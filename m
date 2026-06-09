Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7643DCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JR-0007LQ-CS; Tue, 09 Jun 2026 17:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JE-0006z7-F8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JA-0008Ft-Hn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4eiw3688333
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ohdlov8MLGy
 MC3fdWCLpt9IUMTgal9ssjm8dlZ3h89k=; b=WLM3vuiRF0tl2ciQb1RdTP17/jB
 /t1+o/wS/5w5G9RZNAZiHINXtihVv+TMyQxPw1naESKBuJe7cbEPmLAWBZ9kyXi9
 PIfFonE6oScq71V/UXK3JEotmgtAn26ts8HJeYQdPV/ihOEvklmTQPZbtCgDyTZ9
 sCjJi5eH/ANmn5gM9zEr83ev7v7Ddjlh+4VIliuzhqz9UtyWZkQefR4Wcp5eeR6I
 aub/+Xy0LGxUv7p01Pp3WWV1iQtbOXtryjGw0UGFWuLcipvo/DR8h8O7MEb4ZSKZ
 S4GGHdjrE+FCyxTKwqX2EqJQhOyjdD6HN/0twqPGbCL9Ws9LhyNXKkY4nwQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epfdt3q0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:24 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383975f18bso53817c88.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041703; x=1781646503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohdlov8MLGyMC3fdWCLpt9IUMTgal9ssjm8dlZ3h89k=;
 b=SNnTLzTGdZ4uSCYsKEhyCKXbsN4NFu23sd3cRRqjEPQeoLnkFAAIZ9fbgKsTJFqaug
 Yr/zRQV7m2WYThUua35f/7vAHqpAvwIrU4SfMj4NyJD+MnXklP6tv5ZyimWvFrKQ8cmJ
 aL7qCAa+D4X7nzuGo3O5SqwkOCK8z7s7x7QGnZf0bGW95bIERHL5M2P31BA5+R/I1bwD
 tCrez2RJ0IjNPkoHSVY2dGD1JCc1CB4FAe89IsvVSBh5aosTLx8IL9i9AyBokAq7ERES
 ORH6e+c+XZHlrGOe5fs78FYw04ud4Mt+8V/sRFkEx754m1le1WPlTbtJyNYFcV56djay
 kOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041703; x=1781646503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohdlov8MLGyMC3fdWCLpt9IUMTgal9ssjm8dlZ3h89k=;
 b=nVZ0ETV+xmUcQIP/CtYJi/2lU7rPJMhMFxcijZkjqL32WsDhv4DSJbhFnjtNsy7z++
 mt5UU2lZzkz5mojOpwy57vsic+knLEH8uLwiZlq8kEHvtR8aJsOwYyhzWTv9etU4snTW
 xttVArq+V7Ok9cNI550l9GbcfkorXntNG9sVukeAGicuSLOTsrUlkDtSPK58neBT+zol
 tuqoQ9enmrZWqcaWS8Ue8ShR5olo+Yd4JjMX+uQH71rjVHzpfR5pRK7dL4jSHfqUoI5+
 8fZTOPua53eK3Ae8aOh5e9Ww2lyhw38DmNXmh/QXZL+UCR/oxC3iM07u7YUxfx3CKNvi
 hL3Q==
X-Gm-Message-State: AOJu0YwNh01W4JEIdTLu3J2Jj+pB85kOiXWyp0UGnjOSCAN/kty1Pt0k
 72xSTWZ81ZYOTEH+RrpnQn8uQiB8/q2ini5pHhmSAN4PsUHWP61mndPEm7xAcTPpMPAcwqWSCgU
 skJWO1DiWsRbvHsZYI717PYFSgXd8vsynRE/E5ZPwj6EsGp/i9KmCR7NVrows3KOTRV7d
