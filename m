Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09696CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ifG-0002Ig-A6; Thu, 25 Sep 2025 05:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1if9-0002Cb-Jo
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:53:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1iet-0003A8-H2
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:53:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e30ef74b0so4903295e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758793958; x=1759398758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ch4rC9dUwhktjgX64QbhPwjwyRiTlK3EhVImeheBex4=;
 b=Sc0iW55GxIL2N53hoEhkUoiEaMTYU7nQza2Gtnn6zAsxQpNvNRK/yHj4JOLyjx0q/N
 DGD/vsdbqrDzpK47R3zuIe+Rhd78WBYTGw8OTIr16ymvSevvOv2qmQjoQF1967RNe/l6
 NcgVzu5IOvBA8GMF/0donPKC2swCoQ90twDzVIZC3NdWC2xwPELwfvJuGAspq5DHGvDZ
 lgiZSGJK3lCzznaxpkxpiXkGyiXyKr+NkF7I+KHJtHkaWybjOjCBxJTqVNZO5pk3mdrV
 pcUaTCSCsBNBsm9FFdjVoMMnXshnTWa4SYChxt23B0b4r8h0LUUOcjWwXH0y7Qb+OmcF
 NhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758793958; x=1759398758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ch4rC9dUwhktjgX64QbhPwjwyRiTlK3EhVImeheBex4=;
 b=CoCP3V37BFYRtGjSEHuQPRlGluBZPPuvDGFKfQ6/LoioxD+ZSmQJdQHS9/+gZkqlwn
 g1czAl93zhu0Q/yFUwxoQbEFpe7rS+4iTEwRYnPpgE5YAELYvyZhn6XCBXjuZfXCHtp4
 aY0cAsAUE2MePudUAQdMttUD60MVMQtyKmrgXctuHEIuqpLmTU2C9gY2GduYJ0x2Pt+g
 gxOAaJsJ00prPvUgA0kAonSX22MKqio6lZjkwCkk0SdzRIzHBtvgkO8A9WiJlZQTGd6y
 NhS7b0qttiZzRurS6xCU3L1gKaTwos13jCHWWPTceYGN977IONkYROTLVHnxQYA/1Xg6
 oFIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcAtYAaFDMK6qWQ2By+x2kDSG2ok57QskXCQvhV5wS47dG5rCrX3Da/g2+GTHgydWd6o4giDuY7VEn@nongnu.org
X-Gm-Message-State: AOJu0Yzp5abmw4PE39zZnugRkdc1p7ViMdu8b2p0YYK00RtTuN3tGboQ
 a6WDmkmJYLoenflJ4KWb6Yb20paCyajgEG/+RIxhdf3ViAypV1k10bxp5+jjhot5foc=
X-Gm-Gg: ASbGnctSjTvIQCiQtVH5bCP/kh48mjmQIpYBu9XAyjsEULAgrLUr04vT/9tZTuYfcaX
 LhGk++p59b0443nsDT/+YMD16aM1D2La1bUanUHE2hn6ds5127jOB8taUCDhwZfs2hdkIK06fxE
 R4arfeNrzo//qPm9cp2MivBU0LcJ3ABV1bflXhrY+uDiwLYkwweNj6ivDfNCk1lTVfR7kQ3ksda
 0kA9rllxhV/giGPrMQUEC+3ouWB/34kak12vmU27yveA6FlC1exw90Adw4ILWBwKSnQDtuJdpij
 1TfJBhJpRQ4mId1sh0oqgVZRE+aFMGHyBtt7rYjCvqZhPaIsHnUcelr0ihQfe5/NQe+BBkM2+JW
 a/cNiiciBgUb4kAvb9jantmoxv1JGz7B8XfrH8Zrr8YpmBUbaZH3DXdRaTT+Th7QqXQ==
X-Google-Smtp-Source: AGHT+IE8LXVgsByWDuVLoICxXwfRhVIoSg9kqGYiN/K6iXIQWgIYnbS5ScoHetFwao0FAsOAcPoc9A==
X-Received: by 2002:a05:6000:1447:b0:3ed:f690:a390 with SMTP id
 ffacd0b85a97d-40e4adce95fmr3049581f8f.40.1758793958579; 
 Thu, 25 Sep 2025 02:52:38 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc9248f56sm2428364f8f.61.2025.09.25.02.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 02:52:38 -0700 (PDT)
Message-ID: <dbd997f7-d7b8-4244-9ea6-28a625afde50@linaro.org>
Date: Thu, 25 Sep 2025 11:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/23] util: expose qemu_thread_set_name
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-5-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925094441.1651372-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 25/9/25 11:44, Daniel P. Berrangé wrote:
> The ability to set the thread name needs to be used in a number
> of places, so expose the current impls as public methods.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qemu/thread.h    |  1 +
>   util/qemu-thread-posix.c | 26 ++++++++++++++++----------
>   util/qemu-thread-win32.c | 13 ++++++++-----
>   3 files changed, 25 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


