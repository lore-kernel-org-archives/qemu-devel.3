Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E159CC2A07B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 09:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcgr8-0006Uk-K6; Mon, 05 Jan 2026 04:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vcgr3-0006MI-Do; Mon, 05 Jan 2026 04:26:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vcgr1-0004Vd-RB; Mon, 05 Jan 2026 04:26:25 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604Bj6v5025190;
 Mon, 5 Jan 2026 09:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=G8AOz4
 UijTVIPiBlwKYmV4Gw6y2SvdhHLi/xnUwEXIc=; b=nWWxaK/jSvpaWDAJQi/qot
 wtL7VsWdDLl9YWWXNT0BYC2YC0WtE94abcrunLlv5RrlIKsadwE1r53yNfgGpm5K
 iyK3vuB2Mu/CRxPZK/3HujvoLSvn2ckjrmbL76Jezdk9id3/E5gVmIhkL5mmmm4l
 bWVWt22L10CfRIXZKR73KnAfe+G1xGaEZvF0K0tNSpSZq6HUkadq5UNsOE9oG2pg
 uMq4o+6x8S7HruJA1IJNioQaHzyx0QYVGu443ZYTh5xFgQ7CHYyokGZPZeGLpfpQ
 Dr1p4kWuaHBGLn2Z2KdlkEuUgsYubY00iNHKQgBh6CIJNj5Dhcy1OXUJ0J1kioBQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm6xfu5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 09:26:21 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 6059DbAv000952;
 Mon, 5 Jan 2026 09:26:21 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betm6xfu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 09:26:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60585INg019171;
 Mon, 5 Jan 2026 09:26:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg50vp7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 09:26:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6059QJsS19268342
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jan 2026 09:26:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9EF958057;
 Mon,  5 Jan 2026 09:26:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 551A058063;
 Mon,  5 Jan 2026 09:26:16 +0000 (GMT)
Received: from [9.109.216.92] (unknown [9.109.216.92])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jan 2026 09:26:16 +0000 (GMT)
Message-ID: <5b558ade-e712-417e-8d29-866144194454@linux.ibm.com>
Date: Mon, 5 Jan 2026 14:56:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/kvm : Use macro names instead of hardcoded
 constants as return values
Content-Language: en-GB
To: Gautam Menghani <gautam@linux.ibm.com>, npiggin@gmail.com,
 rathc@linux.ibm.com, pbonzini@redhat.com, sjitindarsingh@gmail.com
Cc: qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20251202124654.11481-1-gautam@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251202124654.11481-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OdmVzxTY c=1 sm=1 tr=0 ts=695b83bd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=mtlxwhp4t4fErtxsobUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EDhIu4lpWDkpH4EejumgfkQ2xmAZ4NDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA4MiBTYWx0ZWRfX2ZXImWrX1bxM
 BsJ6KCMZALRzR4YfUrqQtYtrmzfFhqb5MF7qqPh0rDF6pwD4SC1R1Ck3NeJAZuXPHxZPMCe/a51
 JPjWVtVbbw/Zqh0Bcissu7kS8noIVuFTY+l1SRFMmnInI+H5VahaCbscmjla3siUrEndWukiG/m
 +XnmvlIjvsbMcpBHGOZrsmt1DX5RmQ1C8FXnxWnoP2s2SQl0Fb4bUhX13/EJDna3izdrqdXl6v0
 E5CWoGBQgOkFNfjtpcqqnpVeFzl/0gdvIDfPEFcyDRCLA/36bHGTzp51ZEQCL3CeiwtCnS4RSjr
 BeLf0bO/pRwUIO3QeroGi3XEuMv3DVie+VkmxYY1ljm3DewUchozJCev0w6jeX4S/tTVj0qZTWp
 1/DPUUGwKm4aMHo4092m/kv6bxLGx4KGp1u+gpkejzFlwNmatgfxzFxMsf/9a5ShvYts84L8vZd
 vZqXmt+nbrgjhVSVQSQ==
X-Proofpoint-ORIG-GUID: XyRiKkCmh1xx_rxbZRxRPbpn4BoEd7El
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601050082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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



On 02/12/25 6:16 pm, Gautam Menghani wrote:
> In the parse_* functions used to parse the return values of
> KVM_PPC_GET_CPU_CHAR ioctl, the return values are hardcoded as numbers.
> Use the macro names for better readability. No functional change
> intended.
> 
> Signed-off-by: Gautam Menghani<gautam@linux.ibm.com>
> ---
>   target/ppc/kvm.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Queued.

