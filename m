Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2510ECD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Bl-0003T7-UV; Fri, 29 May 2026 17:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bk-0003Ru-7G
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bi-0000PJ-MU
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:19 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIdxUb203453
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=; b=eL0MwuejfRTiDK27
 tNPTpY/Cu6p+fQXtrVt3zeq9STTP7RhWzTqtDAZ69XqLKjV6ipFzyZNYF2n2LWBK
 GJpvgpKpxjdei3u81W9atJBpbW7aJzkQ5pVPKHtZ7Gr0SRKluDMHff5RqC1FAKQG
 1PoL9Qql73/IifX99Fgo/+tvzsWfQauFL0MqZTCHQIgEWKdCJGGsCh2TVECHAv+6
 WtyI3MZZKgR19EGtWbQ7HTdCfZMzQhonNbhY8MZ9Lfq+PENn7GMkN+gqD3YZZq50
 TJt4rUEZeFFjhPAUmMUAgLGFeU/yPAphiyB3UvVmNlHN0QVOx4lm9axaqIuLfAmD
 NWXAwQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg9c8qxu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304d8e9563eso956320eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091777; x=1780696577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=;
 b=GRsQBAf4iM9iNhsiOA7IpY3n0hUrLw67IS580hsmyWb/mHZBS0coOOKBzPNUhL1RLe
 ngVfGvVgCRAVESHFYb5QecR6XNxUiJT7C7K/8ePY+6CC7TNnsaaJG4zS8feU15tvrqr7
 mvTUBzvkYO2oC1VH4/jXf3YTo3iB12y6sSaK8BqKwhIRwP4DajBchdmp/KZVVooqfWp+
 phR33dIgq2x65zikF2MBV+QZkJHHRTWwKJpXKnyBdxDhimugzXrWP651ysObm4yCtHZA
 2NAUD2+updQAWpRaMfzUToFD0Z89hP9Ni2k98dLrkECwVkD8c8cXRxEia67bRYTx5mc2
 /GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091777; x=1780696577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EH4slYrH2tAurnh1B6qm7AwzqOtD9xGDq2yM4ABUAzo=;
 b=D+Ti8R9JGMF/pN0AvB/wk892523bSsE1dqA6Iunc6pXb0z+SMztUsmANTyXVs+KxLe
 mqX8bQyMjwfrOZg5LGT65WFjqt7ELVtv3J4sXfgHrrUe9z67vnFODuLybFVTvuHrP4LT
 8hG3fgbsbcELP3yB9WJUCKXD/RrNsBjaZJNuYcqZuMXrvTrvFOrDT/DPsmc5X7xSXs5W
 xvS3pd3IPehw5NxHH9actyHJu4ffmKGuOODStfDMd9IOikkivGOlbJRVfjkk4Y4DyBnP
 dBrFBndsaUwBe9Ro0UzukYgm1XzNLvJtZPnOfXeu3VRpJB9YAKSQ0FbUnZMHM3wIKGVG
 7wjQ==
X-Gm-Message-State: AOJu0YwOY+MpdjPVPxXM0IRDgGe8T3v8yZ7zlFqy/YvV1r8fjuR69P5C
 FzqdXyOkjAByAcYBoXcRdRY+/yADMpFCF4FVS22/bbmdR6PUdIZLh8k1ZyR/RryQAD3L4O+22En
 sA23qctCW9z0bi+Sssir/Nx9cFh4GNVEarFdEGBM7KTN/mQsH3dndL/TSmksrwe8f7g==
X-Gm-Gg: Acq92OE2Pq/NsRh+BQLwKUjbBxznKvygNjH58cneJWByk/5iAvEDmyVoEYcMM82y8Gg
 Oxyikn9VCepNoJPg6gu3MezlXSFAglETUt4gCYnW/FzUBA2ri7YiFg90P/wqQfCgI3IuwN03Cbh
 7q4VPlViLmP7NezayZOTUEjMEbx4VC3500tTuGMHmo6ruOxYR5IPSQRob/JEX2Ry2urmzvRYdF3
 aaBDr1GGx0/JGm3vKMJ8SMUqDLE1/8HkfWs/maO3cbLhdQLXLqN6OziOfJ8SLvuUaNOYIaTNIFJ
 45llBXiMHClDvS1Y4bFnCEQ+bVXxPWEGI5bNke30R+RVTad3ZUgpRR0XHLeSK7PUc0EXzyFoYg9
 kDL7dQyUfr7VSeqt8K7hnO5+r7D6QxbbkEe7aIZiuHpDP48myPqLmNrn8EmcIzQq9myAeUjobdU
 G2Jdol
X-Received: by 2002:a05:693c:300c:b0:2ca:8099:ffc0 with SMTP id
 5a478bee46e88-304fa4a90c6mr878054eec.7.1780091776803; 
 Fri, 29 May 2026 14:56:16 -0700 (PDT)
X-Received: by 2002:a05:693c:300c:b0:2ca:8099:ffc0 with SMTP id
 5a478bee46e88-304fa4a90c6mr878038eec.7.1780091776267; 
 Fri, 29 May 2026 14:56:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 10/38] target/hexagon: Add a placeholder fp exception
Date: Fri, 29 May 2026 14:55:26 -0700
Message-Id: <20260529215554.606133-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOCBTYWx0ZWRfX3XQpqaETTRav
 phIJvRUjrG7Xi/5roQWdoRHX19krWi5YnYD0E+03oVT94o4bZN56o/DuazGVA6KAPdDQU8w88iK
 u36aNLjzU1+TBcUUWzxx03pBL/FXsA+gixHN9aJHMv0n/EP3dSbN0JVfujD8U0iJTITK5mB6DvK
 NyWwfrP3e7E30bVm0GucEzKh1S2LBM7Y4Q969WhKzsC2UoltnTMtx2kg386cyBPV9gI2l4UPcpV
 414PJWoYG0Zszk//FA2Q6+QhDBxB23iQjqF1SS//2E39PNzCc4wpyWWNZ4n2wwBKDo9IZxjFfHW
 e3b2fWJJjIs11pnEDsvCswH8JH1cbjYWKFsu47/PXJmHazyJQBjteovKVJw5jrwsBFG1Kq5gqLf
 O8/qFj93iPC5geHJmavpzOceANk/YRyjKEIHqoPcpXDnEKXsytjA2atTveyqM2XICjKmx/ChSww
 5cO5tmus3/x6TfKLr9A==
X-Proofpoint-ORIG-GUID: 8ev82sczxEVKYwvku5sp4SHjP92IBPPC
X-Proofpoint-GUID: 8ev82sczxEVKYwvku5sp4SHjP92IBPPC
X-Authority-Analysis: v=2.4 cv=SKxykuvH c=1 sm=1 tr=0 ts=6a1a0b81 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=R5LHHePp8dzqxDYlWrYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290218
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Fy
Y2guYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXgg
ZTE3ZTcxNGE2YWMuLjBhNDAwYmY3YTc3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNo
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMDgsNiArMjA4LDExIEBAIHZvaWQg
YXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0ZSAqZW52KQogICogbW9kZWwgaXQgaW4gcWVt
dSB1c2VyIG1vZGUuCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCisjZWxzZQorIC8qCisgICogVG8gYmUgaW1wbGVtZW50ZWQuCisgICovCisjZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBN
WUUpIFwKLS0gCjIuMzQuMQoK

