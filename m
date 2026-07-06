Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10392C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtG-0002iO-7e; Mon, 06 Jul 2026 18:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtA-0002gi-Jr
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt6-0005Lp-58
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE4wN1626304
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mEy00Qr8FCI
 U+ykBLJnmgP1NX2Tz8dGlFNmbq848YNY=; b=hJR7yIElIL6H5vVvBh8AGfC4a/3
 xI+GT7xg42hl6IhtXuLwmOlyjD3m8PMH6tEgsZ6VLFEEb2EhxTWDqcOXdyKCdm1f
 t1tPGsbkUNSjmEKlEYbctrwDX4jRrAjfNMFFJgMHwN6mOr35+2ATjL+QHByCAMf0
 zfs5tllZAri+vJX7T8+Y7F6UmPqcwRTB/byS/TYLJk+NJbAyIi5xhzuF0opD0ZBy
 Ly1yJnoX3sFx8Ns1575dIC3u3OLiNASJWP0WPWW2DERbUeyhhqf69bOL1NCoZ7rt
 b0EX1ev2k/hUzSh8GXwVEGnyR2wJ4Gpik1WZanFgg3h1EGf6lU+zg8l6UEA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bn3w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-380ddac2b02so5249999a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377241; x=1783982041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEy00Qr8FCIU+ykBLJnmgP1NX2Tz8dGlFNmbq848YNY=;
 b=C96YNIpuNkN/dDfhMASM6Dz8HLj0HOWKMjNQkAtHlfPDRHz6+4o0Nanb98jdZuuOjE
 KRPJ++AsXpFsRKqs5AKZeYOGeh33yzSbyltsFuNPqwVV9tzr4LCiJclfjCKScAfyj2Y8
 L/z5EdYVUs3X4mG2GbMfZxuKYZkGVLBXH9qKWDCUXcxLhLMNcBUtxfOelAv7vM3HvBxs
 XR3cU3kCFlkq+PEpgpxt5BeLpe8JnUbxB16VgVsTUMcz6UfiBl/0gvmoTyGE9zfItbds
 bgzyZJ/mo9lhmiEHU3Q6DFBEPqzhwt1hTwFUGvkaeGTGORhicEKsV7YWZ+dZnIJMR5z/
 W74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377241; x=1783982041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mEy00Qr8FCIU+ykBLJnmgP1NX2Tz8dGlFNmbq848YNY=;
 b=iA9zIfxjTscIk/SrSoWDV/qg2mi98Klv55Wv+GUGXDOryVZ/jJltJcNVSduBDUZUG3
 25zVF4BQmBCaOANrUYH6VYEWoBZQ9OED/coSePh+LL6L1RTUkqq9O0wq26d1hPCr5OLX
 t1yW9f5qhPm2bypVp5TbzKvHiAB7NbUqOYULkK2E3zEXlS5UlNkRTa+D3cR8InbXlh55
 YU9S2wdPWMgXIh9UvuQk8zAxdI/jSUy59WU6pXlTzDe895RJ/0GoOgqBqRuugemTQ5Gz
 XxLhlUYqwSJF9dqek8aKBYmdephXj3SLG3TwlWuBllGh4OqqjOF47Wnk03iL1q/d+C4r
 9fRg==
X-Gm-Message-State: AOJu0Yw8CjpzdlZlvTKHUJmg4CkytGhYu8cE1cWwcvxxhf78PMLQxeW+
 Nzs00ydVmVC2vjWLpdCjXDLUOoujGtHUKvOkvIQ7v5rKrLzRm6LmnaCCJHrhs6MVaD5RBfwi8Dv
 F3Ys7YYn7V9+6SK6nJ83n+2/XPgyc3PZ1eZ0m+qA8fJUxd5tJjxdO5uoPoDtRkjLMLQ==
