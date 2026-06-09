Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A63CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JR-0007MC-N1; Tue, 09 Jun 2026 17:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JP-0007Je-Bd
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JM-0008Dy-A6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:43 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4El63229733
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kZkSQelKc0D
 nO1UT5BgQ7/HImZykPe/T75yFvbdrt/c=; b=Bdg5mO0fEX8DzfvcPxqahSFOKWN
 8X6ZMKOsSma3e6VWghuxExUfRScRS8JxmnIxH4djXIFOWr/0ZoVl9Iz72IebxnRK
 jLcEki6bU2k1jO8jXupbFI8aCRNnzczyDdgw4+LBqusVSN8/wSYSnRLk/M8XKyYf
 niWkeVUkqO8qryag47smogJRRtTAYfrFpZ/2/XG13LUxmNDh/XHCsk9d0BS5uNSl
 EEUgW8acslnY611WbD+o2DG1/UO9LL78XtL2/4VXFnZtHImueuQoTW0FjIeAQBjC
 WSaYIPBuwPLDFxU/1LJut5Y7DdSCdx1M4TyBVmCSyWEWsccPhf8DUauhLsQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgkxry-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:16 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13709ab38a8so7310146c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041696; x=1781646496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZkSQelKc0DnO1UT5BgQ7/HImZykPe/T75yFvbdrt/c=;
 b=Ahfufx8cdFwhZj5t/0pkmcbGJieHY9WLW+a7KQm61DMR9FQpN+ksMN40vk7CTHHzpL
 2A4SZQMfrcM/bcrsVw5qzCFbQsJVV5NRvKAuVpi+Ab0ePclryEuVEz9Zon/egJumKn23
 GGvaDxZnwM4yy/N+R/lpHhTb2tV3uSMAX02bfOGWdptQJuKckgjFNWeDpUzIZW87XLPs
 GzhUr4Ndkh1JEa1Qz3xDutqOtFKbDSofX1SSJKP5YdsGFLHD+9oZmDn0aYM9HIRFcJOl
 baJ5nVombFKy7woCiBPZSVQaEPODwvKqF1FYIq3/POOLI67mJrPXyOd+u70FjjhKD5z9
 qv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041696; x=1781646496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kZkSQelKc0DnO1UT5BgQ7/HImZykPe/T75yFvbdrt/c=;
 b=fjUjY84mAfv8cRmtypF0ZoN7/QLER816cRK4g4H3+3dogJEf4O/VxZKhIOOIH5Nwsw
 iHiE4FHYjiSi1dPIE+Y99xpn6Q7CcjDs2qXOwhHPU8T6XorCPX5qF+3rLk6sOHoo9lpL
 NSEEHLoHQ+XfSpyLVO3lEqq+XdtO0nXSXmtTszND3qiiW6KTAAlTLVsSv0+GnnDTGqJ+
 SGfh2j3Si/4xy1S0PNsEf035xKW0DOdLK5I0tPmF3aPws5osDHdynxLFPm26HJmX18jo
 cuCUgE2qJq8UyeBUrYw1X6MZgaOrLEwBKeIi1exR2rOySoeAgyuHV/GYEKdFQbO6fSqJ
 05uA==
X-Gm-Message-State: AOJu0YwobU2jgAKBIGrPBwK7NuamIyETJDXWvrWgI5bOvnjmk91B1iDg
 xpdso3eNrgtL5Y5MSiZ2hANTE6aPgRcNngyzpAA3olHqFGg6tf33vCUfOxVzXyM4GciWl7Izr0b
 TqonZ26GFEtD/jvoGeDFV7HPYc3MaQ2VBSRABr1WJg5VjArDK9V3gHkS91C2SpX+T7PcW
X-Gm-Gg: Acq92OG1ybIDR25edV+kIrnIjkdSAjcoWIr7g8xcoZ+LxNFRRq3s5E+fFK03yJwwhFB
 S2UKqgNC2obcTcSq+x1TvfGksT8NvnpNiqVuCg5CueWXwktQPe33PcCIT375BWTXNO0QCYujRAf
 3zLoMAebKhmAjpcCn4apMeK1GFy9QJBrE2oS57Zc6qRraJ9lwRkiLXR/CDvlpmu5A528ceJnKbj
 07owNMX6UPOODHahLxvfAB0b+6ixqXkJRBUjA0yRFdzMgwFhnozfWh8Mm4ckX/gQLaPT6jcekID
 anvr6qHYUuYDVFicorEKkFJn9ds5B9rmhA0z6mhy4cgG/zkVXzmJbnC2xB2Nru/0ucwdmtWlXey
 T61o0aQMy/jQKPqPzJj1Kq0vTX1k8264T9LwzPdHGxWXtMPUmHv1qz/JkSEDi4H7fu3Lquphl9E
 4Z/u7WoAtK6vW8Kokz
