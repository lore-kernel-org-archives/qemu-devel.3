Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75B6E7718C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOLK1-00030B-1v; Thu, 19 Dec 2024 13:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOLJu-0002xb-9Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:32:23 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOLJq-0002ac-5s
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:32:20 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-725d9f57d90so897454b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734633137; x=1735237937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrAuDbFs90HcBriKC3fRwSGZ9LUrKAcdlzz9HBsoE2g=;
 b=TBD4mrezylnX8VJ8/Np0CukWli3N2MSwHuVVZEeqjH+Uthdo3Mc3FTtZKxvrUktzPQ
 zMpIj6HdURrCHyrKYlIG6JTagp/RyfI/jS6hi8I66cJNNUyK9oGSBvS5zaIUPf+//sQa
 5K/ch0RaS4Z9sJH4xBUatKs+OM9tQ/bk4v/g9dtDObHejzf4jkx2HJQKNSZyVVIqpeqp
 MXviFIelO0ES6hg9ir+CKfccEJ7BR4aWPuBQEMQUxiDDDZEV2+M1dgeuEkOLpqcEmJnT
 LhI3peTwsHfxLCYGhW+A/s8kLQKQSsJ72O1iU4n+kyuGLmhuyNhFLGI436G7zWjPCeRK
 8LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734633137; x=1735237937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VrAuDbFs90HcBriKC3fRwSGZ9LUrKAcdlzz9HBsoE2g=;
 b=PjSIvlHDRRfbcC2vXi2FLZftvT5hy6gv8Yz44cIMM5eflexj7uyOf9n380IVZU5Xl7
 COp69Ti8zbDzOxgufFioWOoLvi99JKc7rjefdhmbD94RR2hy/+mi3AwFSzCBgjcpZf52
 HMAKenOH1e9J8J2/OTOBjEl/100BMy4QRtDeStMMpCR0vU0+CTwTJpcXGomseGq00hwS
 sMQbd+G1hqSyZL1FS/Hkc8WEmjd5UtQDRu0TTEIiWH2ZzhpUCamn/hSpiobSAg8A4EB0
 reLpmIFM9l0mTDH3UfzDAPURTiDM9qUGSiAcoTKUcVoWlKOiLvk+uUQcFhjHZ0vdTJlp
 ZFnA==
X-Gm-Message-State: AOJu0YzQwLzfelWxbPRf9mdTtpaBBN5RIna2aO7SJuqf6EDcGeG3ozOI
 fC7DNF/S47RB2zlUFLoN03UsggdN86toGpK8r/7r7R/Kd+26wFc3THCZNItro8w/bjBCUz/te5u
 bBJw=
X-Gm-Gg: ASbGncuFVJocDba+hop6tamdYaSq61vaKdTTiF5LPWYuguuxV8LcUTjCdvmS9uiW4FO
 MqA61Ne9CGslAy7/6fUzkQgcvhpCxF+H/wH7rSNi3nBQvlT3G2KAmCYU8NHMTb55uS09wpu4YmU
 f7pwAUpbMofepJHwHezNzKkO4o0EB/rMoDoABqnuWmeHr3HOGk8cJVp9nPcqTGvjob+WNLr3Kx0
 T5EpXN168juJDq/v7Og8ZcCc6J0uGoobvPE50koObJOCqEtiWcL0XZf
X-Google-Smtp-Source: AGHT+IErQi05wuFbtGW97Qfm0HdyAPfmS5ZIe6ijwUVMBvi4kz/COnJBsO0HHGKLbBRPi5jPh0/OtQ==
X-Received: by 2002:a05:6a00:2189:b0:725:f212:12e5 with SMTP id
 d2e1a72fcca58-72abb5dcc67mr762718b3a.24.1734633136923; 
 Thu, 19 Dec 2024 10:32:16 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad90b302sm1624733b3a.175.2024.12.19.10.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:32:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 3/3] docs/system/arm/virt: mention specific migration
 information
Date: Thu, 19 Dec 2024 10:32:11 -0800
Message-Id: <20241219183211.3493974-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/virt.rst | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index d25275c27ce..9f1457cf9a2 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -17,9 +17,17 @@ to have the same behaviour as that of previous QEMU releases, so
 that VM migration will work between QEMU versions. For instance the
 ``virt-5.0`` machine type will behave like the ``virt`` machine from
 the QEMU 5.0 release, and migration should work between ``virt-5.0``
-of the 5.0 release and ``virt-5.0`` of the 5.1 release. Migration
-is not guaranteed to work between different QEMU releases for
-the non-versioned ``virt`` machine type.
+of the 5.0 release and ``virt-5.0`` of the 5.1 release.
+
+When saving a VM using the ``virt`` model, the snapshot is automatically set to
+target the latest ``virt`` versioned model. When loading the VM with a more
+recent QEMU version, you'll need to set machine model to match the version of
+your snapshot. When loading it, QEMU will return an error with the expected
+``virt`` version you should set, so you don't need to record it.
+
+VM migration is not guaranteed when using ``-cpu max``, as features supported
+may change between QEMU versions. To ensure your VM can be migrated, it is
+recommended to use another cpu model instead.
 
 Supported devices
 """""""""""""""""
-- 
2.39.5


