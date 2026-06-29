Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4F7C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39A-0001YR-A5; Sun, 28 Jun 2026 23:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we396-0001WW-Fy
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we393-0006CK-Ek
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cwxA1549989
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=; b=gQ
 Xjrt3+HPT4WmhIvw6UGg5msEehI7demWlj4t2vMrO3oNAKnHx57i9Jvfo7S9mANm
 KvlIQkb8nI3+esPZhWdiZ34XeY2V+OD1smSuVo3qTiSWlPpDdW/ya8UJSQtBmzAu
 EHh2oQTdVOVy2GPHoWBBlbwsPYSKiXf2qbAZ8hNyn0g2mVecClckop7IVBfgZYgB
 dllyufnws8yDO/LoKE3KQd3AAlh4iMOJkg3ftZ4Y6NaRraaAn1lGgFMJs7AM0VIr
 wYs+hUBLTI4WGykBGESgSXXJVtp8m9covGS4vZ6qQLL0Nfso/Mg2c+EUbgRXJx7Z
 5pz+eP0C3dUjmfMeJoWQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8mdqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-138acbc0e69so14149828c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705531; x=1783310331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=;
 b=CcqqSffwZUgWaGGHY5StnPc2gBy5jq0FchNnHMTwGKa8KnRZH/a2ItTzFzsGtw+uu2
 DxSmE2bYZpg0XagyQgclPtzo+YxsRxazvVURSvpspNwz8wpY+UCFt8l9W+nZkwe/P/7C
 ZRRxDCDysDayOxxhKlbd+H8M2ajNDYORiav3iSnOYnu0qeMTSYUr/9CLROsuJb9UKDbs
 sJkYbdj2vt9O8xFtopJRIibzw2Dywjehgna1Ipx4qZBxG4zFnN2qyujTSoGuleAUrk1b
 u4rM/cXtSkx4r/L3yZbAWSOH/S49Ek99F0ZsKxJYEHNdBgHxtlkmoIy+UlfW21fzCTpL
 kgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705531; x=1783310331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IkxVmrZuFWa1Fs3sFSDNQQouCUhLSalQWx3BbBytT1I=;
 b=r/FoAbP2sNFBRyLjs7QUMMJqEjZ/QlGDRsHR2iK3MW1QUq4IDJe8vhYUmeAseCZmIx
 9eBrkhN8w/E160LYIwPqY8qDNz5IjdcE1kRliIKeny4PgDATVLXLqdDQdqhwhgI80n42
 fuiVRHW36rKRiH2XwEJonD1sU5GAYZmBKpuURgmT6oxPJI7NAlOf+6d7616f8f4dHej5
 wBcqLhHI2UH4FIkS0cbpo6HCcmRH3WMQc30GPtEwBAiZAoiEpEsxslRw+F3qZZxDAPop
 q9XgvfbwZKvMPcMg173GhVl8fwYGQzRpk/40+a94ftcHzmQcxEyckWcS0ZShcnu+Q7L1
 XVtQ==
X-Gm-Message-State: AOJu0YxGXPbs+ITf6QModlHoFM6JBihtk6BlmUegsUz82dt6rZRLVio/
 rM6F7wzQAv3o7siSwSBQpYI4wCtOYLdQDjWxhc0npUc0967qCqL6cXjq0NPrb5uKlWptbfQzZGS
 l1Njd9m0ZvyWxk+68ytX7YhTN7z11WBnTUZubTHdo+8jpihJhVXeZfDqnXM1kPZLCkw==
X-Gm-Gg: AfdE7cldyuL1qenEx1gjdEpDICyB2ahFscrqF7ipiKQ8Y4828M7jxeZcHdCORH1CDAJ
 x8WxWoCDoe3nynJ9gyCfBE96hzPZcUxdatXTtfajYGL7pxvozUDzVNkzOrTPuwMgs5JSmyriocc
 ZZjVSl4QcEPg2soAgxOxN6bv2bL9f1fY+/ox33A7odXC9MgZcbTwR6jzre4zYDoeVc6iWEEbY+w
 zOa9yFO6Tx2dsNYepfXuWqCRhXngaosSiB8sEWsVLhoO6KeTLYHYAaE9wuPjg+Az/fPcfgibGHR
 JVO0WALi/yvH037FnijCBDTihj+Pqf4xXo3EgjZ756hLOwHZdVKdwqNBnPjDAxo1yiLiOHh1gsy
 rI6AzQ8tWDumYfJLx/mveq1BY35Fm42hOvj9h34LdPPBISOfDbSAvtZmU5X4=
