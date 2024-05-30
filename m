Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5125C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 08:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCawR-0002kV-LV; Thu, 30 May 2024 04:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sCawP-0002jg-Hg; Thu, 30 May 2024 04:15:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sCawN-0008Uk-Pv; Thu, 30 May 2024 04:15:17 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U7hRWE026166; Thu, 30 May 2024 08:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=k8tsVdbpNb/XBEtXM7VqJ0EHx1bapJh1FfW/qFLeD2A=;
 b=QcUAz6+lRB1MA/Zo4mdqnev5NHMhirj43RQ/WjURLB/EyVYC9XSrUgTS6RqZHo6ffeqG
 qUC3go5EeTSDU6D824Alkk/eT+9AD+y7W4BsSzK9N+Gz+9CSBqDZll2O20jS00fUpUqD
 k/cOhxVqk6I8CB/UyCS244X8LVAYlFKKNE7V7EsaJT3TqJ9i4ZJEGYFOQDoXza549TgS
 5ZdzntDAEi6jBdy1YhCAPKObJI4WB6jc8t7dkFOKej3sgoLcaeTIYrvMXkwgfAyA3wKH
 iOys/xl4Mn5t1CZqiUor4ToUYNGyvgYXLA2txvOcnUxZ06su2wZNJVabtqiWpXS4kMlj zA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yena2g3fx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 08:15:01 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44U8F00p024618;
 Thu, 30 May 2024 08:15:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yena2g3fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 08:15:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44U8ENjp009806; Thu, 30 May 2024 08:15:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ydpbbrt4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 May 2024 08:14:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44U8Esfe36307210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 08:14:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 849BA2004B;
 Thu, 30 May 2024 08:14:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB0BE20040;
 Thu, 30 May 2024 08:14:52 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.72])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 30 May 2024 08:14:52 +0000 (GMT)
Date: Thu, 30 May 2024 13:44:50 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v4 11/11] ppc/pnv: Update skiboot.lid to support Power11
Message-ID: <4vd7b2bihmfjzp7mtwaevqhjp27vefqcsc2ugdf6cg7atklw7h@6wnzsjnniz4n>
References: <20240528070515.117160-1-adityag@linux.ibm.com>
 <20240528070515.117160-12-adityag@linux.ibm.com>
 <968da156-8621-4509-a0b2-726411e71b5e@kaod.org>
 <D1LP2UJ14DJ2.B5J6N64F9URO@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <D1LP2UJ14DJ2.B5J6N64F9URO@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B8y23fWxKvWKDW7S2lIH9AJajt0Mk7pS
X-Proofpoint-ORIG-GUID: Im_P2JjmIfx7xhzdro8u7r-fW0OOtF-E
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_05,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 mlxlogscore=816 malwarescore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Nick,

On Wed, May 29, 2024 at 10:16:58AM GMT, Nicholas Piggin wrote:
> On Tue May 28, 2024 at 5:15 PM AEST, Cédric Le Goater wrote:
> > On 5/28/24 09:05, Aditya Gupta wrote:
> > > Skiboot/OPAL patches are in discussion upstream [1], with corresponding
> > > commits in github repository [2].
> > > 
> > > Update skiboot.lid, with binary built from 'upstream_power11' branch
> > > of skiboot repository with Power11 enablement patches [2].
> > > 
> > > ---
> > > This patch can be skipped for now, if need to wait for patches to be
> > > merged in open-power/skiboot. Have updated the skiboot.lid to aid in
> > > testing this patch series.
> >
> > When is the merge in skiboot planned ? QEMU 9.1 freeze is in ~2 months.
> 
> I think I will try to get spapr bits in for 9.1, but may just skip pnv
> for this round since there's a bunch of other stuff including some pnv
> churn I'd like to get in 9.1.

Thanks for the information Nick.

Before you take the pseries changes, is it okay if I apply this patch
from Harsh ?

https://lore.kernel.org/qemu-devel/20240523051412.226970-8-harshpb@linux.ibm.com/

This would reduce the duplication.

Thanks,
Aditya Gupta

> 
> Thanks,
> Nick

