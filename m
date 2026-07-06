Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4D3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxM-0007yJ-Pf; Mon, 06 Jul 2026 18:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxL-0007oH-B6
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxJ-0006sQ-Hd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEPDv1639973
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=arLHQl1tTBz
 rHDTsGzP3d93P5D+Whv2rggo17Oo75eA=; b=UEJX9uC16b+Fww3QdWAQiHDnK74
 l9EHmOY82txI2+ezJlroLTxQ7XfLcRfdw8QuCyhHLD+icjmvL38ELnUsEjlBxQZA
 4pS2FnGMtFyuul28EIowi/y8KHP5cDPSnfpJyvvxwNeqNSud5gDYygLdREoQBFAY
 o86VJVrbsQh0+0OJ+pD24gUXMbxdEWLcoU1/dGPAERAqWJtlODottFlRMqMBHUBo
 plNWv/I9ZF32WBNI4eWMCW/Z1YBfU0AQcFK521Rimcv+kl10d1EGQgJqhlpuU+go
 HoWM7ae73eAvf9872Q4rCd4axG8n1n4FpuGntbHbtWBT3TA6jT4ZG27Pnww==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r3588-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8895156101so5376617a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377504; x=1783982304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arLHQl1tTBzrHDTsGzP3d93P5D+Whv2rggo17Oo75eA=;
 b=PsvkMg/fHy268zSFCzeRFgEwbtd8vPeEaro3W65Ye/rTsqMmdKPGCd53lPkv9aaD1D
 fZViuGsIieycs+Et8/wUz8CWN4faRjr6aio1kPpqvKJkTkhOpWyUYmwZylNHrw1b6+H9
 rDRAag+q7/ArdEWdWBnrEnHOlZyaUFpxJOHcMkATcdBoE2tGdA/89HVY49OUoy0Yz6Sb
 Yn0h/w6DUZRnqrBZ5d31SLtAj4rAazjwKz0kJbNbDuDvPvn+hhjAcyGoevX1P06TIQc5
 kfR2KrF7/HeoKqgqmQaAQNN2Mh4wPuYXNs6L1usTfvqme2+SD1d8RppWIvxdBw/pgcfo
 JqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377504; x=1783982304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=arLHQl1tTBzrHDTsGzP3d93P5D+Whv2rggo17Oo75eA=;
 b=UP9Ns6WkDP0JazriRFQ0LnKzA42zAp8C+JwtpHYzdDETgcFHdIylCJdkNGsLkkSsoo
 e120Yhcv9fsQkk44C1P6CsMMfzxWQ5hHapY4Kp9v0DDBmcQRBX+IubtyNOu4HZExY8ZX
 fqcLkpPa8w7U/GvVxKHrv9OzLDHfkh47o6e0dUg0FFxBscuseD2o49M+HGYdsqi/fDWU
 PKjB/YdJYJsaB/iD0kzWwtoz/ke+11HKd4Cws+UqIWAiU8dwxIs8/HxopflnC0WoVG24
 is3Yxu4g+x8HpcsbUiUWxFu8cwGBcICvNJkxL4jgYnEzU+msKgRZZ2X5Qpg120qs2UqJ
 S3ig==
X-Gm-Message-State: AOJu0Yyj75QHpvTNKKNQGTnrzMrK8u4bPsnuE0ByeRh3dALeASrwotDv
 GcdENP0d+XRYzY4EHnx2pPYLDK+3x5XMohoA0MkrGCzNPjj7OXR/6mLbfIktmS8Yvuevy9gC9W2
 4DbL3jtS3ss5inb4iiJtUQFk3xlwoANP1LK9CYKuMovVdUhl7OKXK8KTsbKyDoUAWVA==
