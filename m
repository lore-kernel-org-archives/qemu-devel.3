Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D69DCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9F-0003O0-2F; Mon, 22 Jun 2026 18:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9C-0003NV-Sl
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9B-0006PH-B0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:42 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJb6p11902667
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=; b=SSdh2d8/hRRC27KV
 j20IXu7pXBcNl1+2xWv2Q7W9+5fphmsFC7dfeorbtSSesu9jAGF/CRX1qQ4S3yf/
 6OoCvNEX5RJr/eAnaSXyxRjUlX/7/+fi/5I+etHKY11kesXNDoGysqE4rwGDXHlU
 AAa3Vr4K/J3noB8mKWTNnS+BAS+NITFaQ74QUdlELBoDVz2X3+qK+kO90izTxr8/
 yjTbJVrcKw94lHIGt62PBe/Z/q6SJMgum3f7X7+LIQPXdBim2ljpxCEjihZUEfD+
 Ct/FjwqIJQ1FGZh2GqpzoUyRtug3V5Lzbr1W3/bgXWWwdsDQbAsgL/SW4NBM0hvY
 Ei/W6A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1ukab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c42d96713so952035eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167369; x=1782772169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=;
 b=CBsQiXxKVPwQb8W8YiWSa/9FLswQVniYt7lN5S7fYZYrdyHTtnhzo5C6ATnXTLsRsD
 lNVqP57d4LU+VadBJ+VtijCSVWzSH82iwXvcyRMo4Xgk4SqvAKnRgV/rStC6CjvewBpc
 AV6SID9Yu+cy7tDe3M86+hG+kWnQHi/okulz5fIUHJOmch7zXtZGguebhdrOak7bQmdY
 DxX3YQWcTdG92jtVYpXWqAsRSyqR4xC0LE8D5UbPj/2zSHF0fjf+yBrZTuWVlf0YVhH/
 iHH2I3/5BY+OOpcg/WhgT+F9Twe4kTRPExKj50y6M/KoOFek9xVJlRnEqx6Pppzsr0wW
 Mmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167369; x=1782772169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=;
 b=S7rZkDofwnOO6gV1JDguYkSqg6iFz7KIDIvIMYKpvmpO4KUVpvctHeG7PUxyH1TV/S
 U7/+kZr7wCu7BfhhJ8tbuN/jPRCaax6fg+IN1bmCpkF0TKjtKBHRE3Bjj2WI4D2NYmuw
 JMMky60wVAlqfWuePq5LeckXVf3Ajlj6ZJdQb1/8Ub0gzZPEqWn/fku8ga6DqMbe24e7
 tWHyLc5PaUnnySNHOrY7IbYZPcVN8CWrgAyFlj2ThM+uS/Dw+iWuKA2K7yHV6vSN2Ued
 xEpkvnTSpDLy/U//bzsWRZrpPuy85X5krRp6V/lHV7WeV6WLGKJEA/EyNdYCbAHUlvCc
 n8dQ==
X-Gm-Message-State: AOJu0YxboqJNPzJKZepx5nKJoAf1wGL1GqRKu48zGBCEhmDScoLQNi/t
 DZjbj90IorT/oDanoosijMr3bOXCyQLxP6bkjlBc5X1WYfYuNGbe8y/TQQBPwbdNqhh1afHK/wN
 huht/zumKZLIQx02Zvpq72hGLYqC2AHlZHCzoZz1HYqtfEAPJ3Vw5HF3NhQaP0ldXSQ==
X-Gm-Gg: AfdE7ckCjs8GABJvTCMoySCwHYK5+zl1hobyLvmrf/baB6iVL+8f2MHeRirZsoPnN1D
 ttBAS6cXd0er+dbLBwhGGUX3tXu1NqGZwznMXG5Fk+hg0tysmIVLRp3rqwFeJYjd/+EtBrnspr8
 9V8qVOcWQOnWGMvdvsm1RiAjo1mv843N5Pe99uI6ci6gf9PQINYvXk8wATptKWKXB0MTzSsUgAH
 jClOLbGuR6Toz5pt4/J9ftFX75tfPLbVBxix1up2vu0tTeXPghrqoZXHAehd8epCrTU+5f1wXxE
 1KKKNbToPZcMzV4AKcr/TV11GDYXSCey6lly+X+d8nDu0qzi8xWK1JtLC3jm8Baw9aFUYL6UU88
 9Anrl3h3kasAr5Us5BExuMVAPpCvAjCqNDmwDy7TWKZNifhUp4rICe9iUwAM=
