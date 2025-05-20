Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61831C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 06:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHGlx-0002Pv-QO; Tue, 20 May 2025 02:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uHGlt-0002Me-9K; Tue, 20 May 2025 02:48:17 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uHGlr-00070i-25; Tue, 20 May 2025 02:48:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 87BF6A4DC69;
 Tue, 20 May 2025 06:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75961C4CEEB;
 Tue, 20 May 2025 06:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747723693;
 bh=0+iJkTRrs7XDpaJleK3LNCPN518ONweiiRIUBZT4Fkw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Y90pPUPLqBE90/nX/wrvHjO0GfpL6Z1+QhBNtIlX8ADk216FDvOcJpZvzQzUVRJJi
 0X9T2yhVWWYhrMni2pvwW/Fg1ONIdBdCgYHVJi5zpRSrwpgDivT9e+3K+yF8vWtrH4
 22MfW5FQ66Q29TZe7Ypr3LVrd6M0oYtH8q4DtwdYcfODfZ/qFpvBKUbBSi2M4VzPTz
 mi1pzjnwf6uPM0vgbIiYFGkKvFHZuEIlof6m28+k9pN8naTRFyFcHg4VZb45PexQt/
 2Mmu/UYgFSM5yecC5v2PQi32eUTvsWQxNf4KLrMWd3qJijbMUkpS8TrVA9jxCI8IfA
 0GWQzF8q7evPg==
Date: Tue, 20 May 2025 08:48:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Gavin Shan
 <gshan@redhat.com>, Ani Sinha <anisinha@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, John Snow
 <jsnow@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Markus
 Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/20] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250520084805.5b34d888@foz.lan>
In-Reply-To: <20250511094546-mutt-send-email-mst@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <20250511094343-mutt-send-email-mst@kernel.org>
 <20250511094546-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Sun, 11 May 2025 09:45:55 -0400
"Michael S. Tsirkin" <mst@redhat.com> escreveu:

> On Sun, May 11, 2025 at 09:45:04AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Mar 07, 2025 at 08:14:29PM +0100, Mauro Carvalho Chehab wrote:  
> > > Hi Michael,
> > > 
> > > I'm sending v8 to avoid a merge conflict with v7 due to this
> > > changeset:
> > > 
> > >    611f3bdb20f7 ("hw/acpi/ghes: Make  static")  
> > 
> > 
> > 
> > Applied 1-13.
> > Patch 14 needs to apply compat to 10.0 machine type as well.  
> 
> Sorry i meant 1-11.

Changed on the newest version I just submitted:

	https://lore.kernel.org/qemu-devel/cover.1747722973.git.mchehab+huawei@kernel.org/

Thanks,
Mauro

