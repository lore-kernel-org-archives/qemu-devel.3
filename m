Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69A6C44502
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBn8-0004Jh-UH; Mon, 29 Jun 2026 09:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBn7-0004J6-G9
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBn5-00039k-UV
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:12:49 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3Le2601595
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PhlMi1XNwmwGtcu38VtvVt8mGfYfYfXO6/8xhorQDxo=; b=ILhgk8wYBC6mP+Re
 +W4viThOlk8EulSCIh6g74aybJsQvUeQvxI0Slxk/hajNlwZb0t0iP00SsnwXAtI
 +LaSUG4S7tYOI4DnVPW1tIE0whQQnZ+LLZN6uq4k5wEdDz8GPG9Fb6FYgOKxOw6F
 DNNAyuB5eMt7g15Vusr+B2ZQlqSMNTwLkeYXp9CieUliFJGWClHe0IKh9TszjRpV
 gw+oP/tGMxrCFNzy86WDbZauvjaqUPbvnwLGM+3t6IpOXYtmJ7NTzyajlG68WOhw
 dZFWgkBJe0GQrKcZVivtz7Ye4Lb0fx+u3rgnhyum1uqBo35slSYnAMRopghvZnOC
 2USrHg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw8ybp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:12:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ba395b047so11794941eec.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738766; x=1783343566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhlMi1XNwmwGtcu38VtvVt8mGfYfYfXO6/8xhorQDxo=;
 b=UW5s2mvn6O/+KJcA1GlQufm1kPt+F5RyfPhKGKdAEhn1Kt8PV+cI+9V5yNqZTOESqJ
 V4PxUwxM4jG9gY97quVdDQJmtcG2A5UYO9B9gYsA7bD118YNL9XZWUODM2QbfVsJ7Ira
 seiqe+9eOLRA0i9TqgvFLEyuMpfJ/czL6XRP0klQ6xtlG577VFYup2IIfZfObLoDqPjn
 /yVPYTw2hGg4JK2uFl8eQZgF2KZ53WRi7Ho7hrzjYPbIzj85Efg0p8vIFexS2jo3M6Jv
 vhci3NuJDl82dseVpWcVHJgiwQ9JL1HM1mqGWyQ9jFwUt/d+7hTiHgDK1n2vZhVtsxJv
 ce8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738766; x=1783343566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PhlMi1XNwmwGtcu38VtvVt8mGfYfYfXO6/8xhorQDxo=;
 b=IFjp/Z/eaZg1EfDNZipFjg6QN+BfsQuyfXo8sjvMFd7JlNDFkj9nJ0sk2mwUpqap+G
 LVKy3mW2vZYDu75xm1i31NfRt7wnAx/+7fLlflXf1Yh0LNiYQTowQB5u711zuMZFBQKW
 Tvm0OUedl4dYg3/8EmpbDQ1x98ocjHdZ8sFRQAgrdX3Nxm/hahWpL+QN5XNKx76cjmJJ
 K7mNsg9cKRV3jrLNLIgkkUvq7MQ2TRk3z1wGm3glHREm8sKsMQUPltx5Fge58IQ8F9G4
 i5SetsmV9VH+X91i99GNLGNAIxKeIeFGcnb9lcRECcPeYjqEtBF85rHtlb6z26j5GLZm
 UvIg==
X-Gm-Message-State: AOJu0YxdTVaeBpIuuwZad2ioTqbm9uHbklP/pCmu1093Jxl2WoLKVic9
 9uXotfamTkAhI9BCmotySJvIWnB3H/JsQoLvV2Um9Y7VPyqSshFZywr7Q3f1CCXNyzc3Hq/AqKc
 kDkb3ITjpuavpDGisEWa8g+yv14paBRid6SHbowfdAO6Oj4J/6x1pXdwr8yg/OejYkA==
X-Gm-Gg: AfdE7cnC7UaOqjeRrGDUSzGuqmBS64Mys5vr2r4Rj/Rl4uXAtGoNKMQ+7MfQOpIh+5X
 t1S2a0pO1MHfhYeoheNpmqQxwatdqT9LhuuleeaYuVc8zSOaVS0CSjtSqjF+CzDOhOo/ncDuz1H
 ae2dOZnh8HdfK2iNdVpp3sf+6/zMnhTIRSCPFi01a0dGclc6ckNXzmAvwwEkZzr51FgRrD4rUR5
 JUjTz/iN35xMopgLJLtVTUMS82ejeizUXWKHDys1sNMSKGw09K7qGwsx0ANJetJTAcgI7sz94Tl
 3lWFhIFyrNqjcdFTHiWJqCF9J9G7fzfumvgO1hagvWqPOU8P1TdPj4TIgzmjAvMML+4Ips54BuB
 ZItbz9KqyLgd8X7xzlUG/iDotNosailLtd1nsdC8ULJB2ODM6WaT33wOfELc=
X-Received: by 2002:a05:7022:3d0f:b0:138:33cc:d88b with SMTP id
 a92af1059eb24-139dbb2eb59mr13264640c88.20.1782738766031; 
 Mon, 29 Jun 2026 06:12:46 -0700 (PDT)
