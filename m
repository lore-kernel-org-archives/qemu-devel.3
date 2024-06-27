Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D76C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrw3-0002GF-2y; Thu, 27 Jun 2024 12:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrw0-000249-QI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:25:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrvx-0002QO-9n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:25:20 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-362b32fbb3bso5188079f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505515; x=1720110315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpSfmrc8id/iTbpDVauIfBux1xBlvB+2LTLQjc6fyJc=;
 b=hnptKduCGVkOFV7ctEM01LltMiXKWxcvAjpmSrHIp0YL8RvUqacvG36iXWUhjDt7hL
 fjTUl515muzKhBSXT02SVw3kkl5jJ/MOgf8behtfF68lGC9x3230Ai/lMXsvzo57oKrs
 3wZTUqf6MjHSGSK8y8ev5e2wRcNJWDujQzi1LlnKqDxZt/uc+By8hlR4sJQqgqWI+aCJ
 /0J4hZgGv6Ku4SsMktdpNXXX0kD3cF007+lYbjuMZbIdwdmgoJiV9NAFl21Med7UDL+3
 ap98wbrVWB5tkXv/rAyqCZDcSECO1XAZO0hJ4GO9ydNdbFlk+Z4d6mvHuXkv5h50CUlX
 XV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505515; x=1720110315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpSfmrc8id/iTbpDVauIfBux1xBlvB+2LTLQjc6fyJc=;
 b=tlX5ZOmgadqBa9D8U71yHYWsRsUJ09mRbSfZEpCUycOhd/ntsTruNCCzcSd/zKWAbE
 Gl5EIiBSQ6aAv1+zn5l5kQ57QYb9fbKvKWj17baxG5qgS+dIb9FPrIB8LP4Uccy81h6L
 WzP3A38MS9qJmUl9LRQPopyOX11RcT4uzNWytTT/aXicT7bxQpVD5UHJobjWfkE9qNc5
 /pzLVfnnX23/4lA2B3Ie10RqzaQmPAPssI4kWVNAdXxKc4Agqj842kfsqhBdTEc0BCtf
 6bWdi9ITXqXQuD1C91s3LitYawPbBHpYnhhZayq5d9y676htdYNB5KMR5SQAb8rZFm/Q
 nGQQ==
X-Gm-Message-State: AOJu0YyOwDKhlXChh8svnEcyE7GUccgGKu125WYzbC6fudgEMI8oH7R/
 vyl9dIc9RHZrpaPpfvesnAKsA1aOvhvWVZXs6L7JzI33Xra+1duBaEOiiv+CB8pFX4lV36UEP8B
 3WDA=
X-Google-Smtp-Source: AGHT+IEufYGixwmrzetiSCRO2ZnEER8vmdF99uhUNfGDOXvdqqef2rU+F+eoIQIZan32wf2DA5bG4Q==
X-Received: by 2002:adf:f50d:0:b0:366:e7aa:7fa5 with SMTP id
 ffacd0b85a97d-366e7aa803amr10705832f8f.1.1719505514940; 
 Thu, 27 Jun 2024 09:25:14 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36743699aecsm2343316f8f.87.2024.06.27.09.25.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:25:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 12/17] hw/sd/sdcard: Restrict SWITCH_FUNCTION to
 sd_transfer_state (CMD6)
Date: Thu, 27 Jun 2024 18:22:27 +0200
Message-ID: <20240627162232.80428-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

SWITCH_FUNCTION is only allowed in TRANSFER state
(See 4.8 "Card State Transition Table).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7533a78cf6..8f441e418c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1205,6 +1205,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         if (sd->mode != sd_data_transfer_mode) {
             return sd_invalid_mode_for_cmd(sd, req);
         }
+        if (sd->state != sd_transfer_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
+
         sd_function_switch(sd, req.arg);
         sd->state = sd_sendingdata_state;
         sd->data_start = 0;
-- 
2.41.0


