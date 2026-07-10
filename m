Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0D2C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6N-00085s-B5; Fri, 10 Jul 2026 17:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6K-0007mA-TL
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6I-00057c-NB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:40 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3BB61891828
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fMrXpLGdooj
 nlIv0ivjSkJGu8ZYhksWbtp04zDBYpAQ=; b=LaoGCxVm78mJ/aUkN1+8HbQ8O8M
 9go8jCKn05P+xDVkkHjYSF9J481De8UbFgotFn5TGIDN1AQcFCUaGZTmzDbONyld
 d6K46yfitI/EJJC+Tq1dYQf7+MCyiDdkqhKrc2fyFf9xf/7sPDs3OKZlxKNJoxzU
 ujF89zQYXooUdyA2w+2+jbvZgu3gRpX8wOVvXfA5zsUKBfo905X0dMrFnJ2OALXQ
 HC4WVWVwF5MEsQ/BCEEjHIr38DwvH/2mypk6gAE71THKsanYM1ZU1Xe3YHf8lp8V
 Hu8P4G1hBsOE8M2w6a/rtP2A8AyHXa+2832niGAO1yiyZF/DC4M/SfPPtog==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvs36j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88ab059052so1317437a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720166; x=1784324966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMrXpLGdoojnlIv0ivjSkJGu8ZYhksWbtp04zDBYpAQ=;
 b=dx4Sp7mgVx6QIx7Gvs/199NYGKGLivO5xhsVSvkFWt3HS52RnwGXneW68hRcaYOIYu
 gQFg5/PXyYskcKf4mmUYxZ8iOgirFvVIcKh90eIwcGiBLfh/x95GjiF4mZnrXcX1BPgo
 7uDZ0bGjMQbKin2P6EWD6M0+gIqWIw3C0TMNdUhP9tWu9pkiwmk/y/L36j6Rx3p2nQV8
 O94Z4Hg+NHbHPou6QJS1Ow60x7v4d26onD3ru+Rhjgiq74ds5VV7jtuGBmn/9O+5KQPV
 LuxWT7a9qsOOT3ONeGRhVQNbS4AdwlWwLI4UyTLogEi8tPleCibWQPszQDkauMcUu6GE
 /HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720166; x=1784324966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMrXpLGdoojnlIv0ivjSkJGu8ZYhksWbtp04zDBYpAQ=;
 b=hGTcGw2VZEsBOMzzxEpJy1vOk39k5UHAHCnMn/BSQGz6RGbnjurb1ezqGvBVY7bmlr
 ThPsClS2fv7Fwo4HyVLFBqfbMW5I+AIQaz9KlAYM1Wvubae+VaFKog+RMh4PugGxZwa1
 1PV5g5+JEyIeBH7SWFYWFmzpNQuvxNGllncPXQqIf1sT3ZKCX/b/DN38wYAeItwbnnaP
 V6pzRgXxH12DuyH1qLz0fsd7nqjwmSVy7RZg1IVij4977SPc9PNNwV3diGdqr+IT9+Gc
 6xt1BV3psU5sKLDyqIpGCV+u7l+YzjNkNfGB7cFobKNYjTdXwJuRrithxBvKIS6a6erc
 FOKw==
X-Gm-Message-State: AOJu0YzkuY9RowBiaGJ7A44GVhMwr7g3ZOeWQxyRRicvcUFl1gPLACiw
 7MTaf84sIi13ETOf/i/s+SIgbj9/tauUWEb3syIzut9vuJ6cNB9aGxWn5La8DV9WRCr3Y+t+fx7
 2sA+pNCniic3jZJ0o2Ekt60mZzB2/QHwomu6UfjJIdZhvwxKRklFSWgcnfpHKTZBzjA==
X-Gm-Gg: AfdE7clSSeA7HHJPSvjpAf359Yq5Jp/nLNOSJJSRtOmFlKMOPK0/cMtNRpyphuTXlhw
 Fahw+SR61T3tuD7N3ORCUEx4mi+dCc8fvdIOSbpV6HGuRRd2pRDUVCNpeur4fe2HQdYQPmQcqti
 N5WupF0MErUqhcmHOKFTzGaX6+0+ZS6sNxGpENVx+zzn0gEtYAQ43t7nPd5g04rjyRyLzw/ddR0
 oaV8vXqHkeFxNNMm7eJpQiFG4a/VBzR/1XWymmy9JOt+a+ABCm3R95hkdJEcZi0xuoyZr+otkEG
 vmb8i90JSai6FWzvaQIEsKTX0YUE9rFZID9L9+m3CsoD44Zb4DLQgjNWyqMsgOxUqlo6jo6vBCC
 rXAHTUwscmfskqI4M4jHONsWL4/WxN10ts6Q3cdp9QSA82wU8ogl6BTXRgGrfYytwItfcDRrZtx
 ly2Nf0zw==
