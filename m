Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E0FC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 19:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn1Xh-0005mo-Rh; Wed, 20 Mar 2024 15:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1rn1Xg-0005mY-0f
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 15:24:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1rn1Xd-00062S-Qo
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 15:24:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42KHO5Y7015367; Wed, 20 Mar 2024 19:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=pSdnqXHFZTkqkKppLjU15w73kDq7sofcTzyT9DrSUFk=;
 b=TyNJe8EhOiUgAD9F3B6MLwWJbiGa/scWj5TetjKUrYb/osPaxCWLsntkSgRwFuKctg4X
 htcg8COpW3VMTUcTjmIWvt+qkl46QLj64A76o+Q5ODEHPs8HvQsYDzorGVAS2Hy8ta5L
 p23C5MNLpB3lZICalbr0yQYgP4uLI4+x/+AlIe0SIcbscBYuNIxs8g841hf4Ve28dK45
 clU1RRM5EHajySxZIM1pAc4llj0TZ3GIZPR2s1s2qobqaHoPBRRrD48EZ6yyYu2fIWcD
 zWXHH5E5MLSE7pfWjNhK4DIElGc1QckXfvAtN4tTc+JCxHSsftNvFAjfW4C/uGBRqVkj Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x036j0fhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 19:24:00 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42KJNx6d007280;
 Wed, 20 Mar 2024 19:23:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x036j0fem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 19:23:59 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42KHC6NY015829; Wed, 20 Mar 2024 19:21:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp508hh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 19:21:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42KJLVCx38011292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 19:21:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C09620043;
 Wed, 20 Mar 2024 19:21:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EAB220071;
 Wed, 20 Mar 2024 19:21:31 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.238])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Mar 2024 19:21:31 +0000 (GMT)
Message-ID: <7c1f0248465d55ff804c32ed7bb366d4a03abdec.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] migration: Drop unnecessary check in ram's
 pending_exact()
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Bandan Das <bdas@redhat.com>, Julia Suvorova
 <jusual@redhat.com>, Thomas Huth <thuth@redhat.com>
Date: Wed, 20 Mar 2024 20:21:30 +0100
In-Reply-To: <ZfsxjS4Phkf34f4J@x1n>
References: <20240117075848.139045-1-peterx@redhat.com>
 <20240117075848.139045-3-peterx@redhat.com>
 <bc88f4572649084cd38a0880d7e096a939f80b14.camel@linux.ibm.com>
 <ZfsxjS4Phkf34f4J@x1n>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v5hHLafPGwypdMR05-BtuildkHsoaO2g
X-Proofpoint-ORIG-GUID: jIiJsFSpYsTm-X-deQH2jo-OclZhMKsQ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403200156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Wed, 2024-03-20 at 14:57 -0400, Peter Xu wrote:
> On Wed, Mar 20, 2024 at 06:51:26PM +0100, Nina Schoetterl-Glausch wrote:
> > On Wed, 2024-01-17 at 15:58 +0800, peterx@redhat.com wrote:
> > > From: Peter Xu <peterx@redhat.com>
> > >=20
> > > When the migration frameworks fetches the exact pending sizes, it mea=
ns
> > > this check:
> > >=20
> > >   remaining_size < s->threshold_size
> > >=20
> > > Must have been done already, actually at migration_iteration_run():
> > >=20
> > >     if (must_precopy <=3D s->threshold_size) {
> > >         qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
> > >=20
> > > That should be after one round of ram_state_pending_estimate().  It m=
akes
> > > the 2nd check meaningless and can be dropped.
> > >=20
> > > To say it in another way, when reaching ->state_pending_exact(), we
> > > unconditionally sync dirty bits for precopy.
> > >=20
> > > Then we can drop migrate_get_current() there too.
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> >=20
> > Hi Peter,
>=20
> Hi, Nina,
>=20
> >=20
> > could you have a look at this issue:
> > https://gitlab.com/qemu-project/qemu/-/issues/1565
> >=20
> > which I reopened. Previous thread here:
> >=20
> > https://lore.kernel.org/qemu-devel/20230324184129.3119575-1-nsg@linux.i=
bm.com/
> >=20
> > I'm seeing migration failures with s390x TCG again, which look the same=
 to me
> > as those a while back.
>=20
> I'm still quite confused how that could be caused of this.
>=20
> What you described in the previous bug report seems to imply some page was
> leftover in migration so some page got corrupted after migrated.
>=20
> However what this patch mostly does is it can sync more than before even =
if
> I overlooked the condition check there (I still think the check is
> redundant, there's one outlier when remaining_size =3D=3D threshold_size,=
 but I
> don't think it should matter here as of now).  It'll make more sense if
> this patch made the sync less, but that's not the case but vice versa.

[...]

> In the previous discussion, you mentioned that you bisected to the commit
> and also verified the fix.  Now you also mentioned in the bz that you can=
't
> reporduce this bug manually.
>=20
> Is it still possible to be reproduced with some scripts?  Do you also mean
> that it's harder to reproduce comparing to before?  In all cases, some way
> to reproduce it would definitely be helpful.

I tried running the kvm-unit-test a bunch of times in a loop and couldn't
trigger a failure. I just tried again on a different system and managed just
fine, yay. No idea why it wouldn't on the first system tho.
>=20
> Even if we want to revert this change, we'll need to know whether this wi=
ll
> fix your case so we need something to verify it before a revert.  I'll
> consider that the last though as I had a feeling this is papering over
> something else.

I can check if I can reproduce the issue before & after b0504edd ("migratio=
n:
Drop unnecessary check in ram's pending_exact()").
I can also check if I can reproduce it on x86, that worked last time.
Anything else? Ideas on how to pinpoint where the corruption happens?

>=20
> Thanks,
>=20


