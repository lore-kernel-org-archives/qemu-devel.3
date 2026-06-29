Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8E4C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we399-0001Y0-G5; Sun, 28 Jun 2026 23:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we393-0001Vh-0b
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we390-0006BO-0A
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d0Ta1518986
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=OES4OwpY68ze2Hmn3HRKPHOte4o1zK6n49UyqbIUhyE=; b=Zk
 SieSNGGu2kZroYq2Rdynr3KrHlIIxEQzgwDXNvy8FbTB3y85dAliNHpPTIRriMTQ
 XQLu+pzlbabIop8ERUq7DVQpEUst86ci3k/EYCPJCjIwX+aQwUjHKIP1WHos8qWm
 qgLI3PjF9noewtp/vQ1ATRw1gQoX7xGbXy4OLLjl32ozQVJrqTGXFgeR4FWIk0zm
 M7JtqjBcglQ6H4yV57DyjGHPMqeadiSCf3ZbK/IGIfEZoLGD2FNc1Eou8cO9RLAf
 dGnRrr0sq0L52XeNhIeW0hfJDESs5sjXmowWeyZ9zprMAg8zu4nxgkbgoHPskkdX
 EYDj8R5k9aYtSsbqV6lw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2734cdbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:48 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139ca26403fso793447c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705527; x=1783310327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OES4OwpY68ze2Hmn3HRKPHOte4o1zK6n49UyqbIUhyE=;
 b=KPG8sX3OgoKkIjipi9S2Pw3Mz5+Q9/Mc83yxaP0Rp134e9Ev638vehz+WH2I6pWmyL
 +SJJoqagELc00XZwOFkS4XAyWN/vhJcT4jepGZFhg6vHh2gPl/pTvrz8KA/vHaXeGQhV
 6gwqMg4kPjiKny+t98MAU7vy+nY4iuAfpoHfD6SGr4ztG7S7Hg/yGMleR6Kuc2NpRwPv
 KAag66LdhkGVtKUjCA7Py1FAd2W9k7WQCBLgeNBCfD8M7byO7ubanJDfmsb55SeiHMy5
 9kCnqTSuhW5Lkh8xEZkbBvwk6s3ranyyaUOo3w0sV3NNDmQBIeOKbMsUyfuX+tWeqsTv
 6qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705527; x=1783310327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OES4OwpY68ze2Hmn3HRKPHOte4o1zK6n49UyqbIUhyE=;
 b=cVNHe5MSj8aLF/YtODTtL3xxIxAFfMV1zQ7+A/nbn2FpIbUswNHlz+KlSQ1mElcsL3
 jfw71Ags1PbvqZ4WtLCq5LQpllUkRAe1EcHa2YN8fDVk/dLD91k1fcViNtCuL/lUHQUg
 lYPScNzpruoDyek9WzO2vOt2mAAbgkVMmfWCQ6T3ArTZTsZo5zAb3iFEq88fan5LZvxw
 SphExV5GsqqJX2igLxOOhaWL/xUmXLayEciRXO6HV+zNX4W2TSgprmQfcbERuiYe6ktw
 yt7aNfndmsNCUaHu4e4T4KVgXMnR5CYCBAqMENW47FHqNg1Zt0z1q589MILV8k7hiPm4
 0kkA==
X-Gm-Message-State: AOJu0Yz+oVrVQ6SWaTS2KbQV3WoXaZCc0NTaVaQaRO74O+L44EsvJL2H
 7TBn7pL1Hcj0wVXnvzSNcVdUSZ6+aMcjEwiClFxjsRzev2wjTSpq/SZ62JIj22IttruqpOmYMaP
 C99s3wF3yGtjZuzeaxJrgaHpUrmiMioOzWV9LfrNbKmch8vF2Hj5mlco+XMJ6POijOw==
X-Gm-Gg: AfdE7cmfHbV7m9r5m7/Y7M2HE/YPEuRFErleefHQno9YWrJyvVsZUB+oI4dHuTUDISl
 fAoPzT8NniUktYIE0ULqQd6f6ZepMqJmOQgzW8xKLqAizs0BvyLEbSwFGJ7Mwm9iSlrMeZrMHoY
 zg6HfZAPtj4NzroUSEomU+bids7PfX+EpR+Ne+OEtxL2jHDOywZN+gIUY+Nd8dQTkdI7sWgLK+4
 hWKlfAam5ST4A099T3VzjpqEAFR52K4Y0aIASQLj3g5dg+qoDooDLHgU398wjz4sriBjt6PDdVG
 GmSes67O8j40yUcrnmgCwp6sMKeNI9eh7Jm6/aHzK9naAtPU88Xub9I0VU6+42dIux+JSxq736I
 Q2RFc11gb9F6J4Af/IIAVhOBrX6h8xLPxaTEaUCPTSx8XPIGdI9RiqArNz/o=
X-Received: by 2002:a05:7022:69a0:b0:139:7375:c435 with SMTP id
 a92af1059eb24-139dbac30afmr11128317c88.20.1782705527194; 
 Sun, 28 Jun 2026 20:58:47 -0700 (PDT)
