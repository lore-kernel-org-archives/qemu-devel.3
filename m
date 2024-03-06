Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927CDC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsSB-0007of-6Q; Wed, 06 Mar 2024 09:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS8-0007hS-Fx
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:04 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001TG-90
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:04 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412e6bdd454so22290275e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736042; x=1710340842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCuo1I1x614Ggqxx0hsNU8XUHD4jpmgy247WPP2wLWU=;
 b=NcU48xwdRRiXMLoD2tJMMa0kY3DKVPB7ZKEFUS06+mAnd0vW/bH0mcGPuiGiGj/22J
 3mOfCpi8Zai5EtLUptUCFRj/L51aYJXf30Bg5cdYDSQN2hVN8CfYgi9LC8/a8ATnhEtL
 tXdJVoq/f9u6RbUgRqtUmfQ0O7bKuykXOLgz4tgCuQdmGY2lvC2BJG7h/oBZENXHSysA
 7V5y60B6eg/LG+xfdEkN4W53ypgtpVY9j4ByBam5ov4635lF5fcpPKEYCwEXDKzrAhLU
 SJ+94ENY4qCr/aSZKMd7gwful9o++WjP1H7eU9Z+ZYbke7okKWS85z2mNlLBQlafhV84
 mcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736042; x=1710340842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCuo1I1x614Ggqxx0hsNU8XUHD4jpmgy247WPP2wLWU=;
 b=UacfjYcnm98jYlhhhu2KMHORbcjMWdzFVP+Gl/UJ0tBFV8M9wZ45ZEULWVvPLsp2k5
 NSDbhe5aTnr5ZusjZS7lxLYK904EJlFoKjY653WmHk36zMiSN7OGbTzAvP3Zo9hHs5aQ
 4cY8JcyrnvTa9nC55q/TyijtWsGGR26BNhKVfQv6Z0GiTna+UVIXVDEZMimuZT3vcXqF
 ZKiovmXyS47uYPRDXQCEaK3fm0RUvNCX5ItvWWQPTkOT/iCc6lsaMWzWyXS8eD6qwx7/
 LWpXeoZ3PXvj3NxKBd5OIoxzIolr/5lLRc3VhbJQj/bBpeqzsyDVsmcCNVI9IZhorNdY
 N0LA==
X-Gm-Message-State: AOJu0YwN1fp/YBXs2aPV82zmHF6+V1lvbkWzDB4s24fA6QMGKG6onFRK
 T32fAvGU+hBRAIfIqtcr33/0tINyEM5/DPw5YTIQ7DneC2KK2FIepTY45BB9z6s=
X-Google-Smtp-Source: AGHT+IFX992rEZfKIGjAhXN01fY6cGqE0XDulcv68CHJDttNHtmXYV7CasoPkStWHGBxsIJAtq+JvQ==
X-Received: by 2002:a5d:49ca:0:b0:33e:4750:2250 with SMTP id
 t10-20020a5d49ca000000b0033e47502250mr4489258wrs.62.1709736042452; 
 Wed, 06 Mar 2024 06:40:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bu16-20020a056000079000b0033dc3f3d689sm17930874wrb.93.2024.03.06.06.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A2B4B5F8A9;
 Wed,  6 Mar 2024 14:40:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/29] tests: bump QOS_PATH_MAX_ELEMENT_SIZE again
Date: Wed,  6 Mar 2024 14:40:13 +0000
Message-Id: <20240306144041.3787188-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The array is sized according to the maximum anticipated length of a
path on the graph. However, the worst case for a depth-first search is
to push all nodes on the graph. So it's not really LTO, it depends on
the ordering of the constructors.

Lets be more assertive raising QOS_PATH_MAX_ELEMENT_SIZE to make it go
away again.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1186 (again)
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-2-alex.bennee@linaro.org>

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


