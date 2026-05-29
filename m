Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D263CD6E54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5ER-000692-6z; Fri, 29 May 2026 17:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EJ-0005yV-KJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EH-0000yN-02
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:59 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TJZpFB4123908
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dhVswS2DZAUJvhZS1jkUEyRUjq/jx8V7zSSA5+TNpPQ=; b=HzUZTN3XY5hjXv2r
 yVKzHNFVXNJ90G1ec/zu6PXT2cRKMlBuJiDx9jJqowRL3RUvUXK49YcvCqRQNnTQ
 UGzpPEeRgxCspJm4zktq0Or9lShTUKhhNdWXBLzrEK309EnCtlbEcDDvQ7xciixf
 7G9xZzMeG5Sr9/TWssN9THTh0g1F+8y6R2v6EeBzqrV7IsTtGzgNFxBqQzEPelRr
 oGXalMbudF/0unYAN1zO2kxMie+BSM2I4DdkjqRhmgFjBGsyBNK3NGNSWM8dJ/Tj
 dNlt0l50v9zGF5Bz82mDhb3sSWhaZSTphWi6tPn95WGFhjE6pQm6pQ2PxHGGRbLm
 LopeDw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efh3n8g47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so5136832eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091925; x=1780696725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhVswS2DZAUJvhZS1jkUEyRUjq/jx8V7zSSA5+TNpPQ=;
 b=cgnKJ8rneW7ffsPzL4t5PhDnvBSNCLriYlpSFHKPzQq0Cg5J8pwZ1m00W+fQ+fV/rW
 hasRJHW+yZ4bSG8do08DQnFk9gbgm+c35r6U8qu+wY1Y43DfajHihayBR41F4IGI2fg6
 XaG8U50iZjreufZS5sLrdIj7/QzwcyMnwtmJ07VxTZ7UxI3hJ5mHnSUOrzcxH160i/BF
 CWmO/NE4YIHmo4YalSqFE2tbh7LZ1td2sQ59qTD9fBkMXA494NAtQIITJqTc/3ZRexJz
 n/SDM0a5JiW31XeOLJoKs0lYhUBslOgcvciVR9hL6Uf58E6dQxItQ7shrQ9MQTMwXCqn
 /i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091925; x=1780696725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dhVswS2DZAUJvhZS1jkUEyRUjq/jx8V7zSSA5+TNpPQ=;
 b=UKIAdIRLrA7BuGejQ6r3urCdHvpJ7Vq9EcXrmGAb3T8ACeVp+Tyj/2TPwpVdHAtx91
 iFxDp/BSa86Tk/IICPsl7K5zQ25OPQhrF2d4Lbq3ArMazYcxW0vkkQx78o8fls6k8t34
 J+s7Lj/sUSyMTBr/hkXZg19dabHe4LPWnrHw+c6npxC/XiLjP6ZQ2C5qJtBDBqcu0K9R
 RSKCwI5/suVPn3jGm5q7isLXM07NZV0vEMqMDz/2Z/M//L+ibGrn/jVRya6TxjmMjI27
 qqG0KuYXuCLb2qSTt0o7OmtVFSaJoiUdBEtwPlMpz6XnrD+7jc903B/8qvC77ocHea4s
 NPNQ==
X-Gm-Message-State: AOJu0YxbbFojARYAI/EDhcJw4u3uun7PhP2NMH1/90vPg6vX57RkC2kJ
 oqiGA+zEq2QJHBmUxNmlLgtbAOddNxNv1h9d3sI2KbSLl6OSVlFtZGnVKh8bFEFZjYu6b/s1chY
 p8y0nZkvGtM6uF5KqOtX07S1fRnr1WHMVlrOotc/vL5yS3w7h6udX22SSFYwomdmi/Q==
