Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C32CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 18:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUqcI-00012h-EB; Wed, 03 Jun 2026 14:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUqcG-00012Y-Vz
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUqcE-0002PA-Gh
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780512416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KnJItpd+usV+aKO0X48CY74LEkvN8uhuQI0EZ7CHxjA=;
 b=CtWOS5+PuGurdPCY/QHfCVMaHn3g10myJ83HMzpx71l4i+cTxZULwxCgJdPNX5grwgvnnT
 Qzin+UPdxXB3Apg+O5zdJbJoTFygwSVNdp2iojUK3KA5nJdskv6oXLAA+BhK2fVGpSNL9A
 ATf2gs1wjI0cveByYdDn7xMocPo5e0Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-PP71ZffyMwa6o69kT-WMBA-1; Wed, 03 Jun 2026 14:46:55 -0400
X-MC-Unique: PP71ZffyMwa6o69kT-WMBA-1
X-Mimecast-MFC-AGG-ID: PP71ZffyMwa6o69kT-WMBA_1780512415
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ccd3213beaso135748066d6.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780512415; x=1781117215; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KnJItpd+usV+aKO0X48CY74LEkvN8uhuQI0EZ7CHxjA=;
 b=T3zZyeaam/91DN/Wf6hyrNBUbGLgQKkvy7MINSg9edV36F/C2f4YJdaneJwzjAnaKl
 6oMDGeON7ytWvUjhqrkeuuj1lxqncbaUOoRVHwKHcJtSBhLt/zL88i1J7vdMUOSV1cQh
 9+UBkAQn0D2nOykhVzVcJ+/Lj+vhdVcdpwuh3sQ1iDtApL9p86JprOUoL4yHwht8s6Gy
 EQ0CIXtkns6MQemcqulv6UZDcguPwM584WAxKG4pKod4QvG+DrHT9cQz3e6c0SfRmWJ3
 oo1Fxyon2FhKmQ6zgNlnpnt7U8QBUesX+GiwOzSIlIJK0FU3RUcRbJ2VdGqbnfu9Ygoc
 r55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780512415; x=1781117215;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KnJItpd+usV+aKO0X48CY74LEkvN8uhuQI0EZ7CHxjA=;
 b=RV/ji9TWlZdkcRS5fxYGsbz5bB6BaSEcpoUOmxw7qL9xdOUSPld/c6E/mWDJiFMhT7
 5UjErOPt8tKKOcHdMzLn01HQTPPTfuHSUod/fqDV8Mx4ytBE1Lb88yXH5Bd2N8SoRKfd
 4WekaOta3lbcAr5ZvEuhloNSt3sUZ3ISkfQwlghpgwd143gZD2nfJZkNAMu1l5yv0sz+
 s0uIT2P9UDy9LQyV2Xorp8oHrQtK6BVofIbRT9qQ+vZfcfw87Dzj8dEMU7wxMhHQosL2
 a95r5ZD4EJND2wBrxtML5ejHXAY0VdeAGqYfrrO0WOK2B9RTCpN3vNZP5kpUj4U8Lj9V
 2Y9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KefF8nwTuWmRpLHRXVQK7QfD+1FK/X4BGE5+SZwP5G7T2driHEE0sF1u3qCsuHAYMQxIDn/b1D0wK@nongnu.org
X-Gm-Message-State: AOJu0YzBr3sIESlqooXwy4xGEQGGQAb1GeDINWnvSIAfzDYowIn/I8+I
 LgyO9DQhVkMc+A3q0c9RLmt8zLzS8KHNu63Ihw+KVZX1cOlAhWgxzXH9Rt8yGCHke0Fm29hTK+J
 Xt/jO/hXbnQ1tpbVGoG/4Qv95PX4EohXBbnAlXsX60wwmNWbLkYbf+zhG
X-Gm-Gg: Acq92OG8dd2CeIzzFtAY0rxsrG+kYI11/I4t6Rz9u3E2twbm6AKslmRSAE1xjHN+/O8
 YyqC2oNaa8Yb6L8jpIk4BQtY7bwqN5cQTMX5T5sbKRPvKong+bcIjyURpzTEvJOPrrV3wGVldhB
 W3726EyIDuen4mBlU1npBd2jAkWVdU3XdbTWiXpscGrfVm1iJpW0dXd5ytDwieJMdEEld19ZFxl
 wdToVLTzodeCDvuFsS/vAb3+9m2rBnS0SQm4kzY+DDm/mtGSCMUWAGH6s6OLD8mm4MAaF8JFMoB
 LniWOXjlFKlk1QxyAIV8rKhQ0QYlIquaqkf2PCEgmrc+E4w5BTa0cNdCfDzDvZeSJCjF0QHP/hF
 lLWJ2WCuqI9TTbsLyO5a7eXgo1g==
