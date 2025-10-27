Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCDBCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQ7a-0002p1-Il; Mon, 27 Oct 2025 12:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDQ7V-0002oA-HH
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDQ7O-0006Xv-Sj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761582639;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lkrnlnzE6PCXaK0DoFa9OQ3jM9C1/Pjy4gO9NDcDN4Q=;
 b=RKTaG02Rr4yhMLBrETMI2LWHfr01A/Ni5RL8ZzWuSXqhZ5ZCCHXFhgBZ2MxTeLekHNB2WL
 FtHg3nvIMbKfmRR4MKJL9azjBXq7gjW4shEZXgra9AhFFWA76O3fOlZbuRp/ycYty4w5qd
 g7GepwhVLVO/nnhMQkcrEY/MnmS8d2A=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-K50qaD7JM12fEn3rl5kgSA-1; Mon, 27 Oct 2025 12:30:33 -0400
X-MC-Unique: K50qaD7JM12fEn3rl5kgSA-1
X-Mimecast-MFC-AGG-ID: K50qaD7JM12fEn3rl5kgSA_1761582632
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b6ceeea4addso3786979a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761582632; x=1762187432;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lkrnlnzE6PCXaK0DoFa9OQ3jM9C1/Pjy4gO9NDcDN4Q=;
 b=foCyWszhCt0sgqhq4gxKVplkX5C3iV2mjQnqbruaSPFEOCiEa57MY12oHMn0F0Bjb4
 J8HIMVV8hyHmzaM4uZEvIYiMzO3DIAk81StUIingeHRufsKriB6zebg5WPP0yrUdTVuq
 54jaYF4IWTvBrssyBGEadE6S1ne+xVCeMHujTdt/D2ogEzVorl/mbHFLWsGItmslvjvf
 H7XzJX8w0SyBohL5ID8CrXq/k7zjdIM69uii9TyHC3Sux4lS9fmpwby70Nvo99ECvtrU
 X/wz/1arIYYpBlQgS99wJ6SZgv0VM7BsTF11ARnWy74XrC2837aYsLCaySS7LztQlJRl
 4UyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIfhi0AKydr0eHaa5u5cbn0nKMnaK2KOAuFNdfoMzK1uoSPdzubkmdd8Z0yLwK8pBg6Oc2iczzIAl1@nongnu.org
X-Gm-Message-State: AOJu0YxfMKVLElaOx6QmcVA9YtDAONRBi/aHPVbtmEKEUh0KHEqAKP8g
 wDgh66m0voKNuDCn6Je+frHg7gqk2wndMik9rtrY6qwEylhleeTIgaCOHG4XC2I3LC1iSMPoPEz
 l5BW6dFvYieFi3jf0jibb2qj+f2uPDlsCxZClY9ZXqVgzYKkuMC86aA08
X-Gm-Gg: ASbGncsIpse4k+0UQJMX/SmVfmHZk5L60dnx6UXqHOUUBhHZi+OCPhXlbdLRVJkLHc8
 yApguH030rx3gCoR8G3PjXsYwPsHBqpty+Lz3GNzbZ6VWMNsRGkekDkp9qtRLJE6kgScj1WQ2I8
 CHLLbJwS1+NlwHsXjfH7YACcN+QOT76mObWO45QsyYEd+H1IqHwg4I9ssZ8qz2mFU70WYSr6O4i
 AtIEvEsAQf2mIHmFQPOllLNDCpqjPHBA8Q85dZRVMfrNAiAQYqTI1MXlEFALSRe91eEE8eLYAEg
 gwboO2QtRzR6ZH0OwQm5cRIUiLN2zRYL20oNHr+aIkqLQLrur0DwOjZK1KrwLY3NXEiXBGmG90m
 Y+f5qAC3iHow=
X-Received: by 2002:a17:903:32cc:b0:290:c317:a34e with SMTP id
 d9443c01a7336-294cb3dba25mr4957335ad.25.1761582632001; 
 Mon, 27 Oct 2025 09:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCfLWV+iKL70FzHZlbCu3QAzVtYlNClVfbCrkPe8M2QqihG+rESNCMGHAVEY3JO5Pdz+iatw==
