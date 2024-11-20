Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C98BD44171
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 08:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDgSW-000055-H1; Wed, 20 Nov 2024 03:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDgSR-0008W9-PD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 03:53:08 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDgSP-0004Vb-Pc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 03:53:07 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso16919465e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 00:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732092784; x=1732697584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AKRf522PiZvbyscqQiXBRA8lbsjpyWsajE/CJmlcFBY=;
 b=tsWiI99KXWMYOurgJfYevO+S/o9M6qvLgDxjeseLYn6lWXCRLTL8vmT+EIamJC1zYH
 0tA+3WgvdjpIa1UzIfiX458WjlO+wsxlSQzKPOMUtxYw/qVjADNwoRaCrOnvtS9c3VHg
 gont5aTvJgYwxZ3hrBF10NFp5msnO2nfdgpV9/gb77KnewRI4nchP3ijkeWhq3yRHY62
 VHKutYuS9vxnDZvpFHEyi82gBNrQFSUzAiFQw72mjdcRQXCmQPsT1G3UV9Y1LWAvqlvZ
 aZM+tsJbPwNEgzcioIfVg6lB/3UijEbXXLoLTVMn8f2s8zorOom9AGnUE13u6NEaDtTd
 +Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732092784; x=1732697584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AKRf522PiZvbyscqQiXBRA8lbsjpyWsajE/CJmlcFBY=;
 b=R4Qxa5DiLLB7R+pOg9Lq3xoIse6GRykGs+IsF0QvMy4/3Svm47gvF1gzZqLK8bhsDq
 EM4r42Yrc00iaPv1zgRkg0TEWJHKO3jXIUW9+DAN23+FZRyJ8JhsCOCgNDKFv1VkFsAS
 LqPCFtOFKWSMEU4ZZm+vQgz84TfVgY3CwyYKz/2/hhwKoE8Kjwia99cVM6LzLxohxsyU
 GZcwO3Zza6c62jLshzzMj52JtjX2RI7CiMa6FAUwbNdqx2CPnbPmSHJmz28Q46EvySjU
 dthv+412SiQ/WWE2dO6AqqcZTMshONA6lmRN+/biyIS5gdnJJdizhmEoVy4XduuLYrfa
 /huQ==
X-Gm-Message-State: AOJu0YzMC2ggJWFUyqDmTZiuBI4zo80ewaiKPktauxBgCcfK7ZQdYX++
 Tu3hMhiBDAtD1btoVPjGyLJo9lvMTWqfXa0QbrtnJCc+uZOaab1ea+lfoms34eB/WBhr3HOyM6l
 4fOI=
X-Gm-Gg: ASbGncvA7FgPT2sAEzLlQLciNACLEAEOaMMBpPUVl+cx9fcwfSwtB5mF05FxNBaouZC
 Jq1JAS7Uj/AewiviZJXBDwIXbwU4zQ+38vLYhsYNe1l/T4lzmFvDtqs1GKTzi7HZ6sR3G94LS1z
 xNTZ3Qy6+OOtqSR5I6CWVRGj3GdF2aNR53ypKV+DYue+qOMnsGwU5Sut/1Th3Esr1C0DeufV8dA
 BQbE0r7Ofaj2E1iE3/GliYjWUIzq/RWq1H9m1hKxQdG1qNOIjcsVlC/3ZiWZ5zM3U3kbx0=
X-Google-Smtp-Source: AGHT+IGBbk+LhP6Ss187ucY/w8V6ryiCDZw9dV4JWsmXdCmek/L2cWKYyjWfFyiaiO2+1m2EhuS6fA==
X-Received: by 2002:a05:600c:4e04:b0:42c:de34:34be with SMTP id
 5b1f17b1804b1-43348987112mr17936265e9.3.1732092783621; 
 Wed, 20 Nov 2024 00:53:03 -0800 (PST)
Received: from localhost.localdomain ([176.187.208.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d1d09sm11681265e9.4.2024.11.20.00.53.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Nov 2024 00:53:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/scsi/scsi-disk: Avoid buffer overrun parsing loadparam
 (CID 1565746)
Date: Wed, 20 Nov 2024 09:52:58 +0100
Message-ID: <20241120085300.49866-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Replace magic 8 by proper LOADPARM_LEN definition,
use array of char, allocate loadparam[] within qdev
state, fixing Coverity overrun report (CID 1565746).

Philippe Mathieu-Daudé (2):
  hw/s390x: Declare loadparm as char[LOADPARM_LEN]
  hw/scsi/scsi-disk: Avoid buffer overrun parsing 'loadparam'

 hw/s390x/ccw-device.h               |  5 +++--
 hw/s390x/ipl.h                      |  2 +-
 include/hw/qdev-properties-system.h |  2 +-
 include/hw/s390x/s390-virtio-ccw.h  |  3 ++-
 hw/core/qdev-properties-system.c    |  8 +++++---
 hw/s390x/ipl.c                      |  6 +++---
 hw/scsi/scsi-disk.c                 | 12 +++---------
 7 files changed, 18 insertions(+), 20 deletions(-)

-- 
2.45.2


