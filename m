Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77119CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5C9-0004c1-CG; Fri, 29 May 2026 17:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C6-0004Sx-5m
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5C2-0000Tb-LK
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIQYas877127
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VD8bHDqIwxQ/ejdGEqcRWpPLOabnnnaX/QlfiL4OvyI=; b=CNqXV4jFDMdnFll8
 +EKcclSTDv/HhR8uX1RMB1/9QtZpDs80EftBnmR9ab/MIR+H98N2v7wGN1FNx1ER
 +wZ9EUXtzkD5lu3n1Ehiaom8CwxKG8of6KD5WKEC+2mPXy0nNHK0yYX2uyO3Bgi3
 aOAYkuC5W4nzpfPJ8c6yJYzfsiVUhgcs4ekP/L8TNYIw8FbJi35Eoa9qMC6unNO8
 TtfkCqS7sNWi7AkDzh17wQpvamc82yL5BXtKpRa0SwekjzM8XH+d03hMRo5M7cf3
 5cnQ4WS8dRsO4NMk7rgrvFUgad/KBGplxBFu1lSsnDGqQtTMe9BW590qufdUAlwW
 SoTK/w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg340u7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304e3e3fba5so6169681eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091796; x=1780696596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VD8bHDqIwxQ/ejdGEqcRWpPLOabnnnaX/QlfiL4OvyI=;
 b=U5wiO6BepIQNCTfmQ++z48hhmq362eytQR8XDF1dHgG38maX03ll3sETELG3vGJbpk
 ojgaWxWWKZu+4Hx1gmSEPBFXA4oPRlCW0fI8FwGrdopmQB6Y3+WTg/ZEj+Ognr7BQGY6
 ybCmbzMv1tguUk95g80o6glIjWerhpqsExZ1RPlS9O6+zzZ4i5/sP3UXkoAW8cU2Qc+D
 RR1kmYrkJLhVXHg/DF1SstNiE1DJM7VQhxA00Yzs2S/RRUfRCxti0bLsh9uvbomIMvX6
 QqpscPhMYQEuDCq82WqmgeULFPhxV9kP98kmMFeh90sXU8y8qeM1R2xHuCWOrJZJpa5o
 MDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091796; x=1780696596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VD8bHDqIwxQ/ejdGEqcRWpPLOabnnnaX/QlfiL4OvyI=;
 b=mfG5bfaj5rL/49LGbliggnENj5GS272tsYOKr68gIpdRlIwhDGRyNvdkcLnBEtgHcm
 tCMP9buRhYyiLBkPePxUH8CiL0jP8QFQ1DA5oLRM6zZu23/6P1k6kQWFymzya+xoSwp2
 fNLWcZ9qi6s7QyNA+LPkKbVGL/g0Mo2p/3Cvgu+tVWmbUhauvNTwnF7vhr+/4qub4wyz
 GmdNEvrA5T3JfLJQsewSkqIs6V3mRzocDcMNl7wCEcZhzhchUa9UMwtDWHhNhkbZwy1B
 zYDOsjB0BZwTFZMsn1Zaaq0U4HU152Ix39FuJzyI2T+gPiOKBhk9FchszT77f1/JWXcN
 bkXA==
X-Gm-Message-State: AOJu0YwMZt446AhxV17MktQyEEf3lWDxPxdtTL7NlLSNP83pA5aQnL2a
 yNwM6p+esj99ypDuhORH1VufI7lco2kHc3EwRPEoVUOEnLMR4somLsIhdRGuToBSZtDrnVIhSOT
 SXWy0DwJ4tGv6uL9eZXn7X6TzQAvdOobjlN2BLxJHYAWi49WFZ7J0ywvC7ck/PRkm4A==
X-Gm-Gg: Acq92OH1sRndLqX0oymiOgRh0ORf/g1/fPzn18Q/gd1KxePFXIwNYyTCm501DpuqBxi
 QzwXTXyyEOgU7ntjOUpWQpC9tqr/r+ylIQknhs6zhlCqQdbhRXz70wPuU60Lr18iKPEXYipVemn
 Zh21k3nrv5fjaKgzULeCCFIDcTqgw/0QdSIAMvpJxltujEPrVCtnXxVbK2cD6Yx+MznfweFAGf/
 y89M25ZKb+f5wnWr9viGIHSyqyNTLc3sukUpGP3Ye1ME/oDiJ0pR+32ivq/n+X43o6eYEP1TpHc
 +PLzM59WAaAAM02JSwyG9T0hjWPBK73VlQSQCnihMmyatTVlloMCkLGxAc48h2dixtkGjgwESkZ
 sUGof2zQ7XD2KGuOIlNrJSpMbUmY+akxkJ9zzFdOFjnaFps58lIx5qDpn9CvQJsMF5wKuL9vEdQ
 djI/6L