X-Received: by 2002:a05:7022:69a0:b0:139:7375:c435 with SMTP id
 a92af1059eb24-139dbac30afmr11128301c88.20.1782705526654; 
 Sun, 28 Jun 2026 20:58:46 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:58:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PULL v4 04/77] target/hexagon/idef-parser: open input file in binary
 mode
Date: Sun, 28 Jun 2026 20:57:17 -0700
Message-Id: <20260629035830.1520296-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: lt25NEkhALmmG6RHwpw-7sZRQbBZoIwU
X-Proofpoint-ORIG-GUID: lt25NEkhALmmG6RHwpw-7sZRQbBZoIwU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXwGEAMAygP9s/
 UOujSmwIZpwLsGoum1miBOYxIR+Yrj0mJF169pjI3kM/zkdpwn4EUkp1Dzoz58TPCkiftiq7ZVS
 rH5fKQFILyEU5wkD606Hv23JxQ7Lly4=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a41ed78 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XwlTJ2-QRR3pk5tWCfYA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX/dDgImaW+aTO
 HhHHDQpdkiwkyaT/I2BNdiE3YdFGHfRINty4+Nnf6mA6bUxsc0GwAhPwY9EHa6fxGO61nuVhlr/
 WK+ACXTEK29wM3UjrjViZwbQycsVr7NpEe9rHjfcYsQTlZHdCi9vwimK9C7kUEFMW79fEbgo6r5
 GzYc5bG45nmRtkRedh1ziMEothAoqti8U8RlwiD+w0YgKJ9pFUCWCGdCypbSyEH8ualLGAqL5kR
 eQYpCTAK3F258qi9w7ZOV6sqPYN186GP9zPnjOh7WRn3sguJD0kReu1khGhtFw910uF0zKtoaGX
 aRwZF6xnIG9K0GRvP27rlTnc91wA/Sm63K9O5DSBh58rDyx76Umn26SKttmRLTNkTJLbiNDEVU5
 JKE2dBas5MZY620CF6VIKPJV8DNVAH0ttLGR61kPYAxOwwCc04ALlJ0jtYYkBrsyvfL/EPYsOh0
 eDDrov/CLyKdFI4a3Eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290031
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

T24gV2luZG93cywgb3BlbmluZyBhIGZpbGUgaW4gdGV4dCBtb2RlIGNhdXNlcyBmcmVhZCgpIHRv
IHJldHVybiBmZXdlcgpieXRlcyB0aGFuIGZ0ZWxsKCkgcmVwb3J0ZWQsIGJlY2F1c2UgQ1JMRiBz
ZXF1ZW5jZXMgYXJlIHRyYW5zbGF0ZWQgdG8KTEYgb24gcmVhZC4gIFRoaXMgY2F1c2VzIGlkZWYt
cGFyc2VyIHRvIHJlcG9ydCBhbiBlcnJvciBhbmQgYWJvcnQuCgpPcGVuIHRoZSBpbnB1dCBmaWxl
IGluIGJpbmFyeSBtb2RlICgicmIiKSBzbyB0aGF0IGZ0ZWxsKCkgYW5kIGZyZWFkKCkKYWdyZWUg
b24gdGhlIGZpbGUgc2l6ZSBhY3Jvc3MgYWxsIHBsYXRmb3Jtcy4KClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClJldmlld2Vk
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55IHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRlZi1wYXJzZXIueSBiL3RhcmdldC9oZXhhZ29uL2lk
ZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKaW5kZXggYzZmMTdjNmFmYTcuLmNhYmEwZDI2NDRkIDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55CisrKyBi
L3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKQEAgLTg2OSw3ICs4Njks
NyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAgICAgY29udGV4dC5oZWFkZXJf
c3RyID0gZ19zdHJpbmdfbmV3KE5VTEwpOwogICAgIGNvbnRleHQudGVybmFyeSA9IGdfYXJyYXlf
bmV3KEZBTFNFLCBUUlVFLCBzaXplb2YoVGVybmFyeSkpOwogICAgIC8qIFJlYWQgaW5wdXQgZmls
ZSAqLwotICAgIEZJTEUgKmlucHV0X2ZpbGUgPSBmb3Blbihhcmd2W0FSR19JTkRFWF9JREVGU10s
ICJyIik7CisgICAgRklMRSAqaW5wdXRfZmlsZSA9IGZvcGVuKGFyZ3ZbQVJHX0lOREVYX0lERUZT
XSwgInJiIik7CiAgICAgZnNlZWsoaW5wdXRfZmlsZSwgMEwsIFNFRUtfRU5EKTsKICAgICBsb25n
IGlucHV0X3NpemUgPSBmdGVsbChpbnB1dF9maWxlKTsKICAgICBjb250ZXh0LmlucHV0X2J1ZmZl
ciA9IChjaGFyICopIGNhbGxvYyhpbnB1dF9zaXplICsgMSwgc2l6ZW9mKGNoYXIpKTsKLS0gCjIu
MzQuMQoK

