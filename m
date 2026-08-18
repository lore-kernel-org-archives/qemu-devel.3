Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3528C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTn-0004X1-GT; Tue, 18 Aug 2026 15:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTk-00046D-5Z
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTh-0007TE-K0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:07 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH34I1943392
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=E0J6Fg3o3Ds
 ip/dW2/ZtguYupoqqa9K22JGMSQmFkPU=; b=SUmq/KqZWmWaik+TJfj4dlACw6V
 MvSZwgy7gl2WQk/uwOs4aF0DxQjsUVSKzOgFDmUi/VPWvi14DgGN+4U/kdjcN5pC
 xvH1WWTqc615rC3LsTsG/hfUkmmu+WrVgPYDF4TseNNJWItKfw+0jt3fz0mfU84r
 2jR91QJ06Ec8XDzHRw9Y3QAlZ1NJYWbACziRuDK06aaHTqF6Q0bO4UYm3W4S82Xy
 1yKJ6lJGQCPv7NZmrvoTk8j7REU3yOQ4H6lli4If0eromLYf9Yirs7SBFgnEq2pP
 kZUygn/k1+Ir2BuI7UNapObmll+W16/M5xrnpiyhuWE/SCZ6ndFE+AwqxPw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn26tv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso298381a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081283; x=1787686083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E0J6Fg3o3Dsip/dW2/ZtguYupoqqa9K22JGMSQmFkPU=;
 b=Omzp6D5Y7aodXjpkXUfYAINbPPPfaPqx+4OY8qGy92JH9DN02FrsmRrlO0ek2TsxZy
 kqBdwen+qTbKAHmmegqqBWlIMedAQclJvtpJpcz6L4XpPoX+fuOAfPdwuZESbQwcwr86
 iUPKIzHprFxF/ElHmSTrHZ5z8UbAxRL1h9x6RuTblZkUGI9j2fBv/mxexUWQlflQLW8m
 j6SzbVV1JLZzPpOuZESByhRcfjVTh0K+1hQhqgbCyJkPsaez7SLh2SD//IHaABgu+J1v
 oFBXrh0Aak8Dw4a3hd0Iv+fLMmqA+W9dQ4vmMANSpkmq7rhsQD7Cl4eFlnuZ4USRV21O
 SszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081283; x=1787686083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E0J6Fg3o3Dsip/dW2/ZtguYupoqqa9K22JGMSQmFkPU=;
 b=cnR9YwlAMetPnDjA329Ttu55mqF/hA6sdUyLBMfiZJ8too5lLgVvVAd3ZdRfxh/o/G
 HqBzWASIUoKPjm86iOuhsoVrUF86ldzCaHq4YE7IBijoZQuZpmlrUNysA4w6wCoBvEE8
 ZYpyOI1Ipqp9Lp4XLy40pdzPFLsaKXg6ptTcWaeoukXevd364dS0mnULcv0DN3BfjzEa
 JDRRsbBDRj9Y4QtPxeL/VRSQkQ8apf60H7kyg69rPfotAXm8p7qUOLpM7XOZvJd5BzAb
 X7b3SpEnysC7FdUROMGe1kd1Wpx8SJE4Jm5xqhhZWcsPDeWQCJw824sviv3d8izn4Ppx
 EAGQ==
X-Gm-Message-State: AOJu0Yw/czFJvQdicrY9hMcp3H1ogh5pxpYJoz0ygOrEdv/qGrRMV5Af
 62piKpWwsQfmOn6nxsdK+/uZPB/NNOY9f9b53gWFfJmny9r8JSdORLZytXLJFy0188g0bCPCroo
 tVZpIGNWnMtiNG+x1pid3KEKHHfXd7ypWlUjZV/mMdLMdbHwG1GxlCZp9GtNLeZWoWw==
X-Gm-Gg: AR+sD10I5fV1A9Gb9uNcLvcBTygch2cOCpv2gJ7fESTx4IHxUX5tzEBLadzHEEMXgQu
 5UckCTHVLBCQpgfOkyFvtDRFqrHOHDT4KUJYQVJu0E32Ul+eTv8tPTsvww1eRDzdqx//63A9H0R
 D3dMAX/LF4dgXnCIOWJuB+0L0NJwlrfHTPBrJ+mDHks0EbtuoEFUWyS4NNdycgyVFKk9ygqJyTo
 ZvXmIavOrvrGSBYc0UrAi5qN7hVbGQ9CtlgKXz8AEP83oIYnG3NVMRI+bQJsWeRUH7+r1WhM26d
 ie0nfDoGC9NHICs4SVD92e5piA+1MKM18e150Jz3KwUqoC9rapLP4MvmWg20nhgaEsSF+iLMocQ
 fj9L3d4WK72b8+5BWCAZpbAFIOmlsNruxKAxZUYHVb5irq4MO3SbFiZsIYOo=
