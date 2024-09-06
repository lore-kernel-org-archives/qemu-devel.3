Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E374E6FE41
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdNK-0003MM-9B; Fri, 06 Sep 2024 14:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smdMo-0001gA-Hf
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:07:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smdMm-00056B-S3
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:07:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-371941bbfb0so1502997f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725646047; x=1726250847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkmnJaMxqtgMZowGKV1hTj0h4J0GCGj1CbJQcsCClRg=;
 b=KsLmXti8fyJrXj+A66NPNivXQteCB9ZHHfSLW63tLsvpPQ+HwJ/t+aYF0iblIl2aFE
 u4KooKxjDDBF7HgzhrKZ6glbXs9QYVakor9juslvT5EYSaBtGR3p1n6356s4wI0pOjKO
 LRP8RbodhHrWOYVfyHJ/DqQ2p6mdJxMUJQSpd4BpHR8i+pErkiebCkWQZ1ZMdSTvJ26I
 JBg7dIZFLXriqbV3qrqQyqtTxTqOiHhfT/Bpv3eE4WTzORYXRr5DegmnqP3oLsWbFbGr
 fNFO4x9Qb4sv+TRF8CuCp+8oTWbQNe7Vf+FTOzBd3culxwwDaYpH1S7ki970iU/0DIJC
 AfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725646047; x=1726250847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VkmnJaMxqtgMZowGKV1hTj0h4J0GCGj1CbJQcsCClRg=;
 b=ss99bzcU9u96nTus+cs1LZeKtepLYtBvspcyCUxyQu3We3whSYg7hDIZxfrgowZP2s
 nvY3GY89FqwOCwRxQKSJC5R7wGZJBI59uJ7x5BK7dSn7XTiEjESOF1vYtoVRqKB31loR
 z9jTWQ9hWOoc4nb0Z0uluNvaEN2ubN+nbDnFtTdiZmq5g8QykrxIJtWV5mD6E+UlCJ++
 SSye6tBRXmZDRpT2bKhvq8UBDjwgFs0VTF7ahm0r7/YCCKmrTHpQHqXeVnKeslVOM9hm
 MHVK6HfBt/lCV/hWRFWlrUdHA/IFofkwlxAtF39f3hp20NWOkanlPdDunqrxByLdzIoH
 DHfA==
X-Gm-Message-State: AOJu0YyeSS+zP0DKNjKvpY88m7GSPvNFMM+0D8WPFZOfKV4TCIAhHP5i
 wJlUti95efjEgn95mYDVvZg32JT7qwUoF6cNg2NkjznMrJrX1YvNbONS6XkVAZkWLRlYxYekrFb
 q
X-Google-Smtp-Source: AGHT+IFV4AU28HBXTQBYYX5rVec8epmE+aHNHf8s5Nl7e73Pl7CXi2ULj0OS0NoP4CHzQ4PnqR4cUA==
X-Received: by 2002:a05:6000:18c9:b0:374:b6b5:4688 with SMTP id
 ffacd0b85a97d-37892703ea9mr28876f8f.49.1725646046595; 
 Fri, 06 Sep 2024 11:07:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37891657a2csm441860f8f.95.2024.09.06.11.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 11:07:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] .gitlab-ci.d/crossbuilds.yml: Force 'make check' single
 threaded for cross-i686-tci
Date: Fri,  6 Sep 2024 19:07:23 +0100
Message-Id: <20240906180723.503855-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906180723.503855-1-peter.maydell@linaro.org>
References: <20240906180723.503855-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The cross-i686-tci CI job is persistently flaky with various tests
hitting timeouts.  One theory for why this is happening is that we're
running too many tests in parallel and so sometimes a test gets
starved of CPU and isn't able to complete within the timeout.

Set the MESON_TESTTHREADS environment variable to 1 for this job;
this will cause 'meson test' to run only one test at a time.

(Note that this relies on the change to meson2make that makes it
honour MESON_TESTTHREADS; otherwise it will have no effect.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Seems worth a try -- if this doesn't have an effect then
we can revert it, but we'll at least have determined what
the problem isn't...
---
 .gitlab-ci.d/crossbuilds.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index cb499e4ee0d..ca1db011b11 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -70,6 +70,9 @@ cross-i686-tci:
     ACCEL: tcg-interpreter
     EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
     MAKE_CHECK_ARGS: check check-tcg
+    # Force 'meson test' to run only one test at once, to
+    # see whether this reduces the flakiness of this CI job.
+    MESON_TESTTHREADS: 1
 
 cross-mipsel-system:
   extends: .cross_system_build_job
-- 
2.34.1


