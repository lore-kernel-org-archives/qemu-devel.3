Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC142C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZjm-0000cS-Fg; Tue, 02 Jul 2024 05:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjk-0000QW-VP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:44 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZji-0007co-5m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:44 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2e72224c395so44440061fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912219; x=1720517019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mik6Y+wbs8Uum7pP9/BoqNxBZgA0hVPmMXZ5DOoxW5k=;
 b=hHUfnrRYcGc9Zk5mCxmVVIQ1PCK3k4xSlqNS+osuDEDQr1fBJDlfUVUZHWJHS8MYN7
 d4AxiIrIM9B/CbfmYN5Oc2QVQswKEl1L+sewf+CxPBzgJG3TVG5SIXuZkIRbN85ARPfl
 RO+pUihxeiM4yVCNbZ76CxQq9xTmOHs7w20FlVC+s/iys4aVnujDIhVFlhzvTakPw+AU
 99VHPdwsFGnptxkMV6ZlSa2dOv18CNUORO6HQd7G/QOcGM9bWiJoWLGpc2d4hEeGPI2X
 4/HySL+ZShDsFT4a3Z+GkVfyzJlO+davYatOOTY3q23fjZPYZGej7MGiPtsH6oBiCsEC
 EvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912219; x=1720517019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mik6Y+wbs8Uum7pP9/BoqNxBZgA0hVPmMXZ5DOoxW5k=;
 b=T+A/ECna3NV6ysq6BVxPhOVAP2x2GXQ9U1DfSKm1xmlnit9bE22sCOqdabsaZTr1pg
 d471Cq5l43BnVSfRM3UwFO4KtYpu0sLCn4EtanX7kixMGwsPZ3ekERUA41q0H0+vQzNt
 vA/htla7Ic6wlSGc80+1tKDQQo884ihJk320daSSS0P//kSnMUBgxrM3KniuMDdd20CA
 gYl64wV/EzPvh+Ha2lUQlyaCDdh9box65i3hEO4Pvr9BMXrzAcXvTm4zpDdxcn8BPecn
 7W9QD2VPIdz9+IimSnYYWEtMGqDVLvLiS+pX07JKfxQ05HZ47vV+lskFZ5MmzBtHUvWZ
 O3SQ==
X-Gm-Message-State: AOJu0Yxr2FATWStyWCWaAHIkha5h//C09bE1Q8bgE2AMyNANYwVcdqMC
 e7IQ17zf/LAfAcb7CAuZFHx1BLH5bm0IVqSKKePJ2LkUtljmJ2PzPQZoQjgg8z/mYVhCoSMTpbG
 K
X-Google-Smtp-Source: AGHT+IGA0SdyiOq4TWFuFW5wRgxrin01ZtZgZyP9VS8gmfsvdjae8lpQX9njjx9Cktrzhr1AwySG2Q==
X-Received: by 2002:a2e:b704:0:b0:2ec:5128:1850 with SMTP id
 38308e7fff4ca-2ee5e35452dmr49945211fa.13.1719912219530; 
 Tue, 02 Jul 2024 02:23:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b061095sm180545945e9.23.2024.07.02.02.23.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:23:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/67] hw/sd/sdcard: Convert PROGRAM_CSD to generic_write_byte
 (CMD27)
Date: Tue,  2 Jul 2024 11:20:11 +0200
Message-ID: <20240702092051.45754-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-34-philmd@linaro.org>
---
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0aead3c866..95ba4d0755 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1510,17 +1510,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     case 27:  /* CMD27:  PROGRAM_CSD */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
+        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->csd));
 
     /* Write protection (Class 6) */
     case 28:  /* CMD28:  SET_WRITE_PROT */
@@ -2086,8 +2076,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 27:  /* CMD27:  PROGRAM_CSD */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sizeof(sd->csd)) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->csd); i ++)
-- 
2.41.0


