Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99623C27C79
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 15:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH308-0000gV-2S; Tue, 11 Jun 2024 11:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sH305-0000cp-44
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:01:29 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sH302-0007HU-GU
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:01:28 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57c72d6d5f3so4035686a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718118085; x=1718722885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P7+8pZ09zzO98OCKSXw8074NhqzsgreYZ87RkbPJO+A=;
 b=Hux8WoeYc4Dsd7AOeZSEWJOBl4mUrspo7+E8I270ZeXnV8gfrCnHsvoom3RX94AbZ8
 ujffy/khAyBx6y/bMmIU74ECiWsDTL/mWK5JhXG1G1HSjKtcfAgOLGcxjHB5BtczZYZ2
 QYo+fI3uR9LSYP9u311oBm6C7j5lipYerdFzNDv8j2Bx4VA4Fh+lgGkXtvym1tgBbksR
 ZdHkChHHHxHwu6L8JvJgRs9TP77SqhRvtzCcW/uHViJERGLEn00LuuPp4JuaQdNg65i6
 w9sT5FX+4TO56HUA135Jpl+DNNDIaPBmv/1AjmyFg75JQHxiV3AtCj76NAUOjP3V52la
 6Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718118085; x=1718722885;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P7+8pZ09zzO98OCKSXw8074NhqzsgreYZ87RkbPJO+A=;
 b=kNWhIDODM5d9ueOeO+ou/EuFRA0llcbyxjFy/N58Kto2klzlpb1WAsWTJXizYudruB
 gBN2JnKt5eb0RGCf9Vo4PNM/q/Ls2da2aon9xB4VTdh6C4J6+JMXs5QkB/97M6q6MSCf
 f64Ap7YMoBRLOc9QzktgMDI5Va47Y3pIBZiib5NVC0k2MudJwXoupZDmmD6uKsSRHNm6
 9NDjhsUnpbhoXMmeS8QnKhaKBE46F5Mc+GyQdZwxqkZtJrKUQz/QTFceZdYBh5F6nfPG
 zyEn0yi7qCgKt/pEg4tta32UhE44ZM/bJT0fe5/wCcvtbcxOa5JLwXeAmfkRblzGMy4U
 3Log==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR/4HW4od10JEM71Ew7ka+ODZnwQIDWBvqJ7PIFSjhdBYJyYUtMnJSuXRtteYtvSgzT4QQ3yrBCr3eLhZlk/PaoNjac1g=
X-Gm-Message-State: AOJu0Yw6pdQws3EiL9sFZF4mJj3t7nne+81PDeXTyKcUcMvpI5/klaOS
 oai2t+vIctW4FBsw6MEgKs5RLQsocZEYAfpNpmgWosJq7JBUdZe6Ym88tfKV0NE=
X-Google-Smtp-Source: AGHT+IHgPadbXCLDtg2uCGMcnZzdWwdJdXZx6Mb2wZmUD8e+Js+RaG7Z1B2ZOv0DH2USbh4M75XgSQ==
X-Received: by 2002:a50:aa93:0:b0:57c:7594:4436 with SMTP id
 4fb4d7f45d1cf-57c75944514mr4749490a12.12.1718118084492; 
 Tue, 11 Jun 2024 08:01:24 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c81a98bfdsm3808975a12.26.2024.06.11.08.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 08:01:23 -0700 (PDT)
Message-ID: <5cc8bab3-4edc-4657-882b-5e8291fba29d@linaro.org>
Date: Tue, 11 Jun 2024 17:01:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] virtio-iommu: add error check before assert
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Zheyu Ma <zheyuma97@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20240611122348.3613272-1-manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240611122348.3613272-1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/6/24 14:23, Manos Pitsidianakis wrote:
> A fuzzer case discovered by Zheyu Ma causes an assert failure.
> 
> Add a check before the assert, and respond with an error before moving
> on to the next queue element.
> 
> To reproduce the failure:
> 
> cat << EOF | \
> qemu-system-x86_64 \
> -display none -machine accel=qtest -m 512M -machine q35 -nodefaults \
> -device virtio-iommu -qtest stdio
> outl 0xcf8 0x80000804
> outw 0xcfc 0x06
> outl 0xcf8 0x80000820
> outl 0xcfc 0xe0004000
> write 0x10000e 0x1 0x01
> write 0xe0004020 0x4 0x00001000
> write 0xe0004028 0x4 0x00101000
> write 0xe000401c 0x1 0x01
> write 0x106000 0x1 0x05
> write 0x100001 0x1 0x60
> write 0x100002 0x1 0x10
> write 0x100009 0x1 0x04
> write 0x10000c 0x1 0x01
> write 0x100018 0x1 0x04
> write 0x10001c 0x1 0x02
> write 0x101003 0x1 0x01
> write 0xe0007001 0x1 0x00
> EOF
> 
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2359
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/virtio/virtio-iommu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 1326c6ec41..9b99def39f 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -818,6 +818,18 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>   out:
>           sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>                             buf ? buf : &tail, output_size);
> +        if (unlikely(sz != output_size)) {

Is this a normal guest behavior? Should we log it as GUEST_ERROR?

> +            tail.status = VIRTIO_IOMMU_S_DEVERR;
> +            /* We checked that tail can fit earlier */
> +            output_size = sizeof(tail);
> +            g_free(buf);
> +            buf = NULL;
> +            sz = iov_from_buf(elem->in_sg,
> +                              elem->in_num,
> +                              0,
> +                              &tail,
> +                              output_size);
> +        }
>           assert(sz == output_size);
>   
>           virtqueue_push(vq, elem, sz);
> 
> base-commit: 80e8f0602168f451a93e71cbb1d59e93d745e62e


