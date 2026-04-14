Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164A3F9D0ED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiyd-0002jX-TA; Tue, 14 Apr 2026 14:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCiyc-0002hX-TC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCiyZ-0000Hh-Js
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776193145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ha2VArqBn5TWqki6Eab7lTRWvPu1dHUileltU7MzXrM=;
 b=CTIY5pylUdVsWY9Dts0CGG+HE1sTYrDw1GTQhzPpKtI2DwAa29hIp7PBF7DZmYg3/mVGKC
 yqKkNGLBKnEn6xavwDwwb0Polp4jH9S1Ajki8y4GgJW+mYMa5DhUTTRQR4vTJ0LcHgjr2U
 U57T0YDyShzmvPbMBiocI3HvhQU1Lak=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-45VL48WzORGWjTQSGNhiRw-1; Tue, 14 Apr 2026 14:59:04 -0400
X-MC-Unique: 45VL48WzORGWjTQSGNhiRw-1
X-Mimecast-MFC-AGG-ID: 45VL48WzORGWjTQSGNhiRw_1776193143
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso86480901cf.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776193142; x=1776797942; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ha2VArqBn5TWqki6Eab7lTRWvPu1dHUileltU7MzXrM=;
 b=sb+UrFUq95QWShImnzyNPfEcRSL1qKpgAqem4ZF/+0RHiT//7GIOeDb6tVhwAC0ajB
 0rX0QdXE42xCy7khaQ50satWc4eI1lauYJtMJuCWFRgR/cfGnW3erNBPSwaQIrDRiiFX
 5WoW541noPnAPOnnUb8lScO84p9lw0auyMg8edTL5VjKNinIFruD1zvLYl7qJDZsgizT
 ecs+TTHRgm+MkLVLYKVZenxci1uOp9XgocGXc801bG6RpvkF/mEAipru95KzNjuGyFUS
 g5pEo14lilM8zYju+Y/hYh+3OH7EZspXPS9nFJBAIXxwmldMK1gwBXyFnocyAr+45k6o
 0d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776193142; x=1776797942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ha2VArqBn5TWqki6Eab7lTRWvPu1dHUileltU7MzXrM=;
 b=DeNC5GLEGPKbEUs113JmS1oWMDXNd5SenmIHFCUpXqJoCQY7Tn5PTetb4A7KWDCvNw
 YN4ucJgz7j/WRd1yrwrKLO2+adPIRxiqFKKLenalf675cKHlAHRP2LLIm+snQjE3Ouke
 WUJ7ji8yEOqZz9v18bljVvs0ReBcD95Hpd4CfRhNc0ota7bDcQup93QzBnin1zKDlEgI
 H+GL4RSJmQCnTjQ0jqWfwD8RSKWKf9SyUZHHZXqBKvQySfI/Fj9p9Uy5e021plnvC2er
 AplyaYPIlWwu1CJHWPfl0gRxEg7YFUVhj1QA2XMty1Gk0mYhkSJtI/ZgBeo9Tj3psvBS
 5LtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rbS1507aphWT2iPjJjpA3Yww7QODv9LgQzMigHpeiZtgA+trFiHGLkDJOb0g/IefMbNZHhB8y7MSg@nongnu.org
X-Gm-Message-State: AOJu0Yx7q00IM+nauJ7ZPaeWYWr1uCzgCvO6CESf2ZWmitjUrEvMGIJv
 DXvfkSOzqw/bqTwfIDLhnckLlTb9+hjun+xsO4U1ikWCxxnd2KxbqGfp/wL3KIbvH4zpRBUhF0x
 W1/tYAcQjxYxVR2CrkmzAfRgvjnbcNMk3DPuVx+e8LVUkNOGN9qEh0+XcGyC+I7Fq
X-Gm-Gg: AeBDiesPnL6brQRburT9BEpK1LMlsFG5UNUWzpV/PwBc/csRhu7V6E/iOEMlSoOH8pN
 +bTDRmhm8LcpzwoABrHvep+vlf+p5hYegRnM+abKbFedupMRoa1JcL7lNWmLPLtk4BXgDn+sNvm
 Wl2+t/+/P9Hi3rQVzFnuCXMjCLE2e0byk/7oNSojSDW5M4R7XsMnP7zwQzqA3fsqzjr5v26z7UZ
 5Nh6Sv4AJtFt3HA0WaevMbqj9j0pl44/RS37R4fYtvyqIQ/mIfjWofw7XalaT3YBHpmiSeJTJ/o
 AOWbzsn1OdU64S2pEg4Gjj8nj4i21mLoXqS3MmTOZkv4A+qGeV4GdkvWuXaD77JGNJjalzMBoln
 ZY5ALxgJBUPyr7gau5coZgPq320ZgFnWWTz3UPhbeMBBYqyWrTMZS+kSglg==
X-Received: by 2002:ac8:5855:0:b0:50d:83d8:2d19 with SMTP id
 d75a77b69052e-50dd5c5d77fmr282009061cf.63.1776193142035; 
 Tue, 14 Apr 2026 11:59:02 -0700 (PDT)
