Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762C3C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2is-0001Hp-8f; Mon, 03 Mar 2025 05:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp2iL-0001Cy-Su; Mon, 03 Mar 2025 05:08:05 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp2iG-0003Bf-Fv; Mon, 03 Mar 2025 05:07:57 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2feb96064e4so6217664a91.1; 
 Mon, 03 Mar 2025 02:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740996462; x=1741601262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8vw5UP2F4CCstGMsAhj6cFiNJkBAJ/Fn74w4AjX6tHQ=;
 b=NtSovV2j/N0J+vBCDWgDDtTX4xFj/7OXFusQGFXQ2mtHMWH1gzMeE8Vlv0Kt5FtaCp
 NbsysuJuY8Z+g7yojpwRhmH9Dp5VU7UZgS200gYeaVr275Md3cYxHm9Q2Yp1QOd6PNdA
 1szMIUTwCB2P4wUzc4pNJLHUY6f2CJnvBBlLDTtMwI08ha9yOXARPCQLsk5p02xnMd4f
 l0/+WdtFCMNpMVS0oqpUio0pozxNwb1KkrLfCMZ6CA+jaEVUSudAQXxdSSoDZ9pyb3VZ
 zeqQD6Cr9NGxU5u3BO2eM+PPKZdQh+8ppK7MLZOyRSlG7T5nrcoGYFhJqvVQaLmE6ht/
 +2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740996462; x=1741601262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8vw5UP2F4CCstGMsAhj6cFiNJkBAJ/Fn74w4AjX6tHQ=;
 b=ZzldUWbQDjYXsLGERueiqyN44Unw3GtzHKDPa2GL8vXiYoi4b3AubFiegRpdVdhR0L
 FPHyTnFFdC5sKN+NHx6qfcJ9m0a2QlRgBcPiJFiX9Gjr4xeKvRgXB7Fuj83HHjB5fZ9t
 rDrFOU4LeESxljQ7w2VHmkIrRDg5A8hJ4Tvo8Yh54cDcWu4Ak5lbBDCYJ/gQZ2rTt71Y
 XX4yf1C21VNpXOzZkR1U+zCrgMMOY7CfnQHZNUX4Etsb+rAMJpAI+DE4d8yAEKsuEAf+
 upD84K0uET5GT/sSuP1LBWBpt+/EqxidNX4xkRZTtdQqFCmU04MMiqejGyMlVfGpn+RQ
 G3/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWQwTVHFdpVWZthLmK79n3Kb0l7vUuEZ85/rupqvxi7RIYvZ7Ut1AJJ452V/XDFFlqgERhyH8zTYp+@nongnu.org
X-Gm-Message-State: AOJu0YxQzTtzl0yxCR6VmzxZgnCZ9bGMmErnmPkp6B2Xh22hneeORZgn
 jQOLugZ5T23osGeYFnsrCMfwMxTbCpntvDchs2PvtyuTcCVT6/KwWzqDGg==
X-Gm-Gg: ASbGncu1Yqfi/T+TR5fqbGDN97OeOwAfMGOw6motGRI5265UbbEKli7Xz3yT5KsiOPj
 GOX91jaMOGjHsxWX+h7PFJs6a+XKVxbZAPB1uPEaHPP6qPmRRrIPFA0HctK118N3EVF32NH55GN
 BUbVT3qMYKXrKMj/5AfU8SkKVSpDPcCcJFiXTfTHib0E23N9iSnvUN6PYwjFv9uiz/MES3aMvq3
 D9eQQqojMZ8w030/xy355/yfQweMMSO7cqcbFOYboUba1CBZqu5SFNBEtl2grK2M+w9Y8pVaYoh
 ahIseAtebFVZ7qeoGVow+WXtDztZpHTkk5gfEL0FEMgyuHsAtvs=
X-Google-Smtp-Source: AGHT+IFzaCvrI7TCCJdA027TmifmxgfLGbSGr5FYgtC4HgLGyvyeTUS2imtBY9SpWKbZ1geBNiRD1A==
X-Received: by 2002:a17:90b:390b:b0:2f5:88bb:12f with SMTP id
 98e67ed59e1d1-2febab7770emr17191119a91.21.1740996461996; 
 Mon, 03 Mar 2025 02:07:41 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea67a7ddesm8539779a91.27.2025.03.03.02.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:07:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH 0/3] ppc/pnv: Support sparse NUMA memory addresses
Date: Mon,  3 Mar 2025 20:07:29 +1000
Message-ID: <20250303100732.576457-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

IBM Power machines put NUMA node RAM at fixed addresses per node,
rather than packing it densely from address 0. This series implements
support for this by allowing machines to override the core NUMA
memory container packing, and add their own RAM regions to the
system memory space.

Thanks,
Nick

Nicholas Piggin (3):
  ppc/pnv: Add support for NUMA configuration
  hw/core/numa: add attribute to skip creation of MachineState.ram
    region
  ppc/pnv: Enable sparse chip RAM memory addresses

 include/hw/boards.h   |   6 ++
 include/system/numa.h |   1 +
 hw/core/numa.c        |  44 +++++++++++---
 hw/ppc/pnv.c          | 138 +++++++++++++++++++++++++++++++++++++-----
 4 files changed, 166 insertions(+), 23 deletions(-)

-- 
2.47.1


