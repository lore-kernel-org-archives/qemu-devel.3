Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDA0C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOeV6-0005m2-Dr; Mon, 09 Jun 2025 11:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOeV4-0005li-O7
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOeV1-0006Xu-GU
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749483199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZfnRQjAnKP/AhVK2S07DlzQQA/TODGiqAFTKGbHXRBQ=;
 b=cXLrJq1GbU+3NAFPhGBRv7ajqzK2cO9J358qcXrVdS3hT9WZYkuaCoSjgeCXiw59t8fTWB
 ri3Fp5uw08HXarN4VHeYZfHa9XtF2mXYbLRI9k0AHWnk9e9iHXJ/jj/H99mfJG9XWf+OyP
 m2YV7FV84+FnAPh7Qd2rzhXkvG13dgE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-zyL9VuuKOcu4vpGsDtaTDQ-1; Mon, 09 Jun 2025 11:33:18 -0400
X-MC-Unique: zyL9VuuKOcu4vpGsDtaTDQ-1
X-Mimecast-MFC-AGG-ID: zyL9VuuKOcu4vpGsDtaTDQ_1749483197
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-47b36edcdb1so146375641cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749483197; x=1750087997;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfnRQjAnKP/AhVK2S07DlzQQA/TODGiqAFTKGbHXRBQ=;
 b=a5PAhDei8BgkhgzcgnmDpr9c0qj9hHvZvkV7dtu0mnVnAv8ADBprWPL4LgZB2mIodG
 No6ie5nBtUioEj5onAiP6WNqrUjicJjSrPODPHae9IYU5XkdbtAvZ18KPDziLB4wn6BQ
 L+ShMKb8NpwqcC0eN+Gc1djZpJDLFEV5WmqeDQCIjyKoJnC3yZhicI1Wf7DEQIwZVb+F
 aq12zwGINOl06y1KdMqTOSsIebS5lBaBr0GFLJnD3jeAa4h3q4RZjXCMeSeWfFfSYwkC
 RtCVO5KwucT5ebfP/qdJDOm/8omFyFGFRFxrm0HeEBc9zFOADSC0X6kRkgSHAdxf5jVr
 2vTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0bWv9OT3YaXcqMZWerg9hyeBS2pZtqSY2CW/0MgPp1kVx0E/xVoKn0CsBbNFl+ek+fzSlvcabaRt8@nongnu.org
X-Gm-Message-State: AOJu0Yx7z11VTyholWodZj6RWJYSv6RBdqQhfLzGykBfqRBIZ12Mpthu
 j2XPpXhXUF7QBx8F605r1R5PM47ixJ+/x4Bc+qcN4iRhIWmAdQQQfblKq0nBALBSvJyJhKlf7Mo
 Q4IBMd2ZNf7Dty4F5RkNvnXf+cPIDeHqrnxas/TNkTDOn8lzWjApGCjh0
X-Gm-Gg: ASbGnctolIw5u0zbVoKAfb3RLVShTAoPc1PZFJybHagOBT6JCC3+ZHHvAewoBuPQjos
 biyCgjvvbe3Xw/twyQoMDpMuBKc2tT6cE5rxGbJmBKlM5QYo9eKYNE/MjMpL6OZfEuUrI2kQw8w
 9xNmHt123DZrhG4I9cXh6D6+QxKDTG1Q/zevpX1QysG/k0cBu49G0H6eh5KVc1V071f7l3bmPCM
 J0A6q/gJUYxDxqGUVko5QDkJaKF9P6fw6/0NzTr5EdSb+wNZaV/s8VgpWTIBtt8qliNYWUS/4T7
 785bwHgbahGvqQ==
X-Received: by 2002:a05:622a:559b:b0:4a5:a5fb:d3fa with SMTP id
 d75a77b69052e-4a5b9db18e4mr212127871cf.47.1749483197544; 
 Mon, 09 Jun 2025 08:33:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIIcsbpfromxSnmHRNHmlJ2GZUV2cmCBKTyGxPbw17nWdWyYaqPTWwmQN4cG3Bnc+Dn0PlLw==
