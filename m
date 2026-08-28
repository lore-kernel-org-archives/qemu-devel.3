Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33A1C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvSy-0007pU-N3; Fri, 28 Aug 2026 08:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSw-0007oV-Hc
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSt-0005YB-Lr
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so8545125e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787919224; x=1788524024; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=96s9IQUFnWZcA91cntqgbwzTi5Xd/RB4A50OR/tCf2w=;
 b=VySsyAvou9dU5dljV8iRgsiOvzWhxiHOBu+w0p6xNjrkynuXtFM80Uv3LgDdmaI8mb
 j0KcAzDJrOao+P/jSLjMzVUaDt9s7CJQhD/sLSvHl6vD92lVzHrvexW2pJ0vm835Q81F
 lwSU/aMNFbBH0B2WjmAvb6boGMqRa6xUBzHvAMolzHGEzQKnLOg7VCSbh/8b1R1OiLxS
 OxC4Z1Jy0LIBaKSnajZh+U/dQiDK2rc4dxcJuvhvlb3EJGieV3KMi6d4ECpqYK4mpwg3
 TEHsgKd+cDn8QKjkoqMYWzLgi6gTx6qY3PXCLkTbhnwM/7Hl2Ls5iHNxd4mmSrn1vx5n
 2TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919224; x=1788524024;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=96s9IQUFnWZcA91cntqgbwzTi5Xd/RB4A50OR/tCf2w=;
 b=XYsoI+F2RKpucdAHrF6JjsXM3+fnzcA9Py+X1dFZKFTVh4x8einr2YfQey2TJKBOqK
 83N4gmIqa/vOllfvSF1d59GmTFulByqnLUAXmlmaDpoHWCMsUUtHNLc6z8YxnrBvSwpe
 1OtNzCIvHV8+npAgFWeq5Ws2grS0uS5AzgLHcFHYcfx49traTO/DgY0jPGVcJHGyp0pu
 5akelBd6sjkQrW6g+N41qI+4ouUYc6MATW7xz2ExDoF5SuaW7UeuEja+FIr3SkhmMxtB
 nCLfiwxv3nXpoDvzYidWH4KabZk6gh6g2/jtEVOUVJxWiR8EhwU6Ezrob3/5wEG1QCmq
 DiVA==
X-Gm-Message-State: AFuF++n+oHLYvWzM4b3+g5eHnQJFCMUSyRikQGoIjUDJTak19HVvYQA1
 /Umcpqhe2tspotZv6/KMTYuNADvQwvBROjjbW6wJHtBM7I+sH7GaH+ta7r0mGmWCs0k=
X-Gm-Gg: AR+sD113dX2CGZFDs+kcSymKYnxUVgYd8zYq1b5h7+PmbWJJfjWT3jcjLS+j2s7mLw/
 tyjHAPY1c2wN1dN4rWEltbcVJ0KvSZ/Gkri3Z/N1++9rVyc7JxZuaHfLsWshhNHN2kTzLVfftSh
 iAz9ZX7CUgbdLRdCj421EF3HYhUSUz621mWFgG/tQe2ku2XPBUfkGsf+QoITGjPf+SWAasV9Fw9
 1S3kruOwbwpJ4EBtmp3sSncPYgPqE8KDe9NF7UkpydVc/9VQm+rYw4uDXhcZH4x4YuFeEshfXdI
 1hpx4JeRmlJm90UlMlh4gtDuYqFrfG0W+iMntyD45dNWzDZhjJNHxc7UGxc/lG+5gu6gT1+arSn
 3cWNd0S22hqKykY8+jY7YNlJPO90noyJki1FEo1nfzudLp0HL0hr9YX32+a0vKMVCv5asEX+MGB
 n4B5LjX15ZFOeEzvTCaBj1wn1PdYfn2uIy/qfWvwx9FTke06rc3gUrVmbk5cpR0pc15t4t7u0=
X-Received: by 2002:a05:600c:1d1d:b0:49b:d45:703e with SMTP id
 5b1f17b1804b1-49b91c2dfecmr89297515e9.8.1787919224100; 
 Fri, 28 Aug 2026 05:13:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013d1dsm43303685e9.13.2026.08.28.05.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:13:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 552CC5FC98;
 Fri, 28 Aug 2026 13:13:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 devel@lists.libvirt.org (open list:Incompatible changes)
Subject: [PULL 5/6] docs: deprecate virtio-crypto
Date: Fri, 28 Aug 2026 13:13:36 +0100
Message-ID: <20260828121337.2277303-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828121337.2277303-1-alex.bennee@linaro.org>
References: <20260828121337.2277303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

We have outstanding guest exploitable bugs in the code which is fairly
complex and needs some serious love to clean it up. As off-CPU
cryptography acceleration seems to be waning in popularity lets just
the deprecate the sub-system with a view to removing it in a couple of
cycles.

We can also remove the backend code at that point as well.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/3625
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260824-fixes-for-11-2-v2-7-352c6b890402@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 0c656a968fc..05e4ce8cf16 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -276,6 +276,24 @@ future release. Where no 'dh-params.pem' file is provided, the DH
 parameters will be automatically negotiated in accordance with
 RFC7919.
 
+Devices
+-------
+
+``virtio-crypto`` and cryptodev backends (since 11.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``virtio-crypto`` device emulation is quite complex code with a
+number of known flaws. It has never been migratable, so it is
+unlikely to be used in any serious virtualization setting. Modern
+ISAs provide on-CPU cryptography instructions (e.g. AES-NI/VAES,
+armv8 crypto extensions), and the Linux kernel deprecated AF_ALG
+and dropped its off-CPU accelerator support in Linux 7.2, removing
+the primary userspace path for off-CPU crypto acceleration. The
+time for this sort of off-load has passed.
+
+As this is the only device that uses the cryptodev backends these will
+be removed at the same time the ``virtio-crypto`` device is.
+
 Device options
 --------------
 
-- 
2.47.3


