Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73114CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwjpT-0005Cj-6D; Thu, 11 Sep 2025 12:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uwjpR-0005C5-AP
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:07:21 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uwjpP-0006E6-MF
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:07:21 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C2D244435D;
 Thu, 11 Sep 2025 16:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547AFC4CEF0;
 Thu, 11 Sep 2025 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757606835;
 bh=6CafthLxuvJBl9U6VCth8Xu5LVTg9nJAlbPflKMJTVA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PAOn0B/NRG0ewiOP4B9V1ZEdOCAUa9aaS8HLK5pVa7a7frGeREkK+GEWBxqkuJQwL
 CcvgF4c93z4UWqUV4ElPg+0s1gRr4GOEX0CazX6OS8DTPTQu9OYoVnLs8xbrjkOy2K
 nam6fS2cV1hut6SJ1P1pWYwxvaqdPPcG8KDm8cnPNKPFhR8+8XgctmeesVHm2Z1mJX
 0MTQlh5olvgvYVbcgkYMq+6D1tTNN73dbQLnANxO0jaIRNyPsWgY3OmZ2NB9EpIlnh
 /ZymUhQMzQ+FOo77PGlDbfrK98JGJQLqisnchuQpkNmIuBJgcXIxWBuJ5qsKUX1EMS
 7AuH88E61wWBw==
Date: Thu, 11 Sep 2025 16:07:14 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/26] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Message-ID: <aMLzsk3HHfPZoDDa@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250911025906-mutt-send-email-mst@kernel.org>
 <17ac0ef9-1c10-4f84-be24-b0f25c7e78fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ac0ef9-1c10-4f84-be24-b0f25c7e78fb@redhat.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Sep 11, 2025 at 05:21:44PM +0200, Paolo Bonzini wrote:
> On 9/11/25 08:59, Michael S. Tsirkin wrote:
> > On Thu, Aug 07, 2025 at 04:39:25PM +0200, Magnus Kulke wrote:
> > > Hey all,
> > > 
> > > This is the third revision of a patch set implementing an accelerator
> > > for the MSHV kernel driver, exposing HyperV to Linux "Dom0" hosts in various
> > > scenarios. Thank you for the feedback so far. Since the last revision we
> > > incorporated feedback from the last review and identified further areas for
> > > performance fixes, notably in the irqfd handling. I'm looking forward to your
> > > comments.
> > > 
> > > Best regards,
> > > 
> > > magnus
> > 
> > 
> > So regarding merging plans. Did you guys get in touch
> > with Sunil? That's the easiest smoothest path, through
> > an existing maintainer.
> 
> There's hardly any code shared with WHPX; I am on vacation this week but
> I'll do a final review and merge it soon.

+1 on this. Nothing's shared with WHPX.

Mangus, can you confirm this is ready to be merged? Is there another
version brewing?

Thanks,
Wei

> 
> Paolo
> 

