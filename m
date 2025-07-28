Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B150CC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 10:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLGM-00083y-Ci; Mon, 28 Jul 2025 06:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ugKx7-0006s9-7t
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ugKx4-0002G5-UH
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753697964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wedwjuUU7o9ilyK+XoaQKumlkZXhy0v7V1P7TflecRk=;
 b=FsR9vj7ywkjftBEM9DJrUUigybPtZjOzWyBGSELhAY1jdkiwlkCgX5xfTeWki7tnAFCpPF
 My+fygzPDQdARRfQNwF2sgEvIdd1IRrbymDPYrji6qVi2bYhljWA4/eOoPHh9f8NaFDl0j
 uMMg0gc75WWpbFr+bVmeHaL2XzQkm+A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-76v9CvQJNtypd2LNBKhOYg-1; Mon, 28 Jul 2025 06:19:23 -0400
X-MC-Unique: 76v9CvQJNtypd2LNBKhOYg-1
X-Mimecast-MFC-AGG-ID: 76v9CvQJNtypd2LNBKhOYg_1753697962
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b7882c0992so603175f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753697962; x=1754302762;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wedwjuUU7o9ilyK+XoaQKumlkZXhy0v7V1P7TflecRk=;
 b=JRqgTI79ktVKIXly91csnOSH+dyJwywgJmFPt5++bihb0qSfGcTALB/rooWBcFEx5i
 t+tau6UP4MYNLe/2PnzSW+oMkqDv2pNMzNbuIcg9NgbEGStoPw0wX3MhniX+nzZDnk1Z
 MyjiFn/qp8Bpi7KuKrRPzE+ivG1rg9BehHz/OYMo/Oxe/Smf3SzUn3761qdJzZ6iB7mX
 GKRNkE8E/8nJWR18pH95wgNQXqROjYNZ0eNWeQbdtAdPFaRXAy8l3aOUpFBdAXpMu4Q/
 27A9FuIlPvqYM/7KBetvK9jWqwTeviD4H1IGMjvuZYcI4Tna5ybGFKe0JLryKqQzfJOo
 qQoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTyJ138Tz/wvPhPovUObapO+5RrTmdbTbfhBCO/tajlAjX9hrzDnUGVJjeTbnHiZnpALKXkPHhQ7C5@nongnu.org
X-Gm-Message-State: AOJu0YwolAX5ZsiLL8PhlPrjIJ8oUAsvE+7AwFWb2AedId1ShONHqdj3
 KThJ3fUJ3WF2v9kcxXmiA5E8pHN82OQgoVq0KVWXspCD2kxepEJlicyl1u9oP5DaCpxlOnmTJ9m
 QEThj182y8OiUriumyzTOL/Y13WHwmiY9qL9mi3pOW5jbYLyf6Mf00WZ1
X-Gm-Gg: ASbGncsxrHyRQ43LkVRra19adV77mmxsOQulfH9XvfHf1UaLGDsy7MFCGcvcKgVBM6a
 ia3RsbmRc0/czlZIYcQp2T4STaX2sdnrrthcY+p87r1/epfn1sKgKzKRtYHr/6/kQKjaGOBQK26
 T8/oObvRAxhlVrpmGcWrfsUqPtughITV2j22givJDe5llB3xOoR15MQ5maZL6WCZ46cxSk2cSAS
 7X4yCILMnl0sDNlk1GN3clAcyZElrVFdse7rFWdMcIWmhnNQRtP/aGPKonaYBsfMspBHz4AIqmn
 A48t7DF+hseWSZaiMGgxxcuutbN5BzJm
X-Received: by 2002:a5d:5f82:0:b0:3b7:5a57:eecd with SMTP id
 ffacd0b85a97d-3b7765ecfc7mr7896742f8f.17.1753697962139; 
 Mon, 28 Jul 2025 03:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlYH3GEG4IYFkzrZxIqv3eshLFsHGmW40+8Gmw3L3qj608otX7H1iJvGO0fcsSdb3XFDlWow==
X-Received: by 2002:a5d:5f82:0:b0:3b7:5a57:eecd with SMTP id
 ffacd0b85a97d-3b7765ecfc7mr7896711f8f.17.1753697961627; 
 Mon, 28 Jul 2025 03:19:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7883228dasm3454439f8f.50.2025.07.28.03.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 03:19:20 -0700 (PDT)
Date: Mon, 28 Jul 2025 06:19:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-stable@nongnu.org,
 Corentin BAYET <corentin.bayet@reversetactics.com>
Subject: Re: [PATCH-for-10.1? v2] pcie_sriov: Fix configuration and state
 synchronization
Message-ID: <20250728061838-mutt-send-email-mst@kernel.org>
References: <20250727-wmask-v2-1-394910b1c0b6@rsg.ci.i.u-tokyo.ac.jp>
 <0e122e2a-898f-46ca-b484-291b0091d928@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e122e2a-898f-46ca-b484-291b0091d928@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 28, 2025 at 12:09:34PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Akihiko, Michael,
