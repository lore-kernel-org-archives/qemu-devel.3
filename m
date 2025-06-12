Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26676C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 21:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPpSF-0005Sl-1n; Thu, 12 Jun 2025 17:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPpSC-0005S8-SA
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 17:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPpSB-0005Ec-06
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 17:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749763636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bwFyUWKoKycXGh83cs4dY7T7SNkT7xXTjH6qeDtoHVg=;
 b=MULmrHJ5RbZvyq5vrsSpGm11y10Gfh6H+bRGu6+SSBwEJ0s1/vc+RtJuWjUTTBethhHPHw
 f3M1kAxxC1cGB5oETB72CQvZCQfhimq8qqAKq4qUIvT3jZULc9F4g1tRuDPf5LiO8sC/cW
 Dp4HSVW5ApqgkzPEX3Ev/T9A0ocwNu0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-fuub8LqLOse6SX645ekH9Q-1; Thu, 12 Jun 2025 17:27:15 -0400
X-MC-Unique: fuub8LqLOse6SX645ekH9Q-1
X-Mimecast-MFC-AGG-ID: fuub8LqLOse6SX645ekH9Q_1749763634
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5f876bfe0so277251285a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 14:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749763634; x=1750368434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwFyUWKoKycXGh83cs4dY7T7SNkT7xXTjH6qeDtoHVg=;
 b=M/75UYcIpAy1QKmz52V5IliEFFKxdtG74735mfft/jJ0CjPaAeIiQdPldVStjPv/BX
 rXc5LRfty5lRC477MSZrTqqXSKxV+t9LeGaJLWcsAlX4ZzxxnjcoLMMlnbKHZZeKBUrU
 +EaZgAu2agOkOH20K4JrMH3DCTM38k2lNFHEQrd/+ghUIx4c4Iq+aufk0pa50SlSeSY/
 nqAY89vbY1cHVYibvKpLRIbfMSo1StsAALyCzRlWG5w8IDI8FEbSTuGFSeYCyaoZGInA
 xAXoAnGKkG8jCqFI/I+uOQy0nZA0Rbon5pEhVruB484TnKmjb8Qx+FR/rmKIlTY3Gral
 Zzkw==
X-Gm-Message-State: AOJu0YyGxK4muwzgdKxVtNwBp2rPXsvrN6VZRsqmCJ9AskKS150q8gen
 QhnCf+B09FSiEOudiVt1bvP04OVNZSCeCQRAWu8S9+JwU2kymk8yMWSiXlDr7WckoaWHw+qKlq1
 ItGsupRhP4DEKIhQJb4aDnrstI7hfjtEvdWx98PiSXKVglkPYp2ZPmuzk
X-Gm-Gg: ASbGncupUSBoPQn4MwHAZOifnyA64b0JPTraqHZUE2VSaDfnWobugfzoOvp7Ffm5p/R
 m4MZgWBRPggLP3TOc1QYXk8lUAU1dLSXfZiH+gO+YqrR1s+vbRBUbrRbgzsq94SVfBtRHsakFF+
 mrvjsKAK3NNLrpFOFJnfhmoGJgfcE1rywdj2fzmJ7MPpiRnUodoKdbSInmEEsKl+etQafbiihuY
 5snQDBkI7FH+Focl+taB7OwHcuovXKMLlWYMsoDxcB7PCh8nEyt1/7JBNY4ks7tzOmcCoyKa3cd
 m9Cph2mJnahf0Q==
X-Received: by 2002:a05:620a:171e:b0:7ce:d352:668f with SMTP id
 af79cd13be357-7d3bc4d9581mr150132785a.47.1749763634425; 
 Thu, 12 Jun 2025 14:27:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfNKSq1Bc1Z9nIRiBbZhtfa2+A/40w5eCoBXcDkx4gwy6vA0AZ3wnqctcypZWoZqepZVbQhQ==
X-Received: by 2002:a05:620a:171e:b0:7ce:d352:668f with SMTP id
 af79cd13be357-7d3bc4d9581mr150128785a.47.1749763634061; 
 Thu, 12 Jun 2025 14:27:14 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b8ef9e87sm85010285a.100.2025.06.12.14.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 14:27:13 -0700 (PDT)
Date: Thu, 12 Jun 2025 17:27:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 10/21] migration: Use QAPI_CLONE_MEMBERS in
 query_migrate_parameters
Message-ID: <aEtGL1J4LpLJ8Gj9@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-11-farosas@suse.de>
 <aEMJacJqDHLrdkgn@x1.local> <87a56kx3xc.fsf@suse.de>
 <87ecvovfrt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecvovfrt.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 12, 2025 at 05:58:14PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> On Mon, Jun 02, 2025 at 10:37:59PM -0300, Fabiano Rosas wrote:
