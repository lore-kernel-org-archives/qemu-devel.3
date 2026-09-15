Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D20FC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6W49-0005yF-29; Tue, 15 Sep 2026 12:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3g-0005u9-Q8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6W3f-0003ms-6q
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:31:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAT8F4176137
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JwcyVV0Im3vuhgFNU7i08puH9HDt/9zr+/Z/bFI5GJ0=; b=cXI7DjvdC5jfZJbQ
 uuXyWTUOhGn5RRZOVTRIjds/6w6ANwzj/ol9LJL+IuZrD7ORlEk6DchrW8BIaUxF
 IX+Hj6s78p7I5X+Cv/pRPasdTE5HRv9rLtGjOvQqHaw1qWyNY0ksPxy1Vi23GJxF
 /OjPf/jTatcHUbEajbBt+cC7pvGK7mvyGKb53F/C44Cu0ZmvRZ4WDv0tG9H7//GU
 lzp1LoZQZRjgBCyfUHoP5wAj7AhkvT8HFgfxVtKgCTEARhmAF/4NA1oAFC62ffRI
 BuKzqTo2QQ2Wrk/zlrf2kWF9OwJpGXY2iWfu9+6le0b5pFK+mQSNI7reQCjbc8UZ
 R2iWIA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc2dfn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:30:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39e087a18deso1363587a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789489857; x=1790094657; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JwcyVV0Im3vuhgFNU7i08puH9HDt/9zr+/Z/bFI5GJ0=;
 b=ieYGI4jt2+hkwAYfdqfYtHkEV6Af0i15YHXUBD3WTgcaR8/VUr9wMlyqU8xsRp6JUg
 r1i5jMgS5PDVPTfmKsjh//CsAVEASIQMJOVtIOjsoA5lK603fdB2nAbAusUV1tlG4jt0
 fMik6EIg/2KZSTPIwaPZna5oSWoj2A+61OIlaSi+jArDxz/3J3nZovWyK8Ri5uoPOyfx
 2xbyXSvOqBuRimDn1wkLCYUROpRmqU0wL+xggdS5CYsAaZNF4piXosDoELOn96SDl1d3
 fQ8y/K3b6r/cpuYzymqrmnXIwN0ElTMqERYd6GKgSdaPTNQdWwIJpkPr2h1YL8RKFZhB
 0CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489857; x=1790094657;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JwcyVV0Im3vuhgFNU7i08puH9HDt/9zr+/Z/bFI5GJ0=;
 b=kS+ECnXmNzxqiL75GJxgNpk/mrMOdtpBzMZMazAcnt1UKoYNgljU6QIKVUpAWnz8GH
 gghxx6wLkhu3LMA5b9PKL3u027KEps5F6mXTFZe61yZSoGu7+d/oyliRoAUE41ZdIQJ1
 1Z967YWwfey+TUkPAMe1WU9gGnA++kGgTunZGcDueBxTN9B5d0+gFzm4qCXdlHyaLd6C
 3Bvr0gX8KWLsDOFHIAIC2JRWBBeR6eXmqfaLDaEuwE371bE7q6uMfZxH0idt6fqsMAqS
 AaApWwR/SlEp+3Wzf8FCSEUYru4JZYUkvVAerTL8r1oKxyx9Mulos0EZ6JgJCDUfVHqw
 kc9w==
X-Gm-Message-State: AFuF++njRQ7AcqyifxYeBWxhzwPx8INmuOuaO9BY3fU14A7EcR/r/OX8
 A+8KS/ahOAgwSP7EqWy7J5v1SEoMX2bng+5AGaBxsfOoPzMhBGz+kJsNR+oZnOCMB2fjujcxs6T
 MjqESnPcTll0hfJSAZV9lyF1RCBcGHAxS/T48L8bZTHd7LlNXT8S8dPNGuJW5/8vF6w==
X-Gm-Gg: AYBFou3yjloYx/g9OAZgOf6AOHt7Gr9PI/EiJpXuiw59K2XipgHgIr8J4Z4g/SZ5los
 pPDV6CDOuJcLJK0c2I+Po5eWk7P/GYc7ldppWYfS2yeW7qtlU/GnK0mGiXbw0eo6CfuXQE8jEfi
 gN18LmEg1OmMNNWQVANBNVJrckauau2NwEhQGf6rjb5rcGFNpYaiXH4QlmcEvJzG0Zne/PqHVw0
 /PAiN1lIL5vbnkwSZR+FTc2bHCb+YDoJzT3L9eCdoL6V0fl6+JCHwf8K0eZQdAt3MpGbR+qg/bi
 Ynyu1m1clP3ftVjCI5GKYNOiq9V1heDhddR+CMt+E1ziPzUcR/f7leMrWd0nmaf/ZYHVrFzSBkW
 xiCsSmi9RIklFIOApcJ9LFSqCL2WhpUnNLwnb10hHTe9XATHb
