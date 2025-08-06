Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80370C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 05:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujWS1-0004QH-Iy; Wed, 06 Aug 2025 01:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujWRj-0004NQ-OV
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 01:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujWRf-0003YK-Hu
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 01:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754457128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hw1gvAV8JGRdfz3JPXEn56vj6bPOcM31mb2e305Nakw=;
 b=RIHByWRKYnF8/op4eZF7d/w90GEZZaqrfmTIlyWgHOq4O8oEm9QIaYyL1qfsh1WwExwvF1
 wmNpXWSgNw4G1gWLhlveuxg7SCjcDpUrlxwsg0/1xx5kYzaF08/CakKdCTXs7Fe8KOhAw+
 pC5wdTFlVOWHHWDQMvBiPaFQSxPx9dA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-tF3kp6y_O-SeHWBA1mhaQw-1; Wed, 06 Aug 2025 01:12:07 -0400
X-MC-Unique: tF3kp6y_O-SeHWBA1mhaQw-1
X-Mimecast-MFC-AGG-ID: tF3kp6y_O-SeHWBA1mhaQw_1754457126
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-458de4731b1so14078965e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 22:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754457126; x=1755061926;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hw1gvAV8JGRdfz3JPXEn56vj6bPOcM31mb2e305Nakw=;
 b=cgDRCDBCZZwvq6KS94H1vCgcrbGB1uu3nCmlRy34e3UJxam1Qb+CT0C2TgEaBr9401
 bV5MC2Jgxw9N6+Q8ZYeEtdsDXTpFbIBqYkQC5t/SfYE8faNlN5syf4kbnRo5RfTmp0DV
 tU7K9/XggoMMcUjsZ7FgIGzFlVqZdSEJZiMITx1TdLBM1IM1t0IoDtOa7jznP3A/yPjF
 eho9gMFAhcI+tKEnB2QQ33uv4QufmULDk8qaUEd4cpV9j/vvHlAJPzBH5bUCnYNNiRKn
 1opM2xmT802eVym8zJhUQtIBhkwmT0rrUtoW+t+41SO4bQfqHreVLkCrpUHD0Ru+pZUf
 cWtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4QDKLcdj3IPnLPaC/KHFnoKKDa0w3vVuGP7Z2oEsgBgUb/w9d26vmJ9q5UNAAQ5cyd7guB89Fn5GX@nongnu.org
X-Gm-Message-State: AOJu0Yze1K6k9ZFbWOQIRY9URUvgIc2gFqLxuElytgSWTykFcKqrAxwh
 j2XEgYhV1s9XPX/6wDSjGMEcW+4Kj0G6Z/0zGS9fb4MNyMSp+YWf2CXniBdW0G668JmpFhHmLYc
 UazZLTVML3ZFiVQdGUgk2UzpCIIRPcPmwob/QWKvJw/+X9M0SmqANFDuO
X-Gm-Gg: ASbGnct6PWfTFnd1m8/0a32LY+9xNmCEwmGKDoUVGRAM85LKSDMEgaNeZgGjtjg8crK
 9xoNuikAkpz0XBC+Bhzf+z8nMKGMw9FouUxaKahWY1rOY3f9aMZXjT7N/RJzrw0Qv5Y4ppv6Eza
 cetQ1Gprf1hGX3UnOT52QkHGmSrpXnm+kDSrZYQCPrN694VK/GgZLhdlO42r3qBTFt5aEtRUdNw
 U9ph0joJh6QDDAcbDXjA05TdOWAC7H290EeGA+RfbZ+a4SGg2QS4I/KHUyf89gsJIShPyXZw/WM
 U3syUXvBljR0aUutbO41u8pVNDmdggBBd6w=
X-Received: by 2002:a05:600c:6385:b0:456:dc0:7d4e with SMTP id
 5b1f17b1804b1-459e7490e36mr9601035e9.18.1754457125762; 
 Tue, 05 Aug 2025 22:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc4FONlC9AMPuam2nP7WWrVW16vhd08YrFcN6MFsFmhaHtpZgbYGBc659gdABsLzDVkpvWYQ==
X-Received: by 2002:a05:600c:6385:b0:456:dc0:7d4e with SMTP id
 5b1f17b1804b1-459e7490e36mr9600825e9.18.1754457125328; 
 Tue, 05 Aug 2025 22:12:05 -0700 (PDT)
Received: from [10.94.0.25] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45895377708sm271741615e9.8.2025.08.05.22.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 22:12:04 -0700 (PDT)
Message-ID: <2e21ae04-e535-4bef-83f8-72c5bdba507c@redhat.com>
Date: Wed, 6 Aug 2025 07:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for PowerNV and XIVE
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: npiggin@gmail.com
References: <20250805213646.3285026-1-milesg@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250805213646.3285026-1-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/5/25 23:36, Glenn Miles wrote:
> Adding myself as reviewer for PowerNV and XIVE areas.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07086ed76..f1ab7b893d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1576,6 +1576,7 @@ F: tests/functional/test_ppc64_tuxrun.py
>   PowerNV (Non-Virtualized)
>   M: Nicholas Piggin <npiggin@gmail.com>
>   R: Aditya Gupta <adityag@linux.ibm.com>
> +R: Glenn Miles <milesg@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: docs/system/ppc/powernv.rst
> @@ -2779,6 +2780,7 @@ T: git https://github.com/philmd/qemu.git fw_cfg-next
>   
>   XIVE
>   R: Gautam Menghani <gautam@linux.ibm.com>
> +R: Glenn Miles <milesg@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: hw/*/*xive*


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



