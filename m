Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4053CC7114A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Jun 2025 00:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQbJ3-0007p5-3J; Sat, 14 Jun 2025 20:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uQbJ0-0007oi-Ut
 for qemu-devel@nongnu.org; Sat, 14 Jun 2025 20:33:03 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hasueng@gmail.com>) id 1uQbIy-0008Ez-CV
 for qemu-devel@nongnu.org; Sat, 14 Jun 2025 20:33:02 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b2700de85d0so146389a12.2
 for <qemu-devel@nongnu.org>; Sat, 14 Jun 2025 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749947579; x=1750552379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ew6FhwV7k+RCBqhhgmkMcyj1wtfFtnRN4ZJrEDhTzag=;
 b=mv3n6n8pS/4PoelusI9nFRIH5+/cHwUPNBUcVOPb4Elpsuz3gw8m7bInF6Fptcicwl
 3tb1Fhzjzg5yAja7E5zcU6j5IDmLNgRvZ8lxTCutHTR9WK9V9neXHloOInqUY+xCn+98
 e0h2Pe6dq/ZI8+WdeRNLYhC8y9+xbD6HyNR4O4ifxMsH5Bbyyme40yjdVS/nLhbKYlNo
 V6EniwodcY4gOSpGYtMN99kLPxq59z2yT2PK40HxVVjjKIp5qD792NgGYkB2b5fZvCgk
 aiGqO0Gb8xQCN8W0sFeDFVRqNbssiXp+kKbRYZFHHFeedg+HBmlJ9wzvsd7ew0e3cv/W
 5wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749947579; x=1750552379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ew6FhwV7k+RCBqhhgmkMcyj1wtfFtnRN4ZJrEDhTzag=;
 b=YGI7lJBTiShCJmTgk0WSIy1DwM/zjIapXHMmcPdYnK777tO7v12tSnrixx3vB3lSHY
 lFtXgW8bnw30l5xXZCe0or8pbnXWBYiHKgDC6/0dNMAw1JzxjIXFAkFHk1+gqzU52Z/+
 1zSHZek2Y5SSSQkLnQEi2GvZ7/xlZC/T65HGcFnGL+QhTrCBXc/HebRqF4+J6D9hj+se
 v+CPNfPNrb+zJF7U5QrlznRe388MPh9KXlXchEeT7jpyGUtmk7QitXeWSaCBdU0r4V08
 xXDKx1l+JejaM+Fl4rCMkQzdcu1AuxLigDTLi0VhiMR/8SLVu/3ZOMAgZqGbuRKMtDWd
 qI/A==
X-Gm-Message-State: AOJu0Yxh0MmKD6H/Q2FV8FsVy1vDR1XmiUPtrQLIe72RwQarIn9SVC+3
 54ptv1Xn4MXwITzesuOgsonPmegd7YSvC6CBPp1YwS5Q5qffVuWemfix9vFvDvThwvQ=
X-Gm-Gg: ASbGnctK164QhyzyakiYoxFCzXhyx7YFXZ4eLEPGRhqWwBCyMVPguMBVdxhUVyD0gCs
 6zNeoE9Uv+8Bq+rIIm68ZGsAHzPcompCihaX/0AyI14MHHW+6vuSJ8dScGov4oUU48i9W0LaGc/
 RUSFv0CnWhKKgmWVP3TwQJocCiU4WZKL6o30iJPB/VUTvFZ1PsFKABzciCbWpZZW7BufsKP9y5Z
 K7aExn/VylWiFkIt9TkYzcPsXcCWHZpKDcu4LXSsyAEb+bxrkUQupDo5Vl+b05kwik++J9pn/6z
 PHI02A+W85e4kMmpIUHrzt0rsbm9JWki91z0m1PC62HEkR4xAto6nRz5
X-Google-Smtp-Source: AGHT+IHqIvEKWgNs0W0GMLkINeTdcrAGw3sx4WZyLUpAdCd79Jk2QkPScJ/oYakI99LiOAGk1yJ7Yw==
X-Received: by 2002:a05:6a00:ac3:b0:736:89bd:ffb9 with SMTP id
 d2e1a72fcca58-7489cd5b5b2mr1992680b3a.0.1749947578565; 
 Sat, 14 Jun 2025 17:32:58 -0700 (PDT)
Received: from bong-com.. ([210.97.55.153]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7488ffed0c2sm3942803b3a.22.2025.06.14.17.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Jun 2025 17:32:58 -0700 (PDT)
From: Haseung Bong <hasueng@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, thuth@redhat.com,
 imp@bsdimp.com, kevans@freebsd.org, Haseung Bong <hasueng@gmail.com>
Subject: [PATCH v3] tests/vm: update openbsd image to 7.7
Date: Sun, 15 Jun 2025 09:32:49 +0900
Message-ID: <20250615003249.310160-1-hasueng@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=hasueng@gmail.com; helo=mail-pg1-x52e.google.com
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

Update tests/vm/openbsd to release 7.7

Signed-off-by: Haseung Bong <hasueng@gmail.com>
---
 tests/vm/openbsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 5e4f76f398..2ea86a01ba 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     arch = "x86_64"
 
-    link = "https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76.iso"
-    csum = "60cba8cb391b50bba8fa10fc768bd0529636f5345d82133c93e22c798d8e5269"
+    link = "https://cdn.openbsd.org/pub/OpenBSD/7.7/amd64/install77.iso"
+    csum = "da0106e39463f015524dca806f407c37a9bdd17e6dfffe533b06a2dd2edd8a27"
     size = "20G"
     pkgs = [
         # tools
-- 
2.43.0


