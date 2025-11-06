Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8D6CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 10:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxJ6-0005Tc-MV; Thu, 06 Nov 2025 05:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxJ5-0005Su-Ql
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:33:31 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vGxJ2-0004Ju-Iq
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:33:31 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-63e336b1ac4so1091452d50.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762425207; x=1763030007; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BvCHELAhMlngvHmdCqWKZIHEvGaRU5uQaDtuWSFHUIA=;
 b=DMVNjb5txrP//mSiK6Vrzli9UTbXRy8DOTp6n6+d18B9M2oCb1vHebbcOWSw34/E7j
 XApwDm5eLPeBWL4wDdSKk2oenf8sngArKkctpCp5BREQk3w8XKG+TR/jDOhSL076v7Ju
 bZAX2eYsFoK1iE/u+ZktmOkudDBVOnMqhG/XGuWexbXcwSeKR3oPu+i0H8kBVh1zi7uw
 4dp5orTQZFS9JyGknWeKUH3vCbks4V4lt2ZsKgN7oMMxcI6NlrrGMsFZpXSZ6BWJAWwQ
 dFp+tA1izi85dckKmav9GzHYM2zclkpjAQEBq1Iwcx56WZ8jRaIVwjt7god184gJ+cmt
 u70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762425207; x=1763030007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvCHELAhMlngvHmdCqWKZIHEvGaRU5uQaDtuWSFHUIA=;
 b=msbBHcJ07IAnmSVbUjJQJ491F2OJqXcJzZtZ/joX+yXdsYhsmr8RJBryVydFB4/JWN
 RdgzCyGezToSpTTnnJ6/VO7utkMeygX0tMcNiens7cHipb6HDi+e+6bvP3YmKjyMeKNo
 hpF7OIoKgGT7CLB4U/qnIHB5vG84+3r9+2Dff5+1yZUdPiMrDIigMjBwq++0ZMgcMX5F
 jWhDJLqgG1SNbqRblvpY8UbRrvF9T2u9uFjoQcZTzOH1iWYnOdX2LyR3noTxLcRIJzz0
 qoSfcNzyVwowt9fTeuYwEZfSw8ICpPBW9TPgZMLqThDOtUcgHTVVFQrHUIT1ZLQlv+/i
 gp1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEEtAxzhzawcuLLFLJpDV15c/voVBFN+Ycpvh2G/pSP44iwmWcODLN8PQGMGKSTr9Q0Q1K45JVyj2p@nongnu.org
X-Gm-Message-State: AOJu0YxQPBeKZ23GcOJgHIAfTRtfPv+CF/FvOAuFqb5nBKO3NjO0Ofxw
 zcNCzWNItVcLoFAiZnAd5f3TeDKur0ykEobRPjA3Pm8g9mKqWYF2sexlgEAB7r9iMD+4x1ygDr2
 5x+gTdeNfsM111b/MzdMdlLD8/U1HOs+2q9tsnFerYw==
X-Gm-Gg: ASbGncufAi993uuZ44Rdzhjo7ULrKS38fUVVVtL4+AAOlzie+GD68Ii17w7HptKkYh7
 /iWWZHsm6ncsCATJYKkPNsWJlxjZymLbQedPn3U1wOnAyiUm8BHuOsqDrcIjMM0S88xTdh2/hXf
 y/HihhqPrbPHGXo2FkxVEVZ9KE7TscuYvZDKl2bX27KJPOmit6m1N1eIaUh0uvf8NdAB99z6yVK
 tx79CNWZNp1atlCRCtn7sn0uJIEJYqtyTXdhzq5mKRkFqxgmPekuQx3SR3qxFhnx7C1/FK6
