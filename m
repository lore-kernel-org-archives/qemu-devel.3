Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDACC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gx-0001xA-7B; Fri, 10 Jul 2026 02:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gv-0001vQ-P9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gt-00064I-Vp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n4893661764
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uBS6AInAAkO
 a0JQF2QWIBV1Vlwt36K11OBVZtPltigY=; b=Ib7VllVoU3drQEm02aSPhO/X78F
 iqu2vlrLk5oud8YeqnQ71VpCZCI9CH49gwpF4P7VsQWNBHjx3JA0OfPMgTjRGuDz
 5dmM8tfiE8ii2TbkEiNB1S/l5b103/JxzZZug0LFardXJzWlloRjlMBt+OplbQNU
 NWy+b1Z9Tv44XRBeRFmHmxVa+Eerz0fBh/lerN5k2OXPZpIXWxzyyJx17KZSk0J2
 TJwE9wtPf3Hu3nMoVawidyo+NjdFGbap/YDzY7j/vFrZEsxFMxZXx1riYCvUFcMp
 GxcQ9H4BPUVTyAmE5rMYnNEILH9QJxwun5eqmCTyAd30G9kN8JdgR2uktFQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24twu8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c889d1eebafso1421419a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664776; x=1784269576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uBS6AInAAkOa0JQF2QWIBV1Vlwt36K11OBVZtPltigY=;
 b=i9ncj5Cx1NMi3NwbgC6uA4+lK+ee5G5OHY/YUcvkyd5cHJLr4GORdIpYUDym+p5OeX
 +IERCcTyqsPcNiQ3ZOrQWLliXSHYhgzXLCKoPA6U2MiK44Q3dguG8aQP1Uct0Mh3Oij8
 P0UsR1p2VX1TBUFEgbwgplbWwyg9RPfsJ/YQrQfMLQn90WCWL1VFqm0aDKOiftTAdvAA
 oEDhHe0GV8xR0O45cAYYEfokCwPhZ00IlmzZiVJ3mWrJzTy5tRJdFsGeeYuch2Xv4viA
 SJ1VlMct683ytwj4J/rHzp+BUPENUztxfdStWBIdcDbBhlwzV++bVsx/wF7r8EIh/+9F
 7TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664776; x=1784269576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uBS6AInAAkOa0JQF2QWIBV1Vlwt36K11OBVZtPltigY=;
 b=NmVtd8UMKzn6Db7NIJP2B+hrfKAUoOhVpoELsGrzYZswWxRPVZngD7Y5yY9ay3xtK/
 EtBxd9OchP8A0dAJi8NQPz1zrC8pzDdo6K8XqupoJkK46bOP6ke2NRsOBHi8HX3T5CIs
 LryahZ0yVc1nfroA/Zobi0/g5DDnh5KRNtg7xUDmuvsanigUDgA5BXIZeGlGlOhPtl00
 u/uAbVoO32El4h6cFVtR39m1FSDMN9aNqQxZG6wRgUhmwQBv08fMs7bVH5d0mWYkc1B8
 NwI1MujBXsa7o+8TMJhOsmCG3H0dtGL1HUvuQkrryYDwASt8WzUS4gh0RWLXDWnZ5vQT
 p8zA==
X-Gm-Message-State: AOJu0Yxd12MlAQpcJkCEBhlrdbOzfZGq91Yv2DY39NCChAi3SPxMNNZn
 kQI1/2R2vSTJhgiEd1DnJR+llZIoS8cyFwMC6arkzurrSf9Lh0CHrwdiqnT7YRD1kQBxBRAbuF5
 BE1YRaoGJbeffhxMKkaeHTlWj0H8h3z98ewQL+kvsqNCWUcIh28X897ITSS8UwNsXVQ==
X-Gm-Gg: AfdE7cmaVJzMFqGlIsU4ZFw2OBt8T1TNw+Ztxtz5iY/pJNgfNisUeH3aj2yBjJ2FZbW
 89n1AqGcPpELwHWMjsvE0EU0zizWMfiJ76Ss2bWbj3xWlM20ZEArdHOLWDCt1QKAR7L8rklhoUq
 LGSjec53OzrsEJ9MOvaqwDw8Mu789DpQwg/1fFylL6rKqOio3GeHVZjEUqelMjnsbRcfNNR+Di3
 JCvIxAZ8xhrMxfCphSawSf2Lpk9GYNMORKSLXM5ec8PePWE/4wh0DqE/MuBwptuzYLfdYv/VwpJ
 Neou+FBgU2SVFEFjxTCzeOOdu9uv/xK1ahRyK1CASe4AlBiYJwlWLeJZcnWBboXouR56unH9wrE
 ntl1Q1GKeynZQz27in3xtoKOoP35wstE+ehWpH8HnmznZ8mkpyIoeL/7OzvRrRD3IrNlt2KHQHQ
 LvVKLhOQ==
