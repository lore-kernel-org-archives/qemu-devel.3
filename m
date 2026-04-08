Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307DF10F9968
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 20:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAZUd-0007fD-Og; Wed, 08 Apr 2026 16:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wAZUX-0007c8-77
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 16:27:13 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wAZUV-0003qe-In
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 16:27:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7094143719;
 Wed,  8 Apr 2026 20:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3FEC19421;
 Wed,  8 Apr 2026 20:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775680029;
 bh=gkoOeBnOMC3lxBY6AwM+cpCNfNX2C//0lZNqmLHcwEE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IrqZxtZqm5m2K2swgLDt36kw5djfR4BKWfvrkgPRttKT8rwArsBY+JBWJQ5Jnz2Wa
 +iSknYZ+LMV/jSJWru55ALHkRRnvhe0NlrrkjVg9wfK+m/IrrzGW4N73JbKWVj49jL
 5Y9RaiBkVAxnvg+Ej/RuTgT8AUJMs2zHsBFfZFrrFBnuUmzFEaXcwggcTUKz4xaKPp
 wZcZpf23DI9SiE49iAY807LOuYROcROtlg2sT/R2rTFsB91lC0q9G+ddCQebBhar7n
 RwYJp0tP5LHCqjgDgkYQysmvEhQLFxlMkX4F0pjXBQkL3piH/TjfMnvWyTNy/6p4vk
 yI8bURFrvHing==
Date: Wed, 8 Apr 2026 22:27:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/5] monitor: add dynamic QMP monitor hotplug support
Message-ID: <20260408-gemerkt-munter-92aca76e1529@brauner>
References: <20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org>
 <adTj1iWPZYTD0CF1@redhat.com>
 <20260407-notprogramm-wohlfahrt-be7393963311@brauner>
 <adYlWYHn7AjlHN0t@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adYlWYHn7AjlHN0t@redhat.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=brauner@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 08, 2026 at 10:52:25AM +0100, Daniel P. Berrangé wrote:
> On Tue, Apr 07, 2026 at 10:57:26PM +0200, Christian Brauner wrote:
> > On Tue, Apr 07, 2026 at 12:00:38PM +0100, Daniel P. Berrangé wrote:
> > > On Tue, Apr 07, 2026 at 09:32:44AM +0200, Christian Brauner wrote:
> > > > QEMU supports runtime hotplug for chardevs, devices, block backends,
> > > > and netdevs. Monitors are the only major subsystem that lacks this --
> > > > all QMP monitors must be configured at launch via -mon or -qmp CLI
> > > > options.
> > > > 
> > > > This series adds monitor-add, monitor-remove, and query-monitors QMP
> > > > commands so that management tools can create independent QMP sessions
> > > > on demand at runtime.
> > > > 
> > > > I've implemented a QMP-to-Varlink bridge in systemd. This allows
> > > > systemd-vmspawn to control virtual machines and containers through a
> > > > unified Varlink interface. Varlink allows protocol upgrades. For
> > > > example, it is possible to switch from Varlink to say http. I'm
> > > > allowing Varlink clients to upgrade from the Varlink interface to the
> > > > native QMP interface. Such clients get a new monitor assigned that
> > > > allows them to manage the virtual machine directly via QMP. The main
> > > > monitor remains unaffected and tied to the generic Varlink interface. We
> > > > can't pre-allocate monitors as we have no control over how many protocol
> > > > upgrades we actually get but it won't just be one. And having unused
> > > > monitors around really isn't ideal either.
> > > > 
> > > > Having the ability to hotplug monitors would really be helpful. I'm not
> > > > yet super well-versed in qemu internals so this might be done wrong but
> > > > testing works so far.
> > > 
> > > Can you say if AI agents/LLMs were used in creating these patches ? 
> > 
> > In exploring the QEMU codebase and how the QMP protocol is used in other
> > code-bases. So specifically I used it to research:
> > 
> > * Does monitor hotplug already work?
> > * Has the idea of monitor hotplug been discussed before?
> > * Is there an obvious fundamental reason this cannot work?
> > * What does the lifetime of a monitor look like?
> > * I used it to review the code I wrote and point out bugs that I then
> >   fixed myself.
> > * I had various research questions around how io-thread interactions
> >   work and common synchronization primitives in the codebase.
> > 
> > The code hasn't been written by any coding tool in line with what is
> > requested in the contribution guidelines. I used it to speed up my
> > understanding of what's going on and to debug things without using the
> > output.
> 
> That's all fine, thanks for confirming. I was too suprised by the
> thoroughness of the patches, given your caveat that you were not
> familiar with QEMU internals !

Well, please don't look at the first version then. :)