X-Gm-Gg: Acq92OHWWBlwxt1ABEncoDObZHmj5u7MHNtG5KxnDZXFKn2tOwyElN6bvCL3oVjtFln
 Dtelq84k4w6DKf9HFAmrV3cz3uIJbISbeYq9C6D2YWO/MimVRmQ/fAFdQP+DIQIiSGGEX0JSWjs
 V+eyVDYXO1vbGNB0ffxNDeQVoFXNPHLAusRiXqOVAJcNGg6k68rrItbVWkdSMp6SKLfA+jTru4I
 b5zCILp3XDWaAkjIj2WyBYJQuwFhrG+qx8Vg4QBJyk9FodF47g/yeGJWKZxFih8AvC+wJLNLPW7
 E8gy6py/fQc8KybrdYqjbC9bbpx1yE9pivGYmDqL1wbtWcJTiUv0nYCJ/B//4UmqwpYnff/pU24
 p+OGpI+X9Ktlc59aeK8y06My7dhFPZBvOkWY90QLv98Vcd1Poz+c+Wrh8px5wA1MvhQu45MU8DR
 nETly3
X-Received: by 2002:a05:7300:a44c:b0:2da:a813:a5fd with SMTP id
 5a478bee46e88-304fa5a7ac4mr826003eec.22.1780091924830; 
 Fri, 29 May 2026 14:58:44 -0700 (PDT)
X-Received: by 2002:a05:7300:a44c:b0:2da:a813:a5fd with SMTP id
 5a478bee46e88-304fa5a7ac4mr825978eec.22.1780091924029; 
 Fri, 29 May 2026 14:58:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 25/28] target/hexagon: Add PC to raise_exception,
 use fTRAP() helper
Date: Fri, 29 May 2026 14:58:03 -0700
Message-Id: <20260529215806.608770-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RcCgzVtv c=1 sm=1 tr=0 ts=6a1a0c15 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4FQt9sIIQT5CW9ciUtIA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX2yK51q94+nXK
 DhkAKTkQdOsPblbsCzlwApd0rB03myXvbQrELQykKqcoIxhViyqLDe0rS7OY1GAEdgCau7tedZP
 WBLg62XkbevrLoozmzSzLTpTWp127jLhxuCPSEZaVP8rj9gBTY5IUq3zcGV+iGVJfZntD1NPhoo
 7EDwgMwi9l0lCVQvlqscyqMfKY5udDHExZVyi4xNDJ7W8JspuC+lGRuer7jb+AQOC+2hnrxQK42
 btBL8g3xsCmNIVMg85vTXhukcCBCffzazfnOUcp0+H5gS1LYiDuOc5tuYCncA0Mq1z7SV6RuU9v
 BF28DOySxVbsWlGOzoUIwuLBv4pDsmAT7S9bJULOBX8cPFx0tkf3J1ofYLKL0TW+KUn6ZeO0egI
 cLA1QRjXfscSxWGWCxEw00u69E59vnxVvHTdISYUxFGTlaH+Oq7Aq2WvBjeD9O0cjlxKMwTG5q0
 f2a9G8mL8THU9BEZNbg==
