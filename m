Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4BDCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRyl-0007aB-VL; Mon, 11 May 2026 10:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMRyS-0007Y0-3W
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMRyL-0003XZ-Va
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778511064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cMM7OpLITqfLTeJkY1gTsv+7qN55C0WoCXxolpAonQY=;
 b=GE/8Rp4k0OuPMMgEyt6KkSH5/c1SfsonynT4XhEykbYHm7oBZlbNWzS9XNeEpc5rClZ03u
 TWLqoopgbzR2Tav1WnlGv0S97ucMIn9QYeU3z9fnCkPF88FLge6647M67EQ4kQLuMRtuFU
 kZ3O67lZnkTPwN8T0aEA539F32k4PIo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-BUzepE4CNTCwWF9wXbWTDw-1; Mon, 11 May 2026 10:51:02 -0400
X-MC-Unique: BUzepE4CNTCwWF9wXbWTDw-1
X-Mimecast-MFC-AGG-ID: BUzepE4CNTCwWF9wXbWTDw_1778511062
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8bcb482b185so71681806d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778511062; x=1779115862; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cMM7OpLITqfLTeJkY1gTsv+7qN55C0WoCXxolpAonQY=;
 b=Cr+qnruN6nxrZ0nNOjpam+KPL6oq4om+oqgIv8j0hidMEPgO/aH7JiwuThhdlVAuf2
 5sKySDwGOENaX8WW08pRufcmBwxRiaTbOkAqCIT+00QgbnLDTmpMxkLzYGhf9E1yQyGc
 olMa5udQJWaQ3oX9NIKj/hbrsVxd+suj8MfG/11JAU67A+3MOryokdRy254384hYYekh
 DbSs830ahkEcX25PX3CaUhVUvrviyH86PEFGYkumk2JjG0qVoi7Ug5dXLF0N55uLijTu
 x3GBCJ9RYobzH0efgWkQj9pCTp/K+hOXEip30WniCJWOq88H9K8CAcKKKfRUqdPSrwew
 h5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778511062; x=1779115862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cMM7OpLITqfLTeJkY1gTsv+7qN55C0WoCXxolpAonQY=;
 b=C0/eX9qSADbZh6JQvC8yZUBb2GUIDGMl+eebOfIFuenMZUnZNgdqWZU1ZX2iqmNtw5
 xj0rrsB6iefzUsM0LcJUL9fa1bckybzGm1mghNdTpZ7Gtx2LXrzB+CCJ8orDKj4rJR/m
 dxWwqoaLTDuZOQjz/VLwYURB2U/5oyV/4pSn5s45/ubW8fr7TSQ4e3yAFwJOA8X/+ahK
 bpzO2ePguuRuJkgEWUhKOXB9m56gJWQykAq+8eR3zmCkeKr51/qaCb7155Fg0GDZASl5
 vxEHsrPWAogqSLTImJGVlwfQaImLe9ZoWpfHEU1IuyeY5Z/NCcKZDy4+q0EiZovJEgjx
 HUdQ==
X-Gm-Message-State: AOJu0YzyioHtWEq1X08GZ5iblveBylx6fGIk/XSd099Gd4jhwSLfv00F
 lrUS5X4nqtgkI2/LbnyHBCzWPGb/iVEIV713J4WF4y4xBgr3MfbJrVsClIzdIkifCSFowtTEXRQ
 s9R0LHKIPoFH0KpnJOZL68NrVOTfJILJPt6+iaULU4COSTuVhPxlE5d+q
