Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7244BD1269A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 12:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8IX6-0006wE-TY; Tue, 05 Nov 2024 07:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8IX4-0006w3-O0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 07:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8IX2-0005Nw-EI
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 07:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730809173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azyYN7kkDYPZzIqtpPmghBjzTaRLP+tKBIT/rp86ZIM=;
 b=h/SKsPl/VXiq+UZH20Frf6tj4ajXVDaidPvuFT0YtRd/Q8fDY95Dvn39nwK+eTxlX55N0i
 fdSOfMEt/6ERQD6U6sGndYF6SmjQE/GYVmKx9um3HN5NuC/rFg5jVqBybe9WZuEdqPu10I
 UxgKupp/9dFqUJFYp+2K4l91vxcPkDU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-sMTGmjBeN3-gNT6w1aWpDw-1; Tue, 05 Nov 2024 07:19:32 -0500
X-MC-Unique: sMTGmjBeN3-gNT6w1aWpDw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso35643945e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 04:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730809171; x=1731413971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=azyYN7kkDYPZzIqtpPmghBjzTaRLP+tKBIT/rp86ZIM=;
 b=tWxAWoB8qbjPYX6LoPZRcOQ9++GfDj40RYi/TDdqsb4J4GiP3Mh/SCr2KNt0CS2UxA
 xl+mSaBki6gAJM2FifM9vITwpaIVp+vtqASQttcthSX/Y0Yx6pK/pGO7/XZjEZiESoju
 n4y6toKDxB0J4wWBMcGBStzNmesqxJ3ax9bRbX3NyJGDPZ0D9+IB9LllCc5Zt+pyXarT
 widZ79ew80Nk3fiPMbrzdpmP8AOGoxc9xfvGUuns8x94F69Cem//M27UKWY5UXu6I+lL
 HqalFPKrriL3rKmnOjRmrTVuHN8gCRfkhImZcpsnYLyQiAXW+3vqeb/7dVak8wuAMdGb
 VYqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeV+XiD/tcl0P61ourY+l2tauP+6Qf6P06s4bKNOmjb/Oc4MjwElQuicgcXuFvV0PnxXd7vi9hp5/u@nongnu.org
X-Gm-Message-State: AOJu0Yw1wwn0cupNtE/fwzoPFnNnG10td+M3xmnrsl1QhBykR+XKoqHf
 lhXUJcp6pi+qVE6hI6sLw0bbrNHxbKEps2e9q1cMc0UUfslkrs8oqTdNc2G4cgEWz/OB3pbcFuS
 gMvuwO1RDfm408CMDX9ggcDuWo1T9Xjvlw0Tmu/aeng1caxCVYyJK
X-Received: by 2002:a05:600c:1c15:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-43283297a37mr130630125e9.33.1730809171559; 
 Tue, 05 Nov 2024 04:19:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYjtAV2jDHqbMTJZejPdqpSe42VDGak2/VnFboiMDumTGTba5G9t6EUwi8Y/0lyuhpWLmI8w==
X-Received: by 2002:a05:600c:1c15:b0:42f:8fcd:486c with SMTP id
 5b1f17b1804b1-43283297a37mr130629795e9.33.1730809171146; 
 Tue, 05 Nov 2024 04:19:31 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116abf3sm16027241f8f.101.2024.11.05.04.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 04:19:29 -0800 (PST)
Date: Tue, 5 Nov 2024 13:19:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Horn <chorn@fluxcoil.net>
Cc: chorn@redhat.com, Anthony Harivel <aharivel@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, vchundur@redhat.com,
 rjarry@redhat.com, nathans@redhat.com, kenj@kenj.id.au,
 sunyanan.choochotkaew1@ibm.com, vibhu.sharma2929@gmail.com
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <20241105131927.5a038d3f@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZynFEr2vSeApNGG-@fluxcoil.net>
References: <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
 <ZxJbtkMO1QcoiqVn@redhat.com>
 <20241022144615.203cf0da@imammedo.users.ipa.redhat.com>
 <ZxelgDeuZaia-Vqf@redhat.com>
 <D52ED9BSZU9P.32LYD3328YTTN@redhat.com>
 <20241101160934.42d46c9f@imammedo.users.ipa.redhat.com>
 <D5BL7KCTSON6.36X2ZEWWQUIQ1@redhat.com>
 <20241104104900.1a2a0193@imammedo.users.ipa.redhat.com>
 <ZynFEr2vSeApNGG-@fluxcoil.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 5 Nov 2024 08:11:14 +0100
Christian Horn <chorn@fluxcoil.net> wrote:

> Hi all,
> 
> some thoughts:
> 
> - I vote for making the metrics as much as possible in the guest available
>   as on the host.  Allows cascading, and having in-guest-monitoring working
>   like on bare metal.
> - As result, really just plain vCPU consumption would be made available
>   in the guest as rapl-core.  If the host can at some point understand
>   guests GPU, or I/O consumption, better hand that in separately.
> - Having in mind that we will also need this for other architectures, 
>   at least aarch64.  RAPL comes from x86, rather than extending that
>   to also do I/O or such, we might aim at an interface which will also
>   work for aarch64.

+1 to both points

> - Bigger scope will be to look at the consumption of multiple systems, for
>   that we will need to move the metrics to network eventually, changing
>   from MSR or such mechanisms.

That's aren't VM scope though, which this topic is about.
But yes, the same tools as on baremetal can collect data and send/aggregate
them elsewhere. The main point from VM perspective is act just like baremetal
systems so the same monitoring tools could be reused. 

> - For reading the metrics in the guest, I was tempted to suggest PCP with
>   pmda-denki to cover RAPL, but it's right now just reading /sysfs, not
>   MSR's.  pmda-lmsensors for further sensors offered on various systems,
For NVF usecase, I also was eyeing pmda-denki.

How hard it would be to add MSR based sampling to denki?
Can we borrow Anthony's MSR sampling from
qemu-vmsr-helper, to reduce amount of work needed.

Also, for guest per vCPU accounting, we would need per thread
accounting (which I haven't noticed from a quick look at denki).
So some effort would be needed to add it there.  

I didn't know about pmda-lmsensors, I guess we should be able to use
it out of box with 'acpi power meter' sensor, if QEMU were to provide such.
I've also seen denki supporting battery power sensor, we can abuse that
and make QEMU provide that, but I'd rather add 'acpi power meter' sensor
to denki (which to some degree intersects with battery power sensor
functionality).

PS:
In this series Anthony uses custom protocol to get data from
privileged MSR helper to QEMU. Would it be acceptable?
Or is there a preferred way for PCP to do inter-process comms?

>   and pmda-openmetrics for covering anything appearing somewhere on
>   /sysfs as a number.

>  
> 
> > > Not that I disagree with all you said, to the contrary, but the amount 
> > > of change is quite significant and it would be very annoying if results 
> > > of this work doesn't make upstream because of Y & X.  
> > 
> > split frontend/backend design is established pattern in QEMU, so I'm not
> > suggesting anything revolutionary (probability that anyone would object
> > to it is very low).
> > 
> > sending an RFC can serve as a starting point for discussion.    
> 
> +1,
> Christian
> 


