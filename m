Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08204C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 11:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thoaK-0000GH-V6; Tue, 11 Feb 2025 06:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thoaI-0000FN-Lo
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 06:37:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thoaC-0007un-8i
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 06:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739273858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qMgVG10xoUcGVPkx/2Ot1O4GaxNYrATYKSiAMxkqHSU=;
 b=RiF3Iwdl1W8BpTWG8hgPrqHmPp5CGu4TqZLho+iLMB50zec33X/zlNY/V4bPSrASj1iHi2
 You6Uaf6YazLYxHKW0jsI+nwCPQpiIqVUQ5TusRX9MG6z8+PtiJpP4+lCBqukLGiInl+fN
 mBTuLnE736QwkQ8eB4Q3eNUzksAvtX8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-yK_MEAeyOUCp_lWJRxL-RA-1; Tue, 11 Feb 2025 06:37:35 -0500
X-MC-Unique: yK_MEAeyOUCp_lWJRxL-RA-1
X-Mimecast-MFC-AGG-ID: yK_MEAeyOUCp_lWJRxL-RA
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab7ce0ccd78so221328266b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 03:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739273854; x=1739878654;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMgVG10xoUcGVPkx/2Ot1O4GaxNYrATYKSiAMxkqHSU=;
 b=LmVLbjakTDVJLq7h0CzlUU2t8qtFv00pvG6weSLCIqb9vg4HQZkmcOrsb6U+anzl/B
 kO+azkxx7r1SpqJOIRRVFHMhzXzEqNHxttD46zc+e4Mryp1iV2btHcduUGQ3Bg8LhUww
 GTghrmWKVKmmMc/EeKoO0O/S5OBv1iXrllOOKozsEnNO+uDKBoQacVu7dbuDoLjrrZKB
 G/ZNnXa5emp+o5qcDEda8xpeGdwNuY38OR/UdAgpkAVdcyNLr9PJD5F+udy/ltTMAEE2
 hza/qj3gbbw0O+XJXuBtbtVz1V5yUqDG8cG3Za9eFYX3CfAKL9VmsDuTr5Qf2STOM5Uk
 azcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+gHtE/jQro2GhXRkEMccTk+yatythDl6mLcb8Y5cXNscXL0rQpP+Y5qcN0+/66uq0tiC9+0pdv/mF@nongnu.org
X-Gm-Message-State: AOJu0YxefCcaUq9geJtXRaczaAqthrtX+kMrPQtMEyIZM8hBPIM/O00H
 Q0sYOh70oCVWjvRSg9uCpix4alGjeWEIBjvGkNya95bdUWLcfYomS4RsznhtgS6s6lUtqwJzZ7h
 lhfLBQAA0Ugo4W/ut6/hQy+WeBxeRync9N7igPOi3ACxkqwDh6YVz
X-Gm-Gg: ASbGncuY/fyn2j9YZl5WPTsNJoY02SIQpnsPu+ZDKqJ1Bez9rgrC08ebeP84oNMzw4A
 wNsebSL3Ag9dzEtiUj3gSTDrDOeD6S5/XC5yHRBjcjyHNFuCOKRE+JUNOBtGCJghQ/Ghfrsafmf
 595NzKQWtNsHUYp11un5Rz8pe8n5ihQIzzuWmQ8zz5/y0Md+ZMNHykml7dfeQ8bHCMZYN9KYky4
 C9+EWuivZ10eksM2BVKmXAJYvsxzpOTLHiPbs6m8PDc7dCHLTqKNe7PDQ9M1Kfe1LqCmiiADWPd
 pWKhWBSgjJH20N5UAo35NJWdkv2/rhHe5w==
X-Received: by 2002:a17:907:2d87:b0:ab7:d802:ed18 with SMTP id
 a640c23a62f3a-ab7dad45ae1mr292187466b.0.1739273854478; 
 Tue, 11 Feb 2025 03:37:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyzFpz2rQiGiKjKCWqF02cbgy2WabEnGEBGziFt5xMvCKIphfqTHI8oYgyKrWwjj7+rP1Xww==
X-Received: by 2002:a17:907:2d87:b0:ab7:d802:ed18 with SMTP id
 a640c23a62f3a-ab7dad45ae1mr292185066b.0.1739273854108; 
 Tue, 11 Feb 2025 03:37:34 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7d537efd6sm195589466b.1.2025.02.11.03.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 03:37:33 -0800 (PST)
Message-ID: <6b18058c-8c02-4171-abb0-ca7ef7d3fd4a@redhat.com>
Date: Tue, 11 Feb 2025 12:37:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add a ppc sam460ex test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>
References: <20250203092606.491933-1-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250203092606.491933-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 03/02/2025 10.26, Cédric Le Goater wrote:
> The test sequence boots from kernel a sam460ex machine with a
> virtio-net device to check PCI.
> 
> The buildroot is built with config :
> 
>    BR2_powerpc=y
>    BR2_powerpc_440fp=y
> 
> and the kernel with the '44x/canyonlands' deconfig and virtio support.
> 
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   MAINTAINERS                           |  1 +
>   tests/functional/meson.build          |  1 +
>   tests/functional/test_ppc_sam460ex.py | 38 +++++++++++++++++++++++++++
>   3 files changed, 40 insertions(+)
>   create mode 100644 tests/functional/test_ppc_sam460ex.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d30c5bafd87..e4ab6031511b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1555,6 +1555,7 @@ F: pc-bios/canyonlands.dt[sb]
>   F: pc-bios/u-boot-sam460ex-20100605.bin
>   F: roms/u-boot-sam460ex
>   F: docs/system/ppc/amigang.rst
> +F: tests/functional/test_ppc_sam460ex.py
>   
>   pegasos2
>   M: BALATON Zoltan <balaton@eik.bme.hu>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 868f4a64b60b..6a5f1dc405cb 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -193,6 +193,7 @@ tests_ppc_system_thorough = [
>     'ppc_40p',
>     'ppc_amiga',
>     'ppc_bamboo',
> +  'ppc_sam460ex',
>     'ppc_mac',
>     'ppc_mpc8544ds',
>     'ppc_tuxrun',

I'll sort that entry alphabetically into the list, and then pick this patch 
up for my next pull request.

  Thanks!
   Thomas


