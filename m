Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ADDC54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZer-0004JZ-8w; Tue, 28 Jul 2026 00:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZel-0004Fn-UX
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZej-00019J-CG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:07 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ajj92692925
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3ekQfVwXU1u
 ZkUaeHNQ0o3xlRyOF+rGcKqjZXiY4M1M=; b=CGBPnSqAUoL1upvoKKfIWBXAkxq
 838zkyu0N7eTllhI20z4LTluPhJkty3DyPKhb8gZL4oYYSVVI5qiqcxsA3XT/Zb3
 T72HGmjwdH9Q6guo5l+dIVWWSrPZ8EmmZZrbiSFEyu0LB8RoNZVKypHTi0qOteKj
 71aOANxO9c9BMMtNBFC7ceRtFbfL3b8/w8C9kaNa2DgT4HV3OZ3NZmZ9Z1RU8iEr
 fSifpCiKojLCHdiGBzxXRR695Z4sD6dzEMoO3amLA8bL/KrVaQkCNNQ3rbk5UTq5
 otXQ+xp0LjPPzsGvJvYHEyiDs8EE6SmBnOUCxay4KXegzl1EA8tXcV06zTA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5jehx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb733fc5024so4724893a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213783; x=1785818583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3ekQfVwXU1uZkUaeHNQ0o3xlRyOF+rGcKqjZXiY4M1M=;
 b=RxKbSh4N9Q/2yJ/x9T1UXm55yvILmYwh3KZX+gHhX6oPYqxp6nl6M72tJbCd2+IOo3
 iRUBSKCdJV3pXK0P7XU6vjnJaf1acYfgh78Idz4CneoVQzWf462JT8ekNkj445k9vkx2
 tkyXw1/tTC2I0z0bE1sir+0YmQEkXRAVyKNsTZStW1nrnRTu1q/H6kOE+m8zgm0hjj7z
 ZyEK3h+Ew249JU6kVuvS0lSvJCOf4y7QQPAmb+p1M37aHUIJqtubCsHph4XyYpqJYxWf
 FWHWSnWotUK2WSOslwlZ9gaXnSn6j+WWu+VEhJ05h9Lv3HlQzIKSguCewRkcm00oC6BO
 a8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213783; x=1785818583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3ekQfVwXU1uZkUaeHNQ0o3xlRyOF+rGcKqjZXiY4M1M=;
 b=q0AXwQ9X/ZTJzoktLvISwvaXNlH+CGQfeQFdMc785CnuPdtbJbpIOk/u3krCskRBbR
 kxK3ox6w5B/adgOJx9FYOFJ6CatRnlgEt8MxQjIQ4gY146lK0cZLcDPnWFFDXIYXbU3T
 CWffAyI7jqy9vXZEat0yV0AUM0iHymr6bgOZ1P+zA9qfzqkfqzRxvT07RzXGI1+9wfgb
 bpWZNqb0O07HhWtQ6YgvnalTgnwjIxVLxuRUPQvEp/sJ7Xmvx8R6Ge+CVvaSfrZkPSgn
 3MN/nWZe/F96VKTQsdgyhbJl7jlN28i9js2YXCRiOgn5QEqwTZZermXSnV+2OX9W/sNP
 3gPA==
X-Gm-Message-State: AOJu0Yz6Hu1kewnjw2364JwZYkH9PnK22NW+wlsSHPsTiX7HDdIPOlKW
 274z2t02m880MjV+XIDabw2/NpV6QumAGGoqnHLKGpUYA174N1zEGuGXZMGOZCRedpBT1pKvpxs
 QdJNbuMCiLY6FuOHU3xGkKrMNm/oaK5jxwGkNpp9aFYTdSzRy3tJOfhW1ZDuNBixAvA==
X-Gm-Gg: AR+sD11F5FalXLP0R9ruJo4bv8GhtzoX7ygoMqic+G1hqlPMEUxO3YMwcdL/C0KeISs
 tde1PsKWUZCx8Bbb3AVupIy/Voq0PNJyWvlQK8xPaloKqECf7nF+Nhb20Xny/FwgiEAfX8VmT8L
 X7IVM9He9YgF3m3IHkDYYWKYcK7IBjmzpkZ+qP100yOYnI9b1JFmyXzpePAEwSPZokF62Bj7Z/D
 OHem/fvc8r2lQ0P32qgCjLpHsVD9/yt7DoCEd3Y0hULXe1rEOfiDZ3rpu2t7WMy28fWoCKOWWLK
 0OEZk1qZiFN+qlj+tv19APN+qsXKui5tEgxmU7u34f2kUIHR9Hb2SHPOY3NFAjdkQlqyeEyWN35
 n/d67tU4cQx0NN8kvcJCrZJ4Jna8K1BSygVHr1eYLtB2LrQx0kzw8iXA4A4ooufHLZ+PlIuc=
