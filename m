Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE5DC83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdTI-0000pB-3J; Fri, 04 Jul 2025 06:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTE-0000WX-JX
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdTC-0006z9-E8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso2563455e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624196; x=1752228996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mZ0RE64UQypZytSx4Qr4+gDSoIvyEELE2vq85gWcMKU=;
 b=CzaKAaYpaAuKyWwUgIgQfjh6zN2VTOVt2bBLXJT9NGbCCH5yhQ91sGzFIl1wnyeB3Z
 zcfv/CqCyezVsRnZFA3mKFHHfc314+5rZ1qOUuXL/I7XKDunEo2NCnMzg2dHz4TtclsS
 HlxkqT0YkrkAi0JwCM0iS4ocNT+X4oGaRjase5auIU1pvZvkb+ghzJJhyCpE6IxhRDfk
 iN9X/2MJTiBu7cGla09614ejnkHxZXTZTYzyl3u5IWj5vYyo+mbevZC4Qxl29co3+j4Y
 IU+kKjhzusBS+2F9QqlWAzENsYTGCn+kPVvOYUC7zu6JfUhJ6FNWSgoEddQc8ZTHKw3G
 E8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624196; x=1752228996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZ0RE64UQypZytSx4Qr4+gDSoIvyEELE2vq85gWcMKU=;
 b=INRqU3qDPuDPdJ4qt90avKSADrppIzPygvu1Xt8vQWm5j9oGzgSdep14QgFytiIYYf
 OVckQdmgprTviwKEdIOcQ4FpSDCSuqBpm3jzpnrhpx+yOO9psKTwHaDcFwEdB5s2jEGC
 RlTOJqgEeq6aFvMkq9+Rw9uW8Y04nqh/IV6NPZnibJ1k2EUVVChumZadvmb1qRBYbEJ0
 9jLUfyurK67SalM03qvFLRy3gegYAxkqOGvhRc/iXAWQjvRiwoLatgS6sDd8mwYZwJic
 c471/75sSOFTEUUvfZHhvMshgPXhaevZvGwOCbIdlnpTU8qBf8vGIpQBeVQ0ysjD86fs
 DPbA==
X-Gm-Message-State: AOJu0YyE+gkVFqNVtwYMvl8apnoL3/MxXQiGX1US5OX0c6psr+I4DoIO
 ykqsMtY90EPMWKTBfqccN5lXgHdCzmF7YgqpalA/rlVERAFIqu/yL3ZNrzl2p86V6G9NzJ8py1F
 wT6GM3oU=
X-Gm-Gg: ASbGncv5qYHUiEvAseOb4tVF7FXc8s3CABh97D2gU2oyrq2sJ1E8wXArZ2dw9+lucjM
 heHiIofmXTORVfFgMnHRa6CUAnIK3Ez+z4MQlSj3k+5Vvu+FFVAIiWw8MOpue/id05cFalnxA8x
 /SN6RkXC6eK4n28UtRYdjmDEsybn5lTWXmen1Gq2PTVCNkJAY26/T1PutZyyAxxXegBQMI+I4vd
 ycQNVUcoyxpRqukep/1QFOLDjABY2+7EZ8h4Dp8nIJLX0d6DHO2SQSJsrimThArNE++kWj+0CKr
 DBQT6Sae0IlPLlZUyC0YzVcTrUV/TNv6AEvca39QNTj7q7lwBxLpOsTbKO/XVOrcW/hrDN12yVm
 +7CgNleoEcJ00apvIl782jqiaq1VpfzLgptVHx9M7axi4QpE=
X-Google-Smtp-Source: AGHT+IGmBL0pugXVIqb5M1kYB6ZZ7i9D/80cByKyUdUcVChXuhsltbKTOe2zoCg8wJ1RgKAgutm03g==
X-Received: by 2002:a05:600c:8b6c:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-454b3183873mr17616325e9.27.1751624195821; 
 Fri, 04 Jul 2025 03:16:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d022asm2085121f8f.22.2025.07.04.03.16.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/31] accel/kvm: Directly pass KVMState argument to
 do_kvm_create_vm()
Date: Fri,  4 Jul 2025 12:14:27 +0200
Message-ID: <20250704101433.8813-27-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250703173248.44995-35-philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 72fba12d9fa..007f82a50de 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2470,13 +2470,10 @@ uint32_t kvm_dirty_ring_size(void)
     return kvm_state->kvm_dirty_ring_size;
 }
 
-static int do_kvm_create_vm(MachineState *ms, int type)
+static int do_kvm_create_vm(KVMState *s, int type)
 {
-    KVMState *s;
     int ret;
 
-    s = KVM_STATE(ms->accelerator);
-
     do {
         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
     } while (ret == -EINTR);
@@ -2646,7 +2643,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
         goto err;
     }
 
-    ret = do_kvm_create_vm(ms, type);
+    ret = do_kvm_create_vm(s, type);
     if (ret < 0) {
         goto err;
     }
-- 
2.49.0


