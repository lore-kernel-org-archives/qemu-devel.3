Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055BCC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5S-0002Lr-1S; Fri, 10 Jul 2026 17:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5N-0001im-Bq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5L-0004kG-EN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3GfE1841663
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HPtdWvO42US
 fsHbli/9HH1OCYGTZ6iK0GcVGycJqtfs=; b=RN8PIR1rs4Th/DkqoGc4jF02tb+
 pEJHMJBridKmGBpw37zAMl5qEoNrL9tMHs0NOqicHRsUI/FszaQmM48KQx2ypxT7
 A6nQei4/YxAT5H/sYiLj8QeFQf/u2k/MPCpkUOpu7p7FAZytUG94ZEFGV4RqMiCg
 ex4uss4aYnQ7ZBSfofVk07cEnzLz9IEUz/I7hWtCj4vhy5RMvijfrQWBUko9ZvKs
 gqTvgdFpwhKRstrHdeBAw8JzbEjC69eaFFWnHE7WYPjWxwK58FlII84Wwn0xG7N7
 ThE+tao/b/E+Y3Z+Yz5o2SleMueWuy3W0qG4YpZgabcL+0MlXJh9IEV9gfA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xn13aw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38c7de7baf1so1514800a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720106; x=1784324906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HPtdWvO42USfsHbli/9HH1OCYGTZ6iK0GcVGycJqtfs=;
 b=NK6jsOSnXiTuNOhWJoTAZQiF3cn+pxS6TiGwwurYU6n8Mq82qjetVnN4OLq3wmgHiw
 nf9NOvPyOKyf9TTFD5YVqPf1xYkB55vW0YzKMusUAS38x57krF/c+6Z463UwEDDPErCD
 Oqb3qJmjLOaohDDQ8cUJrMjP6k63bm7tkz25QnOoDCkl3riahTr9JP4K6cDNNdODBlxJ
 qtG4z6D622JeIl6z7MKk1nmkW9+2/y4+8Sd/ZAw//Dq5JK7AwVKyuH6tUkoBZ8Ye1tZg
 mKWbRi8XIwDNw80xK+JR9djkxBe4+TBDOZW/5fGY0iRkHW3+4BZN2Lly/wumHgBCgEOZ
 7jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720106; x=1784324906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HPtdWvO42USfsHbli/9HH1OCYGTZ6iK0GcVGycJqtfs=;
 b=G0EiBDD86jfO/2mD2VA+IjoY+mtJgoEIiTEOf9QY348rj636Lch+ULahf6imj8bJkq
 mhrTO6X/UZbS8/LcEKPTFKB/Bsmim6ailMa0OB/0Jd+NVMkV7JIFhN+Aie6UVrkyez0a
 V3vAWrmrruafhjsPJZGiSHuXwl44N0ZQsBxqiCEWDxb339oTjJrueHSPytoKXqYm2/2n
 AEerjXTQnUNW14rmMS8vD76FYa5GLh5z5ryizFv53mzTbSXgn4LC/cGZgk9VBSuWK52P
 wD30NSB37ZMrYty5U20UtP42Ct3HZzOnVrMXZbCVhRzCBA4Lj1KRxrxA5WfETC6I4on7
 ud3w==
X-Gm-Message-State: AOJu0Yzdiszwj1wZajV/q6jyAR0UbxCj8RkMasRaUVhwLbvtG1JDeKx4
 z+T10eh796hz6exgUzt1FO8Xq6ldBOhqQHQLSmMajA37iaguBPa+dmPn8Y3OVRwdM44LH6UFoA0
 onH5Jv6s1le53ghcOb6muLwTdXwvcARqxtkWbtpDtUZMbirjcPAYIVjdlAfvxukJezg==
X-Gm-Gg: AfdE7clDx0J+r+9xoT/rxofazjhpeDnHNPOrhIGLcuAPzTsN4hbMtP5FwZN6MCcyQEb
 UnrixeR8fhrp4yBHh7bvOJ9tJ36SkKmdR2Dcw0A4Cc0cFDJpvBWOwn7nWlA54Kzmtn9i+dG2zbW
 Yg+FB3DWFSM0lcVC9lMXfzmtVjGC2cJPwA7hwRPZSDtCSXQe2xL4mNjclVFkCYeg9urAGKH9lxl
 SC1tQ1hxXlBjaaKb/L2N1Kxzpz7kXJeUL9xEzdu5MFE24bEn2frZMI9U9Z939ycQzkUcE0eItN4
 U6ULWi/Q8s4TWeZxBSjTU25U8F860NH2RPLcNC7CXJhK2GPl4tfyulsvDIWWcCUgVRUzwsaXrmu
 Qd0tlINEBE0RbUxN6icaQg7GNBHISd9p5Ia5pNlo3X30XJ8RACz8LfsPt8I+qEYoCOIPKEtYQTB
 eJexWf2A==