X-Received: by 2002:a17:903:32cc:b0:290:c317:a34e with SMTP id
 d9443c01a7336-294cb3dba25mr4956795ad.25.1761582631211; 
 Mon, 27 Oct 2025 09:30:31 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d271ccsm86277345ad.57.2025.10.27.09.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 09:30:30 -0700 (PDT)
Date: Mon, 27 Oct 2025 22:00:23 +0530
From: Arun Menon <armenon@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 berrange@redhat.com
Subject: Re: [PATCH v3 4/4] migration: vmsd errp handlers: return bool
Message-ID: <aP-eHzbAtvNp3N3d@armenon-kvm.bengluru.csb>
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-5-vsementsov@yandex-team.ru>
 <87o6psocib.fsf@pond.sub.org>
 <9f5ba3d7-3103-4d2a-b50f-f8883a18c812@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f5ba3d7-3103-4d2a-b50f-f8883a18c812@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Vladimir,

On Mon, Oct 27, 2025 at 05:58:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 27.10.25 13:38, Markus Armbruster wrote:
> > Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> > 
> > > Switch the new API to simple bool-returning interface, as return value
> > > is not used otherwise than check is function failed or not. No logic
> > > depend on concrete errno values.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > ---
> > >   backends/tpm/tpm_emulator.c   | 10 ++++------
> > >   docs/devel/migration/main.rst |  6 +++---
> > >   include/migration/vmstate.h   |  6 +++---
> > >   migration/vmstate.c           | 14 ++++++--------
> > >   4 files changed, 16 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> > > index aa69eb606f..6cc9aa199c 100644
> > > --- a/backends/tpm/tpm_emulator.c
> > > +++ b/backends/tpm/tpm_emulator.c
> > > @@ -947,25 +947,23 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
> > >   /*
> > >    * Load the TPM state blobs into the TPM.
> > > - *
> > > - * Returns negative errno codes in case of error.
> > >    */
> > > -static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
> > > +static bool tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
> > >   {
> > >       TPMBackend *tb = opaque;
> > >       int ret;
> > >       ret = tpm_emulator_set_state_blobs(tb, errp);
> > 
> > Note for later: this returns 0 or -EIO.
> > 
> > >       if (ret < 0) {
> > > -        return ret;
> > > +        return false;
> > >       }
> > >       if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
> > >           error_setg(errp, "Failed to resume tpm");
> > > -        return -EIO;
> > > +        return false;
> > >       }
> > > -    return 0;
> > > +    return true;
> > >   }
> > >   static const VMStateDescription vmstate_tpm_emulator = {
> > > diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> > > index 1afe7b9689..234d280249 100644
> > > --- a/docs/devel/migration/main.rst
> > > +++ b/docs/devel/migration/main.rst
> > > @@ -446,15 +446,15 @@ The functions to do that are inside a vmstate definition, and are called:
> > >   Following are the errp variants of these functions.
> > > -- ``int (*pre_load_errp)(void *opaque, Error **errp);``
> > > +- ``bool (*pre_load_errp)(void *opaque, Error **errp);``
> > >     This function is called before we load the state of one device.
> > > -- ``int (*post_load_errp)(void *opaque, int version_id, Error **errp);``
> > > +- ``bool (*post_load_errp)(void *opaque, int version_id, Error **errp);``
> > >     This function is called after we load the state of one device.
> > > -- ``int (*pre_save_errp)(void *opaque, Error **errp);``
> > > +- ``bool (*pre_save_errp)(void *opaque, Error **errp);``
> > >     This function is called before we save the state of one device.
> > > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > > index 63ccaee07a..dbe330dd5f 100644
> > > --- a/include/migration/vmstate.h
> > > +++ b/include/migration/vmstate.h
> > > @@ -218,11 +218,11 @@ struct VMStateDescription {
> > >       int minimum_version_id;
> > >       MigrationPriority priority;
> > >       int (*pre_load)(void *opaque);
> > > -    int (*pre_load_errp)(void *opaque, Error **errp);
> > > +    bool (*pre_load_errp)(void *opaque, Error **errp);
> > >       int (*post_load)(void *opaque, int version_id);
> > > -    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
> > > +    bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
> > >       int (*pre_save)(void *opaque);
> > > -    int (*pre_save_errp)(void *opaque, Error **errp);
> > > +    bool (*pre_save_errp)(void *opaque, Error **errp);
> > >       int (*post_save)(void *opaque);
> > >       bool (*needed)(void *opaque);
> > >       bool (*dev_unplug_pending)(void *opaque);
> > > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > > index 677e56c84a..adaaf91b3f 100644
> > > --- a/migration/vmstate.c
> > > +++ b/migration/vmstate.c
> > > @@ -154,13 +154,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> > >           return -EINVAL;
> > >       }
> > >       if (vmsd->pre_load_errp) {
> > > -        ret = vmsd->pre_load_errp(opaque, errp);
> > > -        if (ret < 0) {
> > > +        if (!vmsd->pre_load_errp(opaque, errp)) {
> > >               error_prepend(errp, "pre load hook failed for: '%s', "
> > >                             "version_id: %d, minimum version_id: %d: ",
> > >                             vmsd->name, vmsd->version_id,
> > >                             vmsd->minimum_version_id);
> > > -            return ret;
> > > +            return -EINVAL;
> > >           }
> > >       } else if (vmsd->pre_load) {
> > >           ret = vmsd->pre_load(opaque);
> > > @@ -256,11 +255,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> > >           return ret;
> > >       }
> > >       if (vmsd->post_load_errp) {
> > > -        ret = vmsd->post_load_errp(opaque, version_id, errp);
> > > -        if (ret < 0) {
> > > +        if (!vmsd->post_load_errp(opaque, version_id, errp)) {
> > >               error_prepend(errp, "post load hook failed for: %s, version_id: "
> > >                             "%d, minimum_version: %d: ", vmsd->name,
> > >                             vmsd->version_id, vmsd->minimum_version_id);
> > > +            ret = -EINVAL;
> > 
> > With ->post_load_errp is tpm_emulator_post_load(), the value returned on
> > error changes from -EIO to -EINVAL.
> > 
> > Do callers of vmstate_load_state() care?
> 
> Fast check.. let see somewhere, OK: get_qlist() in vmstate-types.c.. That's a .get
> in VMStateInfo structure.
> 
> Oh, and we do print this ret the same way:
> 
> 
> int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                        void *opaque, int version_id, Error **errp)
> 
>  ...
> 
>                     ret = inner_field->info->get(f, curr_elem, size,
>                                                  inner_field);
>                     if (ret < 0) {
>                         error_setg(errp,
>                                    "Failed to load element of type %s for %s: "
>                                    "%d", inner_field->info->name,
>                                    inner_field->name, ret);
>                     }
> 
> 
> Not saying about a lot  of vmstate_load_state() other calls in the code, and callers do
> passthrough the error to their callers, and so on. It's a huge work to analyze all of
> them.
> 
> 
> Hmm now I see that tpm_emulator_post_load() returns only -EIO code on all error paths.
> 
> Would it be correct just use -EIO here in my patch instead of -EINVAL? It will save
> current behavior as is.

I admit I too was not sure whether to use int or bool return type.
A bit of the discussion is here: https://lore.kernel.org/qemu-devel/87v7mbsjb0.fsf@pond.sub.org/
I found few places where a genuine error code was returned from the function
For example:
vmbus_post_load() calls vmbus_init() that returns -ENOMEM on failure.

The intention was to eventually phase out the old implementation and replace them
with the new ones (errp)
We wanted the new errp variants to be structurally as close to the old
ones as possible so that we can perform a bulk change later.

> 
> 
> 
> -- 
> Best regards,
> Vladimir
> 

Regards,
Arun Menon


