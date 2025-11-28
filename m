Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71B4CFD2F6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 01:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOnDK-0004vU-MH; Thu, 27 Nov 2025 20:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vOnBm-0004KS-4Y
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 20:22:22 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vOnBj-0001VJ-99
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 20:22:21 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-297d4a56f97so19092905ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 17:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764292927; x=1764897727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=jAiB9Y3gcNisBSU2IZK22fMa9/YvRNQa7f36VDVfsK8=;
 b=k2zTZI/yiyLbZWV0Vp43kO22koyqwiZh4zSxylRb52BdvVEZyrKwLIsWmfnBW/V67B
 BGaoQH6lUWc0Q/qv1QqpfBboXK1YXypBhL+kplvAyJm15sreAOsL3iMCKyu0GA6NkZoY
 FGCovvhuTpfc7+jqvtA50vuRnRq3zSZKAM2gTghklL9n5CBn/oC27j8IXESSrnh8kRPv
 MDLyu/fR4ItMb9fH3m80SrrP2FGLwu1qYMIAZJw5PjeeeWPlDvPwMsl/OlBy0+/WdzeA
 chBgyXQjj3KfObvwdYMBnNjc9cTbunKqXdyRnyoDbENkU5mL8xDSDgRykLNjrJr5juvg
 /hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764292927; x=1764897727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAiB9Y3gcNisBSU2IZK22fMa9/YvRNQa7f36VDVfsK8=;
 b=h9VIsvCEttX6oerDKu3uaeFheaQvMCuKaJY3wPRa20CIKPZrNH/DA6dGnCOHZGO45L
 5xqUPHahZbTevW7Xa4XMkuQ0NktecnVG6NB4Z8JoeBYuJUz7IjoP/bWOuykdb5kYuBky
 KsSeU7volntHo0xqOdgbGPIry4yo0O4ofIlfB8RBZXdMADhzep7GqclR1fop1lA6Eiwq
 041P+3hXq8nx9hEhzcFoCXldFITdhYlv67Cwxr+3/w/pLYVfkU8O3p4HeiJqd3UqFwba
 iJHNKbQQY9cFGs6FNwbQG//rnekEu60M9y5Tp8IbbFzxjqI0zkiazSCZ7OLpKOipGbSk
 XNUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWxz4QRS/Pijns27S7y+g5qWsnSXUMKq2O/ozMGQNmjCjG73rFaind481DZ5dNGjkAIkWsjqiePcYl@nongnu.org
X-Gm-Message-State: AOJu0YzeX6xsqTvv9q+9HYsyiytpNUG8ozW4VLHjqW8eFRFWHa1R/gmL
 V09e4Pg7SOGrQvt/KoZcYw/XUBYZhhFdsyERC/ItjMRkYrC2Dg6LeOV5
X-Gm-Gg: ASbGnctn9wvWHx/iMequPsBib7ngr8X9f9B5YdiWcx48SvAPLV554D4fpQA74sKmjbB
 ex+O44oyAg2aat7a8mL4qoxYBlOvuhxemACxkrzxrqBLbm8FPfkrRjk9p2W02hPs5OVykVaKCfB
 SoU5UY3whpVvw+qA8Yt4TdmGBP65EzFZBqXUziCJiL/eX/+wKoeYKnvviGTvVP6wFpJRxvs1E79
 CPnlzvekaFSJ6RGd6UiD1/ABoTAjHiik3M/D7P0MtoFmRoWDFJHu7g4pmyOmTudlehXI7Ls+zK7
 faAGxWnFF4a1X2Gv5qbtvS36BON6rMYeNXH108LynogyYdjhjL3CHRzvSLp3YwDxV4FN4yZrbf4
 vnWE6xmXLTa2iTfrJ8My0ceo/K8UphR+jJWIJZMRR/xA4Xqdaj5ScbiyU5ANUrJ4PRRNq6tkFrW
 Nzgkngm0OyzNYxgOTFO4/WdLMPRvBx/d0n6A46W19/yR/7n2ic4gxViJQ=
X-Google-Smtp-Source: AGHT+IGpMQ8zkvP5S6EAUEufQzOssZ5kAxjnSnp7oY6ciPqhmYuz8jjWfG/hCdceyE96nygMq/axXQ==
X-Received: by 2002:a17:903:46c8:b0:24c:965a:f94d with SMTP id
 d9443c01a7336-29b6c699252mr276782005ad.46.1764292927363; 
 Thu, 27 Nov 2025 17:22:07 -0800 (PST)
Received: from donnager-debian.. (115-64-72-154.static.tpgi.com.au.
 [115.64.72.154]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bce44285bsm28196685ad.26.2025.11.27.17.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 17:22:06 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: aik@ozlabs.ru, andrew@aj.id.au, benh@kernel.crashing.org, clg@kaod.org,
 danielhb413@gmail.com, groug@kaod.org, sjitindarsingh@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH] gitdm: Update IBM map
Date: Fri, 28 Nov 2025 11:51:50 +1030
Message-ID: <20251128012151.711182-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Nov 2025 20:23:57 -0500
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

A number of us have moved on from IBM.

 * Alexey moved to AMD in 2022.
 * Andrew moved to Code Construct in 2023.
 * Ben moved to Amazon in 2019.
 * Cedric moved to Redhat.
 * Daniel moved to Ventana in 2024.
 * Greg moved to Redhat.
 * Joel moved to Tenstorrent in 2025.
 * Suraj moved to Amazon in 2019

Most have either stopped working on QEMU or swtiched to corp addresses.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 contrib/gitdm/group-map-ibm | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
index 24d8dc1b8657..39c53a42ca1b 100644
--- a/contrib/gitdm/group-map-ibm
+++ b/contrib/gitdm/group-map-ibm
@@ -2,14 +2,6 @@
 # Some IBM contributors submit via another domain
 #
 
-aik@ozlabs.ru
-andrew@aj.id.au
-benh@kernel.crashing.org
-clg@kaod.org
-danielhb413@gmail.com
-groug@kaod.org
 jcfaracco@gmail.com
-joel@jms.id.au
-sjitindarsingh@gmail.com
 tommusta@gmail.com
 idan.horowitz@gmail.com
-- 
2.47.3


