Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EEACA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJPA-0006hC-3S; Sun, 04 Oct 2026 06:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJP5-0006Ka-40
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJP2-00034G-Pu
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gN+Fp46fqMak0BTpk5ZNcTDYMzd6pz4uW1CXa1nPdHU=;
 b=Ifs47sBx/cKQ/da/vLLbKX5vDdOQKTBHErsCzcYUhA1J+cqv5EILdbQuWl9dVbb4x0wEVH
 rvUQKSdVcOAzeTN7ll+QdbjpIHPAcLAeVdh0ExEDVTz2L40nPYzUIGXr7MXkCPQhh2TO9a
 qjxSaV8UvWGWAudvdq0TWh3HgU9WdAc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-2nTdq_syOLyPbGydSF3q2w-1; Sun,
 04 Oct 2026 06:25:04 -0400
X-MC-Unique: 2nTdq_syOLyPbGydSF3q2w-1
X-Mimecast-MFC-AGG-ID: 2nTdq_syOLyPbGydSF3q2w_1791109503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEB4B1955F0D; Sun,  4 Oct 2026 10:25:03 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BF49180036E; Sun,  4 Oct 2026 10:25:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:38 +0400
Subject: [PATCH 24/63] hw/audio/gusemu_mixer: fix integer overflow in
 volume ramping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-24-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Lw1DF4HbZUr6EsZn1FFfC7SYrdHwEG9nKp623a78vlY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikigJW+jGoY5+NS0trCeCe88jnBYyhRN1E/V
 +6DZikq81yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5X4fEACk8Hvtbwa2cUsfhZflvrfsq3cOaXgu0lOZR2Xl2RJ85GVlWJ9I2FmmUz1Yq16wKVzgJqB
 aRRx2kJxsKE7LIXVYRWG8hvKOknJyPaFU4HHjnDgRieh+QoWkUZSTSn7N9jwPQYWkVbnTdutAY/
 h9Z2i1TKFQNCdRN40jqiZj7py1BuQjn9tveajwohH76YvZlI3Cduz9sy43PUfWAZ4jUzqZs6JEq
 bUr+vPEeCGx4TDN2TQ4ZDADZjAfAn4CGZGpFLqsIbQYINgn75z7WMPUh8DgGHhI/XstUl598tMy
 YnbxCz4tyL1C6zRkHeOArXPlrg1hSlNbGP4TY0Nh7Vi0sxkYlIVP94ApWu00hXiXv76INAKY390
 hLlQ5j59tDM2eoxfo+T26E5OAkWlf6vFvTEXyUEbb7tErmk1aJeHdf+NaeY3MpzfKR7D69Vm+Le
 kfmnY5P5Buvvjpd4cvMDFVRni4jd1tcNpk3kOUVfIRvEklrNrQDnolX6YmgagKpW0cOQlt9QLtW
 UzabEI1UTPoYXxeEnT58zjH4JSJiYKwH2hu8BgJtFtZ8Yau5ujJ2mhapPiJ3UbCRmqj1x4YBn3r
 1cBHv7Z3GjatEv97t8oh4HzK2LHcCKLRm3CFvdkSL+NDeDQtg0jdJJPNDO4NIuNaRozmyRMWBfj
 hFB+BiT7iJqTcvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Volume32, StartVol32, and EndVol32 were unsigned int, but
VolumeIncrement32 can be negative (reverse ramping), so
Volume32 += VolumeIncrement32 wraps around instead of going
negative. This breaks the boundary comparison and produces
incorrect volume.

Change them to signed int and add a CLAMP to keep Volume32
within the valid range [0, 0x1fe000].

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/gusemu_mixer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/audio/gusemu_mixer.c b/hw/audio/gusemu_mixer.c
index 56300de77e44..341995cfd19e 100644
--- a/hw/audio/gusemu_mixer.c
+++ b/hw/audio/gusemu_mixer.c
@@ -68,9 +68,10 @@ void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int
 
             int             PanningPos = (GUSvoice(wVSRPanning) >> 8) & 0xf;
 
-            unsigned int    Volume32   = 32 * GUSvoice(wVSRCurrVol); /* 32 times larger than original gus for maintaining precision while ramping */
-            unsigned int    StartVol32 = (GUSvoice(wVSRVolRampStartVol) & 0xff00) * 32;
-            unsigned int    EndVol32   = (GUSvoice(wVSRVolRampEndVol)   & 0xff00) * 32;
+            /* 32x original GUS precision for ramping */
+            int Volume32 = 32 * GUSvoice(wVSRCurrVol);
+            int StartVol32 = (GUSvoice(wVSRVolRampStartVol) & 0xff00) * 32;
+            int EndVol32 = (GUSvoice(wVSRVolRampEndVol) & 0xff00) * 32;
             int             VolumeIncrement32 = (32 * 16 * (GUSvoice(wVSRVolRampRate) & 0x3f00) >> 8) >> ((((GUSvoice(wVSRVolRampRate) & 0xc000) >> 8) >> 6) * 3); /* including 1/8/64/512 volume speed divisor */
             VolumeIncrement32 = (((VolumeIncrement32 * 44100 / 2) / playback_freq) * 14) / ((GUSregb(NumVoices) & 31) + 1); /* adjust ramping speed to playback speed */
 
@@ -82,6 +83,7 @@ void gus_mixvoices(GUSEmuState * state, unsigned int playback_freq, unsigned int
             for (sample = 0; sample < numsamples; sample++)
             {
                 int             sample1, sample2, Volume;
+                Volume32 = CLAMP(Volume32, 0, 0x1fe000);
                 if (GUSvoice(wVSRControl) & 0x400)      /* 16bit */
                 {
                     int offset = ((CurrPos >> 9) & 0xc0000) + (((CurrPos >> 9) & 0x1ffff) << 1);

-- 
2.56.0.rc0.29.g47ce80527c56


