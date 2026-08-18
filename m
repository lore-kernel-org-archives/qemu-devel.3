Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE17FC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPk-00075g-R9; Tue, 18 Aug 2026 15:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPi-0006tV-M4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPg-0006fq-Lz
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHI1Ok1872769
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jEi7+9wXPIv
 iNeWGzhbSTZK5PZiS+AoE+QzVMs8ON4o=; b=E/qw1/Dwxy93yei9RB0pJmMl0Ap
 LZ5mUhAG9yyUqcsuKv7Md7rUeUs1+6Hkr8zJID58FP+tFWHyNIVvG4xDFh4PYDIH
 9sIuPCB6HUfQHqKaavNqGa36aZGBCTBuymP2zluLjTAA16NUVA3YFZrtQEb4zbYj
 uDLZg7Hm3w43zj7irSfBI8SbcjI+T+f3pRV2XnLM2FNgY4/gQUuYTvLervt4sXrx
 7s5dSH+izLPOXplxvT7q6DSgZfQBGUjAg/gudxGAfBFCWHpIFbKrLP7PrLRbvkhU
 FZXwbIaCCOwe+Lm/tHy40ScNyML9huCgygHin2QklMyh25Gg73K42qMMyww==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb1ag7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso90931a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081034; x=1787685834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jEi7+9wXPIviNeWGzhbSTZK5PZiS+AoE+QzVMs8ON4o=;
 b=PvEZ/PHEJXQrDvBmobaYuDMyiqw0D2Qxxij/oPZ9r64ZUE0MRLmp/RUAZ3n9nCn8bQ
 DGXOoBfU3qkWL2D2oYLv7WDrgDtBG/wSshmYSAg3cbJr12roH3pgjhxry+OrpaB7zF7S
 gZ2LE56TOmmG79lZm9cBOsWySA+HhL4yakSB+J7V9MJ6nyJr29hM+3jgjlgbivEXH1dy
 LG0HWWIw2E+1AEsIgZAkOv0BgwTTCpihPOwc+UyCsuRebCTGxog9Y0D19tFckN87wWf7
 e35tHftg5NQTG4JOya6Zyo9UqdbKkgbOmXjCXqUHNmHUZh9uR1LSmWFJNeNUzeD0MAw8
 PT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081034; x=1787685834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jEi7+9wXPIviNeWGzhbSTZK5PZiS+AoE+QzVMs8ON4o=;
 b=IHemlEaiPa/cipqoHKR/993tNTP4C8Rp2mc9RT8oFFc2+Lk2KIzupwsPxqmTaywr/V
 NroCMHSxjenndnKjlhEXv9QZykdJrzP7samLp+IvGbtVJh/gkkWpnJ2TQJ0dqgj7x4R+
 lvKfC7I1p+YgWWK2+NwGncUQtIIfY7F+U9gjXo0c6qSGCI8JbrQL6cyPZH3P/dZlQibA
 X1hqIH61rTJ6C5b2xzf83U9DjGeChdYqGDfjOURarA/XGKV3Yivkd5fEP/TiRMt7WGbD
 D+pOfLAAMQBJmrCQDq31NBR9sqxkAh8rV08OG2WPqS2Q28udHqM8gs7Uo7Zg0ezyR4xe
 LixA==
X-Gm-Message-State: AOJu0YxVbz5Fk9atIbULiSUEXw1Zav8pBj5nPPMf8JFrdSnOBVKBX9Ft
 w8V4Ebl7tzNOGaWG9Dt4UJ/afUIx/W0SA9LzJT0BKznINk6rNzO16LBDXg6ZWTTqPw7t3JW603v
 LK8HQibL0WeMGxVKSqCF7Q/lA16jXsMVub9ARaEFxvTMVMuDRRtPhFrcvYFqwYMf40Q==
X-Gm-Gg: AR+sD13AGzhz6kYpBb54Q4GR4LOMpC+aJnIWoePsr4P072lt2iv6dmv6O7Tl/LL13UL
 hzQRGmI1GcdCXrRPrppxMjGRDeAKVDolzL8yyFtQhZbdz/nIM2yvZ+MJEfhsg6w9yrhlpd52bEL
 Wq+U9hXpMyo2JKOMLnpL4ECP1ajy7TWh/chCbaxXGd7TJA7iGTHH2EpPHn/HZLPT1JiuJ64BTgn
 M/zr4lM0Eu78tPCTcZ/1bXzpm9RrhhW5L7O1OItoT/3lW1nrjZSL9nKhcYI/CLkf6y1okZqzUXy
 yhBKCLMnxynIA9rtQkKGmZH1ym8ht+qFAdjxY/8Jluu5apNmmZ9F4TKTdbRPmQ/ZqSxF8MODI0T
 bkXlVZUEJINsrnlV9JP6LAkLj2LdVSjjwQVA/9TZHCl7XFwhTiUKBK6RZUEY=