X-Received: by 2002:a05:7300:a44c:b0:2ef:8b91:212 with SMTP id
 5a478bee46e88-304fa589a60mr895433eec.14.1780091796295; 
 Fri, 29 May 2026 14:56:36 -0700 (PDT)
X-Received: by 2002:a05:7300:a44c:b0:2ef:8b91:212 with SMTP id
 5a478bee46e88-304fa589a60mr895420eec.14.1780091795796; 
 Fri, 29 May 2026 14:56:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 22/38] target/hexagon: Implement do_raise_exception()
Date: Fri, 29 May 2026 14:55:38 -0700
Message-Id: <20260529215554.606133-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: ii2BfmVH_kVQWKNwniav2uBgRzM0bima
X-Authority-Analysis: v=2.4 cv=EOI2FVZC c=1 sm=1 tr=0 ts=6a1a0b95 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hK29HtBGQMdOITfcgGsA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ii2BfmVH_kVQWKNwniav2uBgRzM0bima
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX1ahqLVd6Cfm1
 X3qtckbj0bCOfiIN0mwKqopSsgpe0Q5Ev+aX9J2iNkbkbFip6vqORzNLMYPyaNy0SwvbEE6la71
 mF+AmWvPidW+9ityoraGXiIO8OapXiwc3oSd1uI/BJr8+LOsNJPO/SpUtLRBGnSSd2ZXxc05bL9
 WDKZecZcKWtqTHtKVEDcNSFyLuhXq62CrtoIoCNU0yZDGggbuEaV7fem7j7Ts25nKu4tEmn+hsz
 t49Rub/EOFN6B2YzGzhF56sZ5TQjXe4F5Pz8U7JwKquXmuHowWoo/KiYBJtnn6L4RNc1bOKf2SG
 On9DZJzxXhASHuK7cKpOLSRBobK13rx2anSP6RR4LPmH9kx/JBvGJ3YdiHyraV3ut8kR1D8T79T
 iVznE66xn1eBkTPRKs+DntKE8+irDs6EOEgdGQ9kYlBcR34vuvukPsMKYRa/nYBgt6cBxkFRIBJ
 6VF00kXG/D/pgSGCOsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTQgKysr
KysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CmluZGV4IGNkMDZmZjQxZDRmLi4zM2Q3M2VkMThkMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw2ICsz
MSwxMSBAQCB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiBleHRl
cm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RIUkVBRF9S
RUdTXTsKIAordm9pZCBHX05PUkVUVVJOIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwKKyAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLAorICAgICAgICB1aW50MzJfdCBQ
QywKKyAgICAgICAgdWludHB0cl90IHJldGFkZHIpOworCiAjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKIGV4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdTsK
ICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCAzNTliZjEyZjFmMi4uMzI3YzIzM2MwMWIgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC00MCw2ICs0MCwyMCBAQAogI2RlZmluZSBTRl9NQU5UQklUUyAgICAyMwog
CiAvKiBFeGNlcHRpb25zIHByb2Nlc3NpbmcgaGVscGVycyAqLworR19OT1JFVFVSTgordm9pZCBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGV4Y2VwdGlv
biwKKyAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFBDLCB1aW50cHRyX3QgcmV0YWRk
cikKK3sKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX0lOVCwgIiVzOiAweCUwOCIgUFJJeDMyICIsIEAgJTA4IiBQUkl4MzIgIlxuIiwK
KyAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBleGNlcHRpb24sIFBDKTsKKyAgICBBU1NFUlRf
RElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgZXhjZXB0aW9uKTsKKworICAgIGVudi0+Z3ByW0hF
WF9SRUdfUENdID0gUEM7CisgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2VwdGlvbjsKKyAg
ICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHJldGFkZHIpOworfQorCiBHX05PUkVUVVJOIHZv
aWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRp
b24sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJf
dCBwYykKLS0gCjIuMzQuMQoK

