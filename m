Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8DBEE0211
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soH7v-0000Ws-Gr; Wed, 11 Sep 2024 02:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7s-0000Vg-Vk
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7q-0004P3-3R
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d60e23b33so388701766b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726037208; x=1726642008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8ZryqeSlz/ExYUX8ugeGYyDWimNUfnxyhhGDZ+/McA=;
 b=aCCEjJxbIHb6G/jYQQfnSzSKIg2HziMbMVX1b3HZpy2DeEDGmT8YMCF8HUHhmUXPjQ
 QCLFxWaxH5k7W8H3qWPkJpoe36/CuAOA5EpFZw4y16M70U/roBZNFiX16ax9kB/++seW
 yIyHfg3PcPr271vXrKiWSh9/S7/FKg+Ih096LXCQRUH+LZm6yH/mh47bGurmTNHY48Hd
 dPXOFVeW4J6pCm7HR1v/Y1pEgnPOp7zxzKDa5cGr5DobZE/IPL+MGqc3kgc8VVB2p1JH
 h+J8WxFGmZnWIRAJXV5svE5iY100JpV2jMMmgeLxS9KwqXG7oIUAAhXLZD+iLfFbEA1/
 9DpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726037208; x=1726642008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/8ZryqeSlz/ExYUX8ugeGYyDWimNUfnxyhhGDZ+/McA=;
 b=PCC6h/aYBUXaqULvg750cGCqRm4qmc1NwADLeAhotE2lyN4kgbY5tXm49vTAsLIsJv
 7wq3E/xf1HJJpJEv5p3t3D4fcglz52R7st7UIj/FQJZ2+a/Jd+03fELQKbLPPjKNWuqR
 tz5VBLHtT0MNAXmQ9Ra0wYfjoTC/4UXEC8jCXc5lyzTDkUlS7+nfkyZbllw576fo3Tcl
 vG1VOhfw5Bex3art87WdqOcb5UqeB2T31r9uWMT+zvaCan8OX3sO5CRZsHDVREq1Eyqg
 Jdr3iCAIcHdujE0K4ZC+3gGASM37rlsBzkgIepPCaACPOPe1iKcf/eTVkIS64TcosCa9
 Hq+Q==
X-Gm-Message-State: AOJu0YwXEFJ8q75h7460Im7CQk4VZUY6BFd3Z7J4VvznJQ4Brj55vvTp
 wfyy15AE1wyCxo0FtYaeoTJiRO7keuaKAvQqqH4WtZGHUFOKXi5y8yFsnfGouAo=
X-Google-Smtp-Source: AGHT+IEnG6jVJueYtOM7KpQLN3Gv90dgawFsH04FuWAj1U7Xvt6AQMLoUH3fLsLCoyQ81mIt621gDg==
X-Received: by 2002:a17:907:7245:b0:a8a:926a:d02a with SMTP id
 a640c23a62f3a-a8ffadc78d1mr276012166b.49.1726037207804; 
 Tue, 10 Sep 2024 23:46:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c62541sm580541466b.111.2024.09.10.23.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:46:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6AA245FA08;
 Wed, 11 Sep 2024 07:46:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/10] docs/devel: fix duplicate line
Date: Wed, 11 Sep 2024 07:46:39 +0100
Message-Id: <20240911064645.357592-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240911064645.357592-1-alex.bennee@linaro.org>
References: <20240911064645.357592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

I guess the same change came in via two patch series. Remove the
repetition.

Fixes: 2a851fca9f (docs/devel: remind developers to run CI container pipeline when updating images)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240910173900.4154726-5-alex.bennee@linaro.org>

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index e9921a4b10..09725e8ea9 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -500,12 +500,6 @@ first to contribute the mapping to the ``libvirt-ci`` project:
    `CI <https://www.qemu.org/docs/master/devel/ci.html>`__ documentation
    page on how to trigger gitlab CI pipelines on your change.
 
- * Please also trigger gitlab container generation pipelines on your change
-   for as many OS distros as practical to make sure that there are no
-   obvious breakages when adding the new pre-requisite. Please see
-   `CI <https://www.qemu.org/docs/master/devel/ci.html>`__ documentation
-   page on how to trigger gitlab CI pipelines on your change.
-
 For enterprise distros that default to old, end-of-life versions of the
 Python runtime, QEMU uses a separate set of mappings that work with more
 recent versions.  These can be found in ``tests/lcitool/mappings.yml``.
-- 
2.39.2


