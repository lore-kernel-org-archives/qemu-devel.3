Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A4AC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLghK-0004uD-QX; Mon, 24 Jun 2024 06:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLghJ-0004tt-44
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLghH-0006ZQ-Gf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719223992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IYosgh/Ak+8KVQ19lZDf2tmkDoaJHmZMfGthftVeBg=;
 b=dyGNSf25+BYsvWvpW+/HuX+Tlxg0xOQC6FbFsTruh2p4H+M8ucv8C5KgXE7dLEC16sQDBE
 +pTPKdHRygpj8Mgb9Pnfl1gtC9NvTGhxGi4w9qkCw6hWym1bW8GBaR5oJO10AykOkA5dt6
 iQHum5RQleAAlyc+QDk1blca1kbKQCQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-kgKI2jlSOgiqJ9cWf0QCwg-1; Mon, 24 Jun 2024 06:13:11 -0400
X-MC-Unique: kgKI2jlSOgiqJ9cWf0QCwg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57c6e28b151so2249195a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719223989; x=1719828789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IYosgh/Ak+8KVQ19lZDf2tmkDoaJHmZMfGthftVeBg=;
 b=GRQuooGQ18GsiIDlZGv8uJ8GsblGma0Hn5tzy/3fT4ocKGo4lf9wflnBOOsmcFeQOv
 8ynoXf+nRFZdZLaJSGw37LgKNz8Wt+dwWjyGqHsBF5yqQAzwSa+aFnCUp347PyLmP3zE
 w2CIU/R5K5J3+EuGYsSOhrkFRpi4tPGYDVzRJmXjDH4hzdI9U/Q/crerCC/OgpsZyr/X
 7VyPgMjY7ldWiVkoEu9xQvtNqDGguNtoJbHop1P9ksaQmKsO0xPnmolPW518GSakej6p
 pVWSOsfQXrTynCJ8WfhzJoG0hNC5/lgkUY2++EMUtoKYUkum91jEbFrVasP8bTKE5IpY
 VEMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaj4uCHtqfUDCkxaPx72xKNR0+dYmM3RKnUvCPuT0/ztF6qQ+SmK4mq4R0QqDJMJyF7lUrIzQ2o/7ThMTo8LkiufzcAq4=
X-Gm-Message-State: AOJu0Yz/8ZlZYqJfxrtjK/UKx7wOQwQkQ0UKAVRADWNhzN8v/6AnO41I
 Cg+15PPgt4bP9xgxS8YP6D7WTGgmNz6q/NyRcnp7z44Hcqmty283Bn8dxdhmcdUff0myOSUCCwl
 +ATO6drK5yC1dK/wDYbYl7y1fm2vdWywWD0jmA2bz/ouIW/l11PP0ZVO5UfkhMgk=
X-Received: by 2002:a50:cd59:0:b0:57c:6a1f:11d5 with SMTP id
 4fb4d7f45d1cf-57d4bd63249mr2547602a12.15.1719223989242; 
 Mon, 24 Jun 2024 03:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWd+UYcg1Ws5kzQ1fVt2PLqrGEBBqJX3cPPrg/lUuJAJE81Z6Szux09GcbjNyhJM5LqVIrjA==
X-Received: by 2002:a50:cd59:0:b0:57c:6a1f:11d5 with SMTP id
 4fb4d7f45d1cf-57d4bd63249mr2547574a12.15.1719223988474; 
 Mon, 24 Jun 2024 03:13:08 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3006d36bsm4543457a12.0.2024.06.24.03.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:13:07 -0700 (PDT)
Date: Mon, 24 Jun 2024 06:13:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: Failed to hot-plug device to pxb bridge
Message-ID: <20240624060856-mutt-send-email-mst@kernel.org>
References: <3A8D097B-3BA7-40DC-8DDF-D79B7BEE5CEE@baidu.com>
 <20240530160919.01a3effc@imammedo.users.ipa.redhat.com>
 <2cae6cf3c0f64b509ceed04be6a8bd70@baidu.com>
 <74e8929fd34d496ea64aab6b3a136b3b@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e8929fd34d496ea64aab6b3a136b3b@baidu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jun 24, 2024 at 03:08:55AM +0000, Gao,Shiyuan wrote:
> > I checked the guest dmesg and found that failed load shpc driver.
> >   [    0.966668] shpchp 0000:00:05.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.S28_)
> >   [    0.968238] shpchp 0000:00:05.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
> >   [    0.969160] shpchp 0000:00:05.0: Cannot get control of SHPC hotplug
> >   [    0.969876] shpchp 0000:00:06.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.S30_)
> >   [    0.971454] shpchp 0000:00:06.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
> >   [    0.972376] shpchp 0000:00:06.0: Cannot get control of SHPC hotplug
> >   [    0.973119] shpchp 0000:80:00.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PC80)
> >   [    0.974674] shpchp 0000:80:00.0: Cannot get control of SHPC hotplug
> >   [    0.979422] shpchp 0000:81:01.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PC80)
> >   [    0.980948] shpchp 0000:81:01.0: Cannot get control of SHPC hotplug
> >   [    0.981685] shpchp 0000:60:00.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PC60)
> >   [    0.994623] shpchp 0000:60:00.0: Cannot get control of SHPC hotplug
> >   [    0.995349] shpchp 0000:61:01.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PC60)
> >   [    0.996891] shpchp 0000:61:01.0: Cannot get control of SHPC hotplug
> >   [    0.997626] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > Read the shpc driver code, I found that before shpc_init it need check the shpc capability of bridge(shpc_capable) and
> > get hotplug control from firmware(acpi_get_hp_hw_control_from_firmware) in shpc_probe.
> > Howerver it return fail in acpi_get_hp_hw_control_from_firmware. I dump the acpid table, not found OSC and OSHP
> > method in dsdt.dsl.
> > In the QEMU build_dsdt, not found build osc method in i440fx.
> > Putting aside this pxb scenario, I suspect that after disable acpi-pci-hotplug-with-bridge-support,
> > hot-plug into the PCI bridge via SHPC can be successful in i440fx ?
> 
> After adding oshp method in build_dsdt, the SHPC driver load sucess and hotplug device sucess. Maybe we need a patch
> fix it ?
> 
> 
> 
> 

Sorry, can't really say what you are proposing.
Send a patch?




