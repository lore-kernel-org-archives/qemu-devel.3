Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0249DCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn8v-0003KP-FJ; Mon, 22 Jun 2026 18:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8s-0003J8-Rr
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8q-0006Ft-Im
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJcgPG1938794
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=; b=KRpr7OpB019tWEGe
 sdKjHxqTYt9rz9WjG/kJ81BdideOubXDnynIW47IAWHUgp/hJjZdEck8UTHsv/T4
 ZjY6HNzPJL5Vu7X/O6UOeYlRlxsoIhXcwi4gld1byZzHqayk48qNFM7etFuhdvQ6
 uxVRa8aS5vpdXpehf7u1p6OOVw9DWwoHB75TrcYy8e4wle5j0LN1UpVn0jO1pU62
 U2aMGuM0q9lVs79TSCNKd1yoWTR4kxct9jqZvKM7Ax+LpqOR+FwE/J7zbSfjKlrd
 usOJPd7JthoBLZ5CQ7sOhmXNfZwSFWCv3XAcXMYDVEAxHx1NKG0KxabUBzXmlmd2
 tfBREQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye9wsk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c17bc96afso2893101eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167358; x=1782772158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=;
 b=YVzGwWTEycI81PYiUVlEu8IDIk90sQ5IyqjUiLU5/4ZcDd+3bpNjYq0iDNUx0v2VXN
 kJ+DpY9UiP9PqFxzK1XmjohSvf2X+f0Ns+8AoWsWXCLLd140EjgzQatkUGM6hCUoQn06
 /LArbXvNDzxUgnVzZEHoMgB7UwVJfhTciPek4omh0jV4jQap29nV4jM6rDbjzfiz54tX
 cxwIqqrt5rhyEjPxjcGMlJq/gly7TEXPji+J7X5b8yk+m6F/r9zAossbgp8NI+ByCE8l
 66AmOfjq2kIZhJTiuoEpSlyRA5H5kdKP4w0MpGk0X3HtfcRykvcLgzgx6DfEhXc8qZX7
 y6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167358; x=1782772158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=;
 b=jU1AXp0AjjTIe0siL9cv9meAA7Mvo9MTW0SCTYnAXeb/2AYMxmXhcYACKOYKVagjC1
 UyDzzsE1npUcdBatooN/34kqhcfTnEF4FArA+uIp2mb3Fzzb1ANUu6CzH0zrbaNu4BW2
 yOm14OHyS5kjOOP60QOz4MXmnmP2oQwANLfucWaoQ3WzReBp1I1lE+NwqFvaCD0zdOAj
 K50FhHnO1oGUvxKlkgSIlxul9yjnAadH4pIetGprpPy4pkWegn1uZQUfyuBxERsx3oMz
 ggmuM/qqYRv0OqkoPb9D5ZH9hVL/R3CJz+Uz20gIuYErajDVR/G6mcfl5WCZEZ5IaJq8
 gB1Q==
X-Gm-Message-State: AOJu0YxUmWNqxIqh0/dcwoJcsCjl11d89vToy2gpe3DqcE6P1g2Ujf1P
 QvSwAZ4fCq92QnQRsiLrr/7FWiwh8cKQNXiez3zU8uG8vGFJ4y6avF0MXtDIAWF7qcAz0dZS6/s
 O5yu1Y1xETAM2FczC52o0JAWTRcUpJmmtm3S1/eqVsHSjxLgXOjMRTzKvBs6jQvyuOA==
