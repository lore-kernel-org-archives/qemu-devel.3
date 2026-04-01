Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF5A10F6FD9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xV5-0001qp-09; Wed, 01 Apr 2026 11:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUp-00019U-EL
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUn-0008CS-UX
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:43 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631Ef3uR3174289
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dEKo+PI+5OZkA0WTjHJsLVTWdm83mUoo/A8kK5cS4cA=; b=T1lrvW+lHd5HmiGG
 QP2K/OyRVbXHO7WXhlRHmZaxBSdrKIc139WZO1M2tJULr3Gj+iYer13QmhvMfvcc
 OwMCoVGxdelHNjgB2MBSkhmGJk7qyMmaj0vi/K22GcY1e6/Q8vfCUvSTrPRohlrJ
 4fOUDkK7FOonPS1GzMnexwNU/HciQ7dwpipDylcd5VtszYqAvSjMTz4J+ke8rL6l
 LSEQYDVu8olMX6phAE7mrH3As6Y7r17pcJv+cjzcoVjTBxMLb5HNniwzU9oA7ezc
 nQnFs/JuWlO9GovWql3qJ0jk6wJ5U8iwbrIxlYTo8w9/d5tGdvbZl3rWP8+F+rGN
 y4DXWw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d90gbhp8e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:39 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-127133794b6so8312351c88.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057285; x=1775662085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEKo+PI+5OZkA0WTjHJsLVTWdm83mUoo/A8kK5cS4cA=;
 b=ET9bGs8AC0pawQKAox+UsSaFyLx2v2Xg0QErYC6NkP7y7BQm+x6VhcN348FxW72XBT
 ONleJzKlNKDTleiJddjFFg/Y78ozm7Zn8Vy2bmkoOdfZJ0LEkkuZN1x6LtapK7fFXckf
 RMkeJgk69h59CAE97+7Vr/ije8PsVk9IfbDxYAeJEQidEU+XHYg1ULrDZSUQcfcBghMu
 +B+H9Cot7kFvvq+Ud546nv5cGnpxMeYtrbH/ppHHgduFiI7NqNFZnzClMLvOKiV3pRuU
 z7HNIVOG0uR5zhelwek+r1I1NLkBIab7YbOPSqkwppPjoYe6NdQ2hGd5I2DUwPaf/Kwi
 ai1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057285; x=1775662085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dEKo+PI+5OZkA0WTjHJsLVTWdm83mUoo/A8kK5cS4cA=;
 b=OyK4YbNAcPPpdOliqbwRoFQMGtm/fkXtMiLQB2IffbEOkzdtx0/fBJuJigI6lxjWV3
 cPOxYpt4ztD6KhEQKnASvqdh7Oliyib9q/jXR8cPKShlQuCPKub5CALyYaZ7qoKmDfXY
 bN15w7GOPuE8gwwVVq+a509qBp8vyDkS3FYgtAt8IxQxqPoQdZWhnWPkjzw07fgM/L/e
 BhqODn90HHCEIm7f4lRFsDIVWQt6p8TR9AOVZq0Tz0bc98iE1HAKeM5olyc/RRo1Ciwe
 o7HIrAeyofxWZ3YOhXHDGHOldIvMb7ZKAzjlKgT4e/Gd/uePamY901BQ3JZhFK2EM1mJ
 WtkA==
X-Gm-Message-State: AOJu0YzfnsPVMYujY5Zgcuj4teSMIXJ6emtnl9tMqmxLlgQWhfd6dHAw
 4uBfeGdvD8fK5LmvE+YdTum1VmHStuBhPsmOCrxprSD976yKx0ThQsMLOcYm/eO3FSy6oyJLQdx
 Psvtdponji93QE9mi6VaGGwpkP1po064mJieMvW8R6ly88McWkp7gdodmIibpdJ5HuA==
