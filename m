Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A530C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn06L-0008Mx-0O; Wed, 20 Mar 2024 13:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1rn06H-0008MI-NG
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:51:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1rn06D-0005QA-N8
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:51:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42KGlGpI024988; Wed, 20 Mar 2024 17:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=spYKK4dmAdLl5x4n8P28q0el7XZlhTpHN1RSLB7vjFk=;
 b=AeDCBv2QYSNlSBf7Abv/qUwPRmjMqnebFNOKNKAKaQnEJEzMnCJp5rvSxuKjzoC7KSfu
 ayf+O8PxVxROlGcvxC7RGH1XCycX5A+LCotHdI21bb5VpUbmVVU9oYXA10MyK/5A8wez
 xmOR3D2nhY4x9QAwZh5ciTDUhOiPEbE2Jx1XDoI6POTfxkBHVezOrvmGJfgiz2Zst2le
 JtayiCmQV209auNlBMYOz7JtWeufU8kdYYURZPurvIA2nrW8p+ZKpYaGnvEyBx4CojD4
 /E+ww1yY0tmGH/tMisHNJNWhausIGKul2vheHTaFL1hvvs/NDi15HdyVskjOS7HZUENH 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x03mdg5t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 17:51:33 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42KHk80b032361;
 Wed, 20 Mar 2024 17:51:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x03mdg5t3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 17:51:32 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42KGMGJB010139; Wed, 20 Mar 2024 17:51:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvav4txw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 17:51:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42KHpRY710158348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 17:51:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D4752004B;
 Wed, 20 Mar 2024 17:51:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CBBD20040;
 Wed, 20 Mar 2024 17:51:27 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.238])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Mar 2024 17:51:27 +0000 (GMT)
Message-ID: <bc88f4572649084cd38a0880d7e096a939f80b14.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] migration: Drop unnecessary check in ram's
 pending_exact()
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Bandan Das <bdas@redhat.com>, Julia Suvorova <jusual@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Mar 2024 18:51:26 +0100
In-Reply-To: <20240117075848.139045-3-peterx@redhat.com>
References: <20240117075848.139045-1-peterx@redhat.com>
 <20240117075848.139045-3-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _a4-OsmSf1zCMq22SOyeNv9rJ7iMANIh
X-Proofpoint-GUID: WNpBT4b7dx7ZCPW5F1nzMEV_VYKsKZ1a
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403200143
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
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

On Wed, 2024-01-17 at 15:58 +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
>=20
> When the migration frameworks fetches the exact pending sizes, it means
> this check:
>=20
>   remaining_size < s->threshold_size
>=20
> Must have been done already, actually at migration_iteration_run():
>=20
>     if (must_precopy <=3D s->threshold_size) {
>         qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
>=20
> That should be after one round of ram_state_pending_estimate().  It makes
> the 2nd check meaningless and can be dropped.
>=20
> To say it in another way, when reaching ->state_pending_exact(), we
> unconditionally sync dirty bits for precopy.
>=20
> Then we can drop migrate_get_current() there too.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Hi Peter,

could you have a look at this issue:
https://gitlab.com/qemu-project/qemu/-/issues/1565

which I reopened. Previous thread here:

https://lore.kernel.org/qemu-devel/20230324184129.3119575-1-nsg@linux.ibm.c=
om/

I'm seeing migration failures with s390x TCG again, which look the same to =
me
as those a while back.

> ---
>  migration/ram.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index c0cdcccb75..d5b7cd5ac2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3213,21 +3213,20 @@ static void ram_state_pending_estimate(void *opaq=
ue, uint64_t *must_precopy,
>  static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
>                                      uint64_t *can_postcopy)
>  {
> -    MigrationState *s =3D migrate_get_current();
>      RAMState **temp =3D opaque;
>      RAMState *rs =3D *temp;
> +    uint64_t remaining_size;
>=20=20
> -    uint64_t remaining_size =3D rs->migration_dirty_pages * TARGET_PAGE_=
SIZE;
> -
> -    if (!migration_in_postcopy() && remaining_size < s->threshold_size) {
> +    if (!migration_in_postcopy()) {
>          bql_lock();
>          WITH_RCU_READ_LOCK_GUARD() {
>              migration_bitmap_sync_precopy(rs, false);
>          }
>          bql_unlock();
> -        remaining_size =3D rs->migration_dirty_pages * TARGET_PAGE_SIZE;
>      }
>=20=20
> +    remaining_size =3D rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> +
>      if (migrate_postcopy_ram()) {
>          /* We can do postcopy, and all the data is postcopiable */
>          *can_postcopy +=3D remaining_size;

This basically reverts 28ef5339c3 ("migration: fix ram_state_pending_exact(=
)"), which originally
made the issue disappear.

Any thoughts on the matter appreciated.

Thanks,
Nina

