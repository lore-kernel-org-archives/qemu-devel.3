Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AFAC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GGe-0006Qp-0O; Thu, 17 Sep 2026 13:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7GGU-0006Pe-G9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7GGS-0003Pb-0Y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789667472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09DtJ8tZJ8rs9LEZY0Pk2zz/2jXY4P8CwFFo3BQnx2Q=;
 b=WlB2SO+Rute91IWZhfpWKrctuEXeGD/AIyOYyl1ikQjxNZepSAfDZ57LDSUBs9E/Zo0VIs
 PRIhUcdAugIAO0lO/Hxcf1RrPGRRZzDxpxHuGLvR2mqGrEpzjxzUQY3iHAbhGsGP44fe9z
 hQ5v0SwpWjklmMt0uanzr6mWbKAVGX0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-R69O9XSAPfeTDkIzzpfozw-1; Thu, 17 Sep 2026 13:51:11 -0400
X-MC-Unique: R69O9XSAPfeTDkIzzpfozw-1
X-Mimecast-MFC-AGG-ID: R69O9XSAPfeTDkIzzpfozw_1789667471
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8546e211940so8033447b3.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789667471; cv=none;
 d=google.com; s=arc-20260327;
 b=nbYjeFtZ3Op5N6n6g6P8IQAbKUVOJmTzTNaGjiaEH2J8d6VZ8fx7sU9M+SMmEh2R9z
 6CShl8NPrmM7NE9mkRD1dzvrEWdupe0/Rj8HnOjC4b+mjXQc4/eUwEzc6s8WbDjqscl8
 t7qkke9z/VBZMtgdIszBZs4fWYhzk75RJGkErYI1Ml5QAx+RU0RyGvkTz63ZczrtzZRw
 CemRh3jUx8vIuPwoCMdysc+1apGITJ9vO1mm6GJQ/O+eZjgJrVQDWiPSN1fXTmh5X1a8
 iiV50Pg5VujoH+c9FP4WTageDwhDzCLjpgUPe14BVLNqWWdKFlV9rQs2KI6XPpvvbEHN
 vjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=09DtJ8tZJ8rs9LEZY0Pk2zz/2jXY4P8CwFFo3BQnx2Q=;
 fh=N1T2rJRgpF5SwCDa8mYUq6XaRC8Zgv+Raym5wifJ61I=;
 b=GKJI2OrlU0EMn5YF47lZ6Nbjghe8sEcZiXKKLpwOucx9eslfbAjJkv7VSSn1n3cssR
 obqYIN8Ug3U5iMVZHCYVctwzu6Ibbd4R9Sf7IVXAaveOiAgKosD6hnl56COhmmk6xRs3
 wabxHknz2OpISBfgVNLCJot8+n4ntwqR22i4AW+vb8QGNBjFRqQXtl7UOc0g9k/Qoggs
 5wwLMTm/qS3MGYC5DbtPX/MtSoh7rXWZAWYaZ0jtZj9NKtBL2+pn87r0iLiK//P7kRD0
 sBY7pZdui7wi0VZ6svzk4SFAfATHz34wJi8gOqJslT9GBuB1gLwtyZ736pIJmYFuxcTT
 BjaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789667471; x=1790272271; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=09DtJ8tZJ8rs9LEZY0Pk2zz/2jXY4P8CwFFo3BQnx2Q=;
 b=QBvqH+ENt8GK4xRbVg7XsCEYGR1A2+4o/vpP5G+lEq9kvzE02anrOlBUc35l9vaBap
 zbLZmzTBFRqEGG3RBzKNDgQSvB07rvLg4GrMHlSxXiVcONmaT9h+LZ7OIHCkI1nDKyLc
 rnLl5JyLAZB8u/DNd/LD6qpmz3ZoFDJ01FrAN4nHqWfKF92q+aRlPGSdO2s5hzWMm2l7
 AAoVx3l3cGaTXaaUuaUyXSjo8Uw7dJHVNWQUd5SKxhGNb0XaR5fiySFYPxz5z9MOO++k
 UkRmqyl66VWaTHfnNSUTngHwfvvSPJUczxUYWeSEd7s2FlQxQGRa1ovrsedvodrOu07b
 raLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789667471; x=1790272271;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=09DtJ8tZJ8rs9LEZY0Pk2zz/2jXY4P8CwFFo3BQnx2Q=;
 b=Pp072tJJgECNiYUczDn2Ys2P3M5UCdXtFSfRioOAO4cp3mryaxWBexyncsMEDmqqdL
 Qzqph+MhyN5lLu8/85xHhyS9qnEQnQQqjsaFzJ1ApINSFQcy6KHMjHJlB/5HuI9Mb5rx
 AqqwHQUd0C+IIroJBURtO+Hg1Jm0A5uAPNDVj39sj10YwvXP4Atp50jTxHH+y0iv+knQ
 1jeFq3cmxOVof+l0OzvfMtQ+8fpJ5a6X+IJOa9dCIVh72Yze9AAjZwz3W3W8RRXXiPHd
 w2VbjPvI63Cz5aTFUfDEmzFYKFzUva+vieGZiMbqpsmc9WUJKIDcfWZOLBx8rUsmOmJf
 vbhg==
