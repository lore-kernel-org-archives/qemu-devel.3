Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42A4C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 03:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbu3n-00005x-Nc; Wed, 07 Aug 2024 23:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3k-0008I7-68
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3i-0006j5-5f
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:27 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477Jgrg8000812;
 Thu, 8 Aug 2024 03:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BJT05EIgG7eDxCRxMAeLcJUcYubz8A1PsCsWpoQUiVM=; b=VvAnjQjMJs6gW+ue
 Cxun44iNIuPZeuPCvg/9/GLsM2nv1TNSNpQp7+y/lQgUp3aIkDIReK3zZPbUiYYV
 QzfrpKLU4X3JgyjnLoXGJSAObb0sy9K/wHq4mrCujmxovd9ZR1c5Czy5ttAFOtV9
 7Qy2zDcZj4sX3m25K78e8VsyEAoMI12ckFDWgprVLcP8V8BP8iS6gq5vCyqUCmcz
 kGuyxjhvpemVHPN4QVGxcOHmMxrLhgjKYpgoAos29McPPVYuEJdc7KpS2K+YMa/7
 LsjLUtyJadzhqhrErcJYTQDhxm0rsEoezGo7tKGbKQB6Ik6WSZAz2i0jI9PLQzbx
 CzWv+Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vfav0tm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Aug 2024 03:43:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4783hL7h000447
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 Aug 2024 03:43:21 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 Aug 2024 20:43:20 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 3/6] target/hexagon/idef-parser: Remove self-assignment
Date: Wed, 7 Aug 2024 20:42:41 -0700
Message-ID: <20240808034244.4139757-4-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808034244.4139757-1-bcain@quicinc.com>
References: <20240808034244.4139757-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: _-osiUFGwpxwcoPdZq9TvVLEfUYD-HKr
X-Proofpoint-GUID: _-osiUFGwpxwcoPdZq9TvVLEfUYD-HKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_03,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=651 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080024
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KClRoZSBzZWxmIGFzc2lnbm1lbnQg
aXMgY2xlYXJseSB1c2VsZXNzLCBhbmQgQDEubGFzdF9jb2x1bW4gZG9lcyBub3QgaGF2ZQp0byBi
ZSBzZXQgZm9yIGFuIGV4cHJlc3Npb24gd2l0aCBvbmx5IGEgc2luZ2xlIHRva2VuLCBzbyByZW1v
dmUgaXQuCgpSZXBvcnRlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPgpTaWduZWQtb2ZmLWJ5OiBBbnRvbiBKb2hhbnNzb24gPGFuam9AcmV2Lm5nPgpSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+Ck1lc3NhZ2UtSWQ6IDwyMDIzMDcx
MzEyMDg1My4yNzAyMy0xLWFuam9AcmV2Lm5nPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
Y2FpbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBh
cnNlci55IHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkgYi90YXJnZXQvaGV4YWdv
bi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55CmluZGV4IDlmZmI5Zjk2OTkuLmM2ZjE3YzZhZmEg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkKKysr
IGIvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRlZi1wYXJzZXIueQpAQCAtODAwLDcgKzgw
MCw2IEBAIHJ2YWx1ZSA6IEZBSUwKIAogbHZhbHVlIDogRkFJTAogICAgICAgICAgewotICAgICAg
ICAgICAgIEAxLmxhc3RfY29sdW1uID0gQDEubGFzdF9jb2x1bW47CiAgICAgICAgICAgICAgeXlh
c3NlcnQoYywgJkAxLCBmYWxzZSwgIkVuY291bnRlcmVkIGEgRkFJTCB0b2tlbiBhcyBsdmFsdWUu
XG4iKTsKICAgICAgICAgIH0KICAgICAgICB8IFJFRwotLSAKMi4zNC4xCgo=

