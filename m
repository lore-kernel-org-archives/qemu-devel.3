Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEA0CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVCUS-0000Wd-Tz; Thu, 04 Jun 2026 14:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVCUR-0000WP-LF
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 14:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVCUP-0002yT-37
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 14:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780596499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGalzxJ/YVFxKu3dff5Y7lADdiREEZtFQhkM8W3kN+U=;
 b=Zg7pvrRJgqLYeSmEs7P5R3IRKuIJh2mvLD2ouyohUfK4cYPFFNGvqgp4tFhdGzm1pIQkfo
 Dyi7Ulr3MI6ZkQZCqw8dqc3VU7+led1DLsS4oj/nBKjtRxVa7f/D01NjExQAp8KnYeDgju
 7KaS2Z/h5w4wPVS50VYB3gQheEBtGn4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-7jRNnNKbNW-GRCkoHYvnNw-1; Thu, 04 Jun 2026 14:08:18 -0400
X-MC-Unique: 7jRNnNKbNW-GRCkoHYvnNw-1
X-Mimecast-MFC-AGG-ID: 7jRNnNKbNW-GRCkoHYvnNw_1780596498
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8cecac0e467so3071026d6.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780596497; x=1781201297; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dGalzxJ/YVFxKu3dff5Y7lADdiREEZtFQhkM8W3kN+U=;
 b=LUPXlnQWV8kGpdWqltPFIp3XPH3Ufx7jTmwkK7zu24FcSh3YCEaWH0ZCMkDHxnWpQL
 U2ASS91Zndb2Nawr8XApLkTTtT5H/OGIcU5LoMT4L5wNUynE/aNGNcSJkA87d34FwOcc
 NVyVi5CscjmMYvDoy7wIdJyj+9+Hkj1tQQJbzfbzrGctiAOE7TcOyPQ11yfDEty9LQoU
 Cs29RcytQvObrE9ObyzrgK6s/mo3jg7buPhaY1h4pliP7etxFck8dCVlvaibqYfJlL6Z
 FDxPNpiGQiqAGuXkBjAoUcYzP16vwxZI65NTuNLcd14A+ndj3IKTSnEnHAsmjFxAaDa/
 suxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780596497; x=1781201297;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dGalzxJ/YVFxKu3dff5Y7lADdiREEZtFQhkM8W3kN+U=;
 b=aYgxlnFESSsiRMObe0NKH7bZZNklhaygrENs8CoUDCb7oZHssDsOpSP7sYWj+2O8A2
 28vnSNP/3Iyx5vqj/TZ9xQff7qjX6xpwW1IpBIwc1QDDhm8uOwddQedCMO5dTPT2LNQN
 z6D4xX+RU4/u5Bu9RmjATea3L7msBDFBimslKk7lzdmFfQlaKwedj0GxXELZylyIpB+a
 dJqtes1+LPsx81ubD13DB6k9CSbN6Ewird6OzDF0fzJzo00ltZQ9pM5eib6lfPXtKRoS
 M4RsHOpoT0RDfMKfxMqdKN+P7geyG/2KO98w4EviQmnv2HAT6sVYaXlmk6sF5s/BkdeM
 Wxsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2VC0lSj1PRLBHmy3e+fVRXr0F123UFUdJA8MSWlG5473SU9f8cMAivpK5koDIsJYwRDaiPdPyMF9o@nongnu.org
X-Gm-Message-State: AOJu0Yy/PUhEzbg2Ajbba5DUAGzXG5pJo26sKTuLlh39mCKxCiLVIVAJ
 vhsjIXemnjfZYFTdoZy6fUU4zNPcX5js96PpQnZCSvARBqiPOH4GJzlvNF/A1OHQXrI+hotP2Fx
 k4A6Q26gE+WVCU1Hm2Mr1e+fjwWHQhX85a2hEYA3+6W2UjVDTY8Eh7JHN
