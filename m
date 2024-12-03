Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E3DE64AB1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 14:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tITt0-0006D2-As; Tue, 03 Dec 2024 09:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tITsy-0006CU-PT
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:28:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tITsw-0007v1-Pb
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733236093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ybki3++20ZneNRichpifz6iFVj8rps0/Qqc3a46AbZ0=;
 b=cfvepXHVrd4K/OHRBGjhTcFcT1lrmHyLtyrJ8j9jyQEZ0APAzEprjQPAhu/trV/P4gdd/u
 CrEOsPAnOsYOr4daY/Ks4jThy9SQJNVY7bIKXmgZMN5hUQHcMknVO9ms1e359wABFDsS0D
 /jzW2PqXAfyVrtoLhMq7jOCsSnyv20Q=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-DlUl3tyaOUe2nyuLEeIhgA-1; Tue, 03 Dec 2024 09:28:12 -0500
X-MC-Unique: DlUl3tyaOUe2nyuLEeIhgA-1
X-Mimecast-MFC-AGG-ID: DlUl3tyaOUe2nyuLEeIhgA
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-841acf1782fso64806439f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 06:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733236091; x=1733840891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ybki3++20ZneNRichpifz6iFVj8rps0/Qqc3a46AbZ0=;
 b=NHIPmetWDAt4lSRXQFqSZ7kfJbAHALWJSKwO4r4riOicF/UDmjUXuPemu4WWo7kcfF
 KgTEYna7qj6gR1NWg17r71/DYyyAl6do8Lv5Nd5lAPaFvIY6chJlN+A11OtaXA7LM4YB
 jIveuseqpw1pRKVPZOv2G9H4BEzlDD2o6ZWR56Avct+Ntuhky3aXsEGtEJESERw66w10
 Jm81TedKgkbCfXs8Kt3SF1lLBzaUPOFEXVrtn0//tDZ6k7J6ZAsGSWYebzcCm6YfJpKZ
 a64vvBZ9UgtYPoUTkHhHtBPDOPwalw9HTpQD9rOk5xSuynPgNjfcI3I8jepCCQ14hsQW
 p1Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY7IYf+dYVG16P/bvWKWpAhXQYJWEeA4DBBWNVxYy/Awh922Buxh1YU9mkKUvwV/3EjW2mgMKCZy/N@nongnu.org
X-Gm-Message-State: AOJu0YwltHVKGVIJc0BzBOtZOf6F3xO4QgO9QF99tFP4l1jH1fqP41cr
 wVeIOnkMBDAO09b5Kw0bzHT0Pq6vxs4S4XpIcb7bot2s5h/p18z4JZ1KmJnXuVINkgwF0kdPdgq
 CqQc+cK89paLKu6R2iDF1FJt1JK3+Vu+dFkCIF5IhUMcDgdKu2N0b
X-Gm-Gg: ASbGncu7AkVxxodgsvneiKPJFJoq1mU+fxq1vLGntRv+bbsUmtefgB19ZK5Yigq2kuL
 RNGgGGL9TSVfHFFo4mgqLHpIBdTQvS/i+ioTCCxk6QSLvGoQVDSsKxUn+jVFMteXsSAFrTofWeP
 Bdhr4uIcPELr0IvUfLu9ua2Gia7876ZRJldMBXFLKF6m9P5oXuyhainGsVfpmaf6yr6AqHnKvws
 AIowIWBjQ+csjloP7vguGwZ80o6h4rgTdhNO3ffjm3+y8DJs959Xg==
X-Received: by 2002:a05:6602:2cd4:b0:83a:acc8:5faf with SMTP id
 ca18e2360f4ac-8445b806751mr77748139f.5.1733236091393; 
 Tue, 03 Dec 2024 06:28:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0vypiv1lgKIZP5/RfI9q8zcNYKv0+qQC26MczKnKu+iWmRtYEZOWvv3QoeBP+WQU8N1hveA==
X-Received: by 2002:a05:6602:2cd4:b0:83a:acc8:5faf with SMTP id
 ca18e2360f4ac-8445b806751mr77747639f.5.1733236091088; 
 Tue, 03 Dec 2024 06:28:11 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230da998dsm2536506173.3.2024.12.03.06.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 06:28:10 -0800 (PST)
Date: Tue, 3 Dec 2024 07:28:09 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Sebastian Ott <sebott@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org, Zhenyu Zhang <zhenyzha@redhat.com>
Subject: Re: [PATCH v2] pci: ensure valid link status bits for downstream ports
Message-ID: <20241203072809.3431fe80.alex.williamson@redhat.com>
In-Reply-To: <20241203121928.14861-1-sebott@redhat.com>
References: <20241203121928.14861-1-sebott@redhat.com>
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

On Tue,  3 Dec 2024 13:19:28 +0100
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
> Move the sanity checks added via 88c869198aa63
> ("pci: Sanity test minimum downstream LNKSTA") outside of the
> branch to make sure downstream ports always have a valid LNKSTA.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
> ---
>  hw/pci/pcie.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 0b455c8654..1b12db6fa2 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1113,18 +1113,22 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
>          if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
>              lnksta &= ~PCI_EXP_LNKSTA_NLW;
>              lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
> -        } else if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
> -            lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
>          }
>  
>          if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
>              lnksta &= ~PCI_EXP_LNKSTA_CLS;
>              lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
> -        } else if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
> -            lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
>          }
>      }
>  
> +    if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
> +        lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
> +    }
> +
> +    if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
> +        lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
> +    }
> +
>      pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
>                                   PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
>      pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA, lnksta &


