Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6ACE69E85
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIBhz-0000cl-EE; Mon, 02 Dec 2024 14:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIBhv-0000cV-GV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:03:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIBhr-00032d-H5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733166217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5pPmtglZXhgrqnzUVHWfIObXnnvilbIJDQs0jmB7Hwg=;
 b=GOSavLGmoEp1+KQYYHh+LAoA660OFXbQGL4lyPmyM3oBbwLJSbg++R6Hlr83WglN1fcLoK
 awoTtqMiPwHZOTX9jnizwb7EMmwYc67rSN33SFoVBSo/IfjecZrc3aflqc23Xdw+0rSPIN
 umArCJiNzW06Zr1MMjMPNWFUlNEA3gs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-rLiswu6hOOCSxt3sCzI5tg-1; Mon, 02 Dec 2024 14:03:36 -0500
X-MC-Unique: rLiswu6hOOCSxt3sCzI5tg-1
X-Mimecast-MFC-AGG-ID: rLiswu6hOOCSxt3sCzI5tg
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-841953497e2so15782439f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 11:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733166215; x=1733771015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pPmtglZXhgrqnzUVHWfIObXnnvilbIJDQs0jmB7Hwg=;
 b=lZNvnbzeawFYfWG3m9gEUGeuroAgMVLsweQtfCObkLwRKFB1TFyxpwCj5j4sTamMNb
 HAwrruhwnT+2Z1wGkCLDjRo8hs9K8XAli7S3Xa0V3TKjuKKYTYtmyKbrLTQ0TGwdJgNb
 PG7RrPYNdT6Udw8opuVKATvcg9b5rCHjPfnsud0zgOGNwRJ1oxPaN5CZuSTnA9GH90wt
 K7mTxHl3O8PQVzErFo7TCbbCFOuwSeb1t9SEdeGG+Hvq1S1rlu1dlMUNJZKanhPskrqh
 L4LmOa+fAzt9BI6K7k7uRH9Z0bcnlLtUvyhsggewLIONuxrYgz9v+g5tcU95/ykoutGn
 1Shw==
X-Gm-Message-State: AOJu0Yy6zBuMikhw4CvxW3WPCzh12uzkG9+KttZ0T1q23BY77tm4sKIH
 MRvwqKXnHnH3xU29xhjbq/ACL8RUHnpneR2D/OZiaCeGm41arbSgH57psW0EZU9MnQMHNq1ErQe
 ZrVaJo6j6TABz7jfz3XlusYVHH69sLvc2AlAPAwp7oh4yD8nZGtpsYLkWUkwV
X-Gm-Gg: ASbGncuGMTV2sICjDYtwGC5wsDFTxeDAn1hNs9X/PHd+2pG+1EHliuc4IefeSCblAL0
 h1iIVHvtD+NRjteFQULhAdjUpPGDLRMSAGwA4eO+MaSIG/Bg9o6c/cgZ5NhGAIFbaEDrjRTE4Tq
 FYnWkPE+wPxDJNvxYedQvSnqox71BYj58He9YZWh0W+i2sHEEXASOKPd05liQjU+p0lq8zgj/UJ
 503NCMddFJ894C5KBa/I6sTT9JyIC/8wS/ObXLPOUyrL0rIKAfP/Q==
X-Received: by 2002:a92:d28f:0:b0:3a7:c5b1:a522 with SMTP id
 e9e14a558f8ab-3a7c5b1a59cmr55898845ab.7.1733166215394; 
 Mon, 02 Dec 2024 11:03:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5TY3Abb9UaL4EXOJ2HL47SMKDCbUX1mF2je2xcIVHIP7w7aHq7NigUTNhlWj+aPdIlsZKSA==
X-Received: by 2002:a92:d28f:0:b0:3a7:c5b1:a522 with SMTP id
 e9e14a558f8ab-3a7c5b1a59cmr55898775ab.7.1733166215034; 
 Mon, 02 Dec 2024 11:03:35 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7ccbded69sm23056335ab.3.2024.12.02.11.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 11:03:34 -0800 (PST)
Date: Mon, 2 Dec 2024 12:03:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Sebastian Ott <sebott@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: ensure valid link status bits for downstream ports
Message-ID: <20241202120332.5131e7ab.alex.williamson@redhat.com>
In-Reply-To: <20241111123756.18393-1-sebott@redhat.com>
References: <20241111123756.18393-1-sebott@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, 11 Nov 2024 13:37:56 +0100
Sebastian Ott <sebott@redhat.com> wrote:

> PCI hotplug for downstream endpoints on arm fails because Linux'
> PCIe hotplug driver doesn't like the QEMU provided LNKSTA:
> 
>   pcieport 0000:08:01.0: pciehp: Slot(2): Card present
>   pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
>   pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000
> 
> There's 2 cases where LNKSTA isn't setup properly:
> * the downstream device has no express capability
> * max link width of the bridge is 0
> 
> Fix these by making the LNKSTA modifications independent of each other.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  hw/pci/pcie.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 0b455c8654..f714f4fb7c 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1109,20 +1109,20 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
>          lnksta = target->config_read(target,
>                                       target->exp.exp_cap + PCI_EXP_LNKSTA,
>                                       sizeof(lnksta));
> -
> -        if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
> -            lnksta &= ~PCI_EXP_LNKSTA_NLW;
> -            lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
> -        } else if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
> -            lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
> -        }
> -
> -        if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
> -            lnksta &= ~PCI_EXP_LNKSTA_CLS;
> -            lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
> -        } else if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
> -            lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
> -        }
> +    }
> +    if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
> +        lnksta &= ~PCI_EXP_LNKSTA_NLW;
> +        lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
> +    }
> +    if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
> +        lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
> +    }
> +    if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
> +        lnksta &= ~PCI_EXP_LNKSTA_CLS;
> +        lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
> +    }
> +    if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
> +        lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
>      }
>  
>      pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,

Only half of these seem valid to me.  How can we ever hit the
conditions where the status fields exceed the capability fields in the
case where we've set the status field from the capability field?  It
seems like we'd only want to move the sanity checks added in
88c869198aa63 outside of the branch.  Thanks,

Alex


