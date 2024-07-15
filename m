Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5C5C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGk3-0003mO-9c; Mon, 15 Jul 2024 04:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjy-0003SX-Ke; Mon, 15 Jul 2024 04:07:23 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjv-00047o-UK; Mon, 15 Jul 2024 04:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721030840; x=1752566840;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AUweKSJwgobCBfsS0jl8OUFwzF71UTUB1h8wPvccVGE=;
 b=Ed/LFSUR98JZBOXPqgF+rWEHXU5JqjV9AJd3+sP5soadpNTChq0vGUg6
 /NnRC9lZCDucxefQtH85e+pzG1bkdKvFHrihMK5bLT/usmMsf7frvEoqI
 dCX2aLCzZ0ZeVHHSz0WgmzgXjXTfSBcNqnrqh6tWNI5JDB1dSvlwS/pCM
 yyrtS0CkwQrJPIgF59BXuQLJoTH8VLWRmq0ZwUTtniiOlfSYMyVnjJpMq
 zhQvDa9o0HxuvYzO4JmsAnRL114m4yKCcWmxpRh0Q6BGwGsL9Fbez2vOr
 B+8F8lML/OOLbNqFZQfFSbb5OpiPO0YCqGzMrgbBMHlpbH23dZ8cu9369 w==;
X-CSE-ConnectionGUID: R7RBiu2pS4e15JLVkKC29Q==
X-CSE-MsgGUID: 7G2RSkDnSgOwTyvdXCtfRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35935689"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35935689"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 01:06:48 -0700
X-CSE-ConnectionGUID: HX7aRI4/Sr6AHG25S6Fugg==
X-CSE-MsgGUID: e4veaGYOSp+tlQMQRI9OfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="49512601"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 01:06:46 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>
Subject: [PATCH 7/7] backends/rng-random: Get rid of qemu_open_old()
Date: Mon, 15 Jul 2024 16:21:55 +0800
Message-Id: <20240715082155.28771-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715082155.28771-1-zhao1.liu@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

For qemu_open_old(), osdep.h said:

> Don't introduce new usage of this function, prefer the following
> qemu_open/qemu_create that take an "Error **errp".

So replace qemu_open_old() with qemu_open(). And considering
rng_random_opened() will lose its obvious error handling case after
removing error_setg_file_open(), add comment to remind here.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 backends/rng-random.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/backends/rng-random.c b/backends/rng-random.c
index 80eb5be138ce..3cdb982533b5 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -75,10 +75,11 @@ static void rng_random_opened(RngBackend *b, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "filename", "a valid filename");
     } else {
-        s->fd = qemu_open_old(s->filename, O_RDONLY | O_NONBLOCK);
-        if (s->fd == -1) {
-            error_setg_file_open(errp, errno, s->filename);
-        }
+        /*
+         * Once the open fails, the error message is integrated into
+         * the *errp object by qemu_open().
+         */
+        s->fd = qemu_open(s->filename, O_RDONLY | O_NONBLOCK, errp);
     }
 }
 
-- 
2.34.1