X-Received: by 2002:a05:6a21:3990:b0:3c0:3d56:d391 with SMTP id
 adf61e73a8af0-3c0bcf163a5mr11951975637.1.1783664775922; 
 Thu, 09 Jul 2026 23:26:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:3990:b0:3c0:3d56:d391 with SMTP id
 adf61e73a8af0-3c0bcf163a5mr11951946637.1.1783664775395; 
 Thu, 09 Jul 2026 23:26:15 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:26:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 73/97] tests/tcg/ppc64: user tests
Date: Thu,  9 Jul 2026 23:19:51 -0700
Message-ID: <20260710062016.1818125-74-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: f_pVYss5LzsZUEuvb6BJ125bYMVFfSpj
X-Proofpoint-ORIG-GUID: f_pVYss5LzsZUEuvb6BJ125bYMVFfSpj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX4fKANxCi2byt
 ruIvdD3VkaP5hoJefV/MjiM5/1KGqm5A4tyaa9+YzaTY0V4+rBW6c0a5as35igyYxAiPW8D12Vd
 WKCPIoP0uZPD1KCRRioaM0j2xCjwq1w=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a509088 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=GgvVSD1GJW6-qgdqck8A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXwmNzcvvgOhAn
 YDxrheu9MGB8/7x4L7SZbipMT4idJUFoqOcHHy0ltx5ZPj/F49dBXK4ijgR5OPJeguwzrLSV1BG
 HSjZPXz+ubHb8Zf042QC2OrPzasqirsubH/xZlR2//3pWmtLKhrQWK1w2SIY9GiJ6SgFFjvK2UO
 HLn186+qPyPR2l67XqV1Yjrv9OFT5x83JXHpCk4eq2f5fAl0RZEjLQw4cPJYl2P9LWmi8gXuhJe
 xKoD3kEA/X6u+spMFoILq0LQWKFrMsitx81xei9NPoUYNDb6j1PNja+DtkehO1qSrhmTGsE1kh5
 +RDNHF/FBCfFxSvR5B0SMA/OcRWYoW+MlMUQmYajg3lUAFDrbCCvd8NSWRdZ43259h4dczCnahD
 Md5bUp2XHoRnptD2CJWRt+iWTemR77eislxYSzuS1/4iQ3O44nfVaZIxnHnCyf9khbZRr3OViDv
 qNOGlewkjytcbOWwZVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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
 tests/tcg/meson.build       |  1 +
 tests/tcg/ppc64/meson.build | 56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/ppc64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e04f3a63b6a..1926a7e38fe 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -146,6 +146,7 @@ subdir('mips')
 subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
+subdir('ppc64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
new file mode 100644
index 00000000000..c7e495f3d34
--- /dev/null
+++ b/tests/tcg/ppc64/meson.build
@@ -0,0 +1,56 @@
+cc_feat_cflags = {
+  'power8': '-mcpu=power8',
+  'power10': '-mcpu=power10',
+}
+
+tests = []
+
+# Multi arch tests
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    # ppc64 ABI uses function descriptors, and thus, QEMU can't find symbol
+    # for a given instruction. Thus, skip this test.
+    if fs.stem(src) == 'test-plugin-mem-access' and 'wrapper' in setup
+      continue
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  '../ppc64/bcdsub.c': {'cc_feat': 'power8'},
+  '../ppc64/byte_reverse.c': {'cc_feat': 'power10', 'qemu_args': ['-cpu', 'POWER10']},
+  '../ppc64/mffsce.c': {},
+  '../ppc64/mtfsf.c': {},
+  '../ppc64/non_signalling_xscv.c': {'cc_feat': 'power8'},
+  '../ppc64/signal_save_restore_xer.c': {},
+  '../ppc64/test-aes.c': {},
+  '../ppc64/vector.c': {'cc_feat': 'power10', 'qemu_args': ['-cpu', 'POWER10']},
+  '../ppc64/vsx_f2i_nan.c': {'cc_feat': 'power8'},
+  '../ppc64/xxspltw.c': {},
+  '../multiarch/sha512.c': {
+    'exe_name': 'sha512-vector',
+    'cc_feat': 'power10',
+    'cflags': ['-O3'],
+    'qemu_args': ['-cpu', 'POWER10'],
+  }
+}
+
+# export tests for ppc64le
+tcg_tests_ppc64 = tests
+
+if 'qemu-ppc64' in emulators
+  tcg_tests += {
+    'ppc64-linux-user': {
+      'cc': 'powerpc64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'ppc64',
+      'gdb_arch': 'ppc64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-ppc64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


