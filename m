Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCD3D2B925
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Jkn-0000Hm-CS; Tue, 05 Nov 2024 08:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@mail.fluxcoil.net>)
 id 1t8Dio-0003Cd-7Q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:11:26 -0500
Received: from mail.fluxcoil.net ([2a03:4000:49:97::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@mail.fluxcoil.net>)
 id 1t8Dil-0005QR-Pw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fluxcoil.net;
 s=default; t=1730790674;
 bh=CPxCA2OHjYMl/o25eCxUnLUAYPx0HH8v1xZmWXrafSc=;
 h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
 b=SEIFXwWxX1aiiTsO0XSFQC9GY3SYGIB/PV33OHrBWM5szwQrM3JvTDcKGa+wGDBNr
 haOCowD0ZPAuVlZfLHpluC4QPFbk66EURO/DmTxxuy7McOvV86NNKHW7lJ0qelMkox
 +0WQ7SVMPbuqT+wL1NTpB3o463B6qFaZ2Fnj4eNDy8G4o0whCFlKY4Nt+GNqM/AjP6
 3qLkig6yCsShPp3VtNsQ/qqioaQMN0C5YaB1xlfI0QSx5058wdtP7q50XnKsPXUBMI
 MpCIz3hY/gEoR3/uHKDUL3viSLUDavzgV6pT9LGUH+fPNxJa3d3Blg7PB87nkg2FC2
 fEls2zHBIV/pA==
Received: by mail.fluxcoil.net (Postfix, from userid 1000)
 id CA812A0575; Tue,  5 Nov 2024 08:11:14 +0100 (CET)
Date: Tue, 5 Nov 2024 08:11:14 +0100
From: Christian Horn <chorn@fluxcoil.net>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com, rjarry@redhat.com, nathans@redhat.com,
 kenj@kenj.id.au, sunyanan.choochotkaew1@ibm.com, vibhu.sharma2929@gmail.com
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <ZynFEr2vSeApNGG-@fluxcoil.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104104900.1a2a0193@imammedo.users.ipa.redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a03:4000:49:97::2;
 envelope-from=chris@mail.fluxcoil.net; helo=mail.fluxcoil.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 05 Nov 2024 08:37:52 -0500
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
Reply-To: chorn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

some thoughts:

- I vote for making the metrics as much as possible in the guest available
  as on the host.  Allows cascading, and having in-guest-monitoring working
  like on bare metal.
- As result, really just plain vCPU consumption would be made available
  in the guest as rapl-core.  If the host can at some point understand
  guests GPU, or I/O consumption, better hand that in separately.
- Having in mind that we will also need this for other architectures, 
  at least aarch64.  RAPL comes from x86, rather than extending that
  to also do I/O or such, we might aim at an interface which will also
  work for aarch64.
- Bigger scope will be to look at the consumption of multiple systems, for
  that we will need to move the metrics to network eventually, changing
  from MSR or such mechanisms.
- For reading the metrics in the guest, I was tempted to suggest PCP with
  pmda-denki to cover RAPL, but it's right now just reading /sysfs, not
  MSR's.  pmda-lmsensors for further sensors offered on various systems,
  and pmda-openmetrics for covering anything appearing somewhere on
  /sysfs as a number.
 

> > Not that I disagree with all you said, to the contrary, but the amount 
> > of change is quite significant and it would be very annoying if results 
> > of this work doesn't make upstream because of Y & X.
> 
> split frontend/backend design is established pattern in QEMU, so I'm not
> suggesting anything revolutionary (probability that anyone would object
> to it is very low).
> 
> sending an RFC can serve as a starting point for discussion.  

+1,
Christian

