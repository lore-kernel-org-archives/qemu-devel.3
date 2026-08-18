Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757B2C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPF-0006Zr-07; Tue, 18 Aug 2026 15:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPD-0006Z0-7D
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPA-0006Xu-W2
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH9oh1454260
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CkOT7jnQSTZ
 cipKxqamlLVZ+F2FD4hBxxBbJov/vZM0=; b=SIgfoFNJMnEJREKb0stBU86WaEb
 oocLwpXZCRIHtnnmk9jQOLhstujVO28zmAhQ1VTYr72CZR7DsQLtHTr2H4ki6s0V
 vICJIsoh8lOKcrKqFE/iQUiQAwrkvuLbtDjreXvi1nMDzjDwt02bSbGvcLQhdzUI
 Bs6yQPHQ0IIZLGbT97aV0hACO390ZAqVExCNJ3geOolY/ksmFChW4Kj0kTF7jDRA
 PzLgrtR9apInNQ8ZHVAttodL9zLuA5eM/yRJzoSqy993JOu0E0bxVAnhXbwdDROA
 Z5e1FT7rj133FAdyDcQahVShxPHoC1nXdE4zkOdtfCdRY8FxdeeAy0SWbyA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1uat-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so468772a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081003; x=1787685803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CkOT7jnQSTZcipKxqamlLVZ+F2FD4hBxxBbJov/vZM0=;
 b=VeHjWVZf4PUfcxeYL00xup3WQY0Q5LF3dHsYOigp/MFqDu7uHk6YeB215ASL0mH+50
 DE0DxFbPimHN73GAkrn5p8NnviqrYMBtAYE6By0woHTRF/o2GfCfTI2KE5XNxbCMT2xV
 aimiMZCsNeDVXrReqP4wF1D6/UTz7k2SrrkJThFxTGc6i3LH9mXvS8VDDoo3S13SFT7S
 wO4FZMmUYwoNTfBCCLfo3FbXsbVHiCIk48eJaYZNMqh6X6KuxKjAJOwqq/Xd+kY35NPW
 /0bKq7s4XmXWblZJrD+/JAqoX6yFDX0P/AntzfoHCNzZLkVv8EF16yrwido/kbTHTRlp
 V7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081003; x=1787685803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CkOT7jnQSTZcipKxqamlLVZ+F2FD4hBxxBbJov/vZM0=;
 b=Ntm6dYZQCeBQ2MYOqNbG5vbhRKFJp3xqyL0nnbl9SAAb0eUvV4CLncfMoHvuxYKGT+
 kyIvALmLc4eHGDPi75e/nhe3eM1TX2UtE/Gnwcooi0kE/zhDkI9oOW27rw9/6QwBg14h
 R6Gg5A0HUObvFmyGSWhUNU3/HhqsBlv8RLkUvmVP7/etNry39z0TfPpbenAIR95hH8uq
 ZC6rZw28d8+646QzLyicjIo+2gIWcMQG0VQRFsiGlf5K2KxzhklJoXrh8ZxLz3eYtqko
 h/g4Nl+eOlhUt374U3dKnfYHiJ2RTO8pXbCUcjlfuPFDtReIi/5NOa66g+zMVVrsaSkF
 EBYw==
X-Gm-Message-State: AOJu0Yx+NZ5wAht+pku3gf/hvhLRVtEiJdu2RWEJkzJMZP4h4nWsoAPW
 3hcvqV4GKni0O/7+wVZ7a25c5eQ/aloq+iX+EfvOkWjnSfpBXw/emD+bgT8pNAPM21J9Nz/N+dC
 djUu55VpYK7HSRvtNTrlP8qnAwmmpiGa7XzrqE1Nowf+VuUG40TpEwp98qKnfnneSLA==
X-Gm-Gg: AR+sD10W4PXfRN+VgZix5D7tLMOJLlsOzDb/D2HusJ8JJ2Uvjn9V/tp++6JC8KPXy/O
 KACrrOfEtUx/9WH/kPEAf6Fb+j264JKIXMsxkR2+FayVQEkE6B9MtcCw4EtTxYBHngf/V1XMZAF
 WUOrilGS6w01lrfc1Xq1to7a51efFMShRKj6noBwOBP3XHgqJI5wdDCrVp1Pv3uvZotM5K+44ps
 QzXH8GXjAh2I5daiCqEwX/h9PXBGwmTIgFsYjzXKOcYiXzdv7+szrMPnHdzJR/+3BcepT51uol7
 TZxvcme4Rj5v4FOgkSbkm9dQ4iP90RRronhWwKuhi2mn6k7p8FsD9SZ6Men2O6qKDWGO1Y13ADZ
 C3asa+Bz3dzlwXx/qjgQZtmUjljjj5IvgbjLFxxmGWm8P/jdk8H342ZnNq4k=
