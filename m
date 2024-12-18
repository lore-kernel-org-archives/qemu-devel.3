Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CECE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsQG-0007Ys-LR; Wed, 18 Dec 2024 06:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQE-0007YE-27
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:40:58 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNsQC-0007v8-GU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:40:57 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-801c8164ef9so508327a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734522055; x=1735126855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNTvqcQvDiPTLItRbovaMEM3ypoPCWocSxqCoBEoP38=;
 b=eE77p4mFQBh6oLZl6wSAIyo9hXwmkqV3jf1+R+u3qn96tfl3ETGWvnlo8wOoIBF7/Q
 8C/MdqJ9ZHkUUOVmTtthfVKjKLeS8uFrPWRL/lPep4AE1/OnNY+9oFFFc6uRLaX+Wn6Z
 hz98Z3THQqzbWqG34TQwmU9IkkwhWl0J0s1HNG4cdvhcbGe99hw0QnnbiV4wAIyDSi3a
 TJCsGfmw0Uj7xK+kBSiQJQEF+/bTa2+zBkooDLdLT/Mx8aJpguggbNp0oa/7ilp+HYUb
 9AFgvF14aI/TYihlXjZgiAV6KqsXR6m1QPtJVfJ1V3Sz16MAaDbRT2xFZBKvw8aAIhbv
 6plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734522055; x=1735126855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNTvqcQvDiPTLItRbovaMEM3ypoPCWocSxqCoBEoP38=;
 b=VBTanyI4RfHC6qKECa7qRe9PXxCvnSg7WvNhp1xqWgJtcSTtQ0aCxrVpTK3RqU1rMa
 kFIO3E40N9hNZrE8ce0tWeAeVdYfoZwk1c10rOSs1Ln4UYHpX+N1eZuL10t88hWrmjzF
 InGGivSzLZRkQiykbOuALvNPlt9t3bb1P+EJdZXI/ZYhbJya2xRwA5W3gBvFHZd4T22U
 jICxBKB83tMmqCbd/zNK8AMdX184wG90UpnQRsxRfFH6Rqw1A6CiyPy/SV7S2IGvpEJT
 WlsFDEy9NR4VCxygT5GkGkUgt+X4Dd5axwomPAdrEjGlVnlr81errg72URrArcAzIEFb
 daBw==
X-Gm-Message-State: AOJu0YyMKpUKxHQgXBTj8wjfp71gJWLxz0kjD3+i71FKYU0q0x94nA7D
 a8hS0sOXZfdBOJsCDPNuhPK6vUh+Il+On3e1VG4eQvh2xiFu0B2Ttkpm5fKLbXinJbjwPULVBv+
 FtHo=
X-Gm-Gg: ASbGncu1VdtnBNcFhNv/bTmn5HkSMIz+ncEscLKT+oB1ibl3P7ibaYiYn1wB8c7YXqR
 vi0XGhK4u/ZtfqXWFjmViDsZS6iQsJbfuH7BI0o/l+iC1tz4+X5w4M+CZCDwb86VomJhv8VhtQ/
 5e25lzBY4au/Mj4+e8TBrzZQpUsYN8olk+B8E9vyxXxmrDmxuJ/UPVWvwMVNfFZvtEZNJZsfCXN
 ZtFPme6axyQdUwXJzHTVT3mlzHow+jgVm6V276m57Srf+H6NBobmX4X8jQf1d1gZ1j5YOtU2WMy
 oA==
X-Google-Smtp-Source: AGHT+IHGvEpwznqrZEgLJCBktXBDSR5v/dhgWI+rrZnOQnWj0j8a3qcdFM4COnZInDN+b5ofxGHpSg==
X-Received: by 2002:a17:90b:33cd:b0:2ee:463d:8e8d with SMTP id
 98e67ed59e1d1-2f2d8860fcbmr10741403a91.14.1734522054828; 
 Wed, 18 Dec 2024 03:40:54 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:bcc0:51cf:9cf:d2f2:d49e:7bd9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcb447sm74462285ad.68.2024.12.18.03.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 03:40:54 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 4/9] target/riscv: add shvstvala
Date: Wed, 18 Dec 2024 08:40:21 -0300
Message-ID: <20241218114026.1652352-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
References: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x535.google.com
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

shvstvala is defined in RVA22 as:

"vstval must be written in all cases described above for stval."

By "cases describe above" the doc refer to the description of sstvala:

"stval must be written with the faulting virtual address for load,
store, and instruction page-fault, access-fault, and misaligned
exceptions, and for breakpoint exceptions other than those caused by
execution of the EBREAK or C.EBREAK instructions. For
virtual-instruction and illegal-instruction exceptions, stval must be
written with the faulting instruction."

We already have sstvala, and our vstval follows the same rules as stval,
so we can claim to support shvstvala too.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 346 -> 356 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7091eb683e..f4997f488e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 460808d017baef93ccdd8fd8d1d4722edefd3b86..15b82b5bb1cf24cf501e74cb82682742e0041ea6 100644
GIT binary patch
delta 48
zcmcb`^n{5k$iq1#g^_`Q@%ltA16C$RMuwjg?YDDelogkhCFUef{1V4u#mK<m!pOh?
E09kzvYXATM

delta 39
vcmaFDbc=~A$iq1#ijjeV(RCu10qYM2Muztj?YB>2jNvd~WMHsjWMBXQ)M*Jp

-- 
2.47.1


