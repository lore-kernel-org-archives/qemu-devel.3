Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE04C5321D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 23:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shdht-0002Sc-Ud; Fri, 23 Aug 2024 19:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1shdhs-0002Rk-PW; Fri, 23 Aug 2024 19:28:36 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1shdhq-0002IQ-JV; Fri, 23 Aug 2024 19:28:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B2025CE1277;
 Fri, 23 Aug 2024 23:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57787C32786;
 Fri, 23 Aug 2024 23:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724455701;
 bh=qUWlsVBaCvs/ScOoZEuc4eDAUzoBoNdCnkHyMXoBP0Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=vORTuiKbLxZNPOEQ0PzthnF0YH6X3D3t02uOkqzxXEq3ydhuflVlK3Waov1PUgvD3
 7cF8XEuVzOfd9feh4tnCeA5ZFXAep0b31PKMPFr1s0danzrge9wOW0+haFLp1CCj/S
 lQOizMv3uah49tKyOFUH8fpRFmgXA9loFR6Pa+w8xkdzzHG6hqcj9josDJwMI6JLjy
 JZk0F/3AUmy4xUbjEERKYoPRKj8ckzWxQfe1WsNR+bzzR9u3BObxclWpPquTBY5tns
 MNvjEK8mV5/IxshEJXM62Wjf9e9cUjTXPuZtMJkwbgdpizZSn0w1f6hMAPFWAv6x0R
 IOMmxMh68Yg1g==
Date: Sat, 24 Aug 2024 01:28:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 03/13] acpi/ghes: Add support for GED error device
Message-ID: <20240824012806.6189d0a4@sal.lan>
In-Reply-To: <20240819134304.68c54eae@imammedo.users.ipa.redhat.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <ba1864f1aa7073abe090eec0c31915f187967140.1723793768.git.mchehab+huawei@kernel.org>
 <20240819134304.68c54eae@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Em Mon, 19 Aug 2024 13:43:04 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 16 Aug 2024 09:37:35 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > As a GED error device is now defined, add another type
> > of notification.
> > 
> > Add error notification to GHES v2 using
> >a GED error device GED triggered via interrupt.  
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is hard to parse, perhaps update so it would be
> more clear what does what
> 
> > 
> > [mchehab: do some cleanups at ACPI_HEST_SRC_ID_* checks and
> >  rename HEST event to better identify GED interrupt OSPM]
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---  
> 
> in addition to change log in cover letter,
> I'd suggest to keep per patch change log as well (after ---),
> it helps reviewer to notice intended changes.
> 
> 
> [...]
> > +    case ACPI_HEST_SRC_ID_GED:
> > +        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_GPIO);  
> While GPIO works for arm, it's not the case for other machines.
> I recall a suggestion to use ACPI_GHES_NOTIFY_EXTERNAL instead of GPIO one,
> but that got lost somewhere...

True, but the same also applies to SEA, which is ARMv8+. After having
everything in place, I confined the source ID into this code inside
ghes.c:

	enum AcpiHestSourceId {
	    ACPI_HEST_SRC_ID_SEA,
	    ACPI_HEST_SRC_ID_GED,

	    /* Shall be the last one */
	    ACPI_HEST_SRC_ID_COUNT
	} AcpiHestSourceId;

	static bool ghes_notify_to_source_id(enum AcpiGhesNotifyType notify,
	                                     enum AcpiHestSourceId *source_id)
	{
	    switch (notify) {
	    case ACPI_GHES_NOTIFY_SEA:             /* ARMv8 */
	        *source_id = ACPI_HEST_SRC_ID_SEA;
	        return false;
	    case ACPI_GHES_NOTIFY_GPIO:
	        *source_id = ACPI_HEST_SRC_ID_GED;
	        return false;
	    default:
	        /* Unsupported notification types */
	        return true;
	    }
	}

The only place where the source ID number is used is at
ghes_notify_to_source_id() - still we use ACPI_HEST_SRC_ID_COUNT on other
places to initialize and fill in the HEST table and its error source 
structures.

On other words, the source ID field is filled from the notification types as
defined at include/hw/acpi/ghes.h:

    ACPI_GHES_NOTIFY_POLLED = 0,
    ACPI_GHES_NOTIFY_EXTERNAL = 1,
    ACPI_GHES_NOTIFY_LOCAL = 2,
    ACPI_GHES_NOTIFY_SCI = 3,
    ACPI_GHES_NOTIFY_NMI = 4,
    ACPI_GHES_NOTIFY_CMCI = 5,
    ACPI_GHES_NOTIFY_MCE = 6,
    ACPI_GHES_NOTIFY_GPIO = 7,
    ACPI_GHES_NOTIFY_SEA = 8,
    ACPI_GHES_NOTIFY_SEI = 9,
    ACPI_GHES_NOTIFY_GSIV = 10,
    ACPI_GHES_NOTIFY_SDEI = 11,

(please notice that ACPI already defines "EXTERNAL" as being something 
else)

Now, if we want to add support for x86, we could either add some ifdefs
inside ghes.c, e. g. something like:

	enum AcpiHestSourceId {
	#ifdef TARGET_ARM
	    ACPI_HEST_SRC_ID_SEA,
	    ACPI_HEST_SRC_ID_GED,
	#endif
	#ifdef TARGET_I386
	   ACPI_HEST_SRC_ID_MCE,
        #endif

	    /* Shall be the last one */
	    ACPI_HEST_SRC_ID_COUNT
	} AcpiHestSourceId;

and something similar at ghes_notify_to_source_id():
	static bool ghes_notify_to_source_id(enum AcpiGhesNotifyType notify,
	                                     enum AcpiHestSourceId *source_id)
	{
	    switch (notify) {
	#ifdef TARGET_ARM
	    case ACPI_GHES_NOTIFY_SEA:             /* ARMv8 */
	        *source_id = ACPI_HEST_SRC_ID_SEA;
	        return false;
	    case ACPI_GHES_NOTIFY_GPIO:
	        *source_id = ACPI_HEST_SRC_ID_GED;
	        return false;
	#endif
	#ifdef TARGET_I386
	    case ACPI_GHES_NOTIFY_MCE:
	        *source_id = ACPI_HEST_SRC_ID_MCE;
	        return false;
	#endif
	    default:
	        /* Unsupported notification types */
	        return true;
	    }
	}

An alternative would be to move source id/notification code out, placing
them at hw/arm, hw/i386, but a more complex binding logic will be needed.

If we're willing to do something like that, I would prefer to not do such
redesign now. Better to do such change when we'll be ready to add some 
notification support that works on x86 (MCE? SCI? NMI?).

Regards,
Mauro

