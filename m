Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C793ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OVy-0000fs-7P; Wed, 24 Sep 2025 08:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1OVe-0000e8-3B
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:22:13 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1OVU-0000Ae-3Q
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:22:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so2744702f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758716513; x=1759321313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y0znOe9X4B/PKbemoxCtXVM5awE/1hV+1r7TY6n0OQU=;
 b=uuixDhHCedmSs/DSrAM6KHIggj12Tl+fVk4CX8Q8kd30Wubx5+LCuJR+1kWUoNIOlB
 /l4cQ86jCgdRn0aDOf6x0AXatwFf8CNO0JGLWDc7yWAHwS1D9MyGe9eDxX4V6w8UqbCB
 EVZAMU29qJOjjthj79l7/ZWkfV1kBmPsFhU+yaB1qEzHfd2/RMGFryMB9UteR6xBJvO6
 IyHBbJ6qghnY4ZLuF8n/3Sh6EDBHECnC3mNLn3risXbqvexF0vdnzsUOYyFDfjlfUgGJ
 HXGgvkKw1CGC6tpJL1GxTwYbHJofkUZGhpqLGH1y0aL9gqTNpiFZ429Dkw7rVogXOt5J
 51OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758716513; x=1759321313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0znOe9X4B/PKbemoxCtXVM5awE/1hV+1r7TY6n0OQU=;
 b=EzamoccQs8uxzhx2TZNnY1ngblcaIDUtmqZX2SfoOC1dLZofcG6k09aAL+HOqzPMtx
 yq+6skNrmiQBAve3Q6uionFTe1L4LfQwKM1He1J8m48y3087As6mVhTyK+iN5296UVdO
 SKnvcd9B7Trjj7Cscv7yH+rJvHXVKdkZ9h4TYozTzlwNWepyqvSAeI2JlT92QNCHEvwa
 KytqEYi+FLeU4O0qPY91BmJ45zKPwIccnr26HSsfNPq+Vj3wgvwba6/5ltSs+sL1SCja
 LzS7uK5cxdVo22i0ULot1XgEVyAQ8c4gwgTzzIlZswFp1avSiBZu6hbN+wYMpGfqqEHs
 oNkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX66+A3RiGHMnuDUVO75Ow8V5lOsVju9ubkZxNW/1yR0bwYKdkrNhgGxdNKORQFlwYSkx5GgtE4qO20@nongnu.org
X-Gm-Message-State: AOJu0YzkRy7c+5RdTTP+kP7SyUkdmQSCJKaC87nqEuLLd5TeKkYl71Vh
 So5mwYu3I/3fFRZZbBXYy/5hsEwWAvfIxA71GatJNe8Cn475iWnBV+OBkaUDH4eJpgk=
X-Gm-Gg: ASbGncvUd40eosCNSZF7feEXYmtY9hSKAjvqPin21CYtDyTwls4hRaW1rp2ruUK+YwZ
 s5zAJpXF9qppP9jG6pdl1XANpxfGLEBJCeo8PE08EXrf6Tju/RUplME20qfrCb8gRZ05Jdr3L9/
 DtfAmnrQKRg1pO5vbJlqXfXbCx8y3lg2hw++6GG0dA6c4DwHZJBejYkjiBGU8J7qII4uPw+q9Bc
 uaAMPnBFiGTrv1RgqYullQNbESog+Zi0RbY9inTd0dOW/DTHcIYPlvqtzD6OKuY5z5hJILqAzLR
 IFaJ5ZQIFYeInUkWwedkRp64bzlGngAhy8rgw+fV1N8CAMvkV2BusUpQB2nPj66cqHvqd7b4l89
 PPvCJvTsLQ0LOEePayhyfeTs7WRlZCYmUCY3RuqyTESIEvnL8S635q6aiA528zWhjag==
X-Google-Smtp-Source: AGHT+IGxcqd8y70UKTOIYQrCqi2wMjfCHzVYmH3qBBwLsAfmtpkEioQL6ghzMao5t5IEoZPUKrVIGA==
X-Received: by 2002:a05:6000:2902:b0:3eb:d906:e553 with SMTP id
 ffacd0b85a97d-405cb9a546amr4874083f8f.55.1758716513297; 
 Wed, 24 Sep 2025 05:21:53 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f02f332c31sm21975989f8f.45.2025.09.24.05.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 05:21:52 -0700 (PDT)
Message-ID: <79dcaa8e-450d-468c-8df3-508eec009f07@linaro.org>
Date: Wed, 24 Sep 2025 14:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/27] RFC: build-sys: deprecate mips host
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-26-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250924120426.2158655-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 24/9/25 14:04, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   docs/about/build-platforms.rst | 2 --
>   docs/about/deprecated.rst      | 9 +++------
>   meson.build                    | 8 ++++++++
>   3 files changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


