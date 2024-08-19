Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8FBC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfuFQ-0000ym-BX; Mon, 19 Aug 2024 00:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfuFP-0000xl-BI
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:44:03 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfuFN-00076D-Iw
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:44:02 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d3bae081efso2860233a91.1
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724042637; x=1724647437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oCZ5ENeePVyl9eEsemdYTWYmJ2Ak9HGXl3wPNuPo3RE=;
 b=MYDMoSwg6jdj1w4uljWJpzR998k8imvnTQfQ6eAOzG329hXH2oxlxuvu3PstUIw0Sq
 WoLKdbE+85Jablxs15LfrhYpEMxuSjXNyGfg2iKo2wRg1HSFgoft13n7b/RLhl9wC1Au
 mxwQ2zGQPQqhr/kfPLzOGJDCxrpBNib0BtSj8Xiarkd5ob4yT3YOFp+C0C/YW5MZI5kO
 n29I6O7HibE6E3+ZL+UJvBScO1iFzBr4VlDS1qMqr/VDgCQ6gL/kFmIHNbAJTYuTMkVh
 +RP5eh5/SHifjTWSYwMVErxGUT6FpjuYkFsLXBkoSbzPjrrBobAHDmzG6QQAmqGJWLro
 eLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724042637; x=1724647437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oCZ5ENeePVyl9eEsemdYTWYmJ2Ak9HGXl3wPNuPo3RE=;
 b=Huja68lFynQHWzLCxWDlN+tfnKbixgxVpbtNzcZkUJjTyE74G/39O93R3IQVbaZZLc
 0WGFLh8j054ChGH8BLnrBuSITslyTukukv6RFasMB+IVhnyqUinf8D9EzkK0GjLepvd3
 X2yBjDzs59ySC0SokaqypQ8LsHoVUZvwt2YJmpF+VdnHZOc3xHoP3/czRZ6t9RWxayOI
 QENigSw/w6oTL328ql12E9uslMVejL1nzvoogVWq0y71cT9C5LbVsuivEwAkjPeG19Kc
 6VlLcqHNbm4QCf5dbpjRIKG/WvHOfdmrF7hYtW1IzWZ8RmwiYP5o2MLS3UMd2PU/AMb3
 GvdQ==
X-Gm-Message-State: AOJu0YwebUAcDcgsJrQ2OALCs/XzdPayclyv0BvPNEgLe4E0u0eDbOLF
 gKbdz60kMCFbHhSPz3D5SSHladP9rxa0OTHN8UKyOgeGqXOGtQf+XMuYbqHxWPw=
X-Google-Smtp-Source: AGHT+IH3To9dX58aeObzi+ohQCM7Dqsuk52x4QIPYzOSPGEH4yGVVF8BqnpwmB1PGMg0PXZjptDYFA==
X-Received: by 2002:a17:90a:8998:b0:2d3:c862:aa81 with SMTP id
 98e67ed59e1d1-2d4063e8955mr6792649a91.32.1724042637315; 
 Sun, 18 Aug 2024 21:43:57 -0700 (PDT)
Received: from toolbox.alistair23.me ([129.253.180.115])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3c0b87dc8sm8343345a91.38.2024.08.18.21.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 21:43:56 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 0/1] riscv-to-apply queue
Date: Mon, 19 Aug 2024 14:43:43 +1000
Message-ID: <20240819044344.2939218-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 2eefd4fcec4b8fe41ceee2a8f00cdec1fe81b75c:

  Merge tag 'pull-maintainer-9.1-rc3-160824-1' of https://gitlab.com/stsquad/qemu into staging (2024-08-17 16:46:45 +1000)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240819-1

for you to fetch changes up to 6df664f87c738788891f3bda701e63e23a0dbbc2:

  Revert "hw/riscv/virt.c: imsics DT: add '#msi-cells'" (2024-08-19 14:34:49 +1000)

----------------------------------------------------------------
RISC-V PR for 9.1

This reverts a commit adding `#msi-cells=<0>` to the virt machine
as that commit results in PCI devices unable to us MSIs. Even though
it's a kernel bug, we don't want to break existing users.

* Revert adding #msi-cells to virt machine

----------------------------------------------------------------
Andrew Jones (1):
      Revert "hw/riscv/virt.c: imsics DT: add '#msi-cells'"

 hw/riscv/virt.c | 1 -
 1 file changed, 1 deletion(-)

