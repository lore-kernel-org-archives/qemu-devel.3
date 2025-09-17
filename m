Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1131DCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqWh-0006NA-4V; Wed, 17 Sep 2025 07:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uyqWX-0006B5-7G
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uyqWU-00007S-Bd
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758109228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fwVgncdj/Sqp7PFyxUTP95A9TG+s+P37rcpvxjB9Jz8=;
 b=OpJmZ8fPJO2rafO8ccwIejLl31O/vJPmVucmAsKMRzmcadOftE1dI8XLBW8WYDbKZToXnK
 1gU4raAfdGcZSjJO3HtPzM9uXClPfMIsYStWtQjGdZdM5WBJyedXsexI0SdP57aF8hCIk+
 A1zpWHcalYiKfMR3gZH/R0vY1kObmsw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-s1v4u9qXP26NFiuT2ahejA-1; Wed, 17 Sep 2025 07:40:27 -0400
X-MC-Unique: s1v4u9qXP26NFiuT2ahejA-1
X-Mimecast-MFC-AGG-ID: s1v4u9qXP26NFiuT2ahejA_1758109226
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45f2b9b99f0so5795285e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 04:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758109226; x=1758714026;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fwVgncdj/Sqp7PFyxUTP95A9TG+s+P37rcpvxjB9Jz8=;
 b=ddq1hALLmHy6IT5NtcGj8ip3UI1n5yKTWAfp4Yyn685sPp6G1xn3ABptxRrE8wyI0T
 shazHiSLeDeyDxLrs1iXLfakKQkDbwMR8zPTQ0qjnAEXKryCyWJFfxGkYIovgGCM0YRS
 AaDf0V4VRpTiCYyprmq2PQs7D93CrFC0zy8ZCR/n/VeMb7v+aLWcm8weWQKAxE+gg25M
 fYGQtRO970uSBH3CsReE5dgYenGdI8l8/ftDrPzYO7i+gAZhPDX/qFWJtYKR7aRKdUF9
 QUfhlAvJVlUgD8FPO1+VfaCvqlVyC4DkenqLsegByZB1vDOInWpu8mXbSvr2To7akiRr
 Qzcw==
X-Gm-Message-State: AOJu0YzrZDsWWwn/L96eKEnoTOdgQgrwGHw7krKLw+OOBu/BeXRlKFoK
 vLDD7ChEckEzGw7x9lyikoecAGs0L2kFVJj/ojKq/Y5JiP4TQ/MSUTY3aUreRLw/t4N2WdjbAXp
 5ihQ3f+Lzygz3eEr7Rt5LZfzRbocoXQR5BgQngjrks7Ew77k34AR2tJmg
X-Gm-Gg: ASbGncsUnhaVynI8B5vjgf9glPhA1bKNaygZOVuQ8JcUrS6xpsFz9HLANQ5QSNe5fBS
 KbJGxB1ZUOFmmb3J57gbzBK1GpiWRilG5Uf3jJCnqaB/BZR02mJa4h4s9R9z+Jkg+gRVsAM/Xg+
 vZcMKYBPZKNhbVqfAmvFWpFqWxLuLz0/bv9yNQmNr8RbA4dUC6D72/mcc7z5QrIfwzPEgRrI+Hc
 +T6F1BEEHzswr4ZzY95xbMUyR5+2WozA/KIuTeBCl3yml6cXqOhwk52rs11ZEHJ/grYIPIyJ7Yv
 Ez+tT9K/f4L5PmSktKmSegKLY2OGYgRGRFXx40vrZEkJhKWJcuy1xm2q5ZOSRiFvSKx2BoqEix/
 q7bqsbuY9uqjKs+799V1VUwCKT1jE0vloAqX9rIl4mfg=
X-Received: by 2002:a05:600c:46c6:b0:45d:dc10:a5ee with SMTP id
 5b1f17b1804b1-461f94aebebmr17108725e9.15.1758109226313; 
 Wed, 17 Sep 2025 04:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJYsUg5Jvx8FAD0w0tCwDk/n0wKWeDwUalFTocQeblTOfBMfMs83QARTlgiMe8F3aim222YQ==
X-Received: by 2002:a05:600c:46c6:b0:45d:dc10:a5ee with SMTP id
 5b1f17b1804b1-461f94aebebmr17108445e9.15.1758109225852; 
 Wed, 17 Sep 2025 04:40:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-46139ab391bsm34470325e9.21.2025.09.17.04.40.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 04:40:25 -0700 (PDT)
Message-ID: <30f278e0-b55d-4a25-9123-7e7735ad8b8c@redhat.com>
Date: Wed, 17 Sep 2025 13:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] rust/qdev: Support bit property in #property macro
To: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-10-zhao1.liu@intel.com>
 <CAAjaMXYkJno=nAcAGPWQJMCjcSkePJwjmZgFkPAkX2N3tQoSCQ@mail.gmail.com>
 <aMpicpXtVu/4lK63@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aMpicpXtVu/4lK63@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/17/25 09:25, Zhao Liu wrote:
> Only 3 types supports bit:
> 
> u32: qdev_prop_bit
> u64: qdev_prop_bit64
> OnOffAuto: qdev_prop_on_off_auto_bit64 (not support yet)

Yes, this one needs to wait for QAPI (unless we move OnOffAuto to core 
code).

> So for other types don't support bit, they need default BIT_INFO item,
> otherwise, we will meet the error:
> 
>   not all trait items implemented, missing: `BIT_INFO`
> 
> And this panic can provide richer info about why a type can't support
> bit property. (I just refer the implementation of `trait VMState`).

Yep, looks good. I added to rust-next a couple patches that you can 
rebase on, to use the attrs crate.

Also please add a testcase.

Paolo


