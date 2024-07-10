Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA92C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 10:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRUwg-0005ny-9K; Wed, 10 Jul 2024 06:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sRUwe-0005gP-8U
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sRUwb-00008O-Ss
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720608784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51cZzeb/5l9XLCuIEsbKqOvP8NX8IPl8vBxTyiUptj8=;
 b=jIHmOutoR6aZ/hfW59J0HXwf78/tXCNuYcm37jwh/86//FqyUwPPi0K4zMRerBi7gOZeWX
 DW/UpvN5na/Mr83KAmTYEhdPAZDOBuHIa6ZPdTFO4OnrE6dI8RuPml91dA6ouN5epSVF9l
 zr2gxtsXwITFDCoJDb4wTNrI2jM6XoU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-4Sg71oSzNeua5BylZc-BGQ-1; Wed, 10 Jul 2024 06:53:03 -0400
X-MC-Unique: 4Sg71oSzNeua5BylZc-BGQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367990b4beeso4191891f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 03:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720608782; x=1721213582;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=51cZzeb/5l9XLCuIEsbKqOvP8NX8IPl8vBxTyiUptj8=;
 b=rAEzYjULKkba1hf7yTx9N7aVxkKTZIZkGMQlUfvNRbG9mrrA7LZc/l+JSY9lqzI3X3
 1ImdOMgMGSWtHIXlDwz7WiVBwTj8UoNiTy0cPa3bea08Qk82uksOIrA3qSPMDGluCE/O
 ZOd45N4KRQ/1i7R592YBODbPP3BgpJ70wmKqyvGQm4IZW6osinAGuv9hQQWRcjFdbpcR
 w8QcDshIvG3nEHjWJlRSZg9TT5GoebKfQWD0RhuayyNT1vozzDVyg8VZnBuvKEjYaOzT
 DE9cTqtBqWRntQ3EKB2CQefg6jX6v3Cg6i4KlFpC02HqNQmBJlaaMcZLpoNyrB5BH/LC
 FWcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5wau5LEtIVmEUXYNrzRf0UgQV8L/uNr1mwh8n/21EnRZemRa6OXPiBXywXu8/lZ9VffSaMWihk2XdQfmCu4kTNos/FvI=
X-Gm-Message-State: AOJu0Yyx9tyUodbaUVMgUjYP9s70B4nXtAtAlmUf6UM5EQ3XFKgLrJtf
 rJZqtEFCkZMZsSvOAp7Ip/6+OaR+/Y06wABLg7LhdDdAs44KMWQ9H3tmilcUgvUVbm7V/ore2of
 nv8lkUw+66sKhhhNLnLLv3TfhuCBu0sifRCvT36E2iaVtDo0j+rt/
X-Received: by 2002:a5d:68cd:0:b0:367:9d21:22cb with SMTP id
 ffacd0b85a97d-367cea73551mr3121601f8f.22.1720608782055; 
 Wed, 10 Jul 2024 03:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrCrJdvbq2INZQ9Xe2ZxBH+SZ7E9sU4DUnOGi/2VFIoHNVnkkmmSfIotAoo1Zvhg6Lp4BpAA==
X-Received: by 2002:a5d:68cd:0:b0:367:9d21:22cb with SMTP id
 ffacd0b85a97d-367cea73551mr3121576f8f.22.1720608781438; 
 Wed, 10 Jul 2024 03:53:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa067dsm5021944f8f.78.2024.07.10.03.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 03:53:00 -0700 (PDT)
Date: Wed, 10 Jul 2024 06:52:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v10 06/12] pcie_sriov: Reuse SR-IOV VF device instances
Message-ID: <20240710065145-mutt-send-email-mst@kernel.org>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
 <20240627-reuse-v10-6-7ca0b8ed3d9f@daynix.com>
 <75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 10, 2024 at 08:37:27AM +0200, Cédric Le Goater wrote:
> Hello,
> 
> This change introduced a regression on s390x. I could have spotted it
> earlier. Sorry about that. Here is the scenario,
> 
> QEMU now creates automatically the PCI device objects representing the
> VFs when the PF device is realized in pcie_sriov_pf_init(). This is
> good to report errors early but it has an important drawback.
> 
> On s390x, PCI devices have a dual S390PCIBusDevice object. This device
> model has 'uid' and 'fid' properties which can be either set by the VMM
> or, if not, auto-generated by the S390PCIBusDevice realize handler. In
> the VF case, these ids are auto-generated by QEMU and they can possibly
> conflict with the uid number space of libvirt. The conflict is detected
> when the machine is created and the start is aborted with a message :
> 
>   2024-07-08T12:51:42.876883Z qemu-system-s390x: -device {"driver":"zpci","uid":17,"fid":16,"target":"hostdev0","id":"zpci17"}: uid 17 already in use
> 
> This problem can occur today with a s390x VM using an IGB device.
> 
> It worked fine when the VFs were created at OS runtime because the initial
> topology of the machine was in place. Adding VFs was more or less like
> hotplug. AIUI, libvirt should have full control on the machine topology
> and so, creating VFs in QEMU at init time in the back of libvirt seems
> like a violation of this rule.
> 
> That said, the s390x case is specific and could perhaps be handled in a
> special way.
> 
> Thanks,
> 
> C.


Thanks for reporting this Cédric. Akihiko what's your
plan to handle this? Do you have the time to address this issue?


-- 
MST


