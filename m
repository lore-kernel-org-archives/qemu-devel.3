Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257C1C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxOn-0000mB-N6; Tue, 25 Feb 2025 11:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tmxN1-0007Gg-5a
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:19 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tmxMs-0001wO-PT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:01:18 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so38616325e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740499255; x=1741104055;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D0G1BlFEwahcM4AHHFlaoJCV2Tx9e8WvmvlKENfqIqs=;
 b=1pQPqI8MjZMJj9f73A/2n5VqSu3nxCNbnNTHwx1ZCUu3AXU6x3zzLap7PrLKEoraiw
 1qN5mddC5mceLO/CpBUUJqZ0m/ElME3LS/GZxXSww5qjsk2KkoZKiZPRtjB7O80p4DoS
 YUJ81LnfD7GECt42DG9VNgCpoCc7vRcDVXiONesvr2cdBJfnGGVFOQzEjwCLnr3di+eU
 3fj9uAA94KqRH6mte3eHdVCrc8t8VHdjd/c7uYlXuW8ch4HYmjsQPiZJU4aGGAtl+dnm
 EXe0urdWU7FcKhBgYruCDtqj9kE40pX8MVWDhR4XuU4iZX5dIsa3fsG6D+49IOTzaBNR
 5C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740499255; x=1741104055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D0G1BlFEwahcM4AHHFlaoJCV2Tx9e8WvmvlKENfqIqs=;
 b=J/QFTUB5/pIMbPkrd2DF87Mb/wgio+c25bpQ776tZO9iNcGJb03c6CGIHtO8h5xgdT
 3k4iUk4yOEUquqPoABdqlJEdCZ2hz09g/Dovqy52qiEs5okOqzkH8R0ilAGxRNR3CZzt
 rbcc8iBeE0vRCYpm5vRMPv8CbR3KoYqF0ELQHRT25wLRhR+PQRR4PF1LcvGdlfATgetO
 aJbKBzCYnZbUQseciEuifLKisEZLgtxsyF2Qh/OqwpnQPCj/go9UH2ew+szv2CK1CZn0
 PZZpJzz7NoK/TYcxz3JAOeyNEj3+N8PoF1PwevCtWY5ddDWunBhFaMyYruaW/vCpKFNS
 5PFQ==
X-Gm-Message-State: AOJu0Yyx67+sUMiDr/TUiw23qY7QafS/cioPo8yYGfyf4JyaFq9lBoq1
 m94PqVbPTeMDp8QR6h5zkffpeheeM6l3nLYoFiNmlcWj3ieXV2V456tNTWWfI7mTnp1IC+Xz+gL
 yKayzp+Vt
X-Gm-Gg: ASbGncumxmYB6aodyK8fg4DZ3HvMXu6uB6YOXzup18tJjEMOKutwpHYnwMk19tBv49s
 MuFvKiyyA6AO1qwWoojdjhlHuEIb574oVsdGyC7ToREJ9uE2aphPmKG9VqNKBC51b1SwHIvjrdq
 9OsDkVcWgS2liTt0Em0/iexe29+GseLKkYfjYwzWI4oyRmVDZsIFyJ1oVGXfSqkCWX0/b/Zd2b3
 1QkYq2yLmH1OK8KA6baUHCBq1odF0XGs7by9Mwe06ZSp4sZF6GAwCDhRFm03/1wn461N/fktzBa
 8QK8aIdEx3iOCDNdAky1nxDXgGBDTkw8qZHvgyYTBZvNZZq+7Gv+Xkbdf9x6jfErcptE75ii+g=
 =
X-Google-Smtp-Source: AGHT+IH9/nIdXEJG8xS0y2So5FuCfzYmG8qjQ2yNx1oWH8TLHk7/aqf2xNxzTgkojx5IEwL/KxLS4g==
X-Received: by 2002:a05:600c:4ece:b0:439:9274:8203 with SMTP id
 5b1f17b1804b1-439aeae0543mr145133975e9.6.1740499254652; 
 Tue, 25 Feb 2025 08:00:54 -0800 (PST)
Received: from llx1.cad.pilog.net (lfbn-mar-1-50-94.w86-229.abo.wanadoo.fr.
 [86.229.28.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab1546df4sm30530755e9.17.2025.02.25.08.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:00:54 -0800 (PST)
From: =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
Subject: [PATCH 0/5] target/riscv: Smepmp fixes to match specification
Date: Tue, 25 Feb 2025 17:00:47 +0100
Message-ID: <20250225160052.39564-1-loic@rivosinc.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=loic@rivosinc.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

These patches fix Smepmp implementation to make it compliant with the spec.

First patch limits RLB to CSR changes since RLB should not affect privilege
evaluation. Patch 2 extracts some common code into a function (to be used in
patch 3). Patch 3 fixes validation of pmpcfg CSR writes in order to match Smepmp
specification. Patch 4 is a small optimization and last patch is just removing
redundant code.

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