> >>> QAPI_CLONE_MEMBERS is a better option than copying parameters one by
> >>> one because it operates on the entire struct and follows pointers. It
> >>> also avoids the need to alter this function every time a new parameter
> >>> is added.
> >>> 
> >>> Note, since this is a deep clone, now we must free the TLS strings
> >>> before assignment.
> >>> 
> >>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >>> ---
> >>>  migration/options.c | 31 ++++---------------------------
> >>>  1 file changed, 4 insertions(+), 27 deletions(-)
> >>> 
> >>> diff --git a/migration/options.c b/migration/options.c
> >>> index dd62e726cb..0a2a3050ec 100644
> >>> --- a/migration/options.c
> >>> +++ b/migration/options.c
> >>> @@ -918,7 +918,9 @@ static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)
> >>>  {
> >>>      StrOrNull *dst = *dstp;
> >>>  
> >>> -    assert(!dst);
> >>> +    if (dst) {
> >>> +        qapi_free_StrOrNull(dst);
> >>> +    }
> >>>  
> >>>      dst = *dstp = g_new0(StrOrNull, 1);
> >>>      dst->type = QTYPE_QSTRING;
> >>> @@ -975,42 +977,17 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
> >>>      MigrationParameters *params;
> >>>      MigrationState *s = migrate_get_current();
> >>>  
> >>> -    /* TODO use QAPI_CLONE() instead of duplicating it inline */
> >>>      params = g_malloc0(sizeof(*params));
> >>>  
> >>> -    params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
> >>> -    params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
> >>> -    params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
> >>> -    params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
> >>> +    QAPI_CLONE_MEMBERS(MigrationParameters, params, &s->parameters);
> >>>  
> >>>      tls_option_set_str(&params->tls_creds, s->parameters.tls_creds);
> >>>      tls_option_set_str(&params->tls_hostname, s->parameters.tls_hostname);
> >>>      tls_option_set_str(&params->tls_authz, s->parameters.tls_authz);

[1]

> >>>  
> >>> -    params->max_bandwidth = s->parameters.max_bandwidth;
> >>> -    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
> >>> -    params->downtime_limit = s->parameters.downtime_limit;
> >>> -    params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
> >>> -    params->multifd_channels = s->parameters.multifd_channels;
> >>> -    params->multifd_compression = s->parameters.multifd_compression;
> >>> -    params->multifd_zlib_level = s->parameters.multifd_zlib_level;
> >>> -    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
> >>> -    params->multifd_zstd_level = s->parameters.multifd_zstd_level;
> >>> -    params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
> >>> -    params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
> >>> -    params->max_cpu_throttle = s->parameters.max_cpu_throttle;
> >>> -    params->announce_initial = s->parameters.announce_initial;
> >>> -    params->announce_max = s->parameters.announce_max;
> >>> -    params->announce_rounds = s->parameters.announce_rounds;
> >>> -    params->announce_step = s->parameters.announce_step;
> >>>      params->block_bitmap_mapping =
> >>>          QAPI_CLONE(BitmapMigrationNodeAliasList,
> >>>                     s->parameters.block_bitmap_mapping);
> >>
> >> Wouldn't the QAPI_CLONE_MEMBERS() have deep cloned this too?
> >>
> >
> > Hmm, I think it should. But it definitely broke something without this
> > line. I'll double check.
> >
> 
> Thanks for the question, this was indeed wrong. QAPI_CLONE_MEMBERS
> depend on the has_* fields on src, otherwise it's just a glorified
> assignment (*dst = src). The reason I got this wrong is that I was using
> the TLS strings to test and they have a different handling in QAPI:
> 
> visit_type_MigrationParameters_members():
> 
>     bool has_tls_creds = !!obj->tls_creds;

[2]

> 
> So the code was working for them, but not for block_bitmap_mapping, for
> which the QAPI has:
> 
> if (visit_optional(v, "block-bitmap-mapping", &obj->has_block_bitmap_mapping)) {
>                                                     ^
>     if (!visit_type_BitmapMigrationNodeAliasList(v, "block-bitmap-mapping",
>         &obj->block_bitmap_mapping, errp)) {
>         return false;
>     }
> }
> 
> IOW, the QAPI_CLONE routines depend on the has_ fields (in retrospect:
> obviously).
> 
> That assert you didn't like will have to go then and s->parameters will
> have to have all has_* fields permanently set. Not a huge deal, but it
> undermines my argument of keeping it free from QAPI details.

Oops, indeed.  Now you have that function to set all has_*, hopefully this
is trivial now to still do so.

Since you mentioned tls_* won't have has_*, but they will get properly
cloned IIUC as you mentioned above [2].  Does it mean we can also drop the
three lines at [1] too?

In general, I am curious why we can't already use QAPI_CLONE() like:

  params = QAPI_CLONE(&s->parameters);

And if my wish came true once more on having it a pointer (meanwhile if it
even happened before this patch):

  params = QAPI_CLONE(s->parameters);

I thought with that, any of "g_malloc0(), copying of tls_*, copying of
block_bitmap things" are all not needed?

-- 
Peter Xu


