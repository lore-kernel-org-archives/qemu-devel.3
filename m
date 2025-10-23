Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA36CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 18:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC09h-0006y2-Ar; Thu, 23 Oct 2025 14:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC09d-0006wl-DA
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC09b-0000D5-Rt
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761244514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aSu+3e0ILA36mEf/IBDmzVp7nDFD60/OLAnveOqbwYI=;
 b=FKSOfQMNgoQRQGAE8NV13cumA5HSJoaNetuD5KMpo4tr9j6FvtpbN0PIRyYmIuiEqUuZvp
 3rYRc6HtDhtBBFxB7erM/nTqH4OfJqc5I7PutCkCm28YAUj6fy/tRXgofKQYaoao/vm9fb
 BRUCojrAeqwgRDTdbdyviYvrCtPSzD0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-aLX8_5rSPLyR72HSqVjyhw-1; Thu, 23 Oct 2025 14:35:12 -0400
X-MC-Unique: aLX8_5rSPLyR72HSqVjyhw-1
X-Mimecast-MFC-AGG-ID: aLX8_5rSPLyR72HSqVjyhw_1761244512
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8217df6d44cso348587285a.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761244512; x=1761849312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSu+3e0ILA36mEf/IBDmzVp7nDFD60/OLAnveOqbwYI=;
 b=O6P1w5o4l9lfCTXNTIyk1qHOuWADQXYeMSknI8MPR5JRRt1GX6ixP99q7UFbc+/Wsz
 ho14zDXIwtocOVLWlHkkvvj4kW79rC4Mm1UPH58U70BX2L0jYqP7NlnWBv8Md4zHv4U+
 dBF1o5HwL8f38WuUJgkH5fp6LU03viqABe+N1qyzt2dyq1f2DkB2O2wQzeX76LYKlT4C
 6q6tF6MemBhg6/BaxhGDIxea5WjSFQST8qAsrkWrpX8myIIngljO54YDJj9r34Egb09G
 diY8Mara4Dqk5OHEmbPj+BVXw3ANfFzaEttOD2Sci62COjAR5aXgFgZaA1PuP0gJ7R1x
 hLeg==
X-Gm-Message-State: AOJu0YyUYfHMsZOdBPPjb/zmCHTETcrYvzSrai+tQDjIZ8ouf6TEZ8mv
 M7NIRByW+WCYUOjecGe39C/Izi94QeHUT8vcj93Kh7/0hX0ARWD4V074so/UlIqWrBIg5N8AM4z
 2n9adfqkzH3YS4zgWvbKxFMuwCRJNb1VV8aBcPJjNbVf5luXRFbCWnCkR
X-Gm-Gg: ASbGncvklPKKm6tDcAu8+00/0Qt7DkKxVOIBB5o16ogLSUJMCabaKcGZGEa2+A1kdyK
 IQ09owQCN1m6snZ6U2RbtcCCSbGZVBh5y1yZ/3gqftyggxke1lQBYnDHlyMJ5c2DgGm4iF89fdr
 qpzv/TzZiSK9+aOxOdZYhwy4EBWuUqlYN7Z6hiL01DOjvey+9uWNdSuPY2pBbxH4aF8iMmOisga
 bf9GW58X98HFdG5owaIyMNQAL2jmQ5agtN4XtvZK9YDEi969kpCTwJY3dnEZ7Urz3pUV7fPCPhx
 mrgulx7lbT0B+GySC/0HpsLAJiYd1ENAeT4a5hc8t79d157UJKs7vHsoUoODejaEYZg=
X-Received: by 2002:a05:620a:1a04:b0:892:a71a:c02 with SMTP id
 af79cd13be357-892a71a1e17mr2101495085a.23.1761244512230; 
 Thu, 23 Oct 2025 11:35:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGsutgZ2hDzmT7jfPnSPmo24QLI9mAkYMVj7gfsbPD5Dtv6byqn/D+yFJ2Q6GmH34STaPGRQ==
X-Received: by 2002:a05:620a:1a04:b0:892:a71a:c02 with SMTP id
 af79cd13be357-892a71a1e17mr2101490985a.23.1761244511730; 
 Thu, 23 Oct 2025 11:35:11 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0dbcc879sm210635285a.2.2025.10.23.11.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 11:35:11 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:35:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] migration/qmp: Update "resume" flag doc in "migrate"
 command
Message-ID: <aPp1XRanwjPzQs-5@x1.local>
References: <20251022190425.2730441-1-peterx@redhat.com>
 <87cy6eb25c.fsf@pond.sub.org> <aPozyk9Do9iu32G4@x1.local>
 <87sef94suf.fsf@pond.sub.org> <aPo7Sw29g_gdOD0k@x1.local>
 <875xc54jrt.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xc54jrt.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 23, 2025 at 07:20:38PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Oct 23, 2025 at 04:04:40PM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Thu, Oct 23, 2025 at 07:47:11AM +0200, Markus Armbruster wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > It wasn't obvious how the resume flag should be used when staring at the
> >> >> > QAPI doc.  Enrich it to be crystal clear.
> >> >> >
> >> >> > Reported-by: Markus Armbruster <armbru@redhat.com>
> >> >> > Signed-off-by: Peter Xu <peterx@redhat.com>
> >> >> > ---
> >> >> >  qapi/migration.json | 5 ++++-
> >> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/qapi/migration.json b/qapi/migration.json
> >> >> > index be0f3fcc12..48856078db 100644
> >> >> > --- a/qapi/migration.json
> >> >> > +++ b/qapi/migration.json
> >> >> > @@ -1732,7 +1732,10 @@
> >> >> >  # @detach: this argument exists only for compatibility reasons and is
> >> >> >  #     ignored by QEMU
> >> >> >  #
> >> >> > -# @resume: resume one paused migration, default "off".  (since 3.0)
> >> >> > +# @resume: when set, resume one paused postcopy migration, using the new
> >> >> 
> >> >> Scratch "one" unless there can be more than one.
> >> >
> >> > Sure.
> >> >
> >> >> 
> >> >> > +#     URI/channels specified to replace the old/broken channels.  The user
> >> >> > +#     should make sure the migration is in "postcopy-paused" state before
> >> >> > +#     the resume request.  Default "off".  (since 3.0)
> >> >> >  #
> >> >> >  # Features:
> >> >> >  #
> >> >> 
> >> >> What happens when migration is not in state "postcopy-paused"?
> >> >
> >> > The QMP command "migrate" with resume=true set will be rejected,
> >> > corresponds to:
> >> >
> >> > migrate_prepare():
> >> >         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
> >> >             error_setg(errp, "Cannot resume if there is no "
> >> >                        "paused migration");
> >> >             return false;
> >> >         }
> >> 
> >> Makes sense, thanks!
> >> 
> >> I'd suggest something like 'Resume fails unless migration is in
> >> "postcopy-paused" state.  (default: false, since 3.0)'
> >
> > Since it's still a "migrate" QMP command, should I use "the command will
> > fail"? I also re-arranged the words slightly.. would below look a better
> > next version as a whole?
> >
> > # @resume: when set, use the new uri/channels specified to resume paused
> > #     postcopy migration.  This flag should only be used if the previous
> > #     postcopy migration was interrupted.  The command will fail unless
> > #     migration is in "postcopy-paused" state.  (default: false, since 3.0)
> >
> > Thanks,
> 
> I like it.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Rather than a new resend to bother everyone, I'll just queue it with the
amended version and the tag.. thanks Markus!

-- 
Peter Xu


