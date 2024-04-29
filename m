Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF953C19F53
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TIh-0002uC-Pf; Mon, 29 Apr 2024 11:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1s1TIg-0002u3-SE
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:52:18 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1s1TId-0004OP-04
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:52:18 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d8a2cbe1baso62153041fa.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1714405930; x=1715010730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5fPdKooV1Jc1JFMnukyBUwbZs99YjF6Kc3U9f3H43l8=;
 b=gLWIWplApUj2arGgR85i2TKyua7HmGFx3sXOszOogBODpxgKDpOx2ssFSXQ919iEeG
 xfoCjGh9ouAmBfrd+q3gF4Vagt9ajpRNGJgux4K+eM90NlDbKsCQl6AWB44zT94VO+tz
 bblI1wDlK0jCfXsd6+j+CB3OVd5dFRhOII9nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714405930; x=1715010730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fPdKooV1Jc1JFMnukyBUwbZs99YjF6Kc3U9f3H43l8=;
 b=ZhvUJ/6UISZ/S0aFri4/L5Rs4OWKxcsGSgPBSO8RMzK5Mrn5oeOvAOr5w+m6S42NHg
 FKhBagXz19/kkWkdGu5AJbx/ee5D9VMYw927cucsNfYtAXJVTbpjR+89w6ThMX8aNI+X
 F8CzbZ9rkP/AwQO2NuGZ1uehoLee2ASAHhQTS677vP1zx8gScQH+8EVgHDwGfWY5xP70
 OQLbidG0aKIwX8Iurr1r7OeHe4IUl4ZVVRAouSwzdItWQdqpIOiYiYElchEYjctTaV3I
 +NZ86QVlZAXymFSz6K45Hfm4sDdgjrgBNRtZ/ji8N5AF6xclsVlrjdkkNK1SKtpMn85/
 2YFw==
X-Gm-Message-State: AOJu0Yx9LXUltt/maxqe/GP6sSnOfuaUD4df+WcCZFRFwymhWsidF7L0
 /SA8M/rZKfgsjqHnQF6ieYWuiBzL1yJIEdBRIwq5Vol5wuTW4jfDhhLIC35QhRLf5lpXKarPK3L
 h
X-Google-Smtp-Source: AGHT+IE9NtJG3uklJTfQdM7Np/3CMaqJw48NigSHCbQWBaOwe5OJEf4nsb2gvtq5QBZz9X5+NKljlw==
X-Received: by 2002:a05:651c:23c:b0:2dd:3803:e1da with SMTP id
 z28-20020a05651c023c00b002dd3803e1damr8418008ljn.12.1714405930584; 
 Mon, 29 Apr 2024 08:52:10 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92320-cmbg19-2-0-cust35.5-4.cable.virginm.net. [82.13.64.36])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c511400b0041a49b10a13sm29861462wms.11.2024.04.29.08.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 08:52:10 -0700 (PDT)
From: Anthony PERARD <anthony.perard@citrix.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Anthony PERARD <anthony@xenproject.org>
Subject: [PATCH] MAINTAINERS: Update my email address
Date: Mon, 29 Apr 2024 16:49:38 +0100
Message-Id: <20240429154938.19340-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=anthony.perard@cloud.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Anthony PERARD <anthony.perard@citrix.com>

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 302b6fd00c..ea9672fc52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -532,7 +532,7 @@ Guest CPU Cores (Xen)
 ---------------------
 X86 Xen CPUs
 M: Stefano Stabellini <sstabellini@kernel.org>
-M: Anthony Perard <anthony.perard@citrix.com>
+M: Anthony PERARD <anthony@xenproject.org>
 M: Paul Durrant <paul@xen.org>
 L: xen-devel@lists.xenproject.org
 S: Supported
-- 
Anthony PERARD


