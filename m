Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7330110F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYSk-0003ri-91; Wed, 08 Apr 2026 15:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAY3j-00062Z-Sb
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAPaQ-000478-9J
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 05:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775641955;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHgAkaEeXeXO9qay2I4Yl56EdVv/QqtPD1zDtdK+P4g=;
 b=D5LryQoCeWNTqwFbFjv1ijPv8KfsuM5vI1rDFvCf0UpSRhz2mVRxDbyJwkhbVLJPDYnZw/
 kcfhxCf6G4FCyfgBRg1iOcY5P2TqqC0rK55yBebvfNvyt9k90UWXJ9M4cFCdthhkDzvkZQ
 RhdajJ3umQlMxMBCvbPvfwDq1pdJBC8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-8h6v8zOiOpOMHrgM6ci78A-1; Wed,
 08 Apr 2026 05:52:32 -0400
X-MC-Unique: 8h6v8zOiOpOMHrgM6ci78A-1
X-Mimecast-MFC-AGG-ID: 8h6v8zOiOpOMHrgM6ci78A_1775641951
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 535C0180028B; Wed,  8 Apr 2026 09:52:31 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B95FD19560B1; Wed,  8 Apr 2026 09:52:28 +0000 (UTC)
Date: Wed, 8 Apr 2026 10:52:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/5] monitor: add dynamic QMP monitor hotplug support
Message-ID: <adYlWYHn7AjlHN0t@redhat.com>
References: <20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org>
 <adTj1iWPZYTD0CF1@redhat.com>
 <20260407-notprogramm-wohlfahrt-be7393963311@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407-notprogramm-wohlfahrt-be7393963311@brauner>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 07, 2026 at 10:57:26PM +0200, Christian Brauner wrote:
> On Tue, Apr 07, 2026 at 12:00:38PM +0100, Daniel P. Berrangé wrote:
> > On Tue, Apr 07, 2026 at 09:32:44AM +0200, Christian Brauner wrote:
> > > QEMU supports runtime hotplug for chardevs, devices, block backends,
> > > and netdevs. Monitors are the only major subsystem that lacks this --
> > > all QMP monitors must be configured at launch via -mon or -qmp CLI
> > > options.
> > > 
> > > This series adds monitor-add, monitor-remove, and query-monitors QMP
> > > commands so that management tools can create independent QMP sessions
> > > on demand at runtime.
> > > 
> > > I've implemented a QMP-to-Varlink bridge in systemd. This allows
> > > systemd-vmspawn to control virtual machines and containers through a
> > > unified Varlink interface. Varlink allows protocol upgrades. For
> > > example, it is possible to switch from Varlink to say http. I'm
> > > allowing Varlink clients to upgrade from the Varlink interface to the
> > > native QMP interface. Such clients get a new monitor assigned that
> > > allows them to manage the virtual machine directly via QMP. The main
> > > monitor remains unaffected and tied to the generic Varlink interface. We
> > > can't pre-allocate monitors as we have no control over how many protocol
> > > upgrades we actually get but it won't just be one. And having unused
> > > monitors around really isn't ideal either.
> > > 
> > > Having the ability to hotplug monitors would really be helpful. I'm not
> > > yet super well-versed in qemu internals so this might be done wrong but
> > > testing works so far.
> > 
> > Can you say if AI agents/LLMs were used in creating these patches ? 
> 
> In exploring the QEMU codebase and how the QMP protocol is used in other
> code-bases. So specifically I used it to research:
> 
> * Does monitor hotplug already work?
> * Has the idea of monitor hotplug been discussed before?
> * Is there an obvious fundamental reason this cannot work?
> * What does the lifetime of a monitor look like?
> * I used it to review the code I wrote and point out bugs that I then
>   fixed myself.
> * I had various research questions around how io-thread interactions
>   work and common synchronization primitives in the codebase.
> 
> The code hasn't been written by any coding tool in line with what is
> requested in the contribution guidelines. I used it to speed up my
> understanding of what's going on and to debug things without using the
> output.

That's all fine, thanks for confirming. I was too suprised by the
thoroughness of the patches, given your caveat that you were not
familiar with QEMU internals !

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


