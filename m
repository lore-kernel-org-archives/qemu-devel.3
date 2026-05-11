Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D760CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVGF-0004C6-SD; Mon, 11 May 2026 14:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMVGF-0004By-1f
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMVGC-0001um-3g
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778523701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FSd/aOgrjI5ko0w0bQSH+EfBncyhTkN4tOvPFvZEJs=;
 b=OUW4jgJV4z+W5sB5pwnm95ftWxd/Tzmg6oCRaEdfqgqUt2q9rU63TSdSkSmPLj3s5flt6/
 +nuxs6QHKieVgo5ktT9LAKs9SbVZAJ5uRVTzfJZKcG6U7TcCWMpoU0t8Gx32rl5UO1Ac4t
 ss0CioxPfUVACNSs0nMqNOIc0iQksP0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-rXKYFVs9NYqL8I6mTx2ocg-1; Mon, 11 May 2026 14:21:37 -0400
X-MC-Unique: rXKYFVs9NYqL8I6mTx2ocg-1
X-Mimecast-MFC-AGG-ID: rXKYFVs9NYqL8I6mTx2ocg_1778523697
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8aca172588cso6086106d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778523697; x=1779128497; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2FSd/aOgrjI5ko0w0bQSH+EfBncyhTkN4tOvPFvZEJs=;
 b=fMvMYrFhxKRUuTarh+WStjtsiByW6v5ouyS0/fDfSIh8i+R6lp+8VDx9cmUu9UDlVw
 1LJAm1zYsZU83iquFMV1smzlLzKx1W+ZgYUEqQqv/Nkr5ihuv6v9hBM5nJhklo/3SHrd
 m1imtyK9qOXF7hkelsanu4ro0henyBSlCMJNLnWmzCcGHTpyCC9j9JM5CUmbgJ8w5xnb
 CJZP6E+Ei8WcY2w2Soih9tRwoeb/6SWRt7H5FJFc4WvDkyPwzOJQ7l+NU6C+wVHawWLa
 tHElJeP9yocPf4pE0o0XgaTsya5qM7G/lfjAH3ksKfTv1wEWrU/L6IZFyDCY4Y2ssbW+
 AYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523697; x=1779128497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2FSd/aOgrjI5ko0w0bQSH+EfBncyhTkN4tOvPFvZEJs=;
 b=N8TsjFngsqT2jphFDVQIa2D8Pgz1Zg0kaEKws0n3Mg7AyAeCndPi7svrBc1aQqJSb3
 s+AlGOVr07bqGvTQ1kFGLewaiFwnz9Ib5yeKwMs9/KckIOjZoNv/cD4f0+KUmKM4RMK/
 7myHBgaoYr37+HwwZuk4LV9jH0t5MQlY6LQ+1zDWIlW7xAz768Zq6uLrh+DerJwThXRG
 oSUwWlcnD6wmJoxoKAwO5KvuZ0HqezjDhzsHWp0XiULLqZRepx9HZbwUjLPMzhyT66se
 fse42JZw3XgBs1kWIB+3g8fqMBzCOEGs3clxwh5zGD1DemVDOuudeVxNaCdukkB38KVk
 R1Iw==
X-Gm-Message-State: AOJu0YzrNX2dgKiY50jjMeU10y9XeFPbBplL0xC29NL9brPmvYNqAZ0A
 mvcaJkhzbg9uKSgUdz04RiGhh1f8bsOIPWXv63nfuL6ycfe4NEMZlADEQWrbq5EY0RaEukrAJFk
 S1yKkuilNHeeSHEodVY2BlWCbPYH355CLlnsIQaAb0sLP2WCrFyKaGbkj
X-Gm-Gg: Acq92OFjGCw3kOrAB2uSDpJaKvNh39inF7Jf1vTUoxFYsO4LMGSgByeFfqeFaD+0Reg
 aRwL/h+2BOGeBeJgrQlfZCedUar3JyYov0zYtLkt//Na/hxrox+4I5nuabRjlh0SKgzy2310EN8
 NQl8HhMzNG9lq7GIo2xIThhglxeHPFxBWAI9ymXeq65ZcWtW4P+oj+aWKmZj8vVdVzZK/3lnUSN
 rcrQYAhHdrXZciFm5Bn4TN8WkTkgKrnq8yYtMeYK2HRFz3ilW2Hbip4AAANRcaWbdNY+thlKn7K
 /2Rvx387VDqajoAWMjLlNLe5T1/kqJeOYaEXgGf81D0x0PtAsCf4J1LX2fEc93UmwWY13hgbNT2
 KGlGbyoF179FbPjfTCxGyfJXxYQlmN2BgIuT/K/N3F0NK4CI=
X-Received: by 2002:a05:6214:d8b:b0:8ac:b4d5:50e8 with SMTP id
 6a1803df08f44-8bc4536b491mr357053566d6.26.1778523697117; 
 Mon, 11 May 2026 11:21:37 -0700 (PDT)
