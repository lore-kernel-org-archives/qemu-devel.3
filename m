Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC9ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WSw-00071H-Ss; Thu, 02 Oct 2025 23:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSq-00070G-Ri
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:12 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSf-0001Bd-N1
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:12 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-782023ca359so1820349b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462074; x=1760066874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tj6EMm4pi/huEWSaJSUr8mgJHcpPYWaotsC2MhygF1w=;
 b=DE7sKyD+mjc9eAsO1B87RiVLZCWw9blySwrKD0hTKKxhgHurTfaEG9KGI/KGZUdEe+
 qYRgMZ1J00kdN7MN2YdmC4f7oW1kFtEcT1TlyPInS2r01i0haSIJLMoy2eALp+w4DGcG
 rdotPoVMuTjrrTHJNr7jNT8dKpAioVOLWWm/g9iDbPoy0MGXjmBsp2lAPBmSv0UHi5Hm
 LsSyBnXMgz5YiXk4HKCx+jicwdbkdSuE6rbtIAlu17Qm43GA/cvCXvAIhj7dKhQMv+tF
 S+19p4Yc/q+uZb0KJ8DU+IMbL6kBZUXxFD/l+oiSzacoyUa4kNG6Dk2gJypAFygfwAQF
 2B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462074; x=1760066874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tj6EMm4pi/huEWSaJSUr8mgJHcpPYWaotsC2MhygF1w=;
 b=CCjAEk0dqHjiHH0Ps0Wy3pQJPxmSyD2e9u2lm2MuVGMiUtPzwznM3EmADOJlkdfV1X
 BZF2i5UHwne0ksJGAXlr7vtFN+clS6gB1X8saFPYUu/hYrv7zOHKwpv4Hzo+hnQunfIB
 Pzb/IDYmIhIay2R0fal5MklpzZYVPYBWUvT7sxqRXIi7+w1WHGnx3r1490t//HQJzsoj
 QzDzGsNbXrP78U+QVQHOCATX9JbJAMnsnWaqwspJB3tRThOlius0sya3oFAX9urze1Zk
 mDHc6ElHSx7Yqz6IN0kp8+fgLGtJS3z/8FvLrkMCHjdv8beVbeILx4jLWv1a1dg8m4my
 2HHQ==
X-Gm-Message-State: AOJu0Yw7H60R8sg6UaTfJZh5XeuVDBGMObEU1D6Y7ZxDj62p2+bhcV/k
 fDgDditYEltGFrmuVjjLkdK8aMZ3a0bTY36HgoRGPecSpINGilXOUoqDdQYMqg==
X-Gm-Gg: ASbGncunEmtcFsx4rm+xLp6o/byxfSrHpzW2nQS+brzEWu9fIeq+yOmxeBin1VT3AaZ
 Jg3dmMgAuv8wC1nXKXiy0cEilnqlv1m9nJcryHCEIfsKmD/AbUixm2/WfOlTrr2cu3jm/JExi9v
 En1cEu6lZXrtoUZ1pyzqxb0secF19Ww7WNlPHOQKSc1q51Z5/D24FkmLIvWqDnTIZ2/7bSpu5Fi
 /WQIbolOu7hixp727sFW53dVN8o1yLasL08iwSfkbflRqsaSsm6UWFCPW2pLHR/KCTq/AIhyIbF
 WG5AEjZ2Bu3iBSi5w4mbYAFBENG858hSlDvyVVu2aTf9AOt/kpz+R8RCb5RFLIqCezlc77CplK2
 M7kbbOcoYe3/kT91KRmhb2WUlmLsebsn6nyktZinP7CSsZzNNA4pc2mErpLfT8gmdbYpF6PC58V
 vhPmHimKNfvkdY+V7KhsL/yHOxQYh+sVimJa2FrP+3rCXaUS2GAnbk
X-Google-Smtp-Source: AGHT+IGVBq7tIUHzGXUxqyTvTjsPGeOBi6vLtCgYFaC9DJ3OwK7k9m7xEr9OGquIKc80iYH4O8YgaA==
X-Received: by 2002:a05:6a20:3c8d:b0:246:3a6:3e5e with SMTP id
 adf61e73a8af0-32b62108016mr2079462637.54.1759462074555; 
 Thu, 02 Oct 2025 20:27:54 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:27:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/26] roms/opensbi: Update to v1.7
Date: Fri,  3 Oct 2025 13:26:57 +1000
Message-ID: <20251003032718.1324734-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
version 1.7.

It has been almost an year since we last updated OpenSBI (at the time,
up to v1.5.1) and we're missing a lot of good stuff from both v1.6 and
v1.7, including SBI 3.0 and RPMI 1.0.

The changelog is too large and tedious to post in the commit msg so I
encourage refering to [1] and [2] to see the new features we're adding
into the QEMU roms.

[1] https://github.com/riscv-software-src/opensbi/releases/tag/v1.6
[2] https://github.com/riscv-software-src/opensbi/releases/tag/v1.7

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268752 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 273048 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index b2e740010b..02be3a72a8 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index 018b4731a7..cce35c65c2 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index 43cace6c36..a32a910691 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
+Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
-- 
2.51.0


