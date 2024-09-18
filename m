Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C97CDD548
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 16:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqxWt-0004NH-7z; Wed, 18 Sep 2024 12:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqxWr-0004MU-PH
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 12:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqxWp-0005Im-SX
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 12:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726676860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8V/JHQ++Jqzdh+lBdxyhxtk0xk9FR0kaZrnCB21ggcg=;
 b=EQ6TvWZUQ9K7p9KWkaSQK+Rm/npFKIVA3EUbAGtbTblfjhXsKhbcb0X17lWtG/MmyltWEY
 lin842HCcAK3j3LLHQr7tGM6uyju2gTmuuEwpYm/caQ9lEhO6ot5Q+ab8JUbmSog0M3Qrb
 GZg3jYrUrQbkUFHgD8LNGs4jmNju1Ks=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-sllfgs0SMWKBaychTJ5mdQ-1; Wed, 18 Sep 2024 12:27:39 -0400
X-MC-Unique: sllfgs0SMWKBaychTJ5mdQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c35b3a220aso21659166d6.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 09:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726676859; x=1727281659;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8V/JHQ++Jqzdh+lBdxyhxtk0xk9FR0kaZrnCB21ggcg=;
 b=h85JgRGYNq/edP7q6phOhaEEyzIJ48xIj4LrsZwj4lBBjJAJKphsOUIDaDFivEJjDt
 eF8pkz2u7qM3taBE2uOznb0GXNJsZPz9/3XmH1EbMx0zySjVLukmLX1TxHqYZMlxTxuF
 lBnAcyKLeJD+s2CWGB8TDZbDShle1XOg48BkahV2aSy/ifO6VyK9ploPqSvARRmWRmol
 b4nukaFTyfBgbioFQOY6imADDIEq81anxHc2W0CpM/f7sEzYgvLol0MxreicM107r0Zq
 QmdTpdFm6tc3XblLF9onFvG0HJ3K1aO2t5egZdT6TkYFAH5fSdXhtzM6/M7Nq8zGwByQ
 0R/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbBtLeDncM+MkPYoO8XuyY9ecGIv4H3ZGaqmvyOxeFC5DFYRdODiPCGEctmP5yCqyWg/gUn8dAS4sU@nongnu.org
X-Gm-Message-State: AOJu0YwuePMom1UghxRam8qzBDdhdUj0J6dmr/Om2WC8/zhrXQMi/EM4
 kKIFvXBEilvuPSr4jQHPVJHPxZI2kRhrCo5fBAHcMk0eXG0UWURwKdbeP0AHtyQT/8bY1N5mf9y
 61SHLp6EkvmHYHcWOTQBFYenP8Ea176Pg7W4U6M8l5ifKAHl8JX//
X-Received: by 2002:a05:6214:180f:b0:6c5:b881:449 with SMTP id
 6a1803df08f44-6c6823925fbmr2658216d6.21.1726676858894; 
 Wed, 18 Sep 2024 09:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2qWyUHHFLjYnvQAhj6wy3B7bh/twcXv1G+pjozidXVFYSiWF81NsVUJHhWKmJG/v3NaJ2CQ==
X-Received: by 2002:a05:6214:180f:b0:6c5:b881:449 with SMTP id
 6a1803df08f44-6c6823925fbmr2657826d6.21.1726676858419; 
 Wed, 18 Sep 2024 09:27:38 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c692a07sm45527366d6.93.2024.09.18.09.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 09:27:37 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:27:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: dave@treblig.org, farosas@suse.de, eblake@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] migration: Remove unused zero-blocks capability
Message-ID: <Zur_d4m4D3QSHYOu@x1n>
References: <20240918000207.182683-1-dave@treblig.org>
 <20240918000207.182683-3-dave@treblig.org>
 <87msk54ifb.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msk54ifb.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 18, 2024 at 07:52:56AM +0200, Markus Armbruster wrote:
