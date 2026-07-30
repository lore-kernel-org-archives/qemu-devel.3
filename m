Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568C5C55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQQv-0008Cb-80; Thu, 30 Jul 2026 09:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wpQQk-0008Bg-VE
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wpQQj-0008UE-7W
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785416648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3fHbg5GQhtjCJcZ8sb8GB8HbLt6uVyIi9ty4S4qrbdw=;
 b=J3/a9beYXXRqKICHrSxbT57TZeTvzstL0MsRX1LiIZper6lxJ3PwfqJ3ebWxYJ+8PFYYU9
 b7qYd9CrJqXKL+Pw3mMbx5FAZAVa4w3KC6RXtp+0z5WZ6QxdUC98eN9M+HkOn4ge1Olfgg
 JyH83ceYMgEPRIMOf12mwsWkLx4AsdU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-JqmEixgyNtqpEtepCT3dcw-1; Thu,
 30 Jul 2026 09:04:04 -0400
X-MC-Unique: JqmEixgyNtqpEtepCT3dcw-1
X-Mimecast-MFC-AGG-ID: JqmEixgyNtqpEtepCT3dcw_1785416643
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4643318002CC; Thu, 30 Jul 2026 13:04:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D14561800480; Thu, 30 Jul 2026 13:04:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6937821E6920; Thu, 30 Jul 2026 15:04:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Denis V. Lunev <den@openvz.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] hw/ide: Don't divide by zero if guest specifies 0 sectors
In-Reply-To: <CAFEAcA_cGNhZ5JB3-13YXhptYknwiwERQDOS6RMfH17voorgeQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 30 Jul 2026 11:09:33 +0100")
References: <20260630104249.2533126-1-peter.maydell@linaro.org>
 <CAFEAcA8J6-QbqAT-=kfEx2mAvkMucGJiyWC0_zMmVeSrmQw9Jw@mail.gmail.com>
 <CAFEAcA_cGNhZ5JB3-13YXhptYknwiwERQDOS6RMfH17voorgeQ@mail.gmail.com>
Date: Thu, 30 Jul 2026 15:04:00 +0200
Message-ID: <878q6sbpdr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Denis, would you be interested?

Peter Maydell <peter.maydell@linaro.org> writes:

> Ping^2 ?
>
> thanks
> -- PMM
>
> On Mon, 20 Jul 2026 at 09:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> Ping -- would anybody on the qemu-block side like to review this?
>>
>> thanks
>> -- PMM
>>
>> On Tue, 30 Jun 2026 at 11:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>> >
>> > In ide_set_sector() if we're using CHS addressing the way we update
>> > the drive state involves dividing by (s->heads * s->sectors).  These
>> > values can be set by the guest using the INITIALIZE DRIVE PARAMETERS
>> > command, which means that s->sectors can be 0.  (s->heads can't be 0
>> > because the command passes a heads-1 value.) INITIALIZE DRIVE
>> > PARAMETERS is specified to not check the input values for validity;
>> > instead no error is posted until some other command makes an illegal
>> > access. So we have to cope with a 0 divisor here.
>> >
>> > Special-case s->sectors being zero.
>> >
>> > Cc: qemu-stable@nongnu.org
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2399
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > ---
>> > We don't seem to ever actually check that the guest's read/write ops
>> > are within the CHS limits it sets with INITIALIZE DRIVE PARAMETERS --
>> > ide_sect_range_ok() only checks against the underlying block device
>> > geometry.  Maybe we should?  Then a zero-sectors misconfig would
>> > result in our reporting the error on the read/write as the spec
>> > suggests we should.  This patch fixes the division-by-zero, at least,
>> > though.
>> > ---
>> >  hw/ide/core.c | 28 +++++++++++++++++++++-------
>> >  1 file changed, 21 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/hw/ide/core.c b/hw/ide/core.c
>> > index f78b00220b..b030531534 100644
>> > --- a/hw/ide/core.c
>> > +++ b/hw/ide/core.c
>> > @@ -646,13 +646,27 @@ void ide_set_sector(IDEState *s, int64_t sector_num)
>> >          }
>> >      } else {
>> >          /* CHS */
>> > -        cyl = sector_num / (s->heads * s->sectors);
>> > -        r = sector_num % (s->heads * s->sectors);
>> > -        s->hcyl = cyl >> 8;
>> > -        s->lcyl = cyl;
>> > -        s->select = (s->select & ~(ATA_DEV_HS)) |
>> > -            ((r / s->sectors) & (ATA_DEV_HS));
>> > -        s->sector = (r % s->sectors) + 1;
>> > +        if (s->sectors == 0) {
>> > +            /*
>> > +             * s->sectors is under guest control via INITIALIZE DRIVE
>> > +             * PARAMETERS and can be 0; this is an error but can't
>> > +             * be reported at INITIALIZE DRIVE PARAMETERS time so we
>> > +             * have to cope with the bad value here.
>> > +             * (s->heads is always at least 1.)
>> > +             */
>> > +            s->hcyl = 0;
>> > +            s->lcyl = 0;
>> > +            s->select = s->select & ~(ATA_DEV_HS);
>> > +            s->sector = 1;
>> > +        } else {
>> > +            cyl = sector_num / (s->heads * s->sectors);
>> > +            r = sector_num % (s->heads * s->sectors);
>> > +            s->hcyl = cyl >> 8;
>> > +            s->lcyl = cyl;
>> > +            s->select = (s->select & ~(ATA_DEV_HS)) |
>> > +                ((r / s->sectors) & (ATA_DEV_HS));
>> > +            s->sector = (r % s->sectors) + 1;
>> > +        }
>> >      }
>> >  }