X-Proofpoint-ORIG-GUID: Edv6yTCRmA354CGCHsOQ5pq9XO1JOnk5
X-Proofpoint-GUID: Edv6yTCRmA354CGCHsOQ5pq9XO1JOnk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290219
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgUEMgdG8gcmFpc2VfZXhj
ZXB0aW9uIGhlbHBlcgoKUmVwbGFjZSB0aGUgZkdFTl9UQ0dfSjJfdHJhcDAgbWFjcm8gb3ZlcnJp
ZGUgd2l0aCB0aGUgZlRSQVAoKS1nZW5lcmF0ZWQKc3lzdGVtIGhlbHBlciBpbnN0ZWFkLgoKUmV2
aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggICB8ICA3IC0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTAgKysrKy0t
LS0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAyMSArKysrKysrKysrKysrKysrLS0t
LS0KIDQgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZy5oCmluZGV4IDRhNThlYWQ4NzdiLi5hMjhhZjBjMjQ1YiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaApAQCAtMTM0
OSwxMyArMTM0OSw2IEBACiAjZGVmaW5lIGZHRU5fVENHX1MyX3N0b3Jld19ybF9zdF92aShTSE9S
VENPREUpICAgICAgICAgIFNIT1JUQ09ERQogI2RlZmluZSBmR0VOX1RDR19TNF9zdG9yZWRfcmxf
c3RfdmkoU0hPUlRDT0RFKSAgICAgICAgICBTSE9SVENPREUKIAotI2RlZmluZSBmR0VOX1RDR19K
Ml90cmFwMChTSE9SVENPREUpIFwKLSAgICBkbyB7IFwKLSAgICAgICAgdWlWID0gdWlWOyBcCi0g
ICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPnBrdC5wYyk7
IFwKLSAgICAgICAgVENHdiBleGNwID0gdGNnX2NvbnN0YW50X3RsKEhFWF9FVkVOVF9UUkFQMCk7
IFwKLSAgICAgICAgZ2VuX2hlbHBlcl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgZXhjcCk7IFwK
LSAgICB9IHdoaWxlICgwKQogI2VuZGlmCiAKICNkZWZpbmUgZkdFTl9UQ0dfQTJfbm9wKFNIT1JU
Q09ERSkgZG8geyB9IHdoaWxlICgwKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVy
LmggYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCAxN2U3NGIxMmYzYy4uYTg5NzU4YjVk
ZjUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhh
Z29uL2hlbHBlci5oCkBAIC0xOCw3ICsxOCw3IEBACiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKICNp
bmNsdWRlICJoZWxwZXJfcHJvdG9zX2dlbmVyYXRlZC5oLmluYyIKIAotREVGX0hFTFBFUl9GTEFH
U18yKHJhaXNlX2V4Y2VwdGlvbiwgVENHX0NBTExfTk9fUkVUVVJOLCBub3JldHVybiwgZW52LCBp
MzIpCitERUZfSEVMUEVSX0ZMQUdTXzMocmFpc2VfZXhjZXB0aW9uLCBUQ0dfQ0FMTF9OT19SRVRV
Uk4sIG5vcmV0dXJuLCBlbnYsIGkzMiwgaTMyKQogREVGX0hFTFBFUl8yKGNvbW1pdF9zdG9yZSwg
dm9pZCwgZW52LCBpbnQpCiBERUZfSEVMUEVSXzMoZ2F0aGVyX3N0b3JlLCB2b2lkLCBlbnYsIGkz
MiwgaW50KQogREVGX0hFTFBFUl8xKGNvbW1pdF9odnhfc3RvcmVzLCB2b2lkLCBlbnYpCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jCmluZGV4IDI5ODhlNTNkNDU4Li40ZWI5ZjgwOTJiNyAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAg
LTY1LDE1ICs2NSwxMyBAQCBHX05PUkVUVVJOIHZvaWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25f
ZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRpb24sCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJfdCBwYykKIHsKLSAgICBDUFVTdGF0ZSAqY3Mg
PSBlbnZfY3B1KGVudik7Ci0gICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiAlZFxu
IiwgX19mdW5jX18sIGV4Y2VwdGlvbik7Ci0gICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2Vw
dGlvbjsKLSAgICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHBjKTsKKyAgICBkb19yYWlzZV9l
eGNlcHRpb24oZW52LCBleGNlcHRpb24sIHBjLCAwKTsKIH0KIAotR19OT1JFVFVSTiB2b2lkIEhF
TFBFUihyYWlzZV9leGNlcHRpb24pKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBleGNw
KQorR19OT1JFVFVSTiB2b2lkIEhFTFBFUihyYWlzZV9leGNlcHRpb24pKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBleGNwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IFBDKQogewotICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2Vycihl
bnYsIGV4Y3AsIDApOworICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihlbnYsIGV4Y3As
IFBDKTsKIH0KIAogdm9pZCBsb2dfc3RvcmUzMihDUFVIZXhhZ29uU3RhdGUgKmVudiwgdGFyZ2V0
X3Vsb25nIGFkZHIsCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGRiYzc2NDE5MjE1Li5jMzc3NzBiZDkyZSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMKQEAgLTEyNiwxMiArMTI2LDE5IEBAIGludHB0cl90IGN0eF90bXBfdnJl
Z19vZmYoRGlzYXNDb250ZXh0ICpjdHgsIGludCByZWdudW0sCiAgICAgcmV0dXJuIG9mZnNldDsK
IH0KIAotc3RhdGljIHZvaWQgZ2VuX2V4Y2VwdGlvbl9yYXcoaW50IGV4Y3ApCitzdGF0aWMgdm9p
ZCBnZW5fZXhjZXB0aW9uKGludCBleGNwLCB1aW50MzJfdCBQQykKIHsKLSAgICBnZW5faGVscGVy
X3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3ApKTsKKyAgICBn
ZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKGV4Y3Ap
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF9pMzIoUEMpKTsK
IH0KIAogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3By
ZWNpc2VfZXhjZXB0aW9uKGludCBleGNwLCB1aW50MzJfdCBQQykKK3sKKyAgICB0Y2dfZ2VuX21v
dmlfaTMyKGhleF9jYXVzZV9jb2RlLCBleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKEhFWF9FVkVO
VF9QUkVDSVNFLCBQQyk7Cit9CisKIHN0YXRpYyB2b2lkIGdlbl9wY3ljbGVfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiB7CiAgICAgaWYgKGN0eC0+cGN5Y2xlX2VuYWJsZWQpIHsKQEAgLTE0
MCw2ICsxNDcsNyBAQCBzdGF0aWMgdm9pZCBnZW5fcGN5Y2xlX2NvdW50ZXJzKERpc2FzQ29udGV4
dCAqY3R4KQogfQogI2VuZGlmCiAKKwogc3RhdGljIHZvaWQgZ2VuX2V4ZWNfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiB7CiAgICAgdGNnX2dlbl9hZGRpX3RsKGhleF9ncHJbSEVYX1JFR19R
RU1VX1BLVF9DTlRdLApAQCAtMjExLDggKzIxOSwxMSBAQCBzdGF0aWMgdm9pZCBnZW5fZW5kX3Ri
KERpc2FzQ29udGV4dCAqY3R4KQogdm9pZCBoZXhfZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoRGlzYXND
b250ZXh0ICpjdHgsIGludCBleGNwKQogewogICAgIGdlbl9leGVjX2NvdW50ZXJzKGN0eCk7Ci0g
ICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9ncHJbSEVYX1JFR19QQ10sIGN0eC0+bmV4dF9QQyk7Ci0g
ICAgZ2VuX2V4Y2VwdGlvbl9yYXcoZXhjcCk7CisjaWZkZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IGdlbl9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QucGMpOworI2Vsc2UKKyAgICBnZW5fcHJlY2lz
ZV9leGNlcHRpb24oZXhjcCwgY3R4LT5wa3QucGMpOworI2VuZGlmCiAgICAgY3R4LT5iYXNlLmlz
X2ptcCA9IERJU0FTX05PUkVUVVJOOwogfQogCkBAIC0yMjYsNyArMjM3LDcgQEAgc3RhdGljIHZv
aWQgZ2VuX2V4Y2VwdGlvbl9kZWNvZGVfZmFpbChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG53b3Jk
cywgaW50IGV4Y3ApCiAKICAgICBnZW5fZXhlY19jb3VudGVycyhjdHgpOwogICAgIHRjZ19nZW5f
bW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBmYWlsX3BjKTsKLSAgICBnZW5fZXhjZXB0aW9u
X3JhdyhleGNwKTsKKyAgICBnZW5fZXhjZXB0aW9uKGV4Y3AsIGZhaWxfcGMpOwogICAgIGN0eC0+
YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsKICAgICBjdHgtPmJhc2UucGNfbmV4dCA9IGZh
aWxfcGM7CiB9Ci0tIAoyLjM0LjEKCg==

