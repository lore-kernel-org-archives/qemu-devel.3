Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A331AC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coD-0008Vu-U9; Wed, 02 Sep 2026 00:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coC-0008Ve-Kq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coA-0000JP-U2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:42:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTM683751043
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lL7MYL4wXjNxhVBVqr/w00VTB56od7CTJ8sE/VpsDuY=; b=lNDBduAOTXn4z4aH
 XSUoWbvPut0XPNbdvDgfuQUbGmAiMgyMvTVxjpie+8s3w0pRbuyLP5FB97YN4BB/
 LdUW9SlCSX6mjmN8Q66QMfBe+lybawpiyVMAqeG7LAUe5C0yjf0WOG8RjnBrLbIG
 Lwwyh3HngVgWJxjaJvNsgUzJv6VG5tgN6nUJduZ0nz6FEbBZeAmE2P3QQ7SKGx4X
 +abfeNpWLoECAJNztkR0Isy8iKMFFaeSgH03OFxAIzPDob59dS+TuPSExUc7XbKb
 pTFVC/sK+bbV07KboLZYDWAnopuezKkQaI41RoSRvBWqNhzAlgGMEM+c/21/+fAh
 H+s2lg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge38w24eh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:42:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso2041218a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324165; x=1788928965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lL7MYL4wXjNxhVBVqr/w00VTB56od7CTJ8sE/VpsDuY=;
 b=FV8EqGHbrMB9fYuZUfKlb3YU5QLTzDZIY2jfABsvcAswU59Ei+8WreyO2EDxUXPBlu
 0ZUiQzK1JJ5kwa/kuFjPZb2LyQX0yM+cBxHEkyWLVG/si418XsDvVsptDY1u+V9ifLdT
 4ZZ2SGVPK7Z8rRcSWonYVq9a476bCLCq9BC8FyKdX8Ca2ChVT50tDTOHRIc431FUpJfT
 cAcUz4E3Ba4OkDOXAtIWIwSLCnWrmKFO4UTKksQk+W3TycmXYYSoz3XMJ4l1AZ6ckDzE
 CqPwIhWyzbhtWEcdcu2Jwg803wNFFBEbDncVyoirhr5VUFrWBp2pGo/fDHC7wrOexgfW
 J+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324165; x=1788928965;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lL7MYL4wXjNxhVBVqr/w00VTB56od7CTJ8sE/VpsDuY=;
 b=VEoFv3OyXutEbXUX7ju4GRisCZhRLVJD+929JN52S2LTNUU1yIt4RSl3qgnm+F1+/d
 g0Qyno1/nopOU66mNJN9W6YHBBzWBgU9hKqYjqorpvoHfFNmEtvLIuXmcCOh21zP6yN4
 mZAw1CW7dtgHMRclaeoQphn4oV1nDYYufOZfkfi6zTIc1zL4sC+Vzak2Mk8C/SEB/6fz
 c/dD7+wUZJhbFJABiH0oYcj7wFp98qv04m40pE/CDGTb+RxhJSfJYVDAKZjFqaW8624D
 c+sXI9n25QmLhTZeqU6KJEYt/CBeToqu+tgGNmkVXat8L4QsZ/koMvkqiCvGX1lLd5iR
 QFjw==
X-Gm-Message-State: AFuF++k9LEiQjHxH7AVwl6UIjig+ym1pATmll4InqTJtotf41ytY9faU
 aBHHJwe9GgQogvR3zV0THnrhlc2U0Ocdi3aeeGIMwiPp/gwNrehew0wUiy3TL3DjakuuxCfv6xO
 trPUriOUnxfovEg2cAdkM5GwvECzwWZrLSZ1w2doqLGcHjT7xJLRdt9D9d3iipJp6qg==
X-Gm-Gg: AYBFou3rla2YbKEaPF846tmdfDOfKEz0Crgt8e+XC7Yx82Oxm9BVPzVLTnSkUK0b1Qu
 hP9SJFuG2FwBEBeIH9AAvRIjNiJ165UIAbbgeRpQoADXq0/IuNn/n8P8r9fg+YRkBP3pzxywuNm
 gvvAG5aDAUxB2UuT2jIiSbXe/Kuqzwvd1/4N/eAmhbOopT726RirEudH1P2V6Mye4Tb1l5y1IgE
 zG2tm/g9VVJpUAngi8aBpTMqFTLwlzMKAm7TJej44Smyip6tmEZnyoMKJbZewtE/ndhXT+6tF19
 yQGRPy+dmJVqiOMl8WyMncA3QCBPdBdUPFJutdk9kq/dw0IkiCiRvfb+JPa+htmyf1EbcIQ6IIQ
 F9SfKQ62Cqo/18ENKvYSmXUZOvDFSy+q+OdvXm8+9orf1ynGJ
