Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76848CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndM-00036E-Sb; Mon, 22 Jun 2026 19:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndJ-00034T-Rj
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndI-0002Up-6U
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaEU72101424
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=; b=GIhyAQDSSmUQxO3p
 WTCnhdXTZTqDy4F9uFtYy2jYp4g7qP8JiLGiiai46i/Bj3C01uO0v8CGTPWo4dyc
 xUmNwTAPpCSMPZuE3OMNwMDYqLaBx/ac7Sp96zgv8tZkQe3u6dOcMDu6WTh7BaxI
 UbKHzwClZsLGlVBrVjquEBMI+L1Vy9DRj4EiiQKphBq4hXa1g1837Ixl7eFld3L0
 YKZPI+Hyk3rQqYxG0fCeZ0WCyu9sX0/ggjWRvUhgBOp7jSh/y6d2uCk6PYqCFIPQ
 N2XdA9Zbf9wDvJaeTexl2l+UebV1ZgTFl2wrr2If5OofgXhwqAvUKqIhb7BFK62p
 Rkr+sg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3ebah51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:37 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso5231074c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169236; x=1782774036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=gvwwVSnkYR1wizh8F1Kw3g1VS9sKSQAy8cjekpX4Qt1L7vIES+fvzLSbm3Etc5NHgF
 36tRq0dEitIuNQrWuNELZ+CcfAiKbRKujuBrUuwztRXY4Uktvmt7VLcAU7KEAntAL2Bw
 OpRuyf5u+3kIn7cyEn+lmBb/oAYvVA5/mrsCsjPKm/2XRl4dfxfiBZnjqkIVDKATvStD
 qrzmfkF1VrQfF25BKxzcJ9ZHP/UN+HLlJbqv+AVb8eDScJwqVqWYA8EwiSbIdTJvSfuT
 HSsObSnvMZv2NV1VVRTL+wOhMhlGT7IWK0733Rjd3sw6kDy6297pb/zWCON0UBZnZ70G
 hSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169236; x=1782774036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=Aem9OidGUAUi8ulbfhEEt5x49vP+1QIdKPZ7ANP1dpF8mPLogK7meBin4cFEw6FpJt
 LkiPYU8Xhi0OazZzvKp1KW3FA+SHGFC5Iklz98FrQ9FOMsbrAGlayhOxc9nvydjSmhMB
 4+D9tGXKcQbf97hu8m947d5vfQFSsZ5S2DdLdvPue2m8FPam85uo0pLmcGEeeHPLHToC
 Qj76qvJ12gSf1C6ditU1OrtGswW+XjSrtdLUkFX3ok4fbPTMawU/0XmHpB3U2goDy5Uv
 48Pjh9+xBDWNQXDsHzHO6NpZbS3XC8uYTbIwbFiDMMRcoy3ZOljZVFA8ExcsAHvLTonp
 XwhQ==
X-Gm-Message-State: AOJu0YxttA4y6DGavEti2nq5vsQujKT8C7n10rajiTN7mgFRxuhzwCQK
 9reMPK5F8lO3riYYzNJOcfglIGO28M+TkU9MyM2ILVcF6mXiTfE163D9hkbfw+P7gZyp+saOhQR
 jL13RAKRswxTds11fzHj7oZBNb2YAeIZXN9r1NV4iilMP0YbtAt1x0fYQq6G/FUOABw==
X-Gm-Gg: AfdE7cmH0diri/ZLxCrS/nXd9z4GwnLt4YN4wgcFKzqnGzzQndMuRYzNOjrLjFaHBZX
 pT2lthZ3LSfIhDncRDauLgByDc/EFryeIvg8ydthzNDwM3YTEN8cWNpToTgXPhNWLN7zavwF2Ac
 MR+5EmmE91I4AQshKYCh42wgG3Z0jdQZsQmZ1bCe738XN90paNHAOJwNJzwfUay5dih+5qtTi8D
 KGvutTkoSaPq5B4gQQ8Mg807PrZ8SI06DpO9rk2bdF2uDSHmLC7z78r28opGM1ZaFGz1XV3b+kI
 7oVzD+iwgSEbxeYtXH9bZZ5wOg05iDrzVjH3Mevb8VLJZIXTe2iVnFNMtgWKHPADQaDd/2M2rDE
 wbfggxnc6l79YgJo0y8MfEOqIDVRv5/9phSEZBLsle2fn/nkfTIfMKBA6NS4=