X-Received: by 2002:a17:90b:28cc:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-3957b16931emr136261a91.8.1787081002615; 
 Tue, 18 Aug 2026 12:23:22 -0700 (PDT)
X-Received: by 2002:a17:90b:28cc:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-3957b16931emr136160a91.8.1787081002100; 
 Tue, 18 Aug 2026 12:23:22 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 004/104] meson: bump minimal version to 1.6.0
Date: Tue, 18 Aug 2026 19:21:28 +0000
Message-ID: <20260818192309.22169-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX33vPV9I4KDH+
 GFTAjrJlNcYoeZ64wbkZ9K8KP34CeYTRJLLpk86wgRibrVSkoAUBgjIS8GmusyPVIH4BkFQ6Tqj
 5A9+3hXuTPEKuunTjxuTLPdceOlWQcs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXwloD24kdpyNa
 Qs92JL0gZug4xRcaTcVqhAe4ZXN0uHFtkivkU/u7mBEFcMeBfTAD2HC7nW2tbZrJ3ALXxZWLGQV
 NuR4nkXJw3g6zZWRYJT+zY4LwKWSN8wXEf+DSn8GZh8AtAzsRz1Ytx2DVbozMGwdnfSh7Vw6JKM
 55Xm27q6Aby+B6O/GYs1NMFdxEfYjkxtgc4Ciw5V7BSpPUctO7vdUkt5Q9tH/lHqAwwcKSrnUIk
 U/8FLz6ue7oNmuJw80G1DSVIw+FNaHcGhCDhjbOYPszxZFpWKysajm3FkAv34I1A68QNqTjg/Z2
 LgT4ijOZ3pTT1duleaAL3Pi+j05yHUYkaQm5ldZpJ1Gun88lXL5uclXi0iXh/+uJEQ9cvUg/s/M
 Jq9IuQ/KHumL2cJybZxbQduENhddXDJJabIYDx1CA/hmiDl59W8zRSjDHr5CtadYBkibgDxr90E
 ZK0q3KMKbCP5ivv8lxQ==
X-Proofpoint-ORIG-GUID: qTM5uHjLOzaQMaC5EucnhEqAqFl0gMNe
X-Proofpoint-GUID: qTM5uHjLOzaQMaC5EucnhEqAqFl0gMNe
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b12b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=Tinw-K56E9GXueLAAcYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Without it, we'll get the following warning:
WARNING: Project specifies a minimum meson_version '>=1.5.0' but uses features which were added in newer versions:
 * 1.6.0: {'test with external_program in args'}

Which we require because of how we build iteratively our test command
line.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build                                                     | 2 +-
 pythondeps.toml                                                 | 2 +-
 subprojects/packagefiles/anyhow-1-rs/meson.build                | 2 +-
 subprojects/packagefiles/arbitrary-int-1-rs/meson.build         | 2 +-
 subprojects/packagefiles/attrs-0.2-rs/meson.build               | 2 +-
 subprojects/packagefiles/bilge-0.2-rs/meson.build               | 2 +-
 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build          | 2 +-
 subprojects/packagefiles/either-1-rs/meson.build                | 2 +-
 subprojects/packagefiles/foreign-0.3-rs/meson.build             | 2 +-
 subprojects/packagefiles/glib-sys-0.21-rs/meson.build           | 2 +-
 subprojects/packagefiles/itertools-0.11-rs/meson.build          | 2 +-
 subprojects/packagefiles/libc-0.2-rs/meson.build                | 2 +-
 subprojects/packagefiles/probe-0.5-rs/meson.build               | 2 +-
 subprojects/packagefiles/proc-macro-error-1-rs/meson.build      | 2 +-
 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build | 2 +-
 subprojects/packagefiles/proc-macro2-1-rs/meson.build           | 2 +-
 subprojects/packagefiles/quote-1-rs/meson.build                 | 2 +-
 subprojects/packagefiles/syn-2-rs/meson.build                   | 2 +-
 subprojects/packagefiles/unicode-ident-1-rs/meson.build         | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/meson.build b/meson.build