> dave@treblig.org writes:
> 
> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> >
> > migrate_zero_blocks is unused since
> >   eef0bae3a7 ("migration: Remove block migration")
> >
> > Remove it.
> > That whole zero-blocks capability was just for old-school
> > block migration anyway.
> >
> > Remove the capability as well.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> > ---
> >  migration/options.c |  8 --------
> >  migration/options.h |  1 -
> >  qapi/migration.json | 10 +---------
> >  3 files changed, 1 insertion(+), 18 deletions(-)
> >
> > diff --git a/migration/options.c b/migration/options.c
> > index 9460c5dee9..997e060612 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -177,7 +177,6 @@ Property migration_properties[] = {
> >      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> >      DEFINE_PROP_MIG_CAP("x-rdma-pin-all", MIGRATION_CAPABILITY_RDMA_PIN_ALL),
> >      DEFINE_PROP_MIG_CAP("x-auto-converge", MIGRATION_CAPABILITY_AUTO_CONVERGE),
> > -    DEFINE_PROP_MIG_CAP("x-zero-blocks", MIGRATION_CAPABILITY_ZERO_BLOCKS),
> >      DEFINE_PROP_MIG_CAP("x-events", MIGRATION_CAPABILITY_EVENTS),
> >      DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
> >      DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
> 
> Property of (pseudo-)device "migration".  The "x-" prefix suggests we
> expect management software not to rely on it.  Okay.
> 
> [...]
> 
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index b66cccf107..82d0fc962e 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -389,13 +389,6 @@
> >  #     footprint is mlock()'d on demand or all at once.  Refer to
> >  #     docs/rdma.txt for usage.  Disabled by default.  (since 2.0)
> >  #
> > -# @zero-blocks: During storage migration encode blocks of zeroes
> > -#     efficiently.  This essentially saves 1MB of zeroes per block on
> > -#     the wire.  Enabling requires source and target VM to support
> > -#     this feature.  To enable it is sufficient to enable the
> > -#     capability on the source VM.  The feature is disabled by
> > -#     default.  (since 1.6)
> > -#
> >  # @events: generate events for each migration state change (since 2.4)
> >  #
> >  # @auto-converge: If enabled, QEMU will automatically throttle down
> > @@ -483,7 +476,7 @@
> >  # Since: 1.2
> >  ##
> >  { 'enum': 'MigrationCapability',
> > -  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> > +  'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
> >             'events', 'postcopy-ram',
> >             { 'name': 'x-colo', 'features': [ 'unstable' ] },
> >             'release-ram',
> 
> This is used by migrate-set-capabilities and query-migrate-capabilities,
> via ['MigrationCapabilityStatus'].
> 
> query-migrate-capabilities is unaffected: it couldn't return zero-blocks
> anymore even before the patch.
> 
> migrate-set-capabilities changes incompatibly, I'm afraid.  Before the
> patch:
> 
>     {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"capability": "zero-blocks", "state": true}]}}
>     {"return": {}}
> 
> Afterwards:
> 
>     {"error": {"class": "GenericError", "desc": "Parameter 'capability' does not accept value 'zero-blocks'"}}
> 
> If we had somehow rejected the capability when it made no sense,
> removing it now it never makes sense would be obviously fine.
> 
> The straight & narrow path is to deprecate now, remove later.

I wonder whether we can make this one simpler, as IIUC this cap depends on
the block migration feature, which properly went through the deprecation
process and got removed in the previous release.

IOW, currently QEMU behaves the same with this cap on/off, ignoring it
completely.  I think it means the deprecation message (even if we provide
some for two extra releases..) wouldn't be anything helpful as anyone who
uses this feature already got affected before this patch.. this feature,
together with block migration, are simply all gone already?

> 
> If we believe nothing relies on it, we can bend the rules and remove
> right away.  Missing then: update to docs/about/removed-features.rst.

Indeed, we could mention there.

Thanks,

> 
> > @@ -542,7 +535,6 @@
> >  #           {"state": false, "capability": "xbzrle"},
> >  #           {"state": false, "capability": "rdma-pin-all"},
> >  #           {"state": false, "capability": "auto-converge"},
> > -#           {"state": false, "capability": "zero-blocks"},
> >  #           {"state": true, "capability": "events"},
> >  #           {"state": false, "capability": "postcopy-ram"},
> >  #           {"state": false, "capability": "x-colo"}
> 
> Example for query-migrate-capabilities.  Good.
> 

-- 
Peter Xu


