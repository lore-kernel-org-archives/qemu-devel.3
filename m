Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32992CF65E2
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 11:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkKh7-0005EQ-EJ; Mon, 26 Jan 2026 06:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vkKh5-0005Bg-Rv
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:23:43 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vkKh4-0002iE-Ah
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 06:23:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 03790419AE;
 Mon, 26 Jan 2026 11:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5708C116C6;
 Mon, 26 Jan 2026 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769426613;
 bh=pHEZcJ1nDPqLEUCFvidvT3zEBKPmxMiel4BntpxC2Ag=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RWrr/w7/0RHcdcqI+s+JS0L8vaU2MftnjiOc5KgzJBcyjs82rc91vHSbPdrVqyqLu
 Anynkxr5G5XbWfdofLd0iLfQdW1EBtVokWCsD2672NJ0pH1XQnw1eNtJOU0r0nZGY/
 QjypNMTQnrZ1ajhSys1gfhFNMyybhlmPRvTHwGM962xCoD6RedzqVhNN9MMRaOKDzQ
 4f1ZNmUHb59TN0IlO70pg4WdPQDzYEG7FfvpOPoSkSpzXn45nSWd36KHxQ0IYZydin
 9Yh/SvxB2+OBaa5pBCcSs57kZYhpKNbMrY0DJuI/Ee+YNmGRarRhvhDV0ML7xLU/K7
 Q7AyvsROY1VxQ==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vkKgt-0000000A4xH-0I5v; Mon, 26 Jan 2026 12:23:31 +0100
Date: Mon, 26 Jan 2026 12:23:30 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Michael S Tsirkin
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, Igor Mammedov
 <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH 06/13] scripts/qmp_helper: add support for a timeout logic
Message-ID: <20260126122330.515e5deb@localhost>
In-Reply-To: <20260123161603.00006b0d@huawei.com>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <2539e524dd467af51f8286bd1b201feaad06c81e.1768993993.git.mchehab+huawei@kernel.org>
 <20260121123927.00001daa@huawei.com> <aXD1Nb4MU2XYI0HL@foz.lan>
 <20260123161603.00006b0d@huawei.com>
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

On Fri, 23 Jan 2026 16:16:03 +0000
Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:

> > >     
> > > > +        for i in range(0, attempts):
> > > > +            try:
> > > > +                obj = self.qmp_monitor.cmd_obj(msg)
> > > > +
> > > > +                if obj and "return" in obj and not obj["return"]:
> > > > +                    break
> > > > +
> > > > +            except Exception as e:                     # pylint: disable=W0718
> > > > +                print(f"Command: {command}")
> > > > +                print(f"Failed to inject error: {e}.")
> > > > +                obj = None
> > > > +
> > > > +            if attempts > 1:
> > > > +                print(f"Error inject attempt {i + 1}/{attempts} failed.")
> > > > +
> > > > +            if i + 1 < attempts:
> > > > +                sleep(0.1)    
> > 
> > ... and here, we sleep for 0.1 seconds.
> >   
> > > 
> > > Do we care about a sleep at the end?  Feels like a micro optimization that
> > > isn't needed.    
> > 
> > This is not a micro-optimization. It is more to ensure that we won't
> > respin it too fast.
> > 
> > What happens is that QMP interface asks the BIOS to send an async
> > message to OSPM, cleaning an ack register. When the OSPM reads the
> > error, it writes 1 to the ack register.
> > 
> > If we send messages too fast, the logic at ghes.c will detect that
> > the ack didn't happen, imediately returning an errocr code.
> > 
> > On such case, we sleep for 100ms before trying again.  
> I was suggesting the opposite.  Just sleep one more time at the end
> before timing out.
> So instead of
> 	if i + 1 < attempts
> 		sleep(0.1)
> 
> simply
> 	sleep(0.1)

If one writes an external loop calling fuzzy with different parameters,
like:

	for i in $(seq 1 360000); do
            scripts/ghes_inject.py fuzzy -T proc-arm;
            scripts/ghes_inject.py fuzzy -T firmware-error;
        done

The extra unneeded would sleep waste 10 hours doing nothing.

Regards,
Mauro

