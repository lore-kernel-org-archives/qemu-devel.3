Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745DFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10bk-0001Tv-52; Tue, 23 Sep 2025 06:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10bV-0001Tb-O3
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:50:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10bF-0007M8-Jc
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:50:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e24de89c1so546575e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758624615; x=1759229415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U2C5Txc/RlgvZePSBDNXtEQyvBfAQwOqhrQIrvvpA+0=;
 b=Hp7AudRo1lJvyCj1eFb5X+ka86f0CQ4dr/GojForxK3L0a/VL+5Yj9oF3VCC3R8Hhg
 6MZYYtiMr89rXFDnINYHKXbYK4ywHd4jEk2JxFXK+LIMBRkDGkfC/OkkRl+0jybASzuz
 dXdrs+liTql2tlj/RfYEPRolJdx+SqwzjmYXEFHwUGO6XR0/86ysgJ8HUyTlgeoMIKbL
 hBfpauFx8TclwzKxMfo/txWq6X1XdYKn2N5XAjWg+OaRAYN2lQ1jHxzfANhhSu1ljgD9
 6KowOi3dqZQvMDENd77rHcafAkOB1DOlOxgtor54awi7ah/BYB4YJa9dIoKi4VJXHpol
 vNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758624615; x=1759229415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U2C5Txc/RlgvZePSBDNXtEQyvBfAQwOqhrQIrvvpA+0=;
 b=u5AiyI+Yb8EoFmkVYci/13Dr6T0i4AqG4DUmW4GKEtaHzlCOTeToPwr1TmAAVU6Rp5
 Jxnx3nZIPxAKL5wMTGLoy5Yiqo5By0+zxtVPOmor1earInD1Aaw63oPES1bGTL+9kRkl
 5ArUMo/3sEUfOutRedxKeuPy9oVXEeEClpwMuyuk50wCLef0nnSQyyoB02KucDJojNSe
 kklk80aDGFSDyryAoqOcW+Syc3dZgBIZnYxeLGA6wDwojKzL+sN8XEgbGmreEl7PGm+B
 4zFYTzfsqpuYDqkpWwa3TEQFmFYdVdAvijuUzFlvoltcMFLsQpMHN/B5gu/trYHYc2qA
 DxjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN2zgIFfwl+3crZfT8T/dmWS3TLUOQkrE1ojEfaYP/roAyU19YsmrStVsdliI7QneNSF27M4nsOTlL@nongnu.org
X-Gm-Message-State: AOJu0Ywz4cl2giXPJ2IOHBJUNYemoFXKnVYY3tL1QOJXyTPG0r8wwLVl
 zxhkC1XIaYrrNvxnIMfGOrdadw8P54Vv7gufqgtxRvVjEIg4X41kHt1QIr/eKSjnmO4=
X-Gm-Gg: ASbGnctcg0qdvWu/FhVAhuuQiUXi4Nxd0jfO3zmiLudjeHyqBL5JBchOcfN/HBTjrKw
 7M6e0U8nBJt2VpaPWhKCDHtdaG2WU6J7nf9sPJRaWgpbwRkLHdNuUIvdoWtJczsBmJ3YFd3y23t
 jZHGCU0CV060BDdClrXqtShpJqpjrSN7k46vSDUjvCytYadOfT7YYzkuwpeZY0MgXD+Cysi8+YS
 g5ZnRkx0yUTgWUW2+NqTcwaha28JV8U8hR6eDCG/MvWmYLq8jaoFrUXYnn8aeWI/UX612xL4LZn
 R5AsG4uCTfz6UDkrif2sMP9ih/RvRDdvAveBqXfxa11Pc5Tv7On+CJDRas6iVmGBxG8ajmHTykh
 cLrt6Zjb+3bfETiuJYYftLXuZZzmq4gpXIKaolFDThQHB++5WvdPUfftB0XpOx9J1sQ==
X-Google-Smtp-Source: AGHT+IEV9wGUG4i4wFs/rQWM1DcmEjeWaDjEO5L4jxafGmhIuIRWpFzz9TuWyeFCQkRQVpNjCNi3qw==
X-Received: by 2002:a05:6000:2f87:b0:3ee:1563:a78b with SMTP id
 ffacd0b85a97d-405c5ccce11mr2025868f8f.20.1758624615153; 
 Tue, 23 Sep 2025 03:50:15 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0740841dsm23517823f8f.23.2025.09.23.03.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 03:50:14 -0700 (PDT)
Message-ID: <e1471f5b-8425-41c8-8e16-819b59608008@linaro.org>
Date: Tue, 23 Sep 2025 12:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] tracetool-test: allow to run in parallel
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250916081638.764020-1-berrange@redhat.com>
 <20250916081638.764020-9-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916081638.764020-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 16/9/25 10:16, Daniel P. Berrangé wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Create a temporary build subdirectory, to avoid conflicting with other
> running tests. This fixes "meson test" with tracetool-test which is
> parallel default.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20250908114652.1880366-1-marcandre.lureau@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/tracetool/tracetool-test.py | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