X-Received: by 2002:ac8:5855:0:b0:50d:83d8:2d19 with SMTP id
 d75a77b69052e-50dd5c5d77fmr282008561cf.63.1776193141428; 
 Tue, 14 Apr 2026 11:59:01 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd561a34asm118382021cf.26.2026.04.14.11.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 11:59:00 -0700 (PDT)
Date: Tue, 14 Apr 2026 14:58:58 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PULL 19/31] migration: Normalize tls arguments
Message-ID: <ad6OcvW1II8Q3gO1@x1.local>
References: <20251223142959.1460293-1-peterx@redhat.com>
 <20251223142959.1460293-20-peterx@redhat.com>
 <a65a1049-9f19-460a-8e27-a62bb30d2727@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a65a1049-9f19-460a-8e27-a62bb30d2727@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Apr 14, 2026 at 06:56:27PM +0200, Maciej S. Szmigiero wrote:
> On 23.12.2025 15:29, Peter Xu wrote:
> > From: Fabiano Rosas <farosas@suse.de>
> > 
> > The migration parameters tls_creds, tls_authz and tls_hostname
> > currently have a non-uniform handling. When used as arguments to
> > migrate-set-parameters, their type is StrOrNull and when used as
> > return value from query-migrate-parameters their type is a plain
> > string.
> > 
> > Not only having to convert between the types is cumbersome, but it
> > also creates the issue of requiring two different QAPI types to be
> > used, one for each command. MigrateSetParameters is used for
> > migrate-set-parameters with the TLS arguments as StrOrNull while
> > MigrationParameters is used for query-migrate-parameters with the TLS
> > arguments as str.
> > 
> > Since StrOrNull could be considered a superset of str, change the type
> > of the TLS arguments in MigrationParameters to StrOrNull. Also ensure
> > that QTYPE_QNULL is never used.
> > 
> > 1) migrate-set-parameters will always write QTYPE_QSTRING to
> >    s->parameters, either an empty or non-empty string.
> > 
> > 2) query-migrate-parameters will always return a QTYPE_QSTRING, either
> >    empty or non-empty.
> > 
> > 3) the migrate_tls_* helpers will always return a non-empty string or
> >    NULL, for the internal migration code's consumption.
> > 
> > Points (1) and (2) above help simplify the parameters validation and
> > the query command handling because s->parameters is already kept in
> > the format that query-migrate-parameters (and info migrate_paramters)
> > expect. Point (3) is so people don't need to care about StrOrNull in
> > migration code.
> > 
> > This will allow the type duplication to be removed in the next
> > patches.
> > 
> > Note that the type of @tls_creds, @tls-hostname, @tls-authz changes
> > from str to StrOrNull in introspection of the query-migrate-parameters
> > command. We accept this imprecision to enable de-duplication.
> > 
> > There's no need to free the TLS options in
> > migration_instance_finalize() because they're freed by the qdev
> > properties .release method.
> > 
> > Temporary in this patch:
> > migrate_params_test_apply() copies s->parameters into a temporary
> > structure, so it's necessary to drop the references to the TLS options
> > if they were not set by the user to avoid double-free. This is fixed
> > in the next patches.
> > 
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > Link: https://lore.kernel.org/r/20251215220041.12657-6-farosas@suse.de
> > [peterx: in hmp_info_migrate_parameters(), remove an extra dump of
> >   max_postcopy_bandwidth, introduced likely by accident]
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   qapi/migration.json            |   6 +-
> >   migration/options.h            |   1 +
> >   migration/migration-hmp-cmds.c |   6 +-
> >   migration/options.c            | 144 +++++++++++++++++++--------------
> >   migration/tls.c                |   2 +-
> >   5 files changed, 93 insertions(+), 66 deletions(-)
> > 
> > diff --git a/migration/options.c b/migration/options.c
> > index d55f3104be..6ef3c56fb6 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> (..)
> > @@ -1243,7 +1274,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
> >   #ifdef CONFIG_LINUX
> >       if (migrate_zero_copy_send() &&
> >           ((params->has_multifd_compression && params->multifd_compression) ||
> > -         (params->tls_creds && *params->tls_creds))) {
> > +         *params->tls_creds->u.s)) {
> >           error_setg(errp,
> >                      "Zero copy only available for non-compressed non-TLS multifd migration");
> >           return false;
> The above change gives me easily triggerable NULL pointer dereference:
> > $ qemu-system-x86_64 -monitor stdio -global migration.x-multifd=true -global migration.x-zero-copy-send=true
> > QEMU 10.2.93 monitor - type 'help' for more information
> > VNC server running on ::1:5900
> > (qemu) migrate_set_parameter downtime-limit 500
> > Segmentation fault

Oops..

> 
> I guess params->tls_creds really needs that NULL check before being accessed.

Yeah, my gut feeling is we got this special casing of using a temp
parameter object..  I'll leave Fabiano to double check on that and send
patch..

Thanks for the report!

-- 
Peter Xu