X-Received: by 2002:a05:7022:5f14:b0:139:ed5d:1b63 with SMTP id
 a92af1059eb24-139ed5d2271mr3824541c88.49.1782705531455; 
 Sun, 28 Jun 2026 20:58:51 -0700 (PDT)
X-Received: by 2002:a05:7022:5f14:b0:139:ed5d:1b63 with SMTP id
 a92af1059eb24-139ed5d2271mr3824532c88.49.1782705530898; 
 Sun, 28 Jun 2026 20:58:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:58:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 07/77] target/hexagon: Fix badva reference, delete CAUSE
Date: Sun, 28 Jun 2026 20:57:20 -0700
Message-Id: <20260629035830.1520296-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX1MmKr2OHlwZo
 JdPGdVDET1FjY0/QfhjwdM+oqn/o3NH+ckZcUZ7uv1QAMvBTe7tisWQV1YBmtahCvCQVpjGxdBX
 3Q3O54C5LqcfUtlHyXVz0bAqLnxBdS4=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41ed7c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=YHbvUooXmMNqKe3LDhEA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KVADGXljVLOyiHcR4-7ytZaNN_4xevJG
X-Proofpoint-ORIG-GUID: KVADGXljVLOyiHcR4-7ytZaNN_4xevJG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXyhhTydPFnVNg
 6u4qzGJl8fQqoSegvh+WdCiTyuvdykRTZIbwWVl2WVzXacaCShhDji2P/6VnoNJQg2SdUypBRVU
 rm01sDUXggZbXnloaVhzOBzrTpnnc1sk/j2IgJZaXUIT9jzQFQvnYMYTSKCDq7+9CCarH8gyhqH
 +5gn4S0f0P0tSVJnn1VvePZ3H+8EldIynimmGOlLskpiqHltVsy8O6iqt5x0YFTtDx8jgb+2o5v
 A7KyfocT2jqXHtHaODkhrM0gTmW/PNsVGdHwG/SmnLB9lqotpS/CBDzCiZqfCCmeA+7Yiyl6D3k
 4Mxfp+io+MDQMqkCmpRKCQorr3apPFTzkgU4OBXVK6Nr1emZnROxLb0xDL+ruF+1nZ59jhxK5I0
 SIN6zz2XWJulzHJ0E2nawyYhpD2wFcgY8MqeJGwqumdt6JLv7p5MYCfPWMv+LHezjffFJr0ecC/
 daOSvPtxPox1km3s9zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQsIHdlIHdpbGwgZHVtcAp0aGUgU1NSIGluIGEgc3Vi
c2VxdWVudCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgMTEgKysrKysrKysrLS0K
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAy
YzUzZjJjMjgzNi4uYmQ1NjhiZGQ4NzEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0xMTAsNiArMTEwLDE0IEBAIHN0YXRpYyB2
b2lkIHByaW50X3JlZyhGSUxFICpmLCBDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSkK
ICAgICAgICAgICAgICAgICAgaGV4YWdvbl9yZWduYW1lc1tyZWdudW1dLCB2YWx1ZSk7CiB9CiAK
KyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorc3RhdGljIHZvaWQgcHJpbnRfdF9zcmVnKEZJTEUg
KmYsIGNvbnN0IENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQgcmVnbnVtKQoreworICAgIHFlbXVf
ZnByaW50ZihmLCAiICAlcyA9IDB4IiBUQVJHRVRfRk1UX2x4ICJcbiIsCisgICAgICAgICAgICAg
ICAgIGhleGFnb25fc3JlZ25hbWVzW3JlZ251bV0sIGVudi0+dF9zcmVnW3JlZ251bV0pOworfQor
I2VuZGlmCisKIHN0YXRpYyB2b2lkIHByaW50X3ZyZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRl
ICplbnYsIGludCByZWdudW0sCiAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgc2tpcF9pZl96
ZXJvKQogewpAQCAtMjA5LDggKzIxNyw3IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fZHVtcChDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgRklMRSAqZiwgaW50IGZsYWdzKQogICAgIHFlbXVfZnByaW50Zihm
LCAiICBjczAgPSAweDAwMDAwMDAwXG4iKTsKICAgICBxZW11X2ZwcmludGYoZiwgIiAgY3MxID0g
MHgwMDAwMDAwMFxuIik7CiAjZWxzZQotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ0FV
U0UpOwotICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQkFEVkEpOworICAgIHByaW50X3Rf
c3JlZyhmLCBlbnYsIEhFWF9TUkVHX0JBRFZBKTsKICAgICBwcmludF9yZWcoZiwgZW52LCBIRVhf
UkVHX0NTMCk7CiAgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVYX1JFR19DUzEpOwogI2VuZGlmCi0t
IAoyLjM0LjEKCg==

