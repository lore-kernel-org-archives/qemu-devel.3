Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51805C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 17:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Pd8-0007GK-Oa; Fri, 26 Apr 2024 13:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0Pd2-000775-TP; Fri, 26 Apr 2024 13:44:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1s0Pcy-0008I3-2H; Fri, 26 Apr 2024 13:44:55 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QHhrdO010968; Fri, 26 Apr 2024 17:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=FUHu/kf61Q/OimYFKOEyjw7AgtIt67QhjIJUTNLbgR4=;
 b=dq9X5arfsqQ/DD0/eubSGwhXIAkGXiRVXH/Pejoo9LBP+tNHknGiw6zU8zx6CE78qvfd
 bA2mUK2a+41YV2yrrC9JwG8D2jdi6Z3jwxVumHpiiSFz/g6bkFijKQjfq+gIJRyADuPu
 Zdy5ToCTf0ogN0VJgHUpUJetTXJd6rs9bG9+UFtnuTKKnn3UKJ4Ol12PhF7cvU7agg37
 I6rJFFxZT+Vi/wqCN68z4fdtjatpg7Udb9R00D5K0Ql/nPgWPxMsUpZBoOiExYbVjXX3
 2Go3WbnspahTiRHHjceBleQUj0dbpnyChBOUHvWZNZog2Y2HRzpIs94ghy7qumbigC6w NA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgw8g038-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:44:38 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QHicWA011297;
 Fri, 26 Apr 2024 17:44:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrgw8g035-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:44:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QGYfcK015354; Fri, 26 Apr 2024 17:44:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmrvrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 17:44:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QHiUpo49283408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 17:44:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC4592004D;
 Fri, 26 Apr 2024 17:44:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F8D020040;
 Fri, 26 Apr 2024 17:44:28 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.171.36.162])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 17:44:28 +0000 (GMT)
Date: Fri, 26 Apr 2024 23:14:25 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 01/10] ppc/pseries: Add Power11 cpu type
Message-ID: <kfjlap4u4jwel32rmswlvefryjosqgenhwke4grvlbhzdnmkk3@b3d2gjtjpwsm>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-2-adityag@linux.ibm.com>
 <d35b2a2d-1307-46bf-81ae-747a0e62d6be@kaod.org>
 <renzconck4oavacnkebh4g73jia6ovxsv5fgf4lkik4edwdbt7@kajfn5jcjf5j>
 <d8868238-8282-433e-9593-bf6e7b8fc57c@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8868238-8282-433e-9593-bf6e7b8fc57c@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fUwBWsEDgm36VV9k_QUVHZPQ-VAiFusS
X-Proofpoint-ORIG-GUID: YRR7KZEnbMD-qVgf6yqzs5kPW6y65Qxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=323 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260120
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

> > Quoting lines from docs/system/ppc/powernv.rst:
> > 
> > > Missing devices
> > > ---------------
> > > 
> > > A lot is missing, among which :
> > > 
> > >   * I2C controllers (yet to be merged).
> > >   * NPU/NPU2/NPU3 controllers.
> > >   * EEH support for PCIe Host bridge controllers.
> > >   * NX controller.
> > >   * VAS controller.
> > >   * chipTOD (Time Of Day).
> > >   * Self Boot Engine (SBE).
> > >   * FSI bus.
> > 
> > I can see that 'chipTOD' was added in commit 9a69950feb098. I2C mentions
> > yet to merge, is it merged yet ?
> 
> yes.

Thanks for confirming Cédric !

- Aditya Gupta

> 
> > 
> > I will check whether this needs updating, but might do it in a separate
> > patch than this series.
> 
> Thanks,
> 
> 

