Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA595CF9C6C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 04:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stJbk-00012z-SO; Wed, 25 Sep 2024 00:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJbS-0000z3-Qr; Wed, 25 Sep 2024 00:26:15 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1stJbR-0004UR-0g; Wed, 25 Sep 2024 00:26:14 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 74999A43B60;
 Wed, 25 Sep 2024 04:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A92C4CEC3;
 Wed, 25 Sep 2024 04:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727238367;
 bh=Ynfd0JRm++Nr2Ee+rhT8wlroxPnjzYV/SOrelhCelmg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qfvajQ7WG0ypVLqcmpWxo+kxj698Cwbnm+r/0YhOX3PEe3PnWkgW57a5A2eo0Ee7D
 B+LuTdFM+97a3BW1idyWzlu5ciUFDocJ+JUeYlmNmsb/8pEGOB4tYpXYdqzcIDnTCZ
 L1PHsV5f8TUQQpB7xX/T3CavZr5mhYoyJqYzLq541F/A6Y5AkdSM7rFkHfAqVNVtUo
 D5GK8ONk5257ePVWiM1eM8/8pndgpG6cmHbmVeZEtGDYE4cboH+ahc6ZQfzn7W+xyC
 PJ53wOCz70H5DQYV8woUPwZYfC9fHOSyTq8K5uat4f5y7bnp0zP6l6fsm9biw6giaB
 +kSl80LgePvqA==
Date: Wed, 25 Sep 2024 06:26:00 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v10 00/21] Add ACPI CPER firmware first error injection
 on ARM emulation
Message-ID: <20240925062600.7cbfeb19@foz.lan>
In-Reply-To: <20240924151429.3e758b38@imammedo.users.ipa.redhat.com>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <20240917141519.57766bb6@imammedo.users.ipa.redhat.com>
 <20240924150058.4879abe9@foz.lan>
 <20240924151429.3e758b38@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
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

Em Tue, 24 Sep 2024 15:14:29 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > 1) preparation patches:
...
> > 69850f550f99 acpi/generic_event_device: add an APEI error device  
> this one doesn't belong to clean ups, I think.
> Lets move this to #3 part

Ok.

> > The migration logic will require some time, and I don't want to bother
> > with the cleanup stuff while doing it. So, perhaps while I'm doing it,
> > you could review/merge the cleanups.
> > 
> > We can do the same for each of the 4 above series of patches, as it
> > makes review simpler as there will be less patches to look into on
> > each series.
> > 
> > Would it work for you?  
> 
> other than nit above, LGTM
> 

Ok, sent a PR with the first set (cleanups) at:

	https://lore.kernel.org/qemu-devel/cover.1727236561.git.mchehab+huawei@kernel.org/

You can see the full series at:

	https://gitlab.com/mchehab_kernel/qemu/-/commits/qemu_submission_v11b?ref_type=heads

It works fine, except for the migration part that I'm still working with.

For the migration, there are how two functions at ghes.c:

The one compatible with current behavior (up to version 9.1):
	https://gitlab.com/mchehab_kernel/qemu/-/blob/qemu_submission_v11b/hw/acpi/ghes.c?ref_type=heads#L411

And the new one using offsets calculated from HEST (newer versions):
	https://gitlab.com/mchehab_kernel/qemu/-/blob/qemu_submission_v11b/hw/acpi/ghes.c?ref_type=heads#L437 

With that, the migration logic can decide what function should be
called (currently, it is just checking if hest_addr_le is zero, but
I guess I'll need to change it to match some variable added by the
migration path.

Also, in preparation for the migration tests, I created a separate 
branch at:

	https://gitlab.com/mchehab_kernel/qemu/-/commits/ghes_on_v9.1.0?ref_type=heads

which contains the same patches on the top of 9.1, except for
the HEST ones. It also contains a hack to use ACPI_GHES_NOTIFY_GPIO
instead of ACPI_GHES_NOTIFY_SEA.

With that, we have a way to use the same error injection logic
on both 9.1 and upstream, hopefully being enough to test if migration
works.

Thanks,
Mauro