X-Received: by 2002:a05:6300:2285:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3ccff07fa3fmr148726637.17.1787081034110; 
 Tue, 18 Aug 2026 12:23:54 -0700 (PDT)
X-Received: by 2002:a05:6300:2285:b0:3c3:6928:8b25 with SMTP id
 adf61e73a8af0-3ccff07fa3fmr148639637.17.1787081033613; 
 Tue, 18 Aug 2026 12:23:53 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:53 -0700 (PDT)
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
Subject: [PATCH v7 025/104] tests/tcg/meson.build: let test infrastructure
 detect compiler
Date: Tue, 18 Aug 2026 19:21:49 +0000
Message-ID: <20260818192309.22169-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxQczEaU2MKOu
 kJ93kIibM2gDQDPfq9rSPp4bwNP6bVKjQzH6Nrn3y3lInig37ACdTXVcfOoHgv6ObZgBFAiOEv/
 /H67KH7hh/ojQmvpA+rw5vfqtH9ajhMxL/KKdsF4qglJLSznMAz5kls5IMDVec/VfuZA/lqst2V
 0M6b/AunVN1qHFLIZb5836cTk8NwMiQe/6h6gfzLqaQlRf2O+qrC3oroZPJ1pQr8nFyECGdt/WZ
 XviUYst6QENVhKyVso7sGw8xa6SIOry2Dub0xJmU9Ub0I9XMaghMERzyxn7ecCYF6bzBfzHkdP2
 8UFqu92V7bqDGzdi4+36nnIAGd9bAFJSbuXgYDLlZ1oGO6nqSz7Rg7BKKac5fvcIWcwNpLeHiCe
 CoancSPe5S0WWmA/cUD4kEOrxa0lJ9oy9hzqDAG798tya4wjdyqfGOGdXrW+cDnUeJqlWSH0lXg
 IQDZ1y7ElOo9Wb3ccdA==
X-Proofpoint-GUID: GzqDbH3aVOexSxC0BmGMXafjGlGwx3RX
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a84b14b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=tvGfH4KSH3m2s3Kz7-kA:9
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GzqDbH3aVOexSxC0BmGMXafjGlGwx3RX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXy3HeO7J1LJOe
 ObxSWHlB0VgJvQH/jGPUMyuZUiknhiVMYPRuls+fZ0dAL+wMq/VLr5nBHC9bXp4Y4hVT/9625S5
 lDC4HGTqTwB5bX6YjyrO2JYIAAZ6DbQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Now we moved back flags to tests/tcg/meson.build, we don't need to
expose cc anymore in target files.
This will allow us to easily introduce cross containers.
Also, we can reuse the skip_test logic to gracefully report why tests
don't run.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c227bb52381..9c00d21f059 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -19,7 +19,7 @@ tcg_tests = {}
 #
 # {
 #   'name_of_target': {
-#     'cc': cross_compiler,
+#     'cc': 'cross_compiler',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -96,7 +96,7 @@ foreach target, plan: tcg_tests
     endif
   endforeach
 
-  cc = plan['cc']
+  cc = find_program(plan['cc'], required : false)
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
@@ -189,9 +189,13 @@ foreach target, plan: tcg_tests
       if 'cc_feat' in setup
         cc_feat = setup['cc_feat']
         if cc_feat not in cc_has_feat
-          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
-                            check: false)
-          avail = cmd.returncode() == 0
+          avail = false
+          if cc.found()
+            cmd = run_command([cc, '-xc', '/dev/null', '-o', '/dev/null', '-c',
+                               cc_feat_cflags[cc_feat]],
+                              check: false)
+            avail = cmd.returncode() == 0
+          endif
           cc_has_feat += {cc_feat: avail}
         endif
 
@@ -202,6 +206,11 @@ foreach target, plan: tcg_tests
         cflags += cc_feat_cflags[cc_feat]
       endif
 
+      if not cc.found()
+        skip_test = 'compiler ' + plan['cc'] + ' not available'
+        built_tests += {exe_name: exe_name}
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
-- 
2.43.0


