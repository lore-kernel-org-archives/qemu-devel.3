Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65625C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 07:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raA6l-00017y-J3; Wed, 14 Feb 2024 02:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raA6k-00017L-9G
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:55:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raA6h-0001eI-Bk
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 02:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707897302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ldvkJHosj+m7dlrgomfSMfHxFZTRq8+oacWsr4paKFo=;
 b=P353bkUNrSosQLKgy0bddDYySMGlY/FHyDRy10ylV7ajz7xQGwQbiJFSmHip0+ZWhMzsA+
 9fXslMW7pV+Gitq9cCjRqsWrFEygirnw3QA4t7x7SU5JEYHJd7cW+Wwb9I33p+lPZehlTE
 ve2G0wqhEVxQVwmiwiBKpcDIvW/0EjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692--Q-8RGnDODSV-oTBbxridg-1; Wed, 14 Feb 2024 02:55:01 -0500
X-MC-Unique: -Q-8RGnDODSV-oTBbxridg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-410b8e90b4fso18713065e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 23:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707897300; x=1708502100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldvkJHosj+m7dlrgomfSMfHxFZTRq8+oacWsr4paKFo=;
 b=U22kULUHU0QCp9OvNogsZ7ebKsGUfcfp591TsH6LZ3Hgxyrg8ZzthJNjYC+ebZ1A2S
 g7l6cblFn+IgCHaf4qxDwS7YtG5cSFOClH6y/BAZABk5xx2PryKH2k5RsPSgz/vgeRjh
 SqCRcISzfJQ0GuungDX2A0xVyrfH19cuVxxKFO1RtLYumLDt0uANd1RBTM7jTD2+tzmI
 BcgyMX4Brtivizrr7W6gWy0Cq9fAfPpCdbZhSxin2G+EhNTY1iZZMkjSY8eTdV3tusVL
 M4dYbLRhPT5uukRuA31PxoCJEopwA5xcExnImfiWco5+IqdLARBk7xS05/q1rYgoXQcm
 2IAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbs0nw3rUKTHTM2kFc95VGbYH3+DWMpsh2GDTrBtphJ3n2Lfc6QJkM21K5GaMk0QETTJVIV5jNzcEgIuhlXlcimBpux6A=
X-Gm-Message-State: AOJu0YzNwB1HcqoO6jOHN675HAeBAnLh1hBxHio91SPaE92T1gvUFNzY
 X0zB3JLKdjuUO1bOy6JGyWheQtgq+oypHVDXCtQdxQIblsRIieuSU5VE2tPLhPcPDaYjDwxudDc
 wxKft5eDQ9E6Nh+TogJFcgmtmdLCul5HZhf9DwRx20/ql1KijatXB
X-Received: by 2002:a05:600c:4e86:b0:410:e201:bc55 with SMTP id
 f6-20020a05600c4e8600b00410e201bc55mr1681911wmq.11.1707897300121; 
 Tue, 13 Feb 2024 23:55:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTyif6yhQSokJGUoCCwGcNYodxEkxI5qLLhJM9EByf3Yc8E1I4uZCOYZpedwvAo2WVdFEprg==
X-Received: by 2002:a05:600c:4e86:b0:410:e201:bc55 with SMTP id
 f6-20020a05600c4e8600b00410e201bc55mr1681887wmq.11.1707897299790; 
 Tue, 13 Feb 2024 23:54:59 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:720f:e338:175b:c44e:aa92])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a7bc3c9000000b004107dfa6aebsm1090444wmj.28.2024.02.13.23.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 23:54:59 -0800 (PST)
Date: Wed, 14 Feb 2024 02:54:54 -0500
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
Subject: Re: [PATCH v4 7/9] pcie_sriov: Release VFs failed to realize
Message-ID: <20240214025430-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-7-89ad093a07f4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-reuse-v4-7-89ad093a07f4@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

On Wed, Feb 14, 2024 at 02:13:45PM +0900, Akihiko Odaki wrote:
> Release VFs failed to realize just as we do in unregister_vfs().
> 
> Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Is this fixing an old bug or a bug introduced by a previous patch?


> ---
>  hw/pci/pcie_sriov.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index 9ba34cf8f8ed..9d668b8d6c17 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -91,6 +91,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>          vf->exp.sriov_vf.vf_number = i;
>  
>          if (!qdev_realize(&vf->qdev, bus, errp)) {
> +            object_unparent(OBJECT(vf));
> +            object_unref(vf);
>              unrealize_vfs(dev, i);
>              return false;
>          }
> 
> -- 
> 2.43.0