X-Received: by 2002:a05:7300:2210:b0:304:6448:dfd7 with SMTP id
 5a478bee46e88-30c06e0c664mr11174624eec.18.1782167369189; 
 Mon, 22 Jun 2026 15:29:29 -0700 (PDT)
X-Received: by 2002:a05:7300:2210:b0:304:6448:dfd7 with SMTP id
 5a478bee46e88-30c06e0c664mr11174605eec.18.1782167368687; 
 Mon, 22 Jun 2026 15:29:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 11/75] target/hexagon: Add guest, system reg number defs
Date: Mon, 22 Jun 2026 15:28:00 -0700
Message-Id: <20260622222904.607771-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: C0KxqgC1Mtoor0Do8NDD1iWxg2JgsXM0
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a39b74a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tCkOjFGBvLAhDY2OQcYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX4ia2w9M/o+mN
 q7UYrpIaPP9Eef6HxjYf65NqgnEhg8Dof54jpz4PHdfrS6SbG4eBfnnw5Nn4ejFnw0npTMjnrMo
 6VJHkUTDJJ6MkPgdyE9AjOyRgLuEf2E=
X-Proofpoint-ORIG-GUID: C0KxqgC1Mtoor0Do8NDD1iWxg2JgsXM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXwjpNI6APande
 0Djw8RfL/13ShqDo4PBJheJO56qm5BTaTwDi/DbJlzpshUO8sKdaImAeCcvNFo7kr9SLLjsUsWB
 f0MWoYUFqsIzyyiGnmcAk2Z7aFVHj8/ppxT/gmasnwtl182pL3LKX/3u7RSSaXXa3mZZcSmgW81
 KUGZXR9OxnP4V2o0XMUqwtOcKAYJNBD2ktviF5PVXMw1d6XzPf0sgngYyJqfD4g34l4bXjRhBeb
 +ztVSsd6jY0x1ygfewpR2JCJHgtssT6IOUSz+k8qZiFjjqGTRx7Lq/yT/oX70c75LCvN+f+0+z3
 iI13VbFFA1RotHzUmefbiPT7fCdmmx8SXSxan6fxCjCIIY1ch6Mrp+uCEdYyIU/paOKuc/3ZZl2
 4AT9KKh6G7RR4Lj2n2BdaO2So1UFr6Lo6WQGukzJ5F+aeICvhJmB3hgxWLjyZRh1VFqF+X8YPiW
 D4qSurkLNGw9pcTcmkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgfCAgIDcgKysrCiB0YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oIHwgMTE3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyNCBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQv
