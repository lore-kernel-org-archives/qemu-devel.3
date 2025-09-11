Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BACCAC594
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 08:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwd1G-0003bB-8S; Thu, 11 Sep 2025 04:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwd1D-0003VO-FR
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 04:51:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwd16-0004vR-Ow
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 04:51:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45b9853e630so4253345e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757580653; x=1758185453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ujnceHljfEoi7XPNlz/AudQ/n03a6q6hILamwu8xWnU=;
 b=x27V82bYf9wU7v5KoWIhd2aI7q5ecZ9NoWjjU5aaJjxrJBQMbDemEHckW9yHomfmjo
 squW32FktHAUcC7GBZPaE4ADPBKyxy7Vuykr1RUMMWyicYOoLnH6OZgve3AllITOqAUW
 9hfp8+CxZRIlu+GWqEMLgZBmEtoEqHSF/LnhZUQIwUKr7fWUeEdp6Jqk1JbWmRvMKX6Z
 todhktmBglEUW0a1qaBI/DItJEyd+kcssrlBm2jurGdEQct8TGI3aLKTQgZPa+0ncfsW
 /yOYPBajMjbKDAhEGtHdszaOZBzE+PxhQK7WQUKWbRZq09UkwIZyP9YJzulBSSVJdi0A
 XjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757580653; x=1758185453;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ujnceHljfEoi7XPNlz/AudQ/n03a6q6hILamwu8xWnU=;
 b=prYOjpajm0KaIpMOV4ntfY0zy/8VgX5x1RGfMVpBPAmHIEJxqM6WsS1Y3PjGhIlMid
 1ovYxGfziU1uD7wtF2Ape7yJU/VjwMljqbHXlnXzcdkO16cNmaE4ocYxnM8kLxLu53mE
 SGPz2vY8F1umDAaBkesaWXrEfgbLXgqNQ2Yi/bScMFZq9sjekdatf+DtHgszY926ZY67
 Mz4r26zI+n1OHUKxK+TRG4YZxcF0YC4e5NbqT+lsz0xx5LwZaOiQdsAJmIXwGtUZBLEk
 M+w1AqDbAgYkfPKq9z5es+W10KtsYBfP6/dvjfY4jZz/bWe3jF349ApInVN4wosPrEqd
 GoFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJxPaptQK6bKqu8Rp16y2bUewPtW+o0noaBpeLBgArfhHUb+a7mn+r7ID3Uimj9uQAyy+uAjIZJfSs@nongnu.org
X-Gm-Message-State: AOJu0Yy2Vi2FcTtNNpDl6oCHJFYN3dYqp9RWQhA8OpZukqYT++SJztwu
 bd7NDcMUT4lkEQaZzy78UkorPj0ToCevxFqPH0jUmWUzhhf6yz71z7Wuhq2MKwiofvI=
X-Gm-Gg: ASbGncs4h9NQZsRFf2q+AeMQpS8gqYMtD6Wapw7fYjb0+ru5z0VwVaMfc3dV1HoRoU9
 tavelVE5M8D/K/J+5tzX7PkugUCD0Hip4d4NmOmu4leu9yq7hLkt9H1hnk3TIZDW0cdHq9h0fw1
 44TLejt96QKDuKLifHOrk+UDFpmC1Yq7miyTwHJinC52blwSa5gnFmNqnrGY89srK1hVTKzE4Nz
 bWAVNcCPU30CVNN4HXffrqUZT0c+5TgdR5UZbevpgAmPhYw4qDjhch2SML+FheaN39n5L8aeRz1
 J3Z4ykSvfYGE1ZwlupS+/VwtNGS+lgmHF1l9GRVODtL1uq4Imwm6Y+DlbMIJh1zQeW95xajm/cS
 xbox5QVZOJ8bZKKWDhAAxBK2eNZV5gqr4D3jCKLQQpNS5jLs=
X-Google-Smtp-Source: AGHT+IFuWRG/PgvBzTKmhpw+b7xWr1es2/CM/oNvjWlkfR7qV81sBWV6vGoSfJAHTZ2+z2p1yTBeZQ==
X-Received: by 2002:a05:600c:540c:b0:45b:5f99:191c with SMTP id
 5b1f17b1804b1-45dddff012cmr174122035e9.12.1757580653071; 
 Thu, 11 Sep 2025 01:50:53 -0700 (PDT)
Received: from [10.20.51.75] ([88.149.120.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e017c1455sm18101255e9.24.2025.09.11.01.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 01:50:52 -0700 (PDT)
Message-ID: <b5681050-2e15-438d-88fa-cd9e612be2c8@linaro.org>
Date: Thu, 11 Sep 2025 08:50:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] monitor: remove redundant
 error_[v]printf_unless_qmp
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-11-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> These functions only had one caller which was easily converted to
> the normal error_printf() function. Remove them as they don't add
> sufficient value.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/monitor/monitor.h |  3 ---
>   monitor/monitor.c         | 24 ------------------------
>   stubs/error-printf.c      |  5 -----
>   3 files changed, 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


