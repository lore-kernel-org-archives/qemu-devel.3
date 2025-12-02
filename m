Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36BCD1266C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 19:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQWQ4-0001Op-Iv; Tue, 02 Dec 2025 14:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vQWQ2-0001Nz-Sy
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:52:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vQWQ1-0005xK-Fn
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764705132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PD1fvQLkJMJDF+58rk3J/RU4+jmRzIeWZAHwg93WMA4=;
 b=CfNwwct90YCZg1Xzf+EXC8OwVvORdcxtW9P0ug1GT5EYDvZToRuyMmSbe1O+w954zd1mM1
 Uqx3wn385vrIV7yGjBDc7bwqFni0JvNgQC6zXP+1wwMIUNuzmSKXjLUdBRVC61b1zyBPus
 Og6T6xrAw/2o3UeX91HoiXVlyLCXGHY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-N3X87TnnNT60XxbyHTYFLw-1; Tue, 02 Dec 2025 14:52:10 -0500
X-MC-Unique: N3X87TnnNT60XxbyHTYFLw-1
X-Mimecast-MFC-AGG-ID: N3X87TnnNT60XxbyHTYFLw_1764705129
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6411c626af4so5659441a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 11:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764705129; x=1765309929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PD1fvQLkJMJDF+58rk3J/RU4+jmRzIeWZAHwg93WMA4=;
 b=WG7AKk2unZiwbUMRahQ3XExG587StiLap/mCsLu2WlTbkhuf6rsr1bsWOfq5mqXyNG
 3ZnQYCaio6kIYWd7NoabdxF+KQddUVHkvQ5dIs2B/DmOw4hBQR8LGCK/VhjvB+XI8PNL
 1J+R5yJGuEQADXOC48pDzeKuQEZJoGzw3lzeOj44w/sQ1Fyw674aeoNANuvK0/l9zXfF
 sV1b8cnyNkIq7uItQ6e7OwZs6n/vlI/vWsBI3CHsYHBwGB97nBYBR8YVm6OItKUop8IP
 Nf6pis2wIlgkdN/ks8dpxJyf9FzfTcRdCPHDogAy08tQ+dHNejcrIhSBdy/6UK53Gqcl
 cmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764705129; x=1765309929;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PD1fvQLkJMJDF+58rk3J/RU4+jmRzIeWZAHwg93WMA4=;
 b=k+6SYPr5E93JZ5paXEAg+o8hYT4T9Nry8VB+wvnIzNgdVrbTPBpbUve60yjFpB46zG
 VPkiAcG9/SHiedVljorkU5DXg9803yz8wMDYJlUQXsueNxcDXDKEvUfrsI0KLEkbGwxj
 zy5RVSr1Jm+fNAMQabb1Ik4uQwSwfHSa5YaQ6QWgwgkAocaxmnxfjrxloUT1tL7ayqT1
 msh+DsL5cP/G6A10PDYNqyA2rXMOySRcGbwJXOqlZULyJy/l6olCRWGU4BT0FTIx87yg
 LoYIfLIA9wt6b/0UXmwEfw8GubHtCe65dDjvkFhWKTg3u8Lqlm+MR93LCKsBXcg7aYn3
 ZjpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTDKXiHCDjGf/ey/dLvQLPdgbl6oO1j+bW07zHs6Y4QM35QsF74NwKRQhmSOBln0YAh14ORY4ctIbU@nongnu.org
X-Gm-Message-State: AOJu0YyeH+UtoXLpNvXdRY2Jz+gKqAUsVL+5yDUCEfOqPsn3GuGan/4y
 6sqaIl+v38qM/ftWDqfsgoGgTzbMpnmqITQwDgAO6LigXnXhOYfmUgBLE16QLB69cIpnhRcfJly
 jUENbu8jJoC3NTHw5Rr8Ulh2CNl3stGxnxXDqHCmPwvKOeRACb0+cUXz4
