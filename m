Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C77F8A14A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIqT-0005B5-5K; Thu, 16 Apr 2026 05:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqL-00059W-UN
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:03 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqI-0007jW-Mf
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so71619165e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331016; x=1776935816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lN5cnRevdUib9AC/KF/yRMt5PqYdQWTK46aW3OuD03g=;
 b=ZjTS5ZXUvxQic9B04wsw+vL7iq1TWlPDqGAnMxHvyLGxQjyRuwE9xCtYgT9uj7vobt
 Cy87FuwGEg6Lu6PlVowUtEIdyBq+6i+69jyxQzL/H8Htagmr+mAMEN1x6yN3bNqRqsXO
 VAEaQXYVW/+RdCjxGR3UU+4S0IKWWlHi1lfYndLagav9vpjxL01bnwtHR4SYz3z97c31
 iU+LLVt4oJF7Vv4F8IsMbJk6E5vsbXv/PHpd1ZjiOV89dEq/xFWkW7sfpxy6BeiO9QsF
 jC1fTXM0Qzf2yH506up8XYYohPceVbYW4XcGeIGLN3o7mwFfFPv7jo4Hz+VkiKiWeYW8
 DOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331016; x=1776935816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lN5cnRevdUib9AC/KF/yRMt5PqYdQWTK46aW3OuD03g=;
 b=MLM75T7PSEk3SkvRox91L8Poz+AtulENbm0zDyk6OgaSTiHDZKqlfykO6VPTNcFAHi
 0XVZcTTszeVdDtCHAUynOmAYntSedDliOQHdFonJfH8b0ylxDMFhMq2UFA61difACwHz
 M0oAHUiHJAiIOzQu700SiIvuc2krGoenWa0OyQEEhNEIsDbff1BOml3OBZz8cVHpAc/L
 phgh2biITgUwLfVRMtiRHfPw+dto6l7kKJuepZ23+aNY2FBHSHV+FZ+Znh+wPr8HQQqb
 upSTWnYzi+E3pX9ohphm6E86G+fGLtBIePsUIFOxdiipNEWs6qUoEUBZ7jY5v+Tfztgt
 2s1w==
X-Gm-Message-State: AOJu0YxE+4eYY7WIWBVqdRk770BtL3FlW/dD3kDh8+CObW3KqKviemyi
 CSnIbm6JJzN0MuGvKbyxlyonCjWcDkK8Y16LMP+SEjXmqn4FS7B+vZuR08ryQEVDWsIg4x+myLJ
 DKP7g7Qk=
X-Gm-Gg: AeBDievncDOsjl4PXo+VNYGOnUIcl+QBVbvhwk5cG2khO246AoUZHyx4zzrfcblYrOp
 +O4AxkrmROjGcr1brGZvEgccipqfrHllDUn5703EsF595ycGy7ZChvIp8ZokgowT+2kYhlQ3cnr
 X4xNggZu1qZajO+DOEB7EZWZdKbvG7uS2En3P1GaX9Ml5AEduy3wOcs9cGiuG1JpjVaE49pYZ3F
 XVjf4GCPLNnZZMUrnkazdT5AaEpPYRr1fODGQOadM7Md2GOeO/ZAWH0wENrHZbNtbNEgAEksPxt
 KcyoiC+8FllHml1xpRUOaVGFRKSKYwiI1GnM7vEgk8K2rDyGrFp++KYw1Q/vAG3EerBcaaKOeug
 6MRc1FYbFqZUaXHkWhebrZ1MDBaIqYuMb7BbXeFXROyMbnbwsF0uQbgfcAf3yekMqKglEJ9DOvE
 XoLiXYv/g+n6uBBHmka96Uw2kOM0km0c/lNExVV1VZkZL4/RaZexWH/IYOUjhi4HLo12POPoSZh
 n1YIYTdTqtkk8TFcmM+Wg9S5KDIeixsRlB/EYNQWQ==
X-Received: by 2002:a05:600c:c10c:b0:488:c530:48a0 with SMTP id
 5b1f17b1804b1-488d6867eb4mr264132725e9.24.1776331016314; 
 Thu, 16 Apr 2026 02:16:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.16.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:16:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/28] MAINTAINERS: Remove people who are no longer active
