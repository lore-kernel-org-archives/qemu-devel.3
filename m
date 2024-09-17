Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2F5CAC59E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 20:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqeg3-00026L-Jt; Tue, 17 Sep 2024 16:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqeg1-0001zC-JR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 16:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqeg0-0003O1-4C
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 16:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726604394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nq0uthfWvOLTRsb4iK86UMrnfE1qXStyXmn7C7zUaUs=;
 b=G83relxazJ6C+R5RYCNbatWfBfZJOIrhlGgPc4V1Wc3hPagjo3FhWbtADQJvAAZi31Oh4M
 aqcTsVVhXtMs8MIPuQe5LMappwK3miLJ84+Df/IriB2gcgXYK765xrcZxCPf3SReD2UlQW
 uTBZIlBxsC+36+Jw7bs5Po7CXt+eS28=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-WxzfrHL7Ptyz4Lpk0Se2SA-1; Tue, 17 Sep 2024 16:19:53 -0400
X-MC-Unique: WxzfrHL7Ptyz4Lpk0Se2SA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a7d9c328c9so1161026885a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 13:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726604393; x=1727209193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nq0uthfWvOLTRsb4iK86UMrnfE1qXStyXmn7C7zUaUs=;
 b=Ys0ziXl9/AvyxG1Qx5516h2BaOIHKDfWrIJBXT3s0iwNG2NeWuK7c8//FI3bOVg2G9
 QXT+Nhl11iw+Y1SoX3Z4kwsy2DOWoc734E3nTPnUoVUsEY2jLGlnEd1x68SYTT24om0p
 tpSwZvwjulLgGhR9sMo9N3W6dD2nlK50gajo9POBmpm7nNq4vNX1SGUfY82avkgWXq3Y
 tMowKmac9x4vhR6776F7ahEMbmGpNfRC6PB61rBRk36qn4tuZFfSuE6Wk+bIhbj6QZ/a
 LNJQ18pScdYaV6pcH3QZUPb3LzWjlqvIn0vnohBa9d4dPN/ZS1kwKPixBRfRtrUjbFgr
 /Fjg==
X-Gm-Message-State: AOJu0YyFh4+AUJ57zZAWlDbtBcVRla36gSpg/uZaPZA7Xey+Qi8Rnv5W
 S7azYWBQex8ecGzfsSMDpCTWuZxcMpgXBKDN/CL4AIIbTdB8L8ZMCOeUtrgiZComY4FfjJhCVe1
 Xfi6fHrGv/gd4fdn5z1nAa5tlKOZg0/fyZmhKXVxdO2TnWi3OL1eG
X-Received: by 2002:a05:620a:298b:b0:7a7:fdef:27a with SMTP id
 af79cd13be357-7a9e5f9100fmr3834421085a.58.1726604392910; 
 Tue, 17 Sep 2024 13:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKDuI/6jY+IDgmrxXwK7m0vUyGBXCQxG5dZRyQptI///Sg+8AucOtf+ALVRdd6vHodObEtuw==
X-Received: by 2002:a05:620a:298b:b0:7a7:fdef:27a with SMTP id
 af79cd13be357-7a9e5f9100fmr3834416685a.58.1726604392390; 
 Tue, 17 Sep 2024 13:19:52 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e9b39e9sm390438785a.54.2024.09.17.13.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 13:19:51 -0700 (PDT)
Date: Tue, 17 Sep 2024 16:19:49 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gao Shiyuan <gaoshiyuan@baidu.com>, Zuo Boqun <zuoboqun@baidu.com>
Subject: Re: [PULL 14/18] virtio-pci: Add lookup subregion of VirtIOPCIRegion
 MR
Message-ID: <ZunkZfN8Th5ofRLs@x1n>
References: <cover.1726062663.git.mst@redhat.com>
 <ffa8a3e3b2e6ff017113b98d500d6a9e05b1560a.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffa8a3e3b2e6ff017113b98d500d6a9e05b1560a.1726062663.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 11, 2024 at 09:52:08AM -0400, Michael S. Tsirkin wrote:
> From: Gao Shiyuan <gaoshiyuan@baidu.com>
> 
> Now virtio_address_space_lookup only lookup common/isr/device/notify
> MR and exclude their subregions.
> 
> When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER enable, the notify MR has
> host-notifier subregions and we need use host-notifier MR to
> notify the hardware accelerator directly instead of eventfd notify.
> 
> Further more, maybe common/isr/device MR also has subregions in
> the future, so need memory_region_find for each MR incluing
> their subregions.
> 
> Add lookup subregion of VirtIOPCIRegion MR instead of only lookup container MR.
> 
> Fixes: a93c8d8 ("virtio-pci: Replace modern_as with direct access to modern_bar")
> Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> Message-Id: <20240903120304.97833-1-gaoshiyuan@baidu.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi,

QEMU master currently crashes with below cmdlines on my system:

qemu_bin=./qemu-system-x86_64
$qemu_bin -accel kvm -m 4g \
          -name peter-vm,debug-threads=on -msg timestamp=on \
          -nographic -cpu host -smp 4 \
          -device ioh3420,id=pcie.1,chassis=1 \
          -netdev user,id=net0 \
          -device virtio-net-pci,netdev=net0,bus=pcie.1

qemu-system-x86_64: ../hw/virtio/virtio-pci.c:620: virtio_address_space_lookup: Assertion `mrs.mr' failed.

Bisection goes to this patch..

Thanks,

-- 
Peter Xu


