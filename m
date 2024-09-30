Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FFFCF649E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCda-00088H-RB; Mon, 30 Sep 2024 05:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1svCdY-00081B-9G
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1svCdW-00066q-PR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727688248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jc0druRkRoUrarXSRWyMdRP2eH8jvDqoj4jRAP9G5SY=;
 b=Jt9pqMpXO/jv3YuqKjmh+PM/BzxWUEXVDFHgyYmTov/oS6sKI1h7Ym8Tj76GpX9OPRHqB0
 gkwrz2Z/Gj59HZDK5JgaRkw05Enk8nD6h1SSdEL/nA8J4f7v76fdXA49mDuj2SJW+oZJP8
 3ps6HWeANP0iXK2yWzsCCrxQmyq/MPU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-OXeLv-kCNH2HmP9ZrdGX6g-1; Mon, 30 Sep 2024 05:24:06 -0400
X-MC-Unique: OXeLv-kCNH2HmP9ZrdGX6g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37ccbace251so2130581f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727688245; x=1728293045;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jc0druRkRoUrarXSRWyMdRP2eH8jvDqoj4jRAP9G5SY=;
 b=lrvthukZp8Za35U5PdXKCZTpVdMC9OAn/+XyCzQkZe/2HmSxuuhVGUgev33Zh+3lzw
 g9hzJRJcoQMCSTEVQbOmGVUrM9Wf790I5pN9hY7gLrb2H3Xgb+oQrIYSe7AXw8qf7WJC
 aMpA6NZIF33SiLMxBEBZI38K0UGOY1huNDqIX25fnzkqkwTnIjzEHfNR85jCjcGODVGU
 XlrgOrAwK4avkVo1ust1FhW190tAXJE4ob9s5FpdqyoGuEd3iIRM5P5+3AXg6q8vZWvR
 nOybk9ezFohElsjCIiVXlNa31YdbaHJiup+TbvkkqCBqTM/Scw9V5ujxcHSJqV1KSHQs
 pJQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVehN6pX7B6XaIqQWSPbnT8zTCVM26p5t+pq/HCpgBEKpltdEjw3deWZbuwMufZtfBwKxHoYHxxbR2s@nongnu.org
X-Gm-Message-State: AOJu0YyafqyC+20QwNv6SaZ5VCTlTaOfuf6zfyrSc0r+twd3QTDvFhF6
 Y30JVgiI4lFHFWxwEzT6ACOnrh5FqqM5qNTmR8eGN4PwwGFaGU73FHvwg11LkYIqL96Qox6xjC6
 54SAErvWo6+T77JTKtCfoOl+Vco2PU2v1IIetqDzHLSILixjfpF2P
X-Received: by 2002:adf:eed2:0:b0:37c:cd38:e7bd with SMTP id
 ffacd0b85a97d-37cd5a998e4mr7050006f8f.29.1727688245663; 
 Mon, 30 Sep 2024 02:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH01rHQEMF6JLxxA7KjU6/AX9gdyHOuwZLVYNaf9E02HqAMG3V8WFz8OdhhVObx4gu6Fqfb1Q==
X-Received: by 2002:adf:eed2:0:b0:37c:cd38:e7bd with SMTP id
 ffacd0b85a97d-37cd5a998e4mr7049979f8f.29.1727688245294; 
 Mon, 30 Sep 2024 02:24:05 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.43.71])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42f57e2fb5bsm96246265e9.39.2024.09.30.02.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 02:24:04 -0700 (PDT)
Message-ID: <e9462238-17fb-4269-bc4a-955d6b8cf4a3@redhat.com>
Date: Mon, 30 Sep 2024 11:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/9] rust: add crate to expose bindings and interfaces
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org
References: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
 <20240910-rust-pl011-v10-7-85a89ee33c40@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240910-rust-pl011-v10-7-85a89ee33c40@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/10/24 14:35, Manos Pitsidianakis wrote:
> +unsafe impl GlobalAlloc for QemuAllocator {
> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +        if matches!(Self::DEFAULT_ALIGNMENT_BYTES, Some(default) if default.checked_rem(layout.align()) == Some(0))
> +        {
> +            g_malloc0(layout.size().try_into().unwrap()).cast::<u8>()
> +        } else {
> +            #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
> +            {
> +                g_aligned_alloc0(
> +                    layout.size().try_into().unwrap(),
> +                    1,
> +                    (8 * layout.align()).try_into().unwrap(),
> +                )
> +                .cast::<u8>()
> +            }
> +            #[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
> +            {
> +                qemu_memalign(8 * layout.align(), layout.size()).cast::<u8>()
> +            }

The "8 *" is not needed in either case.

To be honest I'd simply drop the allocator code since you have to respin 
(see Junjie's answer).  The DEFAULT_ALIGNMENT_BYTES trick is nice but 
I'm afraid it can be a source of hard-to-debug bugs.

Anyhow, I'll leave the choice to you as long as it's disabled by 
default, and I think with v11 everything should be ready.

Paolo


