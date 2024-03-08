Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A7EC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridxI-0001dt-50; Fri, 08 Mar 2024 12:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ridxG-0001dO-24
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ridxE-0005x3-JB
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709918659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7a0gU4C9+tug7gu5flhnaQuZSBhggp/OP5uFJm1xYvQ=;
 b=KxSfYDlsVS6Xa6uvUDv90BNDYZuizb4Wix8bQBaSWdWwqEYKCgjJxiVKBSsax6ZHwZ4lPO
 qN+RzcPSaC7dJhSL0z4EVwuj7SFGw7BxlHuYHZX/FhggHRt1UqAuxjL8xF/QMwEH7pKyoK
 7vBwChOL4THYK8e+Gfl0BQdW0KvdxUE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-YFo3URqrNMatGGh3TFhdKw-1; Fri, 08 Mar 2024 12:24:18 -0500
X-MC-Unique: YFo3URqrNMatGGh3TFhdKw-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7c874fb29dbso233804439f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 09:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709918657; x=1710523457;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7a0gU4C9+tug7gu5flhnaQuZSBhggp/OP5uFJm1xYvQ=;
 b=vnXGhvtW0fkPZa4TWhsa9CRCExlpqoitU6k1vO0UbRAyotHd17LPKu3McCOky0cSqp
 oWS0PGAbH+KlG+w0oYNKgHyMqs6WKenKAKzxQ06aJUlruRF1U28n11zKMOfflf9CgOOC
 55Tyqhl/yG1SjTHK3MJ5H9ddGNv3xlzgIu/sUr2LX8AZOBqJH7GQO0GmPXtQXh8Ps4OA
 eS/pYpu/JycNrrmgKZLQOsA2MS7BEGqgetf9IwezyO2z8G6aBfGG0KHSVn68T0BQ+/hO
 fymbpF5xT/UlN1zKbfQZlcRlQl3JnghKW/aaJK2uHlr47Q7WNWydtLuQJ1WWE2p6f5fa
 23HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCd4AaXKPiag6dHzaWEJY7Iok0NblhgtVA3avyVSeF5nZKUyVP/TO0tgGcUqI/jaMj0rkj3Yy2ePrGaMibT2vsL2vLxEw=
X-Gm-Message-State: AOJu0YxtpgGc5SOFs4BG3p9BsQOoNVLuPFgRYGpkFO+7cTFlfEU4J4lt
 h/eJXOQOTWkXqE83hcc6MnFDXCnl/mNwGMTC6BPXvtyZDslbjya0rsBLnlF2s4SW+GZN6LJCqJX
 5glRzjyitu5gAx9Wv7iadCGouUvRBCvhw6Zr6zn39Zl/CIFIJM4vG
X-Received: by 2002:a05:6602:3407:b0:7c8:57b1:e799 with SMTP id
 n7-20020a056602340700b007c857b1e799mr17315319ioz.14.1709918657468; 
 Fri, 08 Mar 2024 09:24:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcowYzKUJk++EzgAnsm6rAE6+JU0R+ZUyItah+jvr5Y63v5a0gqAQC4zBA5Qe4KVqX999PUg==
X-Received: by 2002:a05:6602:3407:b0:7c8:57b1:e799 with SMTP id
 n7-20020a056602340700b007c857b1e799mr17315295ioz.14.1709918657173; 
 Fri, 08 Mar 2024 09:24:17 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 v25-20020a02cbb9000000b004767276b068sm1657680jap.41.2024.03.08.09.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 09:24:16 -0800 (PST)
Date: Fri, 8 Mar 2024 10:24:14 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, clg@redhat.com
Subject: Re: [PATCH] pci: Add option to disable device level INTx masking
Message-ID: <20240308102414.1826786c.alex.williamson@redhat.com>
In-Reply-To: <20240308115643-mutt-send-email-mst@kernel.org>
References: <20240307184645.104349-1-alex.williamson@redhat.com>
 <20240308115643-mutt-send-email-mst@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 8 Mar 2024 11:57:38 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Mar 07, 2024 at 11:46:42AM -0700, Alex Williamson wrote:
> > The PCI 2.3 spec added definitions of the INTx disable and status bits,
> > in the command and status registers respectively.  The command register
> > bit, commonly known as DisINTx in lspci, controls whether the device
> > can assert the INTx signal.
> > 
> > Operating systems will often write to this bit to test whether a device
> > supports this style of legacy interrupt masking.  When using device
> > assignment, such as with vfio-pci, the result of this test dictates
> > whether the device can use a shared or exclusive interrupt (ie. generic
> > INTx masking at the device via DisINTx or IRQ controller level INTx
> > masking).
> > 
> > Add an experimental option to the base set of properties for PCI
> > devices which allows the DisINTx bit to be excluded from wmask, making
> > it read-only to the guest for testing purposes related to INTx masking.
> >   
> 
> Could you clarify the use a bit more? It's unstable - do you
> expect to experiment with it and then make it permanent down
> the road?

No, my aspirations end at providing an experimental option.
Technically all devices should support and honor this bit, so I don't
think we should provide a supported method of providing broken behavior,
but there do exist physical devices where this feature is broken or
unsupported.  Rather than implementing emulation of one of these broken
devices, with bug for bug compatibility, it's much easier to be able to
trigger broken DisINTx behavior on an arbitrary device, in an
unsupported fashion.  Thanks,

Alex

> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  hw/pci/pci.c         | 14 ++++++++++----
> >  include/hw/pci/pci.h |  2 ++
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 6496d027ca61..8c78326ad67f 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -85,6 +85,8 @@ static Property pci_props[] = {
> >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > +    DEFINE_PROP_BIT("x-pci-disintx", PCIDevice, cap_present,
> > +                    QEMU_PCI_DISINTX_BITNR, true),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >  
> > @@ -861,13 +863,17 @@ static void pci_init_cmask(PCIDevice *dev)
> >  static void pci_init_wmask(PCIDevice *dev)
> >  {
> >      int config_size = pci_config_size(dev);
> > +    uint16_t cmd_wmask = PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> > +                         PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> >  
> >      dev->wmask[PCI_CACHE_LINE_SIZE] = 0xff;
> >      dev->wmask[PCI_INTERRUPT_LINE] = 0xff;
> > -    pci_set_word(dev->wmask + PCI_COMMAND,
> > -                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> > -                 PCI_COMMAND_INTX_DISABLE);
> > -    pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_SERR);
> > +
> > +    if (dev->cap_present & QEMU_PCI_DISINTX) {
> > +        cmd_wmask |= PCI_COMMAND_INTX_DISABLE;
> > +    }
> > +
> > +    pci_set_word(dev->wmask + PCI_COMMAND, cmd_wmask);
> >  
> >      memset(dev->wmask + PCI_CONFIG_HEADER_SIZE, 0xff,
> >             config_size - PCI_CONFIG_HEADER_SIZE);
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index eaa3fc99d884..45f0fac435cc 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -212,6 +212,8 @@ enum {
> >      QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
> >  #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
> >      QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> > +#define QEMU_PCI_DISINTX_BITNR 13
> > +    QEMU_PCI_DISINTX = (1 << QEMU_PCI_DISINTX_BITNR),
> >  };
> >  
> >  typedef struct PCIINTxRoute {
> > -- 
> > 2.44.0  
> 


