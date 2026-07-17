Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5FBC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkj2a-0000a6-AJ; Fri, 17 Jul 2026 09:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkj2X-0000ZL-9C
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkj2U-0002wF-WC
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784296542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gkJPRonxFAdLMfRYaeucxbkp4HT737Jnx3N5/XSgThw=;
 b=f/q4x2ESQl84lH5AauEipF3D/IDo1x5gadNHINkPcLMoN+VnUHrhtQGdE80ncD92J1U1eN
 jA46/nVSsSLeGN14DcYBs7qVKOK7pAPSs4fCoQJh7Jf5on6mpxucsd4qrWuSx1Tked52cx
 J5L3qrrb9qcEQto1dIzR+0yzBJ6c0pw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-_kgoVfb3O5a0DoGAQTHleQ-1; Fri, 17 Jul 2026 09:55:40 -0400
X-MC-Unique: _kgoVfb3O5a0DoGAQTHleQ-1
X-Mimecast-MFC-AGG-ID: _kgoVfb3O5a0DoGAQTHleQ_1784296539
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so5060514f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784296539; x=1784901339; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gkJPRonxFAdLMfRYaeucxbkp4HT737Jnx3N5/XSgThw=;
 b=kb+sglKJrQ4eqcfsJL8CcVM/mfk+kTwIu+i9u1C7hT6+K/JFGWFvv/5peS3T6U2Mot
 m9tLyk1ghc4GbEBsiRSmjfmFgxdtAxZJX3Q3WZdlfIIEVF3MBKFBvezRxmIfPC19eyle
 MRgCQXWfYp8CbW8kbj1igEcxlN4qWT93XFEhr6jUJKUgnA0vCK8JS8fh53Tr4ZR9a4T0
 nvicaa1K3EiffJZeWR+H8PZuRMPEVnOZTAId7I4INh/rYpYL+KAHuwOB/7BH7Hxf+ePT
 gWsCbdGRIfJ/P47bjbZc9d76CeUlSJl2l4LnlTBkdhafo0/28ov8rJ/fPM4AvFJtiyhN
 E0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296539; x=1784901339;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gkJPRonxFAdLMfRYaeucxbkp4HT737Jnx3N5/XSgThw=;
 b=kzWJ75lK8RqxsqIxsUWduolHGKz+xhOJ0iLlBtfWgqR8Vc2sR0DnCIOl5hOLTBJCPY
 bxHKhzQoX5G/ucdfnzL/UPdv8V3OFxuEfCxi2Y2rFv1oaRQEwshW8fuoi6P+FPp4jM/b
 97rgKmTXT/L8/0uIIw93oPozWSBz4GVqEeAZCUZ7OWiSVN74QsX+dDXu2AKysZy3T/KO
 rSbfS6UgL/HJttWtEbvltBthxNUmaYExQp3LG5GSj9ycdwj7Ob3lg5gxcmxT/o2qoQR8
 2+P1LCF3XZ0UsUVuMrtkk9bZrVU/dUag1NN7oYutloB4BYt+w3j8TAx1ZBN3icibp0Th
 wEMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqekqXRP/ZvScWwiXxu3nOXmlOSrO2oSF8CbXaJPdI941iydHMTybO1jOAhKaQJBxDGoKx3uzDAEA/T@nongnu.org
X-Gm-Message-State: AOJu0YzJpKX9hk+DxrmTq/WhnWPr7ka75rtt7UtZrtEe+sM3lU0ksaX7
 yIFyRijM/IQc7f4InVpWDCCzmxqj6Eg2XNv5qMDGYm4Th6RkqkFRJBqmvgHuSkyEsoiq09hLjip
 HZxR/A4EzgkGxsg+fcljOFSgLAWBAXQbzbdxjCrnIMjcSaKrC6hGn0X/N
