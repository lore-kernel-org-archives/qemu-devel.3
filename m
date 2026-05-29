Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89FACD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5C7-0004UT-3A; Fri, 29 May 2026 17:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C4-0004P0-R5
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C1-0000TP-DA
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2Xlb1863255
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=; b=Z/0TXCsEwZs9IHDJ
 1iw9ktPLWgk/BcTGu0uD+waevtxjv8h81oxrt3D6LJYppGjR/7Mo33vmUfGtww25
 OFRcCSIGcm/knu3xC+qDpqOcj+bQySnU/extrnOrRkpmpXc56+7Y4IYX9+8lkXyk
 +0P5MXWTL1bljrNyOaQm0guVqIOPuIbbWdqjHMvbG5TdeXyFWobs9SVg+fRrnB4m
 oDzP970imZfFr6p3RfGGR9ar7eW6DwL98shUewg/R5Wds4xIXG/A5wyEUPxhx/jf
 hCQ+MOYGWwflWcLpt94I8bJ/l01XIFe7dsuK3Y3is3M0ZemMGRVqLeVrr1fRlfv3
 dZ0TxQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef3te4p81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304dd917645so2000366eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091795; x=1780696595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=;
 b=g+oxI6R9eWQAeZx9Ra7LT5/t1SGrMfG+xJ42//CcvCC110bQSw8EAz/hMK1j8r9Gao
 fLVeP7SoUfyIY9yhwD0kBNeaBwRvrNg4OfraJeLgcoE5W68TJAYVWiJdI/URT1aXrA44
 ETHzGh88eCqOEpfZ2iVn2ufQoGKdDKMbvLRWG6PuSJHzQVy0Yccx/B8SM5XP+EPIN34j
 689SYRQM6fc3LrxYkhFHYE8nkYqJDNy6+iA7CoxTMwcr92JhXwvKqt1i21gptg0ikHlP
 GYuG8+hTwh6NNI+UnYJnbKCVJphOpOsVgZuqzquP2XGhZWHYYp87spfNBCiLITPyQY49
 0LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091795; x=1780696595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dGlGzUayTwiXC/bg5YrAB2T6871CPG9HNKS69hKBulU=;
 b=ikyUIweZpiMbDKj1lt8VUfBsoe26ulQqot7IfgiQ0oXQI0VWjBE5SyXjlJGrNIB+CW
 Ld2ao+70fCCP1zrVdkjGY0kgfdPsx1DQkMo4EE4aQWsNq4wDFWNYub7jocDKpEpEfYNU
 bSjRoZOEy0YG24MErV7cWfJ2sjhY/95GmSncPjE2Xn7j+Tyry7EKswxOpZzWTJDTRDCj
 otdabi6tzKQthiFZ1v9yiOTSV4Mw+ldlNymPqQIe6OWaQkHhW3rgNAFcUilwT1YRaiGl
 IA2CQkunNSTf01whsbIT2FLa7BmOkPU89yKPeufn385FPBvwk3qu93SwVZJNFg+DR7ww
 KttQ==
X-Gm-Message-State: AOJu0Yxw79LX8m8GXQ6drMxhqy1+IupkkkMcH/3YUqbN5BnSbmh5OaGv
 lgA5LrflxgpszU62mSZDF6FzG4LYdo+sXmtzyVa3+bWj3Z4JIwcHtlF4MIB+9nUIgHGZ6yQKMd8
 KUqmuVokYifjEAEutqxxpdoUmKjlnzFIDFmDP+7ugX567vuWUcw7CqeA/TJnEFzBN1A==