X-Received: by 2002:a05:6214:501d:b0:8cc:ea95:2261 with SMTP id
 6a1803df08f44-8cecdcc4a0fmr68688176d6.36.1780512414493; 
 Wed, 03 Jun 2026 11:46:54 -0700 (PDT)
X-Received: by 2002:a05:6214:501d:b0:8cc:ea95:2261 with SMTP id
 6a1803df08f44-8cecdcc4a0fmr68687536d6.36.1780512413897; 
 Wed, 03 Jun 2026 11:46:53 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccd9fd77sm28190976d6.10.2026.06.03.11.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:46:53 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:46:52 -0400
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
Message-ID: <aiB2nA5bmtBRWras@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
 <aiBhTTqSctU9lFsS@redhat.com> <87o6hr7brx.fsf@suse.de>
 <aiBrp1UJZjmC1aI1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiBrp1UJZjmC1aI1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 03, 2026 at 07:00:07PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 03, 2026 at 02:51:30PM -0300, Fabiano Rosas wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > In that case they should definitely be independent command line
> > > options. The old "-incoming" design is already broken / limited
> > > in the non-'defer' case because it is hardcoded to use URI syntax
> > > which can't express all the address formats we accept in QAPI
> > > syntax. Adding more special cases onto -incoming just makes the
> > > bad situation even worse and is not a forward looking design.
> > >
> > > If we need the ability to specify migration parameters on the
> > > CLI, then as a starting point for the design, we should assume that
> > > -incoming does not exist, and design a complete solution from scratch
> > > that uses QAPI exclusively, both for addresses and configuration.
> > >
> > > As discussed before, IMHO the "migrate" and "migrate-incoming"
> > > commands need to accept both the address(s) and parameters/capabilities
> > > as inline data items rather than relying on pre-configured global state
> > > from the 'migrate-parameter' / 'migrate-capability' commands.
> > >
> > > If we did that modelling for 'migrate-incoming' then that modelling of
> > > command parmaeters could map directly to a new '-migrate-incoming'
> > > command line argument that accepted exactly the same data model.
> > >
> > 
> > Maybe a user creatable object would better fit this use case instead of
> > a new command. We could expose what is today MigrationParameters plus
> > the few compat options from migration_properties. It could work more or
> > less the same for the QMP migration commands, QMP set/get commands,
> > source and destination command lines, the compatibility use-case and the
> > debugging use-case.
> 
> If we can do something using "-object" that is useful both at command
> line time and in QMP runtime, then that would be interesting too.
> 
> My general feeling wrt changes to the current command line is that
> any suggestion should be desgined with a nod towards a future scenario
> where QEMU is 100% configured with QMP. ie the full command line is
> 
>    qemu-system-x86_64 -qmp <address>
> 
> In this world, the current -incoming argument is already largely
> unsatisfactory for anything other than "defer".  A model that uses
> -object would fit in well, as would a hypothetical -migrate-incoming
> that directly mapped to 'migrate-incoming' QMP including capabilities
> and parameters.

I don't think even the current -incoming config:* is a blocker or add too
much complexity to the full-QMP-based solution.

When it comes, we can simply map all -incoming config:* (JSON or not) to
QMP command migrate-set-parameters, what we need is teaching that QMP
handler to apply parameters to the temporary MigrationParameters rather
than migration object when the latter hasn't been initialized.

I was talking to Fabiano and he suggested me to mention one more thing I
said on the list.  It's a matter of whether we should still invest time on
supporting migration caps/parameters in QMP migrate/migrate-incoming
commands.

Requirements like this (allow migration parameters to be accessible during
early stage of QEMU) is going towards the other direction of the that idea.
That means even if we put all configs (caps/params) into QMP command
migrate[-incoming], libvirt will still need to manage these global setup
and making sure when invoking migrate[-incoming] QMP commands they match
with the globals.  Say, if one start QEMU with -incoming config:local=on
but then invoke "migrate-incoming,local=off" it's illegal.

Considering that it looks like there're solid use cases that we want to
support (after CPR's "mode" parameter, now "local"), I want to discuss
again whether we want to still spend effort supporting "allow migrate QMP
command to specify capabilities/parameters".  Ultimately, we still seem to
need these global parameters.

Thanks,

-- 
Peter Xu


