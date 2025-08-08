Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFADCC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPmZ-0001kJ-I7; Fri, 08 Aug 2025 12:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ukPmO-0001Pm-AN; Fri, 08 Aug 2025 12:17:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ukPmM-0001d0-FV; Fri, 08 Aug 2025 12:17:16 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578CJqjV028220;
 Fri, 8 Aug 2025 16:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=HbXXcGySMe0CA/KLnP6wSx3F7ePQ54xfQ7yc9Fe19dk=; b=CZb/bkbjq/YB
 PMWPnXZDVnfUlm0UrF7Vlk1OBrlFrDFdFeKTi0fbAEJu7KOL5mBow1pEm8OI6UVN
 xXG1CwNTX/Qh2aYSwPUAKorLPxlxi1iJTKkv8R/DPeWwcV7fXK/ovsuUrLipUO/e
 /KL7H2GgsFpDcGkmaNXhrCflUcnX8K0JeJbZARhsctqJZQ1W0XS0Z81IRUBJrVPu
 b92K/SFEorvd2N6yCVeHVQIKvKKnbvlrFBEkWYO/bSgXAPucSJMIYDGhCxG5c5Wf
 ETaLfZK75t9lComxTYXo74I3r1BPxPfeEOAQ2wkLtpuvg1t0qV5DHpyqOtBUph5F
 N/jqZcxMyA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq619hdt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 16:17:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578FiVgk009285;
 Fri, 8 Aug 2025 16:17:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq619hdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 16:17:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578FBZjB020626;
 Fri, 8 Aug 2025 16:17:04 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwn6ad1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 16:17:03 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 578GH2eo28377768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 16:17:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85AB258068;
 Fri,  8 Aug 2025 16:17:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B2745805A;
 Fri,  8 Aug 2025 16:17:02 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Aug 2025 16:17:02 +0000 (GMT)
Message-ID: <424f4adcd7752d8736b370cc29053bf22688b03b.camel@linux.ibm.com>
Subject: Re: [PULL 00/50] ppc queue
From: Miles Glenn <milesg@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 qemu-stable <qemu-stable@nongnu.org>
Date: Fri, 08 Aug 2025 11:17:01 -0500
In-Reply-To: <a9d36b56-2954-4a48-aec4-09657a2295b2@tls.msk.ru>
References: <20250721162233.686837-1-clg@redhat.com>
 <10177005-d549-41bc-b0eb-c98b7e475f97@tls.msk.ru>
 <ce863981-3d5e-4ec4-94ee-e35d773eab78@redhat.com>
 <fe6a0924-aff9-4881-9c2a-5665776d619f@tls.msk.ru>
 <dc796c6ae712a1a63eba2c6ab9c5c59b03942f50.camel@linux.ibm.com>
 <4468aea8-b8cc-4313-abbe-8a5f58a35adc@redhat.com>
 <6afc919bdb18166a71a2dba1a3862709629d5e08.camel@linux.ibm.com>
 <a9d36b56-2954-4a48-aec4-09657a2295b2@tls.msk.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y0TsJN2XumphC_NU5ix0a_0n2WaUoVro
X-Proofpoint-ORIG-GUID: SCSsrO_DyBarzyqv4zqnLpfjZ0Ty_tXN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyOSBTYWx0ZWRfX0iXFQyoBJmf3
 c2bH58enBtXmnYxkzXG3lzZ3rvEzzJSrhFb0ic52E2cQ/HU0+oe+5PwOa02d9EfonyMKOyqu6Ah
 qRaK+7WFRKF7+VqIXEVPCZmWOGPLlROQRTnEEuGRjWysjr95ZnurAuhZB7YdfFWwfHZy4VN1+9t
 HeVCFyjkoaUhSGowVvcrCR0WXLP94b/NBUmWSqhXcxNFdOr2hL+Dg1T188iGZSxjJIOgf4UFd6N
 TPsZow2goDs3I5hdVJVt+ytix37T0lniUrxmsTQf5xU/cIXsDFsW6fXXY+I6dZjj5weJAQyQ6gh
 aVnHRFI9yMcas2rMQoytcygdVQogRquK3re0dyoDKegnlWp0teEualESaTZ2rmhqeFpJg3nqKqo
 bHztadusonGvECwPR12L/ZhqwjHd5ezCRmq6sQe+sM+T1fJ9qGDtEIlozUFiX711As7JP6tf
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=68962301 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=E_gU1cQRGPPUBrA8uesA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 2025-08-08 at 09:07 +0300, Michael Tokarev wrote:
> On 06.08.2025 23:46, Miles Glenn wrote:
> > On Tue, 2025-08-05 at 22:07 +0200, Cédric Le Goater wrote:
> ...
> > > These seem to be interesting to have :
> > > 
> > > ppc/xive2: Fix treatment of PIPR in CPPR update
> > > ppc/xive2: Fix irq preempted by lower priority group irq
> > > ppc/xive: Fix PHYS NSR ring matching
> > > ppc/xive2: fix context push calculation of IPB priority
> > > ppc/xive2: Remote VSDs need to match on forwarding address
> > > ppc/xive2: Fix calculation of END queue sizes
> > > ppc/xive: Report access size in XIVE TM operation error logs
> > > ppc/xive: Fix xive trace event output
> > 
> > I'm still not sure that the benefit is worth the effort, but I
> > certainly don't have a problem with them being backported if someone
> > has the desire and the time to do it.
> 
> I mentioned already that 10.0 series will (hopefully) be LTS series.
> At the very least, it is what we'll have in the upcoming debian
> stable release (trixie), which will be stable for the next 2 years.
> Whenever this is important to have working Power* support in debian -
> I don't know.
> 
> All the mentioned patches applied to 10.0 branch cleanly (in the
> reverse order, from bottom to top), so there's no effort needed
> to back-port them.  And the result passes at least the standard
> qemu testsuite.  So it looks like everything works as intended.
> 
> Please keep qemu-stable@ in Cc for other fixes which you think are
> of interest for older/stable series of qemu.
> 
> Thanks,
> 
> /mjt

Will do, and thanks for doing the backporting, Michael!

-Glenn


