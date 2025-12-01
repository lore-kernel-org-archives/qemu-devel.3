Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83001D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 16:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ6TV-0003IG-Fe; Mon, 01 Dec 2025 11:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQ6TI-0003CH-AR
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 11:09:55 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQ6TF-00084h-Q3
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 11:09:51 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42e2e6aa22fso784125f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 08:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764605387; x=1765210187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cXZSWZVPXYYtfb9H/CJHQ3ZoTteMVQNNkIFtS3dLOP8=;
 b=f9ONL/IPrqVwdRoRJQtkQLIhj9E8WteqzN5rAeVD1cEFG2WyzDnp5cFBbiLSAYB4On
 WHv+Ozwz21pspB9SkMAAzQO60hwD+Sun2WWeTGBG2w5f0KzLVULwUsT0Ic2Jy/4w7s7S
 6fXYxD3ORWAIclAZHtVLsrAUkVgX1jORRPSbJAD+N4W+kiFlOGzOVvNSy88QSCnEBwp2
 ACPIqzIcGC4JpLLDM4MZZUNFA84pWuBZtnBxpcG97/iZVM1FsUDArtAJnTpNVYKjhxLr
 l1BjaIP8jjJ5g4Lwxm4Cyk8QUUFfPGT2HQsvM6XLc6BRqEibetUfu+nLqtC1RmhScv6a
 kCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605387; x=1765210187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cXZSWZVPXYYtfb9H/CJHQ3ZoTteMVQNNkIFtS3dLOP8=;
 b=EORej7tGc8nns73mdW6MMWlJd3iuhmzEDG8ZxlT2xXRX8BXUcnkghopGNSFoJXsGfr
 rSuNrMrqTr6hahHJP/FBwl5BzTB33S86mYONScB6xGplOqi+xNJMkkVhL/dG6QNj+CEv
 qRAhoV4cGBnjUrOJhDie4FADyAnq1SARFQ4Ef3bmmkBaonSbvLK15BfVH/fO9uXCzgW1
 4rtJqyTNwRdR8v+Le+9p0bTb0msN0ZIKOac0iZyzlcfv7GdE+Sr2uvOgrxEByIGhH81A
 M1xD3Qwo5rxJ5IpqKlKf+Ec9PgGjcrGr8FR9OOHbVkwo9wyTI9iGvDIvoqB7f8SiaJ/y
 ocDg==
X-Gm-Message-State: AOJu0YzEgBFyLDmdPRB38Lv9DRDEC7J9yHaw2IrdEClPk9DbAQglcWIu
 Y767UzqC9BL8jtGuiMV5fZKyk4REjnK0fCtE5DlbEkz+oGU79sAohl0Fcr3aLV5tCScbk5Y4XOp
 7r3au
X-Gm-Gg: ASbGncu5DSjd6CsafsSuLHgvHTvSiAK/vvxPr2RfuUuS13E4L4tLN54DVlltQ3AevIg
 qteuP6lm4IqS0n0nCKTzOCxrz+DFyeo8gshZKO2umHUd1hvYYIVPndh1SwBOiw8vHKcHxh/B/Mk
 ChayhPmT9NyhNSZqTTVIvxFNNAiPCB106hHEoSAFzM5DwobJzjmDX546/gVUoYXilS39Bwr7hC6
 wfBq+Ethd5NN3RZZusi3FTF+zkyCME9SBTsj/eGyRWvHFKHbhmIYJ+HElRXxah20a5S/1lrU5tF
 ufw2le5p/a5g4tJqZZeotvBWStHn3PzdJFop7sMR0NDDiW27ARLe7Df57vHwDPnzZxzVA1puXV0
 DVVZSLptuaWZ70941O1p7Y3ae15CBzSgwWRKbLk0EDVCmlnrZF15fPhqX3WzOQp+HqcBqMsjRHE
 YcoMV792TS2lgZWzFJ
X-Google-Smtp-Source: AGHT+IGR6qVTCma6m588faZMQJMGXhWv2t/2QnUz2GHo01Q9OjzIAugivouFGHDInrLb4RiewT/RBQ==
X-Received: by 2002:a05:6000:2886:b0:42b:4177:7136 with SMTP id
 ffacd0b85a97d-42e0f3445ffmr25475932f8f.32.1764605387354; 
 Mon, 01 Dec 2025 08:09:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d618csm26682796f8f.14.2025.12.01.08.09.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:09:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] docs/devel: Update URL for make-pullreq script
Date: Mon,  1 Dec 2025 16:09:43 +0000
Message-ID: <20251201160943.1342099-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201160943.1342099-1-peter.maydell@linaro.org>
References: <20251201160943.1342099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In the submitting-a-pull-request docs, we have a link to the
make-pullreq script which might be useful for maintainers.  The
canonical git repo for this script has moved; update the link.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20251125164511.255550-1-peter.maydell@linaro.org
---
 docs/devel/submitting-a-pull-request.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/submitting-a-pull-request.rst b/docs/devel/submitting-a-pull-request.rst
index a4cd7ebbb6a..e7d00808782 100644
--- a/docs/devel/submitting-a-pull-request.rst
+++ b/docs/devel/submitting-a-pull-request.rst
@@ -67,7 +67,7 @@ subject tag is "PULL SUBSYSTEM s390/block/whatever" rather than just
 pull requests that should be applied to master.
 
 You might be interested in the `make-pullreq
-<https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/make-pullreq>`__
+<https://gitlab.com/pm215/misc-scripts/-/blob/master/make-pullreq>`__
 script which automates some of this process for you and includes a few
 sanity checks. Note that you must edit it to configure it suitably for
 your local situation!
-- 
2.43.0


