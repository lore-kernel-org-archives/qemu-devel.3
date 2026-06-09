Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB27CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JD-0006wP-1G; Tue, 09 Jun 2026 17:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4J7-0006p9-V7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Iy-00084o-F4
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:19 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4hmR3229325
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eUbpfzKMn3M
 1pSmJidUcLzHiTy/DIgyN8fNCCWmXYX8=; b=bqAW8rXJRj8GhAkDQ2h9K1R+jZH
 p82TcYSO+z7MiEimxwhle+94HJPsPxMaUSpmi28y2czWFKmFv9KySlif5oVB7HNj
 WgF935UhEfZWjdVaC2LFxiuMY7STwuQdNuwuJBxm67SLizLiwfEuA7Vv5uSX10sm
 mWVhJYHS1cB3iVxom2sOlq8fI/7cqCEu/qz7zJw4RrjZoWELLigE9en59zxhoAQJ
 BXf6leY/ZI2dnxOhZvEurSikeM9bCjNlyhb7toegsSLCag9/7mR61K119ewjPXcg
 Wn6hr9y634awp5b4DVcrUtzFFnf6AtPfRdKk0UlXSxC7yJkanOFk63ZvBRQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wkg1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:03 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383975f18bso51914c88.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041683; x=1781646483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUbpfzKMn3M1pSmJidUcLzHiTy/DIgyN8fNCCWmXYX8=;
 b=UO4Oicop9EHNdSA+dYrX7zkQXNPAiB7cpahMhgVnr6nGygm8dmo9yUIptAWo6hYzgR
 5M+ybakU2SMxVAMaBKk3tN9yXEBbTdeKuiO4dEA3a1582gAc/9GfXZKX3YvRBXBLNNT2
 dYlUC8VPEFyLEYTtt1M6jfTSI4PSJC0jNPBNcTqwM30xpdSl9lQzEeGKeHa286+Y34ij
 mdV3xDXsvuM+3HTqEng/qfhiqiq6cF4KdIkqJYXcBSJombEr/Kqo+vELwdiJ7oZp0ezz
 s5xXY/PhkOD9b2WvPfSh78tJkzegInZ8FGuZdJLiNSRmvXABTjX/mkJ/MYoyfM8tj7mR
 nYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041683; x=1781646483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eUbpfzKMn3M1pSmJidUcLzHiTy/DIgyN8fNCCWmXYX8=;
 b=YlTmj3HktuHjYWZmFjDnc9CiMME0SPBOMzjZhbX6HDjas/M8uQEvziCCAlvP6+MPIp
 iHw8oUITTj0zM5qVktACRkfrwyi7aiFQ9b0qMXtDlxzA+/zKZMlIkj1s0iTv1R+I5d09
 q2iEPQpgVKYk2aoreiozAtMOKpDC+97p1okezPyBl5AUqRqCkz3vU8Qra/a5lj7z2bVO
 Y0LINlwUZucmMffoppfnwWEaKPvwTmjpm5TrwVd0X+faLfzYzMC+PjWQ76ZEE7moTmnQ
 ucbMQpWaUKYSBPfsKQT4RNXBYGhsqcK8ha4dpcANIruVZsO0aqxekty8sLaX+VY3wlqA
 gVYg==
X-Gm-Message-State: AOJu0YxszkyOYaob4gSrZz2MPlSPTHR8EyqWxa+vhTKeoDNh/VfEn3V5
 7x4mkURriQc5nfy/JSjsF2X0o8824rasU7MzWOAdynDBL9UOOMIefzvZP0YsTLAvHmNTp8ixxyM
 LPRL6d2nu8mNiYNAlPiEH7B5Wt0aT+KIYFJi+XcOkdKGibiqjOnbXetX+X4vR8aN5BRIW