X-Gm-Gg: Acq92OGxoXZ4rQ2qshvtgCpJh+1/azctYNifmPdsUXLHAxqo+3v939STvFyB0SlT7ea
 CVyDcr5hagI77a5BUiMj/Wkb3WaJfaimjVIlcYxW0muPApIpaSicd/a7Z3AmJAzgUrFrA9G+Y/s
 hTACG0MBZstZw81VsPflOr9q3Mumhf5ddtNmKWT9YcZOf7A5Sh5ZJbkLOwdClUmvEZd531NPVzA
 fOsdyq2AiL7GGbA8QI4OOOun6mXPDj4ZQzIVpl4chsT4hDtt+Y6YYGI/iCfmaMW6QuGlrJ7a8Wt
 obg+u7mdReEqkNo7OVpTh1HsqGK2ekXVh0K2sqwQ8r3PtN05d36qbv44OzpE6HG6vXLf0RO/esG
 W5VsO+Oqkux68YzZPKa6AguITcQ==
X-Received: by 2002:a05:622a:652:b0:50d:3eac:8466 with SMTP id
 d75a77b69052e-517786ed4eamr125843761cf.30.1780596497480; 
 Thu, 04 Jun 2026 11:08:17 -0700 (PDT)
X-Received: by 2002:a05:622a:652:b0:50d:3eac:8466 with SMTP id
 d75a77b69052e-517786ed4eamr125842681cf.30.1780596496329; 
 Thu, 04 Jun 2026 11:08:16 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51785ba0d77sm34413711cf.15.2026.06.04.11.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 11:08:15 -0700 (PDT)
Date: Thu, 4 Jun 2026 14:08:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <aiG_Dh3HcUXInXBb@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
 <aiBhTTqSctU9lFsS@redhat.com> <87o6hr7brx.fsf@suse.de>
 <aiBrp1UJZjmC1aI1@redhat.com> <aiB2nA5bmtBRWras@x1.local>
 <aiE00jn-z-o_WlRo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiE00jn-z-o_WlRo@redhat.com>
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

