Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6FAC98332
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 01:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAGnB-0000Kg-4F; Fri, 25 Sep 2026 21:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAGms-0000Io-M1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 21:01:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAGmr-000689-2C
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 21:01:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PNcHDP3089383
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oOJUVhGzyO/
 BtaeAcNnwLlwraJzOlRUtdqHxgHPgK+4=; b=adFaULHi+ZBXEjrRsUgz22vqdFR
 JvIV5AUpcWYdEsG0b/3EH8YU/83uR5+caHlTHRGNOPwRpnonRHEOMfU5imv6+38E
 ueNKokYcYesXMlsF9d8n2sdzvBlzvWieke5EsuNL5HuYBd0IUJnbh4aOIAgPG4g0
 SWvmS8EmywpyeMfDufK2a4dod2yiiyaw3buID5iXHF/io8D4zuC3kI2wDwpnaVur
 Sf+8Vlpy1yzCvTha19J23W9P2o6gU6YjVs6dWLU2B8RnVTMp1ISWraeHJGLs03GB
 e+c7oOiFlx6Ruzzck4cnGPG0DvufrepJlPTva1MRa+fJLU+4COK0Dsdepog==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq0bq0k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:01:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39aee9b4cf2so2363580a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 18:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790384467; x=1790989267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oOJUVhGzyO/BtaeAcNnwLlwraJzOlRUtdqHxgHPgK+4=;
 b=M6IdN56te1qtPH2SsD6eB63UPQd59BvGbm6v79NjfpaO97FdmJYYCKlf1gsDVOzhQn
 EyeuQ0bVzHRgjMekcreS2n/eeOY1/UiNU7fmwjLb3I8sVwOyHQFraQgIrxl94OUP344X
 iZH8oeoIngMVA31Yc3FqghBjohYRi1bdFz0r8cZoHmV55xMGrvpS6LSJyuacn8wocOEe
 wOO4DsjM7ahW2vYRWzknmi6r1oPidkoxGmUAAXZD5iekAtpqIhSrgo+7ldcjNMLrP1D4
 uBEEH1ATda6Ewe6cgJfgX1nB3VLnk0SrHLn2+CoS4YI0cbHcVpGE5u8NVjIzeLKlGyJX
 r9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790384467; x=1790989267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oOJUVhGzyO/BtaeAcNnwLlwraJzOlRUtdqHxgHPgK+4=;
 b=cbVKIcneHWMAJs0uvrKiTIXI515VcYNNEcAsniWUoU/GyjdDBIlKwy8P+Eop+Zr3yd
 lVL6WinsoyXsQnNUfyeFlGvJ7xyuS4XH5y4HVFrMX9OooKK5gUXvmAN9NvGsoezXQZj+
 Pbxct8imQmk3WOqSF73r88RCU3SEBacWHFTh6CLoFXhC0JmmsgUM5fhNNnwOgpzBOUgZ
 NAwePkito6RIV1ZHSQ6E0+sxv+5sG9PlE+bMzlQ8Vd6IW09gzf5kz5mMnkAsNIOE77i4
 R0sA+lBdudzLE4yKWzrCSnK8ELUK5MDcSkWW4j2L7pXmR2yKqxOvUxH682RkXrmXmffl
 iOtw==
X-Gm-Message-State: AFuF++kmhIKhvuPXrllpsE3t8mQQlioiI8u1T0b4zmaBZhE5aRowcViv
 sGpwaQsgZctIULazTu3iYRVmzP+HjjeEzr/M/G/t6g31YNSf+kl4FqWMYIFO6T5huL1WKqo3wQo
 2dn35dpj5Nj5U/bEmijDbK4w/KgKF29icwJymBrtTElPuTaFe0+3AreQaf24FuaaTrg==