X-Gm-Gg: Acq92OF25lcXU52sd7PtSibSU2yMgkgnKhgRB7FyoYdhbGdUq0EfS3mpFg7X/f5o7Wd
 HFsuAWy3MuND/tu0Di1VLPRbm8VdoMeFch59G4LE/Wpjd1LqWekqgPSVcmCHqVHuJfNgDN0Hrvm
 Ip7Hsni5ts4ldx8dfLYe37rTQYyUpRZQKeOtoaBnrJOjlOqZEY8+8SQ4Cqga8Rlxktb8oCv0xL4
 7q1AAvfVvfDhoCTXBrVw36nVpNMFHpFkwEexNSylhukP5M2xxYSUr38vkdP1uzWHjnZ5Kb9/GfI
 4jWUbJXWf0KHy889X2XSaXh1SDOhz03y/DKMuyILHvcFxIezPnfk6wpg+m1OqzJ6rc5fT9H/Hde
 Z2MuzELim+p83CAV4ynN+3zJx4vsKHX+pPMIGymEG+vB+/Znz/xGho/OdXlruT0nmuRs7NvQKSj
 zYJeJ7D2bJi5NwFSB1
X-Received: by 2002:a05:7022:f314:b0:137:fc2b:1efe with SMTP id
 a92af1059eb24-13831a62d4fmr2263843c88.11.1781041703259; 
 Tue, 09 Jun 2026 14:48:23 -0700 (PDT)
X-Received: by 2002:a05:7022:f314:b0:137:fc2b:1efe with SMTP id
 a92af1059eb24-13831a62d4fmr2263820c88.11.1781041702714; 
 Tue, 09 Jun 2026 14:48:22 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 26/27] tests/tcg/aarch64: add multiarch system tests
Date: Tue,  9 Jun 2026 14:47:44 -0700
Message-ID: <20260609214745.772536-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ixxlun5GGfcX9KpO1VlwM5qWDpBtavCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX9D0r5GKsIB8e
 hAXPHn7t9MZ5UvlG4lgmnas+ozLUDza6d6foh14obmG8v9xIklRV4ge5Lg48f8i2eDGs4naDN4U
 SFFh/Gh+ofHASAIWZWEuC1rOw0njfpAYIKWslk0TayeF+gZ5tJXT3le3Fr7t3bkXe0jtEMddOfl
 1ukLD8VLObhel0vMnN/xR7rgG8J0nq/hkhk6LhOfUUkTnf/HXxCHObCzB/6zaFUeBM1reOtvKfV
 K/tr6QdhV2B33mBtHeFxPwmCThznBwYpyEjYtHDbhmH/eoS9qcF9oz0CIFK4oVD1K0+V2HvS4xf
 TnbTr3Ul3054p771xfxClC8aH4xd+r/vjIKStdZrSVdPTwLRRWyDr6mbUL55PwPH5A+DRH/05pG
 ykUw1JxyYd5GzPvaY+YP0eIi9A5V2L9DuSb56nWD+Wy75u1zEK28HPZGWxYCcwUZWTODH44/YBV
 ujsmIYqgEiaP+CQi87A==
X-Proofpoint-GUID: ixxlun5GGfcX9KpO1VlwM5qWDpBtavCV
X-Authority-Analysis: v=2.4 cv=doTrzVg4 c=1 sm=1 tr=0 ts=6a288a28 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=nM4Zb_-IiONNN0rUaVkA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
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

We can now add multiarch system tests. Because of our policy to not
repeat cflags, we must make sure we only add those once per executable.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/system/meson.build | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index a1edf1b8442..2a613cca52d 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -17,6 +17,32 @@ qemu_base_args = ['-display', 'none',
                   '-kernel']
 qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
 
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if cc_has_feat['sve']
+  tests += {
+    '../../multiarch/system/memory.c': {
+      'exe_name': 'memory-sve',
+      'cflags': [cflags, feat_cflags['sve'], '-DCHECK_UNALIGNED=1', '-O3'],
+      'qemu_args': qemu_def_args,
+    },
+  }
+endif
+
 tests += {
   'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
   'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
@@ -30,6 +56,11 @@ tests += {
                   qemu_def_args],
     'wrapper': [prog_run_with_input, 'X']
   },
+  '../../multiarch/system/memory.c': {
+    'test_name': 'memory-record-replay',
+    'qemu_args': qemu_def_args,
+    'wrapper': [prog_record_replay],
+  },
   'vtimer.c': {
     'cflags': cflags,
     'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
-- 
2.43.0


