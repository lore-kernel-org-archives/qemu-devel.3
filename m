Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441ABCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENbl-00010E-Qw; Wed, 07 Oct 2026 05:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xELWb-0004Na-4l
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xELWV-0005Uq-4M
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791355974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zBOhR1PnHIAJxOFxEKlgw7dN9FfN3Xz2rziQ1CGABF0=;
 b=WgyoQ2qlCfUN+WKi5463exldfa6KKKvsfWEpKlFpSR5Qr6WRYaV1dgz54sONY5KND6TFN0
 T5isWrDkqem6at5fFZEVOAjrwi+XBijd+NDPzoH2QoMDK+TV7iTaEMbIdwp4dtNYm0qn3e
 KIgi72FyHPBUhqO1kwHEujojKX+vZgA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-XQkWpDDyO6ypATu_FjSHfQ-1; Wed, 07 Oct 2026 02:52:53 -0400
X-MC-Unique: XQkWpDDyO6ypATu_FjSHfQ-1
X-Mimecast-MFC-AGG-ID: XQkWpDDyO6ypATu_FjSHfQ_1791355972
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso27701315e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791355972; x=1791960772; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zBOhR1PnHIAJxOFxEKlgw7dN9FfN3Xz2rziQ1CGABF0=;
 b=iVGkwFjuCoH6WsHpdVy3QthbdsUX3GthukGNP24h8B7lq504PaNIq8kAmlpYdgKE8b
 ZJfeCRiVov1lv9+NmuDRDcTBOQI1L8Ir028o9nUFJXlrgF5GsYZ+/qVKnOZSgRC2qt6B
 +fQ57JfOiR/hj563Lv1wvvsiQQzrNDqKngqIupYuFE5O7ob6qu/beksRVI12lDybff0p
 s1UJd87zfvygTd5kUCTCYNbi11/nGXnL4dgekZYEBrbvCnTssY3OMu09fGtvdm9lw7Ky
 wUJoglavT5yCQmBVVU3ugjjdKqIx/Y80jZVKaNenOLIBuTatxgCZO0nnRGq0HuEDLrii
 BPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791355972; x=1791960772;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zBOhR1PnHIAJxOFxEKlgw7dN9FfN3Xz2rziQ1CGABF0=;
 b=jKZEYzJiPi52hjQxLoQgbogqZi0Qa/x8nGZ5dkIQI8ivCXPxvPgLmayTpLK+2QGKy3
 ZAsvHI/aZozvNqMaCveCzDOghUd9wlub1hWMmkllXtYBh1Z2lD2KtoZcKNezbLevpJmA
 6uoVNPfOuZVWd1nFEP6Hrt7qf+u7lVrUMkA8HE8svxp9D3WweES5HxVdrk7wMmhk2wLz
 sLuAbpxn7DH4ZPP+02aRKZXDDXlGDlJgAh0UEQOS/TG+/RL/ZMDVK+wEVSDev+65x+aZ
 oCMjJMJPWzUD1jnBrYwbg6wB7mMzBB4A5XPedZvU8RKMIIvmmexmKToTuOVVhQVTzBBb
 npEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgfd66YX8eQ7A8HGpu4Br7H86iVIpmJXImNEuW1NBFR/3KNA/9V52aEKNLK++bWpdniaGpQYmDj62d@nongnu.org
X-Gm-Message-State: AFuF++mAlNg6sjOMR5n5N7jNYwySplrukqqVqu/JD08X00ny0aXShAdr
 FdCPB1gZxtQra5YyYtjBxtAQSB2EFt11q3nGkiehQA7qfh8MNeXxk9d2AOAT7ePlmy3tx9VyLAN
 bnVpmJ5SJMPp0g+iFqOnJLHgISfhnyXzpw/LjtTMkbEQvBfTj9pIfYUxR
X-Gm-Gg: AYBFou3vEyxNwD8Ag+Ch2wTjNoTs0odcdZvz0zlPtW9n4SZH3M8q4XRJJvEMyoH5p9J
 WUwhRoDpIusS7K/K+52x1QrFj9qcc50xGGFcajMjRCnC2PMT7PG4R28CM2g6ZuulZ+F88NJ12KP
 PIyq73e+FWSCHHWwE7jtrrgixjEPJ5GWre/T8voV22+nW/v4y/5+Fp1XigTmXZVozn6W2ey0lqH
 oC3+w3Ai9godgaF2i8g9Hy9rauJMQ55IOzUq6rhiWYpsBwowEmk+XSZtBO9jbQTk6IXAIcpFKnq
 mlLivFsAbqX4fIBJ66PQhjDaL6T+afFCuyI2Xd6HRDltXvdmxy2uc1YfQrOBwV2ah7iCRcqdDLT
 hncshbN+wt3XboeQHL9Q=
