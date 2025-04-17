Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A5AC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5M0d-0001YN-Dy; Thu, 17 Apr 2025 05:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5M0c-0001Wv-MX
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:58:14 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5M0Z-000299-TP
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:58:14 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so380021f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 02:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744883890; x=1745488690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WhbUksNA5WCsHu7DVyS15rbACub4hYHmoXK4gfbw1I8=;
 b=ERCbrLMCHCH8yKR1/DKXUZ9Fu6SDA+Idj1cOkpuuEvon9lfZcNicyvJf4YxgSCzeKY
 s9sKepm+FNDl9tBUNikawQ9X9naMMBFJ0vDkxUibGPN1jwZfPUULy6uaaS8DUuJ3X57n
 2v7yuxNLlJC2CnDbmIU17WwDPoKRy39fOJEZANPVcBUsD9I7CKBYom2ANVErLFAwYafN
 AA0cHCxE96gQAkkoiSmrp35qcEQGUYcBFbP+UNSixRVZ4N+aHMz1Do1bJvD4m7MmZX3V
 nRkzG6RtUVGJKk9O/qSCT1qgC6ZEGI6/QMdnjlt8ZoEG+6tRNgEb3uqhWsGdmxMzVxQs
 gWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744883890; x=1745488690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WhbUksNA5WCsHu7DVyS15rbACub4hYHmoXK4gfbw1I8=;
 b=U+eQ/elxvXKu2LTua2eGPrZMyyvqwdfyzdx03QsnSZxxVkkdQSSiT5oflBUxb1KYu9
 DZwb/my6c9u3NGwvitpYwZ4e1OWfklZ5cbdWzGaojt8Y3hHJSqRZ9YMI5How/Vd1+v+E
 02iltaOgHteXD2zbC770UKwyxpYfA6BR2+fkxQMl45yldzX/1YnSCHLKtGbPlQ852IGx
 Wvanv42uELR3T7u1nfZqCdvuawU44UfMn9uRelJIVjXkxid8aWVpiThXnOL/qzLzUVAr
 4xRluCs0rAG2AHg0sCmuIRXahrPAZysMIPukrG5UuZhGLEg//TvW920APoGFO28luNDQ
 2/Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh37BMjbtrVRIn+GdzPGizTGCeivKkK4nmtA8ag25J31rW2+eUMSdJIx84XWdNg1ZNctMtpAJins3H@nongnu.org
X-Gm-Message-State: AOJu0YxQG6qo9+ZujNO2ONqWtrKKbnWk/TXNGjUsA57FRx196HKpYj6l
 x0UCUS5sZDkKAHwPMirsNs0Uf0OoPrmOgCQ89KGAWbQPKbd5ZvaqW4uHqOhH55U=
X-Gm-Gg: ASbGnct2unmuO+SHBug7l0iPJTf1Rb86S5yxsGWtG6TYF3UhK0wlEFQ/DCwa854455d
 2gw0dP/3JjxWLA0fZsakK+Sg5JZTU/Oa2iGhKlHgwalAbO9O/aegF/xoemVT+kB3W8PLr+MecSA
 iKY2dt2U8rqwKSYFf0gYbvIKUHJf2u82Jlx/V1eWmR3k7raDm6qiMyo+ID6ah/kLUdMpWp+wf9b
 RZ75vp5tJs6BOQ5BoGtS7X5c3eanFgQM60N6NQGKbw23CTwwufIojZyTMYg8xFn3To8SUgCQoJ2
 zj+6WY3Piq/JfaDp1sMaTlNXMNfBViPknr1egc67nC9nlljDlhlOjF9bPVlZsZJfVLdlFi7AHMz
 9j6NyD1rKrzOYJcL7Izg=
X-Google-Smtp-Source: AGHT+IEqeET6AdG1UMkwctbSE4l83P0Z+vGmkZxifhSHVLyYOM9QHGkJShfCLgn7NkJNkBmlC0mTqA==
X-Received: by 2002:a05:6000:420b:b0:38f:2678:d790 with SMTP id
 ffacd0b85a97d-39ee5b37c35mr4702997f8f.33.1744883890140; 
 Thu, 17 Apr 2025 02:58:10 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4d3463sm47258745e9.13.2025.04.17.02.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 02:58:09 -0700 (PDT)
Message-ID: <1e658b6e-02ed-47d1-9c19-d5753cc6e6c8@linaro.org>
Date: Thu, 17 Apr 2025 11:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/19] include/qemu/osdep.h: Add Emscripten-specific OS
 dependencies
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <58863961cf88a72b76a90279da09ea332943924d.1744787186.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <58863961cf88a72b76a90279da09ea332943924d.1744787186.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Kohei,

On 16/4/25 10:14, Kohei Tokunaga wrote:
> On emscripten, some implementations in os-posix.c can't be used such as
> daemonizing and changing user. This commit introduces os-wasm.c and
> os-wasm.h which are forked from os-posix.c and os-posix.h and patched for
> targetting Emscripten.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   include/qemu/osdep.h      |   8 ++-
>   include/system/os-posix.h |   3 +-
>   include/system/os-wasm.h  | 105 +++++++++++++++++++++++++++++++++
>   os-wasm.c                 | 119 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 232 insertions(+), 3 deletions(-)
>   create mode 100644 include/system/os-wasm.h
>   create mode 100644 os-wasm.c


> diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> index ce5b3bccf8..e87cc36a3a 100644
> --- a/include/system/os-posix.h
> +++ b/include/system/os-posix.h
> @@ -1,5 +1,6 @@
>   /*
> - * posix specific declarations
> + * posix specific declarations forked from os-posix.c, removing functions not
> + * working on Emscripten

You shouldn't have to modify this file, likely a rebase typo.

>    *
>    * Copyright (c) 2003-2008 Fabrice Bellard
>    * Copyright (c) 2010 Jes Sorensen <Jes.Sorensen@redhat.com>


