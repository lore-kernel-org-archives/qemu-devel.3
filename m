Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146CCD1CDD5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CZJ-0001w1-Mn; Tue, 22 Oct 2024 06:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CZ1-0001p1-0u
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:36 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYx-00023z-Df
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:32 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso1155614a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594590; x=1730199390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuVL16OURPo6SfQxD2PzScmfjsPxu4HizBAVk8u7e/E=;
 b=yEgmR/iucv08DNiZ7m008A6CAAh3GaZt5k0f/0SCmq6RK3bXS27FBvrPerjCf387AW
 WQnJLAB5boaVNUizxzqMfclYYhIrDpJvh3FlW4yqJop0THj6ZfFxdJDPfyBxmolAcPF+
 Gb/wNUNpnzPctM+mvYL7M/mxLScxLmEfUMNfPJAG4C9gBy8grZTG85zm+uD3L37TLBUw
 CjQNCSiRKXY17nY7WemyUd2R97/sYuQsGCpqQdDSi/r78p1plUQCeilcLR2qjijmjLng
 9s2nWZxo0kq9IkgNPXSPNJRiGTtNxsKRXOLLPwaIHnVCOsgGlIibMjv5h3B2kBBFyXR/
 wnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594590; x=1730199390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nuVL16OURPo6SfQxD2PzScmfjsPxu4HizBAVk8u7e/E=;
 b=WgY3qv4NiDGRCHJzB6WZr2mGT2uoRRu6z1bp3TfGGwLXg8+21KYYuR4tSZkLVHaP14
 YlF/yselihVUQzTHWWOXlBNiP3VVX1WkxxGeGoIRGbWrjmxYxv9oe7beJf3lYMTuDUju
 0mU0glJtrBc7OdGIIoMgGzTV1z+8dkmI+EPWq+Is2E+C7FpBq82b58DRU35Kl/+E7Gk/
 BwyG/TEcMkJMmwpVptpuDHorvaVfqreWQ5WWVVFI4TsLZ0Z5vr/HLHiI+b/z1K0LnLC8
 JCkOzYS5kzB/nW08vNoPUT57Lz9rdWPhpcIBqCWA1dGOw4QRTBCHQy1E5hloKd+axu04
 x22Q==
X-Gm-Message-State: AOJu0Ywj9tJoBaxwpJyTZc4a9pxOQrq5mt0tzmiqQnCkanbSYrZkJqSN
 8bxa/5A4pbZNIPC5WHOuXZT3LkrcsIgus/92LaBP9Tqj/pNCKuhxRNJUYt/rqKg=
X-Google-Smtp-Source: AGHT+IHwi1+vxmbQ3YLA9r6WePtD03FZyJBvumSeivnyntfSu8jv5XX9sGc6cj7ZvugURHt1idsIcQ==
X-Received: by 2002:a05:6402:35c2:b0:5c9:3070:701e with SMTP id
 4fb4d7f45d1cf-5cb794670eemr2833546a12.9.1729594589755; 
 Tue, 22 Oct 2024 03:56:29 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c7255esm3123937a12.80.2024.10.22.03.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ADE0A5FABE;
 Tue, 22 Oct 2024 11:56:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 12/20] config/targets: update aarch64_be-linux-user gdb XML
 list
Date: Tue, 22 Oct 2024 11:56:06 +0100
Message-Id: <20241022105614.839199-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
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

Attempting to run the binary asserts when it can't find the XML entry.
We can fix it so we don't although I suspect other stuff is broken.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2580
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configs/targets/aarch64_be-linux-user.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/targets/aarch64_be-linux-user.mak b/configs/targets/aarch64_be-linux-user.mak
index 778d22b2a9..dcef597a80 100644
--- a/configs/targets/aarch64_be-linux-user.mak
+++ b/configs/targets/aarch64_be-linux-user.mak
@@ -1,7 +1,7 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_BIG_ENDIAN=y
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
-- 
2.39.5


