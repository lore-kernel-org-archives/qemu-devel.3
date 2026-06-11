Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E903CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXyy-0007ip-7P; Thu, 11 Jun 2026 01:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyq-0007g9-2k
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyn-0000pd-VF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GPtH3817101
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=; b=ehWFdv6nA/jYpLbx
 7LIyvlK5zB9uCmC+A6uONztO2e/TTf3zHFhCvHRJOff7uim25k0J+kKpjDlp5xYd
 cUBImvWBK1cYUUU0AOW1wrds6H/qjJqqNhAbzPI4Tmp/vXNAaWqNoqzJxKfBKtnb
 5p05Q/Zr2oro0tbiLjEP0L2YGwwIQ76TcQrjB37lYSBsKK5Z9ZSrnzufuRrzP9Pz
 U6lMD5DjbSepld0+l+X+q2T9ypTy3/nmDoCIqpeGzXuGnvDtMUpUit43Y5tED6/h
 CfjybkseoadggRWjHN7KIKhO+J1QYIMBJRl7pv4vGlVX+/3FIdqQbXL/F+fAiztu
 uc14Rg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6usrq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f1820babso9679172eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155763; x=1781760563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=ajk5L6sZmrV5ZQUONxEuNOwLv24VnM0JSzKBuFE67PBBO2aSmkQ2CFQRsMyA1kUNfH
 9V3XhXu5SzEJ3wmozF3QKdXyAyNQv5YpUHlhQ6QR67h1mkN0kuhAsJfR388+XqDmsNt6
 Q1gfr062GlsMaezBThcJdYil3Vg/t9YZwE97AXjP2P2B139LSiHMfgEzkEPef4TGvJV8
 gRbirFqf/IlsAU0d9xIkUzADmjvpyICwnuIckwzytevCTvN5XeUwSBGqxOzBw938co6u
 VgWACr8/YmIdaFGL/GZyhizbrv4M4ReXXATsCw+Ch1uYqdAdH6BGcZziNyY7e1HrjCN5
 +6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155763; x=1781760563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=ac6BhoVSmcfg79hjbfrljTwt8OoTXWOc109CLK10UzAOpureKUmAha1ebwIaRhJVAL
 /3ZuTswnmkvh5EWOEELSJl5KOiKFwfUEVcWF5OggdbY6HRK6qTtYS0HHbHl/SKKlWvwl
 BUh/2SbC0BTwd7UYUar0OgZ8YJ7BdPMqhIHwnTMYFpqDTd96TNvUeHeJhp/hBSabVkQ1
 9KzXFud1ysFCvU5PNjkKYtOZFOmWvhYpUrQTJdf1l/pQxw9+lN7ig+9GaMsWiPxjhZAB
 P3Tlq3rsNyP7rR6STRPIuNm30KEJ9Km8USHqZre5K9bFfXzgYHNm2qDgw6L+8RiDtz7b
 7CaA==
X-Gm-Message-State: AOJu0YxssyXKsG7LzBGmsZYGzEDxS0zuy7ytqseZX+4RJ3AV8EMJJk+G
 5aFGZAZr32sI27XKgwh8f6AATfAjbjYmwMVvcMnZ0LxRm3X1qwrRe5ShmHOLvNnp2smckJrsRLY
 Pc2mGG+73Scwg0l6hAdXLS7cX2MqM6gdBoq5LXUJyb7MjueKwW5JXzOo/W+GVfSS+xw==
X-Gm-Gg: Acq92OHg8GILbnUUGezY7cjtfd9I/OJcsQY5IkcGz78cuidc3jt/PezjIS9buOvS5RM
 0kE8XUFXCd3nBl4ySAD0KQG8BswF/MuNRLyQCEuK8L6Pei5z4bdwuFGpNAwGOHGIVug8L4rEEr2
 FlSR6HAubCLeY79YWSi+xIfJuIuVu8H6g1Fu/o2/cCR/faMcjuykLHR2Rctlok5sB8vFzJG/C6E
 8soWHJ/vOTBmW9BEwYSM4+56FTtES8ChRI5FfY91x1iyHzl+YgcdMoJ/E6qZLD7Ry4AsOd22Ro7
 z1zzHjUaTRzJbVDXu5Li8XznXiC2RUs0vmeQVIxL9STsVUaQezIAZbLkshlQV5umSOx6V7rErad
 hi69kVdaovT11ornVhwoKWUgzS0YghR7LVCYWv1jtclkSSfSzjjUivsExkHRpUDVejJb774qHUc
 pGsKys
X-Received: by 2002:a05:7301:5789:b0:304:b93a:5107 with SMTP id
 5a478bee46e88-30804bbd409mr933486eec.21.1781155763323; 
 Wed, 10 Jun 2026 22:29:23 -0700 (PDT)
