Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5D0EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4pm-0005Nw-GI; Tue, 10 Sep 2024 13:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pX-0004iH-MG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:08 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pV-0004ZD-Oo
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:07 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c26852af8fso7610616a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725989944; x=1726594744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDAMP75hxzkvSxh1nZDBhj94P3LXNhJD9uwli3Aulp8=;
 b=nn7UI0N5tnIt8ydaqDPf9TdOxJeqj3v6JvWRNlbZhD2h5T8I9u4axM0yRSuz28lTyC
 ODGbDxiSaJtSm0HwS1VBw07d7dr7vS12OBD0Xx1gNphUCMk1WRZkmcZwwuuGaadpOXTg
 Gof81od4GIvg/f6zRKjcn3csE1P0pAU2DAcJNLgCmjsKfEwJNAJ0A9cLr8C1XuawXwSx
 jdqmZFhpTfuoW0bt6u1zaki8pKj5Sd++pE0s77H1bY5NhRniEKADrE4VXxgn4pQtTO3U
 YAFHagACXx7uOdNem2xw8NVs8WOMKgyk+p23Siw8OK48CJjmaY9BF2PAaUKPrfCnCIIj
 Au7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989944; x=1726594744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDAMP75hxzkvSxh1nZDBhj94P3LXNhJD9uwli3Aulp8=;
 b=Tecchyt2K4Sp47SXXeaz2fWxfgZMhRnszNNIS1onTLSnJ1uzb5ehlVwMEuB9fJ+F+B
 7hM322svyOPYNIcyCojXQC25Yirb4l8BItz9Qin69pUE+ztGUn1o1pz/Nfrs2Ks0ssNX
 9nfLaI9bI0t4oJ6QrjAU9enmNOvWjbz91okLhXmfMIkt7gPknHI1dpeBSmdHQ2XCvrzT
 5wMzsAQ2j1prJO365cmbroUrEDmPSxDE3YFkEL0bQhMLU28BlcPrJ+Oozpt3oLKB0sbt
 wI7C2w1FFDPyXBddOMk+DKHh0pKdkH8MMPK6MxFNWFxI5eHyYX9kUrb5eaCByBCqwA+C
 FafA==
X-Gm-Message-State: AOJu0YzCdN+e2qmfpoPTY5hSqyWZ8cfqv4c5zyi68MolSKmpb5Cb9Ki9
 CnYLiUh64vzrS+Yt4hiyRWjC6foRlHGQnmjEWAiEM2PaKPK/pQk43YLLbX6iuV0=
X-Google-Smtp-Source: AGHT+IG5eom9WBJpGw3ncMWrCxqN2raB7ElUMFe30Zp8kmSx3WAkK5FfD3K7tSVj1bQxhju1fEeSVg==
X-Received: by 2002:a05:6402:34c4:b0:5c2:6083:6256 with SMTP id
 4fb4d7f45d1cf-5c3e962d91dmr10904004a12.10.1725989943384; 
 Tue, 10 Sep 2024 10:39:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46819sm4453099a12.31.2024.09.10.10.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:39:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C93A85F9CC;
 Tue, 10 Sep 2024 18:39:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 04/10] docs/devel: fix duplicate line
Date: Tue, 10 Sep 2024 18:38:54 +0100
Message-Id: <20240910173900.4154726-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910173900.4154726-1-alex.bennee@linaro.org>
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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
Message-Id: <20240910140733.4007719-4-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing/main.rst | 6 ------
 1 file changed, 6 deletions(-)

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