> 
> On 27/7/25 08:50, Akihiko Odaki wrote:
> > Fix issues in PCIe SR-IOV configuration register handling that caused
> > inconsistent internal state due to improper write mask handling and
> > incorrect migration behavior.
> > 
> > Two main problems were identified:
> > 
> > 1. VF Enable bit write mask handling:
> >     pcie_sriov_config_write() incorrectly assumed that its val parameter
> >     was already masked, causing it to ignore the actual write mask.
> >     This led to the VF Enable bit being processed even when masked,
> >     resulting in incorrect VF registration/unregistration. It is
> >     identified as CVE-2025-54567.
> > 
> > 2. Migration state inconsistency:
> >     pcie_sriov_pf_post_load() unconditionally called register_vfs()
> >     regardless of the VF Enable bit state, creating inconsistent
> >     internal state when VFs should not be enabled. Additionally,
> >     it failed to properly update the NumVFs write mask based on
> >     the current configuration. It is identified as CVE-2025-54566.
> > 
> > Root cause analysis revealed that both functions relied on incorrect
> > special-case assumptions instead of properly reading and consuming
> > the actual configuration values. This change introduces a unified
> > consume_config() function that reads actual configuration values and
> > synchronize the internal state without special-case assumptions.
> > 
> > The solution only adds register read overhead in non-hot-path code
> > while ensuring correct SR-IOV state management across configuration
> > writes and migration scenarios.
> > 
> > Fixes: 5e7dd17e4348 ("pcie_sriov: Remove num_vfs from PCIESriovPF")
> > Fixes: f9efcd47110d ("pcie_sriov: Register VFs after migration")
> > Fixes: CVE-2025-54566
> > Fixes: CVE-2025-54567
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Corentin BAYET <corentin.bayet@reversetactics.com>
> > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > ---
> > Changes in v2:
> > - Changed to perform the VFEnable write mask update only when the bit is
> >    cleared. It clarifies the intention is to prevent setting the bit
> >    (i.e., the bit is currently cleared) when the NumVF holds an invalid
> >    value. The code execution when the bit is set will be also a bit
> >    shorter.
> > - Added references to the relevant CVEs.
> > - Link to v1: https://lore.kernel.org/qemu-devel/20250713-wmask-v1-1-4c744cdb32c0@rsg.ci.i.u-tokyo.ac.jp
> > ---
> >   hw/pci/pcie_sriov.c | 42 +++++++++++++++++++++++-------------------
> >   1 file changed, 23 insertions(+), 19 deletions(-)
> > 
> > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> > index 3ad18744f4a8ed2b35144fafcdc8e7e00fec3672..8a4bf0d6f7c0c6e9ec30df2e9bc55967e48cf6c3 100644
> > --- a/hw/pci/pcie_sriov.c
> > +++ b/hw/pci/pcie_sriov.c
> > @@ -64,6 +64,27 @@ static void unregister_vfs(PCIDevice *dev)
> >       pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
> >   }
> > +static void consume_config(PCIDevice *dev)
> > +{
> > +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
> > +
> > +    if (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) {
> > +        register_vfs(dev);
> > +    } else {
> > +        uint8_t *wmask = dev->wmask + dev->exp.sriov_cap;
> > +        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
> > +        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
> > +
> > +        unregister_vfs(dev);
> > +
> > +        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
> > +            wmask_val |= PCI_SRIOV_CTRL_VFE;
> > +        }
> > +
> > +        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
> > +    }
> > +}
> > +
> >   static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
> >                                         uint16_t vf_dev_id, uint16_t init_vfs,
> >                                         uint16_t total_vfs, uint16_t vf_offset,
> > @@ -416,30 +437,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
> >       trace_sriov_config_write(dev->name, PCI_SLOT(dev->devfn),
> >                                PCI_FUNC(dev->devfn), off, val, len);
> > -    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
> > -        if (val & PCI_SRIOV_CTRL_VFE) {
> > -            register_vfs(dev);
> > -        } else {
> > -            unregister_vfs(dev);
> > -        }
> > -    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
> > -        uint8_t *cfg = dev->config + sriov_cap;
> > -        uint8_t *wmask = dev->wmask + sriov_cap;
> > -        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
> > -        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
> > -
> > -        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
> > -            wmask_val |= PCI_SRIOV_CTRL_VFE;
> > -        }
> > -
> > -        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
> > -    }
> > +    consume_config(dev);
> 
> As usual, this would be simpler to review extracting consume_config() in
> a preliminary patch, then the real fix.
> 
> >   }
> >   void pcie_sriov_pf_post_load(PCIDevice *dev)
> >   {
> >       if (dev->exp.sriov_cap) {
> > -        register_vfs(dev);
> > +        consume_config(dev);
> >       }
> >   }
> 
> Michael, do we want this for the 10.1 release?
> 
> Regards,
> 
> Phil.

Think so, I'm testing a pull with this included.