X-Received: by 2002:a05:7301:5789:b0:304:b93a:5107 with SMTP id
 5a478bee46e88-30804bbd409mr933463eec.21.1781155762811; 
 Wed, 10 Jun 2026 22:29:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Add guest, system reg number state
Date: Wed, 10 Jun 2026 22:28:32 -0700
Message-Id: <20260611052857.3911981-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a47b3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ikZfMmNF8Hme0_TNbpMA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX+66nbcaGSKU/
 CrLzPgqZADYYrzPr43spj4GB4l018bHHcnQ/qifCONdqDybZtHxDfyTvTpf9X4/VvyO7JV/2iG/
 SsjchOgD30SVztIGrFlnEkJKeBeaWyU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfXyMCttiLOOkbJ
 OShP3zfNR7SsIqGLRrOoUgC5XD9SJfIZqzMz2tP8M3ff0s5gSjilZt43U2XJd830jztfsid/dVs
 dVCEE7khXjK6zy03gm2RWVEfv8g0iOc2ZWdSOU8BlZms8GIZ7dIPu8ghUnreOfZBGPjn8Wl6BlZ
 ioaTePpwZrfvXFLZftntY9rMsWBAHyajrJ9WDkjveso4TY71S4g8LCfRBeYlEb7bW1tZZz7yahO
 Mgy3Z0CxbDCYKvwhp4nZHrBnB1ELDgnXKeAHrs9irq0sRJJ2yT5/0uR+657t3xGZG8pNeJzmdDa
 n+dlBQh4qb4D/3kHgOirO9vjGDSc2oJr+mOBnbOcmDn2AkCD3NDdafyWmYNc7KiwUFM3zVsC/Gh
 fplFQ7f2yGozNr34W9JQY2vWuMPyoJ26IDvsnOU1KkDttrBqOwYHeJbE9mydXv9lDcvDjnzBa45
 NCian1GGxkwTuegP0/w==
X-Proofpoint-GUID: Lu9qzpW7vA7i5B57i4tzktn63ZxzaK_T
X-Proofpoint-ORIG-GUID: Lu9qzpW7vA7i5B57i4tzktn63ZxzaK_T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgIDUgKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggZTBjZjg3ZTVhNGMuLjRiZWE5
NTNhYzczIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuaApAQCAtMTAwLDYgKzEwMCwxNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3Rh
dGUgewogICAgIHRhcmdldF91bG9uZyBzdGFja19zdGFydDsKIAogICAgIHVpbnQ4X3Qgc2xvdF9j
YW5jZWxsZWQ7CisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIC8qIFNvbWUgc3lzdGVt
IHJlZ2lzdGVycyBhcmUgcGVyIHRocmVhZCBhbmQgc29tZSBhcmUgZ2xvYmFsLiAqLworICAgIHVp
bnQzMl90IHRfc3JlZ1tOVU1fU1JFR1NdOworCisgICAgdWludDMyX3QgZ3JlZ1tOVU1fR1JFR1Nd
OworICAgIHVpbnQzMl90IHdhaXRfbmV4dF9wYzsKKworICAgIC8qIFRoaXMgYWxpYXMgb2YgQ1BV
U3RhdGUuY3B1X2luZGV4IGlzIHVzZWQgYnkgaW1wb3J0ZWQgc291cmNlczogKi8KKyAgICB1aW50
MzJfdCB0aHJlYWRJZDsKKyNlbmRpZgogICAgIHRhcmdldF91bG9uZyBuZXdfdmFsdWVfdXNyOwog
CiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA1YmY2ZTg1Yjkz
OS4uZDMwZTViNjRlYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCkBAIC0yOTksNiArMjk5LDExIEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogICAgIHNldF9m
bG9hdF9kZXRlY3RfdGluaW5lc3MoZmxvYXRfdGluaW5lc3NfYmVmb3JlX3JvdW5kaW5nLCAmZW52
LT5mcF9zdGF0dXMpOwogICAgIC8qIERlZmF1bHQgTmFOIHZhbHVlOiBzaWduIGJpdCBzZXQsIGFs
bCBmcmFjIGJpdHMgc2V0ICovCiAgICAgc2V0X2Zsb2F0X2RlZmF1bHRfbmFuX3BhdHRlcm4oMGIx
MTExMTExMSwgJmVudi0+ZnBfc3RhdHVzKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IG1lbXNldChlbnYtPnRfc3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9TUkVHUyk7Cisg
ICAgbWVtc2V0KGVudi0+Z3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9HUkVHUyk7Cisg
ICAgZW52LT53YWl0X25leHRfcGMgPSAwOworI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0g
SEVYX0VWRU5UX05PTkU7CiB9CiAKLS0gCjIuMzQuMQoK