X-Received: by 2002:a17:90b:5289:b0:38f:efed:5445 with SMTP id
 98e67ed59e1d1-3957b25aa71mr111265a91.4.1787081282392; 
 Tue, 18 Aug 2026 12:28:02 -0700 (PDT)
X-Received: by 2002:a17:90b:5289:b0:38f:efed:5445 with SMTP id
 98e67ed59e1d1-3957b25aa71mr111155a91.4.1787081281799; 
 Tue, 18 Aug 2026 12:28:01 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:01 -0700 (PDT)
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
Subject: [PATCH v7 053/104] tests/tcg/hppa: user tests
Date: Tue, 18 Aug 2026 19:22:17 +0000
Message-ID: <20260818192309.22169-54-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXwTTYWAUHNogx
 BQSLsIJVUbOqO68jSnqJovoZiykfZWeLtmt0WJeXkUXjcAnPUMN/4Q8Qn+ESADU2MfCQZpSlob1
 JJLrf5FMTzXCVYcT3eXkJ8mvJtD6KUs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXzlomu6UZX6Qg
 ILA6ij6G4u8kHU/E9EeSgwnihQX/7jQMQ8jRTLfeR01A0N8AN7awyQMPBOF69hEmaek1IWWRlWY
 fNc9FRP5TOhJxltYf7wxkCv0wx2Dy2TkQ89txkIix8QdW4Imwaaitw9JTNc+2fxP07OxB/C3C6q
 voeY5vamlyowwwpbKHdg/TQL/3ffGDEhOGHy0Eg9AgHnSmTOA2mvVPjkT3PWVIAAZht1xC1V5bd
 YqMGu7YjOjGCMqrNpgfVMqkDuk1KwH8aOWvcvpz/JMYnM5FwN7/stLrJmJ1dZaP/z37DzcqHT63
 jmStkQavWQfm0sX/nXTjK3eQ9ehlaZaje3TCIYKYMDum6eAN6SM86+/cGR8JuVEh7KCiT9ZYBYe
 jhj0n4ZjfgCvqjVNPWKgWA5aO/Rpe7WXdlr+qGg4r4Te6+SHJ1qF/NrtreVdPyGwE2mWn34amyK
 PPE4hHIRr3rOOa0S4zA==
X-Proofpoint-ORIG-GUID: IL785AdS-0Orb8D3616UvXbnW6FyOn5z
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a84b243 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=Wtfs_aKp8OXI5K8l3bAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: IL785AdS-0Orb8D3616UvXbnW6FyOn5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hppa/Makefile.target | 14 --------------
 tests/tcg/hppa/meson.build     | 22 ++++++++++++++++++++++
 tests/tcg/meson.build          |  1 +
 3 files changed, 23 insertions(+), 14 deletions(-)
 delete mode 100644 tests/tcg/hppa/Makefile.target
 create mode 100644 tests/tcg/hppa/meson.build

diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
deleted file mode 100644
index ea5ae2186df..00000000000
--- a/tests/tcg/hppa/Makefile.target
+++ /dev/null
@@ -1,14 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# HPPA specific tweaks - specifically masking out broken tests
-
-# This triggers failures for hppa-linux about 1% of the time
-# HPPA is the odd target that can't use the sigtramp page;
-# it requires the full vdso with dwarf2 unwind info.
-run-signals: signals
-	$(call skip-test, $<, "BROKEN awaiting vdso support")
-
-VPATH += $(SRC_PATH)/tests/tcg/hppa
-TESTS += stby
-
-stby: CFLAGS += -pthread
diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
new file mode 100644
index 00000000000..9ca8f29fa93
--- /dev/null
+++ b/tests/tcg/hppa/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'stby.c': {'cflags': ['-pthread']},
+}
+
+if 'qemu-hppa' in emulators
+  tcg_tests += {
+    'hppa-linux-user': {
+      'cc': 'hppa-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'hppa',
+      'gdb_arch': 'hppa',
+      'qemu': emulators['qemu-hppa'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 27d7aedb8b8..878a391d8fd 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -141,6 +141,7 @@ subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
 subdir('hexagon')
+subdir('hppa')
 
 image_targets = {}
 exe_targets = []
-- 
2.43.0