X-Received: by 2002:a17:90a:e152:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-39af57ba754mr432678a91.5.1788324164920; 
 Tue, 01 Sep 2026 21:42:44 -0700 (PDT)
X-Received: by 2002:a17:90a:e152:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-39af57ba754mr432650a91.5.1788324164417; 
 Tue, 01 Sep 2026 21:42:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:42:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 03/28] target/hexagon: fix PC advancement for non-COF TB
 terminators
Date: Tue,  1 Sep 2026 21:42:06 -0700
Message-Id: <20260902044231.843004-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: E5Lvg6KNLv22JnOWdOwyxNruWhAqoQs9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX7ieXVPLeflb9
 Mum3w5vMDAjrn9tlhYOJoOA/Sey8Jw+0f8jnKKX4as9CWhsHqC5L5BEu6WrhTg99SP8VMlUOd9Q
 hqVrcmOuiW4+on6mX3DwBJPKi+fyGNg=
X-Authority-Analysis: v=2.4 cv=LOpWhpW9 c=1 sm=1 tr=0 ts=6a97a945 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=4a9di1UdVY1t8Q3xuf0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: E5Lvg6KNLv22JnOWdOwyxNruWhAqoQs9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX5xNsS870jZ9s
 fDHYwMNj8FPb5HXCfqFA51//CINt5VTrFIFJ0WVrTKB021VuljLqqEqD50uwyhbPa65HZyqPkHW
 z0RR5R4eal3V5/te2/ow/4TTt3DB8hkNIrBE2T8Uv+CbeO/6itOklfc7KaxHjWvOWszsTudqOiF
 ZHtaJeCpg6WMbaekeWjNaKABQYG0rSYa3VfnhiUjEvMj1htp/v6pBuFjzVwgbJi3NeF796Oy5eR
 4c1eHMe3IVRTJsNRPrgcu2n8om+6fUg6X+VJVz+j2alS+U87q2/81QNvUsxDrJpEf7kCNVsOTtH
 HmNeg5aETrM9G21nvdmd2kjWecvaD825K4uVvWOuSCc8JhKV29BXTeaM1JijRwViG/savNbGklP
 Jo/0/PJiBg35iYst0yMvdYKKGkAWIxVisVrjmFOJ07gfOx6lJGK6TngSP8GFw+KjjxbJqic2RVX
 20lh4f4m2UhUzUVwElA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020040
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKU29tZSBwYWNrZXRzIGVuZCBhIHRyYW5zbGF0aW9uIGJsb2NrIHdpdGhv
dXQgYSBjaGFuZ2Utb2YtZmxvdy4gVGhlc2UgZG8Kbm90IHVwZGF0ZSB0aGUgUEMgZHVyaW5nIGNv
bW1pdCwgc28gZ2VuX2VuZF90YigpIGxlYXZlcwpoZXhfZ3ByW0hFWF9SRUdfUENdIHBvaW50aW5n
IGF0IHRoZSBzYW1lIHBhY2tldCBhbmQgdGhlIGJsb2NrIGdldHMKcmUtZW50ZXJlZCBmb3JldmVy
LiBTZXQgUEMgZXhwbGljaXRseSB0byBuZXh0X1BDIGluIHRoYXQgZ2VuX2VuZF90YigpCmJyYW5j
aCB0byBmaXggZXhlY3V0aW9uIG9mIG5leHQgYmxvY2tzLgoKTm90ZSB0aGF0IGdlbl9zdGFydF9w
YWNrZXQoKSB1c2VkIHRvIGhhdmUgYSBzcGVjaWFsIGNhc2UgZm9yCnRsYmxvY2svazBsb2NrLCBz
ZXR0aW5nIGN0eC0+bmV4dF9QQyB0byB0aGUgcGFja2V0J3Mgb3duIGFkZHJlc3MuIFRoaXMKcmVs
aWVzIG9uIHRoZSB0bGJsb2NrL2swbG9jayBoZWxwZXJzIHRvIHByb3Blcmx5IGFkdmFuY2UgdGhl
IFBDLCB3aGljaAppcyBuZXZlciBkb25lIChvbmx5IGVudi0+bmV4dF9QQyBpcyB1cGRhdGVkLCBi
dXQgdGhhdCBuZXZlciByZWFjaGVzCmhleF9ncHJbSEVYX1JFR19QQ10pLiAgRHJvcCB0aGUgc3Bl
Y2lhbCBjYXNlIHNvIHRoZXNlIHBhY2tldHMgYWR2YW5jZSB0bwp0aGUgZm9sbG93aW5nIHBhY2tl
dCBsaWtlIGFueSBvdGhlciBub24tQ09GIFRCIHRlcm1pbmF0b3IuCgpSZXZpZXdlZC1ieTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQt
b2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8bWF0aGV1cy5iZXJuYXJkaW5vQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8IDEzICsrKysr
KysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYwppbmRleCAwNmE4MTU5ZDI4My4uNTQ2M2EwN2VjNTIgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCkBAIC0yMTcsNiArMjE3LDEyIEBAIHN0YXRpYyB2b2lkIGdlbl9lbmRfdGIoRGlzYXNDb250
ZXh0ICpjdHgpCiAgICAgICAgIGdlbl9nb3RvX3RiKGN0eCwgMCwgY3R4LT5iYXNlLnRiLT5wYywg
dHJ1ZSk7CiAgICAgICAgIGdlbl9zZXRfbGFiZWwoc2tpcCk7CiAgICAgICAgIGdlbl9nb3RvX3Ri
KGN0eCwgMSwgY3R4LT5uZXh0X1BDLCBmYWxzZSk7CisgICAgfSBlbHNlIGlmICghY3R4LT5wa3Qu
cGt0X2hhc19jb2YpIHsKKyAgICAgICAgLyoKKyAgICAgICAgICogUGFja2V0IHdpdGggbm8gZGVm
ZXJyZWQgQ09GIHRoYXQgc3RpbGwgZW5kcyB0aGUgVEIuIFBDIGlzCisgICAgICAgICAqIG5vdCB1
cGRhdGVkIGR1cmluZyBjb21taXQsIHNvIHNldCBpdCBleHBsaWNpdGx5IHRvIG5leHRfUEMuCisg
ICAgICAgICAqLworICAgICAgICAgZ2VuX2dvdG9fdGIoY3R4LCAwLCBjdHgtPm5leHRfUEMsIHRy
dWUpOwogICAgIH0gZWxzZSB7CiAgICAgICAgIHRjZ19nZW5fbG9va3VwX2FuZF9nb3RvX3B0cigp
OwogICAgIH0KQEAgLTI4OSw2ICsyOTUsNyBAQCBzdGF0aWMgYm9vbCBjaGVja19mb3JfYXR0cmli
KFBhY2tldCAqcGt0LCBpbnQgYXR0cmliKQogICAgIHJldHVybiBmYWxzZTsKIH0KIAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCiBzdGF0aWMgYm9vbCBjaGVja19mb3Jfb3Bjb2RlKFBhY2tldCAq
cGt0LCB1aW50MTZfdCBvcGNvZGUpCiB7CiAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBwa3QtPm51
bV9pbnNuczsgaSsrKSB7CkBAIC0yOTgsNiArMzA1LDcgQEAgc3RhdGljIGJvb2wgY2hlY2tfZm9y
X29wY29kZShQYWNrZXQgKnBrdCwgdWludDE2X3Qgb3Bjb2RlKQogICAgIH0KICAgICByZXR1cm4g
ZmFsc2U7CiB9CisjZW5kaWYKIAogc3RhdGljIGJvb2wgbmVlZF9zbG90X2NhbmNlbGxlZChQYWNr
ZXQgKnBrdCkKIHsKQEAgLTU3NywxMCArNTg1LDcgQEAgc3RhdGljIHZvaWQgYW5hbHl6ZV9wYWNr
ZXQoRGlzYXNDb250ZXh0ICpjdHgpCiBzdGF0aWMgdm9pZCBnZW5fc3RhcnRfcGFja2V0KERpc2Fz
Q29udGV4dCAqY3R4KQogewogICAgIFBhY2tldCAqcGt0ID0gJmN0eC0+cGt0OwotICAgIHRhcmdl
dF91bG9uZyBuZXh0X1BDID0gKGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9rMGxvY2spIHx8Ci0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX3RsYmxv
Y2spKSA/Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5iYXNlLnBjX25leHQg
OgotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+YmFzZS5wY19uZXh0ICsgcGt0
LT5lbmNvZF9wa3Rfc2l6ZV9pbl9ieXRlczsKKyAgICB0YXJnZXRfdWxvbmcgbmV4dF9QQyA9IGN0
eC0+YmFzZS5wY19uZXh0ICsgcGt0LT5lbmNvZF9wa3Rfc2l6ZV9pbl9ieXRlczsKICAgICBpbnQg
aTsKIAogICAgIC8qIENsZWFyIG91dCB0aGUgZGlzYXNzZW1ibHkgY29udGV4dCAqLwotLSAKMi4z
NC4xCgo=