index 49a5baf5b52..b873c46165e 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=1.5.0',
+project('qemu', ['c'], meson_version: '>=1.6.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'] +
 
diff --git a/pythondeps.toml b/pythondeps.toml
index bef88d49a6e..e2ee450ba68 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.5.0", installed = "1.11.1", canary = "meson" }
+meson = { accepted = ">=1.6.0", installed = "1.11.1", canary = "meson" }
 pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [meson-rust]
diff --git a/subprojects/packagefiles/anyhow-1-rs/meson.build b/subprojects/packagefiles/anyhow-1-rs/meson.build
index 348bab98b9f..e82b1f20bb4 100644
--- a/subprojects/packagefiles/anyhow-1-rs/meson.build
+++ b/subprojects/packagefiles/anyhow-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('anyhow-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.98',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
index 00733d1faab..267357fa912 100644
--- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
+++ b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('arbitrary-int-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.2.7',
   license: 'MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/attrs-0.2-rs/meson.build b/subprojects/packagefiles/attrs-0.2-rs/meson.build
index ee575476cb2..9b76fe0f73e 100644
--- a/subprojects/packagefiles/attrs-0.2-rs/meson.build
+++ b/subprojects/packagefiles/attrs-0.2-rs/meson.build
@@ -1,5 +1,5 @@
 project('attrs-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.9',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subprojects/packagefiles/bilge-0.2-rs/meson.build
index ce13d0fe80f..4d4c9bde404 100644
--- a/subprojects/packagefiles/bilge-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-0.2-rs/meson.build
@@ -1,7 +1,7 @@
 project(
   'bilge-0.2-rs',
   'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version : '0.2.0',
   license : 'MIT or Apache-2.0',
 )
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
index 04617b875c5..57bdf30ba05 100644
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
@@ -1,5 +1,5 @@
 project('bilge-impl-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojects/packagefiles/either-1-rs/meson.build
index 04c96cc5fb3..d869201e43e 100644
--- a/subprojects/packagefiles/either-1-rs/meson.build
+++ b/subprojects/packagefiles/either-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('either-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/foreign-0.3-rs/meson.build b/subprojects/packagefiles/foreign-0.3-rs/meson.build
index 0901c02c527..80e68967ab4 100644
--- a/subprojects/packagefiles/foreign-0.3-rs/meson.build
+++ b/subprojects/packagefiles/foreign-0.3-rs/meson.build
@@ -1,5 +1,5 @@
 project('foreign-0.3-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
index 8c5483311ed..b9ceb12463f 100644
--- a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
+++ b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
@@ -1,5 +1,5 @@
 project('glib-sys-0.21-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.21.2',
   license: 'MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/subprojects/packagefiles/itertools-0.11-rs/meson.build
index 2a3fbe9ee5a..3081639890b 100644
--- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
+++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
@@ -1,5 +1,5 @@
 project('itertools-0.11-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.11.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/libc-0.2-rs/meson.build b/subprojects/packagefiles/libc-0.2-rs/meson.build
index ac4f80dba98..d1a9da194da 100644
--- a/subprojects/packagefiles/libc-0.2-rs/meson.build
+++ b/subprojects/packagefiles/libc-0.2-rs/meson.build
@@ -1,5 +1,5 @@
 project('libc-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.162',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/probe-0.5-rs/meson.build b/subprojects/packagefiles/probe-0.5-rs/meson.build
index e6ea69533b7..1d33800cde2 100644
--- a/subprojects/packagefiles/probe-0.5-rs/meson.build
+++ b/subprojects/packagefiles/probe-0.5-rs/meson.build
@@ -1,5 +1,5 @@
 project('probe-0.5-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.5.2',
   license: 'Apache-2.0 OR MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
index 8ba558e1330..523572173c7 100644
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('proc-macro-error-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.4',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
index a85d7c07143..85f190e56e0 100644
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('proc-macro-error-attr-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index ba7de070292..7cb4f93bb08 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('proc-macro2-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.95',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subprojects/packagefiles/quote-1-rs/meson.build
index bf41fad99bb..fdd549e7648 100644
--- a/subprojects/packagefiles/quote-1-rs/meson.build
+++ b/subprojects/packagefiles/quote-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('quote-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index 3e6dc318a9c..a7baa6feff4 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -1,5 +1,5 @@
 project('syn-2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '2.0.104',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
index 11a5dab97df..ee483e13423 100644
--- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
+++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('unicode-ident-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.12',
   license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
   default_options: [])
-- 
2.43.0