X-Received: by 2002:a17:90b:274b:b0:39e:d2a:e25a with SMTP id
 98e67ed59e1d1-39e0d2ae7c0mr4017906a91.13.1789489856905; 
 Tue, 15 Sep 2026 09:30:56 -0700 (PDT)
X-Received: by 2002:a17:90b:274b:b0:39e:d2a:e25a with SMTP id
 98e67ed59e1d1-39e0d2ae7c0mr4017839a91.13.1789489856409; 
 Tue, 15 Sep 2026 09:30:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdd0baaasm6068590a91.9.2026.09.15.09.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:30:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 04/17] tests/tcg/hexagon: fix undefined integer overflow in
 v69_hvx.c
Date: Tue, 15 Sep 2026 09:30:34 -0700
Message-Id: <20260915163047.4180600-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
References: <20260915163047.4180600-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: bP9GnjSMNwsvN3xK4MizkepkkOpfLOZ_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfXxkKZ5vllkC0B
 MD3ejPlR/TV5dvifYtrrBA0/1khplQaAXnUoYgMAovibcsYniYN4RAUHR7IuOlOQ0RwhVU3brc6
 rH8fXY+p4T+hOYSHy9dfNUEv4Zz/M4A=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa972c1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=hLQBpLl1in5vK7AdPdsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI0MCBTYWx0ZWRfXxWnFk6LnpR+a
 9UZ1ZHyVUMe95NjxOO3afStKGErOGEgAzVfPxcLUUYJioJw0hge1m/tNuRBBpMMBIKQS6O58alx
 gDY/QM2enD54rbDogIuozTBoXNHyivtuOHG3xhnuJrjIAyDbuiNUxsFJtawY8UU3Gz6of+nD31C
 9IMDWmwbvpWN06Yu9AW/vCLa1f+d4m5095nwen+cDyE0tiGpRnMQp3iyUSPK8g7b6FB6izDrBGb
 Vt4WH8ArMYO9JOLaF7KTym4G0bgr33aonelmYWAXZLgYiSI4Omt2Yl89QwlUjrBHMnF0Y2GIhaO
 T0QagXx5gfbxszj7ci4uJPgGtpQANamPOfU2t29q1DRUME4tUpSZJg05uQha0uq634bNdqgE8EP
 tIDA4lmSBHg4JwsTjzHqgbjwihuNOQb7DOODTYSb9c8hPzqw738LJLNWQsJub3ApWMwV0sj7Cim
 WClFk+XrxFO2kbiBFKQ==
X-Proofpoint-GUID: bP9GnjSMNwsvN3xK4MizkepkkOpfLOZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150240
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

Q2FzdCB0byB1aW50MzJfdCBiZWZvcmUgbXVsdGlwbHlpbmcgdWludDE2X3QgdmFsdWVzIHRvIHBy
ZXZlbnQKc2lnbmVkIGludGVnZXIgb3ZlcmZsb3cuIFdpdGhvdXQgdGhlIGNhc3QsIHRoZSB1aW50
MTZfdCBvcGVyYW5kcwphcmUgcHJvbW90ZWQgdG8gaW50LCBhbmQgdGhlIHByb2R1Y3QgY2FuIG92
ZXJmbG93IHRoZSBpbnQgcmFuZ2UuCkZvdW5kIHdpdGggVUJTYW4uCgpSZXZpZXdlZC1ieTogU2lk
IE1hbm5pbmcgPHNpZC5tYW5uaW5nQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4
YWdvbi92NjlfaHZ4LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL3Y2OV9odnguYyBi
L3Rlc3RzL3RjZy9oZXhhZ29uL3Y2OV9odnguYwppbmRleCBhMGQ1NjdkMTQyZi4uZWZmOTM2MDY0
YTAgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL3Y2OV9odnguYworKysgYi90ZXN0cy90
Y2cvaGV4YWdvbi92NjlfaHZ4LmMKQEAgLTI5Miw3ICsyOTIsOCBAQCBzdGF0aWMgdm9pZCB0ZXN0
X3ZtcHl1aHZzKHZvaWQpCiAgICAgICAgIHBvdXQgKz0gc2l6ZW9mKE1NVmVjdG9yKTsKIAogICAg
ICAgICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDI7IGorKykgewot
ICAgICAgICAgICAgZXhwZWN0W2ldLnVoW2pdID0gKGJ1ZmZlcjBbaV0udWhbal0gKiBidWZmZXIx
W2ldLnVoW2pdKSA+PiAxNjsKKyAgICAgICAgICAgIGV4cGVjdFtpXS51aFtqXSA9CisgICAgICAg
ICAgICAgICAgKCh1aW50MzJfdClidWZmZXIwW2ldLnVoW2pdICogYnVmZmVyMVtpXS51aFtqXSkg
Pj4gMTY7CiAgICAgICAgIH0KICAgICB9CiAKLS0gCjIuMzQuMQoK

