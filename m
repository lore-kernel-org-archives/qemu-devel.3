Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60566CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuiS-00049p-JP; Tue, 12 May 2026 17:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMuhV-0003av-7i
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMuhN-0001du-5K
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778621463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PRAJd7MYVSff0hyc5Zk4OErvDwLqfaPYXXkvm56BQoc=;
 b=XBcmpzl7sV2NZvEOA+7y2OwYqtZuNftY73KcJTK7AtADo61Cx2o0pXxstVjg2ojiksAApx
 sR0zdt2QHKvcDsX2SZfA4Xxg55ytSlPmqwQYCu3xgZcCpHBPjUKlUqJqqTYNylcwkIoKjo
 WaH5MM7eanWvf+fZFh8JBLje9wlbr9A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-LftiE7uUOHish8DKj3lGlg-1; Tue, 12 May 2026 17:31:01 -0400
X-MC-Unique: LftiE7uUOHish8DKj3lGlg-1
X-Mimecast-MFC-AGG-ID: LftiE7uUOHish8DKj3lGlg_1778621460
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43ff19e54beso4189100f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778621460; x=1779226260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PRAJd7MYVSff0hyc5Zk4OErvDwLqfaPYXXkvm56BQoc=;
 b=uHC1VzoI+2Rl1enkNVeTeJAePJ1OCaCOG7P5t6FGemQDJ9KpEo8bfM3/4N4lrt5h+2
 xvjQSZkn57gwOAVXdJ7q9tbaxmypyzSUZctOuyy38Z2piTff8LzuRE3wdiBiDa6KTJqH
 aTNxH0bo2DxbweDPqMtrQOsawMYoswK+mevQdFUo7ZCK0pDKdnJWUh6AZ3G8cttsG1DW
 tQc381qZ9Fo2e/CKI9ZmimSgJ4eUcAWYalYeTMgBKBo9vdTzzhOayu/N6WmrYKW5ZTiS
 CCYQeBzyLZwrfnGLN6/vKgmI6BNrEMWWeVNQ+tNpjcrVMU2cRdLH/qF+WTmQR9uXXBWh
 /Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778621460; x=1779226260;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRAJd7MYVSff0hyc5Zk4OErvDwLqfaPYXXkvm56BQoc=;
 b=Szu5e8FRLijWTJoGrrUF8cKO3Twa3TguPZKmOVsvxuhHV0ojwzE8dwef/RgqS3efcN
 QxWsZZdX2g7TwexqQyuj+weeuXK9fh56w+TGQsDNMqRM05rDJuNRJPKLh5V2wGBF/TW2
 GIFpa8rvRB5Wl0q5w2cDfke2xf3v6Chk2fMYStN5TT/1lZV11tMmFTuIx4zsZ6yi68Uy
 zY0ekYERqbCQ7hY7wKh5dbzeWefA+lBxDqkdqRxHI5DS1yDMrirC19rMWFBL8BWV9DDP
 V4ypiXiDp8kmXmDTZToYpcd1ZNrHZgt1Wc+ydH3lYema27BubP+zQWZ943QWrb6VVbfm
 tM6g==
X-Gm-Message-State: AOJu0YwD6HnYZ9zL4adU6oDBzlyWN+GKoVLIULpAiph2tA+1Z9fMb59F
 6pyrdm0gsnq8xl5MRuEBjby70XsXboYLVwMrYXjm0p+iJQ9f1BR4I/Qb95d5ZZNXP+10ZGXchKY
 MP+/pXgStQOpggXS+pXxaGlN3wRaEom/sw1HqQYux8DdGkeyz2kcSZ/J4
X-Gm-Gg: Acq92OHSx4UH6LDmBXT2o1/kix0g3kKzaz1n0BCTpJuTSlfDIkM49TaxEDchoccOMKq
 wZHy0yWKFx2k4ddb7SjGOAHG2vC8IqZGuKcl43ZddfcMP8uzK0tx3+HbvYErS96LGA18TLLnflx
 E/KagaCEwEy3Jx6gV/yxA7lqTlEUFtdlITv1zU2Llp46YamwFlCF/ctsRjc3VCmi/hlL/cItRho
 a9Vn9WCvmzbWp13WexkfVJZT4H6FPUyf3P0GdJt+zcz2pPos+NCY/AUGUjp9tqPMbCLXtxo3ZCF
 HMzi8HTUdEwCEEQRtyCCYcKHNP6MjrBEaO2pIk5Nu3d7kQnfXtzhr3PrT1R6vt/Q6WHOzGwaRQP
 pCjmG0P/VfxFhhSF3OOnhd5nUXr/WXsjQAQ8bDBQ1CKXjdHD+Q4aUGxp+WS03
