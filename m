Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF25CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 07:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAjtq-0000Gc-LH; Mon, 20 Oct 2025 03:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAjtp-0000DX-AH
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAjtn-0004bh-5r
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760943701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O4csDwzdMwQjW6uP3/tlSZE/YYA/ukAkP3Ck8FP+lCo=;
 b=ZG9eMT1rmi7LorX44OzcUUgpFKIB8QJKybN8crlvOrL2dMkyEV6qD5TDNoZfhOP3mQj9wJ
 IP5hGbdpxx3tfNOrDlGuU25CfEQl1+VIA3dGM8gJIjRxpmmrC5fhWPCe6jb7ekrW7sD11h
 vyKWll50EK6vqgVi/xUiBvTGcleaEKE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-FgJNX3HYM0eko3_DIjjTgg-1; Mon, 20 Oct 2025 03:01:40 -0400
X-MC-Unique: FgJNX3HYM0eko3_DIjjTgg-1
X-Mimecast-MFC-AGG-ID: FgJNX3HYM0eko3_DIjjTgg_1760943699
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4278c82dce6so1259547f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 00:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760943699; x=1761548499;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O4csDwzdMwQjW6uP3/tlSZE/YYA/ukAkP3Ck8FP+lCo=;
 b=B7pYL4EaeycV/4ply042FfAYlkl+bem8rpfwkUzTnGHHuLDw1+uoJ+q7IrQZ2ug7SI
 dSM1Adj66ZNsx8Fn4gl2p0bYU+LO0ICdN+8erHSpeZKAcJ42nbyZfqTLW5bOSweycWRj
 PHDsb6JDP9zuYAV49ChmTLR1NymhDqxa4B5j8H9nLmkDeIV+hWNRvGWN2dpd4sS63hec
 3tpdHl3s5Lz8vDuVSNcEDdl6eJ1iADDJXZYGRUXm1Lvfp0aNfwhhi9J9XfzUD7lqFjTu
 TjFqZqjHxMhBx6dg+zdQQmur+TPmFo9ncLVNSx5xOzE5KOuWzv9+SFoiakXQTdQ1tGXS
 389Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJK4/3z1YPCOyJeeiYCOMtKNLmEcHonLT32PhyE+jMX7+6gBJ4B6UmJtZo63qYkkzkCjXL+Ngv6APh@nongnu.org
X-Gm-Message-State: AOJu0YyNDX2JPY/F4WOEJ9AVy9WGKLilzFKO5F+u1n4Am2fjXMta83V5
 8Ibf4aA/+E8CNW0Wr73es0wB1pcPKZL4RphiQmXS5G7h35kUHZbvHTmkycPiks3D0bd/7Ksbbb9
 HHR4FA3lJvLwS/IWGLX5+nxHwjvPiOTMXiYHa3/uFZlJhmb0hhTAFNa3N
X-Gm-Gg: ASbGncu2nuWpukhBOUJ8T4TLYjY4FyD4xCKw7/436maZynKZWvPXaFYDGMMMJoMjtQY
 tl1iuvJXy6nqgZq+nfhdNjVI1wFzMY1E1OhVOyfR0uiUzw1PxmXotzJnBX/OTLkcEygeB2ofAsm
 GKDE9qWGLZZ917NlA89HWTKuGuwfeSmQC3uQiQN889SlCkwhLztzNK2SN0gku6eeyTlfivE88NL
 BLKT8vKmEx3sbYCqJnVhfaWX+QV4Wx+suyKmJpqVtapKIBsBUWcUvk8ZxaTEi4Hs4cyOBUbramz
 WUR3YKCpW/Zbf6VCB23FaNXg9PaQLMu95Gt9prdgaTuiUmm5pGA6R/pKSHlymOp3P+BTWKhkeDo
 OXEAEAl6Rd7qKpHcKLIyL0guo+pDaVRF+YzzbfQ==
X-Received: by 2002:a05:600c:a4c:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-471178a23c5mr86786055e9.9.1760943698803; 
 Mon, 20 Oct 2025 00:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn/J0Cm9I+MTQhBFYSicXQ6ymFGLHI8scfSmgmPuR2eObPd0fMMAufcHu3UGlz01oh/HBabQ==
X-Received: by 2002:a05:600c:a4c:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-471178a23c5mr86785755e9.9.1760943698417; 
 Mon, 20 Oct 2025 00:01:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715520dd65sm127926885e9.15.2025.10.20.00.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 00:01:37 -0700 (PDT)
Message-ID: <2a211e1c-e2ac-42c0-be70-4fb226f57e69@redhat.com>
Date: Mon, 20 Oct 2025 09:01:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, avihaih@nvidia.com, xudong.hao@intel.com,
 giovanni.cabiddu@intel.com, mark.gross@intel.com, arjan.van.de.ven@intel.com
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-6-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251017082234.517827-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/17/25 10:22, Zhenzhong Duan wrote:
> Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the last dirty
> bitmap query right before unmap, no PTEs flushes. This accelerates the
> query without issue because unmap will tear down the mapping anyway.
> 
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   include/system/iommufd.h | 2 +-
>   backends/iommufd.c       | 5 +++--
>   hw/vfio/iommufd.c        | 5 +++--
>   backends/trace-events    | 2 +-
>   4 files changed, 8 insertions(+), 6 deletions(-)
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



