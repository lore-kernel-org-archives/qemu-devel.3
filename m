Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D5DFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwtg-0008V5-Mq; Wed, 29 Apr 2026 00:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtC-0007Uc-QE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtA-0000sg-Gw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b299b3c739so56411445ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438267; x=1778043067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7NijtvIiB2ZasvjtDivO4iYHDUMYwjPUlmz4qY1Tio=;
 b=d7DQcC4DQH7/fulK3qAeNN9hbF0n3nXUOOQOJ1RXM/4/Q8RzvzErpcQtjzLqReyGdq
 Yl1D1RpZpRMmr5lq7isjjiQPFZIf8Dz0dvJPnYWbLfrGdi+4CaIH91B1VmZMZKgXA6xC
 0ZS41MW5QyjTuwiC6d08fD7WzQZ5qFJVRpGLTiXarnPfVKi2NZ0X3VwD2mrbrCNz8Dyc
 AGf+uITAG5bmeSK7xBkRMgy4qLkaBsAM3vlYEVLEVdz7SLyE8hpAuM/YnuY/J3bQFTEK
 wcF8o/ZVCyOXK6HA+w0Ob9ca88vkIxuy3ZBVMW65tvG60UgV2P5It8SiBG3wnfKTsqpS
 v6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438267; x=1778043067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P7NijtvIiB2ZasvjtDivO4iYHDUMYwjPUlmz4qY1Tio=;
 b=BtuFyzYif6kwNHZ0xpngtcGpYaIPAFMwm74ihGel0qdDWSgOgXLxiKnItUdCKMdRb1
 4fSTDVK+iRMGuD9xakQs/HR0cAxoPDxUNKfTeVx/JvgzjWL4WbCx02+hSF1+u3nQFjY+
 Y63VSlBfBoIQIMAkLL18ClOQNxqp+8QueWKZZtZ+jowAhygRzBPfUMWWtfFLI31KGMHy
 paxFDyADiKqwFDP1rKnR37rWT3RNXhQbvO9Jb1vveiOTtJ6uvW6SiuCOMy4gjG9AcHVX
 UU8gESklYHX3R5JI4DBYOhGh86FDnrN8MRiAZ/Pl1APF8Liq4ugKTfJFPSEENhSUsp/1
 vsEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8w6cD68/2mRoqZq/6OeFTyF7qPcT6gSVYrGvRfGLzx75FadXNAEiJDWsRxt641FPQAGtRiD4vQS/4R@nongnu.org
X-Gm-Message-State: AOJu0YwEf02/9pZTSRqZzavPaYgfB7TO8CqbIMnJ8/aJx4oyVF68gP0x
 qCRj/Um0yaEviR4BR3CyD2aqDXS3V7NP7/k9pC+XWV5Uj5GDezHx/k0P
X-Gm-Gg: AeBDietcRWr3a9YbL3uJc7g8nybNTLRJwwm6+YUPS0EEf0xiYvbo/fT1xza7oNHAtdR
 52Vz+BjXaK9jwll8sMSA3kqYr3LeOzYOOZA+sCec/lHDxNh1DVLIC8MF4YUc8RPrO7cFx5EXQpU
 t+VJDxm6K6f0dOnjCD9L3lcQCXHwxKnNQah+OAqviZhbOiod8TteQxan+lEQaEpFDpwZVo/gVYj
 FeYWjV0JEfuH32ofH0UMmAkv4QW2VBOcejZsmrV8h4qfwgD1+zoapsbf/uEUdsySIRDVYWbtYDT
 gIOUwLv43C27PQZ0ngtsSKDNUB4dUzhorG8Au9r9Qx4fog6OdlifyO8XkM2pQLsqCxTml3VTEjs
 WwHmpT+KVS0w15oCsHcA37Qzw74fvpyYurTVh+XefGa89TUGuMyGIxfE0A+LfZX7CfwxyQmqk+z
 ptDBrQAIWs0xe/FXKzAN4S3P7Zp7xwFXMOjfN6XYb9XeRFq58+9Bw4
X-Received: by 2002:a17:902:c2cf:b0:2b0:af2f:b27a with SMTP id
 d9443c01a7336-2b97c40059dmr41202745ad.11.1777438266921; 
 Tue, 28 Apr 2026 21:51:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 35/51] target/riscv: Expose Zvfbfa extension as a cpu property
Date: Wed, 29 Apr 2026 14:47:36 +1000
Message-ID: <20260429044752.4176397-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260402125234.1371897-10-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bbab96385b..38286b6b40 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1266,6 +1266,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
     MULTI_EXT_CFG_BOOL("zve64x", ext_zve64x, false),
+    MULTI_EXT_CFG_BOOL("zvfbfa", ext_zvfbfa, false),
     MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
     MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
     MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
-- 
2.53.0


