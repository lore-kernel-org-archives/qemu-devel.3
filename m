Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBE8CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 18:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwlei-0000v0-2x; Thu, 11 Sep 2025 14:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwled-0000uP-14
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:04:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlea-00042R-OM
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:04:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45df656889cso6949405e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757613855; x=1758218655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yd47hQ96t7yOjkcKgx8j9KhmfrxkcyBnPQJ6QHsQ5C8=;
 b=vbXBYOHwB/OUd+Fib/GvPIe/9Xz04lFaP0DA1+balKya/SqvGOmGbySIBhoZNNJyi9
 xjcCN2Km35M2nBhoaRnP00A6dRIol2nA69Snv2XEORe1YuO5BUs8iIswOySIUBFpU7f9
 tLkPAANC1yBzNGHu/NcwxQsoZm+urGz0qI/Y7lVLUJnEmCyNKirFY2JMfAyDQW1AO0iF
 ah/xs9Tv1qgC3/dVE3UXEgm3eg5l/4zuRIhySftC+X4HH3T5HsMS1KpF7zk8JeV6TpwA
 XpTsWolbjaew0BYLi1dq3tKf3XxXtlBebCiZdJmtSJ9OHEtMhWv0epvMEh5giw/TkGez
 xJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757613855; x=1758218655;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yd47hQ96t7yOjkcKgx8j9KhmfrxkcyBnPQJ6QHsQ5C8=;
 b=EdRS1H1jf9R2SjGKqrTexjKJEpVnCwvMZykJfY7szOZ42xs/B9fRKlrSkcKzBuxhPw
 zLPofLc1cb1A6LktfytnRgBVks+x6xwD4Mf9ZpQ0a2KcTE95Y4lm3m/6sT59+aS+urAj
 fmayIWGdYhBs7UhLurlY8QkCRnBZcNtBMbhmke/ahAQPmBLZe33tpGG6qhB9U3k13p9t
 4D6GYh61q3Q3hVrAz3aLYgPFNbR8UHvSl1+GAiNxFQ1oZFQIKNQxRSG9LC2/J9wGKhdW
 3aYUngEBG6rNjCuGCvi364STxxNdycF//v4jTVN8sdFRlYzKpzvXxEVVFPOG0lU1u3LR
 w+jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMNi8awdm/mRauGbfvzPPyO69p+SCzROfFAAW8Zwp2Ly8zz9rxYw9PnOUSRFnilPbJOdQfNbkIZ2Co@nongnu.org
X-Gm-Message-State: AOJu0YwrSa07sn9NLZ+MMCP5Lpv2gD7zKPxU/Zvbfc2wlYqO97Ru/yd6
 aE+ODBExVhsNusUhiTauapogaA/Z8eKhYUcHVBGqVK3M07FAC9p9KIxi+0faEZN5qaY=
X-Gm-Gg: ASbGnctIbXgQbI8xH51+4CQrDr6JlN91G6NW0h7jdDuiAH4qW5GJf2nUxQnKC937v+k
 sVgc2VOyHprSGkp9OmbMmxeDJGWO+or3Gf4l5LaVpAEWDKLEwl7Asykq3AQ6KjK7uiQxYnqxkPR
 l6ytm40ibt6afNH3Cz7bfzMTXauUzQO185r3YCJ1nmRSAjHwAEfBGl5kkezcWUt5oxGdsDaDWM/
 jz/Ro+KfOR6OfLXSrOvV0pVxdaqFiIegAt7TrJmQPd+EqOf8JoAgugbHaIVLaF+NStnlPREYOLT
 JaMapN3H9s9xfQEM5kSOLRZtqwCQXmPvCUbe3ggTN/qb3eEBW7Pp7nOxRM2eis2TqijtTO4j2Tw
 HGxsle3pzkb5RmTnrYqrrRp3F6CuSHiWx8/6afWj6d+YqhLRSQYjiBHk7gI41N4HN3EDLmv5M5X
 g9em+WPD9WLCHxNw==
X-Google-Smtp-Source: AGHT+IHDWS91ZPTkkGU4rhWffw9Ojk7vbnxp2mL1w/Wyk9ozdkzSYTSYlgePiZD/jfoV9USb6ZeX7g==
X-Received: by 2002:a05:600c:4443:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-45f211f7572mr2894795e9.23.1757613854532; 
 Thu, 11 Sep 2025 11:04:14 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e017b2a32sm35061245e9.18.2025.09.11.11.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 11:04:14 -0700 (PDT)
Message-ID: <9f2b2b44-9f70-4214-9fcc-39069a400a6a@linaro.org>
Date: Thu, 11 Sep 2025 18:04:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/20] util: convert error-report & log to message API
 for timestamp
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
 <20250910180357.320297-17-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-17-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> Both the error-report and log APIs can optional emit a timestamp
> as a prefix on messages, with the '-msg timestamp=on' command
> line flag is set.
> 
> Convert them to the new message API for formatting the context
> prefix, guaranteeing they will have matching behaviour going
> forward.
> 
> There is no change in output format for either logs or errors
> with this conversion.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/qemu/error-report.h    |  1 -
>   system/vl.c                    |  7 ++++++-
>   tests/unit/test-error-report.c |  3 ++-
>   util/error-report.c            | 17 ++---------------
>   util/log.c                     | 21 ++++-----------------
>   5 files changed, 14 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

