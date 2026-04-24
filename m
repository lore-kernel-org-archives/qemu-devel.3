Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F31CFF885C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGPWm-0000sQ-Pk; Fri, 24 Apr 2026 19:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGPWV-0000nf-Ug
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 19:01:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGPWO-0004Ym-LO
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 19:01:19 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OLp1Kk3724597
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 23:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1M0G2MAUiu5
 P1kUDffZ343P1Cx0BWZfKyzwGOnhMS6o=; b=hy3Ee/39OZ5+xDcgCMQKw5Q7b+s
 e0p5fHdlHMI7K2qvJLu7s8ezzmfHUMp9ffPTTtCdBqnyffiJDTaBvoA2IVtG0KR1
 ALTuRbvSXazkN/c7c6loWgS4oElc8DqELiDgnyojW35kziDFN9XVQxzuPWPSLUOg
 i+rOBW669Yhe2d5h7D+ke3i7cFyFgFSlU58BMolnhblYYrIL4UYZgZcgbK/u24Vs
 NEM9XrbpI1xYG9C+FpiWwbdLJBFk163uOk42GHSwB199zPVZV2IKxXz7FlASV8I2
 mJ4lchk5EZn2drks32JBAMEddObyE7Qji5at6Ug1ayxg/oey18l8XtxZTyw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drbqg19yq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 23:01:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so13087484eec.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777071673; x=1777676473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1M0G2MAUiu5P1kUDffZ343P1Cx0BWZfKyzwGOnhMS6o=;
 b=emBD/9B3CsAEISXNAwTlYYyqKeWbBg81kmpdIc5iUDg9v17jxjxZrDsxF5NKZCou7Z
 Y0r91PCbWGmTGZKNe5+StUMxpa4U9ZlA3VLhqVPS7nscTWu/w9nveP7N8R6j9rTtpVc9
 Yupotzyr175w7sPyNqUG1HvmzApEZ5gIR2g4wUNkd2pPQetuPEU59iGPdHyqH9B9OTmo
 N4BcT1lNBjheFNX/ycHUIuhd/Dq2kHV9B8i2sHOCYHGKeY0k8lzIltKxhJr8A/Ldl6Hn
 Z6P3GK8vAt4DRx/2XsOr3GQdLjaD3QJcZZfc3os7w6vkPcYump3VoYHhAQIfj3BiqLoh
 N6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777071673; x=1777676473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1M0G2MAUiu5P1kUDffZ343P1Cx0BWZfKyzwGOnhMS6o=;
 b=o3Aw0K4xR7okhT/UM9rHSyOGXpxLrhmscPQeP//ryrqEx8Ono125TyLuM9rHi4VfdE
 NCW4Ss5VCbwYhOfP79/qzVD/1hvRyVsIDvDqWuDZQNAXInq0ldWnRbhQieQxPzEI8AOC
 b/pa6+U4KuS2GyxGvrhtI0QHvyXfF5XfIf+uWdLO8EJmB+FSBOBWvANTrBYMYivZXdpL
 VvIUrpygXoVibvss3Yv2QPNlM5pgF6bY4E44BM6OCemPmckQoQw2UbIx5d7J/lA9cbZb
 A1YQNkpL85P5lXhfTIIhttojsyBiQlluZ7N9920mKXwF/bZr823Uae+0TQU1b28r6QbT
 Qlvw==
X-Gm-Message-State: AOJu0Ywm8pBxOhuxpk6ZEmw8cgg8/eGhSnj4MehpfVkDz0a/j2obd7Mb
 Pc7riTAZdkmQf8I2KshVf9rzp+LQ1st+FOGPtFOSSUXH0IPvDupmVm8SewfI7JUYRuWDCvvi5+x
 G9oL+ONCpUcze5r0GjvxhGXG4tE1e3s8N+gep3i3He8O37Nx9DHg59Swnb/Fxgid6gfsP
X-Gm-Gg: AeBDievPH5VTKMS1TuNgaxUT/GK/6Qhf54bX/gU3d4Kqv3/OTB2mID24LIXka+xsiyq
 +M8u6u9tZBHImD0HYGaVTl7btjXd9IAN+HxgJ+YCKYGVQtmkmPlexkKUlAfa3IVXU8fbmmN2/ru
 55KKlbjIHf88kjpCrPjDUtB7pe46kqlOgVQWPvbFD33hvx9hGcF5SBqZAFBLzCa7PUWhnvNKbIQ
 HhCboP+53/k3rm61NhRKC+l92X/+erjVbt9b8rF9kplQ5N6hjGyrpdYvBvsEZQWzW0fVHyEs4/P
 TZaO/RKWmIPYFXK4lCE3p/jMgl2o5O5Q5ucQpoMLGPHA7u4sbfwePQ6wT3ZgL4r3MlBzpmn33ew
 4lFgf22KIKmCEAwFSrFeaasag7BL3CYdLHpBoppgbMfPAiERmfSfGmEgtH6heloZBaC/UysgJRz
 FIYaLaEyL9fGkvwYvq
X-Received: by 2002:a05:7301:4288:b0:2da:2ec2:64e5 with SMTP id
 5a478bee46e88-2e479c042b2mr12729881eec.18.1777071673053; 
 Fri, 24 Apr 2026 16:01:13 -0700 (PDT)