On Thu, Jun 04, 2026 at 09:18:26AM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 03, 2026 at 02:46:52PM -0400, Peter Xu wrote:
> > On Wed, Jun 03, 2026 at 07:00:07PM +0100, Daniel P. Berrangé wrote:
> > > On Wed, Jun 03, 2026 at 02:51:30PM -0300, Fabiano Rosas wrote:
> > > > Daniel P. Berrangé <berrange@redhat.com> writes:
> > > > 
> > > > > In that case they should definitely be independent command line
> > > > > options. The old "-incoming" design is already broken / limited
> > > > > in the non-'defer' case because it is hardcoded to use URI syntax
> > > > > which can't express all the address formats we accept in QAPI
> > > > > syntax. Adding more special cases onto -incoming just makes the
> > > > > bad situation even worse and is not a forward looking design.
> > > > >
> > > > > If we need the ability to specify migration parameters on the
> > > > > CLI, then as a starting point for the design, we should assume that
> > > > > -incoming does not exist, and design a complete solution from scratch
> > > > > that uses QAPI exclusively, both for addresses and configuration.
> > > > >
> > > > > As discussed before, IMHO the "migrate" and "migrate-incoming"
> > > > > commands need to accept both the address(s) and parameters/capabilities
> > > > > as inline data items rather than relying on pre-configured global state
> > > > > from the 'migrate-parameter' / 'migrate-capability' commands.
> > > > >
> > > > > If we did that modelling for 'migrate-incoming' then that modelling of
> > > > > command parmaeters could map directly to a new '-migrate-incoming'
> > > > > command line argument that accepted exactly the same data model.
> > > > >
> > > > 
> > > > Maybe a user creatable object would better fit this use case instead of
> > > > a new command. We could expose what is today MigrationParameters plus
> > > > the few compat options from migration_properties. It could work more or
> > > > less the same for the QMP migration commands, QMP set/get commands,
> > > > source and destination command lines, the compatibility use-case and the
> > > > debugging use-case.
> > > 
> > > If we can do something using "-object" that is useful both at command
> > > line time and in QMP runtime, then that would be interesting too.
> > > 
> > > My general feeling wrt changes to the current command line is that
> > > any suggestion should be desgined with a nod towards a future scenario
> > > where QEMU is 100% configured with QMP. ie the full command line is
> > > 
> > >    qemu-system-x86_64 -qmp <address>
> > > 
> > > In this world, the current -incoming argument is already largely
> > > unsatisfactory for anything other than "defer".  A model that uses
> > > -object would fit in well, as would a hypothetical -migrate-incoming
> > > that directly mapped to 'migrate-incoming' QMP including capabilities
> > > and parameters.
> > 
> > I don't think even the current -incoming config:* is a blocker or add too
> > much complexity to the full-QMP-based solution.
> > 
> > When it comes, we can simply map all -incoming config:* (JSON or not) to
> > QMP command migrate-set-parameters, what we need is teaching that QMP
> > handler to apply parameters to the temporary MigrationParameters rather
> > than migration object when the latter hasn't been initialized.
> > 
> > I was talking to Fabiano and he suggested me to mention one more thing I
> > said on the list.  It's a matter of whether we should still invest time on
> > supporting migration caps/parameters in QMP migrate/migrate-incoming
> > commands.
> > 
> > Requirements like this (allow migration parameters to be accessible during
> > early stage of QEMU) is going towards the other direction of the that idea.
> > That means even if we put all configs (caps/params) into QMP command
> > migrate[-incoming], libvirt will still need to manage these global setup
> > and making sure when invoking migrate[-incoming] QMP commands they match
> > with the globals.  Say, if one start QEMU with -incoming config:local=on
> > but then invoke "migrate-incoming,local=off" it's illegal.
> > 
> > Considering that it looks like there're solid use cases that we want to
> > support (after CPR's "mode" parameter, now "local"), I want to discuss
> > again whether we want to still spend effort supporting "allow migrate QMP
> > command to specify capabilities/parameters".  Ultimately, we still seem to
> > need these global parameters.
> 
> This is saying that incoming migration is a multi phase/stage task.
> 
> There is a "prepare" phase which sets up QEMU ready to receive an
> incoming migration.
> 
> There is a "running" phase where we are waiting for incoming connection
> and/or handling the migration data stream.
> 
> The current "migrate_incoming" overloads both tasks into the same QMP
> command such that they always happen at the same point in time.
> "-incoming defer" was a crude hack to partially separate them, allowing
> parameters/capabilities to be set before the real migrate_incoming
> QMP command is invoked.
> 
> We can address that by separating the tasks explicitly with a
> "migrate_prepare" command / -migrate-prepare CLI arg that sets all
> the parameters/capabilities atomically, and a "migrate_run" command
> that initiates the processing.

I'm OK with this, or IMHO we can also stick with -incoming treating it as
the preparation phase.

For most of the time, I would slightly prefer keeping old things working
but building new things on top.  Obsolete should only happen if very needed
and properly justified.

For this one, I hope the QAPI helpers I used should introduce minimum
overhead even if we're reusing an old paramaeter.. we can still consider
introducing another parmeter besides -incoming, but it'll work similarly
like what this patch does, then.

> 
> The "jobs" QAPI design has this explicit concept of different phases
> that a job can be in, and provides commands for lifecycle handling.

We have some rich discussion before on Jobs:

https://lore.kernel.org/qemu-devel/878qg1uhbd.fsf_-_@pond.sub.org/#t

IIRC the consensus was it's only about the interfacing that can be shared or
not, which doesn't seem to be a huge mount of code that we can reuse; what
we can reuse is minimum and we may need to overload the interface when
migration joins the party.

We're definitely open to adopt anything Jobs did right.  We don't
necessarily need to switch to Jobs until further justified, which won't be
a trivial task.

Thanks,

-- 
Peter Xu