aGV4YWdvbi9jcHUuaAppbmRleCBlMjI1NjdkOGU2Ny4uZTBjZjg3ZTVhNGMgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMCw2
ICsyMCwxMyBAQAogCiAjaW5jbHVkZSAiZnB1L3NvZnRmbG9hdC10eXBlcy5oIgogCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKyNkZWZpbmUgTlVNX0dSRUdTIDMyCisjZGVmaW5lIEdSRUdfV1JJ
VEVTX01BWCAyCisjZGVmaW5lIE5VTV9TUkVHUyA2NAorI2RlZmluZSBTUkVHX1dSSVRFU19NQVgg
MgorI2VuZGlmCisKICNpbmNsdWRlICJjcHUtcW9tLmgiCiAjaW5jbHVkZSAiZXhlYy9jcHUtY29t
bW9uLmgiCiAjaW5jbHVkZSAiZXhlYy90YXJnZXRfbG9uZy5oIgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vaGV4X3JlZ3MuaCBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKaW5kZXggYmRk
ZmMyODAyMWMuLjIxNGI3YjhmZGU4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfcmVn
cy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKQEAgLTgxLDQgKzgxLDEyMSBAQCBl
bnVtIHsKICAgICBIRVhfUkVHX1VUSU1FUkhJICAgICAgICAgID0gNjMsCiB9OwogCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKworI2RlZmluZSBIRVhfR1JFR19WQUxVRVMgXAorICBERUNMX0hF
WF9HUkVHKEcwLCAgICAgICAgIDApIFwKKyAgREVDTF9IRVhfR1JFRyhHRUxSLCAgICAgICAwKSBc
CisgIERFQ0xfSEVYX0dSRUcoRzEsICAgICAgICAgMSkgXAorICBERUNMX0hFWF9HUkVHKEdTUiwg
ICAgICAgIDEpIFwKKyAgREVDTF9IRVhfR1JFRyhHMiwgICAgICAgICAyKSBcCisgIERFQ0xfSEVY
X0dSRUcoR09TUCwgICAgICAgMikgXAorICBERUNMX0hFWF9HUkVHKEczLCAgICAgICAgIDMpIFwK
KyAgREVDTF9IRVhfR1JFRyhHQkFEVkEsICAgICAzKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xF
XzFULCAgMTApIFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfMlQsICAxMSkgXAorICBERUNMX0hF
WF9HUkVHKEdDWUNMRV8zVCwgIDEyKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzRULCAgMTMp
IFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfNVQsICAxNCkgXAorICBERUNMX0hFWF9HUkVHKEdD
WUNMRV82VCwgIDE1KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDQsICAgMTYpIFwKKyAgREVD
TF9IRVhfR1JFRyhHUE1VQ05UNSwgICAxNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ2LCAg
IDE4KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDcsICAgMTkpIFwKKyAgREVDTF9IRVhfR1JF
RyhHUENZQ0xFTE8sICAyNCkgXAorICBERUNMX0hFWF9HUkVHKEdQQ1lDTEVISSwgIDI1KSBcCisg
IERFQ0xfSEVYX0dSRUcoR1BNVUNOVDAsICAgMjYpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05U
MSwgICAyNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQyLCAgIDI4KSBcCisgIERFQ0xfSEVY
X0dSRUcoR1BNVUNOVDMsICAgMjkpIFwKKyAgREVDTF9IRVhfR1JFR19ET05FCisKKyNkZWZpbmUg
REVDTF9IRVhfR1JFR19ET05FCisjZGVmaW5lIERFQ0xfSEVYX0dSRUcobmFtZSwgdmFsKSBIRVhf
R1JFR18gIyNuYW1lID0gdmFsLAorZW51bSBoZXhfZ3JlZyB7CisgICAgSEVYX0dSRUdfVkFMVUVT
Cit9OworI3VuZGVmIERFQ0xfSEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKwor
I2RlZmluZSBERUNMX0hFWF9HUkVHX0RPTkUgMAorI2RlZmluZSBERUNMX0hFWF9HUkVHKF8sIHZh
bCkgKDEgPDwgdmFsKSB8CitzdGF0aWMgaW5saW5lIGJvb2wgZ3JlZ19pbXBsZW1lbnRlZChlbnVt
IGhleF9ncmVnIGdyZWcpCit7CisjaWYgTlVNX0dSRUdTID4gMzIKKyNlcnJvciAiTlVNX0dSRUdT
IHRvbyBsYXJnZSBmb3IgZ3JlZ19pbXBsZW1lbnRlZCgpOiB1cGRhdGUgYGltcGxfYml0bWFwYCIK
KyNlbmRpZgorICAgIHN0YXRpYyBpbnQzMl90IGltcGxfYml0bWFwID0gSEVYX0dSRUdfVkFMVUVT
OworICAgIHJldHVybiBpbXBsX2JpdG1hcCAmICgxIDw8IGdyZWcpOworfQorI3VuZGVmIERFQ0xf
SEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKworI2VuZGlmIC8qIENPTkZJR19V
U0VSX09OTFkgKi8KKworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitlbnVtIHsKKyAgICBIRVhf
U1JFR19TR1AwID0gMCwKKyAgICBIRVhfU1JFR19TR1AxID0gMSwKKyAgICBIRVhfU1JFR19TVElE
ID0gMiwKKyAgICBIRVhfU1JFR19FTFIgPSAzLAorICAgIEhFWF9TUkVHX0JBRFZBMCA9IDQsCisg
ICAgSEVYX1NSRUdfQkFEVkExID0gNSwKKyAgICBIRVhfU1JFR19TU1IgPSA2LAorICAgIEhFWF9T
UkVHX0NDUiA9IDcsCisgICAgSEVYX1NSRUdfSFRJRCA9IDgsCisgICAgSEVYX1NSRUdfQkFEVkEg
PSA5LAorICAgIEhFWF9TUkVHX0lNQVNLID0gMTAsCisgICAgSEVYX1NSRUdfR0VWQiAgPSAxMSwK
KyAgICBIRVhfU1JFR19HTEJfU1RBUlQgPSAxNiwKKyAgICBIRVhfU1JFR19FVkIgPSAxNiwKKyAg
ICBIRVhfU1JFR19NT0RFQ1RMID0gMTcsCisgICAgSEVYX1NSRUdfU1lTQ0ZHID0gMTgsCisgICAg
SEVYX1NSRUdfSVBFTkRBRCA9IDIwLAorICAgIEhFWF9TUkVHX1ZJRCA9IDIxLAorICAgIEhFWF9T
UkVHX1ZJRDEgPSAyMiwKKyAgICBIRVhfU1JFR19CRVNUV0FJVCA9IDIzLAorICAgIEhFWF9TUkVH
X0lFTCA9IDI0LAorICAgIEhFWF9TUkVHX1NDSEVEQ0ZHID0gMjUsCisgICAgSEVYX1NSRUdfSUFI
TCA9IDI2LAorICAgIEhFWF9TUkVHX0NGR0JBU0UgPSAyNywKKyAgICBIRVhfU1JFR19ESUFHID0g
MjgsCisgICAgSEVYX1NSRUdfUkVWID0gMjksCisgICAgSEVYX1NSRUdfUENZQ0xFTE8gPSAzMCwK
KyAgICBIRVhfU1JFR19QQ1lDTEVISSA9IDMxLAorICAgIEhFWF9TUkVHX0lTREJTVCA9IDMyLAor
ICAgIEhFWF9TUkVHX0lTREJDRkcwID0gMzMsCisgICAgSEVYX1NSRUdfSVNEQkNGRzEgPSAzNCwK
KyAgICBIRVhfU1JFR19MSVZFTE9DSyA9IDM1LAorICAgIEhFWF9TUkVHX0JSS1BUUEMwID0gMzYs
CisgICAgSEVYX1NSRUdfQlJLUFRDRkcwID0gMzcsCisgICAgSEVYX1NSRUdfQlJLUFRQQzEgPSAz
OCwKKyAgICBIRVhfU1JFR19CUktQVENGRzEgPSAzOSwKKyAgICBIRVhfU1JFR19JU0RCTUJYSU4g
PSA0MCwKKyAgICBIRVhfU1JFR19JU0RCTUJYT1VUID0gNDEsCisgICAgSEVYX1NSRUdfSVNEQkVO
ID0gNDIsCisgICAgSEVYX1NSRUdfSVNEQkdQUiA9IDQzLAorICAgIEhFWF9TUkVHX1BNVUNOVDQg
PSA0NCwKKyAgICBIRVhfU1JFR19QTVVDTlQ1ID0gNDUsCisgICAgSEVYX1NSRUdfUE1VQ05UNiA9
IDQ2LAorICAgIEhFWF9TUkVHX1BNVUNOVDcgPSA0NywKKyAgICBIRVhfU1JFR19QTVVDTlQwID0g
NDgsCisgICAgSEVYX1NSRUdfUE1VQ05UMSA9IDQ5LAorICAgIEhFWF9TUkVHX1BNVUNOVDIgPSA1
MCwKKyAgICBIRVhfU1JFR19QTVVDTlQzID0gNTEsCisgICAgSEVYX1NSRUdfUE1VRVZUQ0ZHID0g
NTIsCisgICAgSEVYX1NSRUdfUE1VU1RJRDAgPSA1MywKKyAgICBIRVhfU1JFR19QTVVFVlRDRkcx
ID0gNTQsCisgICAgSEVYX1NSRUdfUE1VU1RJRDEgPSA1NSwKKyAgICBIRVhfU1JFR19USU1FUkxP
ID0gNTYsCisgICAgSEVYX1NSRUdfVElNRVJISSA9IDU3LAorICAgIEhFWF9TUkVHX1BNVUNGRyA9
IDU4LAorICAgIEhFWF9TUkVHX1M1OSA9IDU5LAorICAgIEhFWF9TUkVHX1M2MCA9IDYwLAorICAg
IEhFWF9TUkVHX1M2MSA9IDYxLAorICAgIEhFWF9TUkVHX1M2MiA9IDYyLAorICAgIEhFWF9TUkVH
X1M2MyA9IDYzLAorfTsKKyNlbmRpZiAvKiAhQ09ORklHX1VTRVJfT05MWSAqLworCiAjZW5kaWYK
LS0gCjIuMzQuMQoK

