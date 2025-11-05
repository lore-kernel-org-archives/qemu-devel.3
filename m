Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FC0CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGiwU-0004Z9-Ex; Wed, 05 Nov 2025 14:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGiwR-0004YD-A5
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGiwP-0006nc-OW
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762369988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAjuNcKljn/c1T5RfxgqKqF8DyPB/yTqKDAm312+qHA=;
 b=XQIfkU0XFSt4ZBX8oUFevQmQj9Mvp2rLLQMK0wEuRH3rrLwVJjAFVfbsHygdrw5zU/7geQ
 rbgzxKU6DIe/yjX+pPU9ZzMCluzTbWx8AxJmtbzQGpdkl8uJwaV+QuvTC/73cls0W6vuIW
 IIyKbsJLKlAbbO3CvXGMVWjZ7Mx6mn4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-fYrrCrwmMtG1moAJnK-efA-1; Wed, 05 Nov 2025 14:13:05 -0500
X-MC-Unique: fYrrCrwmMtG1moAJnK-efA-1
X-Mimecast-MFC-AGG-ID: fYrrCrwmMtG1moAJnK-efA_1762369985
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88041f9e686so5480876d6.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762369985; x=1762974785; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XAjuNcKljn/c1T5RfxgqKqF8DyPB/yTqKDAm312+qHA=;
 b=IanD9E/Xl0tNt5K5i4B1FsdMc1kVD4NZeh9MTHKDegkhF7/0tEoCOJfQ9mBgIEn+If
 dUpltDswEifJcIo5keuTQ1FoEzjRRUqXvZ6/4whp34BcqEa1cs1OQ2iOC4T0iOmnKoRy
 QIuB+zjs3duGDvLyvVpNEjG9DJkzjvF99gZ8hTh9DnJNN0ZqIrvLI3eSYIfuHj0eEtiW
 5dQRg34obn3Xy5gfDdB2x7PGGOw5IU0piEufXzAOiI5ZgZEu176WmZe9Rfg3mk52y9hP
 MU8Rebwb8b6jp2rCF5ow4J8H32wq7mf7MzAa9hoqihvtpmUXytW+3vQWRV0COJlEa4v7
 m1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762369985; x=1762974785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAjuNcKljn/c1T5RfxgqKqF8DyPB/yTqKDAm312+qHA=;
 b=gGBlkdRhsFy5Lqhj8wajHPAyiBBWNFtFNBpSLpr0O+Ilt/Xg6y7KXNP2979xBDTKGG
 MlGc+ou9mGDPkmJ1z44P/0LP8TTc+vpZcxGP3/8pTZEhd3jeKxYzVlTM5OqTHLt6crj7
 XPIIDXKm8BCY4sGm+/DYeUvGlqH/F3hBHYlP6jGHMAhwuQW6zrTGQkduOawiGZwIkxqh
 ZX7NTtL5aDq6dz/KdZUEA5UOeHfXU1suQS02E0xM2PLbFrS4eBpaD/W0y6gAcBTL8tON
 SX7OFJlb57nxfuP/vHngvYfuvh+jqXN7BzjS5ORvgu/6akQim7qAjW/GITwYLYYBeOor
 iMhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4BOMNcl+igdH8vJmLPFoDe+DSCNQQ2mOiIFwoH749tVTPVAHxwganDM25oD964woudTtI/o89M9cE@nongnu.org
X-Gm-Message-State: AOJu0YyOilc8EnF8Ehio51Cg82qNhRUnCWZh+T8RVkC5jhKKHc5ie2EF
 HUGjOz8TM1D6Kf8X+Uan2w90Eme7JpsrMgTa2B9/OHP8IuhqN5oX6KYtiTrh/oJZTF+F22HnvZD
 VgMEcUfnFLF7+WoprXJkUZMJXatySyqYQvBKDf0mAqsUZry1LJRE/QSQa
X-Gm-Gg: ASbGncv6VtCEpfsLeKIpPKlspblcpgLHwFGZ81T56VSYCqnZSXwdomBl3eYKwJ0P+RK
 QLbWvFa8hM5IF4QVzYvojM44y+XB/rJy4wsLPycLmGJFE4Vqyzi/AdjSO69OuJOjv1/3/TxI21c
 1WX/WnyBlJ4dOdFrugHAeqgjldkucdJ8mKM1V2DCrCXKi5ZSTEkukIaO3VVmKggUWyfdwMUQJ5R
 T+yRbOw3LXiFFelJKm5dAHe7kJcb0v91TmaHSOUvCvRAe7qCLkMTS0u2oiSr6BXpCNjv2Clz46c
 rAG/qhBP2R98ilQRkBFSt+56T/NOZh56JikkRzL1KqXNCYgV93j2cY7X3TxQG9w3ibU=