X-Gm-Gg: Acq92OFcZg38eta0NCxpi4XMmrRYKA+7Zu0PMaVrTqIxIrUPSn4aSIYe80NM0jLxOkt
 /VzzVMFKaL/gH5ScT9uwZSAUoLaQBVCDyzlHVRh5GDvcNmcX31SlqMVqRe/YAozs+WdyVmdkYc0
 YCX5VegT1pqfkJPNN89TUg0HNLs7Xte9TXFXvbO8xWEQ5JQ0vrqeE1yNwt9dKEzyhbUU4MohHlP
 ys12JJHWXwcD+s3TR/z1ew+I0y+SDFNd2l7uEjkLTGSoEsy46hF09Zdxn7Llq04tHTQB5mYlrI6
 oKymEjNGA3tBb5qa2IyDRlAQ8CNxEdIV7Ce4/JVnMp2lNTm297o+XMN1yihqNHEmnvTLkFs6hB8
 RoNYQF69Qe2hxG0GkcksY4bUQF6WbbRtRPkIrPCDZYXQKiPADeb46viOBGuN1CIytBk/qo5sz2T
 F7JgGU
X-Received: by 2002:a05:7300:e683:b0:304:6139:5a3e with SMTP id
 5a478bee46e88-304fa6c856dmr790839eec.34.1780091795070; 
 Fri, 29 May 2026 14:56:35 -0700 (PDT)
X-Received: by 2002:a05:7300:e683:b0:304:6139:5a3e with SMTP id
 5a478bee46e88-304fa6c856dmr790818eec.34.1780091794565; 
 Fri, 29 May 2026 14:56:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 21/38] target/hexagon: Define register fields for system
 regs
Date: Fri, 29 May 2026 14:55:37 -0700
Message-Id: <20260529215554.606133-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: XkdTnTaVNI9tCySm-9e4OpOXVeyam0mU
X-Proofpoint-GUID: XkdTnTaVNI9tCySm-9e4OpOXVeyam0mU
X-Authority-Analysis: v=2.4 cv=daSwG3Xe c=1 sm=1 tr=0 ts=6a1a0b93 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mmKuwxttERDeH49ycpoA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX49zHQNODVAp3
 OQ1/7yiPVKyiGk/B/ames7z9VyEJVSPTZKF+EHHWwc/c71wbta0BCIV7QFbcTy5WdiOjwNsqyf5
 EAsBLBoIdF4w3Xot0V4x4FXgRIcOtqa88pD4zJCQw1IFaZPtLne5LykU0st+sSvMrlUvvHtgPyt
 Pk7NSfe63HJXUyR4mYKNXSywgNZ5aatGM2HdOoax4Ld7awHIyPBTe6AiEPTzopHqw3M3xzUsFZK
 0dVgLTRvYNaZshwzjGRVauPyEBgEudl9nuLRO0h3NUqK+JKm3JuAU4GmcUFCpnwrGVtxiPSfLi5
 tsktqtgWS6XytxxQFI8Ude32l917BIiVTG7shXilRuSbPV9llweZdXnHB0AyatytffXTnJX4cCC
 RIG/XmG5DoTAWS7Bdk3ExRp8cOn9PTz5ZAzIXu5GyI59Oxqm+1ZLjFRVwXgNMYeNoRSuzw5OT/V
 cvB+8NFn43IkwlcrqMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgdGhlIHJlZ2lzdGVy
