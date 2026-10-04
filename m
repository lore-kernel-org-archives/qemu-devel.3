Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61762CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJOn-0005AS-75; Sun, 04 Oct 2026 06:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOW-0004gd-8w
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOJ-0002uf-UA
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n86AoTS+BLLAH8ZgM1of4MLJiA87rxXiRSiW79x7cjE=;
 b=iRBnUnDwHfgtU7FGK7wnLal1rv2w5lLEB+cj6IDPu4WTjzDEeB8rViitqMX27sDHp9HpJn
 WoKyhDN7FwZWglymiX6egjcpvVh5vtNAiE/jA6bvbP2Q/Rb/FMGrDza4hhifFrSzKvNH8s
 G5rhKuMoi96ePRFUbDO5GOZ/LTFFt8M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-Iqf7YzZ4Ot2OW4Y4novpbw-1; Sun,
 04 Oct 2026 06:24:22 -0400
X-MC-Unique: Iqf7YzZ4Ot2OW4Y4novpbw-1
X-Mimecast-MFC-AGG-ID: Iqf7YzZ4Ot2OW4Y4novpbw_1791109461
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31764180066A; Sun,  4 Oct 2026 10:24:21 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FD311956089; Sun,  4 Oct 2026 10:24:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:26 +0400
Subject: [PATCH 12/63] audio/wavcapture: prevent freq overflow and
 corrupted WAV header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-12-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=838;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BI+UJVs9WtYcutSY/kdUjpYrfwAZpuzBZ5fjGQAVNFs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikinklM0KNfW0Mr3Q2cBvEz+/xmhaUvLRlpE
 ErzNeWIodeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5cR2D/49DaEM+xmMGEOCYbc/k3+nT/V2jP5BXPgJ8xNbT8DXVWq/rnSF3DvO6MU2VjjuR91gsuH
 yNtzCyc9IuZYRCanqGG0WlwLEK//5Sh2HFVGSrNM/HjBKz6sPHmBoPu/vmzWkb3wRuHMwH7Xo5W
 bf3XTtD1E/y52ZsSlOhNWpIx3gC5nqp3D+AkMymtWwbmkmb+0k1B3gHWvdrf0B7N0iBPfhvXM/H
 O6STW7u20uJMX86CfvZj4PowIref5vjTM1okAkARQe2/pTN/TRipaAZxNuKfxdBfU1XE3DSzGDx
 LVsAc4sbEyDXrGKQBVTMqrbqGYZW+e/Hzc71Y769vHwb8XYJkXEdPI/0EiXVcC7KvPTl9gdPsqu
 SuPvkdyylDu/MqbGawI9vLMLCiHPtDsPwsNz7XHVek3AdqbTh8/L1YjWO3+uqUH0Kkl+0aiuR+S
 Gf10xD5akxF/hCsqLW5/OEC3YqO2Wh5h3+GxHMy9LuVABoPVz8ZRX/0+HyH+VHYhMtSPPC7QKeW
 VTuQzzLBH3QH2DuvmFJ+V3fHCyVOUk6vVAOVxOk6r5PWE3EAGSw6d7Ie2rebAcdYYACp3XO77nQ
 TJ2CodRwAPWCP0vnuy6e0aBmxl75LwCNSIRiMq7bIGRFq1TGAA68YeKNVIGlKTW3DZLe/1TzM6u
 o2wimw8UDDfNjdA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reject freq <= 0 in wav_start_capture() early, before it is used to
compute the WAV header fields.

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/wavcapture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 2dac94617104..67bac380ac7d 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -131,6 +131,12 @@ int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
         return -1;
     }
 
+    if (freq <= 0 || freq > 384000) {
+        error_report("invalid frequency %d, must be between 1 and 384000",
+                     freq);
+        return -1;
+    }
+
     stereo = nchannels == 2;
     bits16 = bits == 16;
 

-- 
2.56.0.rc0.29.g47ce80527c56


