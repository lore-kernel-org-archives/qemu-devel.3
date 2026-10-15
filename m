Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10330CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKdI-0006Xr-FA; Thu, 15 Oct 2026 08:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHKd7-0006X7-Nv
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHKd5-0006on-KK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792067532;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=V1dccALdS0MiU7L0tqoEgdI1lyIEklc2mX6/d1+43QA=;
 b=I+XYfYgCfGSI1d4+dcepn371vUdnv6+tNOO5PVbNDrVP2e14g/Vijw2/V89IXtpi1sjPqA
 RsD1JOxRnrWI9UjDDeI/FBjLZC/6c1bRc8wBZu5PRt6sgtItFDDFizLG6lgB9/GeDGyCOe
 eiWF4/DsZ5GODllHBz3XV8b91jdVF8w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-15VCFEHdPY20ExZGkZZaLA-1; Thu,
 15 Oct 2026 12:32:11 +0000
X-MC-Unique: 15VCFEHdPY20ExZGkZZaLA-1
X-Mimecast-MFC-AGG-ID: 15VCFEHdPY20ExZGkZZaLA_1792067530
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77FC41800758; Thu, 15 Oct 2026 12:32:09 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E78DB30001B9; Thu, 15 Oct 2026 12:32:04 +0000 (UTC)
Date: Thu, 15 Oct 2026 13:32:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 00/21] system: introduce a live data recorder facility
Message-ID: <atDHwThz_5XPY9Yx@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <179206655287.744241.865023521920859070.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179206655287.744241.865023521920859070.b4-review@b4>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 15, 2026 at 04:15:52PM +0400, marcandre.lureau@redhat.com wrote:
> > This series introduces a new facility called 'tldr' which is a
> > live data recorder. This is intended to aid support of production
> > QEMU deployments, by providing a data collection facility that
> > can be left "always on", such that in the event of a QEMU crash
> > or guest OS crash, certain important information will be recorded.
> > 
> > The data recorder has to be enabled by adding a "tldr-config"
> > object instance with -object / object_add.
> > 
> > With this series, the data recorder collects
> > 
> >  * error_report/warn_report/error_printf messages
> >  * QMP events
> 
> It should probably be recorded at emission, not per monitor

Opps.

> >  * QMP errors
> >  * QMP commands, which are not query-XXX/qom-list,
> >    or any command associated with a QMP error.
> >  * qemu_log output
> > 
> > The last item is intended primarily to be used in combination
> > with tracing and its 'log' backend, to have continuous
> > recording of certain interesting probes.
> > 
> > Each type of data is collected in a distinct circular
> > buffer, such that high volumes of one type of data, does
> > not result in overwriting other types of low volume data.
> > 
> > The data recorder is set to trigger on SIGBUS, SIGSEGV,
> > SIGILL, SIGFPE and SIGABRT, or manually via QMP 'tldr-dump'.
> 
> Instead of allocating and dumping by a signal handler, why not use a file-backed
> mmap or a memfd? We would need to define a small fixed header for the file
> layout/buckets.  This would avoid all the issues with signal handlers.

That would impose a continuous I/O workload on data recording, which
is something I wanted to explicitly avoid, until the time the data is
needed to be preserved. This only persists the final data, not any
intermediate data that is overwritten as the circular buffer wraps.
Coupling the in-memory layout to the on-disk layout also means that
dumps would always be the max size, since we would not have grow-on
demand buffers.

File backed would be even worse for the follow up goal of including
statistics, since it'd be putting disk I/O into the stats gathering
path.

> There would be a small window for consistency on crash, but that's probably
> acceptable.
> 
> Plain ASCII section markers would probably be easier to deal with than emojis



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


