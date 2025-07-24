Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6272C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetg5-0007Z8-N5; Thu, 24 Jul 2025 06:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfy-0007LH-0w
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:50 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfw-0007yB-9l
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:49 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae36e88a5daso157906866b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354786; x=1753959586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUHaaEX9ciB/Ilkp0Zt8jXKaLwdGaCvdaueBn699s6I=;
 b=Of52W3+W86WkG8EfWZD1LeMzOOPQAnqOcynZyw5Xa9pbawS4guBwilIDFuKnJdMVfC
 Y/3g6ktiuDDhIR4r8OaZZFO6ev5jK+2j7Ic3Rjwpxq7ayHQhU0PjeyaAdJIjwR8PvanV
 L+OB/hOY/B7DTIflthVAXLCysRY7eaSuk7DRNpDD/VWIuxz7UHV7fcMk3+0l+VZWF8/d
 /WwYQqpmcA+gLp3da12IpCpMv8+whbg4PCo0euHw5ucBVX93hQSocfrIe0rANHBd8bCy
 Al84MdXCE6haF5gzp+eyF0ptBab+wqBWVOBlr/Vb9gLW7A24cE3X98SRBNJxYmcn3XkC
 tnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354786; x=1753959586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yUHaaEX9ciB/Ilkp0Zt8jXKaLwdGaCvdaueBn699s6I=;
 b=bEOfbjr/4PQm6u2OWy8DX0f0lv4zmbviK8SkBr3NR5bEFAzF55so9j/aZ1Jf0cu26m
 ygN62+6XVMRpZourWirdKrpCusxzMqezBD9UGkaPvSVnO7yE8cOmvpKnsIugCzYq6rrX
 7EBo3LLaw/7FBm7a/b6fBWUD/wNDmFAnh3mfwAT0odW2dxXYrgIafjhX6WKp9ARoCj9A
 vKE6LCWu12JRQ/AFCJ6yBdXUTQbxngzTDuSLJABm4RHwjH08acbisE2BJvPP0P3jF10D
 Rqk0qsBLpb3ILsBNgQY0rjmEeNGscKEe8WPug77jgI7rY9+iMrrHYgswkikrIUfLHmw+
 oVSg==
X-Gm-Message-State: AOJu0Yz3xmnspiELmC2dtmk528pQKhQfv7yjC0n2oZaRRl+oJKWA22j6
 6MxKv5uKVhiFIn2yjcB5aqdKCzaIv4pbCEAZONIKe9Uf/4U+rKBJNkRsOTvmyAY/BTQ=
X-Gm-Gg: ASbGncuRjyw7kW6VEKH3EefVmTUaJB9HmONvQswpDtRxExAI0GiKvX+Ha8EGx/RAWo9
 oOCkvc3i1q/fF8Y1pZWMo1egBaBMYqkAewunFbyQLV2l1viuAFqwhm4fBAusDJUjuA/79RU36gt
 mvlTAwCcLweUQk6xrspwDo4TKCLQ1Slq6uGopXLKjqmEjvsOVqIaWCgIz/T62hmKm6mhGIUEqYy
 3sjs9gJ1d4b4su+4CChH1Z97h7jJt0y+Faif6aQGjW73Dbgy/z92/FVS+1/Iwoix5YmeOJi0RZ3
 51Yy9VKY/vP62x4QzxSwwzfo0aEjctDEWmx2o5e6uYRp7a+W6RGFBTFfGJzLcZ8xSOAajaxc4bV
 um916E0mnN+tmu+fLsciMxbU=
X-Google-Smtp-Source: AGHT+IGX67i7criljbaqAz8ksx1tlf1HH3SLFpMUEr1DPkdwapaDNpzHIDf6NfyFO6qcdqEHfaudJg==
X-Received: by 2002:a17:906:f585:b0:ae9:bf1c:50a4 with SMTP id
 a640c23a62f3a-af2f866213bmr645352466b.36.1753354786448; 
 Thu, 24 Jul 2025 03:59:46 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47cc6e75esm98716366b.48.2025.07.24.03.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E7C45F8BD;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 05/13] docs/user: expand section on threading
Date: Thu, 24 Jul 2025 11:59:31 +0100
Message-ID: <20250724105939.2393230-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Potentially too many weasel words when describing atomic and memory
order issues.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/user/main.rst | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/docs/user/main.rst b/docs/user/main.rst
index 05de904225c..449acd4a324 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -46,9 +46,14 @@ Threading
 
 On Linux, QEMU can emulate the ``clone`` syscall and create a real
 host thread (with a separate virtual CPU) for each emulated thread.
-Note that not all targets currently emulate atomic operations
-correctly. x86 and Arm use a global lock in order to preserve their
-semantics.
+However as QEMU relies on the system libc to call ``clone`` on its
+behalf we are limit the flags accepted to those it uses. Specifically
+this means flags affecting namespaces (e.g. container runtimes) are
+not supported. QEMU guest can still be run inside containers though.
+
+While QEMU does its best to emulate atomic operations properly
+differences between the host and guest memory models can cause issues
+for software that makes assumptions about the memory model.
 
 QEMU was conceived so that ultimately it can emulate itself. Although it
 is not very useful, it is an important test to show the power of the
-- 
2.47.2