Date: Thu, 16 Apr 2026 10:16:26 +0100
Message-ID: <20260416091654.316158-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

At the beginning of March I went through our MAINTAINERS file to
identify all the email addresses which hadn't been used to post to
qemu-devel in at least three years. (There were 50 of those.) I sent
all of those people a query via private email to see if they were
still interested in QEMU and still wanted to be listed in our
MAINTAINERS file. About half of them responded to me either agreeing
that they would rather be removed, or requesting that they stay
listed.

The aim of this cleanup is to give us a more accurate idea of which
parts of the project are or are not actively maintained, and to avoid
CCing people on emails they're no longer interested in receiving.

This patchset removes from MAINTAINERS those people who didn't
respond. To all of these people, I'd like to say thank you on behalf
of the project for your work on QEMU, and for helping us in reviewing
code and maintainer duties. If you wish to be re-listed in future,
we'll happily put your name back in the file.

I've done the changes with one person per commit, to make it easier
if we potentially want to revert any of them in future.

The removals here leave the following subsections in Orphan status:

- Performance Tools and Tests (scripts/performance)
- VHDX block backend
- Vhost-user block device backend server
- ACPI/HEST/GHES (hw/acpi/ghes.c)
- LoongArch64 TCG target
- PCIE DOE (hw/pci/doe.c)
- Tricore TCG target
- or1k-sim OpenRISC machine
- ARM ACPI Subsystem (hw/arm/virt-acpi-build.c)
- Intel Hexadecimal Object File Loader
- Shakti C class RISC-V SoC
- Replication block filter (block/replication.c)

If anybody cares about the above and wants to step forward
to help with maintaining them, let us know. In some cases
above we could merge into existing sections, e.g.:

* "ARM ACPI Subsystem" merged into "ACPI/SMBIOS" (it has only
  one listed file, which we already list also in ACPI/SMBIOS,
  so this amounts to "just delete the section")
* merge "ACPI/HEST/GHES" and "ACPI/HEST/GHES/ARM processor CPER" ?
  Or merge "ACPI/HEST/GHES" into "ACPI/SMBIOS" ? (the wildcarding
  in the latter means it already covers most of the same files)

thanks
-- PMM

Peter Maydell (28):
  MAINTAINERS: Remove Ahmed Karaman
  MAINTAINERS: Remove Anup Patel
  MAINTAINERS: Remove Beniamino Galvani
  MAINTAINERS: Remove Jeff Cody
  MAINTAINERS: Remove Coiby Xu
  MAINTAINERS: Remove Damien Hedde
  MAINTAINERS: Remove Ed Maste
  MAINTAINERS: Remove Dongjiu Geng
  MAINTAINERS: Remove WANG Xuerui
  MAINTAINERS: Remove Huai-Cheng Kuo
  MAINTAINERS: Remove Bastian Koppelmann
  MAINTAINERS: Remove Mahmoud Mandour
  MAINTAINERS: Remove Magnus Damm
  MAINTAINERS: Remove Marcel Apfelbaum
  MAINTAINERS: Remove Aarushi Mehta
  MAINTAINERS: Remove Paul Burton
  MAINTAINERS: Remove Jia Liu
  MAINTAINERS: Remove Qiuhao Li
  MAINTAINERS: Remove Luigi Rizzo
  MAINTAINERS: Remove Ronnie Sahlberg
  MAINTAINERS: Remove Ryo ONODERA
  MAINTAINERS: Remove Shannon Zhao
  MAINTAINERS: Remove Su Hang
  MAINTAINERS: Remove Vijai Kumar K
  MAINTAINERS: Remove Yanan Wang
  MAINTAINERS: Remove Wen Congyang
  MAINTAINERS: Remove Xiao Guangrong
  MAINTAINERS: Remove Xie Changlong

 MAINTAINERS | 55 ++++++++++++-----------------------------------------
 1 file changed, 12 insertions(+), 43 deletions(-)

-- 
2.43.0