X-Gm-Gg: AYBFou2oNOjbITr/Cl0lyrI5CP8kEu0hpYnHEcTG+b4EePlStgrshZF5aQE7eoRUOYv
 uln4zyhNzqPUufeG4yIJE2Ac6hYXvvx/tefgNwzsG2YuiyBxkRRHZhXiIj4X/WHUglkefHR0xYb
 oSvnpDqDbMpZKs3ASiTpzF8d/TMk0oXV3AlKn4XCWP52PcxZQrMhAt4vabACGScI2/zE6TMcsed
 3/XIz2UM7BBtPW/jXW0ieCuChtW5jnlwgoQ0kNhjG+Tn6MfYvl268sMD1feif9nwpCmSrD6/hnW
 +Wqd3GEPp3T7iC5RxCvdxCOLGDfB48lSulb84kxFaXplWK1l9U3aIJPFtCTsFeJ1P9/dlyTdlym
 Z43+kEavi/4FSjL1MTLtipo+Nv5OTGpxjM7RUcTxr3F6hEbl9Mm9DKoHUfBoA
X-Received: by 2002:a17:90b:39ae:b0:39e:6a7f:1dc6 with SMTP id
 98e67ed59e1d1-3a098db9894mr5896629a91.34.1790384467037; 
 Fri, 25 Sep 2026 18:01:07 -0700 (PDT)
X-Received: by 2002:a17:90b:39ae:b0:39e:6a7f:1dc6 with SMTP id
 98e67ed59e1d1-3a098db9894mr5896589a91.34.1790384466389; 
 Fri, 25 Sep 2026 18:01:06 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b898cabesm7138253a91.0.2026.09.25.18.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 18:01:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 5/5] tests/tcg/mipsel: add multiarch tests
Date: Sat, 26 Sep 2026 01:00:53 +0000
Message-ID: <20260926010053.2840-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAwMyBTYWx0ZWRfX2Q0XRzrnauYq
 lS/tfMuIqB9cmDK/oT4kZ/DpNVazC+okRYPCiQOZgD2JWKm40QlvYqqL07arPLy3rzS3Uu83WSr
 pVR43scZfDOMnLgGc55rCz4j0Tb/ZgI=
X-Proofpoint-GUID: i1pEBxX2tXOoEevpqDMv8Sd7U-O0QKSm
X-Proofpoint-ORIG-GUID: i1pEBxX2tXOoEevpqDMv8Sd7U-O0QKSm
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab71954 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=hBK4cgCRInjPGRQbU2sA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAwMyBTYWx0ZWRfX7+13FJBZSVBw
 XIxMEZAkSidTvbiD3aP5ozlOWj8WFxvI+kTGrzIYn068y9UHDF6HWOoPkg8DbK2HIhnqylLs1yV
 gAXEg5bWcahTCiCjOFhSyudnIYsLVWvEngGMqVzlSfFkji/+AyId7Nw0XFEakhALOmdQZUu609r
 g4xlrrNF1TeM4G/F8OAvWGTaZGAHi9DIwgBJDvXlbM+tnzSXxJ4xv5Ji28GjYxth7Pjq4+AaPXg
 GF7CkAg6NituKQhNug9dXLUrzP+Esum5Cmif/0kLD4fQ/+e+UJUfpVtAhTlzVwsW6DRYg+vkuh6
 tT1wXoHjijsRyyR5LkNuVyzrN5lPo5AkvY6bLFr10Y4fdAQuh0ozR/UW35l5rXn3oGj3BVQu8gv
 jWXcvIffZiX8HViEhN4ZArrUl+jwbPhO5Mig82tRlQpG9g7UL51nN1yB66+yXM+ZmHq/4n5Dx/w
 LPQF+h+68cuPd/5rAgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260003
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
 tests/tcg/mipsel/meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 0bf7e840a7d..a02a4bac289 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -1,5 +1,8 @@
 tests = []
 
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
 tests_dsp = [
   'test_dsp_r1_absq_s_ph.c',
   'test_dsp_r1_absq_s_w.c',
-- 
2.43.0


