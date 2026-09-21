Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BFEC982FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8nEI-0008Ft-U4; Mon, 21 Sep 2026 19:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEE-0008Et-9L
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEC-0000FZ-E7
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LN1vqw1860580
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pQ3n0aHdu9E
 KZmZZQfVAw4ZJB6KBMcKPJE1YkIDEtzA=; b=UjGOnYpZPWGyQTM5sNwqefhSc+w
 lcnmAmqbvnqLsTKDJ87lslpnjuTXIy4qOsKQiOgclbPkHk1wxecicvKNUVLOpjSz
 rtM6H//O91y8xP6uSO9Im8/D0MCbQjm+eOIneoNy76elGyYTgPzcVJgCcoQwOQlh
 wIc6oHQagFRYM3xx9NvC8xmxGv1btXJ51IhCYpww5fG2W0xlu72rSZzkPMaG2+YR
 E4X4z3YLe+DHoDSVMlTabZWTwKthadR/Qc7H2SWMRUQ9CJxOgkofgioGnNAAYRY0
 8DvIVjDVFmFky97sOQxR32RkijcGc/yjsOoBcijtHugfqff6d6LQJWiN/cg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gudw0g16j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39e3f521346so4042283a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 16:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790032514; x=1790637314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pQ3n0aHdu9EKZmZZQfVAw4ZJB6KBMcKPJE1YkIDEtzA=;
 b=P7IhbiubUOavZTOCaws4D7c6CduXB4labPx18lLIjj/Q/z4nOTtsBTeH3QIzKIsDeD
 hwr5vRXUgz8YqMA7D3Gu889Z1Wb3WelNU0WwMsqqNwJM5c/miqJCSoauSvqGX3Pa7heF
 ExoeCFjAXibFgo925pHWROWJE7qTT0snod7z1O1qdgT73bkDwuPs/Ghieo36NWWGloQ9
 XMTcVdhpbK55gdrAZeB1c2SCuDoPUveHLNTik87DrGkQboZN5640xhKE9tjAMt1wbGoC
 c7G6MswgT0Yg8KLiwHFCP8eh1qqi0w63RiuWQ0aA4dKnOOP0tJlrWOMv6l2Pf+uqe2+a
 4cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790032514; x=1790637314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pQ3n0aHdu9EKZmZZQfVAw4ZJB6KBMcKPJE1YkIDEtzA=;
 b=desmcIunXminWMOat6Vf16j7CWHnhpPwZrC1XgVPz3JrIpjqfRcbtQ5hx+XczFsJmE
 h1ru0P/CEMUDomMbOAvXvMvccSfruKdrd8uvyWTvAfQSVmDOYKx4TfhDLDOArkRTXlEO
 oz3s3eWthzkZ7RW+3YZ7JiiJZvUzqeulWsAkzpgKwj3J76HCRWQxCaiKVTI7GzqTpJnG
 8Cv33mdtu/qpPKVaWC0h1zh6vUl3wz+oNR3++ypTE5x8ghSt8Nj8Yts3jL8+xWunSXIF
 NYhdgoNB+2+Qtt41Stp2rVKH+INbeTO3YEEvCIr8hNX+zs0FOYD07EY3wgUjw5zoQCVq
 riHw==
X-Gm-Message-State: AFuF++m8+4ZQxeJ2/wOSCRLEKZ6FafdL2wm/pMuDUj8itfPXfnRkHDDo
 F8NBwjY8tETmm3aEmgu1j2YYET91gKWFkRtorUll0FqLEsitzuj5YV8MXV4j7PVQ4zjFwEnNhrV
 CfZwJFjXF1QxADZzN30WcLfTOte5xphGn4RbBNZQ1Gs4SpQkZXz03PKHYaE38DKzqpQ==
