Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F8FC88E75
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 00:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6dOH-00071x-TC; Tue, 15 Sep 2026 20:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1x6dOG-00071k-G3
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 20:20:44 -0400
Received: from mail-pz2-x17.google.com ([2607:f8b0:4864:3b::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1x6dOE-0007vG-Va
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 20:20:44 -0400
Received: by mail-pz2-x17.google.com with SMTP id
 41be03b00d2f7-cc1cea48edcso257258a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 17:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789518041; x=1790122841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PXYtwTHnaHGmGuPdZD07fr4p1RgWffwiJHcJgMk0B/o=;
 b=kMf3CW/12pq4g8j/JWsazcpHBCC5rUk9Z4RU06BC0h7BpCsCI/fIfOqwsqqad+k0Jh
 uhyo+d70by5+32iZfJi/lc5OmDdS8xWP9BY4esj7Q0rt+Z0sCh3woE5hINbqSTeX1m/8
 vR6yTXbWZkg4SRbb85pSX/h2rOmrw9b7QY+pDfMgG6uMqp63sxAAaNVUxeKn95eMtEfE
 sMG//GorBteQsf7Bv4lPWuo/G6sUaWf0jbIWBThA+WSkILMl5Q4wLCT38zoZcWPQKbS0
 4TvYifPbHjJ7VA7YndMZ9cj/EYci+a6Q0cxfdx42c8u61LhL2t0VqktPB/2u+YfviGoj
 ocfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789518041; x=1790122841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PXYtwTHnaHGmGuPdZD07fr4p1RgWffwiJHcJgMk0B/o=;
 b=aRBWe1UmFOAt8qYcZSx9t2YWTPKxoScV7nwxMeA6FeH87pnfudMAEYwovSiZQ6Qn6U
 Ll/nDY8JM1y59384SkrT5nWwZ3zGqqp1iJxg4fq17oQkd3AtGDpE6zbZcxwgJ7uHDaiH
 hdQNiV1qenLUywP9Exvg8bltLFqYz3eWW/yUOIE9YMAKYBKicpIWX8v90uC86mrPs1AZ
 qWZ9nB4DiUSL5AkQn392ZWCIME0Yxk3KUPgJoYzgJfBBW1pzdbvGFH6v1vhjRYjqI/J8
 /Qi0GgYb8QmPxXfCexM2RRL03nga8L6MNgeheuvnO7J2uBi/CTHxYh+OkKv9X00siQCV
 GJWQ==
X-Gm-Message-State: AFuF++n+RSt4aiczcfGiIqyIyNk1GkQCcOvz/B28qJ60g6Szk20CGXE7
 TTrJBMr3JvPhck1Qq8wL3ImGipybIHbeamz5tDkEwMBiY5DNIXA3mOfwLsCIy6zJ
X-Gm-Gg: AYBFou3wpHV4c2LbSOp2Xlu16widuwMwle95it75pjX71Sv3IPYPnA0REyqOIcaNoQU
 BwoqtTcvMoHfSTgEFh8YylaSg4VfSqzHvZ1cNbYeGoG6o3T5kT76O9DhCvlG1t58dqWpAes11ux
 j1ye5bWsCgRGN6MQcSsNwk/PKfbM3A3YeAFdi4Lefw+6QXVhaoJENnh8putf1Xgef8MpB5LQc8b
 00HMJvHJSdlHZBPa5On5fF4KHtFCPpSQ73EZLn5wYug4a6S0Mk55WaOp0Uqcko0GK3K/sGgOpJo
 U8j5Zejude250RvcS8SWbKNGBJhx65tGB4ZAOSX190VC+hws9z6beKPLOlaRaEo2/OZojZyk4AU
 q7J0kBqlK+HPJtlnQiZcx/wr/w2wuMWrP6n1yoSOTNT9r3thYbp54T3Z43ypPkT6Fd3Ra8QhiQI
 6CyW5Y0Q9kh+sw7SDbRHW7RgHwKbLM3VfDK6rmK7wc/1LELAXBgY832Zk7vfitLTur1WMrPqjWt
 j7uGTOw4qldocXekZIcer2mZyws
X-Received: by 2002:a05:6a21:4a98:b0:3dd:5831:ef5c with SMTP id
 adf61e73a8af0-3dd5f5af371mr1422097637.17.1789518040876; 
 Tue, 15 Sep 2026 17:20:40 -0700 (PDT)
Received: from cxlqual.. ([220.120.90.131]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc50ab8ae01sm609027a12.18.2026.09.15.17.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 17:20:40 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: jic23@kernel.org, mst@redhat.com, junjie.cao@intel.com, dave@stgolabs.net,
 Anisa Su <anisa.su@samsung.com>
Subject: [PATCH] MAINTAINERS: Add Anisa Su as a reviewer for CXL
Date: Wed, 16 Sep 2026 09:21:28 +0900
Message-ID: <20260916002143.777233-1-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::17;
 envelope-from=anisa.su887@gmail.com; helo=mail-pz2-x17.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

I contributed the FMAPI DCD mailbox command support in hw/cxl and also
work on the Linux driver side, which is developed and tested against QEMU's
CXL emulation, so I would like to be Cc'd on incoming CXL changes to help
with review.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bf895732c..14412a6b4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3334,6 +3334,7 @@ F: docs/devel/migration/CPR.rst
 Compute Express Link
 M: Jonathan Cameron <jic23@kernel.org>
 R: Junjie Cao <junjie.cao@intel.com>
+R: Anisa Su <anisa.su@samsung.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
 F: hw/cxl/

base-commit: 302c2f2df4d8b2eec81c38ee5d5b04e8e6e40d31
-- 
2.43.0