X-Gm-Gg: AfdE7ckSiJvevaaADdrZlnPVrR+5SAhn8E99RVvek9JujAzDi7aIwbY4bmcKLfhM+aJ
 uNFLyC19csOIGBykk5bNN8FtCIE2uE5VVmQP+NSoakgSkF0Y6T4Sg8nTxousXOL3A/wQJ/8NT/3
 5yyawXa6x3bzQnCI6o7YYyGH/rpHOKY4+AknftSZwskAOMfj94SPCE7Xko7Zq5RcApJoSGKpXhI
 TyfPM65QryJdY4ihjS3Ikr0x35vWJICmYs5esx+GAEsGJkQdNalCunAMycZL6rGKEIgClKJpOpv
 5bCoaoQxqQeSuTCKcXsvUvDFAuddSSC510AAiMFQm1mZxX+3e5V35vTZHROCP08gr1l9eBX+GNM
 YqXEumJNxJLGXSzROYJfS/s9I
X-Received: by 2002:a05:6000:41d3:b0:47d:e547:8965 with SMTP id
 ffacd0b85a97d-47f6233fbe9mr3585463f8f.58.1784296539115; 
 Fri, 17 Jul 2026 06:55:39 -0700 (PDT)
X-Received: by 2002:a05:6000:41d3:b0:47d:e547:8965 with SMTP id
 ffacd0b85a97d-47f6233fbe9mr3585403f8f.58.1784296538470; 
 Fri, 17 Jul 2026 06:55:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed1911sm4114351f8f.22.2026.07.17.06.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 06:55:37 -0700 (PDT)
Date: Fri, 17 Jul 2026 09:55:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260717095407-mutt-send-email-mst@kernel.org>
References: <20260625091334-mutt-send-email-mst@kernel.org>
 <CAFEAcA8xK+t3-prEphtkq-o9UY2mgS6cowhs880GOaxL9dKSGw@mail.gmail.com>
 <20260625101817-mutt-send-email-mst@kernel.org>
 <CAFEAcA8-Un+Q1yBDqLWCLPRwtgTA_VhJqGobgZChrFhAeVfG8A@mail.gmail.com>
 <20260625123119-mutt-send-email-mst@kernel.org>
 <CAFEAcA8UjtXgmPC27fOKMwbaWs2piwGYudtwCNWQHuu3E_7A-A@mail.gmail.com>
 <5faf04b9-d596-4a1d-9fe3-5e9ad5f0a99a@redhat.com>
 <73f79841-8cc7-4ca6-8f6b-fb97b53a6fe8@redhat.com>
 <20260717091756-mutt-send-email-mst@kernel.org>
 <CAFEAcA-O6Z4JrVV0DL_tta6khRyUta_Zz5mJt6OszaW1mu0o6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-O6Z4JrVV0DL_tta6khRyUta_Zz5mJt6OszaW1mu0o6Q@mail.gmail.com>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jul 17, 2026 at 02:49:53PM +0100, Peter Maydell wrote:
> On Fri, 17 Jul 2026 at 14:24, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jul 09, 2026 at 07:52:12PM +1000, Gavin Shan wrote:
> > > Hi Michael and Peter,
> 
> > >
> > > Could you help to confirm if the conclusion is to have unified qemu_ram_{copy, move}()
> > > for all architectures? In qemu_ram_{copy, move}(), the fixed sized accesses like
> > > 1/2/4/8 bytes are handled by __builtin_{memcpy, memmove}() and fall back to
> > > memcpy/memmove() for other sized accesses. It's basically what was proposed by
> > > Michael :-)
> >
> > No. __builtin_ and  memcpy/memmove are same on modern linuxes.
> >
> > I'd say as a 1st step, on x86 hosts we can do a fixed size
> > memmove for 1/2/4/8, on other hosts
> > *aligned* 1/2/4/8 bytes can do
> >  __atomic_store ... __ATOMIC_RELAXED
> > and the rest can hobble along on memmove
> > and hope for the best.
> 
> I don't think we should be doing something that's x86-host specific,
> as I've mentioned previously.
> 
> -- PMM

Shrug. Of course we already have arch specific code in asm.
But we can make the unaligned 1/2/4/8 for x86 host a separate
optimization on top. They are unlikely to be common.

-- 
MST


