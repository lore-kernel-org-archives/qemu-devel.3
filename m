Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344CECD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWv1G-0006zY-V5; Tue, 09 Jun 2026 07:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wWv1F-0006z9-02
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wWv1D-0002jy-JZ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781005998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Umh8o2RevX6dN2k8uisEDF152XUm4N4QEuarT8kMMs=;
 b=Pp244LKPCktW7Zs2q36KwPJiIdhk5PNjv7lj2QcQB/OyeuB9NZ5SgG7cMUJfVzrOdtXnw2
 WdGkm+dsY5AztnpytC8bssqcmWIoj7pSsT1W4UvhyykjMBUurkQJpLDhGbirTfXK/BDT/p
 sWjDdk4xO4Gds4YlvXtY/XuR21ArLcg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-_2LvW4YKNtGDR7SWuXIN5w-1; Tue, 09 Jun 2026 07:53:11 -0400
X-MC-Unique: _2LvW4YKNtGDR7SWuXIN5w-1
X-Mimecast-MFC-AGG-ID: _2LvW4YKNtGDR7SWuXIN5w_1781005990
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5aa68d012dbso3751445e87.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781005990; x=1781610790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Umh8o2RevX6dN2k8uisEDF152XUm4N4QEuarT8kMMs=;
 b=dvCN0yf3ZdREWP1CpYagS5hcO51lHBTSq5QsBHZ4DyNiyve61M9exQD6qMdtG7h9nE
 7/gEerQ9M13EqDtPMb/Mw6aX3WFDssPEE95IUI3u3Fk6CKy9VnptUPptVvT6ecFP9h4+
 SmFAiIqZxhxEUwmURUxXD+PxKNZ58N3N3L/uqMkTg3cEzpcU8YC//sgynF7miyWHA2lf
 d6u8jekUMV0h3y6LclQ9hOZ9fNjA+aERUXBVf0DqnDqh+Jj/UCEVFrLb+Rv3C+cw2Z5m
 nu2BISQhTOR0LsGKpy1/AL29LM0cNljnWaRQQoPz4UXEveC3ake1QMfMR8R8BGmQbouy
 C6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781005990; x=1781610790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Umh8o2RevX6dN2k8uisEDF152XUm4N4QEuarT8kMMs=;
 b=RAl2OpLkwajdCNm6hsJRbQjo5exRKbLRgLbBk8vNDsM9eieyjM/vMfvqsRTgAj084u
 nF6d3rOhOtSQ6zJMxxkqcvU1keYWGq8WvQgcuk8/fBXEJjX2X5FxTE49epGb0OlZzVY8
 AmlanzZ0+Hr9+zZXx+yYA5dL73Kpe77PFW8Oaw/oQi0FTA3RFpPUI0PXF9NcOLEGlU5w
 0YPeHJCweR2U4Td51Ie1v795EGsdqVYbjRdGVRBYI0tp7lIGQxUHISseysi4n1tNZqLs
 4fgJfO/59BNIl8nXlf0hrmU0f5+6yTG6134V/M73ZpoDXQuWYelMGqiYE+Bc+Get4tKm
 r3aQ==
X-Gm-Message-State: AOJu0YzdfmG4HknaSW7JmkDtLbBv8wVPfqg04/D9jYL9LtLb2rsTUnPk
 dYL0dUQsVpgkzKh5yx65V2njxWwEKG7rkY6tNYlzNrc/NHgpmmEzHXURfJxsRTcPedzT81ifo3p
 vPtX5NS+0U0HvKaOpbiIxT8C9VVwETCGKWQLw++OJOcTcrFpG4T+YI0I4
X-Gm-Gg: Acq92OFJEsG5KoEIokrnzT/BU+AANCYpjWZlJJOB4vvmGAOmPezob76utmDYzFwlAhB
 SbjnPSVt+D+S6UbjIaitXtMvsjm+9LiLmDeTkr0wiUoChtOuHj29yLycb90E+9nu7oLaf0VZC0c
 Eg3mK1yx5lp6mDoTX8bbmdJ3trzX3QpAXafKqHJgqc5030E4wXZZGk1iPOH/+QCdnW0cJoKFO8H
 QJIQh0s1EoFjoi+79JatleNyedutV7mWCmMi032jmkRmU4eGSBBQJtiNCfP14LRWH5Zw5yW4ptd
 jN+KlIoUcmU4TCgdFJF3TpQ/DipgIHHlyCkMMvaig4E28OBDygHPrRVuZC0regGtuiQ4e5qzTf4
 A5S6I6NbwmP5j+Khy
X-Received: by 2002:a05:6512:690:b0:5aa:753c:d8de with SMTP id
 2adb3069b0e04-5aa87b24057mr5993352e87.0.1781005990183; 
 Tue, 09 Jun 2026 04:53:10 -0700 (PDT)
X-Received: by 2002:a05:6512:690:b0:5aa:753c:d8de with SMTP id
 2adb3069b0e04-5aa87b24057mr5993341e87.0.1781005989708; 
 Tue, 09 Jun 2026 04:53:09 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b97b042sm4516910e87.47.2026.06.09.04.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 04:53:09 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:53:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <gourry@gourry.net>,
 <philmd@mailo.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v10 4/4] MAINTAINERS: cover sp-mem under Memory devices,
 add R: tag
Message-ID: <20260609135306.5c66c347@imammedo>
In-Reply-To: <20260605104609.1739911-5-FangSheng.Huang@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-5-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 5 Jun 2026 18:46:09 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7752917d8c..db34f6cf17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3361,13 +3361,16 @@ F: scripts/coccinelle/memory-region-housekeeping.cocci
>  Memory devices
>  M: David Hildenbrand <david@kernel.org>
>  M: Igor Mammedov <imammedo@redhat.com>
> +R: FangSheng Huang <FangSheng.Huang@amd.com>
>  S: Supported
>  F: hw/mem/memory-device*.c
>  F: hw/mem/nvdimm.c
>  F: hw/mem/pc-dimm.c
> +F: hw/mem/sp-mem.c
>  F: include/hw/mem/memory-device.h
>  F: include/hw/mem/nvdimm.h
>  F: include/hw/mem/pc-dimm.h
> +F: include/hw/mem/sp-mem.h
>  F: docs/nvdimm.txt
>  
>  SPICE