X-Received: by 2002:a17:90b:2d4d:b0:381:6466:7160 with SMTP id
 98e67ed59e1d1-38dc7b38895mr643992a91.26.1783720106204; 
 Fri, 10 Jul 2026 14:48:26 -0700 (PDT)
X-Received: by 2002:a17:90b:2d4d:b0:381:6466:7160 with SMTP id
 98e67ed59e1d1-38dc7b38895mr643968a91.26.1783720105769; 
 Fri, 10 Jul 2026 14:48:25 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 43/98] tests/tcg/alpha: user tests
Date: Fri, 10 Jul 2026 14:42:47 -0700
Message-ID: <20260710214343.2065491-44-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JJYLdcKb c=1 sm=1 tr=0 ts=6a5168aa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=HlkHknZ0qViDtorXcHIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: KzlUtULOcIVt8gco99JsDk-G0Al4tjUx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX/+z1r0dNXUFc
 Z8hX5fHT6+nfubGlOPhliBXzxkkJws8iW+jJk1v5UeJy4Fv+TSH0mUHsRy3cGOiD2WpeiKvTLdU
 43JspQQ4LTLQfTFDceCPo3NMB2X/SLY=
X-Proofpoint-GUID: KzlUtULOcIVt8gco99JsDk-G0Al4tjUx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX+RKJ0gNMp/H2
 zCOnaOpNL9+XaHxf5wgcGEDjiCehgccnfQBwOQiLw+VR5spADoqcpa7d/47IoTOHWMpvg2m3MTP
 8hVjgXG/thxCOjJXbfobqoIIuRi1oZ0I6RfcrYqBoFHEvaZwxbxIS9GKnOGwabaUAEQcOttKlzl
 g2R9UsypeGGbvrdWIP038oPsNdlFUkaEJL1ztBBvdvgZqr6WuC9LycXojn9fUr3qaZQj/VHHy3c
 sUYDyFzsaOm1XrGGunMKS/O3CkNw6+90F19H8ZNUlO34kqx6S/hqB1C2GeQmwEY3L+EVzUsm2CQ
 eLOeBPTSBJ9q6aS7aKQN+9dbQclyHC2djlIMVFIvrsjzWkx/vpMFPVSgjlJowezTWs4pMaWc3Su
 nPYqDCj7R7pMAu5n1ngWmCCzq9v2gtcKw4Yz4/Bj3LjtaoHFNXyCwCcZjpPN2fiOPb6RMXnh7mq
 5sxXZq38ZjBnUbkln5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/alpha/Makefile.target | 18 -----------
 tests/tcg/alpha/meson.build     | 53 +++++++++++++++++++++++++++++++++
 tests/tcg/meson.build           |  1 +
 3 files changed, 54 insertions(+), 18 deletions(-)
 delete mode 100644 tests/tcg/alpha/Makefile.target
 create mode 100644 tests/tcg/alpha/meson.build

diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
deleted file mode 100644
index 36d8ed1eaea..00000000000
--- a/tests/tcg/alpha/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# Alpha specific tweaks
-
-ALPHA_SRC=$(SRC_PATH)/tests/tcg/alpha
-VPATH+=$(ALPHA_SRC)
-
-ALPHA_TESTS=hello-alpha test-cond test-cmov test-ovf test-cvttq
-TESTS+=$(ALPHA_TESTS)
-
-test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
-test-cmov: test-cond.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-# Force generation of byte read/write
-test-plugin-mem-access: CFLAGS+=-mbwx
-
-run-test-cmov: test-cmov
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
new file mode 100644
index 00000000000..08e371116c3
--- /dev/null
+++ b/tests/tcg/alpha/meson.build
@@ -0,0 +1,53 @@
+cc = 'alpha-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags = setup['cflags']
+    endif
+    # Force generation of byte read/write
+    if fs.stem(src) == 'test-plugin-mem-access'
+      new_cflags += ['-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': new_cflags}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'hello-alpha.c': {},
+  'test-cond.c': {},
+  'test-cvttq.c': {},
+  'test-ovf.c': {},
+}
+
+tests += {
+  'test-cond.c': {
+    'cflags': ['-DTEST_CMOV'],
+    'exe_name': 'test-cmov'
+  },
+}
+
+if 'qemu-alpha' in emulators
+  tcg_tests += {
+    'alpha-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-alpha'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1996fb0cdf8..45f53fbd8df 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -135,6 +135,7 @@ endforeach
 # Now let's go through all architectures
 subdir('aarch64')
 subdir('aarch64_be')
+subdir('alpha')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


