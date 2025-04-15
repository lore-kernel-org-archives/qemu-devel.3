Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD814C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4b3l-0003Ak-V7; Tue, 15 Apr 2025 03:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1u4b3j-0003AF-7d
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1u4b3g-0007ZS-EI
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744703412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9GL8Jiak0PPzAi305o2OIVAtyLPZMn+xMPHksf916Ng=;
 b=EzrfM10ZKNRc2hEY4/otiRrzwGuZjCkDb1LyOMQlBd6RLB4Q1o5tPebxQMj7Ud+91jDwdp
 yqHQWxf5pu5Pc0YyFYiSVapGDUypJqJr4PGum/7BWsvZb/YBPR0Dnvr2Rz1xIxGi1TYW7J
 ZKckTlyZDk2j3EbP5LepcYUh5IxpSNQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-5l6JnsNTO9auxSgewafZ9w-1; Tue, 15 Apr 2025 03:50:09 -0400
X-MC-Unique: 5l6JnsNTO9auxSgewafZ9w-1
X-Mimecast-MFC-AGG-ID: 5l6JnsNTO9auxSgewafZ9w_1744703408
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-739525d4d7bso3755981b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 00:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744703408; x=1745308208;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9GL8Jiak0PPzAi305o2OIVAtyLPZMn+xMPHksf916Ng=;
 b=Hf3+at18bR33WmPfJW+/HGs2OVys/muIJ5nE1EZHFyYggkc+87V/hNVJrPdnCNnSI0
 hMYSFN2+T5V1V4MmsBS26l4L9VCxOGRW1F4psaj1WKSGYM3mkEO/kcYTQIl03qdkwUdB
 ZM7G1usn/MzeqvYwJPY3ctEfCvYlOV3QGjeINwWftkkAINcmVawbXHy90JtZOYPtieWl
 dzq7Dwe0jwjgb3b3a9dD+6HbzRYi7cKl3D8nr5mBfFWZFVmEjeeJbTCxU95kK1pgMkHv
 vWGDJ89+5JH4rRQBvyOV2Jn9Gtqkrwu3gLCUEdg0Xe5dKWqXg8gQ2ABVkS9RevsJoWbf
 GuWw==
X-Gm-Message-State: AOJu0Yz6hrAiQFiC+2yhfHpPens5hWGXBhZgYYaLno/bgW16wKamCbNX
 xuMyWMuR+QmhiNPLOL+lhU1c7NzqOoBHBm+Qa81c0Kc7Mu3+zYdLykP1Cbu7UrL7WIoZZl1XI1U
 wMWR5qt/J8ZjzOK1qyo+FpTf5cS8hTwU/yA2ZXxofYzmy4LW2PiA4
X-Gm-Gg: ASbGncs8B8vDjSK7raZWs8tgnk299Gq8CYKDUw94z/emoC7Hzz8LDMUQrtP7CpgbHJ+
 1yWkoR5JqpRPSflIBnpfmANvfnwl7zdyoExEqB8ZqM3CfqSt6X/Kp6CfZb71EdXTuD505QfJSEf
 wZlENnmxy4RJ12MPxpBjFXgipzvt/T2lEtIyDavOaB30Ig+JAsNjR0TezfMHaAzRCUtb/C0SeQ1
 YWboBLjRR/ykBeRuosgCKzBiWAZgO45g9bhqAPlbIspZlymIEZmkkKflvb1AFmNMeyLBjwlT7Vx
 AQ1hBhBuoQh5A0tG
X-Received: by 2002:a05:6a21:32a3:b0:1f5:9208:3ac7 with SMTP id
 adf61e73a8af0-20179995dcbmr27309140637.41.1744703408544; 
 Tue, 15 Apr 2025 00:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu9EMf6d9BVqtrpts6HlArjZAaV7yFs26wRb9URmr1lUu62FiTMck++WIHCgXLXvf0aHaKtA==
X-Received: by 2002:a05:6a21:32a3:b0:1f5:9208:3ac7 with SMTP id
 adf61e73a8af0-20179995dcbmr27309086637.41.1744703407997; 
 Tue, 15 Apr 2025 00:50:07 -0700 (PDT)
