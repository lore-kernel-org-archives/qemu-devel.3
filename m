Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F21C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 12:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5OgE-0008FY-VL; Thu, 17 Apr 2025 08:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Ofj-00083C-2f
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:48:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u5Ofg-0004U9-Sd
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 08:48:50 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224341bbc1dso7121675ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1744894126; x=1745498926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JFQHOQ6GK0cfTiglAqPV23Wm0Yk/+L6pqWhTMv84grE=;
 b=DCPyO9o7PKmmpa/Vg8QuRxRgTdwS/W50j02ulZEkhS+blw4HO7bxJv8lbuZ8ypcOq3
 lLdxCbGWvfgeD0qmNrNuaQKRc90xntiJQy8Nr0NhjqCG4SJfJD9HCu4g/sbHWVgNNMGy
 nkog0+Dt5/jQ/bPmmJvE+poEbFcXPSqACdnqRPkEYSK3x5W++nxfqy7YruItzjYNAB/j
 CFiBmWd4QoG6w+/nM/fr3gkBaVdLqSGGfPoyfgTOzFt/+HBnhS+vwTnLlnfg+4UiFQLq
 0M0AeX5hOao6OLvmqCLQL/FvYB4iuqJHb7uia6NxIpoCBRDD8gcw02HylfA7HIK6cKpd
 448A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744894126; x=1745498926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JFQHOQ6GK0cfTiglAqPV23Wm0Yk/+L6pqWhTMv84grE=;
 b=QSsB/wogqBW2aUP4IuuXH8lEBn7lrBU9Ggog8qNUjBt4y5f1h9h7dU+2rh4xST+lhq
 C64UkRJbUo8E6Is5gjt+ST5sJQDMdXzFehZBVte1WhLfSeW8NKv6XB+OaCLNZkjT81KS
 9pnJUk+wHsljpfm5ozWcHEE8Vq4JUP/mhSyuE76AryWjjTSXDxOXlaHcijjk9HAnCwia
 MA9GdLv916eCULvQfKun0o7FtLB8/jKInOhtTtSzzyzQvjjius0gqccRbQ+6Fip+gYSN
 rjonML8nhX5GxZeQBLTYHeB5AAlJ+tYS2k7/riqWhyQiHtSWb3hiwwEp73J7fBUUyuwn
 giqA==
X-Gm-Message-State: AOJu0YzrBioc8SuUJ/6w92hFPajWhCWySM721Wy13uSEIpoBhdQRKVOI
 drsRFHZVxMV3AUTJBtUj8i+I2H5d8SIacuRtxv0Iqlc4I4UCSA7B2QHHNjDAgglh4kHbhik7VL/
 k
X-Gm-Gg: ASbGncuqsoUGhG0USKwGPu6aCc+vS+eNJiofLvpBxodl8D2zC/aPrIMB7JP5fOXow+C
 QcX3lAJyrfaw7E9oJiAhQ3H1UhpC8rB7bKhR7v3LtNW9kRtlthttPfv3nhJfH+7cDhxwZvU2AP/
 VFluEGIQ8rwkdzuDLIbqRHBsqr7QW66vG2ShJQwUIMa83xWkpnqhLWLAVB8aGZaMP3+UjVM1yD2
 Sskd6Qbxk+Ys57PxE26EEjtAuloPcHvwGR5j9aDKAktLtLsMcQA3kRj6g7Y224tvrmB9klCukxi
 pit3gjWEJqWIYnit1zZDpjwOhVfwdMp+nN+dphLwSGvYbIbPpNlux9k/dXJGXbaSvHMg
X-Google-Smtp-Source: AGHT+IHJVFvY6XLV1ub2dGOzUlAAszLoOq3qOoSuBQLojZgdt7mZ/vZoR+t5qaGgxJLPltBFr1SyqA==
X-Received: by 2002:a17:902:f688:b0:224:249f:9723 with SMTP id
 d9443c01a7336-22c359853ebmr76532645ad.51.1744894125777; 
 Thu, 17 Apr 2025 05:48:45 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6dbasm32175065ad.239.2025.04.17.05.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 05:48:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, abologna@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/7] target/riscv/kvm: CSR related fixes
Date: Thu, 17 Apr 2025 09:48:32 -0300
Message-ID: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

Hi,

This series contains fixes to address a problem reported by Andrea in
[1]. We're now handling CSRs like regular KVM extensions, i.e. we'll
verify if the CSR is available before attempting to read/write it.

A considerable amount of boilerplate had to be added, but as a reward
we've automated the process to a point where new CSRs can be added by
just adding them in an static array, and everything else is taken care
of.

Patch 6 re-introduces scounteren and senvcfg KVM CSRs, the patch that
we've reverted during the 10.0 cycle. We're ready to deal with older
kernels that don't know about them, so reintroduce it.

Patch 7 is a fix for an issue I've found with scounteren during testing.
It is a kernel issue at heart but QEMU must be able to deal with it due
to older kernels in the wild.



Andrea, if you could take these patches and test it with your setup that
would be terrific.



Patches based on alistair/riscv-to-apply.next.


[1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com/

Daniel Henrique Barboza (7):
  target/riscv/kvm: minor fixes/tweaks
  target/riscv/kvm: turn u32/u64 reg functions in macros
  target/riscv/kvm: turn kvm_riscv_reg_id_ulong() in a macro
  target/riscv/kvm: add kvm_csr_cfgs[]
  target/riscv/kvm: do not read unavailable CSRs
  target/riscv/kvm: add missing KVM CSRs
  target/riscv/kvm: reset 'scounteren' with host val

 target/riscv/cpu.h         |   1 +
 target/riscv/kvm/kvm-cpu.c | 366 +++++++++++++++++++++++++------------
 2 files changed, 247 insertions(+), 120 deletions(-)

-- 
2.49.0


