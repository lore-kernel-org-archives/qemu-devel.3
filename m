Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81502CF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5Ac-0002RT-3J; Tue, 24 Sep 2024 09:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1st5AK-0001Jt-Ay; Tue, 24 Sep 2024 09:01:24 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1st5AI-00084i-7z; Tue, 24 Sep 2024 09:01:15 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B3017A42521;
 Tue, 24 Sep 2024 13:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF214C4CEC4;
 Tue, 24 Sep 2024 13:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727182865;
 bh=OakmT0sLzny8R4JiJYYxGXCumP8RVBEVBkER1UAFCqc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EZOrhIEr2zgqlMHomrBGjn4qf2AhbOE/5eB6mnm/2fuMtMJ+ZgpprUbomnoTqy7hw
 r845phN3j3ryzwrH2oXkLMqqrumYvGXzTZfHVZpbDthcvk5Co+iBR1CYw9D9ouqE/b
 S2vajtRzNG2NBx7rDe9ELDr3c7gwBmoPDeYzuRcPQ0lsg6xuk9/x5ydgxqIxvHhA3H
 NyvraLkHZlKLx73aIrpNLGuZdvHu0WCxU4h4Xkjook5JGxWETUEEvm6Pa44qnp0Xj+
 y+D8ma5QUUc8fVqqVHPKUHghpVWrRgPY/uBJ+hDsN5SDWocjSK8eIxfOXB1fnjliL8
 UIHsflQBF+d+Q==
Date: Tue, 24 Sep 2024 15:00:58 +0200
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
Message-ID: <20240924150058.4879abe9@foz.lan>
In-Reply-To: <20240917141519.57766bb6@imammedo.users.ipa.redhat.com>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <20240917141519.57766bb6@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Em Tue, 17 Sep 2024 14:15:19 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> I'm done with this round of review.
> 
> Given that the series accumulated a bunch of cleanups,
> I'd suggest to move all cleanups/renamings not related
> to new HEST lookup and new src id mapping to the beginning
> of the series, so once they reviewed they could be split up into
> a separate series that could be merged while we are ironing down
> the new functionality. 

I've rebased the series placing the preparation stuff (cleanups
and renames) at the beginning. So, what I have now is:

1) preparation patches:

41709f0898e1 acpi/ghes: get rid of ACPI_HEST_SRC_ID_RESERVED
5409daa41c78 acpi/ghes: simplify acpi_ghes_record_errors() code
2539f1f662b9 acpi/ghes: better handle source_id and notification
3f19400549c1 acpi/ghes: Remove a duplicated out of bounds check
f0b06ecede46 acpi/ghes: Change the type for source_id
9f08301ac195 acpi/ghes: Prepare to support multiple sources on ghes
2426cd76e868 acpi/ghes: make the GHES record generation more generic
3fb7ec864700 acpi/ghes: better name GHES memory error function
1a22dad3211e acpi/ghes: don't crash QEMU if ghes GED is not found
726968d4ee20 acpi/ghes: rename etc/hardware_error file macros
f562380da7ce docs: acpi_hest_ghes: fix documentation for CPER size
69850f550f99 acpi/generic_event_device: add an APEI error device

Patches were changed to ensure that they won't be add any new
new features. They are just code shift in order to make the diff
of the next patches smaller.

There is a small point here: the logic was simplified to only
support a single source ID (I added an assert() to enforce it) and
simplified the calculus in preparation for the HEST and migration
series.


2) add a BIOS pointer to HEST, using it. The migration stuff
will be along those:

c24f1a8708e3 acpi/ghes: add a firmware file with HEST address
853dce23ec39 acpi/ghes: Use HEST table offsets when preparing GHES records
c148716fd7c8 acpi/generic_event_device: Update GHES migration to cover hest addr

Up to that, still no new features, but the offset calculus will be
relative to HEST table and will use the bios pointers stored there;

3) Add support for generic error inject:

f5ec0d197d82 acpi/ghes: add a notifier to notify when error data is ready
f5e015537209 arm/virt: Wire up a GED error device for ACPI / GHES
3b6692dbf473 qapi/acpi-hest: add an interface to do generic CPER error injection
620a5a49f218 scripts/ghes_inject: add a script to generate GHES error inject

4) MPIDR property:
2dd6e3aae450 target/arm: add an experimental mpidr arm cpu property object
02c88cd4daa2 scripts/arm_processor_error.py: retrieve mpidr if not filled

I'm still testing if the rebase didn't cause any issues. So, the above
may still change a little bit. I also need to address your comments to the
cleanup patches and work at the migration, but just want to double check if
this is what you want.

If OK to you, my plan is to submit you the cleanup patches after I
finish testing the hole series.

The migration logic will require some time, and I don't want to bother
with the cleanup stuff while doing it. So, perhaps while I'm doing it,
you could review/merge the cleanups.

We can do the same for each of the 4 above series of patches, as it
makes review simpler as there will be less patches to look into on
each series.

Would it work for you?

Thanks,
Mauro