X-Gm-Gg: ASbGncsgVleKqI9BPBiBt4PfPxay57sFol5ArxxQYzvEdhXpAWagfc0tK24stTUIPYm
 1F3CuYbsA5wouuWVwWPlXWKz4nx/wUwzuQBcq27+MOZ+V/3ue2YYRBa8/O9qSyvl+hMHVqsjJFf
 uprsRz+crUawvTxetAphpReTdTw6PwZCydrkF8YJoVDGp4M9HQ8Jhb+qyycwqwIgrQb4sCyK/+c
 yqWv3CdVUVEqZWowIxPDF7X0kT8IPBCR8vz90qFFnyDMkR9KQJUzjuvvZJYPJ8ySV1U15p/5Xcy
 QFMjPHLvsXRbSEx1gGpB2hk9ETuB73ZFDtJpOVkxugpHMV5+HHUChzf87uIJ43Me0FjMs3D19xP
 kSsLl5A==
X-Received: by 2002:a17:907:7e8f:b0:b72:134a:48c8 with SMTP id
 a640c23a62f3a-b76c53bff9emr3401014966b.14.1764705129414; 
 Tue, 02 Dec 2025 11:52:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyYpagPt4RIr3KJtdh9ucvHdsJ4MBCp7NGUGXu6TnuDfhEC2Z5EZ9Me//L4xmrWBP2kNnd6Q==
X-Received: by 2002:a17:907:7e8f:b0:b72:134a:48c8 with SMTP id
 a640c23a62f3a-b76c53bff9emr3401012766b.14.1764705128990; 
 Tue, 02 Dec 2025 11:52:08 -0800 (PST)
Received: from [192.168.0.5] ([47.64.115.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f51c6c12sm1584952766b.29.2025.12.02.11.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 11:52:08 -0800 (PST)
Message-ID: <8ac1b4c8-5b6d-448f-9fbc-df5254c442cf@redhat.com>
Date: Tue, 2 Dec 2025 20:52:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs/devel: Correct typo
To: AlanoSong@163.com, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, berrange@redhat.com,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20251202131934.17324-1-AlanoSong@163.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251202131934.17324-1-AlanoSong@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 02/12/2025 14.19, AlanoSong@163.com wrote:
> Correct typo in atomics.rst
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>
> ---
>   docs/devel/atomics.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
> index 95c7b77c01..ea4ede4b8c 100644
> --- a/docs/devel/atomics.rst
> +++ b/docs/devel/atomics.rst
> @@ -266,7 +266,7 @@ Splitting a loop can also be useful to reduce the number of barriers:
>       |   n = 0;                                 |     smp_mb_release();            |
>       |   for (i = 0; i < 10; i++) {             |     for (i = 0; i < 10; i++)     |
>       |     qatomic_store_release(&a[i], false); |       qatomic_set(&a[i], false); |
> -    |     smp_mb();                            |     smb_mb();                    |
> +    |     smp_mb();                            |     smp_mb();                    |
>       |     n += qatomic_read(&b[i]);            |     n = 0;                       |
>       |   }                                      |     for (i = 0; i < 10; i++)     |
>       |                                          |       n += qatomic_read(&b[i]);  |
> @@ -283,7 +283,7 @@ as well) ``smp_wmb()``:
>       |                                          |     smp_mb_release();            |
>       |   for (i = 0; i < 10; i++) {             |     for (i = 0; i < 10; i++)     |
>       |     qatomic_store_release(&a[i], false); |       qatomic_set(&a[i], false); |
> -    |     qatomic_store_release(&b[i], false); |     smb_wmb();                   |
> +    |     qatomic_store_release(&b[i], false); |     smp_wmb();                   |
>       |   }                                      |     for (i = 0; i < 10; i++)     |
>       |                                          |       qatomic_set(&b[i], false); |
>       +------------------------------------------+----------------------------------+

Reviewed-by: Thomas Huth <thuth@redhat.com>


