Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A6CF483DE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jOH-0003Vn-Oz; Mon, 23 Mar 2026 13:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w4jO8-0003Qg-Pc; Mon, 23 Mar 2026 13:48:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w4jO2-0007YW-Um; Mon, 23 Mar 2026 13:48:24 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NE0CjA768705; Mon, 23 Mar 2026 17:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DEGz5g
 0ADUWkg4bjB4zpV52xRu4fCsWGMG7harvb3IY=; b=qjV9aVGGwaJGPzQ/s08Pt3
 VKuCtXIEEBD2lGPg2IkGvPWdWeHHNn386xnzLGj//sjrWuJA+CCXxvi3whTKC1Zj
 E4PNefIDzyxwbUsKS6OAO3RxND2bKkX9itD8SIANnAy+SX11UBgMh/sqGbI9REXt
 e2eBrBBE/4sEPF2S5Eg2S9/t22yi1f8c5c6a589wcTAm258d8v+srXcva+ka5Ouu
 eS1kYnIvRA7kExYHhlxvOcH29pAIUbYfP8LWC0JVwYEcGuHo1liQyzmdyY4ZttUR
 OXmSURugxO/cNFCgFRD2vcaJIA3iKLhPvSOLmLRFnH6dMZqinA5aLOCaz2xs6qkg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq83q3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 17:48:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NGwpRW008745;
 Mon, 23 Mar 2026 17:48:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nned2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 17:48:19 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62NHmIg064815436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 17:48:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BDA358055;
 Mon, 23 Mar 2026 17:48:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7581858043;
 Mon, 23 Mar 2026 17:48:17 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.71.103]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 17:48:17 +0000 (GMT)
Message-ID: <1f81f942ac8dfd80dbfc7be7a4ffbfcec4aaf76c.camel@linux.ibm.com>
Subject: Re: [PATCH] target/s390x/kvm: Simplify the async pfault handling code
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Date: Mon, 23 Mar 2026 13:48:17 -0400
In-Reply-To: <20260317134531.460141-1-thuth@redhat.com>
References: <20260317134531.460141-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hhilsdr368BYPcqjRdKOxQxGqGXQ_hZq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEzMSBTYWx0ZWRfXyjbigNo9fv9V
 nLkavbZVzRSp6JzqvNV5cPwNk9S2GKavU+3yGflB69bSucwhf+4z+E6uj+QMlUWQQK4CJSOJUtD
 pDiqmIhckGvswcmukEYQMooJz51N0ORjxpHkTMNO5PuLj6ArQVpGxECvTCoavrunFZwV8ePdIoA
 zbRGfBHFq5l0AUWIUdEpauRABDJVGxQZHuanYCJM/gjAahQoE/YB0Il0mFQfb0f9oUGkoZ8iP3R
 hwBZXPgWh+6s5IK/2Fxx7Fa980BDlbL59ScIUZ7PEqvEQMQUjh0rodFzQtfetI7lJje9XogAiog
 N4EQy+1Yy90+3IJD8tc6WfW9x0J+yV3OgVThgMGpr8D1vmCLNUjHJoUbmN2xPEXW6R+1310GIfF
 mZ9y0SEcpQyy+FHujVbDH1Bz/44Cwfro4QX5hOimJvFwKSbbTqrjFSV7ZM2xAanz5sYQgTk0jff
 dF4O91fnHzNKPaniTDg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c17ce4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=1PiBuSbX7Db_E7daJGwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hhilsdr368BYPcqjRdKOxQxGqGXQ_hZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 2026-03-17 at 14:45 +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> Since commit 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and
> KVM_CAP_IOEVENTFD_ANY_LENGTH") we require at least kernel v4.4 to
> be able to use KVM. KVM_CAP_ASYNC_PF is available in the kernel
> since v3.15 and KVM_SYNC_PFAULT is available since kernel v3.18,
> so we can assume now that they are available in all supported
> kernels. Thus simplify the code a little bit by removing the
> checks for these features.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I just found this old patch on one of my local branches ... seems like
>  I forgot to send it out after writing it last year...
>=20
>  target/s390x/kvm/kvm.c | 52 +++++++++---------------------------------
>  1 file changed, 11 insertions(+), 41 deletions(-)

Nice.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

