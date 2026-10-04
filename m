Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20966CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJOY-0004dN-LX; Sun, 04 Oct 2026 06:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOI-0004Ww-Pw
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOH-0002uL-F8
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITAbWn3FX0hZRtmoULjpVP0Nk9gZpGtRFkfmPFSDUYw=;
 b=DOkDJ8A7JSqHly9MJqByyxxtN27CYycn99vcd8iFk2UKbQ+va76lvqpsPiRLzsm3xPo8vV
 K4zbfd1zYAWikWWd61sufAdN6t6Th8MbJSvogRnjVHVitNHKLFfig7cbY11GtBEwVkfzdc
 rQutRhgNhYHNuZj3SP+Nx0YTvFyIdRs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-IZb4L1EjOXe3sMKnpZqFFQ-1; Sun,
 04 Oct 2026 06:24:18 -0400
X-MC-Unique: IZb4L1EjOXe3sMKnpZqFFQ-1
X-Mimecast-MFC-AGG-ID: IZb4L1EjOXe3sMKnpZqFFQ_1791109457
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B78F1955E88; Sun,  4 Oct 2026 10:24:17 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83D7230000E5; Sun,  4 Oct 2026 10:24:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:25 +0400
Subject: [PATCH 11/63] audio/audio-mixeng-be: add upper bounds to audio
 settings validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-11-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FezRPSCUIdB5uWxc/ky4n3WTLX67Ff60WIjy5cNgQVU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikhN9Zc0oVr2YfnEHW4l9HZDILANw8ouqaO0
 52mMaFU/oqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIQAKCRDa6OEJdZac
 5R6ID/4oggglmEGAoHuCAYZ3DQW2WkJmIrs/qEitcWuwUA2i329ai0FbOjtPGPz2obd+xBUDn0v
 +7JhnkoihGY6BhEqPXV2UA4qjLvC3fi9pwMmndpWj5lOyI3/4coSeivu/e24GLdxSB4aRnbnN9W
 L72Mg5M3ieJTL8HWnrSVmc2ENKk7Vyp91ieTAUmn07cHkwlMGkK83Fvo5bjAinguqsTj88tVh9Y
 oK47SK1LuWMLVrQcKvahQq5j6kOMokfeyI4W85y+E/5pP7l9KCaLq9Ot3G95wxnnDhAlCrvG6B5
 1UqehvVSEqbFaIm/spf2FOiCvo4PogzNx10OZhdKwdrK+p87bBg9ScP84yAk1GnttQShW46bf3e
 Ow9dsdAxnpL8gxhcWamosPCsEDT2l3U5eddt7EPOyoA2dgNRmK/lN/v26EoqS+JsZecj8dTN0hf
 g23auvQCVskkIb4WEOPAe36p3JXc/ocbefbU2AACcu+6YM3BqaeGu6LVgcLXvpj/DfUiPBLzPU5
 1YYVmSQdJx2EJPqq43XqyvO+rPNFWgWDCPKGPSrw27aDf/zm5vk6ofcxhw6F70Fau5A0XeErzPZ
 ULk55KFQiwip0YXnI1k9GjjOuiXMlNGm69TWxOhfUNCf235ileEWzpAt3iCeQgmVrP1CTjhqf6O
 4PpQTO+PRRpKtKQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reject channel counts above 16 and sample rates above 384 kHz in
audio_validate_settings(). Without upper bounds, extreme values can
cause excessive memory allocation or arithmetic overflow downstream.

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio-mixeng-be.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index f7d73d85608c..f6fd5014e0e0 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -78,7 +78,7 @@ static int audio_validate_settings (const struct audsettings *as)
 {
     int invalid;
 
-    invalid = as->nchannels < 1;
+    invalid = as->nchannels < 1 || as->nchannels > 16;
 
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
@@ -94,7 +94,7 @@ static int audio_validate_settings (const struct audsettings *as)
         break;
     }
 
-    invalid |= as->freq <= 0;
+    invalid |= as->freq <= 0 || as->freq > 384000;
     return invalid ? -1 : 0;
 }
 

-- 
2.56.0.rc0.29.g47ce80527c56