X-Received: by 2002:a05:7022:e98c:b0:12d:d972:b969 with SMTP id
 a92af1059eb24-139a365d1c8mr9199787c88.24.1782169235980; 
 Mon, 22 Jun 2026 16:00:35 -0700 (PDT)
X-Received: by 2002:a05:7022:e98c:b0:12d:d972:b969 with SMTP id
 a92af1059eb24-139a365d1c8mr9199766c88.24.1782169235348; 
 Mon, 22 Jun 2026 16:00:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 59/75] target/hexagon: Add implicit sysreg writes
Date: Mon, 22 Jun 2026 15:28:48 -0700
Message-Id: <20260622222904.607771-60-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX0x1bhvBlUvb5
 md76lXU7DPtBGWIvlU6D+xI38urYCNOlMnCNROG/KTRIlfayIkvtulRvKwU4NKxb/Kq3xu9DEf1
 fsHGe6JU7muK5Erv7psHCZB2EdYxvFc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX/ilwV0FJiBdL
 BLrKR6LEHjWtuC4qU7y7B/Huxww4kjFV9Bpk9Z8bq25VfZ6L/lxAgLkcm+7dnenEXpYhFkCznqt
 aZMyPwQwARflo0dXCOGoGcwXDTtlEPGXVNczbN/sN/QCBY+qsy51z/Wt0wrFqwjg3CYcH3wSEJn
 +i3JGjXC1tYacmttNqbinGa5dgqSNZ7G68Xkyf8kI2F/iUxIMaXLBL/IWY1hwv8TFHOqRKeh29D
 oPFhE8tUKbCF9l855D7rhf0t7lb5YjKZx7CWfJU8dTTOQzasj21bbaFRjrgneUWffdUo59/KaAO
 5CkZyxzPbd886Qf80En0b6uG6zsxtOW9GgvkBbAYmaZpjSI8OEX9q4tjMHe71PRy4YjGAnpDo91
 ShDXN9HhgcB5zxx+CIm1NVbX/GFuLpIXRFONO8M1jIEFHaB5NRfNPUXLiTWZwx/GnEYaSAGufx9
 veGTSTI4Kw1O5LwgveA==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a39be95 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ySlkKLH3HnL0fBWr2zQA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fOpliKkVaT9C6X17SoN8D-8uo2OLv93s
X-Proofpoint-ORIG-GUID: fOpliKkVaT9C6X17SoN8D-8uo2OLv93s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY0YTM1Mzk1OGZmLi5mNTQ1MGNlZDdkZSAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKQEAgLTQyNCw2ICs0MjQsMTYgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNp
dF91c3Jfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBhdHRyaWIpCiAgICAgfQogfQogCisj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIG1hcmtfaW1wbGljaXRfc3JlZ193
cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IGF0dHJpYiwgaW50IHNudW0pCit7CisgICAgdWlu
dDE2X3Qgb3Bjb2RlID0gY3R4LT5pbnNuLT5vcGNvZGU7CisgICAgaWYgKEdFVF9BVFRSSUIob3Bj
b2RlLCBhdHRyaWIpKSB7CisgICAgICAgIGN0eF9sb2dfc3JlZ193cml0ZShjdHgsIHNudW0pOwor
ICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGUoY3R4LCBB
X0lNUExJQ0lUX1dSSVRFU19GUCwgIEhFWF9SRUdfRlApOwpAQCAtNDM2LDYgKzQ0NiwxMiBAQCBz
dGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAK
ICAgICBtYXJrX2ltcGxpY2l0X3Vzcl93cml0ZShjdHgsIEFfSU1QTElDSVRfV1JJVEVTX1VTUik7
CiAgICAgbWFya19pbXBsaWNpdF91c3Jfd3JpdGUoY3R4LCBBX0ZQT1ApOworCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJ
Q0lUX1dSSVRFU19TR1AwLCBIRVhfU1JFR19TR1AwKTsKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdf
d3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TR1AxLCBIRVhfU1JFR19TR1AxKTsKKyAgICBt
YXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TU1IsIEhFWF9T
UkVHX1NTUik7CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9wcmVkX3dy
aXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgYXR0cmliLCBpbnQgcG51bSkKLS0gCjIuMzQuMQoK

