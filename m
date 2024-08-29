Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624A3C87FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjofI-0003xZ-77; Thu, 29 Aug 2024 19:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjofF-0003nS-5g
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:53 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjof4-0003AN-Sn
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:52 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d3b595c18dso1633415a91.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724974481; x=1725579281;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVrxnpz839aLLYnBnHuqeTltn+xpAuxyl7GsFPJsO10=;
 b=KVB/XD2kt6m0QP6VtLzKJdt/AKEG0/Mv5GVk+OklQg5d5LcP/F7iBMqxhD77kheGHC
 CYxrJukDgg0CbsEpnx+VkJhm3un6U9iYfRhZnlWRaQdDLqySOC44vTLx1ab/OduPjzWD
 ddWM9SfbpHetyOYU2YpEDB2ycPEUb/awj5NxVPOLicS3QSoK2t5p7R7qVGMA0BkNIe1S
 OByk1FWa4UNfoxQ+bKxLXah1Mh5NXYJPTCUwPWO29B+rjMzCli8XEQOcVW4YOXIqTg0U
 CzUKDMZRxSxrIbWzLgKAtFYVFaad2ZIrvlhult373auGLE1l6rTOODnH93lanjzbMzYn
 Wmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724974481; x=1725579281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVrxnpz839aLLYnBnHuqeTltn+xpAuxyl7GsFPJsO10=;
 b=Q7Vr01l0QxHEY7otMk/VzmDtJb9m1T+gm0ntgPqfXFRuT9wJdgI2cJacsv8yqjmINa
 Rie0C2dgZjhX2TUsCL/dNZgNA55fRGmLT2ss4uaPzHF2LdplJZkJjRCPeEdkuVIqHor+
 JdPbbVN1Y90r4tQNvjZiAqQgxCFfiFHYoM+Ranai8FQ3A96AFw40bn1I5oZMpEzW9dah
 7WpFTzSJf8fO+TYezKu2DcmtNqc8sDH+bDq/uCmrAPWqWtdKbsXvJ16GdTohiQ7jSBbw
 tHK3HC/fVA9rhOFHbQhLxpo4DaCS4po4XPe9ewZT82hQeXxUQsc7Xsa6VkZc2QIRluEJ
 nJDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa8z1Fa2I6ufhp5LZXf4oxGlCZ4kyegxd1gRbXFOvV2pCXmz1H5bOaOGFWOf+25G4xjM8SMWBxrv4h@nongnu.org
X-Gm-Message-State: AOJu0YxywzvtLeITgnYNv7zqeO2ROX/yfhpZKwaApPFMzlJUjB4ZI7ID
 aMvYt8OZ2tV+aLkxLJQKUFo4FtWFnNhovQoN/MZ+3Z1FmyoYeniVdczZcWvb29Q=
X-Google-Smtp-Source: AGHT+IHOzePZe/EpnOnHVaSSN8/mia56d+9nDGEozYX0PGWueybh60OW0A+m7g3zI8UqiFCq0J2Q8w==
X-Received: by 2002:a17:90b:1c03:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2d86b00d063mr717737a91.15.1724974481406; 
 Thu, 29 Aug 2024 16:34:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b13df55sm2331074a91.27.2024.08.29.16.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 16:34:40 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 09/20] target/riscv: Expose zicfilp extension as a cpu
 property
Date: Thu, 29 Aug 2024 16:34:13 -0700
Message-ID: <20240829233425.1005029-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829233425.1005029-1-debug@rivosinc.com>
References: <20240829233425.1005029-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 55754cb374..c9aeffee4e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1481,6 +1481,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
+    MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
-- 
2.44.0


