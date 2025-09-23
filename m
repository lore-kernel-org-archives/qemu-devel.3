Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56372CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 06:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0wZ9-0007u8-AI; Tue, 23 Sep 2025 02:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0wZ2-0007sU-Sx; Tue, 23 Sep 2025 02:31:48 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1v0wYz-0002Eb-TV; Tue, 23 Sep 2025 02:31:48 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C190A4191D;
 Tue, 23 Sep 2025 06:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1336C4CEF5;
 Tue, 23 Sep 2025 06:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758609087;
 bh=RsUOjWNMuW8fTpkA5v4oUy7565EFHVMf8hFPI9OPMWk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gz6bM0kUbawRQUyoC68iDL5h886rZ+Jy6rW3K07YmvngJ2U89xF/+tW1olgHdTa2+
 v3TmCTlTQie/83DjYk6i0ExLcciOInRWtfIj/aIoQ5fo7klHOXMzJ8qYhVbOrzEZ4R
 jTsLQNr6d29NctyYNI6K+zJ/kjDj8y/2nbCb+UvB7abTgb6B1YjEl7+hWnLamDzBWf
 4rfAPZ0XC/biw/GRkSd4vjcHpjpO4Iqe/UJNluwEJjt6zJlfNqygHutDNh+wJLrR2I
 +PwYM7zBw4w+UOkmJcy4SH6D4sH4KtATpdmU4Zzp1CnElhmwPz47pGw9Sa4ynP4u+d
 kPbiOzG2e8Gmw==
Date: Tue, 23 Sep 2025 08:31:22 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v11 17/17] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20250923083122.6b75ae82@foz.lan>
In-Reply-To: <20250922084417-mutt-send-email-mst@kernel.org>
References: <cover.1757084668.git.mchehab+huawei@kernel.org>
 <41cfda8170605a25a795b555cdb49402af4ef5b0.1757084668.git.mchehab+huawei@kernel.org>
 <20250922084417-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Em Mon, 22 Sep 2025 08:48:03 -0400
"Michael S. Tsirkin" <mst@redhat.com> escreveu:

> On Fri, Sep 05, 2025 at 05:09:24PM +0200, Mauro Carvalho Chehab wrote:

> > diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
> > new file mode 100644
> > index 000000000000..1dd42e42a877
> > --- /dev/null
> > +++ b/scripts/arm_processor_error.py
> > @@ -0,0 +1,476 @@  
> 
> Malformed patch: script only has 474 lines.

Sorry for that. This time I sent the series with a new (not so) shiny 
mailbomb script, I rewrote in Python. It turned to be a big headache to
use python EmailMessage class: it always ended badly encoding something.
It also affected patches I sent to the Kernel, badly handling utf-8 chars
and "\" characters. I gave up on it and I'm reusing my 10+ years old Perl
script again.

Sorry for that.

> > +#!/usr/bin/env python3
> > +#
> > +# pylint: disable=C0301,C0114,R0903,R0912,R0913,R0914,R0915,W0511
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2024-2025 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > +
> > +# TODO: current implementation has dummy defaults.
> > +#
> > +# For a better implementation, a QMP addition/call is needed to
> > +# retrieve some data for ARM Processor Error injection:
> > +#
> > +#   - ARM registers: power_state, mpidr.
> > +
> > +"""
> > +Generates an ARM processor error CPER, compatible with  
> 
> Generates -> Generate
> 
> prefer imperative mood
> 
> > +UEFI 2.9A Errata.
> > +
> > +Injecting such errors can be done using:
> > +
> > +    $ ./scripts/ghes_inject.py arm
> > +    Error injected.
> > +
> > +Produces a simple CPER register, as detected on a Linux guest:
> > +
> > +[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> > +[Hardware Error]: event severity: recoverable
> > +[Hardware Error]:  Error 0, type: recoverable
> > +[Hardware Error]:   section_type: ARM processor error
> > +[Hardware Error]:   MIDR: 0x0000000000000000
> > +[Hardware Error]:   running state: 0x0
> > +[Hardware Error]:   Power State Coordination Interface state: 0
> > +[Hardware Error]:   Error info structure 0:
> > +[Hardware Error]:   num errors: 2
> > +[Hardware Error]:    error_type: 0x02: cache error
> > +[Hardware Error]:    error_info: 0x000000000091000f
> > +[Hardware Error]:     transaction type: Data Access
> > +[Hardware Error]:     cache error, operation type: Data write
> > +[Hardware Error]:     cache level: 2
> > +[Hardware Error]:     processor context not corrupted
> > +[Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
> > +
> > +The ARM Processor Error message can be customized via command line
> > +parameters. For instance:
> > +
> > +    $ ./scripts/ghes_inject.py arm --mpidr 0x444 --running --affinity 1 +        --error-info 12345678 --vendor 0x13,123,4,5,1 --ctx-array 0,1,2,3,4,5 +        -t cache tlb bus micro-arch tlb,micro-arch  
> 
> Weird formatting. Are these + signs intentional here?
> Oh, maybe that is where the 2 missing lines are hiding.

Nope. Broken mailbomb script: EmailMessage decided to handle itself 
lines ended with "\", even after being asked to parse an e-mail as
binary.

For v12 I'll be using the old script which doesn't corrupt patches.

Thanks,
Mauro

