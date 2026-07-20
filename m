Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA981C4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlpSW-0007I9-BX; Mon, 20 Jul 2026 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlpSR-0007HM-0o
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlpSP-0006kE-7q
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784559540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=krKqBpnhrNAILhDbBVJH91LhOhk+pJnJkDGoEguyyko=;
 b=c76iUDfwfx9/GY7Q3deSQR/uG0T4cZbqPYlK6AhB0E+Dua55L49pFav0Jj7LlmZRVo6QhN
 qwGsYFp2+dWNhPJLJMffossW/KpUalxxd6L7iYFLx3mcfSy2UHu0OBEFJTWkI9H6eQ0Q7/
 JRnFOLA1Ka96/MCTD3/mTl4rlQder+U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-2m4gyWSpMj2uMydwzXEp7A-1; Mon, 20 Jul 2026 10:58:58 -0400
X-MC-Unique: 2m4gyWSpMj2uMydwzXEp7A-1
X-Mimecast-MFC-AGG-ID: 2m4gyWSpMj2uMydwzXEp7A_1784559538
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f08560ea44so149316326d6.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784559538; x=1785164338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=krKqBpnhrNAILhDbBVJH91LhOhk+pJnJkDGoEguyyko=;
 b=nGfN0UABLRN12uMAh1HFN8qFHGUUXgBN1PKjofBigDZrGySm15ByOjJCh2fWaGr/yX
 WbcrBPL65M6UvBMLRKYRMzg1JlUNJ9vm5sY2vU2MiwfkuKpwOdeCyTNT36bjFPRwkR7N
 g6hQ0TrYvthKks5he5Q2r2Ai4azp6+VBoDhEdsyT1fJkeIhFAZ8zdFV4R/uduEQCZRt/
 O+IYPQ1+vTbBH+j5CC5yovOsfnu9H9F4yLylC1hSas5OfbsSmMiwIKO+Yu1JX4QnjAhX
 VnaTYqd/eEAheEzzZtfBfEfHslrSdbUvxY2rVVsuCtxu/RplZi4L+a+SqNXUIwX23eOm
 K9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784559538; x=1785164338;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=krKqBpnhrNAILhDbBVJH91LhOhk+pJnJkDGoEguyyko=;
 b=XJIsF57fbkwo1SQ6wh+9cub9D0grwA7f/9W2he+vtn8aq/tRsKXfuUkBv+BqeO9iTj
 fDI1ssVNMKTRAC/DKmTDJ1qEq4RCFVKjNawzv07HVzjrIoxeapPVtPQxizMVvo8OtdgR
 BozwG7WK6rbTetj5UxH8pKcVHWkopILh34Kmgd5PvrjP+SdTwxQBVvE0suajANAj2PLL
 Bl7C0poOCrwimlNxyaLZlkKJFTslT9BqNDHOyYxohMmYqjRy7aB97JK8xrFSx3Vx7CqX
 jqY0m99/wLcT7lGabTer203qvar2qoQLQasa0210G1XrizfIn0SZEes10XlrfW2VoFbG
 SkVw==
X-Gm-Message-State: AOJu0YyaDhqhWu1ZPfNMbv2+r8qnmmAafKSD4kVNcajWJ7RrSdMrfZYC
 bVPJC5bEtULnMztKe5VRvyyCJyfSK8xYzrivrBvKF8fRJAxHFN6c5dince6q1YV1NL9OigNRB4K
 JgLnRzD0alg65fpmPA7/mxIc5xkni58BELkD77PSu9REh1rAxVyH+Yz2q9nL4mkcnWCuXB/2vzK
 lBgf51TMuDZlyCbG/1s95DzPBOo8ealYsI4nW9/w==
X-Gm-Gg: AfdE7cnJ+Og/mTNEooopSl4xx1bpD0ikac5hzRilVrWUrze32SPl1Fww1Ou3XovS/rU
 a5df2p0wh74k6WPNp80JtpWOVIwQmIzHmBqe1zJR2qDSu9YqtM+cT52Cr2UfvI+NDsTA++qbXfB
 m110gt0kWbmQXhJir/R1PRh+9mIPlnARLmn89SAyezRlA4ODhATqDt43QXv2VJ5alNM57JonDNc
 3LruYvrsw5gnSELYj8hNd2J8BlGBLVRxrIgOl8O9moi5wPoEspxAOxSNpQ4H2DaxzwolGg4nyFF
 y7/s9WQdBw1vkag4l2u5BCUykop07VzVyBXhO+pmU2y6YJ+/TjOI68T+aBl/v9IzEA==
X-Received: by 2002:a05:622a:15d6:b0:51e:49d7:771f with SMTP id
 d75a77b69052e-5213cad9277mr137039671cf.57.1784559538048; 
 Mon, 20 Jul 2026 07:58:58 -0700 (PDT)
X-Received: by 2002:a05:622a:15d6:b0:51e:49d7:771f with SMTP id
 d75a77b69052e-5213cad9277mr137039341cf.57.1784559537472; 
 Mon, 20 Jul 2026 07:58:57 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-521502b9d5bsm75640391cf.31.2026.07.20.07.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:58:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 0/3] Next patches
Date: Mon, 20 Jul 2026 10:58:50 -0400
Message-ID: <20260720145853.1483307-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 30e8a06b64aa58a3990ba39cb5d09531e7d265e0:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2026-06-29 17:41:42 +0200)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/next-pull-request

for you to fetch changes up to 60f2281450c4b4e9a16922fd69c66486a8207abb:

  migration: clean up postcopy blocktime presentation (2026-07-17 12:33:42 -0400)

----------------------------------------------------------------
Migration pull for rc1

- Bin's cleanup on migration blocktime (partly)
- Yujun's fix on print format

----------------------------------------------------------------

Bin Guo (2):
  migration: fix ineffective overflow assert in postcopy blocktime
  migration: clean up postcopy blocktime presentation

yujun (1):
  migration: Fix invalid %ud format and trace arg typo

 migration/migration-hmp-cmds.c |  2 +-
 migration/postcopy-ram.c       | 14 ++++++--------
 migration/trace-events         |  6 +++---
 3 files changed, 10 insertions(+), 12 deletions(-)

-- 
2.54.0


