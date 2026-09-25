Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE94C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9O-0004xA-9H; Thu, 24 Sep 2026 21:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9H-0004vY-ML
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9F-0005sD-11
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kUqL705970
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8cvVVhcQo22iups7MHduZhtcuerfZAl5JAXLqVBKlIo=; b=eFmn4X5hc2ajQEdO
 VNi7SJUGCxTTuN4QA6JU2Xso80NbcQ8tkeeSlK6NQnMh4elz27Nj1zJOZeVf0hrZ
 H0IxCdYC56j6hgCjmtL2kdhSH/RLtemtBwfAiuut3RwqKezHboigkCZSM7Vv6THn
 MFd5SMQeHuE9GdEQrBZwtr96+zo32HsLmD8CbWkKZbM8ojUTOj9rjopXTfp2VfCY
 i+rVJxfRuFnglZ/9fn0Xlfc6ci+iy3pbpqKiv9SudP8uP3SmsCykCyghR3JcwgWi
 xQXvJRJ2CFkbTGGjvpCzM/3XJ90B9vr9u7VOdI+P8AubYlx6wd+/p7a3Y1WUWpUR
 q9IKCQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce78h9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso574253eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301287; x=1790906087; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8cvVVhcQo22iups7MHduZhtcuerfZAl5JAXLqVBKlIo=;
 b=kp/epUVnTmrgFdxQmzyvs1+Eyn5qUTf5yDCkevayUxaKup364xuoisOUwMjYksGmno
 NnBLtRodqJFVKYkrrcznoYMop/fdb+dyow/TEYI3wkO3qanWdw91Gmc8cOHyykkiQxBe
 ONb/N75ht7FHCN3escRtBSea8VGvcYphgA+anAAJercFQVia7OhkGmCJy2tP4ATp11Fb
 1EY3kfNAeRuG/6ZURpYqxb577krG0n82wldbh03K2ed80BdwwAmZgstrgv4rJbvg/iHj
 5bF0VaHS4gjKNTJH+qCjfwjmNmCHp5s/1n8ELFBTXFHo47dRm5g4f44hxv3dXwmfATTm
 ANMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301287; x=1790906087;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8cvVVhcQo22iups7MHduZhtcuerfZAl5JAXLqVBKlIo=;
 b=A3AF34j2ozYIQUNCboy+YJufY656RMHnT3lRaJvcfIiquJpnnaNP+xUge3hInpso3i
 m7P00v0A+VR61eSM+UegFYC7cgtYYcf7/4WwsBFOnMk5YTN0I72isWR4QUidaqTQKBIp
 Iinaf1zQo/NlgNFkRj6J1VuQVXBJ/BqC5Zmbdnwn56fflnVwOhKAfNTDSgvhXGeOmKqG
 VTMY2NBCgJt7CsQRYnu7Rb8WxjmwVh5y0kcx6PIr0T9vla4+va3BWOYuhyIzUofR9qnj
 Aoj8nfxylqEOSGSXgQdZgD/3WLbSrNmbmW9zzJ4XzadVghqY5kEwuIaCLfrS8kiZHSiv
 CPTA==
X-Gm-Message-State: AFuF++kmaQMiEH+ovDG54k6M1VaBi3ikFOGkDdl9iMyzHJODDzMeIK2c
 76xCommcGK35dVIvy+SFBNXREQQdh6S90xofENDIC9nu27Jkls6o11i2LjcFs6XUz6Ot89gfsj6
 jULzxo857ej5aFgpLOIZbkLytDWE9VN+nKGYMOmzesZzsTLS++a/Q/NbnDSjCpoGpQg==
X-Gm-Gg: AYBFou2AjEJ5++JrArLmfNczhK1EqAUxModeht17j+0O3LSvRyqmg8/uw3r2nVmKkHf
 DX0BDRmT83OuAB7MfDt3XB21i9C7CyGA3JdKjcaVVe/TMSca0JMRkl2sFH0kdzTOeJCHofV1Tz6
 7A97Emdow8Xe4v8C01w6M/9PI4uWTFfMQPL2cK4tmgZujsmhxi27qe2oIvG5M5h7RR6/RmLk5ps
 j4/mitfKLOrBSstrQZDTV8jOu4PjhaM3hDIHOGrM0OF4qdBX5gB7k/s1yxgY7QbAGI7tD/o759X
 S4W1A6DMy1hduFoWEeluKBq9PQKBaozGBVq7l4wk5DwDFDT+H604cgsXtTzvBHSteXQPMzZh19l
 Z63ZOsBdUb+78KwBr6BP+oaBWl6TkRVvYVIzcHabjvXtf6Nc=
X-Received: by 2002:a05:693c:41db:10b0:33b:dd20:f79c with SMTP id
 5a478bee46e88-33ffeb46c67mr3423957eec.12.1790301286786; 
 Thu, 24 Sep 2026 18:54:46 -0700 (PDT)
