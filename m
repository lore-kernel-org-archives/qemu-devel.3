Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EAAC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 17:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNbBY-0001h2-O2; Fri, 06 Jun 2025 13:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNbBT-0001gn-5U
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 13:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNbBQ-0002Wa-Pj
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 13:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749232126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rjIiam4HLpaaQIXbhNWkFdyBeD4V+g7ypthKxfeDIqA=;
 b=OYSiJHaSO87EgJ3dHLtdkvhlfZqvkivOG4cReyKrcIpDmGFzJaMuaa3cQUlErIdWcOse/b
 EbnNB5F9onumH5Omor+G7USs+H188TlyKr92uI+zUFi6iud8aieclVoT9UMqHZ4FQKV56I
 PUP9cwj3VnT+K5aKB2B13sVCaHkfOEU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-ANdNegdfNUSsdOPSrGQs1Q-1; Fri, 06 Jun 2025 13:48:45 -0400
X-MC-Unique: ANdNegdfNUSsdOPSrGQs1Q-1
X-Mimecast-MFC-AGG-ID: ANdNegdfNUSsdOPSrGQs1Q_1749232124
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a585ad6726so69696411cf.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 10:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749232124; x=1749836924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjIiam4HLpaaQIXbhNWkFdyBeD4V+g7ypthKxfeDIqA=;
 b=c170M/KfCn0pscwMvWQ2yzf8ZCC8SlbymOodNVHc6p/D0IX6gjOGeWQdYAMKGCd3/S
 HtSAOvtjAZZo43mke2mxjyRAJzWq6XtYXU9adFZrbLVHcUHkXBUuENKOsaLO+mSrvo8+
 Pqp8XCJoV+GzzHyO+FRWQJfHq65jF7Lad/HDYKhbIGb15IpF3gsslfIVtd/X0yNlAEzp
 TgQkIUSj3m8BVajyOCDBMtiVGE4ezI+NXcouFoWKu/mjgzS98f/+1ceMJrk3VayRvFXW
 dFsNj6lhfhh03OcQAP/tDWtVFNPXzqrmF3T/kmGIhMldSkGYhmXZeXebz+1dZ0zpmtvS
 33CA==
X-Gm-Message-State: AOJu0YzS7TAyKldzygcChEx/QypmiF+O+ZwUMidnTEAbyCrR2OVIq+yr
 27wBSHTIrXW/sRDOSJ9PmmvEG6KX7qq/HzQmTtxwgGgKR0NlirW4E5sdT7F/ps8/yzuqBTZNVf3
 dHo6fxVkVDpjFmsaevQqfC5SAwq3jAvobA4NIpuM1sfi3/0A08002kO8A
X-Gm-Gg: ASbGncsGAcAKjf4yAHDAwYs9uvRLBphLlFLetZSBCaptiq6EHw/mEdKU+iIfA0Yd86e
 TGDmz0SSZ5qNUu5fQfg0pq8td+MyL3ibT0lcZeUVKECrXq6EgabJOJYCd6QFIehTpOVqnrnubl+
 HlMG8l3SSiCclUm1tOeLFLl8GJIrk1rzVWFrbEq84qpKVUTKQINaveN9hSPIyg65XgY2ESU3CWI
 Qf+aOiIx9YommkIiiWMzUtDvVh+L+H9TVO/CpytlPkSggVTl4xVuAvBYfqXkxWv+Hclx4gBPN1/
 Cdc=
X-Received: by 2002:a05:622a:5146:b0:4a5:880e:73e2 with SMTP id
 d75a77b69052e-4a5b9a00fb7mr79410251cf.8.1749232124613; 
 Fri, 06 Jun 2025 10:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3eZDcyzKzmd/8/Lx96dcFqzBVfOuLI2sMjEtHqcUCAmvpnS37P8Y1J/uqnD9JYui/JZzzLw==
X-Received: by 2002:a05:622a:5146:b0:4a5:880e:73e2 with SMTP id
 d75a77b69052e-4a5b9a00fb7mr79409931cf.8.1749232124248; 
 Fri, 06 Jun 2025 10:48:44 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a6198659a3sm15751961cf.64.2025.06.06.10.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 10:48:43 -0700 (PDT)
