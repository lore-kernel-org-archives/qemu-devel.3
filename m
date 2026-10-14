Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DFBC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH51m-0005TH-4J; Wed, 14 Oct 2026 15:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51k-0005Sn-RZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51j-0002Vn-8W
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:40 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZmWP3469215
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4JgiAcnQPvZmlsW0668YGmvnJG7Ah6t2ZSVER2TdSMw=; b=RJQTlhMDatYdUDmM
 p7MrwuEeU45j/yUMzf3gdrF1OBSyKqWVSxdWi+28plOxRWtYU2IMYG/+G32EFbeN
 yPh4UzlF+NIYshFBoYRprlywCaGSxlGYe3lLDeh4sTaeTjGE70zozMFplSxIL+v1
 cXTj6jsDTS32VHnIuSae9Ld0WXlE9ahizwMv1x3oVwVxe/y2HwEeN/ZWwaOp+2vO
 RA1vnkeg2Avuscr9I5uW6EYqA50m4Eq5sN33TQwGBVR2BJK1V6i7NNfFf62K5xU2
 jRb6n4aCemf+vzUIBx1KuQNIjvY/LA8nJpK46j5zhVptXbbPpJ3dqmsy8NuITAFk
 WnaiBA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd78r2n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso8521461eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007557; x=1792612357; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4JgiAcnQPvZmlsW0668YGmvnJG7Ah6t2ZSVER2TdSMw=;
 b=gZ+9SkAL6sZmNgEaywQ7OsGGezehzWC2bWZe61AV7CX3ilE+RdHsnXZ6ypPbdoBIhX
 K8Qt9HEsKLac+TJTuuDv4hkxvipccgX0tO2IfySEUozN4eixj4/be7KoZyC2WIF4P23K
 g0kZrQ95jeA3wWS49eORCCQKxyqaCQTYj+HX545ROuroTz3P9afPJDPVGCK3U1XMar/I
 G0+KrRD1JdWuqBvMDNqqsbPlWCvtbhsWaPJzdk4lkqPD5E1pezifcINYT6sWyWXhRodP
 z8aATcvxWU7GfFJVmkFuWT/cqhJp0a7DErRI8yPsOsh0LehfjlCKH884wcFDxbwdAOAG
 I1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007557; x=1792612357;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4JgiAcnQPvZmlsW0668YGmvnJG7Ah6t2ZSVER2TdSMw=;
 b=hXqOes2DBEoRrrZp30h5vSut6u4jWjdbcFyQ3sx5SeMencsMkc2EF7mWS1WiACWGhb
 UX8g67QZRT4sO5DVK3tbAvXnhB9v5t9HRbTo3Pg0+CEH52h3ZV7Qjf/Wbh4ERbZiKzVr
 foojI0OftIL+69riislvuI5FF72p4Fhxfjck1qLvnryNNJpYkrCtrsDw4XPVr0BSF9qh
 CvHn/wWg516/IgdEdJYOo7JmvD6Vp+XXxAzd6v5jxFry1YDqMO5L9/BsppNXs0AQQEkD
 LjF1BX0c7chElHaEh77fYn/qvwakUwL3Xoa/mmFNh4YHHQzj2mQQU9fN2ObQG2QUxHvr
 HwXw==
X-Gm-Message-State: AFq9FYKLUtC4JRamY6j7+Z38zScy+EV6TF01io0yjz91ETSgype6b7DF
 //+iP2ADSg+s69II9zWoplsSyVVEZYoU+0goqdiYjVcIuBIKWzGUQd7k1D22YJRH2PRUTp93HIZ
 M90u9WoTX+g7H8pk/GnX2G+yeBEOIAIlOijZ5M/2VOdqLInc2YdW3QXQnSewFbV9jkA==
X-Gm-Gg: AYBFou0MZJQJBeTBl2xGCkQxMlUu0WIfdH4j4AvI9uwrt9lGJBHdyv8XLKTdkKt74zT
 txrzZwWxhNn1RmoVmek3I4ZMLKQnwbdZlMra3idUYt72XBDd1tndjweXuGl5p2QOx+OgOTUGVxF
 ebYKsnIiIcikg/YCR0yWkI6U/g88I0uckPt0eETnyoFcZup2q0HKZYDWiLMNjUD2PG+2QJZ04s4
 jpJMAeq9W6bXA0NLMibZYBpXZTAagoXhol7hRjKSLswKwf0fgBLEYVIeOMWRig2wFmd6FA6JoM9
 IgQi6iY+Gy/XBckhROHs9RHpLSjcvV8c8bwI4IDmsaXrV6u/wXhq2iqslr+i6T9wIxyLo2gupvt
 zr7KK4+i+6poTw2O4cvCRCdbb68LUDezLa9ZdIe/L3nhDmJw=
X-Received: by 2002:a05:7301:18a3:b0:353:8122:27b4 with SMTP id
 5a478bee46e88-35381226e68mr24586953eec.18.1792007557134; 
 Wed, 14 Oct 2026 12:52:37 -0700 (PDT)