X-Received: by 2002:a05:7301:4288:b0:2da:2ec2:64e5 with SMTP id
 5a478bee46e88-2e479c042b2mr12729858eec.18.1777071672469; 
 Fri, 24 Apr 2026 16:01:12 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d8b944bsm34075003eec.28.2026.04.24.16.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 16:01:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/2] meson.build: define stubs library per target base
 architecture
Date: Fri, 24 Apr 2026 16:01:02 -0700
Message-ID: <20260424230103.1579600-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424230103.1579600-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260424230103.1579600-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDIyNSBTYWx0ZWRfX2rdXwv5qCLxx
 Uu5+7Z8qkilLj4BHmutQ9HFas38giaLfIapjkzyg6XzwxN0/4jS02EecMFdYrMZu1tkH5odxXrg
 A4bgQunD2Zfw1XqulOV0l3FIQVrZNZfk4puAbg2RCBcbJRzQzEkQ1GIuCk872bhFCisiMDSFJCN
 w42hHtpO7esE0yEaJ2mjwX8GBBycbkzKkDL3SUojgnUe2X7g4lCgm4JDmFnzcAmd3P4PSSBuYoB
 Up+kWF1el78yCqDaVxDysFSzqZLAEBr36gncdWKxvJjmhnjKxQMGoTpYSehP3D8L/A9RnIr8qNk
 Wb9r4dkr5Sd8r3fPQafMVOrpDdYQxLwn9G6ZuarSGzIjZ5JzD1BL2COafxTD8+S472t90m/dNSr
 NJetSvqQr13i8S/1xkRT9NpjERAQKOrmEWj6KeBDPnOipZNoTQC+LaXHbAs6/BwSIEYTMFSzYNh
 QwyP+ZqJXxF6uR0DWkg==
X-Proofpoint-GUID: alyC2hac1NCG_BQy2Y9QZb6lULPko__m
X-Authority-Analysis: v=2.4 cv=DKu/JSNb c=1 sm=1 tr=0 ts=69ebf63b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=vAAjUAkajoglRl0kLfkA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: alyC2hac1NCG_BQy2Y9QZb6lULPko__m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240225
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

QEMU stubs (from stubs folder) have a unique feature: they emulate weak
symbols. Weak symbols are not supported on Windows with gcc. This is
achieved by defining a static library, so the linker can pick a file
only when one of its symbol is needed.

The problem is that common stubs are embedded in qemuutil, which is
defined and created before any target code. Thus, to benefit from the
same feature for target code, we need to create stub static libraries
for each target architecture.

To keep things simple, we declare one library per target base
architecture. This implies that stubs are compiled only once, and we
choose them to be system common files. This is not a big issue, since
stubs definition have no specific behaviour, out of returning a default
value, or stopping execution, which makes this safe to link them in user
binaries also.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 096303f021c..d5f4fe25928 100644
--- a/meson.build
+++ b/meson.build
@@ -3742,6 +3742,7 @@ target_user_arch = {}
 hw_common_arch = {}
 target_common_arch = {}
 target_common_system_arch = {}
+target_stubs_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4147,6 +4148,7 @@ common_all = static_library('common',
 # construct common libraries per base architecture
 target_common_arch_libs = {}
 target_common_system_arch_libs = {}
+target_stubs_arch_libs = {}
 foreach target_base_arch, config_base_arch : config_base_arch_mak
   target_inc = [include_directories('target' / target_base_arch)]
   inc = [common_user_inc + target_inc]
@@ -4206,6 +4208,15 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
       dependencies: src.all_dependencies() + common_deps + system_deps)
     target_common_system_arch_libs += {target_base_arch: lib}
   endif
+
+  if target_base_arch in target_stubs_arch
+    src = target_stubs_arch[target_base_arch]
+    lib = static_library('stubs_' + target_base_arch,
+                         sources: src.all_sources() + genh,
+                         include_directories: inc,
+                         c_args: target_system_c_args)
+    target_stubs_arch_libs += {target_base_arch: lib}
+  endif
 endforeach
 
 if have_rust
@@ -4365,6 +4376,11 @@ foreach target : target_dirs
     objects += lib.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
+  lib_target_stubs = []
+  if target_base_arch in target_stubs_arch_libs
+    lib_target_stubs = [target_stubs_arch_libs[target_base_arch]]
+  endif
+  target_stubs = declare_dependency(link_with: lib_target_stubs)
 
   target_specific = specific_ss.apply(config_target, strict: false)
   arch_srcs += target_specific.sources()
@@ -4410,14 +4426,14 @@ foreach target : target_dirs
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
       'sources': [main_rs, files('system/main.c')],
-      'dependencies': [sdl]
+      'dependencies': [sdl, target_stubs],
     }]
     if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
         'sources': [main_rs, files('system/main.c')],
-        'dependencies': [sdl]
+        'dependencies': [sdl, target_stubs],
       }]
     endif
     if get_option('fuzzing')
@@ -4434,7 +4450,7 @@ foreach target : target_dirs
       'name': 'qemu-' + target_name,
       'win_subsystem': 'console',
       'sources': [],
-      'dependencies': []
+      'dependencies': [target_stubs]
     }]
   endif
   foreach exe: execs
-- 
2.43.0


