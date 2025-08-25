Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA27FCA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTEI-0007IA-Td; Mon, 25 Aug 2025 05:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqTEF-0007Hm-2m
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqTE9-0005um-LR
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756113055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xDrqLYlMwJ0+sgRgAiLVhjR9rps3WNHUl2q/V3rZJkE=;
 b=EZH/6ck2dB80gtFQGicieYCmwhbjYMVHdO0ofQERQetgxJ+DM/lIqs6ZYzqHcnwtWp+By7
 bvMy3bDi2eA45rvfdeouShAGhWfKbkod6eX9xf0YOpMqrGa3tY4J1OKXqyIzCFRyRwG7bN
 HpKYQjXdETdGdDag0ORb6q+YJ8XOHrI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-XNdXQi2vPQKma8bCnT_2Lg-1; Mon, 25 Aug 2025 05:10:52 -0400
X-MC-Unique: XNdXQi2vPQKma8bCnT_2Lg-1
X-Mimecast-MFC-AGG-ID: XNdXQi2vPQKma8bCnT_2Lg_1756113051
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0c5377so20682985e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756113051; x=1756717851;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xDrqLYlMwJ0+sgRgAiLVhjR9rps3WNHUl2q/V3rZJkE=;
 b=UauqiQXsbW0BPMbxUi6f4L5rIYHpF7Ml0cnR2zxGsH6jpG0gThf73pmRAjhrJ/x/tQ
 hxLgeoiMFQQE/kMkQTctMwRwpWr3R6gyjH1jz6V3sNW7fbZAJN1Ffv1ysospvyWnJglo
 edNogg6g3HMIQW+hO5qr1NdqyiJ8t4FY7YfsZjMVDJq6mQ2gLTVAry6BiIEYjL1QzoiJ
 qDNjNNoSFswRdGyDSh0hCINmMGcQCsEblEPxHTHvFTuegRpiAJ/EbhK4lX0aIHyZOz2c
 m4KDM0N7HgO2u0n6sYGBaDlvQrshj8K3hM2X/mlc0iQvl+kQB6sD8bG7Wy0BVyb207/f
 YWiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg8ZW/26d3iHMcrJpihFFCCuwkf4KCeEuCtAacOJq2WLD2QLB3PewylipS8OjezqvRvsyhYiFjO4AR@nongnu.org
X-Gm-Message-State: AOJu0YwAM8ztnmGsuH7TS5kzIymdOGgHgOZusI0pBdZtyilEyzHODqUM
 EqKiuqFdud+/EcCbdAniDNJkO0eXqIwMVTtTGsLTO9TKL8qtMMYKuIBD7hZf2xknJUBvJydv44c
 27pT9BWFDirzBSMA0Q+7QkObqAUFlf9XA+E+HHxOaYyYoD3go3lB30npc
X-Gm-Gg: ASbGncvPM7g1/YDNPBqnKx2hbr4C/oBztf69rQpuQaqvgOo3UNSBEAzNb+h8lN0XQUb
 +qLqhA56TKHQ3XNxelAkKNOWEbB9TMTs8QlGcH2JdRbjjSu+A8t8VcOqW8gUvjtyWlieQ/NYCZx
 apM0ZELCwq1cob6rsX9W+uvIIlQrjfe24jmJwPy8P8iIapXVFoHi7LrZ6QxBH7OaR0zy/DaOuf1
 k4Em9jB2zmVLpEogcg0wTKJT3SBXl8YuxCmPhMWvEm2c/T1e2anW7k9f/3BaT0yEbNXBvtXLe4R
 0J8RoCDcY3VUhBFb3h94oo9bIMjkUAjpGvohxXFClaTaQc6pxDGmzY2feTHGdXUBkJYOt4BSq6C
 J7j0=
X-Received: by 2002:a05:600c:1e85:b0:456:1560:7c5f with SMTP id
 5b1f17b1804b1-45b5179d004mr78821365e9.14.1756113051190; 
 Mon, 25 Aug 2025 02:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmR0wckXboReT1VU3Us9R61MTH8ExodTKBG3aGMqg9GaeRfXwuxJsTxkhOndheqKpYnHDz9w==
X-Received: by 2002:a05:600c:1e85:b0:456:1560:7c5f with SMTP id
 5b1f17b1804b1-45b5179d004mr78821105e9.14.1756113050803; 
 Mon, 25 Aug 2025 02:10:50 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-084.pools.arcor-ip.net.
 [47.64.112.84]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b5744a587sm103166995e9.9.2025.08.25.02.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 02:10:50 -0700 (PDT)
Message-ID: <5453deaa-9c73-4af8-9fbb-559754967edc@redhat.com>
Date: Mon, 25 Aug 2025 11:10:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/functional: Add test for IBM PPE42 instructions
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, rathc@linux.ibm.com, richard.henderson@linaro.org
References: <20250819212856.219932-1-milesg@linux.ibm.com>
 <20250819212856.219932-5-milesg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250819212856.219932-5-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 19/08/2025 23.28, Glenn Miles wrote:
> Adds a functional test for the IBM PPE42 instructions which
> downloads a test image from a public github repo and then
> loads and executes the image.
> (see https://github.com/milesg-github/ppe42-tests for details)
> 
> Test status is checked by periodically issuing 'info register'
> commands and checking the NIP value.  If the NIP is 0xFFF80200
> then the test successfully executed to completion.  If the
> machine stops before the test completes or if a 90 second
> timeout is reached, then the test is marked as having failed.
> 
> This test does not test any PowerPC instructions as it is
> expected that these instructions are well covered in other
> tests.  Only instructions that are unique to the IBM PPE42
> processor are tested.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   tests/functional/meson.build       |  1 +
>   tests/functional/test_ppc_ppe42.py | 79 ++++++++++++++++++++++++++++++
>   2 files changed, 80 insertions(+)
>   create mode 100644 tests/functional/test_ppc_ppe42.py

Reviewed-by: Thomas Huth <thuth@redhat.com>