X-Gm-Gg: AfdE7clWZ7zNgafP3btoccJfugFV/ylV0J3XTZNJ0yWMF809VtfFklqRaZd8GtZbeO0
 gUFcsiiAtfhaNo19JVqYIkN9/26xR4YyYshA2eTKhU0JOdQOBzb0PvHkH3hOX9FhndLAMvHdX9n
 jO20qCx+wC5dRwvEnLdMr3dCwP0pyTlGyM6mVNX1jq4KfwmJoRVS8qTgzqOFVJy3xWgR93hFvJq
 uQ2jIIOlfazZXY08XOHcPs7TT9IqG2xnnjh9r/+JsSC+eb0UMXyIeYfh4EtdxoHSOCRVEg0bxYx
 AQaTtOTtlJW1im3emT54JR3LKIizx01I7PRw0Vyf2G/lL8ruz9ZBhglEC+efHk6jKeYEEgBcBYh
 10pOFtNMqWp+7CYeITLeXHtQpR72XdZvHBYUmKZpB2FDX0HL8PCGyaFZ+iLT11J87tZ3J8/AHMD
 ctyxRCBA==
X-Received: by 2002:a17:90b:2752:b0:36a:fcf5:64bd with SMTP id
 98e67ed59e1d1-3875650bb6cmr2491696a91.2.1783377241051; 
 Mon, 06 Jul 2026 15:34:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2752:b0:36a:fcf5:64bd with SMTP id
 98e67ed59e1d1-3875650bb6cmr2491667a91.2.1783377240598; 
 Mon, 06 Jul 2026 15:34:00 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 05/91] tests/tcg/meson.build: introduce exe_name
Date: Mon,  6 Jul 2026 15:32:17 -0700
Message-ID: <20260706223343.988769-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i654def0krh2P7ViOMndLCWMF4k5Y4YM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX1tabazVuoVZ+
 Zyxixc7XdQJkM02HldQImjWUdZR2nU3As4FCFv5KSSNigaJi58Av2YxBvVpRGQyIdDIgmqqOcA/
 BJv9tw9p0tyDj2dot8tFAYMae+VyyGQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX57FZeTo92ZYS
 nQhUY/MemRKNuf2J7gRYMSZmMO81q06QrtinRilt4vpT3wL2c5W+g95RZE/v2jV05D6OvF3WHvw
 ui2aaxhg/nNfemfV7PqQJ8ggej3PQejIScXjyMSgl9dvupfJWvPf+hkWkHZSKJCmw+Po7XV+hxM
 6aEBe6GI08XFf2XiGB5IvMFnrKUeKQa7SdqaJL0UpOFdwypcBl1B0dpp3gJiFZjaU+iPylK3xyX
 6/xRQ/pusXnSoeB1RoJ1jycrP33szcYQMFTj/Kcfcekna5XBc6b8cxtMhvvcHn7peTzE8GN2FEB
 uBa0Eitlpv5WnFfqZZZkEQjvKOMM7k43ZdY4jTEDf6RFEStPQh3M65DBf28Bhe530KaqGncHBfK
 V3eyB91KlRx7NZ2dQfWyuE7u71sjVPZELNRa46bCFxRTuqMYkAAyZn/DI5uL8IwXkp50rjxb8qy
 Bi/gX9o0httr/1D0/TA==
X-Proofpoint-GUID: i654def0krh2P7ViOMndLCWMF4k5Y4YM
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2d5a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=vdizb8zAaNHivpZOFqUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

We add possibility to duplicate a test executable for a given source
file. This is needed when different cflags need to be used (like
vectorized vs non-vectorized for instance, like sve tests in aarch64).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0cfb39b0902..1719eac0d51 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_tests = {}
 #     'tests': [
 #       {
 #         'src_file': {
+#           'exe_name': ['provide an alternative binary name'],
 #         }
 #       },
 #       ...
@@ -18,10 +19,10 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, is built only once.
+# Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also.
-# Default name is derived from src.
+# Default name is derived from src if 'exe_name' is omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -49,10 +50,22 @@ foreach target, plan: tcg_tests
 
   foreach t : tests
     foreach src, setup: t
+      # return a clear error if user misspell a setup entry
+      foreach key, _ : setup
+        allowed = ['exe_name']
+        if key not in allowed
+          error('unknown tcg setup entry \'' + key + '\' for test ' + src +
+                ' (possible: [' + ', '.join(allowed) + '])')
+        endif
+      endforeach
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
       exe_name = fs.stem(src)
+      if 'exe_name' in setup
+        exe_name = setup['exe_name']
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = exe_name
-- 
2.47.3


