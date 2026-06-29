Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AE9C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we0fI-0006O1-Tw; Sun, 28 Jun 2026 21:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1we0fH-0006Ng-HJ
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:19:59 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1we0fF-0006x6-Vs
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:19:59 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-37febcda057so130550a91.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 18:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782695996; x=1783300796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sfPb47el87s2Pnqjl7c5Q1STUgh4k7VH+T1K97NiHnQ=;
 b=MywgX4wTje6cP3LoG/M8vglnfRhrhmt6O0GUXFzmTkv7hpJkThSDI+b0UglUSsoC4u
 vQA9t7mJ5ufAHAMMbOB8rO99yg/uHWNMnGW8FBoZhIS6E68D/dq6UoFUErYvdn5k/i5L
 GaOhT/wbMU/m61L/c/mGiq4/gsVvDnKCgFxVGu5xmkfCbhpvwMVxZ65Kink4Lf8sQcig
 IZUJ41KtrK7DaXnkQWmXb7q3eMBwfqAIjbJkr6KarczTzg9vP6gncf2KNB7H/0OkvqlI
 H7otvhxHH2hfANNW5cHw21qS0kvZmu8Kmj8s5Sc/MDIj7Kdtv54KMwGDhkWEGSCo4/eA
 fPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782695996; x=1783300796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfPb47el87s2Pnqjl7c5Q1STUgh4k7VH+T1K97NiHnQ=;
 b=KyZqRKUjPoL3dFot1u2W9KbMOI7XGMb9YQxH+9PAg+PipNBbeDzBIStRo4Yu3bPwSA
 4GVFSB6JPDSKwcI83vEp+MLy4KwoTWFDLeQeNbskKO6vsDrXolrWq5JvS22JtZFAbAtL
 qYe7HKmz2G8NYpxrdKu86T6SSnevGW4fbVlPUx67+k/olnFa4LsStme4jfW5s9IvRBHu
 h5eCwdPfMJx6K3aKhd91XwQUyBw9GLa52C6XiaMOaC+VvknR+fuV/ocXhnfKy7qH5rL3
 7q5TMBDzlG829NbH1YMct931yAoMEkmIspLxzowtFnrlmExaZJ/PCoUmoXiyfcXBi26/
 4qLQ==
X-Gm-Message-State: AOJu0YwDaPkNm/93iFU/ymMJzolNf4iPzFUdQ9jsRGaqTAiGKLo65Qu+
 lEql4GPkPHQ5Yag+ojQMtHdCIndTtivO9l115JfXpuIpicKAvWAMaLg4dYzITw==
X-Gm-Gg: AfdE7cm/6r1XuAtA466yFM5kL9c0I4JW5AN7GOhTiZQrTwUZKMALTB9sKHCCz5G3U3N
 O2dx7gwdFyCoW1rQnTWqGEB0lq22HrZPqVdgYslGU8ntsLFGUijVrIHt5e6e1jkJOCvdOhR6zbM
 DHzdkOYkKC7EyPb9/eJ6Jtuo/23TAdxzz3JE1oZzr6TCQn2OXy4PRXSFy9LwpO0PUTa8MYHLjGs
 5/1yQLWAnMMs4Q2iWKvZQIN/9TOhbgjCERZtIt8Sm2g0H9mENXuWIXntzGWFUbA9v7d384oqylJ
 W7ucTOJ5cULVxNn1w3hi3eSjpAomF+ZCtUwOePkxwwmhXO8tvxB8yrDRqUDgHSSaswJkw/hiJ6y
 k0J8S7KynNTlM9XYZw/0VMIA3F6MtcDy42aRAtpzti+9JPxPb66eq2ADXWkQqySARSpx3gQWl9S
 Yeb71pwyfU7yU+sklc4Hnt
X-Received: by 2002:a17:90b:4ac1:b0:37f:9ce1:735c with SMTP id
 98e67ed59e1d1-37f9ce17463mr7624613a91.29.1782695995635; 
 Sun, 28 Jun 2026 18:19:55 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37e24b13458sm4614058a91.13.2026.06.28.18.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 18:19:55 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, j-young.choi@samsung.com, jaemyung.lee@samsung.com
Subject: [PATCH 0/2] hw/ufs: Complete UFSHCI 4.1 link bring-up and MCQ tagging
Date: Mon, 29 Jun 2026 10:19:33 +0900
Message-ID: <cover.1782695495.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102b.google.com
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

This series fixes two gaps that prevent a UFSHCI 4.1 host from bringing the
emulated device up and using it over MCQ.

Patch 1 adds minimal DME_GET/SET handling for the PA layer attributes that a
host reads and writes when negotiating the link power mode after
DME_LINK_STARTUP. Previously every DME command other than LINK_STARTUP and
HIBER_{ENTER,EXIT} returned FAILURE, so the power-mode change could not
complete.

Patch 2 populates cqe.task_tag (and lun) in the MCQ completion path. The
device reports version 4.1, for which the request tag is conveyed in the CQE
task_tag field instead of being derived from the command descriptor base
address, so completions were all decoded as tag 0.

Jeuk Kim (2):
  hw/ufs: Emulate DME_GET/SET for PA layer attributes
  hw/ufs: Populate cqe.task_tag for UFSHCI 4.1 tag decoding

 hw/ufs/ufs.c        | 46 +++++++++++++++++++++++++++++++++++++++++++++
 include/block/ufs.h | 18 +++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.43.0