X-Received: by 2002:a05:7022:ec1:b0:138:37a4:fcc4 with SMTP id
 a92af1059eb24-13837a4feb1mr583205c88.13.1781041696068; 
 Tue, 09 Jun 2026 14:48:16 -0700 (PDT)
X-Received: by 2002:a05:7022:ec1:b0:138:37a4:fcc4 with SMTP id
 a92af1059eb24-13837a4feb1mr583178c88.13.1781041695477; 
 Tue, 09 Jun 2026 14:48:15 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:15 -0700 (PDT)
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
Subject: [PATCH 22/27] tests/tcg/aarch64: add system tests
Date: Tue,  9 Jun 2026 14:47:40 -0700
Message-ID: <20260609214745.772536-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfXwtGkyekYqhUB
 zYzYavaltqiRT6+isdTto4qoC4rKcqrlO/lGcFAcLlkE0oUmN7DjvKJA1ozY07w/pkzd7dqR7Xd
 SRtmN2wk2aWU1u4nBhR034MKzXb+iH0leaoRXlFp9lz+7A5Katt1ClwpRWFpz/R1mQEHYwhGoZY
 +5chObjkmTYtXwOi7TCyV5+tL4+0nHoNIdiLfXKzSZTnQ/MX+wpGwOkkuiw3/ikqcYWvYjFAr6/
 HwDv2gT/rpjanzuRNntGgh90W7d75wvomsc2mp/LHZkYQBn9T9w9GABPJDPTJqRDNDcfBmSjGie
 BsgjOW8k7TiK75TLyMtXN6tEJx+7/b7DFJnVEeA1LND+03lp183pcJmltpBuE+wwchutzWVkcC2
 +Aw8H3aid6cyOuvzJ6nA7LlOmQBuePmJTxqSfbG37RrqPdM2XmAWe6wtsB9+5T8I1aOjZhNEQWQ
 9zhKYiO4pEkBwZ7s4Zw==
X-Proofpoint-ORIG-GUID: a_U6bi07BFssgL3Z3iMznzQhPBxXqA-_
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a288a20 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=VjnBZxq8liE_eFJiS68A:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: a_U6bi07BFssgL3Z3iMznzQhPBxXqA-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
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

Let's continue with system tests. Take note of how we don't generate
intermediate (common) objects, but instead provide a single build
command for every test, embedding all dependencies.

Besides reducing boilerplate, this makes sure we track correctly all the
dependencies for a given test. Compilation time difference is invisible.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build        |  2 +
 tests/tcg/aarch64/system/meson.build | 69 ++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/meson.build

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 9c42b129551..e6cf5309649 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -43,6 +43,8 @@ foreach feat, min_ver : gdb_feat_version
   endif
 endforeach
 
+subdir('system')
+
 if 'qemu-aarch64' not in emulators
   subdir_done()
 endif
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
new file mode 100644
index 00000000000..a1edf1b8442
--- /dev/null
+++ b/tests/tcg/aarch64/system/meson.build
@@ -0,0 +1,69 @@
+if 'qemu-system-aarch64' not in emulators
+  subdir_done()
+endif
+
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script]
+qemu_base_args = ['-display', 'none',
+                  '-semihosting-config', 'enable=on',
+                  '-kernel']
+qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
+
+tests += {
+  'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'rme_gdi.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'semiheap.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'semiconsole.c': {
+    'cflags': cflags,
+    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
+                  '-semihosting-config', 'enable=on,chardev=stdio0',
+                  '-mon', 'chardev=stdio0,mode=readline',
+                  qemu_def_args],
+    'wrapper': [prog_run_with_input, 'X']
+  },
+  'vtimer.c': {
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
+                  '-cpu', 'cortex-a57', '-smp', '4',
+                  '-semihosting-config', 'enable=on,arg=2',
+                  qemu_base_args]
+  },
+}
+
+if cc_has_feat['v8.3']
+  tests += {
+    'pauth-3.c': {
+      'cflags': [feat_cflags['v8.3'], cflags],
+      'qemu_args': ['-M', 'virt', '-cpu', 'max,pauth-qarma5=on', qemu_base_args],
+    }
+  }
+endif
+
+if cc_has_feat['mte'] and gdb_has_feat['mte-baremetal']
+  tests += {
+    'mte.S': {
+      'cflags': [feat_cflags['mte'], cflags],
+      'qemu_args': ['-M', 'virt,mte=on', '-cpu', 'max', qemu_base_args],
+      'gdb_test': ['--test', files('../gdbstub/test-mte.py'), '--', '--mode=system'],
+    }
+  }
+endif
+
+tcg_tests += {
+  'aarch64-softmmu': {
+    'cc': cc,
+    'folder': 'aarch64/system',
+    'gdb_arch': 'aarch64',
+    'qemu': emulators['qemu-system-aarch64'],
+    'tests': tests,
+  }
+}
-- 
2.43.0


