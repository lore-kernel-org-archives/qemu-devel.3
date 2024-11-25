Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85820D58062
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFWvZ-0001Ci-DK; Mon, 25 Nov 2024 06:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tFWvL-00018Q-Ua; Mon, 25 Nov 2024 06:06:36 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tFWvH-000882-56; Mon, 25 Nov 2024 06:06:34 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E8DD65C5A30;
 Mon, 25 Nov 2024 11:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B13C4CECE;
 Mon, 25 Nov 2024 11:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732532787;
 bh=ncD7qidOGaWs7u0h7m5tQWNFFQUyTY10tZvsB2EhAV4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=suuCWMJg+WsQiT/et+/msfBICzWy2l89YiRFzvyLqlXufgwMA9kYoudvDV7Jz9my8
 LNLhHvEGpMgoF3iYY1V8i2DDR+gkvLf+kKb5ya8D+ga0ZtHYXw/SJuKBsYW2Ci0E2M
 FArecBcxXY3efH8aHsehy6MPo4ESVVMHNHCSHrlvifGA7eQgAlWLPwaJlnn7cKpEge
 IQclRtgqrenDmDPDaWbuqDB2R6lssc4JKwWFVLgcLV43zYP34uWGeI+0bSIVAm17+A
 +k+M7EaOsewRoFViNVKB+Oo/PcEJFcTOt8Lw64wt9Wm8HyFzpC2mYgCzR5AIuMO6U4
 apnf5tqc9q38A==
Date: Mon, 25 Nov 2024 12:06:16 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241125120616.6b89a1fe@sal.lan>
In-Reply-To: <20241122171944.4b5ac367@imammedo.users.ipa.redhat.com>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <b3845a8c78ef36c633d5e20af868de4ed16650a4.1732266152.git.mchehab+huawei@kernel.org>
 <20241122171944.4b5ac367@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Fri, 22 Nov 2024 17:19:44 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +
> > +    if (!physical_address) {
> > +        error_report("can not find Generic Error Status Block for source id %d",
> > +                     source_id);  
> 
> isn't it a copy paste error from somewhere, perhaps it's mixed up with something else?
> Granted, the check was there before patches but error message seems bogus.
> 
> Also 'physical_address' is a faulty page here, and 0 is as valid as any other value.
> I'd say we should drop the check, and if from ARM/KVM pov 0 addr shouldn't exist
> then it should be up to caller to filter it out and not call  acpi_ghes_record_errors()
> in the 1st place.

I'll add a patch just before this one removing the physical_address check,
and remove it from the moved function on this patch.

I'll submit a v5 once you review patches 13-15 from this series.

Regards,
Mauro

