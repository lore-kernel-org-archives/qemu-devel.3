Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FF0CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7ED-00021j-Qo; Mon, 15 Jun 2026 09:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1wZ7EC-00021a-Hf
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:19:48 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1wZ7E8-0003R5-IY
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 09:19:48 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2bf1cda2b17so23872235ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1781529582; x=1782134382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ucx3uLkg3ssgpzA1hnSf5+DtlQk6YxcnZlxyY7JjFMU=;
 b=lM57gYbW2QoCfnYQX34hUBxDgODmogpyoH4FXxrdxn1znbpXxeUBc6USej6luPcrGC
 LKCS+Cp1P+yuEftHfUNe+Jxwdltr6sM+7k2EUtdLrDai5oh+1Repefc+h09cRMug+D7p
 g1k8LT/gea0P5CBGNZuDF8/kOYvUZb4Z0YFSuMe/5WI2LsUaOm7YTqm+SEbjMgJJQOI2
 puDbaVSFwVg/eprnYfHvAl815s/+Cr6fUHNSEVxPXU5TwfgmbURGzylSHplIcIn7YQFk
 ifEQMSROsHU8mUgCLUwiCuZS3kAvopv9ZrQt71/IMcTstd5HeVTg/5STff1EiKgPtorX
 P6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781529582; x=1782134382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ucx3uLkg3ssgpzA1hnSf5+DtlQk6YxcnZlxyY7JjFMU=;
 b=B5fu7jfPcP5ycCjOuI3bd/jWWJ1B/IqRZkr/Mqa7HpzhwVgxWIEedIUQvVnl+JpsBh
 GGwkpTiT8LTRlBXal6IkzW8pVrFFTNdYGyKXvvzbGfl3/dEHSBfMK7GoqhmNGlg8sTrL
 OJEsCIGE0xhVWgxDbGX0WzrOEtU7p0rzESJ2g3hqNDJD0hbPLCQqzdQp2s3dDVjQshEE
 LMHiwbkA87i59R8cgXm9x7SVdTqWgJzMDsGw69Mue5aA7ym1cKVhkHAfllkmFcl8vIk7
 ya9Zk1U9l9YEIe42pB7uevNu60XUrbv+pjKZSRYb73VN2q4idq+8kPLJPtUfSgBclxtc
 CH/w==
X-Gm-Message-State: AOJu0Yx3fghQfUuL204koOZ0Uu0tCinGYmh9zrzs1xtGKV6Gbb1OWYDq
 yrHzbPdgA7rE3u7v/+SEHNQbbalNvjdBorvwMB3l3vyqpV5sppr1/LyHkEgN0Y3cxKu17sGrWDz
 PHCvE
X-Gm-Gg: Acq92OEga/JRUnS1VoQLV3BNFTndg3TfjmqpWuCZZUT85qI4yCpMZN3dyzDgSohyYKb
 YR9xR+OckP94p6gojTPp437ke+fOUf1h6FEdGcl1L0o9HCYt7S0BhnY2196hXoNXq5wPLKn2Kse
 5Q7mHjSSqMLeTtjgEMcla32PXvNM7fG5DeLm17pL5bk3i+vWjrMI+j+KwaxIOXSYgzPVAkG2puC
 /FNwjaFrs1hHxTe32ISfrIm63+jJnEWPfijoFsuM0IQl0oQJX8m5QwVJPvuMtoHOwfew2l8qEzG
 xnu8zSIGIpb5ERm2keBc1CzFeKmq87ATQVgMe1cWAZwcN3y3Z6OMb1JtsHspL8PnlSM8JAfmAcE
 Y8ZYuppEFbrnBi8n4I7bFhJSE06mVCtP8RV8e5RcBE90pQ0rahb830z56PvkVqELgBg68v+Ax/p
 fCJgPiuhwrVr7jE8sAoASFUGjEyaStZhCpD7sK7Is6Ug==
X-Received: by 2002:a17:903:b84:b0:2bf:2d0:8877 with SMTP id
 d9443c01a7336-2c3fd41e1f5mr118777645ad.23.1781529582068; 
 Mon, 15 Jun 2026 06:19:42 -0700 (PDT)
Received: from n37-012-226.byted.org ([115.190.40.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm101483565ad.55.2026.06.15.06.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 06:19:41 -0700 (PDT)
From: Qingwei Hu <qingwei.hu@bytedance.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jim.shu@sifive.com, nutty.liu@hotmail.com,
 Qingwei Hu <qingwei.hu@bytedance.com>
Subject: [PATCH v2 0/2] hw/intc: Skip reset for KVM irqchip
Date: Mon, 15 Jun 2026 21:19:23 +0800
Message-Id: <20260615131925.3019370-1-qingwei.hu@bytedance.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=qingwei.hu@bytedance.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series fixes NULL pointer dereferences in the RISC-V APLIC and
IMSIC reset paths when the interrupt controller is handled by the KVM
in-kernel irqchip.

Changes in v2:
- Split the APLIC and IMSIC reset fixes into separate patches.
- Carry Nutty Liu's Reviewed-by tag from v1.

Qingwei Hu (2):
  hw/intc: riscv_aplic: Skip reset for KVM irqchip
  hw/intc: riscv_imsic: Skip reset for KVM irqchip

 hw/intc/riscv_aplic.c | 4 ++++
 hw/intc/riscv_imsic.c | 4 ++++
 2 files changed, 8 insertions(+)

-- 
2.47.3


