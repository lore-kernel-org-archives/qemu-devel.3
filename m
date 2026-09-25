Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFC0C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAB33-0004Sn-MK; Fri, 25 Sep 2026 14:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1xAB2z-0004SC-Nf; Fri, 25 Sep 2026 14:53:26 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1xAB2y-0005tu-2B; Fri, 25 Sep 2026 14:53:25 -0400
Received: from pps.filterd (m0409408.ppops.net [127.0.0.1])
 by m0409408.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 68PIrG61290702; Fri, 25 Sep 2026 19:53:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=apr2026.eng; bh=eqBIAl38M
 /OEu4eO1Fj8LDUOJqq6C8DkO4bcTvRYIjE=; b=JoWcXijtZJ+QVwgiezu1b4IC4
 A+oSDiIRWk79eYnKCSi9FBsn21LkoMnSpmIctoFyroyMjRV5QfMEiv/I/EFyh77H
 NjqqFVjReJAFrQ7n3j3kQw1K2Rsna2ZfXf53PNBIj1RewDlY6qW35kS5kgrqPH7D
 uQnvi02lhT1l5RMf1E1OvXnXzxJ8jXo/wJ+PPpPZoBwa+LYUSaPMFzHs3PRU1eMl
 kTJZVRTWS4txhjfCMib/KGNHAEjbvbmMWuKGj5B5llErFNXrsmgOt0aHRNg+xW5F
 Ef8xBZ5nDZWWfFzhfYq+b+N4HSCRTM6mlmV0jPTKAri8rRdWo2pNgKkb9rlKg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0409408.ppops.net-00190b01. (PPS) with ESMTPS id 4gwqgnmc61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 19:53:16 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 68PIqFk7015744; Fri, 25 Sep 2026 14:53:14 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4guw1qdwpr-1;
 Fri, 25 Sep 2026 14:53:14 -0400 (EDT)
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.220.254])
 by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 8AD7397;
 Fri, 25 Sep 2026 18:53:14 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
To: stefanha@redhat.com
Cc: ebiggers@google.com, hreitz@redhat.com, kwolf@redhat.com,
 nsoffer@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH] file-posix: add statx(STATX_DIOALIGN) support
Date: Fri, 25 Sep 2026 14:53:03 -0400
Message-Id: <20260925185303.2218703-1-bchaney@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922154351.226540-1-stefanha@redhat.com>
References: <20260922154351.226540-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2609040000
 definitions=main-2609250075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX1SWKYDM0t9wP
 Jr2silk5OTlkuHW3RG5XzlZwQuSF2umImsKOTp3foZo44E/73iTyD3E/+5TJELUZJScn7ZxTwMM
 YBiasMMI2fSTMxAulurcUwvj3VPdE5I6NEmiC1jDNMcCwbL8bSPuU53lmBmkj5j6tIlTFIrWKiF
 D35OAzKPWbXvz/586jXd5NcprdB7kd5a23R+M465BFLNC1hMDXDwev90hW8ewQvqZ3zmZQhHN5y
 cLfgkp+RS5xSDx6ixwoOlz7xBYbefxwKeDDaRm8dLxwv9WQ4SEKT3eilwyz/kOOMC66kS94AGtQ
 iC3GdbBofWtaDnBSOvDECg0l+5vZOu4WqRi1bEU9LFkwAze2RzfdzhEFkKK8zck37IYwDv1nm0c
 zGuim/y4d4kSrDrynlmzRn/mt2noSwgh7BI/E1Tm66yvcHU52dbgsGuD7xyvpz3U5l0/cCgNFBD
 JwoTdIKGTr54pGib7tw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX2yvr6RRaL6Uc
 nmym1caqRvuY7PUHEcysOx9xDx/2gu8j2LLqn9fD5ToJpHC3EBwE0mSZftm1GjgPJie50jWkBwj
 jhOqwqM34EsVH5mOyPbJmZosISGsnnY=
X-Authority-Analysis: v=2.4 cv=AbckjHXG c=1 sm=1 tr=0 ts=6ab6c31c cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=BYUV7c42er6_Rx9bq0XK:22 a=p0WdMEafAAAA:8 a=X7Ea-ya5AAAA:8
 a=G1GFQtNWi_rV8_KDm_YA:9 a=jgk2pzAlstkA:10
X-Proofpoint-ORIG-GUID: 5xOFQFxUolonWM50mnF2wLM-ch4OEIyG
X-Proofpoint-GUID: 5xOFQFxUolonWM50mnF2wLM-ch4OEIyG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250075
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1290

We encountered a similar issue and this patch resolves it for us.

Reviewed-by: Ben Chaney <bchaney@akamai.com>