X-Gm-Gg: Acq92OEFgLAgjOxqSua4mhTnrZDcv6mG1Zp9pP8xkLBwpyEzoCVIAdznYYQJKAknfiM
 Wpy0Z4ErsisGULTZDZnjeawJ1ZG3Jm8t0DSe6sP/qMc/6XXI5yOmPY/DulMX2WwGLDnYu/CrGOk
 3X49/CLgcm3wMH5R5InXpPEdjIwnTekah68vVw70o/LKmGI8GuLFFAYXREvVKNufMYtekgspuTD
 3kGYoETOdybRVzON2+MQMaypYlVwtw8gtsfOBbfAXuaHCHaBXm4oiLZ5CtJbWqbibgX0yWZAHyB
 F0Vumebb7FudW5Hm39/VvWUB1Wf+iFOyjn6eih+qCn1hEzGyMZ3eZThV+v+XoHBJ11xsjJzCSE7
 qY/QK4jy7TGLLe8FRir0u3tUABajYJ7E321u/Qn5JSuWbnW6v+W9o+Ej/ErmHzLFkt8hAJqqh+h
 Ns6n0eqOMtzgq0mzu0
X-Received: by 2002:a05:7022:2595:b0:135:3025:be5c with SMTP id
 a92af1059eb24-13831bb3d63mr3561222c88.27.1781041683058; 
 Tue, 09 Jun 2026 14:48:03 -0700 (PDT)
X-Received: by 2002:a05:7022:2595:b0:135:3025:be5c with SMTP id
 a92af1059eb24-13831bb3d63mr3561194c88.27.1781041682534; 
 Tue, 09 Jun 2026 14:48:02 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:01 -0700 (PDT)
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
Subject: [PATCH 10/27] tests/tcg/plugins: build list of test_plugins
Date: Tue,  9 Jun 2026 14:47:28 -0700
Message-ID: <20260609214745.772536-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX7nPzSfftogUJ
 Um74AqGqU0A84PAM3x0dPGE4Um9Nqw5wX5tSipuYiwwhjiKP7QUU6yFaqj2KqCwbrgpCiikCx63
 gg0dMUF/gznKjgvLZfNhNV413KSgEwQBieAsKXFIRGb50sWu9cMvy3VU2eawG+7gAjOauBPF6Yx
 U8YBZxu7s7+4o7UTU0/IfQdufLWaZ8YAtbTb6zH6XO2ZSgl+QBG9aQeKir3rmR264dbTKcNHzmj
 +Fi/+9cC8ckBMJcEqA2hDX7bUikYpKSyxP+MS48ANwU9J7O9VkDqfkjJ11pKtTptQvAgMafE/ln
 J353NL8JXGifB/KLZeDyjmJ0FdM2WaCp9HW/JqZyqYuMh4eKdnIRQbY1pJFfUpiEqpHKlhh/UXh
 tTYLRm3/DovWiOg1dgd4bnuOP/qI2aAEHpFIDkhp3JX8a7K/RS0aj9O2+i4YKhnXe/INxEhKiVb
 hMz5tD0U8TYBuUD7SOw==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a288a13 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=mwllZrKobXNPg8A7wcwA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: Xj1pd6XmGJnaoXSdb8w4hk1uANio71-W
X-Proofpoint-ORIG-GUID: Xj1pd6XmGJnaoXSdb8w4hk1uANio71-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We previously had list of test_plugins sources, but not the target
themselves. Create this list, so tests can then reference a plugin by
its name from there.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/plugins/meson.build | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index b6a375e9eee..5cd80f3c030 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -30,6 +30,7 @@ tcg_tests = {}
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
+test_plugins = {}
 subdir('plugins')
 
 # Finally, we can create all test executables and test targets
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7f8f0ae0ad..2abc317d1e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,4 +1,4 @@
-test_plugins = [
+test_plugins_src = [
 'bb.c',
 'discons.c',
 'empty.c',
@@ -14,9 +14,12 @@ test_plugins = [
 
 t = []
 if get_option('plugins')
-  foreach i : test_plugins
-    t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+  foreach i : test_plugins_src
+    name = fs.stem(i)
+    plugin = shared_module(name, files(i),
+                           dependencies: plugins_deps)
+    t += plugin
+    test_plugins += {name: plugin}
   endforeach
 endif
 if t.length() > 0
-- 
2.43.0


