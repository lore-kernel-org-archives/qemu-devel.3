Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C7ECD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBL-0001af-FF; Fri, 19 Jun 2026 18:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBH-0001Z1-9l
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBF-0001UB-Kq
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:23 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXg4C1285925
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=; b=Be
 79M+aq+1QfMcTKOy+SOudPZYXnK8QL3FRE/7HLeTSSt+9GSSlRBEgHD4U5T19tSR
 DUjf3eWRYnlefoFWriQ9rHpglxjW+ME7Zcj9yLeU9z+EILwRpHljwuKeJpoO7RA2
 mklt/AMUCH+ldbMQ2P9qNNhaeQEoLmJUCo0TO9m+9YEZfco9hcIVF6SB+jV9IdR8
 g4Nwqh38QFN52go7Yyz5+0IzOHEScrsh7OJ/YOwLiV5S0VMaH3u+FEJcSD3xJLOS
 /xTwPCS7aTlEBAIDpk8BZzsdMn8utFumvMHZyYigCwG0jrXR0o6AWoEadOeQIL0v
 bnSr5SKdu9Ou6J8WZhtg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evy72k80q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bccca5620so3385078eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909960; x=1782514760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=;
 b=ee2dT45Y1EaTrz60TTUcRzYam9OPzZw5pNe0RtrspqtAWcNuSAkCrRSXXvnq/MBfXJ
 yVUcoSwMDVskbJ900onAugLIKS8frBAdPSw0kTpO/zpi55c/KsSLR/ZTXIPLSIgKIW+7
 FMYQ/9BUiVTcMHU3I03CMx6asMcj2FrDC8Cx46kbV/Zd+/fB7qYMNedGiYvulXNLkvtk
 5GS2vOYqYncyVHwEOLdY01teCL91AZ1acqX0lMFiq6Eyq73ied0tI02zxQGyTk2Zf8Nc
 JKXiugT8mXzc1dSNlCnZ6wnnJO91QHz9BpVoqKoGpUmg6xSwN7PWYPCuU3YiYGG3Wrox
 XbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909960; x=1782514760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=;
 b=o7+aidWVFBxN23KF5pCGfh8uUw12V3LShgFC2sJDbYLIvjZZ/lW7SiBkDDCmeml2vK
 I6ARZbvGbwCJ85Mi/Ov8H6napNEl3dHDKvgFXvVeKR/jqn2G4D+KzITjz63IDJnhCQFu
 X1hhd7oLhAwHQ5OkQwl0w++LojRWPN9FN42Zi9RdPwKMkjZrvygpqbJgIWaSYb80JSn5
 ZVlT9OHotFMKREzE60rY/jtdF5e1zSwTqbTLvFWzVtnkW/Li3VGyBarE4VX4FiLlijm6
 008qUtKFqBql1dIpiUmchEjHB2rOK/U2gh4HACuB03hn/jhvxqdB7kCBN44MwJG5//Gj
 Y1pQ==
X-Gm-Message-State: AOJu0YwzXygu/yCvrcYBfq8b+PoJdx3uO9goukT0Jku7zMJiyzLzViR3
 j7k/KhO+0MjlCuTxrkBZ9m2PeyMbvdJcamWxi4QsxK3VSaAgelpXJC35XmooJ+PwPKmf2wqJJ9P
 3fmy/Oqdw183kroCnwJqvWg+SOTek8jOCGd6doyK+etHDvWjOTaZzACIF+TUzgbpcSw==
X-Gm-Gg: AfdE7cnaGDACTJJ8BT8hrzFkSaH21+UluyFDNk7nrh2HtbZ4tTRkYd91cHkOzqL8iOJ
 rSmcHR8k1HL/efzWkAK8cBt5fMGXM4ktzpGcA1+2oa/6ITCWIxZTBu/hW2wCu+gUH5Y3t5AQOIC
 Eq142g7XhMMRF0nFkeUDuffbSeFW31WAx9P3JnpX7edzfqHTN9ZRMFawOv6m0AwxMFHwjR12BgW
 NXpioOgZn6VrKAOhzKUyRAkBti9MFWLfKoTX0UqhPMYE5HjNS0H8eOBOnfW2Wh42uPdVxacmbYy
 dw+VwVFxot6G55NOZtZrgtBcc2T5NkGJ5Qm1dN0EKePkVGHaqZLCwKnc5yrUJ3iy2pM4Gk5dYal
 fSj1QnwkEETKGM8MYCXEL+wPKQldzOYc02rqSBcc9m/n5OnG17Z+m9dYa3P0=