X-Gm-Gg: AfdE7ckuW0phzQUKe/D1w5Ak/TK+p9G6zIAxtgJNNXNk2UeN3tRJkqfo96Ac9cPRDiT
 PYgdDEJp29hOLOF3z4hxCqHRR0EDv7x//G8hIrQFrnaYCQgYtK/klgBeD+cZEZl/UEip0Nuvzo1
 LQ+ZUUTsvKur6Q2D6fjiSqToBa/LFue4wxoCVvdbfR7nFDySPs5j57kXbGiMFzmEzjSCBYtAs6U
 Bm1lafXonLsm6LzLvG2fV2GSWpMv3JEtkc02ypH4aa0zuIMxuwPwKq/gE0HYQLUinWxb9MzTLnN
 o32Y3eOYJ9SGZUexxiOZIJ2MucFuYxaGZjPGB9fS5vx7UoRciqVc64y74Nl25Sa5AY604q+8XKi
 QbGH52Tlgp9UofJS0s+la/+OW4+CL6Zq9mh8zjKMEyoL4+FVQk+HnL6OJoEs=
X-Received: by 2002:a05:7301:5f09:b0:304:e72a:d4d9 with SMTP id
 5a478bee46e88-30c58b66e50mr372941eec.19.1782167358351; 
 Mon, 22 Jun 2026 15:29:18 -0700 (PDT)
X-Received: by 2002:a05:7301:5f09:b0:304:e72a:d4d9 with SMTP id
 5a478bee46e88-30c58b66e50mr372907eec.19.1782167357775; 
 Mon, 22 Jun 2026 15:29:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 05/75] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Mon, 22 Jun 2026 15:27:54 -0700
Message-Id: <20260622222904.607771-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: QASFpUTGyx39ivEblYLUz2YVrOKpTlYg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX0u5Kk8+wDPna
 grnMlydgd5aW8yYQ1RQ/OYG18nhKxjg2IahuOWY4ehaCjEclHHsakQkC8L0YdCePqTtcn8knyRf
 WssI1R26rFPgHNPhtJMIhcYokUn1adg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX1i5RSYbkSiSY
 VvbZw1QGLRAnuqDoVqByjQL3wzKSkJGZRDVgLf1alGPlosCYRkXj9pmjDr7oJRiH0FP4A9ZQ4oY
 LEGfmSXWuE1GiabuLSUySy/2YjB/Y4fZ09fn7clS4cbvChuj3UVlaFa2OrDOOhMR2kOXimCiYLL
 UgNhh5JniKz3iyhRu6BDKoF5HZtI7hHa3dpWxeigN5Wbc1elQ18Sj7ivhtgGHPGyOtWFgI1utgl
 rueEbnogj2pwODueWKOJFPKnHjVefxH01dqghGaK0xb1h4MeZvohIB8EChRG/qusy/wWdt9D7uV
 bm5qQyF279R1UhhWYWIH7LBAx7c2VEfNxiafbCAGQJxabdTZercFsX8/6LNodfecKE1OMTy10Nd
 cAPEbFgHF2dSUL+IlT6DgC5YRWROA0DqfV9J0PDSeWVlRheVTW4jc/lhSm/UQhNjDuAKxfbvP/m
 DcEM5G2Pj/2H5ojxACg==
X-Proofpoint-GUID: QASFpUTGyx39ivEblYLUz2YVrOKpTlYg
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a39b73f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ZLKCIdW5I75hk_SXmpcA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBlMzdkNWE1MTRmMC4uMjgwYWVmMGRm
M2YgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjQ3LDcgKzI0Nyw5IEBAIGRlZiBuZWVkX25leHRf
UEModGFnKToKIAogCiBkZWYgbmVlZF9wa3RfaGFzX211bHRpX2NvZih0YWcpOgotICAgIHJldHVy
biAiQV9DT0YiIGluIGF0dHJpYmRpY3RbdGFnXQorICAgIGlmIGF0dHJpYmRpY3RbdGFnXSAmIHsi
QV9KVU1QIiwgIkFfQ0FMTCJ9OgorICAgICAgICByZXR1cm4gdGFnICE9ICJKNF9oaW50anVtcHIi
CisgICAgcmV0dXJuIEZhbHNlCiAKIAogZGVmIG5lZWRfcGt0X25lZWRfY29tbWl0KHRhZyk6Ci0t
IAoyLjM0LjEKCg==