X-Gm-Gg: ATEYQzyOrzRSGrL+yl3HYUWGPBdSaY/wFRQcJbQNyA3ONGD9oM1CR9NumvLbuexCYRQ
 xlilQ72RkDijJzqiCD0eHJ7d1QhQGnycbDIcRHC/yz6FSPCuabqdOvZ8/S0/QnAFXnS55ylVUOn
 8TzuE6wdpFeyeQ5iQpFnL9riRQiskUPbHVrvKnw6MNh1OB6NnK9QdK16OJDP+B1Ti85Rqf/6ZPp
 JySgGZx3wrv6f5IUKqLYaZ+9W1RVelwgt0SqbCpxoBRdGR/5TDQa0ccnLeIcu6sy8WKdPMjo4uQ
 l2sg6EVsmrI5rfTISIJmyIdaRe4c9+w6ZnNu4dp2NhH4/DUyCowD3FWNTHwspZKOmbvFDsKHwDA
 3OmLaixWvphx93kA3UU41fbX0YkFivrzd0ftadvKLmIkEHtzy0dwHYp5B8FtYtzN3JzWg9Q==
X-Received: by 2002:a05:7022:391:b0:12a:72af:83f5 with SMTP id
 a92af1059eb24-12be642a500mr2084511c88.7.1775057284658; 
 Wed, 01 Apr 2026 08:28:04 -0700 (PDT)
X-Received: by 2002:a05:7022:391:b0:12a:72af:83f5 with SMTP id
 a92af1059eb24-12be642a500mr2084481c88.7.1775057284071; 
 Wed, 01 Apr 2026 08:28:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 20/37] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Wed,  1 Apr 2026 08:26:40 -0700
Message-Id: <20260401152657.314902-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX42XfXD68if/6
 ke9rdPeg4pL1Y9qZdETrCICfc1JvcvzLJfroBj2JOBQE44Mjwb7SqrfCVk90RbEk0+h0H3EDfW9
 1uZbWzPR92RnqsSTJtWFuXOrhWt4mYaY4/TjpvW2BXVB9gTmHW3nLdQEpBRUf/7Hej/UwiJ4s0x
 S9RjJ7sJCCEN+LGAm9ld1OtY4GjMB5W3260cWOG8GsQxDVkk1WA/EALs84jCH6v/yJueE3wUG1f
 mIEyo1YcDLU5ThYvvy0Z1NK405gVmB7bLBp5+yY+LIr336EowdggbeU039F45kLVgDIO5UPSm/+
 XM3h3ZjOtbyXD7S1CZVBVWzgTqzb0+CbDM66cRMcsHiuBasFR3ARQb/LP0LNSaxvQDtMvfUfGq/
 IfBf20wITB/b3JyYZ1ehecjADArqxodHrNs0UAxpeyoWONNoZethyGEy01Lb3vzxEC++BLA+QSZ
 6OmKi/NQw3FoZxcJrfQ==
X-Authority-Analysis: v=2.4 cv=QJJlhwLL c=1 sm=1 tr=0 ts=69cd39a7 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8AIcS7dZ67HrSpPWHdEA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: V9B2R05B4jxLvenQDUNvdIqATpj6pV1N
X-Proofpoint-ORIG-GUID: V9B2R05B4jxLvenQDUNvdIqATpj6pV1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCAxZGFmNzIzOWZjNC4uZjdjYTQ5ODZj
YTggMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjUwLDcgKzI1MCw5IEBAIGRlZiBuZWVkX2Vudih0
YWcpOgogICAgICAgICAgICAgIkFfTE9BRCIgaW4gYXR0cmliZGljdFt0YWddIG9yCiAgICAgICAg
ICAgICAiQV9DVklfR0FUSEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKICAgICAgICAgICAgICJB
X0NWSV9TQ0FUVEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKLSAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSkKKyAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSBvcgorICAgICAgICAgICAgIkFfUFJJ
ViIgaW4gYXR0cmliZGljdFt0YWddIG9yCisgICAgICAgICAgICAiSjJfdHJhcCIgaW4gdGFnKQog
CiAKIGRlZiBuZWVkX3Nsb3QodGFnKToKLS0gCjIuMzQuMQoK