X-Google-Smtp-Source: AGHT+IEco8bLn1SdsB2OCkJpWIfdZBvI5/OErgSrP53wCT4iJ+XywXWMoNjSSasx+XgSBb/f9znUSYlrdFNoTdVV73w=
X-Received: by 2002:a53:acce:0:20b0:63e:29af:bd23 with SMTP id
 956f58d0204a3-640b53db810mr1707371d50.4.1762425206886; Thu, 06 Nov 2025
 02:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20250129160059.6987-1-farosas@suse.de>
 <20250129160059.6987-8-farosas@suse.de>
 <CAFEAcA8_zO0MmyN2nQDZsmiWssoiSUvKRMVYfRLrz6TsNejQFA@mail.gmail.com>
 <aQuhvURPy3qhY64-@x1.local>
In-Reply-To: <aQuhvURPy3qhY64-@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Nov 2025 10:33:14 +0000
X-Gm-Features: AWmQ_bky7DlME38t5MRB4i-2-okJS38qIGD4aGOz9w08m0TIkT4Uj2JR_gJQALE
Message-ID: <CAFEAcA8-oboPd1VemPJb4v1qXAnBO07JbBrhdNfZ5Dy00brhPg@mail.gmail.com>
Subject: Re: [PULL 07/42] machine: aux-ram-share option
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Steve Sistare <steven.sistare@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 5 Nov 2025 at 19:13, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Nov 04, 2025 at 10:53:54AM +0000, Peter Maydell wrote:
> > On Wed, 29 Jan 2025 at 16:03, Fabiano Rosas <farosas@suse.de> wrote:
> > >
> > > From: Steve Sistare <steven.sistare@oracle.com>
> > >
> > > Allocate auxilliary guest RAM as an anonymous file that is shareable
> > > with an external process.  This option applies to memory allocated as
> > > a side effect of creating various devices. It does not apply to
> > > memory-backend-objects, whether explicitly specified on the command
> > > line, or implicitly created by the -m command line option.
> > >
> > > This option is intended to support new migration modes, in which the
> > > memory region can be transferred in place to a new QEMU process, by sending
> > > the memfd file descriptor to the process.  Memory contents are preserved,
> > > and if the mode also transfers device descriptors, then pages that are
> > > locked in memory for DMA remain locked.  This behavior is a pre-requisite
> > > for supporting vfio, vdpa, and iommufd devices with the new modes.
> >
> > Hi; I've just noticed that in this patch:
> >
> >
> > > @@ -1162,6 +1178,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
> > >      object_class_property_set_description(oc, "mem-merge",
> > >          "Enable/disable memory merge support");
> > >
> > > +#ifdef CONFIG_POSIX
> > > +    object_class_property_add_bool(oc, "aux-ram-share",
> > > +                                   machine_get_aux_ram_share,
> > > +                                   machine_set_aux_ram_share);
> > > +#endif
> >
> > we added a new class property to the machine, but we don't
> > call object_class_property_set_description() to give it any
> > help text (compare how we handle the other properties in this
> > function).
> >
> > > +
> > >      object_class_property_add_bool(oc, "usb",
> > >          machine_get_usb, machine_set_usb);
> > >      object_class_property_set_description(oc, "usb",
> >
> > This means that if you run "qemu-system-x86_64 -M q35,help"
> > you'll see that this option is missing help text:
> >
> > pc-q35-10.2-machine options:
> >   acpi=<OnOffAuto>       - Enable ACPI
> >   append=<string>        - Linux kernel command line
> >   aux-ram-share=<bool>
> >   boot=<BootConfiguration> - Boot configuration
> >   bus-lock-ratelimit=<uint64_t> - Set the ratelimit for the bus locks
> > acquired in VMs
> >   confidential-guest-support=<link<confidential-guest-support>> - Set
> > confidential guest scheme to support
> >   default-bus-bypass-iommu=<bool>
> > [etc]
> >
> > Would somebody like to write a patch to add the missing
> > description ?
>
> Thanks for reporting, sent "[PATCH] machine: Provide a description for
> aux-ram-share property" just now.
>
> PS: for q35 there's another one fd-bootchk=..

Yes; it was looking at the bug report about that
https://gitlab.com/qemu-project/qemu/-/issues/3193
that led me to spot the aux-ram-share option.

-- PMM

