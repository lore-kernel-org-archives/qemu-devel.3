Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF62CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFVr-0005ia-Eu; Mon, 04 Mar 2024 16:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhFVp-0005i7-EI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:06:17 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhFVn-0005fc-Lf
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:06:17 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33da51fd636so2496135f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 13:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709586372; x=1710191172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/W0nDOLB2pGVOvo6YJlAYsR5x71KypiKlMd0+OAbv9o=;
 b=d7QAdl7+ynBjxyBr+FC/TDdIwcYJ5pkkR15p5Azkp/uRxYoLcLKhSqmYU9iqJ6oJVW
 d0xjOQajnXZCPDLphj9elVdakmPPKA1mB4D29HFpwsIc+RrM9gLWDB/4/c8cMIs9spz5
 rjr3buzq1JlRhjV3uk72Xh4XTpDBvdgD+WKu+FdlKEkPWMgEvxGPztxOZTquXjLxBibC
 p2OExL9UGUxj1KJMAUuP8+o963GVHWNH7YhF9wNDs01fevt5dZYNn3X/uIBCjM3Fn2hc
 pf+ewERf0T5AYUIs0WRGsWvv6Bu7WriQa8Sg0kPZPAsp4DOD+SQiu5iHPtRZ9dhUiSxi
 cvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709586372; x=1710191172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/W0nDOLB2pGVOvo6YJlAYsR5x71KypiKlMd0+OAbv9o=;
 b=vNH5iET+sAf5230VgZe6nIUFuOeT9AWwO+Y8aKSucq3wE2CgI/MH/NBZ1I9a9GWzbf
 QBk8gQp55B7o7DxmO2Q4hWNfkIsjFAm7rquuLnqx0QGVNxk13ijJ6ODrGq72dx+2PSfX
 qKeVM7K8GfLuaEyGxhVCf0Ch//Pex8KQcDxNIRevTlGDzGKdJuLqIlNSewGiE6exvkLf
 NipoIqALpMUfhu2RODYzOfjDeoEwgtx8ragk99gHzwfxwVDZLcmpxlcswDoTWl2v/kIM
 xS1OnZWUHWMwDcwgBIcKzgcdS5LsWoxwo4kDSnT3alcOQrmpGffGe1jrABK53a41iQ5Q
 hBPg==
X-Gm-Message-State: AOJu0YxLcQd9p9EypZyVJNJ1PHgbIP/X7C5e3udwBBHGTPCB8BwnU884
 qLSNbfIpW3FsVUqd2wq0KL3WEZyhll5535LhuIBRtYM6bqFLR2X90pFnnd3vHU0=
X-Google-Smtp-Source: AGHT+IG2mrNsCzreSCaNMIDIwdo02ypgFKCk2OZW3ZrpCEGf0UqG8Uz0qgArk4wcalm3qj7FRvONJw==
X-Received: by 2002:adf:f887:0:b0:33e:1c90:9b32 with SMTP id
 u7-20020adff887000000b0033e1c909b32mr7449270wrp.35.1709586372005; 
 Mon, 04 Mar 2024 13:06:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g25-20020adfa499000000b0033d6c928a95sm13185234wrb.63.2024.03.04.13.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 13:06:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 11E365F8BB;
 Mon,  4 Mar 2024 21:06:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] tests: bump QOS_PATH_MAX_ELEMENT_SIZE again
Date: Mon,  4 Mar 2024 19:37:02 +0000
Message-Id: <20240304193702.3195255-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We "fixed" a bug with LTO builds with 100c459f194 (tests/qtest: bump
up QOS_PATH_MAX_ELEMENT_SIZE) but it seems it has triggered again.
Lets be more assertive raising QOS_PATH_MAX_ELEMENT_SIZE to make it go
away again.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1186 (again)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/libqos/qgraph.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/qgraph.h b/tests/qtest/libqos/qgraph.h
index 287022a67c1..1b5de02e7be 100644
--- a/tests/qtest/libqos/qgraph.h
+++ b/tests/qtest/libqos/qgraph.h
@@ -24,7 +24,7 @@
 #include "libqos-malloc.h"
 
 /* maximum path length */
-#define QOS_PATH_MAX_ELEMENT_SIZE 64
+#define QOS_PATH_MAX_ELEMENT_SIZE 128
 
 typedef struct QOSGraphObject QOSGraphObject;
 typedef struct QOSGraphNode QOSGraphNode;
-- 
2.39.2