X-Received: by 2002:a05:600c:871a:b0:49f:faa3:3ca2 with SMTP id
 5b1f17b1804b1-4a18041ee50mr15887615e9.13.1791355970795; 
 Tue, 06 Oct 2026 23:52:50 -0700 (PDT)
X-Received: by 2002:a05:600c:871a:b0:49f:faa3:3ca2 with SMTP id
 5b1f17b1804b1-4a18041ee50mr15887025e9.13.1791355969899; 
 Tue, 06 Oct 2026 23:52:49 -0700 (PDT)
Received: from [10.1.38.247] (90-181-163-241.rco.o2.cz. [90.181.163.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f51beffsm44618195e9.2.2026.10.06.23.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 23:52:49 -0700 (PDT)
Message-ID: <6ec3e7f7-fde1-4e90-bb3e-7af107db953a@redhat.com>
Date: Wed, 7 Oct 2026 08:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND 0/4] vfio-user: support multiple FDs backing
 region mmaps
To: Naman Gulati <namangulati@google.com>, qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>
References: <20261007000833.2445641-1-namangulati@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261007000833.2445641-1-namangulati@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Naman,

On 10/7/26 02:08, Naman Gulati wrote:
> This series extends the vfio-user protocol specification to allow
> servers to pass multiple file descriptors for different sparse memory
> areas to be mmap'ed within a single device region.
> 
> This extension is intended for exposing paravirtualized PCI devices via
> a vfio-user server that may have multiple unique sub-regions in a BAR
> backed by some mmap'able buffers sourced from distinct file descriptors.
> 
> This change introduces a new capability:
>    VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
> 
> Unlike VFIO_REGION_INFO_CAP_SPARSE_MMAP (which maps all sparse areas
> from a single open file descriptor), this new capability defines an
> array of sparse mmap areas where each area contains an index into the
> array of file descriptors.
> 
> When all sparse areas share a single file descriptor, servers may
> continue to emit VFIO_REGION_INFO_CAP_SPARSE_MMAP and send exactly one
> file descriptor in SCM_RIGHTS for backwards compatibility with older
> clients.
> 
> The extensions in this series also lays the groundwork to make use of
> the in-development series [1] extending vfio-pci to return distinct
> dmabuf FDs for discrete regions of a device's BAR. A vfio-user server
> may choose to return dmabuf FDs for various regions of a device's BAR to
> map a vfio passthrough device into the guest, in order to retain control
> of the device and be able to revoke mappings passed to the VM.
> 
> libvfio-user server side changes WIP on github [2].
> 
> 
> [1] https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org
> [2] https://github.com/NamanGulati/libvfio-user/tree/multi-region-fd
> 
> ---
> Changes from v2:
>    - As suggested by Cedric: kept core VFIO changes minimal by only
>      extending VFIOMMmap to hold each mmap subregion's fd & fd_offset.
>    - Moved multi-FD management and capability parsing into hw/vfio-user,
>      and using VFIOUserProxy to hold region multi-fds.
>    - Resend: rebased to head.
>    - Link to v2: https://lore.kernel.org/qemu-devel/20260826050039.2068138-1-namangulati@google.com
> 
> Changes from RFC:
>    - Refactored the get_region_info callback to keep vbasedev constant
>      and take in a VFIORegionFDs* out parameter to store the received fds.
>    - Link to RFC: https://lore.kernel.org/qemu-devel/20260811233930.401797-1-namangulati@google.com
> ---
> 
> Naman Gulati (4):
>    vfio-user: add multi-fd region mmap capability
>    vfio: add 'fd' and 'fd_offset' to VFIOMmap
>    vfio: add setup_sparse_mmaps hook to VFIODeviceIOOps
>    vfio-user: support multiple FDs for sparse mmap regions
> 
>   docs/interop/vfio-user.rst    | 71 +++++++++++++++++++++++++--
>   hw/vfio-user/protocol.h       | 22 +++++++++
>   hw/vfio-user/proxy.h          |  2 +
>   hw/vfio/vfio-region.h         |  9 +++-
>   include/hw/vfio/vfio-device.h | 16 +++++++
>   hw/vfio-user/device.c         | 90 ++++++++++++++++++++++++++++++++---
>   hw/vfio-user/proxy.c          | 32 +++++++++++--
>   hw/vfio/pci.c                 |  2 +
>   hw/vfio/region.c              | 51 ++++++++++++++++----
>   9 files changed, 269 insertions(+), 26 deletions(-)
> 

There is no need to resend. We need some acks from the vfio-user team now.

Thanks,

C.