X-Gm-Gg: Acq92OH4IEZpsvOnLpGiwzWNHuN0Eq55p6OVCdFORc8uLhbXNN24yDB/WtOEwU99y9J
 jjZGokVzqA2toZhYKZnqo+TY1W+cchuJ6frRdwqOvtYCzE1CyjRG3yI1vdn+nMiBIGLxkEIdvEe
 CHkJXfkHTazRH70oOIP6FIJj+6WVEM/+XauKZnnVgi9Ekm8xOkAcmNZM57UlRDHVmP1tXZgrVhQ
 9Ta9Rs7k3svGJItsclpWik26giZhb4+/pAvYj3qmYa9zUaEOXlZSGw+zOgEE72KRcZBSMeCflcu
 xGMVxem8O45J0g2tbihrVf1kdZZWJkFT+J3FQkqdJQ0spk1nJu2bnnBeoPFM+J7TuWEkdZhsZGt
 IsOUziSbUuwsGuN7tQeCi3O6Zz/THMPm0n+gs8smaRMDB674=
X-Received: by 2002:a05:6214:469b:b0:89e:a170:6af2 with SMTP id
 6a1803df08f44-8c1afabc2c5mr170605236d6.41.1778511062087; 
 Mon, 11 May 2026 07:51:02 -0700 (PDT)
X-Received: by 2002:a05:6214:469b:b0:89e:a170:6af2 with SMTP id
 6a1803df08f44-8c1afabc2c5mr170604266d6.41.1778511061421; 
 Mon, 11 May 2026 07:51:01 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf3b0c7600sm96215986d6.1.2026.05.11.07.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:51:01 -0700 (PDT)
Date: Mon, 11 May 2026 10:51:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] migration: Fix possible division by zero on calc
 expected downtime
Message-ID: <agHs1PcxZYJtba4W@x1.local>
References: <20260511141049.1293449-1-peterx@redhat.com>
 <CAFEAcA88Ui1tG0PEwbwSnSBMaywMJEy5bLLVwXvGdW_06pgJ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA88Ui1tG0PEwbwSnSBMaywMJEy5bLLVwXvGdW_06pgJ0w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 11, 2026 at 03:26:06PM +0100, Peter Maydell wrote:
> On Mon, 11 May 2026 at 15:10, Peter Xu <peterx@redhat.com> wrote:
> >
> > Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> > that the value will be calculated on-demand.  One side effect on the change
> > is QEMU will allow the calculation to happen anytime even if there's no
> > transfer happening for a short while.
> >
> > PeterM reported an ubsan report from clang when running migration-test with
> > aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> > concurrently so some of the src QEMU may not get chance to push any data,
> > causing mbps to be 0:
> >
> > ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
> >
> > Fix it by checking mbps non-zero before the devision.
> >
> > Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index b6f78eb3ac..b06e577328 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1044,12 +1044,18 @@ static bool migrate_show_downtime(MigrationState *s)
> >  /* Return expected downtime (unit: milliseconds) */
> >  int64_t migration_downtime_calc_expected(MigrationState *s)
> >  {
> > +    double bw;
> > +
> >      if (mig_stats.dirty_sync_count <= 1) {
> >          return migrate_downtime_limit();
> >      }
> >
> > -    return mig_stats.dirty_bytes_last_sync /
> > -        migration_get_switchover_bw(s) * 1000;
> > +    bw = migration_get_switchover_bw(s) * 1000;
> > +    if (!bw) {
> > +        return INT64_MAX;
> > +    }
> > +
> > +    return mig_stats.dirty_bytes_last_sync / bw;
> 
> I think this is still UB if bw is a value that's nonzero
> but still small enough that mig_stats.dirty_bytes_last_sync / bw
> is greater than INT64_MAX. It might be more robust to do
> something like:
> 
>     double expected = mig_stats.dirty_bytes_last_sync /
>         migration_get_switchover_bw(s) * 1000;
> 
>     if (expected >= (double)INT64_MAX) {
>         return INT64_MAX;
>     }
>     return (int64_t)expected;
> 
> (which will also handle the infinity case, because
> in IEEE fp infinity is larger than any finite value).

I almost treated mbps as integer, because when it's non-zero it almost
should be at least ~10byte/s (our unit is (uint)transferred / 100ms).. so I
doubt if the issue can happen. But indeed it's theoretically flawed.

I'll repost, thanks for the careful review, Peter.

-- 
Peter Xu