X-Gm-Message-State: AFuF++mFuLw1BEjxWGjhdUZQpAUrqB+Dj7w8Yk2T9jLGyM2AnAot+FzW
 sQiXGNtJOXmo0PIlE70jQbEHiCq5Go2BzbaZxcSi9snVADtjFo85HteYZspt7kvv4Jbf4S2SeJ4
 /InPeyHibIMUCNhbIbPIjNfYnD8iGXs1t/R5KFEuqtT/V6HtfCu7k6cAQ7mizNYHiHBcwnxt6By
 75hBtsO3gGwKJWw1HLWE1V3yaRGbMQRdU=
X-Gm-Gg: AYBFou3n+W46Uqa5qTMbyDVSxhb+nQ2ZNNPWmISddHlbFN+TxczPflWBWQYC5bJh5IB
 7j7jme43xUfirnF18b4N0s5fEZ+K4ua34JGOOV9bssIjStU9x7oOfaxKg88U6u4/48T6ZmILEWX
 vzBNEffAroImqq/gsl6E+ucOr9czbk6qb0rcbPjy9RfN+QIVeoPLeuDwnQipQpifDh8zrnc724i
 to8V+C+7umuNLqt
X-Received: by 2002:a05:690e:450b:10b0:66c:486c:aa1b with SMTP id
 956f58d0204a3-671631f05acmr1743275d50.38.1789667470754; 
 Thu, 17 Sep 2026 10:51:10 -0700 (PDT)
X-Received: by 2002:a05:690e:450b:10b0:66c:486c:aa1b with SMTP id
 956f58d0204a3-671631f05acmr1743251d50.38.1789667470302; Thu, 17 Sep 2026
 10:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260916135841.3614495-1-jsnow@redhat.com>
 <20260916135841.3614495-8-jsnow@redhat.com>
 <877bkl6p5s.fsf@pond.sub.org>
In-Reply-To: <877bkl6p5s.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 17 Sep 2026 13:50:59 -0400
X-Gm-Features: AcwNN1X3Ijah7JnB4DXCnn25H-wDvOuxeeEXSvmMKd70__JU6VQ57kzsptrcuPY
Message-ID: <CAFn=p-YbywppYTRUj9K9ncrue8b9NTgqXtcjWzMYiiJwTgYCpA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] qapi: convert intro sections followed by
 notes/examples
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jonathan Cameron <jic23@kernel.org>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 linux-cxl@vger.kernel.org, 
 qemu-block@nongnu.org, Junjie Cao <junjie.cao@intel.com>, 
 Lukas Straub <lukasstraub2@web.de>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 16, 2026 at 2:13=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > These provide a rather natural cutoff point, but technically this does
> > introduce a new intro/details split to these documentation blocks.
>
> Not sure what you mean by "technically".

As a German, when an American says "technically", you can just omit
that word from the sentence.
I think, translating for you: "I don't expect these changes to have
any immediate effect, but it's possible they might".
You found the case where they might - a case where we probably
actually did want a "TODO:" but never added it.

>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/machine.json   |  5 ++---
> >  qapi/migration.json | 15 +++++++--------
> >  qapi/misc.json      |  3 +--
> >  qapi/run-state.json |  7 +++----
> >  4 files changed, 13 insertions(+), 17 deletions(-)
> >
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 84d95c8d87f..276258d9e5c 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1209,9 +1209,8 @@
> >
> >  ##
> >  # @HV_BALLOON_STATUS_REPORT:
> > -#
> > -# Emitted when the hv-balloon driver receives a "STATUS" message from
> > -# the guest.
> > +#     Emitted when the hv-balloon driver receives a "STATUS" message
> > +#     from the guest.
> >  #
> >  # .. note:: This event is rate-limited.
> >  #
>    # Since: 8.2
>
> The patch splits the first section between after the first paragraph,
> i.e. before the note.
>
> This matters, because we insert generated argument documentation after
> the first section.  Rendered documentation changes like this
>
>     Emitted when the hv-balloon driver receives a "STATUS" message from
>     the guest.
>
> +   Members:
> +      * The members of "HvBalloonInfo".
> +
>     Note:
>
>       This event is rate-limited.
>
> -   Members:
> -      * The members of "HvBalloonInfo".
> -
>     Example::
>
>        <- { "event": "HV_BALLOON_STATUS_REPORT",
>
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index d571c06fc20..a272e701385 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1254,10 +1254,10 @@
> >
> >  ##
> >  # @migrate_cancel:
> > -#
> > -# Cancel the currently executing migration process.  Allows a new
> > -# migration to be started right after.  When postcopy-ram is in use,
> > -# cancelling is not allowed after the postcopy phase has started.
> > +#     Cancel the currently executing migration process.  Allows a new
> > +#     migration to be started right after.  When postcopy-ram is in
> > +#     use, cancelling is not allowed after the postcopy phase has
> > +#     started.
> >  #
> >  # .. note:: This command succeeds even if there is no migration
> >  #    process running.
>
> Similar split, but rendered documentation doesn't change, because
> nothing gets inserted.
>
> Same for the remaining hunks.
>
> Should the one hunk that changes rendered documentation be in the "qapi:
> convert/split remaining QAPI/QMP intro sections" series?

If you should so please. I was splitting by semantics and not effect,
but I can split this one out for you.

>
> [...]
>