X-Received: by 2002:a05:7301:18a3:b0:353:8122:27b4 with SMTP id
 5a478bee46e88-35381226e68mr24586928eec.18.1792007556689; 
 Wed, 14 Oct 2026 12:52:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35f0c3bcf80sm547069eec.7.2026.10.14.12.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:52:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 09/12] target/hexagon: preserve callr target when Rs is LR
Date: Wed, 14 Oct 2026 12:52:20 -0700
Message-Id: <20261014195223.3233623-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfdd85 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=7q1P7thizxoqYyVqf_8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: OLdUh72o4j6UQyJfhQEs_eZUE1bgbyuE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX8zDuwe7wlqoo
 mkmCgMBIxOjPjt5dIIvRQfjWiNtNBbj2iS8bcmhRBFatJXdQgefO7djiTWB3It4J0IFcuEXdXSN
 FAMMA3rK7Uh9Iaf214jnrqg8Nh7vMdgNJ/htkGTq8tj3ZH9/buspZuD2mEw5bEIkWkg1XFnSL3K
 O0vSSkuHEItLKZyJYPSphTAl3sD3WGSKjS+wRauKoEwsg09nm1X7+juPJsDSyxp/dYn+FAHBQzR
 RlYGBmckLdykC4QOEgKEFkAh98Id9E4sRtGZisJyTqKOcnoUYSi+JOVND1e8qSfRg7GTi36+TKm
 hLwdBqVuvKlez8W+Pxof1g31AKClkv26DMhSuW15fmiYeeoITE7ejUJLu72r/vw6bL5KaA3nWMQ
 ApXDbWSsayLcgcHD5xPNHBobKa6Xe2Rhw/ftKXs4d+SdCgd0gDn1ZWdVpPoPlL6BMhAQqEkIVJO
 /xSh/CRnxE8pVNTIDyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX5G7J9B0og4Oz
 bFwJK5N/bwDehQgJwKdimcP85pQP40qxfkIPwgfessGCtnzOUwdAWnzedwNmAt0YB/+mjhb3eZF
 Nixq5w4go6KnXMjwtjvuWLfqM2FCP/I=
X-Proofpoint-ORIG-GUID: OLdUh72o4j6UQyJfhQEs_eZUE1bgbyuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140079
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

Z2VuX2NhbGxyIHdyb3RlIHRoZSBsaW5rIHJlZ2lzdGVyIGJlZm9yZSBjb25zdW1pbmcgdGhlIHRh
cmdldCwgc28KImNhbGxyIHIzMSIganVtcGVkIHRvIHRoZSBuZXcgcmV0dXJuIGFkZHJlc3MgaW5z
dGVhZCBvZiB0aGUgb2xkIExSCnZhbHVlLiAgQ29weSB0aGUgdGFyZ2V0IHRvIGEgdGVtcG9yYXJ5
IGZpcnN0LgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jIHwgNiArKysrKy0KIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9nZW5wdHIuYyBiL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jCmluZGV4IGYyNjRi
YjlkMGEwLi43ZWY2MDI0NGRlMCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMK
KysrIGIvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMKQEAgLTEwMjgsOSArMTAyOCwxMyBAQCBzdGF0
aWMgdm9pZCBnZW5fY2FsbChEaXNhc0NvbnRleHQgKmN0eCwgaW50IHBjX29mZikKIAogc3RhdGlj
IHZvaWQgZ2VuX2NhbGxyKERpc2FzQ29udGV4dCAqY3R4LCBUQ0d2IG5ld19wYykKIHsKKyAgICBU
Q0d2IHRhcmdldCA9IHRjZ190ZW1wX25ldygpOwogICAgIFRDR3YgbHIgPSBnZXRfcmVzdWx0X2dw
cihjdHgsIEhFWF9SRUdfTFIpOworCisgICAgLyogUHJlc2VydmUgdGhlIHRhcmdldCB3aGVuIGNh
bGxyIHVzZXMgTFIgYXMgaXRzIHNvdXJjZSByZWdpc3Rlci4gKi8KKyAgICB0Y2dfZ2VuX21vdl90
bCh0YXJnZXQsIG5ld19wYyk7CiAgICAgdGNnX2dlbl9tb3ZpX3RsKGxyLCBjdHgtPm5leHRfUEMp
OwotICAgIGdlbl93cml0ZV9uZXdfcGNfYWRkcihjdHgsIG5ld19wYywgVENHX0NPTkRfQUxXQVlT
LCBOVUxMKTsKKyAgICBnZW5fd3JpdGVfbmV3X3BjX2FkZHIoY3R4LCB0YXJnZXQsIFRDR19DT05E
X0FMV0FZUywgTlVMTCk7CiB9CiAKIHN0YXRpYyB2b2lkIGdlbl9jb25kX2NhbGwoRGlzYXNDb250
ZXh0ICpjdHgsIFRDR3YgcHJlZCwKLS0gCjIuMzQuMQoK

