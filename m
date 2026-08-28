Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6CEC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YU-0001LW-6o; Fri, 28 Aug 2026 19:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YP-00018G-Sb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YO-0005pG-1O
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTv8d146839
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=s1rVLBMIWHx
 KnsT6S0IlxsaEj4BE12BpOyuaebWPi1M=; b=dggRfikJxxkZ8qu4Rkcf6awh2X1
 j4mlKy44LxS/QeESkH4DD+V1cAIeWJLyCjHSOh5KHGqO/QQHGI58YhUb8tQkz1ad
 vp5VSsp/qYnYjLXZRMzexJO3uf73WItGGRbdUnshfJ9eSyAXiPydMaI/URT5iK5q
 NRnu9k1DiFqrBq2kG84MKFK3pvSdHXi+4xQsLGLVe+QvQNF1u1ZxpcjGKKrHYM+g
 cMxCap6P8LaULxICcLm+xx4hEZcrRyAAGGgB0SW9oRQBvvCMRBmGFw39/QzTZxn2
 +07QCrfaivwdkYO68UnB0Wvjh9vqCkoIJVb42tjk9K9k2QXBLASwtc7ImKQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb7eh2s4u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so1829444a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957996; x=1788562796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s1rVLBMIWHxKnsT6S0IlxsaEj4BE12BpOyuaebWPi1M=;
 b=d2r1D1shiQsHKiQG5wkByBwZ11gBVbGrZ/74Q8n2TYNbxCbmgrj39HxYpmc3sAGaLg
 /hQU0X75VogcAaq5/MgWPrsL9QlubZ6hEG2/jYDigHiK2tgz/R41/oHqWDiOpafUgBG1
 DbtFRlS/b1pFywrnpdSMWV0u3/QdXsYyjYvVrwAM3Pxxq9/GPN7HAfp/ZH2vn3fN4bRg
 0wtjQpzFVIS3PoH2y9zjcqWWeZfWH9TLeSrBgFfdfamwoVKJfOIMZ6WRcYkAL9VE6xHA
 XZLamN/fGFQBW7kOmatwApM8J1Tyipqmlvq3ZxJBYdw+80HUntAY+qols6FIF1sbru+a
 5OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957996; x=1788562796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s1rVLBMIWHxKnsT6S0IlxsaEj4BE12BpOyuaebWPi1M=;
 b=T5ge5tgxMj8eUU27wSOqlavekMHuNY86Zyn9eWMkq8viHM5wXCdciO2GfLaOiPbfgq
 +5wBXld4O3P/O+Nb9SFejcle/X392MPxUEUx6ojZcbO4BA+off40F/YnPeMGmnLiyWb6
 W7G3EYyfvC5zWh/JTAFhYacMWGGYm4/7LiteX5U3FogsUx7hnIVSiLKjXCOJ7BPOC+/I
 vxraOW8QCTXk7FsqFY5Cwf0iKpfARMv1XpXZj80+MPdtkgyr6EmQJq+j3VHHA0dLIhsu
 90lVHwUHX8m340oP2OUsfLRwEmWRE0YSSWMs9uueta1ufIexy1YXLVYKl1ZJ/ILg3OTL
 t+QA==
X-Gm-Message-State: AFuF++kCD5jpZUE9Z/yacdMnabUgtQj1zU/Er+pyLIWnDBzS9kIuWIbY
 sEgSWAZ71Z+HUHo7set0tHlc4XgfYWjFmzjJZPrKf3ztA7lpT8MOGj1+c8m7813AcgZSfzz38IL
 RG1CeMmYI+izxebPrEDcywLg90nyYY5F3NvrkJ0kOiSMeuBOpLLLNssnDIPm25svhEQ==
