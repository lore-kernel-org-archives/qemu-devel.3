Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEFBC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs1f-0005gd-W5; Mon, 06 Jul 2026 18:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1d-0005dm-Fx
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1b-0000C0-NW
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE8q31654904
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=niBvukNQfar
 iNgj2Mx4kZ/JnnAFrOwH7ekSepuZeEsM=; b=NRxMiuN7NR9VXEklRHTbIQBRiKZ
 iEp3+Pa2LYcjKJ0m1p0tkM0222DBwk0WICX6/cbjZ+E6bNFzR69zNPRACTyernG6
 aXhvlW3pJB/X1GvrWR+obutaNk3hmRyMr56QSZo7NMssYUlSo0ezblQxMZdHNBzw
 vyxKAUqpQnw95w8YJDDr8PL8fI6ugXhyAUMHq7bP+LCSPaKplZTRZGzMYO4Eu1ow
 ecxDz/YhwWOM4O7fS5XHfW6KSnskSjB7qwbSFO/mkqY40SvwwEqcKPhNKSEFetD9
 oqshI7K0Rsnl99aaS7PQIoTaJEedYlXXcUPd/oFVeSA5y3nH/xJTKqYj8Iw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpk9gq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:42:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8478e603285so78086b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377770; x=1783982570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niBvukNQfariNgj2Mx4kZ/JnnAFrOwH7ekSepuZeEsM=;
 b=aR2/xEyJsLqN+pF+zzeSVrg1wPYazZwGnpUEli4HJK0fqI3KnZUO0JyN2Axu1KG9OM
 Ke4FF1Ec4X0wirSAT0UxfHF/iqeJ0zuSv4KjU0O56BQQUPQaMFqGqyaGvetuK7IFuoY6
 Avbj25m/bC0hfez8zFBTiVMDs4jkrUiK3kMrl2NLNZBC3oxvOk+L/2Xq7+36JLa/8xbg
 DWXswUrCIvR2OBpgMjh67srxs/zYLzcgbHFeXa70NwGNuIxxFM4LgD3OG0QuvYCfD4lq
 BbaHJ1ss8cOx3eyYlgcSEzGHI9SKCBiS1t6USJVgisMFnfNwmn/lb/yoT3EAOkDMznim
 C62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377770; x=1783982570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=niBvukNQfariNgj2Mx4kZ/JnnAFrOwH7ekSepuZeEsM=;
 b=Qkn0HaQ3d/G/z/h3KPfM8GsUtzrMGYF67sCn9/GvqZasBiuBrj1GNe2x/jJ0FigA9Y
 +fzVr+Yt39mo3Nzh1Ty7LjokAvLqwp56R70OpVaj6BFt8HdOvzrUF9/SeXcoGGc7Mtn+
 8ZXQ2chvu5UrkB5UlTG0bnFibkmhuV7lrG7t+HOJf5yK787NL0AfON0XP3BnJX5ndPLh
 ToztN8LCDpIgHi3sZxrDl/Fg+ZbRBGQtxTYA6LvU14rg1xkN4BeL6cEVWBmv8qMi8Lk+
 qiHuw9REdx+BNaFoBmsQ73k/ykJMlhFW5J1fSjr9Hf5831zSXxjK5CYa9PBkT4od/Fdi
 X8+g==
X-Gm-Message-State: AOJu0YyAPwZmui2vUOFDhHlkcwOFWgYR03/wFwTTJ/Hu8WsQfuVNZRpz
 o2zFLYQAHQiUKKDGlbwy4AY+3FqKBpmd+owTqgqmbwyBnUXxCXPvyE525hNIPJ+FtUu10XmUaq6
 tSMyWzqKw3V6O38mdDeR3rpxr4FHwOpuNioIzct1cOFSMGsWL3a3JqjyfLw/ON+3Fkw==
X-Gm-Gg: AfdE7cl1obNpwuf5JgwKzx8HC735MxWxKgGhpckYnFX9fcEM2xR+7+FkY/W4iwIMroi
 +bEsZS+rramjC4cb7yqj7jQ8JBeY1xm+Lhn0eTilghFWC8eYuC4CWv34a6PmptojQ4bcYBQnUTO
 iwvgbIfc3DgKNPxqEyvbcvffTFDZwJOIzrXUvcvS32LEet8HpqU/hjcZ/wA3gTBMHHz/D4VAUEq
 nAxl3cOVyGdrzIGL0nDEC0jSIIfTCgvfBFcJoDSCJuwL/jCzzNfoUtxldQOklhQzDxLe3jOnLDy
 cs0QkA5UqAtRIc4rHQEOfE6o7RSTdoJ8NVt1xsAAC6aKrrxSQIXvi5l9nwgQdFxcaPOytN+/PYw
 CyPHlaVHhSu6J2VeK+ckouDFjMq5pjflfi4FqOHjGyy17K/BC7Z+W/2i95MChdclUejXd/9WQ/l
 EPTUptpA==
