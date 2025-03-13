Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADD6C35FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 19:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsoGZ-0001vh-Vl; Thu, 13 Mar 2025 15:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tsoGA-0001qg-V9
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:30:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tsoG0-0001f4-Vr
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:30:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso12505005e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741894213; x=1742499013;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OqqMqeTRo1EajqnduezxEFLA+bccYny5XY5wtE1tPV8=;
 b=OAkzl7ul/O8vCJ3nv6Ya+GLhvriGh8AES9KKUZyNICF1VO7kpgor195xpd/nOk/+IH
 OT182dZjiEuyeMwQKa9B1hHeOiy8ryWwVKtLZ0JiKCCVVCcx8RleoQZGK7wAOg86bQMj
 /frFCB/SkgYH6rIfscQMlokXxq45QZXgjz9CyxmveAb2tKiz5vfo8X5iUD0hVhls9CHc
 X3/rmJ4oQ/QtmQAmHGzYlVepqlhfIEI126uom0kmCiuh6QmJBsKp376XyEXsBkRMCGUy
 4456N0b3AZjzYpCpxJLLasZWtqq7Daw1nzxKdVto/ycFTUNWBCEjtMOaco4VJjq8de9W
 uteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741894213; x=1742499013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OqqMqeTRo1EajqnduezxEFLA+bccYny5XY5wtE1tPV8=;
 b=sFmC2r/q5Hbl1/ZKxblkRCPzdqesFOVrhVhSHjh8lVzyaz8/iTkT7bDBw/FO6iac1m
 AbCa3VQfeCcgvy3mKutbAfWvrAm9V48egzhVFvRA57vOOS/7P+Lulu/qZtfeMJB21pGY
 QMS6fMfl8EkcwJDZ/VI++fHn4IxbeVLd8KAnk/FTa4OuZqs5PRvStJuKp5CNO1xwZPOi
 3Walt1iE6a7W2yh93HuBO8ZalrX/7jg11I3n82ufbTftaB5+rzV2PRCXqfz6yO0B5TW7
 u5RDic8h3SPiSqmC544270ElOPv1Yy5bBrtB5Ol603+ArGUyRcoP9TG43n2SicGdV29N
 A/1Q==
X-Gm-Message-State: AOJu0YycORAQ51DEuELvz9yNJrRgZGZmRwL4x+PSmiKscNv5GATmNc6w
 4XpLbXbdb/vG05KEsOu+UWrhls4/iGRE6YM1S2ZIRZZzPUXyEYclgxyV5qineOQTiJQuahMnAhb
 /j97u7zxwBuA=
X-Gm-Gg: ASbGncuMrqZFEin/jYvdvu3DQvxm4GVZ/vjSanAuAKfxuh8k5Re4NZGYRUYZxm7J1JE
 dwg9p68BNVkvTUbYDKo7RSUNnUHfKDmHbZWDEaTqjVM3LoGeMVCAZjtDiGbfvNuJAFMb8oDPPyz
 omGWgSOPyQasFrlhS71Orp16pcHljO+iaAKPr9MzC65gvTGvJQvhtNoMt+9mJ15hadUnUAH7VlH
 0a1X1UH0HVRVmV+trW1Hoand2USEgXKu2UWHJG4AC4XdQ1lyFQeHn3V0KT1EJnvB59qRWcSnTUQ
 AORmT0QJ0kBnim6OXMvmiVUUuoyB8vu6LplnEjkzsuaNKXLVBgbN67sl77bGIxtjh3m3OCSVIhH
 vgONnOnRt03cb676axkg=
X-Google-Smtp-Source: AGHT+IE8H9qSECvH7gw/V0GaNTDa7Otz5TSiqVmJ+ZNLVTQVKKPC88KZWs3EecJAmNJe9jmUPhdJHA==
X-Received: by 2002:adf:a2d4:0:b0:390:f552:d291 with SMTP id
 ffacd0b85a97d-396c1c26592mr648128f8f.22.1741894212827; 
 Thu, 13 Mar 2025 12:30:12 -0700 (PDT)
Received: from llx1.ba.rivosinc.com (lfbn-mar-1-50-94.w86-229.abo.wanadoo.fr.
 [86.229.28.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888152dsm3016421f8f.48.2025.03.13.12.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 12:30:12 -0700 (PDT)
From: =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
Subject: [PATCH v2 0/5] target/riscv: Smepmp fixes to match specification
Date: Thu, 13 Mar 2025 20:30:06 +0100
Message-ID: <20250313193011.720075-1-loic@rivosinc.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=loic@rivosinc.com; helo=mail-wm1-x341.google.com
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

These patches fix Smepmp implementation to make it compliant with the spec.

First patch limits RLB to CSR changes since RLB should not affect privilege
evaluation. Patch 2 extracts some common code into a function (to be used in
patch 3). Patch 3 fixes validation of pmpcfg CSR writes in order to match Smepmp
specification. Patch 4 is a small optimization and last patch is just removing
redundant code.

---
Changes in v2:
- rebased to latest riscv-to-apply.next
- addressed Daniel comments on patch 1

Link to v1:
https://lore.kernel.org/qemu-riscv/20250225160052.39564-1-loic@rivosinc.com/

Loïc Lefort (5):
  target/riscv: pmp: don't allow RLB to bypass rule privileges
  target/riscv: pmp: move Smepmp operation conversion into a function
  target/riscv: pmp: fix checks on writes to pmpcfg in Smepmp MML mode
  target/riscv: pmp: exit csr writes early if value was not changed
  target/riscv: pmp: remove redundant check in pmp_is_locked

 target/riscv/pmp.c | 151 +++++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 68 deletions(-)

-- 
2.47.2