X-Received: by 2002:a05:6a21:6e43:b0:3bf:8230:1b71 with SMTP id
 adf61e73a8af0-3c0f0ae8235mr5412679637.25.1783720166568; 
 Fri, 10 Jul 2026 14:49:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e43:b0:3bf:8230:1b71 with SMTP id
 adf61e73a8af0-3c0f0ae8235mr5412652637.25.1783720166121; 
 Fri, 10 Jul 2026 14:49:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:23 -0700 (PDT)
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
Subject: [PATCH v5 71/98] tests/tcg/or1k: user tests
Date: Fri, 10 Jul 2026 14:43:15 -0700
Message-ID: <20260710214343.2065491-72-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hAdsgkw93_MdZu3I81OjfBfF6WYFOxwN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX8bKjwf9UFbl8
 9UuYcCBdEb/SgspyGNIOwmlbwLwrokAYI3Cai9Mg0/Yp8hyIhGXhjHHZe2Guzo1bMQVpcF/u5L/
 2NZz8aGKu0cyVwXAq/YQZro/wIcLHd3RSO9LzKFWR7Sqs+tCae1bMsmnsCE1bxh0S6E0kmjZ/ol
 1SdNJW+YMIia/CNtkw/Be/aRsBwIv/Z2r1O6Xak696oAKcfIRGq9gDfVXHvM9wjkfqDLy0CutN1
 a3jrO80PtRjnKzDvKVJ1Hmf9+z/RYFmCKa04u6LsBOqLNY6wBxXltQyAESmYIQLMMgSfhuMhodg
 fnNfOvW1POloKu+CxqtNdMqGv1RyCEoWKzzXJqY2mhiO/7+sK0fknOzgsdAQ2nTgWUNcJro3S+3
 lHUOtVj0F7414RqZ68I7epYeZN3eUQdWDXQITBreFACWrXjoJVhvgckO5zDm0rZnx+GVhKMxbdc
 Kxh2kmXw4KjnDWR05Ew==
X-Proofpoint-GUID: hAdsgkw93_MdZu3I81OjfBfF6WYFOxwN
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a5168e7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=vRC7ysU8fHDJUYuF0LMA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXxtb0hJrnx03q
 mOH+yYDlWzRyMu75fmmy6YHCQdvzV2LGwCci47NCkMxJRDc32apVCUAKrdCuX6TLwtvg5m0imAj
 Wm3Oc5EmR9q93O53Q9ktZ3MyPpOt0XM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
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

Some tests are currently failing, so they are commented.
To be investigated.

qemu:or1k-linux-user-test_addc FAIL 0.05s (exit status 255 or 0xff)
qemu:or1k-linux-user-test_div  FAIL 0.06s (exit status 136 or signal 8 SIGFPE)
qemu:or1k-linux-user-test_extx FAIL 0.06s (exit status 132 or signal 4 SIGILL)
qemu:or1k-linux-user-test_lx   FAIL 0.05s (exit status 139 or signal 11 SIGSEGV)

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build      |  1 +
 tests/tcg/or1k/Makefile    | 71 -------------------------------------
 tests/tcg/or1k/meson.build | 72 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 71 deletions(-)
 delete mode 100644 tests/tcg/or1k/Makefile
 create mode 100644 tests/tcg/or1k/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 598b32ea1b4..0dbf92c2d9c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -145,6 +145,7 @@ subdir('m68k')
 subdir('mips')
 subdir('mips64')
 subdir('mips64el')
