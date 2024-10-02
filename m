Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACD1CF6D3C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 16:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw2OL-0001bg-0N; Wed, 02 Oct 2024 12:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sw2OH-0001Zs-1H
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 12:39:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sw2OE-0006dM-Cq
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 12:39:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492GIOcf018379;
 Wed, 2 Oct 2024 16:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 947pVEtvvcYR29MJg3byEYJOr2R6XjW37XiLD0AWxKU=; b=IpA6yO8dHM0i2ev5
 P00x2L5jGDUQ5HkDmRb34FF7ruE96/24sJ/QamjczqO/P5nskVuBN8JSEf1rwbcM
 x3rqDPgw3+s3RWvjqQNP10UwXwUtSNxiBraEA9sKHdf299RupTHqnoInk5id3Y1l
 6f4+LVKW5dPEciQ1DgeenEt1ujSkX1TLOsWmIOXB3sPK5kjr3Ag9Wf1DAfhN9QC9
 tB3Pjqnx+HICqw8lrWkEDNzHOl8b3oSCY+kv3ndL1ede/9ZOy+oAdGajg6piTs6U
 K4P1O9In9jVonMaGdsWkt4KXJltETarkZvkKf370PLCjgSigXn7owKdSeEhQQIpP
 fA2iNw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4219jx0340-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 16:39:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 492GdmH4004444;
 Wed, 2 Oct 2024 16:39:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4219jx033w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 16:39:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 492GYdHW017899;
 Wed, 2 Oct 2024 16:39:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4n3ckj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 16:39:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 492GdjKb56951054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Oct 2024 16:39:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0E6020049;
 Wed,  2 Oct 2024 16:39:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AB1920040;
 Wed,  2 Oct 2024 16:39:45 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Oct 2024 16:39:45 +0000 (GMT)
Message-ID: <731d741bb01c8157a076a3614d20732a3ea448db.camel@linux.ibm.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Noah Goldstein <goldstein.w.n@gmail.com>, laurent@vivier.eu
Cc: qemu-devel@nongnu.org
Date: Wed, 02 Oct 2024 18:39:45 +0200
In-Reply-To: <CAFUsyf+wYJVQHFaJZZ2mE0e3MRXMoQsr+-vk3T0qU3LYd3Dujw@mail.gmail.com>
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <6109eea4230bb3aa7caf6deff526878231aa2136.camel@linux.ibm.com>
 <CAFUsyf+wYJVQHFaJZZ2mE0e3MRXMoQsr+-vk3T0qU3LYd3Dujw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 81stqZfD5eRbeV_yG1edgmX98lxbmEWl
X-Proofpoint-ORIG-GUID: ZXHIYkKX8bfUP_ipon1at58umleACDbq
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_16,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 2024-10-02 at 09:05 -0500, Noah Goldstein wrote:
> On Wed, Oct 2, 2024 at 3:08=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m>
> wrote:
> >=20
> > On Fri, 2024-08-30 at 15:36 -0700, Noah Goldstein wrote:
> > > The new option '-qemu-children' makes it so that on `execve` the
> > > child
> > > process will be launch by the same `qemu` executable that is
> > > currently
> > > running along with its current commandline arguments.
> > >=20
> > > The motivation for the change is to make it so that plugins
> > > running
> > > through `qemu` can continue to run on children.=C2=A0 Why not just
> > > `binfmt`?: Plugins can be desirable regardless of
> > > system/architecture
> > > emulation, and can sometimes be useful for elf files that can run
> > > natively. Enabling `binfmt` for all natively runnable elf files
> > > may
> > > not be desirable.
> >=20
> > Another reason to have this is that one may not have root
> > permissions
> > to configure binfmt-misc.
> >=20
> +1
>=20
> > There was a similar patch posted to the mailing list some years
> > back,
> > which I used to cherry-pick when I needed this. I'm not sure what
> > happened to that discussion though.
>=20
> Yes(ish):
> https://patchwork.ozlabs.org/project/qemu-devel/patch/1455515507-26877-1-=
git-send-email-petrosagg@resin.io/

Thanks for finding this! Don't we need the shebang handling here as
well?

Laurent, do you per chance know why was it not accepted back
then?Unfortunately I cannot find any discussion associated with v3 or
v4
[1]. There were some concerns regarding v1 [2], but from what I can see
they all were addressed.

[1]
https://patchew.org/QEMU/20200730160106.16613-1-rj.bcjesus@gmail.com/
[2]
https://patchwork.kernel.org/project/qemu-devel/patch/1453091602-21843-1-gi=
t-send-email-petrosagg@gmail.com/

