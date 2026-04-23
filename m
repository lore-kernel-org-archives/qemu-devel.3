Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D8FC0360
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwaj-0004fL-S9; Thu, 23 Apr 2026 12:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFwaW-0004dm-Io
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFwaM-00012N-Ag
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776960442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QiK8IP/k+DnDYnRKizravr/pRsAQbIxHBJ6gwM6XuqU=;
 b=NigN/Nb47Mj9akBHyjJSYVxM8v20aTpWmiumD0MLQWDZjPiv65kt4opdUsIrQdpcAC9dad
 I++b2yL6FTNYKDlJ39XnE4yJxkM6QaMRN3xMfIW4exStT2/NrvDzC3rDgVdx7mBhDZRYFG
 8eODsR3kK/G3muWYCzLTEC/ETVXqtgY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-Awoyn8BuNUSjhgqquWWnbQ-1; Thu, 23 Apr 2026 12:07:21 -0400
X-MC-Unique: Awoyn8BuNUSjhgqquWWnbQ-1
X-Mimecast-MFC-AGG-ID: Awoyn8BuNUSjhgqquWWnbQ_1776960441
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca6420fe3so100761616d6.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776960441; x=1777565241; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QiK8IP/k+DnDYnRKizravr/pRsAQbIxHBJ6gwM6XuqU=;
 b=ii67jrV7U5jfkLyzieJryOSNasB01BLrNCvUnQf2zGYdPpiTrn+JBt7JcdAxOWVXdU
 CqZYIEscryH/1NgxiwEtQ95yrDGEy8zpLgp6tqZ+7r4Gsk/59XBNfG3vwom1P+R96Ee8
 GeLhWnRXmKvcOXSSj92Z3CWOmy1pvFB+ciSnx406RBa75LmHTuDYZM15MWFr6Jglizvo
 /sKn5TUxKyAFVc2HEtFiMosgBkAxVr8v9+/zc8zommOKjwW5DThT4LR/UDaNU+YEIb10
 198saLTEiI186BQVcKBpftY/vMJsjCYmUGHIk1hIWiI0KRKFylp/eqjNRXi8sCYpuzrA
 OUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776960441; x=1777565241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiK8IP/k+DnDYnRKizravr/pRsAQbIxHBJ6gwM6XuqU=;
 b=T2BNikz2HgRDd8lQQSJ8jWx1q+j5oIOd3gOmVB4YPQ5upxcJTncdbEeZibjPy9hnbI
 llFIdQTh3e0FGOqQYyTfdwA+6ggzCfKET1speGgP/tysQnOD4VqWgqvnJlW3OFVfhy7m
 /euTifQVPRu9ajP6kE4NRyIBPN+4V7mR04gyrGkejwV6wsjLHGucr5l8ZrHdaPDbhzY9
 rVAiToHsMQAv7U93GNNggWzNo1VHtrRyLE98mtmbJCmmry4vJ0Px8ZRc9RYkyZRApkuv
 keqkvdn+qvvu98N4rCWG4rC2w6xxd6kYQ3yGJ5JUHZBvHiKW74VCWTneAEbX1Vs8BVXZ
 c3Pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9G+TDVe7KAJTxQ96SsHRw6SbMhK5tQaRTVU08955W4lK/277SK+1gdOrdtTx2cwtlzyvfD911uRaTU@nongnu.org
X-Gm-Message-State: AOJu0Yw2fIcKFl09gxPojveJnLU+57TAaF+cfn8nqygoXd5WpRa9B+4w
 8BmBJdAxK72OAssO0GCO3S1jslxRJtB2pE0LZOI/ZS0CbLEWQpFxVvGabVUBwf1Naa6NQiAztyA
 jhOXv+904W7XHTkwLrDvGaEa10hIyErmQ199/WlUyuMKan1lgaoYaZads
X-Gm-Gg: AeBDieujDySYqjJ1an5TIYrO3zSJ9L65q3ZITpJhHZllt00cITysTnDZFqe+tBpY0OA
 mCgInMxx/UwDfEBsPb1OxmdIIWs3zFwQZAlsjPJsSOAgNUhWAkibvj9YJdI11ROBCcdqZvtk0zS
 tkEnuhzDWAdeI3PnTTJjMU9VOSLPnIxTMPSfLM1VPeGstcdpDm91JdngOyn/POb1WNi99KqdxhM
 NthrF1qmMQ2s7X/ToE4s8v0ELejKSaAhIh/IhaoQqT1piL97JU/wwWjjnPMO97p0v79IsVyUy51
 pNeWNdLjxPmCElyWlK/AgGjTb0KblNSh2Szp+lVhDENOGKJS5XZ7jWwPTBV6rwcZNZyTyW9gB1D
 6HLgQFSq9O2oKft2a4vZbz7WhTuo4cq7O5fzLn+VIjSMF4gwiIy5+TZlGWA==
X-Received: by 2002:ad4:5765:0:b0:8b0:2b9e:9639 with SMTP id
 6a1803df08f44-8b02b9e9e6dmr428012396d6.19.1776960440644; 
 Thu, 23 Apr 2026 09:07:20 -0700 (PDT)
X-Received: by 2002:ad4:5765:0:b0:8b0:2b9e:9639 with SMTP id
 6a1803df08f44-8b02b9e9e6dmr428011796d6.19.1776960440100; 
 Thu, 23 Apr 2026 09:07:20 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5ec2dsm167327096d6.29.2026.04.23.09.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 09:07:19 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:07:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: "philmd@linaro.org" <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "farosas@suse.de" <farosas@suse.de>
Subject: Re: [PATCH v4 08/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
Message-ID: <aepDtUYjYfag6TeC@x1.local>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
 <20260423051804.362095-9-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423051804.362095-9-jamin_lin@aspeedtech.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 23, 2026 at 05:18:15AM +0000, Jamin Lin wrote:
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0aa77a57e9..e77400c7ab 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,8 @@
>  GlobalProperty hw_compat_10_2[] = {
>      { "scsi-block", "migrate-pr", "off" },
>      { "isa-cirrus-vga", "global-vmstate", "true" },
> +    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
> +    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
>  };

Sorry I forgot to comment here previously: we just released 11.0, I think
it means you want hw_compat_11_0[] now, otherwise someone using 11.0.0
released binary may hit issues migrating to some newer binaries before 11.1.

-- 
Peter Xu