X-Received: by 2002:a05:7022:3d0f:b0:138:33cc:d88b with SMTP id
 a92af1059eb24-139dbb2eb59mr13264612c88.20.1782738765541; 
 Mon, 29 Jun 2026 06:12:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:12:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 06/77] docs/system: Add hexagon CPU emulation
Date: Mon, 29 Jun 2026 06:11:21 -0700
Message-Id: <20260629131232.2487780-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfX0IQN+OygQ4yU
 NbgpNhutTU3moiVvCxiYdvE/AF5OMvVXxKRgyXCewcx5Fb7mF2U1FuLt9Ws1uVOjkxoYzsbesXm
 8S3iAl26tpea8fhuHgFXwoxvu5f7er4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOCBTYWx0ZWRfX+L41z3qdyk5y
 8DZYMcBgV4XdC/y6y0CMMRMWcfhschpfJaASIkfHKbux3irSgDCxVKQajjQkIUDz0tl6aCZtT+m
 Xe+l3EBJEhnE7nvh9xjGPVSxS6McnpZDEy6L12WrxiMKktqjVS8zYFsD0uHGqEHGO4CpYjLCsdg
 9eu9zhug1yYsPNefmiZ0dkdGnnCtjyVPXkU2pI+i2fsMLneBf+TA32rifkOsDDTJNFxrMb7KGTl
 nx2kZmKhpjYyaMPVAu0w9HkM4FkD+Ofa9ZxN48ckSteGdwh0I4vMB0OE/H3mhyMvjEv0sy42dwt
 9uG7rLPpuc/G8280Sq57DUHzL5Aw03Qb0Q28b3LjHk1fpBo1j5Q2MRYvPfI4sQMQnEMQ8j7dNbE
 NxJdyX9Y5VU9q+Zl+6Wjg2PW7td2qyBEmOBA3frgQozixGTpGaf1pcF9w4u/ccXU6KTTp86sXMp
 tVF3iE0Vpm+ymNVgtvw==
X-Proofpoint-GUID: 5h5WG76v0IHGKPJm7EijAfhV9fUHOcWW
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a426f4e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=14gtCLEoMj5qQ5-DTC4A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5h5WG76v0IHGKPJm7EijAfhV9fUHOcWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290108
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdCB8IDE1ICsrKysrKysrKysrKysrKwogZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0ICAgIHwgIDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdAoK
ZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCBiL2RvY3Mvc3lz
dGVtL2hleGFnb24vZW11bGF0aW9uLnJzdApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAw
MDAwMDAwMC4uMzZmNTRmMDU4YWYKLS0tIC9kZXYvbnVsbAorKysgYi9kb2NzL3N5c3RlbS9oZXhh
Z29uL2VtdWxhdGlvbi5yc3QKQEAgLTAsMCArMSwxNSBAQAorLi4gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworLi4gX0hleGFnb24gRW11bGF0aW9uOgorCitIZXhh
Z29uIENQVSBhcmNoaXRlY3R1cmUgc3VwcG9ydAorPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KKworUUVNVSdzIFRDRyBlbXVsYXRpb24gaW5jbHVkZXMgc3VwcG9ydCBmb3IgdjY1LCB2
NjYsIHY2NywgdjY4LCB2NjksIHY3MSwgdjczLgorSXQgYWxzbyBoYXMgc3VwcG9ydCBmb3IgdGhl
IGZvbGxvd2luZyBhcmNoaXRlY3R1cmUgZXh0ZW5zaW9uczoKKworLSBIVlggKEhleGFnb24gVmVj
dG9yIGVYdGVuc2lvbnMpCisKK0ZvciBpbmZvcm1hdGlvbiBvbiB0aGUgc3BlY2lmaWNzIG9mIHRo
ZSBIVlggZXh0ZW5zaW9uLCBwbGVhc2UgcmVmZXIKK3RvIHRoZSBgUXVhbGNvbW0gSGV4YWdvbiBW
NzMgSFZYIFByb2dyYW1tZXIncyBSZWZlcmVuY2UgTWFudWFsCis8aHR0cHM6Ly9kb2NzLnF1YWxj
b21tLmNvbS9idW5kbGUvcHVibGljcmVzb3VyY2UvODAtTjIwNDAtNTMucGRmPmBfLgpkaWZmIC0t
Z2l0IGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0CmluZGV4IDY1ODY2Mjk2NzI0Li40MTZiOGY3YmU3NiAxMDA2NDQKLS0tIGEv
ZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CisrKyBiL2RvY3Mvc3lzdGVtL3RhcmdldC1o
ZXhhZ29uLnJzdApAQCAtOTgsNCArOTgsNiBAQCBpcyBub3QgeWV0IGltcGxlbWVudGVkIGluIFFF
TVUgaGV4YWdvbi4KIEhleGFnb24gRmVhdHVyZXMKID09PT09PT09PT09PT09PT0KIC4uIHRvY3Ry
ZWU6OgorICAgaGV4YWdvbi9lbXVsYXRpb24KICAgIGhleGFnb24vY2RzcAorCi0tIAoyLjM0LjEK
Cg==