X-Received: by 2002:a05:7022:ef0b:b0:138:4e1:4701 with SMTP id
 a92af1059eb24-139a37f5e82mr2339314c88.7.1781909959595; 
 Fri, 19 Jun 2026 15:59:19 -0700 (PDT)
X-Received: by 2002:a05:7022:ef0b:b0:138:4e1:4701 with SMTP id
 a92af1059eb24-139a37f5e82mr2339303c88.7.1781909959063; 
 Fri, 19 Jun 2026 15:59:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 03/74] target/hexagon: Fix badva reference, delete CAUSE
Date: Fri, 19 Jun 2026 15:58:00 -0700
Message-Id: <20260619225911.159473-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX7XLSlxFCBp/T
 QciPH2G6L+83yOVn0u9QbatSx+8ZrN8m4xPA2Szv5KuRgEPT/RPeFDB/nL6Ed8E0UlE/bpKjfoo
 wJPOYsqwmIr32IlDWt8KssIkz7qJSkYZhmubcTMRRD70yUbJYSoNYCpKaDlfntRtdK4+GAoMMfS
 +UUUzgz9LdBrmuEEMHIDRr8ckVrW0a6mtiljTJpCyH9EPC3Z6SgHJGRWLOoBnvkPVrloBG74x6v
 46ff12qsZvThnebi+ySMQmDb20I+anF+Ur/1p4RAa2X9fJYiFFeDBBNjwikzQb59n9X4/ZOjPdp
 wvb6899zVrDxFkWiG42Ez21A5z0OFxG3QKg/6ek0g6AbHvFu1tMKBlbU4IJELBMqIXA3vfSBXD9
 SKZw9bBJ4tY0wxKOCX6ygkjgVKCLUGpxL4Xkw/I3snPw0UuKxhwHEin4yOXXYsdvnJigrM9MapE
 neaDrpGu4LKejWVoV9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX6ejTLzkHGR7d
 fbq5eNswvHC6cZAQCDZJKTDaRzZQT0sF788bgVKdIQMMZgfxxgc4OtWsB3vBNy6MwNSbUms+uQ1
 g+q8w/nqvkKakQoaYUEp8nclGPX0pvY=
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a35c9c8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=YHbvUooXmMNqKe3LDhEA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GpMsrYtwySRelK3LTrDwG-fWpTGYUt-P
X-Proofpoint-GUID: GpMsrYtwySRelK3LTrDwG-fWpTGYUt-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQsIHdlIHdpbGwgZHVtcAp0aGUgU1NSIGluIGEgc3Vi
c2VxdWVudCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgMTEgKysrKysrKysrLS0K
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAy
YzUzZjJjMjgzNi4uYmQ1NjhiZGQ4NzEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0xMTAsNiArMTEwLDE0IEBAIHN0YXRpYyB2
b2lkIHByaW50X3JlZyhGSUxFICpmLCBDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSkK
ICAgICAgICAgICAgICAgICAgaGV4YWdvbl9yZWduYW1lc1tyZWdudW1dLCB2YWx1ZSk7CiB9CiAK
KyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgcHJpbnRfdF9zcmVnKEZJTEUg
KmYsIGNvbnN0IENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQgcmVnbnVtKQoreworICAgIHFlbXVf
ZnByaW50ZihmLCAiICAlcyA9IDB4IiBUQVJHRVRfRk1UX2x4ICJcbiIsCisgICAgICAgICAgICAg
ICAgIGhleGFnb25fc3JlZ25hbWVzW3JlZ251bV0sIGVudi0+dF9zcmVnW3JlZ251bV0pOworfQor
I2VuZGlmCisKIHN0YXRpYyB2b2lkIHByaW50X3ZyZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRl
ICplbnYsIGludCByZWdudW0sCiAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgc2tpcF9pZl96
ZXJvKQogewpAQCAtMjA5LDggKzIxNyw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fZHVtcChDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgRklMRSAqZiwgaW50IGZsYWdzKQogICAgIHFlbXVfZnByaW50Zihm
LCAiICBjczAgPSAweDAwMDAwMDAwXG4iKTsKICAgICBxZW11X2ZwcmludGYoZiwgIiAgY3MxID0g
MHgwMDAwMDAwMFxuIik7CiAjZWxzZQotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ0FV
U0UpOwotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQkFEVkEpOworICAgIHByaW50X3Rf
c3JlZyhmLCBlbnYsIEhFWF9TUkVHX0JBRFZBKTsKICAgICBwcmludF9yZWcoZiwgZW52LCBIRVhf
UkVHX0NTMCk7CiAgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVYX1JFR19DUzEpOwogI2VuZGlmCi0t
IAoyLjM0LjEKCg==

