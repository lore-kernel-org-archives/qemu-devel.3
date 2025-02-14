Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54669C021A0
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 01:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tikup-0006bT-4U; Thu, 13 Feb 2025 20:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tikun-0006bH-2W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:54:49 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tikul-0004NW-Am
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:54:48 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220e989edb6so14517545ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 17:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739498085; x=1740102885;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9RC6MJMkMFddmaETe/J83cE8JOgsz6X2WCSfCIYCZQ=;
 b=PIAzLM4WLO0dG7s4KOPz8L6Qucw827qdZyYW9WlfNZ4jUyT7EzOyJ/Shuuo6m/k/8N
 vIFM5aac3J8OCnzMC5M7oMY56Bs079NZfL4gGV/eB6c4zemKttC4bdsYlp33gAm3JQAj
 ghUuICpspPnoFf7MEl6VUW319+KD1WcqfIYzT6oQYz2wI6YXRRahJpiGh24Lvb5gycT9
 jYV5vWmqS1Zo+bvCLbxbZfTe/5BZkodc9J8U5qOkgInJ6ueDaKsrmuaLoIBa1GnurLXE
 ZVzr9UYFu40jRs66kI8zXx8S7RLi5Sf0pmKaguzzLsfojIeOjF0wxeNUy1vw3PDjbvMz
 flEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739498085; x=1740102885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9RC6MJMkMFddmaETe/J83cE8JOgsz6X2WCSfCIYCZQ=;
 b=AG93knN83ASl2X8S2d5DgJMDhMhhYSJHb3VuoQ93dhN4g3S07wAMKeP9hKnTUSvjEg
 uw34GYVfzGRCb9HYQU8QQG2iUJ6PsDMQFDa5ja71OK1plX87CGcuF0mxRGJ8vOnFzOA3
 Bi0VCzC9Cx4/L+1vyqNoVpZbzO7xuHpNV3vD3NvdXH1WZnIOt98Sn7PxAFUGBfGVG1+1
 iPZtv1E3cPm7l0ODpnP8dzTDCxv/P3tgSH6zDfp5TQ75ggzY6GZV1fxlEwAtKyeOJJ6g
 LZOe0DqyfhYtWE/iTaNWrX+BDZNAx9CtP6NNzc69xCeZ1hhwPGm1Wk55HaL7Ftb7JBIT
 8ocQ==
X-Gm-Message-State: AOJu0Ywf72wQi1YC1sf3PmK/WVEtdzEFQnSS2LRPJI4L622OG4rvM4bj
 W1WFzO2UkEB2/aPRZmd2/bud4FyySlV7ckV36BPrzETu51Z//MRyGusQYj5HqlCmSd4PYLXkqmE
 BetQnPStF
X-Gm-Gg: ASbGncvjNHwpQP+bJ5HCJPd+y68BrIn6gwe9YjXtNjqNworzLkl/DtHhJRb3OQf0zsA
 yPaOdy3xO8tABRzwbZaE/HgDIsANtGZv8Hgl/gLhxrSH/96fCMrDEOwwo5xDDjFNpqyoxKPfHR9
 MFEnHN7ksxlwLLPbjLLeXasqp2bYs5TcMd5IMT/WYlazldPy8vnxE7fxvUnjG39il94udyFXxcw
 BehNS/Z9reYtuVP/kpH7gGNxC6PDoUrCmf3VSJE2E5/tdVntt3kLVqhzj/ArB8aXWoQh/Ev1oS1
 F2E0pgNfB4oGr8/Z0M4KdZEZFLG0qBDDAtXu71Q2
X-Google-Smtp-Source: AGHT+IGDuncs+s7Lnxw3U/Ztn+70I3oPVHtrCX7o9uswgNFjSa8XyUvknA4tgckxkiAdU2cx1I09TA==
X-Received: by 2002:a17:902:c952:b0:21f:85ee:f2df with SMTP id
 d9443c01a7336-220d1ed85famr97543505ad.15.1739498085351; 
 Thu, 13 Feb 2025 17:54:45 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d67fsm18831515ad.143.2025.02.13.17.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 17:54:45 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 2/4] guestperf: Nitpick the inconsistent parameters
Date: Fri, 14 Feb 2025 09:53:34 +0800
Message-Id: <c8e3768c0d21b47456ad80376ddee63122d60cf7.1739497707.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1739497707.git.yong.huang@smartx.com>
References: <cover.1739497707.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/migration-stress/guestperf/comparison.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/migration-stress/guestperf/comparison.py b/tests/migration-stress/guestperf/comparison.py
index 42cc0372d1..40e9d2eb1d 100644
--- a/tests/migration-stress/guestperf/comparison.py
+++ b/tests/migration-stress/guestperf/comparison.py
@@ -127,7 +127,7 @@ def __init__(self, name, scenarios):
     # varying numbers of channels
     Comparison("compr-multifd", scenarios = [
         Scenario("compr-multifd-channels-4",
-                 multifd=True, multifd_channels=2),
+                 multifd=True, multifd_channels=4),
         Scenario("compr-multifd-channels-8",
                  multifd=True, multifd_channels=8),
         Scenario("compr-multifd-channels-32",
-- 
2.27.0


