Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93882E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEYF-00052z-Hr; Fri, 10 Jan 2025 07:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXa-0004G7-Qo
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:55:07 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tWEXY-00010p-MP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:55:06 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso21736905e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736513702; x=1737118502;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dM7VO3EPBoxLDcTRKpkxLG7YDBXqyjRr+7+nUF8FOJ8=;
 b=t8L2Ckg+WuItCYrM/a3eqmMXmlAE9wINuth+bldxxc2JBXW/bvuV0BrJmlitZG05Iq
 ac2vjU7GbJwv3VpuWdLyKKPkfEOCapE/Q+ReB55Y7dlvoPmmMVijaz3Am85tp9v6reY9
 NiTBQ5C/mRrPuY+9qWCBA/j/3t9qgcbsWYWvW/HR2I6mfDApDsaRcMaBycE3nXEWTN6Z
 w6VjeTxmaDdnEpq3FodAyOuOqNvJeSULR/zo0l6rVJBYVlOkoejhpHWLforZu87bi/J+
 vbFKZAX5OEQT+LSiESzHO+m0L9g/PYy3FYquXxwZ2jz1NTdvTsd2SRezz9Y2D7n2LWey
 +csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736513702; x=1737118502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dM7VO3EPBoxLDcTRKpkxLG7YDBXqyjRr+7+nUF8FOJ8=;
 b=ITFBVfGhgo0OIuzxo7rq9dB8WiJjbhn716IS8wLkNf/4iQHWdJf8JgOHt4z9z6om04
 SelO0vmSpFzBcCJqWhJbKwKud90VybJcmfsh1LL+8Yo+a64bnmVVXO8LTEqsVqkgismY
 JjrIa1LJhiCtytMZGqdwbFaG0eup0k/7kugGCGsCxNj/hsbEEejqNHLsC7h9AsaRdm2b
 VPi56NJDFC8q5PFV1B6gq90AQMzNxgu77BNNotxpmiLkxVZ/Oo/sK2HOW2uI4Kk2rLMt
 oRC4ZiuebA2mrpQcdJ0lqNkGvy23TQ1/h2VoWlrnk/ii8RJ0UDdRjM3sFSxaKo8Rpq0s
 LvzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXctqB41P63GHpZFIjgxmaGi2RQJKJfDkM+HzoXpLI64QdnJese5E++KP1SY27fHig5SAUTrpmXTvyO@nongnu.org
X-Gm-Message-State: AOJu0YzsJevb6gh+jLQyBOFq/HELhBFdZnU3IBIyszxEhhyBgSujxMtW
 mU6U5i59nCVYojXXGg5sZ52cuh8keRF93TPSPAZfhUTczsLax670QGGUdTlQXtI=
X-Gm-Gg: ASbGncsLhygNdQM2HcegMGN5eog7Hn7Ceig/k3eBYfsGm9H9apri6+V7acGcz/NiR+I
 Or0IbGkDBZ0IoZVfjud+S7pc4IkZm3eJ7X9QYYjWpiMSuP3LtGmM7hRfpsjJ+5xDoKuIlvQYSW9
 vBNRc6F98hjStRohFTGsQ8V7wu5lHyzpG5FyetE6/YfNMo2Q2B1r2H8FCmEdy39JaNbkbqJDRIO
 B46lJ/dM74augzFwTzES7a4y+fL0asI9qMcISxXXjwUBgTTeNzCuoxLxQ==
X-Google-Smtp-Source: AGHT+IHTEDXaaJ+iQ7n0PjVXn8kuqmxtqK9XlwOXKBXjLgmAKm0we4SJdmR/opMC6e3Mjx4GQ16PSw==
X-Received: by 2002:a05:600c:1c84:b0:434:e9ee:c2d with SMTP id
 5b1f17b1804b1-436e26e2725mr87304965e9.26.1736513701855; 
 Fri, 10 Jan 2025 04:55:01 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1c01sm4548921f8f.97.2025.01.10.04.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 04:55:01 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 9/9] target/riscv: Add Smdbltrp ISA extension enable switch
Date: Fri, 10 Jan 2025 13:54:40 +0100
Message-ID: <20250110125441.3208676-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110125441.3208676-1-cleger@rivosinc.com>
References: <20250110125441.3208676-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32f.google.com
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

Add the switch to enable the Smdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e3ed11b0fd..bddf1ba75e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
+    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
     ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
@@ -1626,6 +1627,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
+    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
-- 
2.47.1


