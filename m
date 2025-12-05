Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CA2D32D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXLP-0007yg-Fl; Fri, 05 Dec 2025 10:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vRXLN-0007xm-Cb
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:03:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vRXLL-00069o-AS
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764947012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W8ol8Mnme9f4s36qEHa5fxixLS0zMo8SLhMP74ynYTA=;
 b=a/8kBI+zbDhtThrWiTFabY9cqVY7chVvyLgFPNOE0bhbOyrq5HLxfer0jXMr2/aCDJbA0W
 ODbmJfLGk9ceySmJRl/OLJB5xXJhY45y7JH3BUUtMLLor/3URWoskUp0o63ZuBM/DsrT5U
 b2Kb/QGnWforoCplE4fHJN+slRvGWfw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-LB8tOw_rNZSqKByC3cTxsA-1; Fri, 05 Dec 2025 10:03:31 -0500
X-MC-Unique: LB8tOw_rNZSqKByC3cTxsA-1
X-Mimecast-MFC-AGG-ID: LB8tOw_rNZSqKByC3cTxsA_1764947010
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b56125e77so1096767f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764947010; x=1765551810; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W8ol8Mnme9f4s36qEHa5fxixLS0zMo8SLhMP74ynYTA=;
 b=lyu2WGD3oM8cjbCDwUgUfl/XU6cOtkOPPOJWX0xwzdszdR3XJYT+Hq3aAfOKDZB8rO
 erZDwQmVi+2X3qnYvXEQdYPXGgQlDuddqYvJQc/S7WzGDuP2gxNoRRV1pgvjrvvuJVDR
 lixo2FyR+efCOJEHeOghHU3i4r4d205u0A7bClMzybcOpI3HVw4vTBeEwNSR3VoFBj24
 C2ur2wAodSOK0CYAicyUM0rFo4Xf38FkcBsDMSF9FiOnjC1lYKLrWUvFNt6jMjl3LgvB
 LSauY3S8fZEzxObT62Z0vwC0P8+A5YGyzsuQ1Fyx6jbOkk9zvXTn//rk0jseO5X4uHQh
 hkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947010; x=1765551810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8ol8Mnme9f4s36qEHa5fxixLS0zMo8SLhMP74ynYTA=;
 b=B9yDEH2UD2Lfc85RilehJ33yDxnMYMTstQa780UqdbliaDzosoU68x7t1naYPuHrg8
 esspBZRQIvaOrzac93yzBn8tc0LUY4ehktv3R0zcsrIk3PbK5PVcj7B59tFf/XUHVJnW
 LRq4bueexq4JEEVr4536Ib9QElcHnFk3gNiECfbney5Dg2+9vKEs2ERRMnV84r1ZW3n6
 R6AdKA26LICMJQV5TxVSKKIZm+7qW+vq1QnrcbM3jd/dlltRkLRk0S7S7uQmU9f6V572
 fitqzPG5q60K2n3jUZS1lmtdr36G3Qz6iu9+bTbR5r/jsyMuWehGinPtSTJVECIVaSrG
 qAaA==
X-Gm-Message-State: AOJu0Yzgiv5YjvKoxUnrv+XMIRgUubtrF2rFL2A583xxgguwhk4IQMfN
 3h5V5YLZyf3X6wJrHp/CSx6Ff3rmu6TNMN2vaeTWn8J3qO2ZV/3OULJEIjDg14e2qien5AmswOJ
 +7NcYl+71eS8/RAn6HJBzrDRWFchtCMAJQ3ybroC3LQuij0HQvlo3Sj9a
