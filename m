Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95566C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 18:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCN3o-0003FR-5Z; Tue, 06 May 2025 14:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uCN0T-0006fZ-4e; Tue, 06 May 2025 14:27:10 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uCN0Q-0007fo-5o; Tue, 06 May 2025 14:27:04 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-548409cd2a8so6793010e87.3; 
 Tue, 06 May 2025 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746556017; x=1747160817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTjmb4CVzk7evFGnM7dnHZhUU6iWaPb1DdyvIUz9ueY=;
 b=P4nV0h2JXeXeQ4w/tpq2IqQimHgujH4TnH52IKIsR+hK/e9htkonXQtY4aJojcMreY
 BRA3SQCucOUpMhMILR0l4dxhPwULjUveVBScABD0DoxlQ1VeJPUyiv14dEowx4KuPTWK
 xOEplrJ+7QlccvRlnCzKf2nqa2Kx7FSyreUYdtbAIyXmwCG5Mk8W0GG/2WDi2nPDILfW
 Gee4Z+46ytlwcEPz9Mm3gAq0WB2E2gAGyC9E7ntJgrOCNP9k8njU7xjJj2k/PbwzjLGl
 c2nvem4oD0KuUrHJSy2q9x+FbLtikaaDT+fazlthVq656FjAXcdi3VT4MysYxZfFITgn
 rGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746556017; x=1747160817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZTjmb4CVzk7evFGnM7dnHZhUU6iWaPb1DdyvIUz9ueY=;
 b=kh7mPdwFf2/Hk9EjQ9JiZxLsRL+rKmv0WyKAIREqKkhsy+jnEtJtNnArKdGKzKCUZR
 bGamccfipvnphOgSwGbgcIolmpuwSrR4DYeoaz4Loy5/9Q26meguImVMsUdDX5NK7wU9
 vrRruXCxaq0qYEmraivND9aOsMbF0J5Fwmi0+WwA4nL0cjYhoDK+x3yGTkO4tIcWMbJM
 DsC/JryWXtrighs3mkRxwiffGPk8clWNPtCjAWZxJc8NL1ugEF9ZjQFPuvwFqTpXjbl7
 mRfjsjBhHgll6I7ER4Sc1JojPc0j16zuoWqcpe0Hnd2f8tFn0nHmNK7WVKVD82crZY2t
 LdcA==
X-Gm-Message-State: AOJu0Yz9AdXd4JCe5gDsoJDrQOxOCKZ6/FmkMbCAYlBR2I0UYOHJdA70
 5f4rzQqySYem4OGisJXgpB6wuEWdJoMh7WnAW5rdRtAi4pukxoywa6mJXoXjleM=
X-Gm-Gg: ASbGncv/+bi4uBE2Ab7gvO0kLaeIvg86nx577wE0Ese+YeV7Y6CRwIXkWNs8go0oEeR
 8mpfxbHc7tIt5hcCk8c6kytucVc/TgOQ5g+4vd+jrc9Qx3ksfE4y46gFwZGXPlnzhSOqtVtN7Ev
 8VRXQ+UCHTo4L9gFVKmgTeoI+S2myfzQ0y1DwkoltkL4bKR8TN7JxjGB4RNwJQZ/OVWk5/G9V/c
 bUys9iVOlziwCngG4KyjB2USdXqKgKPXJPHEVn17lTQu+DszbzxUYzEpq7z+zjTWkBFZUcpDdb4
 7M7y9fFAcp3SXGHCQDsFWZycdeEJT6QbEJFGl+vrkEi6BLbGqfviTuA2pMjop3DSNpl+JR/SlQN
 qYbnkVf5xUksF
X-Google-Smtp-Source: AGHT+IG0QNxm2H52AYImFQ9/85BOn3rOqRXdlPtH5VEXNMZVVE3v32Bclj57hFQ5Eqpo6lHWEzQxZQ==
X-Received: by 2002:a05:6512:ba8:b0:54a:f757:f8b3 with SMTP id
 2adb3069b0e04-54fb92a6b1fmr220316e87.0.1746556017245; 
 Tue, 06 May 2025 11:26:57 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-320290171e8sm21858681fa.27.2025.05.06.11.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 11:26:56 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org,
 paul@xen.org, alex.pentagrid@gmail.com, peter.maydell@linaro.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: [PULL v1 0/2] xen: mapcache: Fixes
Date: Tue,  6 May 2025 20:26:45 +0200
Message-ID: <20250506182647.302961-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2eab8:

  Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu into staging (2025-05-05 11:26:59 -0400)

are available in the Git repository at:

  https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2025-05-06.for-upstream

for you to fetch changes up to 88fb705600a3b612c571efc9f1a6aed923a18dcc:

  xen: mapcache: Split mapcache_grants by ro and rw (2025-05-06 18:39:44 +0200)

----------------------------------------------------------------
Edgars Xen queue

----------------------------------------------------------------
Aleksandr Partanen (1):
      xen: mapcache: Fix finding matching entry

Edgar E. Iglesias (1):
      xen: mapcache: Split mapcache_grants by ro and rw

 hw/xen/xen-mapcache.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

-- 
2.43.0


