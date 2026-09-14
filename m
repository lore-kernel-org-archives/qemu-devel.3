Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A232C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6GSc-0001Cu-RA; Mon, 14 Sep 2026 19:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1x6GSb-0001Ci-8f; Mon, 14 Sep 2026 19:51:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1x6GSZ-0003l9-HA; Mon, 14 Sep 2026 19:51:41 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN1jqB3399995; Mon, 14 Sep 2026 23:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=GckjyNtO8j/SOS9YdVNgjOaXFSdk
 /thhj7VTvhHBCNM=; b=FaD4zZBt6fGd+uwlMrq+kNDcrSdiCbgobHPRFJP0zWpp
 VFiVzvHhbWkfGkrX2O8OjPHPo8w1l+y3GDd9afGrraCyNTgZR9/8nj3SRBTB79gp
 Vobl+QpMxnppw23uaviHexUAwgkVM97G25NJwvqmSExxtXHuYS3I77A86n1G9dMZ
 kP/0h6dv8q7kjcbk92qZHWEZ74CkYfOrLdhr/ujai87Hzh6gNQsCgShfdXfsOZeA
 LqoECw8UtHzZC0aNtCQVA8ThgkwtXxr2XF8iomHPndKTmi/nPq/IEhnzI10ifn/k
 0EhaqkSvB+/skaReeBrP1rWhwnBD6z0ZCZaff0xr6w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcuv787-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 23:51:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN56kG3025950; Mon, 14 Sep 2026 23:51:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnj2k0q3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 23:51:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ENpTV828115312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 23:51:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A395920067;
 Mon, 14 Sep 2026 23:51:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B35B2005A;
 Mon, 14 Sep 2026 23:51:29 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.56.140]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 23:51:29 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/tcg/s390x: Restore the SLOF libc include path
Date: Tue, 15 Sep 2026 01:51:10 +0200
Message-ID: <20260914235113.272992-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMzNyBTYWx0ZWRfX2zK+rp1YnsGH
 bAKwv2RnLEWZAANSm7lZNoNb0o74nWq3r/LPFoaDsFPYcmpjphXHDHWiEVu00g3y1hQMShFiQAf
 wdjykytIM9DfHRA/bkGTyrXtS0YeOsM=
X-Proofpoint-ORIG-GUID: nIfILIi2Dff9nc-OSoR9DcWWV-zhQUU1
X-Proofpoint-GUID: nIfILIi2Dff9nc-OSoR9DcWWV-zhQUU1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMzNyBTYWx0ZWRfX+UuAEYCc/omG
 8/JoeX8bsw5sl9B69MzJoAwSQg5UDROtYw5aTkKtvMQ1kC38lLP/MDtgiAJLqmUrX+G47MJMEuC
 8mPtowqhHlkPbrmn2MTiZIQzxF7HbN2v/Z1IU92SNwSKCiiyIHZUOqs4FNerAoJJ7FPdvpuGHN4
 H+SFzsw8pG2dGA/67YkhaeN9xXEgevbf+Nm4P9FVcPE2tvkiWl19m8Rqg0XiDzaaH9MjzU2YMU6
 /yo/FjFewiuYBY5sz9bW+fboZAbZU50ks5SaXrm2OYeLSUSQaRBUG/sdB06XPYl4w2/oLYmaRF1
 DsCDEfPhr5YVb1fUgn7dsbPQZqr8CAZHGD6ANYYK2JsYYPaJeK3xMU7BzdbHtYxxYhOJtfXff5y
 llWI/CiMGQAgodT9+XxKNalnwWWSLPI2EvFH+D2FcUqzingEn4qEtpEMkYdfnnMvDw0B3gFR08f
 MTJeZjn2rkBtdvcz+Zg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa88886 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=GaQpPoNlAAAA:8
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=p6B6tjyVSEegV1g8rl4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140337
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The meson conversion dropped the SLOF libc include path that commit
3fa010d5317 ("tests/tcg/s390x: Use the SLOF libc headers for the
multiarch tests") had added, breaking the build on systems without a
cross-libc, such as Fedora.

Restore the include path. Add the logic to check out SLOF libc.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Closes: https://patchew.org/QEMU/20260910100120.2076092-1-berrange@redhat.com/
Fixes: cd81cf86834 ("tests/tcg/s390x: system tests")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/s390x/system/meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
index ca07f503058..26f47d4184a 100644
--- a/tests/tcg/s390x/system/meson.build
+++ b/tests/tcg/s390x/system/meson.build
@@ -6,11 +6,13 @@ link_script = files('../softmmu.ld')[0]
 head64 = files('../head64.S')[0]
 console = files('../console.c')[0]
 ipl_inc = meson.project_source_root()/'include'/'hw'/'s390x'/'ipl'
+slof_inc = meson.project_source_root()/'roms'/'SLOF'/'lib'/'libc'/'include'
 cflags = ['-nostdlib',
           '-ffreestanding',
           '-Wa,--noexecstack',
           '-I', minilib_dir, minilib_printf,
           '-I', ipl_inc,
+          '-I', slof_inc,
           '-march=z13',
           head64, console]
 asmflags = ['-nostdlib',
@@ -21,6 +23,11 @@ qemu_args = ['-display', 'none',
              '-serial', 'stdio',
              '-kernel']
 
+if not fs.exists(slof_inc) and get_option('wrap_mode') != 'nodownload'
+  run_command(meson.project_source_root()/'scripts'/'git-submodule.sh',
+              'update', 'roms/SLOF', check: false)
+endif
+
 # Multi arch tests - add cflags only once per src
 multi_src = []
 foreach t: tcg_tests['multiarch-softmmu']['tests']
-- 
2.55.0