X-Gm-Gg: ASbGncscWH4jICbV7YoEYAg/8XRSl+0u+Qu7/sOQdFBVxrdJVUfz6Nmd+fovac+ISaO
 xLLms+2TRglhhesQYIiN6bfKiJqoGvQkdH1gqNDwIpaJrSkNhVfI3uhS+5GqnWWnkzbCvCrLK8a
 2peksr4l12C/m8ib06FrFtiTpZhs7IIYFnLwKw+5Elg8k02gWtCECDlT5u1jbxEWz+eAQGrZJf9
 K6DA+vxAycaKSyzfR0kqyb1rkhsBnFZ8e1HIjiCmuZIWinlGrOzDp3zcTXb+UtctUv5NPk2jAYs
 Vj//vrjQG1rTnmh+3S17mnv94+AKZUv0sodaYgZW1yvus8IvLjIMNwWBUSRM9xahGUQYRa6qnrU
 =
X-Received: by 2002:a05:600c:4fce:b0:477:7658:572a with SMTP id
 5b1f17b1804b1-4792f3861fbmr75960155e9.20.1764947009652; 
 Fri, 05 Dec 2025 07:03:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5HQsQvogv7MqxFx7yZspO0vjm7mpIG7W5EZY938A12jtUZbEBsTLtLKgk6OtE5cHKa5M9sg==
X-Received: by 2002:a05:600c:4fce:b0:477:7658:572a with SMTP id
 5b1f17b1804b1-4792f3861fbmr75959525e9.20.1764947008862; 
 Fri, 05 Dec 2025 07:03:28 -0800 (PST)
Received: from redhat.com ([31.187.78.57]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310ca502sm90638325e9.7.2025.12.05.07.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 07:03:28 -0800 (PST)
Date: Fri, 5 Dec 2025 10:03:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, akihiko.odaki@daynix.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] pcie_sriov: Fix PCI_SRIOV_* accesses in
 pcie_sriov_pf_exit()
Message-ID: <20251205100242-mutt-send-email-mst@kernel.org>
References: <20251205145718.55136-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205145718.55136-1-kwolf@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Dec 05, 2025 at 03:57:18PM +0100, Kevin Wolf wrote:
> PCI_SRIOV_* are offsets into the SR-IOV capability, not into the PCI
> config space. pcie_sriov_pf_exit() erroneously takes them as the latter,
> which makes it read PCI_HEADER_TYPE and PCI_BIST when it tries to read
> PCI_SRIOV_TOTAL_VF.
> 
> In many cases we're lucky enough that the PCI config space will be 0
> there, so we just skip the whole for loop, but this isn't guaranteed.
> For example, setting the multifunction bit on the PF and then doing a
> 'device_del' on it will get a larger number and cause a segfault.
> 
> Fix this and access the real PCI_SRIOV_* fields in the capability.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 19e55471d4e8 ('pcie_sriov: Allow user to create SR-IOV device')
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Thanks for the patch! something small to improve:

> ---
>  hw/pci/pcie_sriov.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index c4f88f09757..d467284cbda 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -195,14 +195,17 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>  
>  void pcie_sriov_pf_exit(PCIDevice *dev)
>  {
> +    uint8_t *cfg;
> +
>      if (dev->exp.sriov_cap == 0) {
>          return;
>      }
> +    cfg = dev->config + dev->exp.sriov_cap;

initialize cfg at the point of declaration maybe? I think it would
be clearer.

>  
>      if (dev->exp.sriov_pf.vf_user_created) {
>          uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
> -        uint16_t total_vfs = pci_get_word(dev->config + PCI_SRIOV_TOTAL_VF);
> -        uint16_t vf_dev_id = pci_get_word(dev->config + PCI_SRIOV_VF_DID);
> +        uint16_t total_vfs = pci_get_word(cfg + PCI_SRIOV_TOTAL_VF);
> +        uint16_t vf_dev_id = pci_get_word(cfg + PCI_SRIOV_VF_DID);
>  
>          unregister_vfs(dev);
>  
> @@ -213,8 +216,6 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
>              pci_config_set_device_id(dev->exp.sriov_pf.vf[i]->config, vf_dev_id);
>          }
>      } else {
> -        uint8_t *cfg = dev->config + dev->exp.sriov_cap;
> -
>          unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
>      }
>  }
> -- 
> 2.52.0