X-Received: by 2002:a05:6000:22c3:b0:44e:902f:e341 with SMTP id
 ffacd0b85a97d-45c59cd2940mr565580f8f.20.1778621460456; 
 Tue, 12 May 2026 14:31:00 -0700 (PDT)
X-Received: by 2002:a05:6000:22c3:b0:44e:902f:e341 with SMTP id
 ffacd0b85a97d-45c59cd2940mr565534f8f.20.1778621459979; 
 Tue, 12 May 2026 14:30:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ba2aaec3asm5600081f8f.15.2026.05.12.14.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 14:30:58 -0700 (PDT)
Message-ID: <eb2f2af0-a510-4f0e-be00-9ed6bf7b4dca@redhat.com>
Date: Tue, 12 May 2026 23:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] linux-headers: Update to Linux v7.1-rc1
To: Song Gao <gaosong@loongson.cn>, maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, chenhuacai@loongson.cn,
 Avihai Horon <avihaih@nvidia.com>
References: <20260507092358.2479135-1-gaosong@loongson.cn>
 <20260507092358.2479135-3-gaosong@loongson.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260507092358.2479135-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

Hello,


On 5/7/26 11:23, Song Gao wrote:
> From: Avihai Horon<avihaih@nvidia.com>
> 
> Update Linux headers to get VFIO_PRECOPY_INFO_REINIT feature of VFIO
> migration uAPI.
> 
> The update was done by running `update-linux-headers.sh` on commit
> 254f49634ee1 ("Linux 7.1-rc1") in the Linux tree.
> 
> Signed-off-by: Avihai Horon<avihaih@nvidia.com>
> Reviewed-by: Cédric Le Goater<clg@redhat.com>
> ---
>   include/standard-headers/drm/drm_fourcc.h     |  28 +-
>   include/standard-headers/linux/const.h        |  18 +
>   include/standard-headers/linux/ethtool.h      |  28 +-
>   .../linux/input-event-codes.h                 |  13 +
>   include/standard-headers/linux/pci_regs.h     |  71 ++-
>   include/standard-headers/linux/typelimits.h   |   8 +
>   include/standard-headers/linux/virtio_ring.h  |   3 +-
>   include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
>   include/standard-headers/linux/vmclock-abi.h  |  20 +
>   linux-headers/asm-arm64/kvm.h                 |   1 +
>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>   linux-headers/asm-generic/unistd.h            |   5 +-
>   linux-headers/asm-loongarch/kvm.h             |   5 +
>   linux-headers/asm-loongarch/kvm_para.h        |   1 +
>   linux-headers/asm-loongarch/unistd_64.h       |   2 +
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/kvm.h                 |  11 +-
>   linux-headers/asm-riscv/ptrace.h              |  37 ++
>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>   linux-headers/asm-s390/unistd_32.h            | 446 ------------------
>   linux-headers/asm-s390/unistd_64.h            |   1 +
>   linux-headers/asm-x86/kvm.h                   |  21 +-
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/const.h                   |  18 +
>   linux-headers/linux/iommufd.h                 |  48 ++
>   linux-headers/linux/kvm.h                     |  46 +-
>   linux-headers/linux/mshv.h                    |   4 +-
>   linux-headers/linux/psp-sev.h                 |   2 +-
>   linux-headers/linux/stddef.h                  |   4 +
>   linux-headers/linux/vduse.h                   |  85 +++-
>   linux-headers/linux/vfio.h                    |  30 +-
>   38 files changed, 711 insertions(+), 493 deletions(-)
>   create mode 100644 include/standard-headers/linux/typelimits.h
>   create mode 100644 include/standard-headers/linux/virtio_rtc.h
>   delete mode 100644 linux-headers/asm-s390/unistd_32.h

The linux headers update needs to be regenerated with this fix :

   https://lore.kernel.org/qemu-devel/20260511111913.3327672-1-clg@redhat.com/

Thanks,

C.