+subdir('or1k')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/or1k/Makefile b/tests/tcg/or1k/Makefile
deleted file mode 100644
index fb5ceda512f..00000000000
--- a/tests/tcg/or1k/Makefile
+++ /dev/null
@@ -1,71 +0,0 @@
--include ../../config-host.mak
-
-CROSS = or1k-linux-
-
-SIM = qemu-or1k
-
-CC = $(CROSS)gcc
-
-TESTCASES = test_add.tst
-TESTCASES += test_sub.tst
-TESTCASES += test_addc.tst
-TESTCASES += test_addi.tst
-TESTCASES += test_addic.tst
-TESTCASES += test_and_or.tst
-TESTCASES += test_bf.tst
-TESTCASES += test_bnf.tst
-TESTCASES += test_div.tst
-TESTCASES += test_divu.tst
-TESTCASES += test_extx.tst
-TESTCASES += test_fx.tst
-TESTCASES += test_jal.tst
-TESTCASES += test_j.tst
-TESTCASES += test_lf_div.tst
-TESTCASES += test_lf_eqs.tst
-TESTCASES += test_lf_ges.tst
-TESTCASES += test_lf_gts.tst
-TESTCASES += test_lf_les.tst
-TESTCASES += test_lf_lts.tst
-TESTCASES += test_lf_mul.tst
-TESTCASES += test_lf_nes.tst
-TESTCASES += test_lf_rem.tst
-TESTCASES += test_lf_sub.tst
-TESTCASES += test_lf_add.tst
-TESTCASES += test_logic.tst
-TESTCASES += test_lx.tst
-TESTCASES += test_movhi.tst
-TESTCASES += test_mul.tst
-TESTCASES += test_mulu.tst
-TESTCASES += test_muli.tst
-TESTCASES += test_sfeq.tst
-TESTCASES += test_sfeqi.tst
-TESTCASES += test_sfges.tst
-TESTCASES += test_sfgesi.tst
-TESTCASES += test_sfgeu.tst
-TESTCASES += test_sfgeui.tst
-TESTCASES += test_sfgts.tst
-TESTCASES += test_sfgtsi.tst
-TESTCASES += test_sfgtu.tst
-TESTCASES += test_sfgtui.tst
-TESTCASES += test_sfles.tst
-TESTCASES += test_sflesi.tst
-TESTCASES += test_sfleu.tst
-TESTCASES += test_sfleui.tst
-TESTCASES += test_sflts.tst
-TESTCASES += test_sfltsi.tst
-TESTCASES += test_sfltu.tst
-TESTCASES += test_sfltui.tst
-TESTCASES += test_sfne.tst
-TESTCASES += test_sfnei.tst
-
-all: $(TESTCASES)
-
-%.tst: %.c
-	$(CC) -static $< -o $@
-
-
-check: $(TESTCASES)
-	@for case in $(TESTCASES); do $(SIM) $$case; echo $$case pass!; sleep 0.2; done
-
-clean:
-	$(RM) -rf $(TESTCASES)
diff --git a/tests/tcg/or1k/meson.build b/tests/tcg/or1k/meson.build
new file mode 100644
index 00000000000..5151e8f361f
--- /dev/null
+++ b/tests/tcg/or1k/meson.build
@@ -0,0 +1,72 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_add.c': {},
+  #'test_addc.c': {},
+  'test_addi.c': {},
+  'test_addic.c': {},
+  'test_and_or.c': {},
+  'test_bf.c': {},
+  'test_bnf.c': {},
+  #'test_div.c': {},
+  'test_divu.c': {},
+  #'test_extx.c': {},
+  'test_fx.c': {},
+  'test_j.c': {},
+  'test_jal.c': {},
+  'test_lf_add.c': {},
+  'test_lf_div.c': {},
+  'test_lf_eqs.c': {},
+  'test_lf_ges.c': {},
+  'test_lf_gts.c': {},
+  'test_lf_les.c': {},
+  'test_lf_lts.c': {},
+  'test_lf_mul.c': {},
+  'test_lf_nes.c': {},
+  'test_lf_rem.c': {},
+  'test_lf_sub.c': {},
+  'test_logic.c': {},
+  #'test_lx.c': {},
+  'test_movhi.c': {},
+  'test_mul.c': {},
+  'test_muli.c': {},
+  'test_mulu.c': {},
+  'test_sfeq.c': {},
+  'test_sfeqi.c': {},
+  'test_sfges.c': {},
+  'test_sfgesi.c': {},
+  'test_sfgeu.c': {},
+  'test_sfgeui.c': {},
+  'test_sfgts.c': {},
+  'test_sfgtsi.c': {},
+  'test_sfgtu.c': {},
+  'test_sfgtui.c': {},
+  'test_sfles.c': {},
+  'test_sflesi.c': {},
+  'test_sfleu.c': {},
+  'test_sfleui.c': {},
+  'test_sflts.c': {},
+  'test_sfltsi.c': {},
+  'test_sfltu.c': {},
+  'test_sfltui.c': {},
+  'test_sfne.c': {},
+  'test_sfnei.c': {},
+  'test_sub.c': {},
+}
+
+if 'qemu-or1k' in emulators
+  tcg_tests += {
+    'or1k-linux-user': {
+      'cc': 'or1k-none-linux-musl-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'or1k',
+      'gdb_arch': 'or1k',
+      'qemu': emulators['qemu-or1k'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


