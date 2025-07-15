Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19D3C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 12:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubeyz-0005vi-TM; Tue, 15 Jul 2025 08:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1ubeb0-00006m-5K
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1ubeav-0004xb-LM
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752581829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dwwg2nozHDDp5DEj+1k50w5oqRARFs12qVFYJg7iqrk=;
 b=i7YsdLMi3BuYtvurip+rSUzfMtiD0+ufB5fbmBYrNZ/ow9gcLqAM048cQKFcBsBxY8BjHO
 h119CLKIlraLIrCu3X5Y+6+rtrN+7XyW9x2c5MYPGmYnoqbIu8ILnpxTGBJtDjnJ/KdDM9
 6fFZwhj3deK5nuVOybZdcEbuQUIKvEI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-426yG1qnPvO01AKCBviImg-1; Tue, 15 Jul 2025 08:17:08 -0400
X-MC-Unique: 426yG1qnPvO01AKCBviImg-1
X-Mimecast-MFC-AGG-ID: 426yG1qnPvO01AKCBviImg_1752581827
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ab76d734acso23219931cf.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 05:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752581827; x=1753186627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dwwg2nozHDDp5DEj+1k50w5oqRARFs12qVFYJg7iqrk=;
 b=ebgVGGPEVCmBCeYGuTPXPq1lRRsQYvV2tEsAjPmbm57SnjAJFGNG8H6Tw6FrLj1bJE
 pJMfXTl8yufVsxVezRvDAlCIV099B2px9eOZqLPws/AtG/6lq4h9ycwhS5tlIcLQDIPA
 1BK8rHqKdpxs9DiGUAALI4zSecHJz6rUInXc+D6Pvcm/d7RuBq8k6GRVrTpxDKBJxtaR
 d3kWI8V0DRu/QFvrxBLQGwtybmCSEqmEgJ4af8vh3NWTiCPs7gg9l7f7232aWet6tzc0
 Av7iT58KRpsoRGErNWsDh5Ebs+FyUIurafkXhnvToInxVIrYvvDmep6wf94+/togT4pZ
 +EbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj5Dldo957ffinuOtq+0lp1riB7wgzlqCoYSDzokUXAD0JXBbuwJcTSafw+iow/wD+mR5IrnfJCPnE@nongnu.org
X-Gm-Message-State: AOJu0YzAbLtBaPcZtIouNMeamHzseQpgl+IlX0ZNYBxmGUWSHYZhyz6x
 zDV2/xVWLwtagDqiOoBJ2ENYFytIws9ZVxUQkdHfYf1rPG3awVLD5SUD4mMxuTRZdUbtvMnfjqj
 SH2M63c3TOd/un3bWcznIeMneSIMJgYe2oF4aj+lkk6KiqGcwYNpqYL3HSHuz+/FcydNdBSR3dd
 OWTQ4pIf3+k4+suTfNGB1BU0ayhOxRP2E=
X-Gm-Gg: ASbGncugQcoG4ex34xPSYSgQSxSZaUmRykizzE1gYCq1T5GYs81Rjtaj2MyK2AfU7wa
 eSPyv5tsH42A52VFPwlhfHwWFWOIsnFSEZPQDJki5CgiaVKNKbCNlx7WfRnm4RazwMJNdpn0Hie
 WgETlvK5XI1xPlBgox9fMr0w==
X-Received: by 2002:a05:622a:5915:b0:4ab:6e3d:49b4 with SMTP id
 d75a77b69052e-4ab7f771107mr48299361cf.7.1752581827292; 
 Tue, 15 Jul 2025 05:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAE7LmQPq5pMtiGvnmETeHGp6RIU3KfK6GqYb2TzxvNdgiMXR9VJ23KSqtriF8GRnN4UrSucV3kHRQ1pbPBto=
X-Received: by 2002:a05:622a:5915:b0:4ab:6e3d:49b4 with SMTP id
 d75a77b69052e-4ab7f771107mr48298871cf.7.1752581826817; Tue, 15 Jul 2025
 05:17:06 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 05:17:05 -0700
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 05:17:05 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20250610143259.1056400-1-cohuck@redhat.com>
 <20250610143259.1056400-3-cohuck@redhat.com>
 <aEhnbN1pSYgdi4EZ@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aEhnbN1pSYgdi4EZ@redhat.com>
Date: Tue, 15 Jul 2025 05:17:05 -0700
X-Gm-Features: Ac12FXxdRfeGjvlYx6R0iALVJA5YylVmMVXC5Y8e6qk7H3MD4dS2q_cga3iDw-E
Message-ID: <CABJz62O3FKYfUOyCLMotgYgckWV1frSUb=MtTW2J4fDTEg_==g@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: generic name for i6300esb
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 10, 2025 at 06:12:12PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jun 10, 2025 at 04:32:59PM +0200, Cornelia Huck wrote:
> > The Intel 6300 Enterprise SouthBridge is a south bridge for a more or
> > less obscure embedded Intel system; however, the i6300esb watchdog
> > device we implement in QEMU is a virtual watchdog device that should
> > work well on any PCI-based machine, is well supported by Linux guests,
> > and used in many examples on how to set up a virtual watchdog.
> >
> > Let's use "virtual i6300ESB" in the description to make clear that
> > this device will work just fine on non-Intel platforms.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/watchdog/wdt_i6300esb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I'm not entirely sold on the idea that this is needed, but at the same
> time I won't object so
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I would argue that this change is incorrect.

While the QEMU device can be used for non-x86 VMs, it *is* faithfully
modelled after an Intel part, and the guest OS will recognize it as
such:

  # lspci | grep 6300
  07:01.0 System peripheral: Intel Corporation 6300ESB Watchdog Timer

What we actually need to do is create a new QEMU device with distinct
PCI IDs, same as we've done in the past for qemu-xhci, pcie-root-port
and pcie-to-pci-bridge.

That will take a lot longer to integrate throughout the stack and be
supported across the various guest OS, but it's the only approach
that eventually leads to truly Intel-free non-x86 VMs.

--=20
Andrea Bolognani / Red Hat / Virtualization