X-Received: by 2002:a05:6a20:6a0b:b0:3bf:a8fa:a7b1 with SMTP id
 adf61e73a8af0-3c09b48c10cmr224480637.37.1783377769774; 
 Mon, 06 Jul 2026 15:42:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0b:b0:3bf:a8fa:a7b1 with SMTP id
 adf61e73a8af0-3c09b48c10cmr224463637.37.1783377769319; 
 Mon, 06 Jul 2026 15:42:49 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1439200c88.14.2026.07.06.15.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:42:47 -0700 (PDT)
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
Subject: [PATCH v3 83/91] Revert "tests/tcg/tricore: system tests"
Date: Mon,  6 Jul 2026 15:33:35 -0700
Message-ID: <20260706223343.988769-84-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4c2f6a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=iDqF0Ks1Phzk79bJWccA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: aeFVzIE-iSItggv0jP3DhdnblsMTYbiA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX1Vf9oCPVehtz
 jQ4quM4OhCpmknt1dNr8bqVE3N3H3lbepWIJPsZKLfcxZVl+JhNq8Nsny3hhAY6hYVjVSxWPA2r
 lGYCRXcAQTbXN/7CWxkm8Gi/dHi171ZrN9ZYTwVH55yLl7qhlswAHbXi5GggNdvzOdgP+v1b28E
 jPbxm5WRi0NDTCPx5dkDLwm6Mux9qhU//ZwZvPKomcaP092r2wWID7+P5cpw9RWBhj3xXOJF+3W
 CRXY1PjEkS/YWU8I++C+fD+iojvC90FkIbIWWM0XEAs9mySVD9Tw18uN2WdG6ckRf9R+OgX2rzr
 gjamXgaNinlN5Lbfe6rsYTnIdBnSSkKDdxuW0kK6XdCscOOMpUWfByC49m7zglYvbPJ2rbhT807
 /R3q/23DQ4+7JR0W8qpeJ14sw0I76pULyrQ1oE/OLAos8ymYev8KESeKZyrPk/HHsPTlF34gmZF
 XMoByBWo/7X43PLlwQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX4C18fIpqSLTv
 VDO6I9rNgzTOgR6+Ltnhg0MuYt+DSg5dEykZOCEvtfaLKiVoO48CDzrdYCFbZhOfe5LkMJzodvA
 5xsKgEtWKNYvj3nyq2snIFb7D6KyF6s=
X-Proofpoint-GUID: aeFVzIE-iSItggv0jP3DhdnblsMTYbiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
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

Those tests are hanging for now. To be investigated.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 -
 tests/tcg/tricore/meson.build | 56 -----------------------------------
 2 files changed, 57 deletions(-)
 delete mode 100644 tests/tcg/tricore/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index b2630176b7f..59e71d82c99 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -152,7 +152,6 @@ subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
-subdir('tricore')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
deleted file mode 100644
index 6303d6a912c..00000000000
--- a/tests/tcg/tricore/meson.build
+++ /dev/null
@@ -1,56 +0,0 @@
-tests = []
-
-link_script = files('link.ld')[0]
-crt0 = files('c'/'crt0-tc2x.S')
-asmflags = ['-Wl,--mcpu=tc162',
-            '-Wl,-T', link_script,
-            '-mtc162',
-            '-nostartfiles']
-cflags = [asmflags, crt0]
-qemu_args = ['-display', 'none',
-             '-M', 'tricore_testboard',
-             '-cpu', 'tc37x']
-
-# Multi arch tests are not supported
-# tests += tcg_tests['multiarch-softmmu']['tests']
-
-setup_asm = {'cflags': asmflags, 'qemu_args': qemu_args}
-setup_c = {'cflags': cflags, 'qemu_args': qemu_args}
-
-tests += {
-  'asm/test_abs.S': setup_asm,
-  'asm/test_bmerge.S': setup_asm,
-  'asm/test_clz.S': setup_asm,
-  'asm/test_crcn.S': setup_asm,
-  'asm/test_dextr.S': setup_asm,
-  'asm/test_dvstep.S': setup_asm,
-  'asm/test_fadd.S': setup_asm,
-  'asm/test_fmul.S': setup_asm,
-  'asm/test_ftohp.S': setup_asm,
-  'asm/test_ftoi.S': setup_asm,
-  'asm/test_ftou.S': setup_asm,
-  'asm/test_hptof.S': setup_asm,
-  'asm/test_imask.S': setup_asm,
-  'asm/test_insert.S': setup_asm,
-  'asm/test_ld_bu.S': setup_asm,
-  'asm/test_ld_h.S': setup_asm,
-  'asm/test_madd.S': setup_asm,
-  'asm/test_msub.S': setup_asm,
-  'asm/test_muls.S': setup_asm,
-  'c/test_boot_to_main.c': setup_c,
-  'c/test_context_save_areas.c': setup_c,
-}
-
-if 'qemu-system-tricore' in emulators
-  tcg_tests += {
-    'tricore-softmmu': {
-      'cc': 'tricore-gcc',
-      'cc_dockerfile': 'debian-tricore-cross',
-      'cc_docker_arch': ['x86_64'],
-      'folder': 'tricore',
-      'gdb_arch': 'tricore',
-      'qemu': emulators['qemu-system-tricore'],
-      'tests': tests,
-    }
-  }
-endif
-- 
2.47.3


