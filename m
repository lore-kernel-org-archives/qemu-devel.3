Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E05ECA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENH5-0004S5-Qa; Wed, 07 Oct 2026 04:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJNH-0004Ly-7s
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:35:38 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJNC-0001yF-7R
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:35:23 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6afe8d3980aso1303961a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791347721; x=1791952521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wKcbZxFVNlLilCNRix49XjJCUS9fhra/dn6x/AnwPTA=;
 b=LtMp9IyU2nguv4wgqsRxJgRVoMOHR2CpYQE77Gn4DfeA/GuEUAP/l8cQNmKuIFM4S9
 oqf8f+sOfiXjml9HUKqP559DTKFsOiULREtFHPJREumha2VsOY9QGlbSfEzKckKuKCmC
 PTtVSSL2An5KVjIOvxvJqSUCeLJSTQ4Y3B3pp3ZNfZEW/AheVTbnh8FHWU4WmATFnTpy
 S3UyuiiofwmryM/y/hA/ncYnjFutRls0/6DHamQ4pX3XtafPpAQVIWW8kpoFGHCQS3Hc
 RUe58U5/Q7Hrp3bLGGpMahPcvNKYzWxYzpKxFNs4yMgDPkQz669r8NTmUDzOOt61vPqw
 TumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791347721; x=1791952521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wKcbZxFVNlLilCNRix49XjJCUS9fhra/dn6x/AnwPTA=;
 b=r+iZ8BqOph2uOgv5Cks1pUPql7uQkFKyhh2jC8//ZRbpzk250U0SKpdldAIUishUXo
 gkdfrhDQka3XIK8hll5vq6jiQg5oSKKVHOp21yT8p75Xlqwi1Mw/PliREI3Kxeo19bwj
 d+vaHhX43t2wMaUuXZFpXPwwGdpfcQlL9ulRaPduiMhGe491f06RIMVti0yneW7ufmup
 o9QG2C9N8idIyiDKUpKatZgo+YE+EetLAA0hFWI7/Zr/QWnYJsSdlbNhX/YoPqTVTQbG
 f+gNV+i1S97oKTfP39j9qpO38Jn9Kcz/yc5XrfrpK/x/jKuy3fKjHfBgo/Vei8J4h9XE
 ybHg==
X-Gm-Message-State: AFq9FYIZF0nZqblDqJlanJ6bZ+117Cs1F7wPwyRqHgO1oNo6OZmW2UAJ
 KYGWCdSZ7wwxCaWhnqQ1zy9PG30wg+lI8v+E3WrsNRQ3MxAtqvNSWL5Bpx/gjA==
X-Gm-Gg: AYBFou1JduQn6oaX//94HMrcngAbjCNSvS/MUvc35j1ela5WWDmT5Oq2F+jCE+pJ6Tk
 3Kjggo48BY0Qoyj0cpAA8UvETlOXXfrNItD6R9ixHdutYHsV1VF3kkpkH9PyXz6Kwr2XuwL/lra
 6oXV/CsENSjowofZVR6hLeCk+Wi5a0wfyieS64goNVzIUAKhwyqq/yWHijqHIqLEDfHNFj4tm+l
 OCvyEo11SLRInGeE3WW9Yi13kWh60XcxmmVJVryLjbBGsne7wnrmLAgYq5n8lE7V6QMdbGlluaQ
 zgv2OSAwC7b/AsyNsPsiGWiznnRKsPM3J0SUCCLvX1yjeAllM9ITpenXXT5WZpSHJ9VHf6ZOX9X
 9y4kO4Vv8yZqDp1Q8KBxgGtWWqKwE1fpxlEqvi8Tgt214mYksmRKHwc0T+NdkrVKin1oUryFlAB
 /PCqvXr0kkAK5sJy9ONcIn71SGtYqZxk5uDdQJAHTYAgrS8lvyhUYAF+RGVR9LWQzh5FFna6NXb
 g67CBD5IM2cbG+vh+Jk9xyQuuRET6fKtncvNI/GzJsCP3yl
X-Received: by 2002:a05:6000:4b0d:b0:487:27f9:82f with SMTP id
 ffacd0b85a97d-48c6d1a2624mr1369239f8f.36.1791279911635; 
 Tue, 06 Oct 2026 02:45:11 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6faa93fbsm433426f8f.16.2026.10.06.02.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:45:11 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 7/8] hw/sd/sd: Retype state attribute to SDCardStates
Date: Tue,  6 Oct 2026 11:44:46 +0200
Message-ID: <20261006094447.43491-8-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006094447.43491-1-shentey@gmail.com>
References: <20261006094447.43491-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

An enumeration is checked by the compiler, so is more robust. It also
helps auto-completion, so is more ergonomic. Change the state attribute
to be of type enum SDCardStates rather than int32_t to achieve both.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 03c51b0291..6295e7a942 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -172,7 +172,7 @@ struct SDState {
 
     /* Runtime changeables */
 
-    int32_t state;    /* current card state, one of SDCardStates */
+    enum SDCardStates state; /* current card state */
     uint32_t vhs;
     bool wp_switch;
     unsigned long *wp_group_bmap;
-- 
2.56.0


