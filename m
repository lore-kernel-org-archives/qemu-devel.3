Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EDBC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtocj-0007yR-ER; Tue, 11 Aug 2026 11:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtoch-0007xd-6L
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:42:39 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtocQ-0004CC-Cm
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:42:38 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so5161451a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786462941; x=1787067741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7V+Ujk44PJvZHDttbRgVQxc94DYK+G9QIRN+pGmRpvA=;
 b=goYlhNtYLGhzqyZYfc84jDGKRq7Ezdi0iwlrFrQRPWSiKln8X9J/+v2u7JhGlEwtGj
 4d/Xbn3Vxrdz6z5FjYVnMCGeIMoZwr9h/HYDpFJzNdVhMfwN0Td1yanaUI129giYHkJR
 xyY2FtRgoqhNnSj4oMlqFLLiMpVfBjhdZ7IRJayl8KaQSrFnApabQKXTcJQ0J/OzgKiK
 NVzI1crNcKlrKswWh+MnIx50nWELd7ivZfvjdmLfAXFYYA7w9cyf5CRV6kZpCPA5eiqe
 CSUjNYZxpOXXZmOPUlGPrlagpGcS9n2b6xqKlIXsvgoGw/DlIv8uqfcmwsUlWTpPAJmZ
 RO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786462941; x=1787067741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7V+Ujk44PJvZHDttbRgVQxc94DYK+G9QIRN+pGmRpvA=;
 b=dJEW1MmdwCNkXLAIiO6cK8ahkqlaMWVnI4fcwUi/f47Cb+lWXwsvrqQvDKS9XOGccP
 f15WEEgRV6rgFUsObQETAuFImZHJ6nE4V50FfxsE6JqeaFGyE/NQyZvVm4AR/EIkmd7V
 SWU76HBtOxHq3moBMM4rR4HdneNjzy6da6yQ74bKqGQSyqtul2FcrKuFfOsC5tqodOvW
 Mrymf1zX4aUXZ1XXqQJmBHOM/Bwp/IihJ+dQMiX/IeJcDt/ZnzvKOLhDrLtgjEXpCiOd
 v9OKJtRNRezy28E00LTN5Dl7INqs0IrVpyUHGxSwBiRwSD6oa4Qp/xrFey0f+QsZR3vL
 LQ0w==
X-Gm-Message-State: AOJu0YzYoYA5NCA7cXFQ6Ql/UzuXhdZDOV331Y3p+wzWm9HY/eA5pnrk
 gJLJo843WOGh3jx6BbcvTg6rZO7RQ7KlbbAACU41zSL9aUJoR1mIDO49UDSY5ypPiv5kA/x50qv
 5sV4E
X-Gm-Gg: AR+sD13gTlxpGhn5u4Z25L9/L4KfEO9YI3apbOE+aIEIRSxRB0zjItH/8NunZPHc+RO
 qigT+uhEPqobAlS9MbkV9DB+OTZJUXo2KIbVpBJDCFMaLS7WrVUBcbFDFH6deDunUNJbzYJ6KxZ
 N354tTJVqnOD7aNATD0ytuI7U2bpfwb5MW1ocDnCpTawsnX+xhVbnyj4ECrs1LnazImL8MWYGj1
 LYa8xWV68xRdX7KD8s2atXhbyVlLmfb1CX3uDGBx1NgpAlY/b8f/l2oc4TgODhGVcGFCL8mNXvg
 pRklTrzBmghoC2JgYCGxFih0XUsyPc59Yb2m5B5DGb4YpMxdAepcxjRx4D8A7hEdW2mXwoiGPJi
 5biGW21aPiixDqJpkisCNmfvGfkj15k3lFYd29K/yEqFkAY8Dcs1XvnrjeDbKE/gG3Ml3vxCf+a
 SsPa0ySIzwaEHDiYNKCqqkV+HU3LirAOWJQl5ALOer98eV2rE1QRDR0xPV
X-Received: by 2002:a05:6402:4283:b0:69c:6547:518b with SMTP id
 4fb4d7f45d1cf-6a3644ed12amr2220408a12.12.1786462940709; 
 Tue, 11 Aug 2026 08:42:20 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362e34d4bsm841128a12.12.2026.08.11.08.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:42:20 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 3/4] block: remember the writability a reopen starts from
Date: Tue, 11 Aug 2026 17:42:12 +0200
Message-ID: <20260811154213.184947-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154213.184947-1-den@openvz.org>
References: <20260811154213.184947-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=den@openvz.org; helo=mail-ed1-x535.google.com
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

bdrv_reopen_commit() updates bs->open_flags, so by the time
.bdrv_reopen_commit_post() runs a driver can no longer tell whether
the node has just become writable or was writable all along. Only the
transition is worth reacting to.

Record the value while the queue is built, next to the other
pre-reopen state BDRVReopenState already keeps.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
---
 block.c                      | 1 +
 include/block/block-common.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block.c b/block.c
index 99ed06f8ca..c50d9474fc 100644
--- a/block.c
+++ b/block.c
@@ -4473,6 +4473,7 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
     bs_entry->state.options = options;
     bs_entry->state.explicit_options = explicit_options;
     bs_entry->state.flags = flags;
+    bs_entry->state.was_writable = bdrv_is_writable(bs);
 
     /*
      * If keep_old_opts is false then it means that unspecified
diff --git a/include/block/block-common.h b/include/block/block-common.h
index 895ea17541..f64b2d6f35 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -360,6 +360,7 @@ typedef struct BDRVReopenState {
     int flags;
     BlockdevDetectZeroesOptions detect_zeroes;
     bool backing_missing;
+    bool was_writable; /* bs->open_flags is updated on commit */
     BlockDriverState *old_backing_bs; /* keep pointer for permissions update */
     BlockDriverState *old_file_bs; /* keep pointer for permissions update */
     QDict *options;
-- 
2.53.0


