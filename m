Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD43EDE99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 15:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2c3-0005wn-1g; Tue, 10 Sep 2024 11:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2c1-0005vd-3m
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2bz-00068f-Ex
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725981417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5ul0ynz6uIlH1TE/L40/eJzs5Gkx1EOvdj+ZtO+Ang=;
 b=W2Y/mWg4RG7LE2X2JuJYpiQqrf+4xOVFnG23rgfzkmvwgZi6JlGon9b83Zzxo/31Ou77Rg
 72k+S3Vwgj6P9yo6XwU7a08byPVigV8/eKQULDuDCuRTNE1TcSpZdCIsOphkNBedcptpA1
 ThlirSGFhLkKSXG1e4UzgowAO0WQFhE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-A-7pf3VVNqaP93xK4qd90A-1; Tue, 10 Sep 2024 11:16:55 -0400
X-MC-Unique: A-7pf3VVNqaP93xK4qd90A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cbcf60722so11150725e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 08:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725981413; x=1726586213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5ul0ynz6uIlH1TE/L40/eJzs5Gkx1EOvdj+ZtO+Ang=;
 b=qpq69WonkYuJv+05UX19qJCqaBoxxyjoC2rY59WbOodtG0eQZ5XwkQMbXH/vF/W0hZ
 j6j2qPPtRtDNKzRwO17wTiAlnvc/RThotMi+oVR8UZYcbQgo+N3Ja1cbS81i9ea+jqdV
 ulfRN5FH2HGu/xTx0peUEU7INxQ/rdgazltdBHiymbEpkEn8NGwkNkG2xjiNrOcpSxAW
 iMpd3wtCUgoofvro5GI1pQqTFT3vYJjyAdcJuh98pSS2sHJUkdVgvN5vK77xWo6GGgEB
 qO61MJK0genQ7kJobyD+gsz/8MGJXJIR1wQy9eGjHvOd0S8NxyHLGJHcc4uOfuhEdWHy
 8qLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcGMM6j0M8+NWigCeTPq/b5fAnOpKid9jF+5GSxgz+Wk/WoGwkUDJI0cQ/w3Tmx4VCcTwnVmW2/REE@nongnu.org
X-Gm-Message-State: AOJu0YzPhLk4u1DXGy9JPthFXj8c37Xq/CDBzgWLZNb+2cBrYVhGY+jh
 MRBSaFSliZn5mBYuCfGK5Vv2na23n2YMtOFwu9JQrQakVAuoonY+ZdqIDKgcSVg2zw3w11UKW4j
 cSEumFG0XEoHUZhPLkpMX1B2TrFtQPSGYKNfyiZpjeTKmo3o/XOmbr2xbiYhi
X-Received: by 2002:a7b:c5c6:0:b0:42b:af52:2525 with SMTP id
 5b1f17b1804b1-42c9f981c0amr110650005e9.16.1725981413461; 
 Tue, 10 Sep 2024 08:16:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEStzf0AWslunZoEzz+ValkyCUhb8OQrfDnIvj6e4kKGhX+O5LN6V5W9nVktHgoWeTbC0U7ng==
X-Received: by 2002:a7b:c5c6:0:b0:42b:af52:2525 with SMTP id
 5b1f17b1804b1-42c9f981c0amr110649685e9.16.1725981412895; 
 Tue, 10 Sep 2024 08:16:52 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05c272esm148702095e9.8.2024.09.10.08.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 08:16:52 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:16:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4] pci-bridge: avoid linking a single downstream port
 more than once
Message-ID: <20240910111433-mutt-send-email-mst@kernel.org>
References: <20240725093819.15549-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725093819.15549-1-yaoxt.fnst@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 25, 2024 at 05:38:19AM -0400, Yao Xingtao wrote:
> Since the downstream port is not checked, two slots can be linked to
> a single port. However, this can prevent the driver from detecting the
> device properly.
> 
> It is necessary to ensure that a downstream port is not linked more than
> once.
> 
> Links: https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> 
> ---
> V3[3] -> V4:
>  - make the error message more readable
>  - fix the downstream port check error
> 
> V2[2] -> V3:
>  - Move this check into pcie_cap_init()
> 
> V1[1] -> V2:
>  - Move downstream port check forward
> 
> [1] https://lore.kernel.org/qemu-devel/20240704033834.3362-1-yaoxt.fnst@fujitsu.com
> [2] https://lore.kernel.org/qemu-devel/20240717085621.55315-1-yaoxt.fnst@fujitsu.com
> [3] https://lore.kernel.org/qemu-devel/20240725032731.13032-1-yaoxt.fnst@fujitsu.com
> ---
>  hw/pci/pcie.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 4b2f0805c6e0..1e53be1bc7c5 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -192,6 +192,13 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
>  
>      assert(pci_is_express(dev));
>  
> +    if ((type == PCI_EXP_TYPE_DOWNSTREAM || type == PCI_EXP_TYPE_ROOT_PORT) &&
> +        pcie_find_port_by_pn(pci_get_bus(dev), port)) {
> +        error_setg(errp, "The port %d is already in use, please select "
> +                   "another port", port);
> +        return -EBUSY;
> +    }
> +
>      pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
>                               PCI_EXP_VER2_SIZEOF, errp);
>      if (pos < 0) {


But can't there be two functions of a multi-function device,
sharing a port?

> -- 
> 2.41.0