Received: from [10.72.116.169] ([209.132.188.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd1fe6b4esm7881572b3a.0.2025.04.15.00.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 00:50:07 -0700 (PDT)
Message-ID: <21f3fedd-274e-4e81-87f8-369deefa8c1a@redhat.com>
Date: Tue, 15 Apr 2025 15:49:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] accel/kvm: Support KVM PMU filter
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250409082649.14733-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Zhao,

I've added some code and test it on ARM64, it works very well.

And after reviewing the code, it looks good to me.

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

On 4/9/25 4:26 PM, Zhao Liu wrote:
> Hi all,
> 
> Now I've converted the previous RFC (v2) to PATCH.
> 
> Compared with RFC v2 [1], this version mianly have the following
> changes:
>   * Make PMU related QAPIs accept decimal value instead of string.
>   * Introduce a three-level QAPI section to organize KVM PMU stuff.
>   * Fix QAPI related style issues.
>   * Rename "x86-default" format to "x86-select-umask".
> 
> Current pmu-filter QOM design could meet the requirements of both x86
> and ARM sides.
> 
> 
> Background
> ==========
> 
> I picked up Shaoqing's previous work [2] on the KVM PMU filter for arm,
> and now is trying to support this feature for x86 with a JSON-compatible
> API.
> 
> While arm and x86 use different KVM ioctls to configure the PMU filter,
> considering they all have similar inputs (PMU event + action), it is
> still possible to abstract a generic, cross-architecture kvm-pmu-filter
> object and provide users with a sufficiently generic or near-consistent
> QAPI interface.
> 
> That's what I did in this series, a new kvm-pmu-filter object, with the
> API like:
> 
> -object '{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"raw","code":196}]}'
> 
> For x86, this object is inserted into kvm accelerator and is extended
> to support fixed-counter and more formats ("x86-default" and
> "x86-masked-entry"):
> 
> -accel kvm,pmu-filter=f0 \
> -object '{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","x86-fixed-counter":0,"events":[{"format":"x86-masked-entry","select":196,"mask":255,"match":0,"exclude":true},{"format":"x86-masked-entry","select":197,"mask":255,"match":0,"exclude":true}]}'
> 
> This object can still be added as the property to the arch CPU if it is
> desired as a per CPU feature (as Shaoqin did for arm before).
> 
> 
> Introduction
> ============
> 
> 
> Formats supported in kvm-pmu-filter
> -----------------------------------
> 
> This series supports 3 formats:
> 
> * raw format (general format).
> 
>    This format indicates the code that has been encoded to be able to
>    index the PMU events, and which can be delivered directly to the KVM
>    ioctl. For arm, this means the event code, and for i386, this means
>    the raw event with the layout like:
> 
>        select high bit | umask | select low bits
> 
> * x86-select-umask format (i386 specific)
> 
>    x86 commonly uses select&umask to identify PMU events, and this format
>    is used to support the select&umask. Then QEMU will encode select and
>    umask into a raw format code.
> 
> * x86-masked-entry (i386 specific)
> 
>    This is a special format that x86's KVM_SET_PMU_EVENT_FILTER supports.
> 
> 
> CPU property v.s. KVM property
> ------------------------------
> 
> In Shaoqin's previous implementation [2], KVM PMU filter is made as a
> arm CPU property. This is because arm uses a per CPU ioctl
> (KVM_SET_DEVICE_ATTR) to configure KVM PMU filter.
> 
> However, for x86, the dependent ioctl (KVM_SET_PMU_EVENT_FILTER) is per
> VM. In the meantime, considering that for hybrid architecture, maybe in
> the future there will be a new per vCPU ioctl, or there will be
> practices to support filter fixed counter by configuring CPUIDs.
> 
> Based on the above thoughts, for x86, it is not appropriate to make the
> current per-VM ioctl-based PMU filter a CPU property. Instead, I make it
> a kvm property and configure it via "-accel kvm,pmu-filter=obj_id".
> 
> So in summary, it is feasible to use the KVM PMU filter as either a CPU
> or a KVM property, depending on whether it is used as a CPU feature or a
> VM feature.
> 
> The kvm-pmu-filter object, as an abstraction, is general enough to
> support filter configurations for different scopes (per-CPU or per-VM).
> 
> [1]: https://lore.kernel.org/qemu-devel/20250122090517.294083-1-zhao1.liu@intel.com/
> [2]: https://lore.kernel.org/qemu-devel/20240409024940.180107-1-shahuang@redhat.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (5):
>    qapi/qom: Introduce kvm-pmu-filter object
>    i386/kvm: Support basic KVM PMU filter
>    i386/kvm: Support event with select & umask format in KVM PMU filter
>    i386/kvm: Support event with masked entry format in KVM PMU filter
>    i386/kvm: Support fixed counter in KVM PMU filter
> 
>   MAINTAINERS              |   2 +
>   accel/kvm/kvm-pmu.c      | 177 +++++++++++++++++++++++++++++++++++++++
>   accel/kvm/meson.build    |   1 +
>   include/system/kvm-pmu.h |  51 +++++++++++
>   include/system/kvm_int.h |   2 +
>   qapi/accelerator.json    |  14 ++++
>   qapi/kvm.json            | 130 ++++++++++++++++++++++++++++
>   qapi/meson.build         |   1 +
>   qapi/qapi-schema.json    |   1 +
>   qapi/qom.json            |   3 +
>   qemu-options.hx          |  67 ++++++++++++++-
>   target/i386/kvm/kvm.c    | 176 ++++++++++++++++++++++++++++++++++++++
>   12 files changed, 624 insertions(+), 1 deletion(-)
>   create mode 100644 accel/kvm/kvm-pmu.c
>   create mode 100644 include/system/kvm-pmu.h
>   create mode 100644 qapi/accelerator.json
>   create mode 100644 qapi/kvm.json
> 

-- 
Shaoqin


