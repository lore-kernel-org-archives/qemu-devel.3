Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7B5C4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 07:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra9Mb-0002QG-Rv; Wed, 14 Feb 2024 02:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ra9MZ-0002PT-Ne
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:07:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ra9MY-0007pr-C8
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707894441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5/0tyFmb+DfpNR6LRU7p5xJ0mop7QZplevz/3fuXDM=;
 b=OKX9n1WoeUYzjA2iLl+OkdWEgGB4enOvyx6bepd9OEUafV9msd84qcx00FWir1sQrXRnf8
 bkU5Ojwty42cTbc4OpuhPtJ8k4g4BVhp0/yDV34zM0KxgDPsezRxqNDDiHV+UksNMOhqfy
 +j5giFxMHvTC/1A65HWD6EEZalZcKco=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-9gPLDniCNfOPENGOyjpfYg-1; Wed, 14 Feb 2024 02:07:19 -0500
X-MC-Unique: 9gPLDniCNfOPENGOyjpfYg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d0a20a788dso53056621fa.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 23:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707894437; x=1708499237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5/0tyFmb+DfpNR6LRU7p5xJ0mop7QZplevz/3fuXDM=;
 b=Y5wMHH//0PHpslWPmx3B3JOXGxnR7HI1ozkKcjkPJPZPHvnsw7ccHlPwZ8WAm0RhZK
 B8pA1YfpgIR2WXmfmXofPlcT+COHvn7t+hH+0m7d/pbL+Es4Ky/5LOQty4Mbh+K2AfEC
 uLTuOU6AZxN8iMgDbmQNxJci0RrPyKMEEsXAgPkhtX7V3LShikmsw5XjAlnmhUY3SxCx
 Mer8ALF6fqfvhe8UCxggpEmjFUqRmRmiApt5XXrvwdSh600Dh2l1kwTIYAZ/bcweOUCh
 p3sPkbccbIXCwZSls6B992UpUHzk+MN2d5jfjD8mGbj1PYtiC0t9LmJYnehhcjmCsJMZ
 aj9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnqDZcAcP9m5IKRsioijS3Yx1+MoR48SqtJx6LybQ4cim1W47vlPn72S/dAnnGNyxCimuxqDwBUNaRg90uzrDQzD/sAnE=
X-Gm-Message-State: AOJu0YznwTAMLIhFg0HiyNQ1WsCOZHzHHl/9UJSyqYyUidCv/BW+TLjf
 AD3pYMb9EUPFevYWw0P7ROAEa3MImjIq32WUNdF9hpUQQF4z/D0npHwoLOo5+qHqCs/b2b1B8f5
 ZH7FdODrxguAIERv1bxSD187iZNG+vskkwKep1uaf19qjzQ+8wQas
X-Received: by 2002:a05:651c:2044:b0:2d0:b32f:8304 with SMTP id
 t4-20020a05651c204400b002d0b32f8304mr1106134ljo.28.1707894437703; 
 Tue, 13 Feb 2024 23:07:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpQayfOKT8u/G3NiSR0w0wisqs4X8qf/Rbjjibej6XTb7g+A3StlGttldT5d0rKcTc3+cd1g==
X-Received: by 2002:a05:651c:2044:b0:2d0:b32f:8304 with SMTP id
 t4-20020a05651c204400b002d0b32f8304mr1106110ljo.28.1707894437356; 
 Tue, 13 Feb 2024 23:07:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ7ShoGD36lBr2pBK6JVlKHH6tdvbHOjoXJKiWA7fCQU2uEsoNeRXlj/DCto7SBpAAUSRUg7+XqIuWqOKc+1iW/p3Uh/6rZxFOZ8Rqt1mhwySeRHCQkXihgDQn/UmfXfQRV1tNbW31rNxpDdsWXOdx8tw/DcWILVaFqPqRtgSohi8IAulsvldYlmY45pj/PStkqRsVNAl0gYYEw2eRRBdf2gX9T+vCmhAoJ2EGbntNKsLDYSTH1gA1RnTuiewVb5Ic314l/YazBvCYvezdpFAzXURfUjkUqkjFfwjwr/ovsCYso/7QcAg6uWqtXmG4Zb131yleNQmf07yBl8Rs3J/ovlJlCKupZmim06ekavd+VOfaXyeSMnJvx2/1ieSxql0gSCL+ZRxOufmKyIFmEmwHARK2Q61w4oXfPQ==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 j8-20020adfe508000000b0033aedaea1b2sm11500198wrm.30.2024.02.13.23.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 23:07:16 -0800 (PST)
Date: Wed, 14 Feb 2024 02:07:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v4 9/9] hw/nvme: Refer to dev->exp.sriov_pf.num_vfs
Message-ID: <20240214015457-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-9-89ad093a07f4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-reuse-v4-9-89ad093a07f4@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 14, 2024 at 02:13:47PM +0900, Akihiko Odaki wrote:
> NumVFs may not equal to the current effective number of VFs because VF
> Enable is cleared, NumVFs is set after VF Enable is set, or NumVFs is
> greater than TotalVFs.
> 
> Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

I don't get what this is saying about VF enable.
This code will not trigger on numVFs write when VF enable is set.
Generally this commit makes no sense on its own, squash it with
the pci core change pls.

> ---
>  hw/nvme/ctrl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f8df622fe590..daedda5d326f 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -8481,7 +8481,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
>      NvmeSecCtrlEntry *sctrl;
>      uint16_t sriov_cap = dev->exp.sriov_cap;
>      uint32_t off = address - sriov_cap;
> -    int i, num_vfs;
> +    int i;
>  
>      if (!sriov_cap) {
>          return;
> @@ -8489,8 +8489,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
>  
>      if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
>          if (!(val & PCI_SRIOV_CTRL_VFE)) {
> -            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> -            for (i = 0; i < num_vfs; i++) {
> +            for (i = 0; i < dev->exp.sriov_pf.num_vfs; i++) {
>                  sctrl = &n->sec_ctrl_list.sec[i];
>                  nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
>              }
> 
> -- 
> 2.43.0