X-Gm-Gg: AYBFou2j6jyKBHV+r+xd4FHc9KOWypgOZ6BBfFGLnJx8t6+PdcT79hRP25bQV0hNMf4
 Q18OrHlH6gKJqi7ytE1Xaw/R0t9wP39UjfINXb6A/osbrPutQnb6prcgEbe0d6orLEWR26LCCRJ
 Sj3fJV1BY+VvMfH1Yb1oCp/idmZq7KpsLAppIqnX8JdxwmdgAwDNTiEtGqCUlE99fmp3RdpLsSn
 LcLK4ID5zlOITMNPGhVmvoQr3Z2MTBrcOxcxurJNcE+bQKUxT03g289JRLVT6HsYPLxDef5rOt6
 Vep8f+C1mFkZBHo/wcthwqhVGx1Jv5iyHeMs9oY5seAo3MTsp5Srg8z9ZHf3kuISJGr1U0IyzyN
 OEnmnNowYRqaQP2H1yRyyUi1jsLnCQKIUaEghcJEiFSD8BbtNhphBjwm+RwJ2Rw==
X-Received: by 2002:a17:90b:180c:b0:3a0:3d1c:2dc2 with SMTP id
 98e67ed59e1d1-3a03d1c38c6mr7017641a91.66.1790032514432; 
 Mon, 21 Sep 2026 16:15:14 -0700 (PDT)
X-Received: by 2002:a17:90b:180c:b0:3a0:3d1c:2dc2 with SMTP id
 98e67ed59e1d1-3a03d1c38c6mr7017620a91.66.1790032513922; 
 Mon, 21 Sep 2026 16:15:13 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0674c0b4bsm1295939a91.13.2026.09.21.16.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 16:15:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 7/7] tests/tcg/loongarch64/system: deactivate
 loongarch64-softmmu-memory (hang on aarch64 host)
Date: Mon, 21 Sep 2026 23:14:58 +0000
Message-ID: <20260921231458.3369-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NhdngROhSGLjTNh8727yS8oxZRYz14sY
X-Proofpoint-GUID: NhdngROhSGLjTNh8727yS8oxZRYz14sY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfX2wZH2FXvUNJH
 r3BUxlKA4DBHSTCXxGKIeRUX0n/J3pwOhFDf3zX4x3GsOG7BGVZCfjJ81H9uX3K1h5WLvqxh/Xt
 cyzt9W6H3ZDr814OStUaXhdpILfSHOjchSOMSmQPkSDdlHLPSmSbCIXVf2Q57g4HeXicnWPbbxJ
 R4maeteIV3GkjI7kXI0u2HxMJIdpWXwvkJQFLglH132uxrFOkv5iW7V/k4T067MnyFiaLEjEoif
 tYGD1awYqj6syUVL4AO4ESzdkth3qSD+doIN7BI5ahKpOf1fWz8wtWPFrhZTwqDEx6GVxhBKAaa
 Zav8NUHPOUAB+i2cB3EH1u4MmrOD7HZ+OIKoFgP/8i7EJOaVP5CUAV6BMKo3Xn5CMdYAgi/UlH/
 V7KeGnbB1SYcAh/AGluQH4YB4YOcCxh1hsYSQ+2B8stnFaOIjg3YK7qy6Smx+MbMTstRMEN5vTR
 zrYPqcC1bFYf/gZSHdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfXwxacjkZf5/ME
 Kpo0dbt4uUgySqIQvD8lfOnNzCWIoN4o3JY9g/xTfxD8PWY5Qm/XVJgu9n3erx2akttADqWB4xp
 lHrU1gtcWkvNxIBk//vZPSQLsFao5GI=
X-Authority-Analysis: v=2.4 cv=TvFzFzXh c=1 sm=1 tr=0 ts=6ab1ba83 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=Tik54YSiwzO2kUiBZWMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210340
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

Created associated issue:
https://gitlab.com/qemu-project/qemu/-/work_items/4567

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/system/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
index 035dd5f85fb..33e9f58cc28 100644
--- a/tests/tcg/loongarch64/system/meson.build
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -24,6 +24,11 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
     new_cflags = cflags
     if fs.stem(src) == 'memory'
       new_cflags += '-DCHECK_UNALIGNED=0'
+      # TODO: memory test hangs on aarch64 host
+      # https://gitlab.com/qemu-project/qemu/-/work_items/4567
+      if host_machine.cpu_family() == 'aarch64'
+        continue
+      endif
     endif
     if src not in multi_src
       setup += {'cflags': [new_cflags]}
-- 
2.43.0


