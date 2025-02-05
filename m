Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E96C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 11:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfdRS-0004QG-0H; Wed, 05 Feb 2025 06:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRM-0004OK-I2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:32 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRK-0003xi-52
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:32 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so65860815e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 03:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738754368; x=1739359168;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGS+kPJk1Sts3OT6jlvRg0wUW3GBgfwYTQ1dwaloTKE=;
 b=whZS2HIuk0NNvAceCsi1vh35fpjRANf+8v+hpokttvF03yLnmAQ3C07xx8yx/1ZqqZ
 iJyo7dojrNOrGCLZ1zNC0/IquATfn6P7KXhHi7n5mICA+2ZuOSDjBQ1wO25Ew+hsXqzr
 h7VPYFU0ByhQZ/rmzXrEGKpE7rDbbxhKWFSKIl5H551GSvCuFLzUlN4VY4289nGQIlI9
 dlV/5ilxwdnA7M+34TaJL7dYLCdqipb3GPgVXCs+LR5YMPR6H7MNhbnCfOKoui4VY3M8
 mTXk/Jj+JWNh2yrbIi67p9V2gJKilzmSmE+wbciml0JfgNYSvZQQRnF2hhNWAheYhB9c
 WJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738754368; x=1739359168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGS+kPJk1Sts3OT6jlvRg0wUW3GBgfwYTQ1dwaloTKE=;
 b=mNOhthhD6KbNETGPw0KyNCn1noz6ZlYCTyendUp48w/rCJu0wxIAmnyyouLdLLun7s
 6xxN9UHU2FjvSswna+Ao5PtEg+fPbnpGr8BmKQPNYL70MqoiZ67bO3NNUuMnhXFkkqE+
 DOo+EUBEXn594JbbRXOYQ6ZcXUeyPxpoIB8jAOAmU9ngl/MGvuKJ8VZGBCfjNcKZFWZv
 nzj7yWeSgi6EXCHimME8XK2n6CGX/mKpmnTzGLT9WuD/AZ5XsWMDI4+kq4WapTV5W8pb
 imyIHxPN3t4ys4v4wU46yUovzFgwBARDWTSrQYIS6bQcI3t4z+JSaS3Z3ZCDWOq8YHRa
 WivQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI9LchNFbBhkTpWeTyfXPceXu99JSlb9bstnKjTHUhwMeMOzLQMcKP2XH6KfIu9MrCQd0EUS2KZDe7@nongnu.org
X-Gm-Message-State: AOJu0YzCLl8qHEddxQavs9YQpDI9/s17BB0au3PnMCeH7BTL2BtJbi4j
 Z/eJsVEYqIJgw6SfZQm+K4GM5FiaIGRwNvvSgL3p/AgVJnO+x5jfMqOo6D9839w=
X-Gm-Gg: ASbGnctb4cq26iiGZfwv3MgFG8MlqS21tc8SnI5VvPECMBi+VNput57LcEBqDQfXz+K
 6M9F8XjQE18SztBFNA8cseNE8ihuJsZJbKU1/mjGLtWtX0/QISLJEFEE6ROal1oMPr9V/+XOJrD
 l5qvYjhFlSOWolexiEr4HC9dM6G8bHkRymjpnWpsAZybpU2RwcjdWUxNi3zQpYwhf1vJFKBD5hj
 tq5yLEu4rPGEgcTUq4GasP+ry6/7HhlYp15wjhzl70JP47ro/jXg2gwTsvO4vNv3s8zp0giJ6kX
 WJzvi6d1o7+PDjT5DriAoDABLrs=
X-Google-Smtp-Source: AGHT+IHwdKoaV1yKVeMYh37lk4+zMRCEXjbfqrAxHthH+3zBtc4auU1Svcg3sNO4Com7qMBsmfTlww==
X-Received: by 2002:a05:600c:1e02:b0:434:fa73:a907 with SMTP id
 5b1f17b1804b1-4390d43d465mr16630465e9.13.1738754368441; 
 Wed, 05 Feb 2025 03:19:28 -0800 (PST)
Received: from localhost.localdomain ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d93382dsm18256575e9.4.2025.02.05.03.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 03:19:28 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com,
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Subject: [PATCH v6 1/7] target/riscv: Remove obsolete sfence.vm instruction
Date: Wed,  5 Feb 2025 11:18:45 +0000
Message-Id: <20250205-b4-ctr_upstream_v6-v6-1-439d8e06c8ef@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
References: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
---
 target/riscv/insn32.decode                     | 1 -
 target/riscv/insn_trans/trans_privileged.c.inc | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 942c434c6e8c0596d686263f5eba064feba28022..a98dab02057648d9dae28eaf9f9ddb00079211e2 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -119,7 +119,6 @@ sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
-sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** NMI ***
 mnret       0111000    00010 00000 000 00000 1110011
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 73f940d406135a9b346d66120321e35cf424ec40..27d5558d63edf10a516c068a69023ad9035414fd 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -147,8 +147,3 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 #endif
     return false;
 }
-
-static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
-{
-    return false;
-}

-- 
2.34.1


