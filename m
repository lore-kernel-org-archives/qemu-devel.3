Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4764EC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQsB-0001cl-Qg; Tue, 04 Feb 2025 16:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQs0-0001Zs-TE
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:15 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQry-0008VD-SN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:12 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f4448bf96fso7906912a91.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706049; x=1739310849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POW93gVR6h/M8xFYSXewi98308xEJBX+M2a2KNFKUmQ=;
 b=JNsg/YpfvPWDyr0b9jvRhhzqzaWsYuvk7pYz5wtAXoA0vcalwSv7XHXhA2Lp0AfQUz
 EAQ3NuEPqnwdmnzLIQtaba8bp3Bc0peF1ffRB9vpDHarvNPk+EMaPF/1zaV67wRy/GgT
 EtBd7MUTlZFY2KzRfMdm3zQ6tXaYwWBBRe201l4+oyeVXQIHuC6pJDkUZelrgoEaQyE5
 9vC++D5mGJKxDzruQ/WFH/b08vrSMNPH0lKZOsHpzJjfimtl7yIfBxbTZAdr+pifrEN7
 klrwqDd3MYpvYHYK+trrSU78DBYnLBFiRdjHjNmjR39obUq+3uYxUgJDEutErVVR+HKo
 VM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706049; x=1739310849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=POW93gVR6h/M8xFYSXewi98308xEJBX+M2a2KNFKUmQ=;
 b=ZcVhQxguu4NHLpUVMkLC9llLMUtJzSN3Ad1BaGW8HKTyKTm8G3tm2QktCpOTfrjEKv
 EfigKWInju/bXBOmF60UMTDb3QNT1x1hyCjZJIj3YhmPQdVRp6dOArQ2lVxzO8OA17Kr
 n7Z9KI6KCp7CP5Cs3y+4qylEmWnQmSJzZFmHbhLgPzMq0HA+5JZeqkZrY4o2Zgv6NSjl
 O8/7i1W8MiTfM3ylaQXizOGuNpG/ifngNE1Bj5esNcFFRj4Nbx0Rk8WaKLgfkGH+DG7i
 +otan8uVBcGps2migPk3JWkUJymDEBcRAWBM0gaDMToiKVrbdoulKk/dvaCSv3G0v30M
 cObg==
X-Gm-Message-State: AOJu0YzRUGQGF0tf0eJ4ChF39ky8NCf+d8mvxwan7Gpt6yt6JBLw6VeU
 G+jHNaY35RLe4HXnw6WG1cdbQzuLLWS6Qh2x9E+KKSRUb6uGLEBsEJGKCLXC90yKgrdwiw3S6aU
 0
X-Gm-Gg: ASbGnct/D+N8RJjZceG4TUjskTiw47b2z5HESlGCxUEm4Ee6wycW7grnga/S9CAQ//G
 rr06MaHZeNqmYwosMuZ2TjAzmbQFvucWUDpYvIWN1BTFXMCcHTZlwUybD0gC6hYCHLNyWiMKIHP
 cZ+qIHutu8IwGXZCvSndO5mtPM2rWkQYp4rgQQh5BMbeZN6lxlkSX+yHfihHPCEoU5nrjQHx6VU
 7uENFfc79Z7bNwPGxtICm+AKw7G+asq51XPRp3Fm7Xov/gPk7wea/bn6sqc7etNdeNVVsc03zLZ
 DfhC2OlCDeIIdX0DF18jh5rPNZPfosYf6fu9rFjNtcWTO+4=
X-Google-Smtp-Source: AGHT+IFGuHH5bxkCtRI96UB6Wyp0QbjEF6JCj/PZVziWE16jl1k++kmW0SDa5CUEYBNfeRykb9E+Fg==
X-Received: by 2002:a17:90b:1e43:b0:2ee:acb4:fecd with SMTP id
 98e67ed59e1d1-2f9e075c58amr632118a91.9.1738706049554; 
 Tue, 04 Feb 2025 13:54:09 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 11/12] meson: Deprecate 32-bit host support
Date: Tue,  4 Feb 2025 13:53:58 -0800
Message-ID: <20250204215359.1238808-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

We deprecated i686 system mode support for qemu 8.0.  However, to
make real cleanups to TCG we need to deprecate all 32-bit hosts.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/deprecated.rst | 7 +++++++
 meson.build               | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962..7c61d0ba16 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -204,6 +204,13 @@ is going to be so much slower it wouldn't make sense for any serious
 instrumentation. Due to implementation differences there will also be
 anomalies in things like memory instrumentation.
 
+32-bit host operating systems (since 10.0)
+''''''''''''''''''''''''''''''''''''''''''
+
+Keeping 32-bit host support alive is a substantial burden for the
+QEMU project.  Thus QEMU will in future drop the support for all
+32-bit host systems.
+
 System emulator CPUs
 --------------------
 
diff --git a/meson.build b/meson.build
index aa1ca8355d..3347b0a553 100644
--- a/meson.build
+++ b/meson.build
@@ -4843,14 +4843,12 @@ if host_arch == 'unknown'
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
-elif host_arch == 'mips'
+elif host_long_bits < 64
   message()
   warning('DEPRECATED HOST CPU')
   message()
-  message('Support for CPU host architecture ' + cpu + ' is going to be')
-  message('dropped as soon as the QEMU project stops supporting Debian 12')
-  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
-  message('that QEMU will compile or work on this host CPU.')
+  message('Support for 32-bit CPU host architecture ' + cpu + ' is going')
+  message('to be dropped in a future QEMU release.')
 endif
 
 if not supported_oses.contains(host_os)
-- 
2.43.0