X-Received: by 2002:a05:6214:caa:b0:87f:fbe1:2c2a with SMTP id
 6a1803df08f44-8807116cb65mr68006046d6.26.1762369984715; 
 Wed, 05 Nov 2025 11:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2j190PgLW6XGp9pjP2UF6JidT0Cqkdnx2ivHdhKysbhV/U7W80a23UmeSEWdxoBpJaGSdow==
X-Received: by 2002:a05:6214:caa:b0:87f:fbe1:2c2a with SMTP id
 6a1803df08f44-8807116cb65mr68004666d6.26.1762369983537; 
 Wed, 05 Nov 2025 11:13:03 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-880828f62absm2844166d6.19.2025.11.05.11.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:13:02 -0800 (PST)
Date: Wed, 5 Nov 2025 14:13:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PULL 07/42] machine: aux-ram-share option
Message-ID: <aQuhvURPy3qhY64-@x1.local>
References: <20250129160059.6987-1-farosas@suse.de>
 <20250129160059.6987-8-farosas@suse.de>
 <CAFEAcA8_zO0MmyN2nQDZsmiWssoiSUvKRMVYfRLrz6TsNejQFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8_zO0MmyN2nQDZsmiWssoiSUvKRMVYfRLrz6TsNejQFA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 04, 2025 at 10:53:54AM +0000, Peter Maydell wrote:
> On Wed, 29 Jan 2025 at 16:03, Fabiano Rosas <farosas@suse.de> wrote:
> >
> > From: Steve Sistare <steven.sistare@oracle.com>
> >
> > Allocate auxilliary guest RAM as an anonymous file that is shareable
> > with an external process.  This option applies to memory allocated as
> > a side effect of creating various devices. It does not apply to
> > memory-backend-objects, whether explicitly specified on the command
> > line, or implicitly created by the -m command line option.
> >
> > This option is intended to support new migration modes, in which the
> > memory region can be transferred in place to a new QEMU process, by sending
> > the memfd file descriptor to the process.  Memory contents are preserved,
> > and if the mode also transfers device descriptors, then pages that are
> > locked in memory for DMA remain locked.  This behavior is a pre-requisite
> > for supporting vfio, vdpa, and iommufd devices with the new modes.
> 
> Hi; I've just noticed that in this patch:
> 
> 
> > @@ -1162,6 +1178,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
> >      object_class_property_set_description(oc, "mem-merge",
> >          "Enable/disable memory merge support");
> >
> > +#ifdef CONFIG_POSIX
> > +    object_class_property_add_bool(oc, "aux-ram-share",
> > +                                   machine_get_aux_ram_share,
> > +                                   machine_set_aux_ram_share);
> > +#endif
> 
> we added a new class property to the machine, but we don't
> call object_class_property_set_description() to give it any
> help text (compare how we handle the other properties in this
> function).
> 
> > +
> >      object_class_property_add_bool(oc, "usb",
> >          machine_get_usb, machine_set_usb);
> >      object_class_property_set_description(oc, "usb",
> 
> This means that if you run "qemu-system-x86_64 -M q35,help"
> you'll see that this option is missing help text:
> 
> pc-q35-10.2-machine options:
>   acpi=<OnOffAuto>       - Enable ACPI
>   append=<string>        - Linux kernel command line
>   aux-ram-share=<bool>
>   boot=<BootConfiguration> - Boot configuration
>   bus-lock-ratelimit=<uint64_t> - Set the ratelimit for the bus locks
> acquired in VMs
>   confidential-guest-support=<link<confidential-guest-support>> - Set
> confidential guest scheme to support
>   default-bus-bypass-iommu=<bool>
> [etc]
> 
> Would somebody like to write a patch to add the missing
> description ?

Thanks for reporting, sent "[PATCH] machine: Provide a description for
aux-ram-share property" just now.

PS: for q35 there's another one fd-bootchk=..

-- 
Peter Xu


