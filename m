Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA77BCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXN-0005SO-Ti; Tue, 13 Oct 2026 09:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVG-0002uN-3I
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVE-0004o9-OG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPKbLak/HPS10eSu1N7D8T9DAm98SXZfpOrOqgr5fN0=;
 b=Sm96ipqeuWRgq3oIibcNgqY0R19DvOmXBGbmDTCJYHAaMqjm38K3/yBBkOXvkWzj6wfTQD
 OlZ8KdWivCaCD0/pAS0ELpkgAqvvEie2Cf9MtB2AoYARh3W2U421JgBwkzC3bSmbceXT6v
 ad27Kx5OnP+rCDLKikIey/KmF+cMi18=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-vSZn160wO4S4WfcUDu3E1g-1; Tue,
 13 Oct 2026 13:25:05 +0000
X-MC-Unique: vSZn160wO4S4WfcUDu3E1g-1
X-Mimecast-MFC-AGG-ID: vSZn160wO4S4WfcUDu3E1g_1791897904
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 765A8193FA98; Tue, 13 Oct 2026 13:25:04 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5299E180057E; Tue, 13 Oct 2026 13:25:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:25 +0400
Subject: [GIT PULL 28/40] audio/audio-mixeng-be: add upper bounds to audio
 settings validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-28-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fkIa5eoymWixmINmSZQ4EoqBEWtifAtNStqEwZGtKrw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDEsa1Vokta/zSTTGDe+AF0iX/eR0dbqwniL
 b7L0XO67ByJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5Vk8D/4vw0cf/lLwOItz/8stkPVwl+X1sdcCir3/e/HF3wq+EcMtkvas5WVoo/GVCH2xnSzIzJd
 Hy7uNPmQmqmcyK+KcJ5G+2ROyL6LUEoYplLQR0rfMyNmTk6P6Tisv0bNfiDPgiMVzkjtFa0WxGj
 U2uiJdfypJihRo2vU4SrEY34k5xouNRU47MyEIoHZt7SFNeIWq4oFGKb3/1r0HM/QzVYfCdT8fs
 yJmsHwkeCSwGYBG1fG3rb71zUpUUXCmTBVH/BAv4DXdPSTuAxO7IwH8uOODlzqJIBAIzXMDbhRE
 X9rFHstPvOS6hrYoaaKqiKxvT7Djb4RW26R/E8BkXw6Y7S0Wwfulh/vinpUWV63Z6tYqSsTXMHm
 mDLVfELjhK9TOJI85nr5l1MGy5NzcUG3HlgWGEpC5KS2qD4x+KX1TmFKY1oEQDbH1fslazFmZK2
 Iv/mEVUn5SF51kZ3ADXVUCwk7RK6Mgde1qmNNjwjIxXW8HZuZP87QYXN2K4MSe9m7+TnyBgGkHf
 h085q14klnm+f/EVUb7YEEb6PnXrILNearGzZrkGYUF6B4vdOt0g6vWwk1AvR55Oj386oJVbkEN
 sMNFXSyF1hNyPMu23PX04WAVzmuWIWM7gjmvaETgQeECXb3dcn+PzbaK0IQbc9sLRH9Ob5u5twD
 J29Zj9UuMlV0pIw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reported-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-11-ccbef537cbeb@redhat.com>
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
2.56.0.116.g6de20f6092dc


