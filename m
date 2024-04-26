Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9815EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Pay-0005hW-Kv; Fri, 26 Apr 2024 13:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0Par-0005ac-Qf; Fri, 26 Apr 2024 13:42:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0Pae-0007e4-Mj; Fri, 26 Apr 2024 13:42:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QH3B6u021835; Fri, 26 Apr 2024 17:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YF5uOH/GNrtaDIuRmRlmw/cJ/rSpQWvvo3gbTU3LpSk=;
 b=WmsVQS/xWF5elFPY78gPwmcH+u7MSzBEzqwxxubN1eJ8++Q+TkeS8Nho8fsp3o5tmP54
 HT4lXUhHxh3EMFhfadVUF5Uv7yIp+kc1t+GX8EZaCj8bLsZNLa/wGXdxOadNNWvSJyEw
 eTeVQKoosh1Fjg6441hpeCPJCye5YOsWQGmi+1mClOVI/pmcirFl0zEhK1s+lcyRboDG
 c/xfzhpN74OKBYrmdbHdCBzQsQ1/pA34dNLMwUnald05PPEeb2UmVnift24g19J2sRJw
 wJNoGmnRaSsqzZInA88yDlcmn99bqYTLJSpWKE8ZB6A9nHttWQQPZ72d4SPX1hqiCZ8u fA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgb1r2fa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:42:23 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHgMWO013650;
 Fri, 26 Apr 2024 17:42:22 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgb1r2f9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:42:22 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QGmO9L005355; Fri, 26 Apr 2024 17:42:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cys7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:42:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHgG7j47514054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:42:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E49320043;
 Fri, 26 Apr 2024 17:42:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D9CE20040;
 Fri, 26 Apr 2024 17:42:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:42:14 +0000 (GMT)
Date: Fri, 26 Apr 2024 23:12:11 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 10/10] ppc/pnv: Update skiboot.lid to support Power11
Message-ID: <qxdrovfjtuynb7fbdj7k2xhx2racl6yjuwx4tsjvriorzkxl5k@dfvz2xccyt7s>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-11-adityag@linux.ibm.com>
 <d6850e42-acbc-42fc-a27b-87c10736dd95@kaod.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d6850e42-acbc-42fc-a27b-87c10736dd95@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9HLM3PsEMeANP-FQDFJCAISdUgCzfWPg
X-Proofpoint-ORIG-GUID: C21QvLF4M1l2D2baiwwRjz80WsWIcNW3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260120
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, Apr 26, 2024 at 04:38:13PM +0200, Cédric Le Goater wrote:
> On 4/26/24 13:00, Aditya Gupta wrote:
> > Skiboot/OPAL patches are in discussion upstream [1], with corresponding
> > commits in github repository [2].
> > 
> > Update skiboot.lid, with binary built from 'upstream_power11' branch
> > of skiboot repository with Power11 enablement patches [2].
> > 
> > ---
> > This patch can be skipped for now, if need to wait for patches to be
> > merged in open-power/skiboot.
> 
> yes.
> 
> > Have updated the skiboot.lid to aid in testing this patch series.
> 
> Thanks for doing so.

Good it helped !

Thanks,
- Aditya Gupta

> 
> > ---
> > 
> > [1]:https://lists.ozlabs.org/pipermail/skiboot/2024-April/018963.html
> > [2]:https://github.com/maheshsal/skiboot.
> > 
> > Cc: Cédric Le Goater<clg@kaod.org>
> > Cc: Joel Stanley<joel@jms.id.au>
> > Cc: Mahesh J Salgaonkar<mahesh@linux.ibm.com>
> > Cc: Madhavan Srinivasan<maddy@linux.ibm.com>
> > Cc: Nicholas Piggin<npiggin@gmail.com>
> > Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
> > ---
> >   pc-bios/skiboot.lid | Bin 2527328 -> 2527328 bytes
> >   1 file changed, 0 insertions(+), 0 deletions(-)
> 
> We avoid sending such big blobs on the mailing list. We usually send a
> PR to the sub-system maintainer (Nick). When time comes (support is
> merged is skiboot), we will address the skiboot image update in QEMU.
> 
> C.
> 

