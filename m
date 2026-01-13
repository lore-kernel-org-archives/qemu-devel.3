Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD80D29DE0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfZ5M-0007e6-RI; Tue, 13 Jan 2026 02:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfZ5K-0007d1-DN
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:45:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfZ5I-0000VH-WB
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768290299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oqrXYMLkug+uuJ/ra74shECWhoYI5fGBGfW6FGoitww=;
 b=WFDa/4//Ii4u+22Y/o5xmkwfjLt8kE3SeabiGNTGfTOltuHrBtwLLNkbxbnj7YhZdJSRus
 8YmHtOYONEOojwvxeDOwX5eYFNVLlMsJr8sqbPyQyhrP3d0+NP0c/0F5mK4LvTylFcxgdm
 vbtLacu8f4/3SJCpdcio+J1YDpWa8jA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-_0Z4ou2NMh2r31vxMJEFcQ-1; Tue, 13 Jan 2026 02:44:57 -0500
X-MC-Unique: _0Z4ou2NMh2r31vxMJEFcQ-1
X-Mimecast-MFC-AGG-ID: _0Z4ou2NMh2r31vxMJEFcQ_1768290296
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a49cso66759675e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768290296; x=1768895096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=oqrXYMLkug+uuJ/ra74shECWhoYI5fGBGfW6FGoitww=;
 b=Q898/YNoD85SEJOm6D8cRdz5Vh/+3H9H6qFxkVZGHZxIZI4SdcDGu9oGgGgmPFNjvT
 NaHEQAaqzsm7w3sN9pM3AUM/od96TtDL1UUWklXY3f5LwYLr+8K350rH88tyrjzovAJr
 4obK2qJLdXyRxIwCvtfeLJ5U2/kY1BTy4IhfOOlYbm6Kxhh+pE2MWieOEWWUdNBLy41b
 diMoVNeTzaekiD572ZH6iflN0Por2u6oJ9udic2X2ZGcSDcKCGCCZCa3940lD7m0I1SQ
 Ffcc33B7YCVHseI5J3mcYIqG+Uvjav5lh0FusrZhSS3j1hfkdDjwyU5ohkHbrNbqlXVi
 DAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768290296; x=1768895096;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqrXYMLkug+uuJ/ra74shECWhoYI5fGBGfW6FGoitww=;
 b=HafBhfftlDaSUoUKJSkZgBKxrOmi2OO0vPpReCXTx0vm26VwjK+q8yOdPqsJruDXyv
 Qr94nxlKZ8GVfw2Pc9yUAJXfKHf/Dp/LvuxTciu1S+ShiPGQUnLak35eRMIMCHV99NRA
 0NwJMXPQXnv6mH5hOoNkBsZEi/TxXincF801AxTpLDf4g3J8cNOHwF+8Bkv88LDdmwk0
 7xoAUeGWey7n+m0fMl3SZj+JBQu4QxHb1PR5vECyLkiphjw3rSSpcSGLOTwMnPfRVLW4
 24tP4qD4XC7KXaz+c03Q5bDqPaPLAL4l3LSYFgieYAnYtiB+UQXA3WRbtncQTb51G0J4
 PKFg==
X-Gm-Message-State: AOJu0YyE882mN9bfu/N3uVxM+3TsXam+ZmsranBzacQySJI+LBiJMSR1
 HpEfZK3vNc4IuZEx7aOvFcFrm3/nbnP0CPS+9SAsyzPFsVAzWmAR/iOMvwUzwQPrmiHDzrvvap6
 ecDLQN86I5yWmTD2WQzqKdGDWyiauCq1h/79EyHXUBrz/Q8MkhiYR8alENBZ/m/7qpKfX5Xasak
 u5I+p2/QXJ4rinu+wPMq8iISyn1zPQY6zs0w==
X-Gm-Gg: AY/fxX7vw2N9/pU+fmIE9BGRMiEUE3PaHvmYOI3u3htQc0Q1MKVJXiRsnCKkxL2aSUh
 Wt8P7DRIXTz6UAP+VMgRBxQ/ZZOVj8xnFyh1F/+S1NajvWD94kEFrECg8/KwMuDFn64ARd/utwn
 3mnCyDBGxT1y1c6B/5tYiFNghtFKfhbIqEozwbPJ2VzfxfkQ79o6lOv9Qdmo0uL+b7TLtEwrRaz
 1Ysf7sMiKKGwSfOXQ/GK3+2K966R0oR7EXTsQ41jjegnHPUHUX2fN7bdb1+NfzudmR4t/trrU9u
 spnTdKmz8ZbNw18BD6AD56dCq/86MyZLrlayXrmnmB/cJEVbPpthyyI7wi6wIYOCSvOhUEd0jPm
 B8hdiuPLhPbtQDEGsNdtx2GJ1UKyQieP2JJr/6Ql1FGR/dvlJ
X-Received: by 2002:a05:600c:1e24:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-47d84b18ccfmr233935315e9.11.1768290295798; 
 Mon, 12 Jan 2026 23:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa9RZnSeXNlZXWVVKmr7s83N4uP8QEvcEzSshxYXhTV53fmeaRDLJ+j8sIwjTUnpucpoHYGA==
X-Received: by 2002:a05:600c:1e24:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-47d84b18ccfmr233935105e9.11.1768290295389; 
 Mon, 12 Jan 2026 23:44:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432d9610671sm25246376f8f.34.2026.01.12.23.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:44:54 -0800 (PST)
Message-ID: <63b038d3-218b-4ef0-aa68-02ca1c743ef5@redhat.com>
Date: Tue, 13 Jan 2026 08:44:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] update-linux-headers: Remove "asm-s390/unistd_32.h"
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Shameer Kolothum <skolothumtho@nvidia.com>, Thomas Huth <thuth@redhat.com>
References: <20260112155341.1209988-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260112155341.1209988-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/12/26 16:53, Cédric Le Goater wrote:
> The "asm/unistd_32.h" file was generated for the 31-bit compatibility
> mode on the s390 architecture and support was removed in v6.19-rc1,
> commit 4ac286c4a8d9 ("s390/syscalls: Switch to generic system call
> table generation")
> 
> unistd_32.h is no longer generated when running make header_install.
> Remove it.
> 
> Reported-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   scripts/update-linux-headers.sh | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 844d9cb9f5e430dcb4833e6225b57173f4befb8c..d09d8cf4c6f0f6a109e899f5c8671f64373d9c6a 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -154,7 +154,6 @@ EOF
>       mkdir -p "$output/include/standard-headers/asm-$arch"
>       if [ $arch = s390 ]; then
>           cp_portable "$hdrdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
> -        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-s390/"
>           cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
>       fi
>       if [ $arch = arm64 ]; then

Applied to vfio-next.

Thanks,

C.


