Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E46CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIs2V-0000EZ-8R; Tue, 11 Nov 2025 12:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIs00-0005rt-6l
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:44 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzt-0003ze-Be
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:43 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6406f3dcc66so7328998a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 09:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762881456; x=1763486256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fTw1tbKCxfSYtSshvI7Ey8m20SzjiVCQ9bgtYepDy4=;
 b=jnmfODHKfIcJAN8d0GRiW0Aqif6kGvgiVxmtFGAArqrjRNHxflWr8WIodeFaJIyKTm
 TeaHwx+/80IPWZsY5EUSN72CfLzI2frus4lDBubgRhqZ7KTL3Wki/fqasj0Hxr1Je2Gc
 Bk7JpE9A6wmAHlAZUiQglNHBFSMg86rhnL0XdqB/coaSts0AM25iZeJXcaUDYXTWdC2t
 DWFFDIZ3Im9XuN2Z2sSSjnRn0xNMPN0FkL2Foien1AxCnp/WLCTWgEfcf6kg5Mq26l+0
 HGpastFPhq16o/3lVwdc5FtE7jHNVJLdrKz4soGAZhFFyVgppeqNZA9zEUgK6WLF4Vlk
 l1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762881456; x=1763486256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6fTw1tbKCxfSYtSshvI7Ey8m20SzjiVCQ9bgtYepDy4=;
 b=PO3d5KM8v96vE9bA5wGjAtjhIj0rERzLflIvigEUDyKrQ9Kc37tixCEOjFww+9/Xut
 t+KIaF40OPKYFE++KUAJMR8bW8BnZB3FIa2UrAEF6f9SdwSU3FGV1VoTnwOfSCDriYcv
 MRomA8uw0UTb1UC9bOWB90DXhtQRp66/mEgSbsjyuCZH3RlM0EPrbOmRDpN4h++z5OiT
 +c9iNaacllz99Rra+0G468AXnFfedbnNzAegMXMMMDgxGrmji/nC1p9jgAqzAv5mmDMB
 T3wwdLNxWj9tR04UNdkquGXOZFhcjZNQdgLs6gAvds420tQjkD9oEl3zkKlF6eWeidR5
 cYzg==
X-Gm-Message-State: AOJu0YwwNK4mxi5IPNtl75/5J1cZV6SBh7/LjJj7yDzIneRzMlqH16AL
 dTioeYeFviZyHhdBideYlbNLzrykgi7YMcuAvCyIJQMJxpbptpSYNSOMHUO8vvy9UjY=
X-Gm-Gg: ASbGnctrzozo9pL/Mtw7M0U9VxolV0pMT00x4letA6qkXH6HW4mOudxVMPpD6Fy/cSk
 GJyKL/TJHPaka/8D4Zxqq1Ndn5xCFaEsVkKBN0yqqUp3gtlrmQKgTps1Y+1hH8QDvmbC5RFDLGx
 j/e+7Ti9nNU/LnKKbnwKDZ1+QVF/UrnLaifrc2HsjOail9LZfXRvUEZYJ0TlMEsVpNgwNH8OZ28
 a1BuaVj6OyNedfCz560RLWajTzVgLJ+uHjUHk5wjYD3pfxvlZPQWY323HqOR1BJXGLWztf+xFkx
 QcK4FUa5rUxMY7eEQoXVYMNY9n0kI3B94snoUmwsqkicOzvrFxoryTnSGvxWnNOVUhJrx58OWH4
 LrUC+YjvCK5ZGLsuBUdVOqw12oYl/b2Rs2u1nvZwr+n25Lh2sH870I1QYvhv7KHZceIjh0/YYX/
 Hc
X-Google-Smtp-Source: AGHT+IEIBJSo9FgSIMHiM7CQsZpHOl0WJofaTdHZ+a73Qle06jSr+jEjM5ZdvzkUWrmqxAA6DKq6Hg==
X-Received: by 2002:a17:907:60ce:b0:b71:88eb:e60c with SMTP id
 a640c23a62f3a-b72e05e686emr1169167566b.44.1762881455418; 
 Tue, 11 Nov 2025 09:17:35 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6411f862cd7sm13899498a12.30.2025.11.11.09.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 09:17:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F4A660804;
 Tue, 11 Nov 2025 17:17:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH 11/16] tests: move test_kvm to share.linaro.org
Date: Tue, 11 Nov 2025 17:17:18 +0000
Message-ID: <20251111171724.78201-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111171724.78201-1-alex.bennee@linaro.org>
References: <20251111171724.78201-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 tests/functional/aarch64/test_kvm.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index 9fb9286139f..c8351afc5ec 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -18,11 +18,8 @@
 
 class Aarch64VirtKVMTests(LinuxKernelTest):
 
-    ASSET_KVM_TEST_KERNEL = Asset(
-        'https://fileserver.linaro.org/s/HmjaxXXYHYSqbes/'
-        'download?path=%2F&files='
-        'image-with-kvm-tool-and-unit-tests.gz',
-        '34de4aaea90db5da42729e7d28b77f392c37a2f4da859f889a5234aaf0970696')
+    ASSET_KVM_TEST_KERNEL = Asset('https://share.linaro.org/downloadFile?id=Dt5pQbTe5RrxEii',
+                                  '34de4aaea90db5da42729e7d28b77f392c37a2f4da859f889a5234aaf0970696')
 
     # make it easier to detect successful return to shell
     PS1 = 'RES=[$?] # '
-- 
2.47.3


