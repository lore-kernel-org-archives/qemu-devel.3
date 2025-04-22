Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F80C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KRr-0000Pn-8P; Tue, 22 Apr 2025 16:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KRm-0000Ny-UJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:42:27 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KRk-0005sZ-GD
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:42:26 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-301918a4e1bso4694424a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745354542; x=1745959342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HA5AQVjZtc6BAQc/jb+qCJYRHcVlbUXjlRRDAwSnwE0=;
 b=HP9eYzPgKDJgcWSttw7eFVEcqnsVqRysYQ3LjOQivHSVqWMgE7Yr2xLeP1rMA0ePWC
 L35rg6VlQIBD0gPMs6XcEg8ppky9zSoumt2poUcsdIE/1N5u8WxuuHkjt8bkz/y0iOqW
 7B8oGkx7Yb0yc+fHhMZmx3Yl4KVecMg0sEWCb1wX02F0FfM7fi44h+WSjACP7YC/NDBz
 l8rtI1JFjuOQxilToasjJVjS5kdOJDJ6Qd93t61awSegRl3UKcwPwIHMaOL78QPXd2vV
 wQC2RSPVaZWqEdBfSO/Gn52QUHVVFD6XIPmTXiNu0LfoLOZw7XyQuBx2KKUSNZ//hYvK
 FanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745354542; x=1745959342;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HA5AQVjZtc6BAQc/jb+qCJYRHcVlbUXjlRRDAwSnwE0=;
 b=lABJ5aB07M0gjxEYSEVnjLxnQii1lh5+lA/JeRpkmOKy6D7Qae9Q4/09LTqj2qQJZB
 EIhWiNPECGQeM9FbfYbsXSJ3I6/VKxTD8yVXISQbb7GiS/KjQmB2yCOJd++iVFPJr6Sd
 Ehm3vWHOZo0Oq6srEzgvLrcG1tcK5Isp/x8wbZQz0KsHITr0DYUg1KIeqRGsDzXTqyvu
 o3aRzkeoRvuDzlJUZUPyQjc0bLfvq3lXL+XKg7z3Y+AVMIRXCTSN4VJI+eEHhuw83Ds+
 fBQ8H2aunk4fjAqU8U1OX7m+xNFl+Z/8R0/xDjUgH4V87Hg8RQxIs1R4SisP9oGLGWhK
 KILQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmTRXdVDqmc5sYrHGWNjuiVD4pxM6PyoN7TJ2fjG5C1956mzB2qQ7dBf3h9FH8WFbxncTWrwc4dZg5@nongnu.org
X-Gm-Message-State: AOJu0YzLOvgJy0J8CjhUs2QrW4K9CwbArqtGa5QGkFdCNykhFQVoCWN5
 jz+zz8K9t9imWCU3PzOxeoAfUsBbshsqZDhmEDBjW5CTjQsvCNld7IyrWh65sc2RduuSEGqA47I
 y
X-Gm-Gg: ASbGnct3WsZO2AvuLgyKXJG4/cqIEvcKv/KFf1VGm6LeR8L9/D+cPYjcDtiGs/e8nrZ
 gLOq4H3rEMUI3F3+f4oz2eWJqSIT+FXsJ576oG0pNmV3l/iMBvY55uC/4Mf4wvnCKiMYygABqxe
 BRPvDGhUPn1vz8hahlMjj1xgoS2+TKaQqFBo15JEhFS+Og9oHKdJk5KYs+7Vwe3MCHkVcInhYOA
 1kKul21oUEe6/3MyEAYGCGNba6CA2PxOGhniWpBpEE9iw3GboED/uvZxx8r6x3WwKCOxQ0vWUpy
 9Nmnqr0Ye28hFjqJCgm99dx4KzB9vrSb5Imq3bVojz+k0wIwmnW7vw==
X-Google-Smtp-Source: AGHT+IGyX5SLVyrx5TwbdfUsJbOhb8y9fgny36bjiE2gO1tydNOgXHiOmuV3Y2tBAsQI2Ms7cPpqKQ==
X-Received: by 2002:a17:90b:3a4b:b0:2fe:7fea:ca34 with SMTP id
 98e67ed59e1d1-3087bcc39e9mr21247912a91.32.1745354542670; 
 Tue, 22 Apr 2025 13:42:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309df9f54b8sm41281a91.2.2025.04.22.13.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:42:22 -0700 (PDT)
Message-ID: <d549cb2c-5c82-4f9d-b15f-add43787f223@linaro.org>
Date: Tue, 22 Apr 2025 13:42:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 030/147] accel/tcg: Use cpu_ld*_code_mmu in translator.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-31-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/22/25 12:26, Richard Henderson wrote:
> Cache the mmu index in DisasContextBase.
> Perform the read on host endianness, which lets us
> share code with the translator_ld fast path.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h |  1 +
>   accel/tcg/translator.c    | 58 ++++++++++++++++++---------------------
>   2 files changed, 28 insertions(+), 31 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