X-Gm-Gg: AfdE7cmsuv+1N8WR4/B3FECG6m17Lq6ReHm29/OGSmGK4FGYWfdytSHqq/Bka2XOfI/
 Q6YeumfuVU1kKpdJ4dZ9S8AKIa6PTFg3W4ykACNY93nbFIExzmk/Be9TmdK+IjpSie/mxNPA9+Z
 SfvUCZG9yKtRvTUFMVAsqMRcLiTPdvX11U9ZMw/IQJIr5s6b2hN865ERIUCuyJgEEeON+fQ4D5w
 ij0LBxSLEniEWHsMeRrajGuolmurYS/kYSuwqQn+t8p/aK05jaFvybvILlvx5TNH+wD5btVNmuv
 5aE997VTXPWslwiexB7zXrVoyXzjZzpt4vLM2YHo1s7AtM9klM5IvfOkMh52aLDZC6d8wLcYpN+
 ExsB5Mlx0zHLVD4GU2hBGfm+qCybY7kmjDGjtfdzvF1RsSPvnOziYkNIIHenwD6oulMMM90wf3x
 JqrdQLQQ==
X-Received: by 2002:a05:6a20:7285:b0:3c0:9c19:65ac with SMTP id
 adf61e73a8af0-3c09c19688bmr89671637.68.1783377503578; 
 Mon, 06 Jul 2026 15:38:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:7285:b0:3c0:9c19:65ac with SMTP id
 adf61e73a8af0-3c09c19688bmr89640637.68.1783377503124; 
 Mon, 06 Jul 2026 15:38:23 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:21 -0700 (PDT)
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
Subject: [PATCH v3 50/91] tests/tcg/i386: system tests
Date: Mon,  6 Jul 2026 15:33:02 -0700
Message-ID: <20260706223343.988769-51-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX1lkbVO073Dl2
 4JhLtbtMpWrAWunf+CIBiWhmiRu8nhmH4TeX2kvMqM3xwPOrRiE07JWJIShkYg1QrDf/sQW968t
 Ob1y9WXG8HE18av2KH8FvVUC4VSihj+1Ywn5/9VVrAkpUBWyWNp5dRXDVlJznxkvcFDr51pjy1F
 /+qpJL2YZ1BuQ9fkptrq6MRRA6OsdITm2S6m+sHBvSIwmnWY/9OgzRexEGOLxSI+EFVl+e2PQp3
 LvTpbDMmd4gNecFCTxAvNvSx3KUU36cqv1Oj1c/kFweMdzXyORtVfPq1FuosjFzuBDS1y5WcaxQ
 HEP0sLkNigMDVEgWdvt30V3bqvKtFJ1rZhJbECKcTOzWq5KE/p/TK0zCrO2HarFjNhCQKaHztoR
 sry+RlfOEsvK9aJKf9Uf1Z2O8tua++P4NW/90K45isHXfTaFI/zgTDyQrWlv/z3KEbZW2zU9DOe
 0r45+l00NvEFCf2flqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX3NdSzXd4s5tz
 7tgscSNsXdeSpdQHm96gZ9K2Y5EhY5y7WBJcTo0Bqo4lcYH1zgSLq/nzeL3tbn1pOkV2KcJoYjz
 DiW/V9+UTEW+6WJF46f+8hEGpryd+FE=
X-Proofpoint-GUID: mwdoIeFgV9Lr0jTmSa7CM_aInPSMhKrs
X-Proofpoint-ORIG-GUID: mwdoIeFgV9Lr0jTmSa7CM_aInPSMhKrs
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2e60 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=B10MwvMbzDGICZWKPU4A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/i386/meson.build        |  2 ++
 tests/tcg/i386/system/meson.build | 48 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tests/tcg/i386/system/meson.build

diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 858485ab62c..c66fa79879c 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -2,6 +2,8 @@ cc = 'i686-linux-gnu-gcc'
 cc_dockerfile = 'debian-i686-cross'
 cc_docker_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
new file mode 100644
index 00000000000..7473f7e1c1a
--- /dev/null
+++ b/tests/tcg/i386/system/meson.build
@@ -0,0 +1,48 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-Wl,-melf_i386',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-device', 'isa-debugcon,chardev=stdio',
+                 '-chardev', 'stdio,id=stdio',
+                 '-device', 'isa-debug-exit,iobase=0xf4,iosize=0x4',
+                 '-kernel']
+
+# Multi arch tests
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
+if 'qemu-system-i386' in emulators
+  tcg_tests += {
+    'i386-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'i386/system',
+      'gdb_arch': 'i386',
+      'qemu': emulators['qemu-system-i386'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


