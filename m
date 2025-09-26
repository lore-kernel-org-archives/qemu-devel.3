Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CF3CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 09:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24Sk-0003zu-Oa; Fri, 26 Sep 2025 05:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v24Sh-0003xu-5O
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v24Sa-00041O-3I
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758877784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MyV6a01tjLqjPaVKNvz8GKBfSkxgNR40rAt0doVLyi4=;
 b=UtLzHay6gHotFyAbZl6X2bDB3oOhr9f3YKHGIgUuireexlYYzSDpraoFHgFSZbu9cgLfjK
 rN5VOPJCYLib4xgpcBkmYsrbevrwN6LF42SPzKqvVeLYVLkjK42HlKofjVf9OedU34lbiv
 +eL+fbkgX23I1O57v7QCrUb5wJHAcsc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-xy_UNy6kMQKwCdFIAcN1XQ-1; Fri, 26 Sep 2025 05:09:42 -0400
X-MC-Unique: xy_UNy6kMQKwCdFIAcN1XQ-1
X-Mimecast-MFC-AGG-ID: xy_UNy6kMQKwCdFIAcN1XQ_1758877781
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee10a24246so1078483f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 02:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758877781; x=1759482581;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MyV6a01tjLqjPaVKNvz8GKBfSkxgNR40rAt0doVLyi4=;
 b=sDx0kKU/HZQreW3uz6l+yi5QPeXc2XBgEEFzfaWmv2TLR95AjZYCmNWI0JW626QlMv
 LKHA5XTVCAltBpuGWjDPSkKeeRfuJJ8+2IQBp2BDrNr8MZaMKI8HfkKrPct3r+MlDMXR
 +yRB6nHMfUnrGdNwV7S7hhq0OG7/RdTjILklDfJrw+g177uB5o7jllAztMW9N1nsmMbt
 kK8aPE/R0i1LK0PhCLZbsHqw0ML9PjLyzE+k8m+O1/9H+RDYSMvspQAyW/JMRWAthpBv
 cJWx7aZzL0QR/rxf6bhhkuk7lnZnqZAvam8KdHe/fdaLjY+GxtXx1Gh+WZR/jMeuKwzP
 kVTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZLwDcflcMUTiezqyf9cyhBOemQISajrVxJX/kNjEXdyIEuGYpuC4AjCN3vtIYx1RGKrmJSbx3VDCr@nongnu.org
X-Gm-Message-State: AOJu0YwgJ5vjSnexTh7/fJsbOyRVpKb1/qvzLa9W01r6GcQDnRpi1CdZ
 W4E5MjX+iX6JVYcXwzHJqPJnr/FRJllktBmR2rT3iceU8qW3LEYbKcbcD0tRzfBBzWsh4CeEEhW
 +UMjoVEU9XAnNJRHbx45efUofjvs0qvP5JmsfTgkeZeqsUHo1Re0iUgoj
X-Gm-Gg: ASbGnctAWkAmnVlAgPdQzYJNjQoT9fPpbiStFttoqwJ+G86UFPnI5ZjnY0GNfRfqzRY
 WlPJHaijc+g2yIHEgvdrsB2mZ8jop9CVb7Mwik59CNwt2iHstt0/sZx8WybM+pl9ZccEUiJXX/m
 IDu5fCDGtUri3/IVlnQ/BD0pQ3lko9y2OeDbJusJF+FAF7TKk7vqEWmqlZiXgn+iDnB5WI/uZaA
 q+dz8u8OXv8NNJGYX0RzYRYuHZfq17bnqc89kGrZ36f8kYCsOjlUE4qsMat8jR3ceTWxauPidNa
 rX3OIfVza28jk586kcbPoZ0QEyS9ZfQrOhxT5i7bAlQQaNUEO5RoyctGl7dHGPwInLuU4Qe+uKI
 L3E3Crg==
X-Received: by 2002:a05:6000:220c:b0:3fa:5925:4b11 with SMTP id
 ffacd0b85a97d-40e4cb6ebe0mr5797316f8f.42.1758877781417; 
 Fri, 26 Sep 2025 02:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMZqFCJ+58ANilTo9vRHieNVOUJeZQRv3Ue3c3T/4IXpBSBWiz8ZpOed2nDiatYDuZFMeboQ==
X-Received: by 2002:a05:6000:220c:b0:3fa:5925:4b11 with SMTP id
 ffacd0b85a97d-40e4cb6ebe0mr5797290f8f.42.1758877781034; 
 Fri, 26 Sep 2025 02:09:41 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921bcfsm6522214f8f.43.2025.09.26.02.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 02:09:40 -0700 (PDT)
Message-ID: <5b49a9c1-2eb1-4061-8e77-6b4b39f588e1@redhat.com>
Date: Fri, 26 Sep 2025 11:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] tests/functional: Adapt arches to
 reverse_debugging w/o Avocado
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-10-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250926051542.104432-10-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/09/2025 07.15, Gustavo Romero wrote:
> reverse_debugging no longer depends on Avocado, so remove the import
> checks for Avocado, the per-arch endianness tweaks, and the per-arch
> register settings. All of these are now handled in the ReverseDebugging
> class, automatically.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/functional/aarch64/test_reverse_debug.py |  9 ++++-----
>   tests/functional/ppc64/test_reverse_debug.py   | 11 ++++-------
>   tests/functional/x86_64/test_reverse_debug.py  | 13 ++++---------
>   3 files changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
> index 8bc91ccfde..36985a4a1d 100755
> --- a/tests/functional/aarch64/test_reverse_debug.py
> +++ b/tests/functional/aarch64/test_reverse_debug.py
> @@ -2,25 +2,24 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   #
> -# Reverse debugging test
> +# Reverse debugging test for aarch64
>   #
>   # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>   #
>   # Author:
>   #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>   #
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> -from qemu_test import Asset, skipIfMissingImports, skipFlakyTest
> +from qemu_test import Asset, skipFlakyTest
>   from reverse_debugging import ReverseDebugging
>   
>   
> -@skipIfMissingImports('avocado.utils')
>   class ReverseDebugging_AArch64(ReverseDebugging):

Maybe use @skipIfMissingImports('pygdbmi') now?

Apart from that:
Reviewed-by: Thomas Huth <thuth@redhat.com>