X-Gm-Gg: AR+sD135XT4Qa0KEwSxPvJvzY8oOhBJJ9Nu0HCyjzvFNfeNbiUIG2xI0oRH9kDkq2Gq
 bmYJG1XSMquxRFUb0WGjwYtAP3zxniA+p5qxs+JQDobQnGWq6H80rApeDoWO/SjOgUIMXblgega
 to5iUNfzqZgmkf8jGOlVcdh8kHSUL5JocdShTuZzvlsudmftQaA6HTz+M6M3Fjoq4v6UxPGj19S
 5Q1a+P8oHU248oupxf+m8XhWFYHwrn7g0Suj/jc7iOZef/UpdnU54wbwz8IBX+6IF86woEBud4S
 ph1Aj7qxY/55VLQtkLpSXgG0YXlQfsyGAD70gVR4mcz7+kxt5JLuh3gqaQ2L9si49chVRyeICKf
 fG2ePxw8Ln9ijPP5fFQtcPITqyG+r0i98bfY9Jbq7aBdtbyHHVbpr1menClk=
X-Received: by 2002:a05:6a20:3944:b0:3d3:ae40:51df with SMTP id
 adf61e73a8af0-3d3ae4055famr3399242637.19.1787957995900; 
 Fri, 28 Aug 2026 15:59:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:3944:b0:3d3:ae40:51df with SMTP id
 adf61e73a8af0-3d3ae4055famr3399209637.19.1787957995463; 
 Fri, 28 Aug 2026 15:59:55 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 38/47] hw/core/boards.h: remove unused
 DEFINE_MACHINE_WITH_INTERFACE*
Date: Fri, 28 Aug 2026 22:58:52 +0000
Message-ID: <20260828225901.367438-39-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U1htTDIVYwICP1pNaffhlVTR_6l0qFec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXzFRcB23RmS4N
 0cwiWofCpBBKe1CLX/W4U2ciZWVy73P8ObG8pdrukkAXcXT0iBJHPUjpOBRwDcQzTviC3vTW/cO
 MVCn8z6k6c2GJXNyq7DgYI6UmsZYVWqzBcqRozx8kXz0tzBG6ilZeXPYPvWW7EsNO+CbFOtxG82
 OzVsuX9JAUSG/ya5/I0qz3igyn7jURJ9wpAjJczlO+Z3aV6JZ9QTDYZXbOG8skLlZwJZSIrRcML
 9Mwb5C0kztbIbPGqCi4dHPysjSrQvABkoukx2K8Z1vOjbc9EBl0PEG7XJXSV5CMeWyqh+7pa0Oo
 kf7oVriGPsPFg2nwBC41QrVG+myfltG4IXKWBXe6M5FRXrSilZ+SnsTdW1WdAhI6DJAazhbGG3g
 AmMZcHswjmcOvShrpp5daJxry2rCwYtMVP7/4trnHVwWQbFcVkzBZWwJZhcYMGDLWjeHibVfALk
 B/X/NxTNfdZkr9OQBUg==
X-Proofpoint-ORIG-GUID: U1htTDIVYwICP1pNaffhlVTR_6l0qFec
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX3CpcJgg95b7a
 IrwQZc9YUiKLbzK+CADoq3maUxWaWGQ/QSFeHhxy7zMmPeCKplEeqiV0905g24Nq6CVigY+Y9Mz
 Pcw3SliFnAd5CsQlgY2aN8PsAnYnNgI=
X-Authority-Analysis: v=2.4 cv=RoP16imK c=1 sm=1 tr=0 ts=6a9212ec cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Drpi8JZk3zr7esNuAscA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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
 include/hw/core/boards.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 2e2acdb6867..a745187847c 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -540,14 +540,6 @@ struct MachineState {
     DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
                             false, NULL, NULL)
 
-#define DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, ifaces...)\
-    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
-                            false, NULL, ifaces)
-
-#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
-    DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, NULL, \
-                                        (const InterfaceInfo[]) { __VA_ARGS__ })
-
 /*
  * Helper for dispatching different macros based on how
  * many __VA_ARGS__ are passed. Supports 1 to 5 variadic
-- 
2.43.0