X-Received: by 2002:a05:693c:41db:10b0:33b:dd20:f79c with SMTP id
 5a478bee46e88-33ffeb46c67mr3423939eec.12.1790301286242; 
 Thu, 24 Sep 2026 18:54:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 07/40] Hexagon (tests/tcg/hexagon) Add tests for qreg multiple
 writes
Date: Thu, 24 Sep 2026 18:53:56 -0700
Message-Id: <20260925015429.2579174-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: jkOlQvgI4hb_fcgJcDbJt7g15fpppW6-
X-Proofpoint-ORIG-GUID: jkOlQvgI4hb_fcgJcDbJt7g15fpppW6-
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab5d467 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1APIX9Nw0rv35xyIdUEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX8jZlzFls49bx
 d3qrXaMloboJpDHrFmV+gJOh2MZoVNgIzmVT2LqeNjbngyLnW8Ld8+XnYmHts+PyvaBuUvb2dwA
 cUpL2WHxJ+KHOfT9NTAKd56EM0S2cyWMjb/1XoyBtFzLBq9FiTUFlyR7OJsFyc/4tHH8nHxHKri
 A5EQu/C/wOxuL4Tgy5pSiv/sMNVXKT3SRFEwEe/f162wR9Hd3CGxM91b0UXLHFFXy8ostOTX0NM
 xVf7hfMxoOMdWH475kZgflLMeFHPNFvht0+gqxykMD/pyh6AISpI1MZhzIWSyt+GPIxLweB6vWe
 UDv7UKbODXAL6ewMOuHPzQ0yFSly1HicnI3MEy4DdDSLcP/Qtg/pbs5s0gbIcpqNxsm0Us9y/6N
 Pu8q2vwenz9kP/+bIHhvV2Jr26sKKXb/EEqZFnHju52y1OZjEkw4oNXqsK9xjDJF8k+AyuzvsHq
 jvCN30gPUs0nWRGSBtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX9eLLapm7klA6
 juCfjr3IaRcQZkJd7AZuigH1iLugPEBNC7C+14djUb99CqVLvOqtc7vTRKJJYKNQ1gvlGNATY/G
 botjnz9sAfwrZoh3QQzcg05PARa6UAE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClJldmlld2Vk
LWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQt
b2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMv
dGNnL2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMgfCAyMyArKysrKysrKysrKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy90
Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL211bHRpcGxl
LXdyaXRlcy5jCmluZGV4IDYyZTU4MjhhMGFmLi5iZDJiMTM4NGRkOSAxMDA2NDQKLS0tIGEvdGVz
dHMvdGNnL2hleGFnb24vbXVsdGlwbGUtd3JpdGVzLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24v
bXVsdGlwbGUtd3JpdGVzLmMKQEAgLTI2MSw2ICsyNjEsMjcgQEAgc3RhdGljIGludCB0ZXN0X3Zy
ZWdfaWxsZWdhbF91bmNvbmQodm9pZCkKICAgICByZXR1cm4gc2lnOwogfQogCitzdGF0aWMgaW50
IHRlc3RfcXJlZ19pbGxlZ2FsKHZvaWQpCit7CisgICAgaW50IHNpZzsKKworICAgIGFzbSB2b2xh
dGlsZSgKKyAgICAgICAgInIwID0gIzBcbiIKKyAgICAgICAgInIxID0gIyMxZlxuIgorICAgICAg
ICAibWVtdyglMSkgPSByMVxuIgorICAgICAgICAie1xuIgorICAgICAgICAiLndvcmQgMHgxOWEx
NDA0OCAgICAvKiB7IHEwID0gdmFuZCh2MCwgcjEpICovXG4iCisgICAgICAgICIud29yZCAweDE5
YTBjMDQ0ICAgIC8qICAgcTAgPSB2c2V0cShyMCkgfSAqL1xuIgorICAgICAgICAifVxuIgorICAg
ICAgICAiMTpcbiIKKyAgICAgICAgIiUwID0gcjBcbiIKKyAgICAgICAgOiAiPXIiKHNpZykKKyAg
ICAgICAgOiAiciIoJnJlc3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAibWVtb3J5Iik7
CisKKyAgICByZXR1cm4gc2lnOworfQorCiBpbnQgbWFpbigpCiB7CiAgICAgc3RydWN0IHNpZ2Fj
dGlvbiBhY3Q7CkBAIC0yOTAsNiArMzExLDggQEAgaW50IG1haW4oKQogICAgIGFzc2VydCh0ZXN0
X3ZyZWdfaWxsZWdhbF9taXhlZCgpID09IFNJR0lMTCk7CiAgICAgYXNzZXJ0KHRlc3RfdnJlZ19p
bGxlZ2FsX3VuY29uZCgpID09IFNJR0lMTCk7CiAKKyAgICBhc3NlcnQodGVzdF9xcmVnX2lsbGVn
YWwoKSA9PSBTSUdJTEwpOworCiAgICAgcHV0cygiUEFTUyIpOwogICAgIHJldHVybiBFWElUX1NV
Q0NFU1M7CiB9Ci0tIAoyLjM0LjEKCg==