Date: Fri, 6 Jun 2025 13:48:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 09/21] migration: Extract code to mark all parameters as
 present
Message-ID: <aEMp-R1qM6LTclHY@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-10-farosas@suse.de>
 <aEMIkKbRsmW_DEMM@x1.local> <87cybgx3z5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cybgx3z5.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Fri, Jun 06, 2025 at 12:51:58PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jun 02, 2025 at 10:37:58PM -0300, Fabiano Rosas wrote:
> >> MigrationParameters needs to have all of its has_* fields marked as
> >> true when used as the return of query_migrate_parameters because the
> >> corresponding QMP command has all of its members non-optional by
> >> design, despite them being marked as optional in migration.json.
> >> 
> >> Extract this code into a function and make it assert if any field is
> >> missing. With this we ensure future changes will not inadvertently
> >> leave any parameters missing.
> >> 
> >> Also assert that s->parameters _does not_ have any of its has_* fields
> >> set. This structure is internal to the migration code and it should
> >> not rely on the QAPI-generate has_* fields. We might want to store
> >> migration parameters differently in the future.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/options.c | 74 ++++++++++++++++++++++++++++-----------------
> >>  1 file changed, 46 insertions(+), 28 deletions(-)
> >> 
> >> diff --git a/migration/options.c b/migration/options.c
> >> index e2e3ab717f..dd62e726cb 100644
> >> --- a/migration/options.c
> >> +++ b/migration/options.c
> >> @@ -936,6 +936,40 @@ static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)
> >>      }
> >>  }
> >>  
> >> +static void migrate_mark_all_params_present(MigrationParameters *p)
> >> +{
> >> +    int len, n_str_args = 3; /* tls-creds, tls-hostname, tls-authz */
> >
> > Could you remind me why we don't set has_*=true for these three?
> >
> 
> I doesn't exist. These are StrOrNull so their presence is supposed to be
> determined by checking against NULL pointer.
> 
> >> +    bool *has_fields[] = {
> >> +        &p->has_throttle_trigger_threshold, &p->has_cpu_throttle_initial,
> >> +        &p->has_cpu_throttle_increment, &p->has_cpu_throttle_tailslow,
> >> +        &p->has_max_bandwidth, &p->has_avail_switchover_bandwidth,
> >> +        &p->has_downtime_limit, &p->has_x_checkpoint_delay,
> >> +        &p->has_multifd_channels, &p->has_multifd_compression,
> >> +        &p->has_multifd_zlib_level, &p->has_multifd_qatzip_level,
> >> +        &p->has_multifd_zstd_level, &p->has_xbzrle_cache_size,
> >> +        &p->has_max_postcopy_bandwidth, &p->has_max_cpu_throttle,
> >> +        &p->has_announce_initial, &p->has_announce_max, &p->has_announce_rounds,
> >> +        &p->has_announce_step, &p->has_block_bitmap_mapping,
> >> +        &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
> >> +        &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
> >> +    };
> >> +
> >> +    /*
> >> +     * The has_* fields of MigrationParameters are used by QAPI to
> >> +     * inform whether an optional struct member is present. Keep this
> >> +     * decoupled from the internal usage (not QAPI) by leaving the
> >> +     * has_* fields of s->parameters unused.
> >> +     */
> >> +    assert(p != &(migrate_get_current())->parameters);
> >
> > This is OK, I'm not sure whether we're over-cautious though.. but..
> >
> 
> Hopefully after this series the code will be encapsulated enough that we
> don't need to think about this, but before this series the situation is
> definitely confusing enough that we need to know which fields are used
> for what.
> 
> I don't want to see people passing s->parameters into here thinking it's
> all the same, because it isn't. The has_* fields should be used only for
> QAPI stuff, user input validation, etc, while s->parameters is the thing
> that stores all that after validation and there's not reason to be
> messing with has_* since we know that's just an consequence of the fact
> that we're choosing to use the same QAPI type for user input/output and
> internal storage.
> 
> I guess what I'm trying to do is take the pain points where I got
> confused while working on the current code and introduce some hard rules
> to it.

Yes, this makes sense.

-- 
Peter Xu


