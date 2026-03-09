Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD818F4180D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzd0c-0006c2-82; Mon, 09 Mar 2026 11:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzczJ-0004wy-Je
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzczG-0000rj-Ni
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:57:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so9380455e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071861; x=1773676661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AuRv8v324tCQUkX/bfQ3Ovg91hb7uk1tmN4rCfz01G8=;
 b=cjPojoAKSdHK3d38fbW2sF5VV9BYbZCObjG8QCJr4nztSN2/qu241NHN+h8eSJvdqg
 ww48v5tiZ5Uu4rgyrOm1kKNGu+M667Qrtt/XqvxG7JDdsvT8WwBxESTYhyxf8OGxeTGQ
 Shcg1ctI1aV+rF2z8EZv5EnNY06aira2xAzs8S/ysBOaZgJsOe6SPtX+KTSkuPX/iOqH
 pmHkJV7IY3MiHeXmzPhwQLgtxOWvO2sWlryw4rsxam4WNDiTHBZnwKI3L+ojkwt/ubL4
 MjH+it4MBrORfckkDClKchT2SpFtgzggLhgIDhPYeKsHJeKv3oi5KI/dmvYSVX9inN66
 WfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071861; x=1773676661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AuRv8v324tCQUkX/bfQ3Ovg91hb7uk1tmN4rCfz01G8=;
 b=apkoeCR3r6aKNvGD+q+7eZ85YAgb9WpzhS4R1BMmTVMtjYcX5m80smi1k2jzu9qAYZ
 ywqTA+wHzfUzrdgJI8MdiFYT6s1BoOaZbZdsvxfzCi9kV3BEU5KgvNNxnSWgKOkKR6KI
 GePw82Dtpo0zIbzt31yr2mgkGheeY2nri681pe5bq69ob7ghzjUv5LA8InTjULNJg5H9
 vBSEOE2l06CjlYNkUHAz6tdmThjBjH5o0Zdm/X/R3/DJ+Sj2EuG1vgxS3dwzhMNVtPpy
 hTdl3Lz32so00XvRCkE9qIe5OSSkHo7wNviKsZ54jo+ZE5K97N/OOUq27olU9CZVu8W6
 lVlQ==
X-Gm-Message-State: AOJu0Yzf/HErMuEqznZKdbXqFBBah1c4Ma9u+tSHrA4iKJJFDGG7XQGG
 OEVq/XUsR4xZR7eClUJqAXjYR6NNovFkwFzuxbLfqUpQnKHZnoaq2XcM54gx6BXDLZot444gsfO
 SIFRD0Mo=
X-Gm-Gg: ATEYQzzKOlm9rTOhmICYOJr4uY48zczFGNWpw/u+VScC3chPAvQN6Ltvj1uob0RF0pa
 ZnmIFcKQJAak/Z8p0lZOH7nvvHJm3tTLV1bgqs1WadjKX36sN+H1g55idmwQhmNQK2jNccsgiTu
 /KefBDGM87VQGU9+cYuNfr7L2A0tHcpA2AN2HQDHKR8z192ahaiASso0uQHU3f1/3F1rnbzswwu
 GDUKuKovt2+2vfD3alRegxfpyrjLq6N2uImFfU5Oh97uFVCXz88TecpdPqToOQShGmcojGJOdbc
 OxHzQ7FIM5ranj6kcygBNwz2nuHiC4k0Ve4CScBFl2/ABC7bRFzRabrA1t+n8CP+4ym9ctFG7WC
 wV/J+Agj7eNnlmtAZZxRUVVg+bpY8ieHI522pLqoXTR4FYbmdQmGNVVi1wtDXPQd3UTTqm5Kc40
 Qdpvs6/A72me/+ySZLnJie4G/zy0MitCzqzMGQ48vR0FNY8+1BxjNSWcMWmw4yLwPFqjILMGp2
X-Received: by 2002:a05:600c:4f55:b0:485:3c66:e230 with SMTP id
 5b1f17b1804b1-4853c66e4eamr55050955e9.29.1773071860592; 
 Mon, 09 Mar 2026 08:57:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aad45fsm802025e9.15.2026.03.09.08.57.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:57:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/49] hw/i3c/dw-i3c: Fix memory leaks in error logging paths
Date: Mon,  9 Mar 2026 16:52:17 +0100
Message-ID: <20260309155219.62400-48-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Cédric Le Goater <clg@redhat.com>

object_get_canonical_path() returns an allocated string that must be
freed by the caller. Use g_autofree variables to ensure that memory is
not leaked.

Resolves: Coverity CID 1645550
Resolves: Coverity CID 1645553
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260309093838.364126-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i3c/dw-i3c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 3d8b95a14c4..e9bdfd6af2a 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -490,8 +490,9 @@ static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uint8_t *data,
     /* I3C devices can NACK if the controller sends an unsupported CCC. */
     ret = i3c_recv(s->bus, data, num_to_read, num_read);
     if (ret) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
         qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed receiving byte\n",
-                      object_get_canonical_path(OBJECT(s)));
+                      path);
         ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
                          DW_I3C_TRANSFER_STATE_HALT);
         ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
@@ -1107,8 +1108,9 @@ static void dw_i3c_resp_queue_push(DWI3C *s, uint8_t err, uint8_t tid,
 static void dw_i3c_push_tx(DWI3C *s, uint32_t val)
 {
     if (fifo32_is_full(&s->tx_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to push to TX FIFO when "
-                      "full\n", object_get_canonical_path(OBJECT(s)));
+                      "full\n", path);
         return;
     }
 
-- 
2.53.0


