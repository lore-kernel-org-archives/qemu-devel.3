Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B77E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 03:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO7P5-00070o-WA; Wed, 18 Dec 2024 22:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7P4-00070a-EF; Wed, 18 Dec 2024 22:40:46 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO7P2-0004Hc-Uv; Wed, 18 Dec 2024 22:40:46 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21636268e43so3875375ad.2; 
 Wed, 18 Dec 2024 19:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734579643; x=1735184443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=92NFufFhsFDGvrTgzEG6aRfej6pEjyfQArCcINBf5O0=;
 b=cFvS4ik8Z1PNJOEa2x+ddpTg5SkRl2jVbHDmqUWVMnEKqT0a+nBM1hGEMgQn4w42Qz
 HsBb0/HBTrl0s5FJ4pc0yp+DohepoGPjUykrgjYrqjT1COc/rCZOFqfq816mQ5ADfkMg
 8LbLswHuMrLQKo3IDOuBO9NijdKWMVftsyVWEiitkVin+NjiaGxrdQXLiIoye/4Jv16R
 MRH4KhwjfEO6rvNgf6uPuHrBlWJtRjQIrmv0SnUZODihb2lchYd1zuDU4V+avKIwfXxL
 CZlZRYea5tuEmxLP7DkJ0Ekm0LDwxOPhL/5+3unIRd5xvCrWbf8XVcO9V5wTCNIuuXGk
 NpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734579643; x=1735184443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=92NFufFhsFDGvrTgzEG6aRfej6pEjyfQArCcINBf5O0=;
 b=mvWGjooO0+zPjMUZYJ/SZfw67mBa/XqRg/0+rz3I4NLkJhFHRthew001vbZ8oU4x1g
 Jlb+GqXeaaKOmxUIFDsarLkyz5mX+euTaFG4p9Ksftzs5sIUjPlh3aTpeisVvubblPFY
 nmlREdniA6jcVmmoP+zbhLEQl/KLFlyyeed9hC8mleDj6s9G+pWuq6KRu8/Pi8UvqFMc
 g959Gwt47HDTDwE5QGnmOv+v0uEhFDTf8gAZS3hnIODUI/kreZ1NRmiMStJ7s6rMwVnH
 5UuRSzAL3O/RqDRkBUmrhZCut19A26yTLZEpBYxWxnuzE5wXf8x065KJIpLvo+LzvQqY
 N26g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYpNtqwQe1te/O1l0UFdL7G1oP8U4EtmnCMHwORbVKSwkNcLSLiTFJ8EfmGqlNpAdbHyBGDOiWhflI@nongnu.org
X-Gm-Message-State: AOJu0YyZms1zJ23xv7qQhMaZNbrFxgMYzyet2t38revILYzx50130FZy
 I0OxowGDA7C/QlK0wH2DNHfMbDYqycusaLlBRwotlFT9BtUytwQgU3CU+Q==
X-Gm-Gg: ASbGncsmL1Kn8sjUc0b0Eg4Kf0VehYoAMKOmUkeu3Q+0MehgzDr4xRdmaD7m04tS2l5
 ICVJi5tlV+0AQrrcaVuC7kwRg+k9VhpiSdQEAY57mDEw+gsvEOR+oAAA3QsgvHpWE7nb1ECMp+a
 hSUbAqDMEFnnoIWGHXLdwGa5ySh7RdKM2uM9K47LDW93uKowsrYli72hQrBOEMY8fSgSYdMj9rR
 HJFHyRtkTrfFuZl88K9e9+dVULWamnpQor60JEuU6m7z3N+2tk6dNB/Y1OoFgUzy067U3eIh8wf
 iZXOhXq7Kw==
X-Google-Smtp-Source: AGHT+IEAvyfOd74OBma3Wd3OqDHwJkJJh73HJteFa81g9XL7zeP3Cvl/xSz0Y36QSTHmVPavviIqPw==
X-Received: by 2002:a17:902:dacb:b0:216:7ee9:2222 with SMTP id
 d9443c01a7336-219d96d098bmr26204485ad.35.1734579642578; 
 Wed, 18 Dec 2024 19:40:42 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc970520sm2881595ad.75.2024.12.18.19.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 19:40:42 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/5] ppc: misc ppc patches
Date: Thu, 19 Dec 2024 13:40:30 +1000
Message-ID: <20241219034035.1826173-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

These are a bunch of small fixes and improvements for ppc. I've
posted these before so I'll just end up merging them this cycle.

Thanks,
Nick

Nicholas Piggin (5):
  target/ppc: fix timebase register reset state
  spapr: Fix vpa dispatch count for record-replay
  spapr: Generate random HASHPKEYR for spapr machines
  target/ppc: Avoid warning message for zero process table entries
  target/ppc: Wire up BookE ATB registers for e500 family

 include/hw/ppc/spapr.h          |  1 +
 include/hw/ppc/spapr_cpu_core.h |  3 +++
 hw/ppc/ppc.c                    | 11 +++++++---
 hw/ppc/spapr.c                  | 39 +++++----------------------------
 hw/ppc/spapr_cpu_core.c         |  2 ++
 hw/ppc/spapr_hcall.c            | 33 ++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c             |  1 +
 target/ppc/cpu_init.c           | 17 ++++++++++++++
 target/ppc/mmu-radix64.c        | 14 ++++++++++++
 9 files changed, 84 insertions(+), 37 deletions(-)

-- 
2.45.2


