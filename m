Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE53C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wenMj-0003Jr-MW; Wed, 01 Jul 2026 01:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wenMh-0003IP-Bz
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:20:03 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wenMf-0005jP-Ll
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:20:03 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-37cab825ec9so182902a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782883200; x=1783488000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VlEIFb1njhqEsi5/PzDge8mjrlguSpTLubs4pt8gWEo=;
 b=CdtWKX2D80OJgQc9GpcIZf8g97C9MkW7pOhI2Ktm0XX/8YPC9xJsoYy8rhrIEwmJFc
 DIS92Jz0H+qROB+0V1GhfOoHR/IPimDkSbb+j9/EbJzqAL38BaFVKGbNes5B3xhypzCq
 1D5/I1ZV1AR/ruB2/xL2F3ct7qhatnPJlIf7dKaqJ8O+uk56a9quVNQt20X81ctH63R7
 V9INuFNMVP6hBKcuSHuhvLAf3b74reYXr+1w+B0PO4LOqvuZ5FVpAcXHXscO1MrMszfn
 kZq0rwEhKReXlDu0SouzijhkNp3WzQ7oF3qWxifDL3ZbrEHRwuMLcnnFXPoqrjP8qPUT
 O7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782883200; x=1783488000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlEIFb1njhqEsi5/PzDge8mjrlguSpTLubs4pt8gWEo=;
 b=Xi6IfFK9udmv7dQ/+/k8bw1MPKRMf3/OJzMH+x7/EFJFd+FniPUcxA0bRubtJbSGrm
 w/2I7y95uI4vHFjvTleJ5jlpZO8uzLva3abxRYtrB7GLz/KhnCKa8j2RBBYGJaEtCROH
 ON8RUU0rkNqB4ugtovVqR/f+QRNIcdWCqzSPPxX/tJYpo6Hwf3mxjIVTIww07XQpAmRA
 5Yr7nC/c8/Bmx9FpVYOF7ABkr2n7A3O7UcEcc8iqwPqe1rqtmtb4eJpccSoqIIIPn/23
 0kjnT+OUgnGvAmvJQwP0ZFQsiRLp3IQLCiyb0CTogSzpt50CpCMG7P+a7rfscdDuKV/e
 lJOw==
X-Gm-Message-State: AOJu0YzD/AdielwS//4K1xOMsrZnLH79VFlyAkU4CzOgTrwyjiAIX4VA
 haeb+kDRDGEi2I7nPGudhxHbfsrc86DDu1squ9k0pOzD22TZfQ6d/GP0PSKhmQ==
X-Gm-Gg: AfdE7clRlLNioUVttKOE28hZPBJqnrogmJcl/FkhsnDhyMLroQ1p6SjTrjPvRerrPfH
 n7ehUvDCl82qyjvAraQ0WTUVZ2/rUxBl2tVfVmJHt6DPYbCOpaHmY1Bw5fuwCQsQ7PIEB709yRA
 6vrDktBc9oua+WcGnR7pByqZ6+rVCUWlaYFDdxEoeAGFS2osEb2NmLujrMmQp/z5QOpIzLa/abW
 QisVciBUTS6DvQkfCe2Wtu4L3+41XXl56wqFEfBKaUUFBg8OgsmjblTwRNqYg6ktcrfx/UwlUi8
 NRI7WCcDNpmAeMndG3YILhJafJd5JepQcT7UYKUfZUEQ6fpv/rF0irtNvKKDij85TiSTfP4aQZH
 UOVQqbEkd45793KqTHsDRH3+9NyKim9PsvKeTd4FuIs0OtGzSdPGQ6fHFfiwKaanEtJScQpZHUQ
 mquvCo0miIPfypOSgJPg==
X-Received: by 2002:a17:90b:3cce:b0:380:9ef6:e8cc with SMTP id
 98e67ed59e1d1-380aa07e1f3mr243574a91.5.1782883199768; 
 Tue, 30 Jun 2026 22:19:59 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095d4c263sm1098157a91.3.2026.06.30.22.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 22:19:59 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 0/2] ufs queue
Date: Wed,  1 Jul 2026 14:19:45 +0900
Message-ID: <cover.1782882742.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit 30e8a06b64aa58a3990ba39cb5d09531e7d265e0:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2026-06-29 17:41:42 +0200)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260701

for you to fetch changes up to 20c03709b353d6c985bfa3174c4563d57ff47275:

  hw/ufs: Populate cqe.task_tag for UFSHCI 4.1 tag decoding (2026-07-01 10:19:10 +0900)

----------------------------------------------------------------
ufs queue

- Add minimal PA-layer DME command emulation needed by newer Linux UFS probe.
- Populate UFSHCI 4.1 MCQ CQE tag fields used by newer Linux completion handling.
----------------------------------------------------------------
Jeuk Kim (2):
      hw/ufs: Emulate DME_GET/SET for PA layer attributes
      hw/ufs: Populate cqe.task_tag for UFSHCI 4.1 tag decoding

 hw/ufs/ufs.c        | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/block/ufs.h | 18 +++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