IGZpZWxkcyBmb3Igc3NyLCBzY2hlZGNmZywgc3RpZCwgYmVzdHdhaXQsIGNjciwKbW9kZWN0bCwg
aW1hc2ssIGlwZW5kYWQuCgpEZWZpbmUgdGhlIGZpZWxkcyBmb3IgVExCIGVudHJpZXMuCgoKUmV2
aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyB8IDk2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIGIvdGFyZ2V0L2hleGFnb24v
cmVnX2ZpZWxkc19kZWYuaC5pbmMKaW5kZXggZjJhNThkNDg2YzUuLjliMTEyY2NlYzY0IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYworKysgYi90YXJnZXQv
aGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwpAQCAtMzksMyArMzksOTkgQEAgREVGX1JFR19G
SUVMRChVU1JfRlBEQlpFLCAgICAgICAgMjYsIDEpCiBERUZfUkVHX0ZJRUxEKFVTUl9GUE9WRkUs
ICAgICAgICAyNywgMSkKIERFRl9SRUdfRklFTEQoVVNSX0ZQVU5GRSwgICAgICAgIDI4LCAxKQog
REVGX1JFR19GSUVMRChVU1JfRlBJTlBFLCAgICAgICAgMjksIDEpCisKK0RFRl9SRUdfRklFTEQo
SVBFTkRBRF9JQUQsIDE2LCAxNikKK0RFRl9SRUdfRklFTEQoSVBFTkRBRF9JUEVORCwgMCwgMTYp
CisKK0RFRl9SRUdfRklFTEQoU0NIRURDRkdfRU4sIDgsIDEpCitERUZfUkVHX0ZJRUxEKFNDSEVE
Q0ZHX0lOVE5PLCAwLCA0KQorREVGX1JFR19GSUVMRChCRVNUV0FJVF9QUklPLCAwLCA5KQorCisK
Ky8qIFBURSAoYWthIFRMQiBlbnRyeSkgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKFBURV9QUEQs
IDAsIDI0KQorREVGX1JFR19GSUVMRChQVEVfQywgMjQsIDQpCitERUZfUkVHX0ZJRUxEKFBURV9V
LCAyOCwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX1IsIDI5LCAxKQorREVGX1JFR19GSUVMRChQVEVf
VywgMzAsIDEpCitERUZfUkVHX0ZJRUxEKFBURV9YLCAzMSwgMSkKK0RFRl9SRUdfRklFTEQoUFRF
X1ZQTiwgMzIsIDIwKQorREVGX1JFR19GSUVMRChQVEVfQVNJRCwgNTIsIDcpCitERUZfUkVHX0ZJ
RUxEKFBURV9BVFIwLCA1OSwgMSkKK0RFRl9SRUdfRklFTEQoUFRFX0FUUjEsIDYwLCAxKQorREVG
X1JFR19GSUVMRChQVEVfUEEzNSwgNjEsIDEpCitERUZfUkVHX0ZJRUxEKFBURV9HLCA2MiwgMSkK
K0RFRl9SRUdfRklFTEQoUFRFX1YsIDYzLCAxKQorCisvKiBTWVNDRkcgZmllbGRzICovCitERUZf
UkVHX0ZJRUxEKFNZU0NGR19NTVVFTiwgMCwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0lDRU4s
IDEsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19EQ0VOLCAyLCAxKQorREVGX1JFR19GSUVMRChT
WVNDRkdfSVNEQlRSVVNURUQsIDMsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19HSUUsIDQsIDEp
CitERUZfUkVHX0ZJRUxEKFNZU0NGR19JU0RCUkVBRFksIDUsIDEpCitERUZfUkVHX0ZJRUxEKFNZ
U0NGR19QQ1lDTEVFTiwgNiwgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX1YyWCwgNywgMSkKK0RF
Rl9SRUdfRklFTEQoU1lTQ0ZHX0lHTk9SRURBQk9SVCwgOCwgMSkKK0RFRl9SRUdfRklFTEQoU1lT
Q0ZHX1BNLCA5LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfVExCTE9DSywgMTEsIDEpCitERUZf
UkVHX0ZJRUxEKFNZU0NGR19LMExPQ0ssIDEyLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfQlEs
IDEzLCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfUFJJTywgMTQsIDEpCitERUZfUkVHX0ZJRUxE
KFNZU0NGR19ETVQsIDE1LCAxKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJDRkcsIDE2LCAzKQor
REVGX1JFR19GSUVMRChTWVNDRkdfSVRDTSwgMTksIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19M
Mk5XQSwgMjEsIDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMk5SQSwgMjIsIDEpCitERUZfUkVH
X0ZJRUxEKFNZU0NGR19MMldCLCAyMywgMSkKK0RFRl9SRUdfRklFTEQoU1lTQ0ZHX0wyUCwgMjQs
IDEpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19TTFZDVEwwLCAyNSwgMikKK0RFRl9SRUdfRklFTEQo
U1lTQ0ZHX1NMVkNUTDEsIDI3LCAyKQorREVGX1JFR19GSUVMRChTWVNDRkdfTDJQQVJUU0laRSwg
MjksIDIpCitERUZfUkVHX0ZJRUxEKFNZU0NGR19MMkdDQSwgMzEsIDEpCisKKy8qIFNTUiBmaWVs
ZHMgKi8KK0RFRl9SRUdfRklFTEQoU1NSX0NBVVNFLCAwLCA4KQorREVGX1JFR19GSUVMRChTU1Jf
QVNJRCwgOCwgNykKK0RFRl9SRUdfRklFTEQoU1NSX1VNLCAxNiwgMSkKK0RFRl9SRUdfRklFTEQo
U1NSX0VYLCAxNywgMSkKK0RFRl9SRUdfRklFTEQoU1NSX0lFLCAxOCwgMSkKK0RFRl9SRUdfRklF
TEQoU1NSX0dNLCAxOSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX1YwLCAyMCwgMSkKK0RFRl9SRUdf
RklFTEQoU1NSX1YxLCAyMSwgMSkKK0RFRl9SRUdfRklFTEQoU1NSX0JWUywgMjIsIDEpCitERUZf
UkVHX0ZJRUxEKFNTUl9DRSwgMjMsIDEpCitERUZfUkVHX0ZJRUxEKFNTUl9QRSwgMjQsIDEpCitE
RUZfUkVHX0ZJRUxEKFNTUl9CUCwgMjUsIDEpCitERUZfUkVHX0ZJRUxEKFNTUl9YRTIsIDI2LCAx
KQorREVGX1JFR19GSUVMRChTU1JfWEEsIDI3LCAzKQorREVGX1JFR19GSUVMRChTU1JfU1MsIDMw
LCAxKQorREVGX1JFR19GSUVMRChTU1JfWEUsIDMxLCAxKQorCisvKiBtaXNjIHJlZ2lzdGVycyAq
LworREVGX1JFR19GSUVMRChJTUFTS19NQVNLLCAwLCAxNikKKworREVGX1JFR19GSUVMRChTVElE
X1BSSU8sIDE2LCA4KQorREVGX1JFR19GSUVMRChTVElEX1NUSUQsIDAsIDgpCisKKy8qIE1PREVD
VEwgZmllbGRzICovCitERUZfUkVHX0ZJRUxEKE1PREVDVExfRSwgMCwgOCkKK0RFRl9SRUdfRklF
TEQoTU9ERUNUTF9XLCAxNiwgOCkKKworREVGX1JFR19GSUVMRChDQ1JfTDFJQ1AsIDAsIDIpCitE
RUZfUkVHX0ZJRUxEKENDUl9MMURDUCwgMywgMikKK0RFRl9SRUdfRklFTEQoQ0NSX0wyQ1AsIDYs
IDIpCisKK0RFRl9SRUdfRklFTEQoQ0NSX0hGSSwgMTYsIDEpCitERUZfUkVHX0ZJRUxEKENDUl9I
RkQsIDE3LCAxKQorREVGX1JFR19GSUVMRChDQ1JfSEZJTDIsIDE4LCAxKQorREVGX1JFR19GSUVM
RChDQ1JfSEZETDIsIDE5LCAxKQorREVGX1JFR19GSUVMRChDQ1JfU0ZELCAyMCwgMSkKKworREVG
X1JFR19GSUVMRChDQ1JfR0lFLCAyNCwgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX0dURSwgMjUsIDEp
CitERUZfUkVHX0ZJRUxEKENDUl9HRUUsIDI2LCAxKQorREVGX1JFR19GSUVMRChDQ1JfR1JFLCAy
NywgMSkKK0RFRl9SRUdfRklFTEQoQ0NSX1ZWMSwgMjksIDEpCitERUZfUkVHX0ZJRUxEKENDUl9W
VjIsIDMwLCAxKQorREVGX1JFR19GSUVMRChDQ1JfVlYzLCAzMSwgMSkKLS0gCjIuMzQuMQoK