X-Received: by 2002:a05:622a:559b:b0:4a5:a5fb:d3fa with SMTP id
 d75a77b69052e-4a5b9db18e4mr212127501cf.47.1749483197197; 
 Mon, 09 Jun 2025 08:33:17 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a619866975sm57670551cf.68.2025.06.09.08.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:33:16 -0700 (PDT)
Date: Mon, 9 Jun 2025 11:33:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEb-umgh0VP2sKGW@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local> <aEb3pRkQK30JBf04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEb3pRkQK30JBf04@redhat.com>
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

On Mon, Jun 09, 2025 at 04:03:01PM +0100, Daniel P. Berrangé wrote:
> On Fri, Jun 06, 2025 at 04:50:54PM -0400, Peter Xu wrote:
> > On Fri, Jun 06, 2025 at 05:23:18PM -0300, Fabiano Rosas wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > > 
> > > > On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
> > > >> Allow the migrate and migrate_incoming commands to pass the migration
> > > >> configuration options all at once, dispensing the use of
> > > >> migrate-set-parameters and migrate-set-capabilities.
> > > >> 
> > > >> The motivation of this is to simplify the interface with the
> > > >> management layer and avoid the usage of several command invocations to
> > > >> configure a migration. It also avoids stale parameters from a previous
> > > >> migration to influence the current migration.
> > > >> 
> > > >> The options that are changed during the migration can still be set
> > > >> with the existing commands.
> > > >> 
> > > >> The order of precedence is:
> > > >> 
> > > >> 'config' argument > -global cmdline > defaults (migration_properties)
> > > >
> > > > Could we still keep the QMP migrate-set-parameters values?
> > > >
> > > >   'config' argument > QMP setups using migrate-set-parameters >
> > > >     -global cmdline > defaults (migration_properties)
> > > >
> > > 
> > > That's the case. I failed to mention it in the commit message. IOW it
> > > behaves just like today, but the new 'config' way takes precedence over
> > > all.
> > 
> > Referring to below chunk of code:
> > 
> > [...]
> > 
> > > >> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
> > > >> +                             Error **errp)
> > > >> +{
> > > >> +    ERRP_GUARD();
> > > >> +
> > > >> +    assert(bql_locked());
> > > >> +
> > > >> +    /* reset to default parameters */
> > > >> +    migrate_params_apply(&s->defaults);
> > 
> > IIUC here it'll reset all global parameters using the initial defaults
> > first, then apply the "config" specified in "migrate" QMP command?
> > 
> > I think there're actually two separate questions to be asked, to make it
> > clearer, they are:
> > 
> >   (1) Whether we should allow QMP "migrate" 'config' parameter to overwrite
> >       global setup?
> > 
> >   (2) Whether we should allow previous QMP global setup to be used even if
> >       QMP "migrate" provided 'config' parameter?
> > 
> > So IIUC the patch does (1) YES (2) NO, while what I think might be more
> > intuitive is (1) NO (2) YES.
> 
> The point of the 'config' parameter to the 'migrate' command is to
> enable the mgmt app to fully specify what it wants the configuration
> to be, such that there is no previously set state will will cause
> it surprises. Allowing -global to have an effect undermines the
> predictibility in the same way that migrate-set-parameter undermines
> the predictibility.

Now I think I know part of what I've missed: I used to think the "config"
of per-QMP-migrate-command can be totally temporary for a specific
migration request, but then we need another MigrationState.parameters_2 to
cache the old or vice versa; that's probably not necessary.  Now I think it
makes sense to overwrite any settings directly, hence I think I changed my
mind on question (1), YES is fine here.

For (2), why it would introduce any uncertainty for mgmt?

If the mgmt app can both: (1) query from qapi schema knowing all the
parameters supported, then (2) specify all the parameters in QMP migrate's
"option" parameter.  Then it's literally overwritting all the parameters,
so it's predictable with or without completely removing global settings as
an idea?  To me, the "option" is the key to make QMP migrate command and
parameter/cap setup in one "atomic-like" operation, and that provides the
predictability if the command succeeded and if all the parameters are
specified (otherwise it'll fail saying migration in progress, internally
protected by BQL or whatever lock QMP monitor holds).

Thanks,

-- 
Peter Xu


