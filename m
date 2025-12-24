Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7586BE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRcq-0002Aj-9s; Wed, 24 Dec 2025 11:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRcb-0001ps-Q0
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:22:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRcZ-0002p5-M6
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:21:56 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so61818235e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593313; x=1767198113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ua60JEpQG58b3nrNlFkMCulo7Kh6kSjNov2Wuy5h9Qw=;
 b=ZVLYHUKMLfZ/pgiCD+gm61cDQlHZ+Z9y/b4GDWSvYK/xK6PltGkduutVPlBo7uoRBs
 W+iFugt8WCFFGgTZRuts8PIAkyvzPqTmUCldmM2OTtCWX/5pDeVDsPfIxh9iXkV78Lvp
 /oTILOgeGYcmiCdQ3IGmSC30gzuQjbY8wicBU3rEVLG9EKNw191c8ZtPQDdxJjF+O3Gr
 NPkjAB3VTPLTYSpg+jX7oBzEALAvRebIDddA+cegYXHoUdZYnXUmOF+I12GAPscIv2V+
 HWzpN99FT6CihhTuMw00noF+LkvdSYYyttLJDSCmj4i8ICnNYn3JFZK8o2S7BcPjABm1
 wM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593313; x=1767198113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ua60JEpQG58b3nrNlFkMCulo7Kh6kSjNov2Wuy5h9Qw=;
 b=uM5n/G+ZDJLSSWy6yoMnktCT7NbhdMpIwXiM5IWABvgNVqSqiOB+IO1G9B873/6+ic
 mArGx3XIkFuX2VM7+fY20N9+S+X+Lh194vfWY6PFKIRLZFRYFuEcJEPf4B0ugAeWy/p7
 7bT6YSeSOjZms4NdwoF2pGWLrZOuGy+PGZ9uCOuGajvFLAagFHuG1KkC6Qfn8g7MZdIp
 T18YJ3M1W2oVDnql2Dxg+PRYFmi6vKDNdwhXCj8RuZE55deqgeqjuEmU6Z7Y7j2Zv4Ri
 4vTWpQUvUp4XmB0CtDLQ9sbkj2dwtATa+NYGPrAcRVPb7BohjfXSxDXPwT3l/pTCD6r9
 X1nw==
X-Gm-Message-State: AOJu0YyZ+mHv9jq0HOmqIFAjmTsLUBK1NyRSYGwTVJGHsamJghJM++b1
 zjtDWLretWYRsvLXcT+4Z/zIImchGx/ImJjZ+5p+cL+8dv7aTSufSJvaStyJCGOZKmqWBu1W7WQ
 fDn/Fvrc=
X-Gm-Gg: AY/fxX7Ns6wOf6NG2kpcjp2sb0JXV69MwgOmNKCbXP/yVL7KlElO+CF2fQc/w1NtQ5j
 zwHrExMO1XFXoibc6JZUE0JYoRdj6XQGF7NjQ2a5KNCQ5Ir88denp4iXXl/KRVM4KZEudKZ6yCv
 0h7BTAFdzVp3x1UWB5XlduMmSiSxBqJv5YbqHEjtQOBb1GEOxHafawE5T1yZYbD1SPcEGY6v25t
 mjtX2lwgPG058LkntVQ9mUlcuHWDVcQw22pCQsGGMKEFJuMWkgwzjZts272y42/h/KEJewtpWNH
 7MWyq72wMjHdiRM1Ow25EiQTLF5cH94ryiyWkY2j1ltW6r/H4kc9EhF4tf9TCWdVHCLkbVfYtIv
 4qzPb9wafhyMS0zOOteb5zH5HppVvAz06DyQKGQp4lZ09X8Oqd6ANqPnVevR/KAIaxMe7IbaGO/
 oIy5Rh1IoNRIrNAsRYcy8OkQgT1/959tsV/ExM2cAIFeD/jphFmVYviK8=
X-Google-Smtp-Source: AGHT+IFvyCNY4XxIhahmA5smi+M+ydPrfRFfKBSS5TwvrkAR8TgyTNuQx+Ueu0ZAv1lE3hcOARa3mg==
X-Received: by 2002:a05:600c:5246:b0:477:54cd:2030 with SMTP id
 5b1f17b1804b1-47d1957f707mr204371555e9.21.1766593313523; 
 Wed, 24 Dec 2025 08:21:53 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1b1sm34694980f8f.3.2025.12.24.08.21.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:21:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] configs/targets: Forbid S390x to use legacy native
 endianness APIs
Date: Wed, 24 Dec 2025 17:20:35 +0100
Message-ID: <20251224162036.90404-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162036.90404-1-philmd@linaro.org>
References: <20251224162036.90404-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

All S390x-related binaries are buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/s390x-linux-user.mak | 1 +
 configs/targets/s390x-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/s390x-linux-user.mak b/configs/targets/s390x-linux-user.mak
index 68c2f288724..e3723f5dc54 100644
--- a/configs/targets/s390x-linux-user.mak
+++ b/configs/targets/s390x-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index 76dd5de6584..544657cfe2d 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