X-Received: by 2002:a05:6a21:9985:b0:3c4:3112:33 with SMTP id
 adf61e73a8af0-3c8aaf7f814mr1009405637.6.1785213783176; 
 Mon, 27 Jul 2026 21:43:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:9985:b0:3c4:3112:33 with SMTP id
 adf61e73a8af0-3c8aaf7f814mr1009383637.6.1785213782667; 
 Mon, 27 Jul 2026 21:43:02 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 004/103] meson: bump minimal version to 1.6.0
Date: Mon, 27 Jul 2026 21:41:08 -0700
Message-ID: <20260728044248.137626-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX4edWIVeU7Jza
 m+H5eD/a6Ob6c3bSVSnKexesjhC9k7KC+oky5rKsEs3SnAFPn5rVZqNxnbVaImQ6JmeGXTeAPUD
 4UUWU/g0Zqk1r8X0Orm+WVvNqwnbzPE=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a683357 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=OdLkAQov_zCaxSa-YWIA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX4aTS2DNeGQQu
 gBqyZWpCPWY8h1VdbH4A87xvVD2lqBppoQNudrxhAOdoGONQ3b7V8A7KmmwXbSrKTPIEEuB3GMi
 HfTe9svlaB6+nW/Xl8Q7zzI5/LJucsqqAzTaPqn3vEZfmMGY31ua+ZxAA25Y53zGCC+JzebMjGm
 QMH1ZGBTfmuHIceP/NtbnkGfyWhyhPO7JQMekGNbO9DpqwBOvAeZdrkDR4+Fcj1ly1pqTzX7wzR
 mtBpSrRPkoiyk+plyOsyZKc5WrQ0AZYhc7Wvg31hpijKMAFU5pZGL/g8mGmWCIjelkEfteJgXhk
 5BkCTUsyw/KfBMH/GfF2lcMAvBz8HZn9AZVGGVsGUCnmpcVe6nXqUr2NNcm6pJDYNhIByKqPL+2
 t+en6ZkFlDZ0yNjUsmWog7cM1A+Ylzv/Lf4DaIqZvDAM4+7oQzfn9RayuvLZ3pq1sSoDXGo/Fxj
 WzQvtW69jIj4Y0OYaBw==
X-Proofpoint-ORIG-GUID: gJj4bgjbzqsovq2GCuuib-xmbVSvNL23
X-Proofpoint-GUID: gJj4bgjbzqsovq2GCuuib-xmbVSvNL23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build                                                   | 4 ++--
 pythondeps.toml                                               | 2 +-
 subprojects/packagefiles/anyhow-1-rs/meson.build              | 2 +-
 subprojects/packagefiles/arbitrary-int-1-rs/meson.build       | 2 +-
 subprojects/packagefiles/attrs-0.2-rs/meson.build             | 2 +-
 subprojects/packagefiles/bilge-0.2-rs/meson.build             | 2 +-
 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build        | 2 +-
 subprojects/packagefiles/either-1-rs/meson.build              | 2 +-
 subprojects/packagefiles/foreign-0.3-rs/meson.build           | 2 +-
 subprojects/packagefiles/glib-sys-0.21-rs/meson.build         | 2 +-
 subprojects/packagefiles/itertools-0.11-rs/meson.build        | 2 +-
 subprojects/packagefiles/libc-0.2-rs/meson.build              | 2 +-
 subprojects/packagefiles/probe-0.5-rs/meson.build             | 2 +-
 subprojects/packagefiles/proc-macro-error-1-rs/meson.build    | 2 +-
 .../packagefiles/proc-macro-error-attr-1-rs/meson.build       | 2 +-
 subprojects/packagefiles/proc-macro2-1-rs/meson.build         | 2 +-
 subprojects/packagefiles/quote-1-rs/meson.build               | 2 +-
 subprojects/packagefiles/syn-2-rs/meson.build                 | 2 +-
 subprojects/packagefiles/unicode-ident-1-rs/meson.build       | 2 +-
 19 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/meson.build b/meson.build
index 49a5baf5b52..d59c86ab2bc 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=1.5.0',
+project('qemu', ['c'], meson_version: '>=1.6.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'] +
 
@@ -1385,7 +1385,7 @@ if not get_option('zstd').auto() or have_block
 endif
 qpl = not_found
 if not get_option('qpl').auto() or have_system
-  qpl = dependency('qpl', version: '>=1.5.0',
+  qpl = dependency('qpl', version: '>=1.6.0',
                     required: get_option('qpl'),
                     method: 'pkg-config')
 endif
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
2.47.3