X-Received: by 2002:a05:6214:d8b:b0:8ac:b4d5:50e8 with SMTP id
 6a1803df08f44-8bc4536b491mr357052916d6.26.1778523696463; 
 Mon, 11 May 2026 11:21:36 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b1csm101012176d6.28.2026.05.11.11.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:21:36 -0700 (PDT)
Date: Mon, 11 May 2026 14:21:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] migration: Fix possible division by zero on calc
 expected downtime
Message-ID: <agIeL1qYpqmDppab@x1.local>
References: <20260511152019.1316898-1-peterx@redhat.com>
 <CAFEAcA_Hk5EnPWK3Ho1fQVeN0o+2VFjjjz+1sZQk2f3f_CRmWg@mail.gmail.com>
 <agIWHJExoRQqfcNT@x1.local>
 <CAFEAcA-Tup_NPTTi3x0xk_thyku8yN3qNGvzJRt8A0_vJbQZ7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Tup_NPTTi3x0xk_thyku8yN3qNGvzJRt8A0_vJbQZ7g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 11, 2026 at 07:03:08PM +0100, Peter Maydell wrote:
> On Mon, 11 May 2026 at 18:47, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, May 11, 2026 at 04:47:22PM +0100, Peter Maydell wrote:
> > > On Mon, 11 May 2026 at 16:20, Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> > > > that the value will be calculated on-demand.  One side effect on the change
> > > > is QEMU will allow the calculation to happen anytime even if there's no
> > > > transfer happening for a short while.
> > > >
> > > > PeterM reported an ubsan report from clang when running migration-test with
> > > > aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> > > > concurrently so some of the src QEMU may not get chance to push any data,
> > > > causing mbps to be 0:
> > > >
> > > > ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
> > > >
> > > > Fix it by properly handle both Inf and Nan.  One note is we can't use
> > > > ">"/">=" check here otherwise we cannot cover Nan.
> > > >
> > > > Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
> > > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > > Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  migration/migration.c | 18 +++++++++++++++++-
> > > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > index b6f78eb3ac..e4103cd3f0 100644
> > > > --- a/migration/migration.c
> > > > +++ b/migration/migration.c
> > > > @@ -1044,12 +1044,28 @@ static bool migrate_show_downtime(MigrationState *s)
> > > >  /* Return expected downtime (unit: milliseconds) */
> > > >  int64_t migration_downtime_calc_expected(MigrationState *s)
> > > >  {
> > > > +    double expected_ms;
> > > > +
> > > >      if (mig_stats.dirty_sync_count <= 1) {
> > > >          return migrate_downtime_limit();
> > > >      }
> > > >
> > > > -    return mig_stats.dirty_bytes_last_sync /
> > > > +    expected_ms = mig_stats.dirty_bytes_last_sync /
> > > >          migration_get_switchover_bw(s) * 1000;
> > > > +
> > > > +    /*
> > > > +     * This "<" check covers two cases where we want to fallback to
> > > > +     * INT64_MAX, the 1st case is obvious, but the 2nd is not:
> > > > +     *
> > > > +     * (1) when expected_ms is Inf, or anything too big for int64_t
> > > > +     * (2) when expected_ms is Nan (division by zero), evaluation of this
> > >
> > > This should say "zero divided by zero" -- general division by
> > > zero gives Inf, and it's only 0 / 0 that runs into NaN.
> > >
> > > > +     *     if clause will be FALSE
> > > > +     */
> > > > +    if (expected_ms < (double)INT64_MAX) {
> > >
> > > This works, but maybe we should write it out
> > >       if (isnan(expected_ms) || expected_ms < (double)INT64_MAX) {
> >
> > I agree using isnan() is better than comment. Though code in the patch for
> > the next line here is:
> >
> > +           return (int64_t) expected_ms;
> 
> Oops, yes, I got the sense of the condition wrong.
> 
> > Do you think below should work?
> >
> >     expected_ms = ...;
> >
> >     /* For isnan() (0/0) case, we can return anything; return MAX too */
> >     if (isnan(expected_ms) || expected_ms >= (double)INT64_MAX) {
> >         return INT64_MAX;
> >     }
> 
> Yes, this will work. But I think rather than "return anything"
> we ought to say why what we're returning is a sensible value
> for the use case we have. How about:

Just to mention, here when I mentioned "anything", what actually in my mind
is the previous valid value we reported, like before the change of commit
dd4fe8844b5, here we used to have a cache value and only update if we
transferred more than 10k bytes (which itself is a magic value).

But I'm not sure if we need to keep that behavior either..

> 
> /*
>  * If we haven't been able to transfer any data, the result here
>  * could be NaN (for 0 / 0) or infinity (something else / 0).

Theoretically, we can also come to affinity if we sent something small but
the total dirty data is rediculously large, but yeah, I'm OK with this
wording; even if it may not be accurate, it's clear enough to me as a
comment to help reading.

>  * Return INT64_MAX as our best approximation to "this will
>  * take forever to complete". If the problem is transient
>  * (e.g. we just haven't started to transfer yet) we'll
>  * recalculate to a more accurate figure later.
>  */
> 
> ?

I'll use the comment suggested, thanks.

-- 
Peter Xu


