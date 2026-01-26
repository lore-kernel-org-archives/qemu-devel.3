Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6C7CF65E1
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 11:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKmq-0000b2-K5; Mon, 26 Jan 2026 06:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vkKmp-0000Xr-1j
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:29:39 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vkKmn-0004m1-6k
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:29:38 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DAD3943F79;
 Mon, 26 Jan 2026 11:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B874BC19422;
 Mon, 26 Jan 2026 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769426975;
 bh=l/1uBwAO+PnB2F/kL5LKuMAOim3d7Sri3CKK64Pifbg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tADunJMI7O4KkY1GU5Lf6EnW2m8uAzTJD8m/CnTXvsOZuRapZDvKqVV4YDX/35uwd
 Uk8DRVLjvucbOqQ6Zt2Dv+jAbBWsp1ANr5xJn7TdYIGl3VP5f1w9a4bq7c8Z5dnH2Z
 VHjA0Sy0gTJFXTWDQUAkkfY6wJm88L7EHZgkjdEZGUiRBZTJCBlizvh2h+N3BT7Vqo
 USLjZYNedqzKE54dUDKxEbeZbwTTw6RSZk07aYEiZ2TMJqM2yHiqHlnVsA+MU+0Nty
 7g913HQ1ZSJN+GnNbIDN0wv1Lz6N2alDJ477QYNBsXFKpgxK1OJjibRkKxkReACqk/
 J2+Hpmj/mkfOQ==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vkKmj-0000000A5DA-2R4k; Mon, 26 Jan 2026 12:29:33 +0100
Date: Mon, 26 Jan 2026 12:29:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Michael S Tsirkin
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, Igor Mammedov
 <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 06/13] scripts/qmp_helper: add support for a timeout logic
Message-ID: <20260126122932.10a3d552@localhost>
In-Reply-To: <20260126122330.515e5deb@localhost>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <2539e524dd467af51f8286bd1b201feaad06c81e.1768993993.git.mchehab+huawei@kernel.org>
 <20260121123927.00001daa@huawei.com> <aXD1Nb4MU2XYI0HL@foz.lan>
 <20260123161603.00006b0d@huawei.com>
 <20260126122330.515e5deb@localhost>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 26 Jan 2026 12:23:30 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> (by way of Mauro Carvalho Chehab <mchehab+huawei@kernel.org>) wrote:

> On Fri, 23 Jan 2026 16:16:03 +0000
> Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:
> 
> > > >     
> > > > > +        for i in range(0, attempts):
> > > > > +            try:
> > > > > +                obj = self.qmp_monitor.cmd_obj(msg)
> > > > > +
> > > > > +                if obj and "return" in obj and not obj["return"]:
> > > > > +                    break
> > > > > +
> > > > > +            except Exception as e:                     # pylint: disable=W0718
> > > > > +                print(f"Command: {command}")
> > > > > +                print(f"Failed to inject error: {e}.")
> > > > > +                obj = None
> > > > > +
> > > > > +            if attempts > 1:
> > > > > +                print(f"Error inject attempt {i + 1}/{attempts} failed.")
> > > > > +
> > > > > +            if i + 1 < attempts:
> > > > > +                sleep(0.1)    
> > > 
> > > ... and here, we sleep for 0.1 seconds.
> > >   
> > > > 
> > > > Do we care about a sleep at the end?  Feels like a micro optimization that
> > > > isn't needed.    
> > > 
> > > This is not a micro-optimization. It is more to ensure that we won't
> > > respin it too fast.
> > > 
> > > What happens is that QMP interface asks the BIOS to send an async
> > > message to OSPM, cleaning an ack register. When the OSPM reads the
> > > error, it writes 1 to the ack register.
> > > 
> > > If we send messages too fast, the logic at ghes.c will detect that
> > > the ack didn't happen, imediately returning an errocr code.
> > > 
> > > On such case, we sleep for 100ms before trying again.  
> > I was suggesting the opposite.  Just sleep one more time at the end
> > before timing out.
> > So instead of
> > 	if i + 1 < attempts
> > 		sleep(0.1)
> > 
> > simply
> > 	sleep(0.1)
> 
> If one writes an external loop calling fuzzy with different parameters,
> like:
> 
> 	for i in $(seq 1 360000); do
>             scripts/ghes_inject.py fuzzy -T proc-arm;
>             scripts/ghes_inject.py fuzzy -T firmware-error;
>         done
> 
> The extra unneeded would sleep waste 10 hours doing nothing.

Btw, the same applies when using the -c parameter:

             scripts/ghes_inject.py fuzzy -T proc-arm -c 360000

The goal here is to optimize in a way that we could one day have a
CI running lots of tests in a reasonable time to detect regressions
at QEMU + Linux Kernel + rasdaemon.

So, we don't want unneeded delays. We only need to sleep if a
retry attempt failed and it will be retrying again.

Regards,

