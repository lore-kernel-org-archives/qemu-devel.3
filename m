Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F813C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJU4Q-0003O9-Qu; Mon, 26 May 2025 05:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJU4O-0003O0-Sc
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:24:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJU4M-0003SC-5z
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:24:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4c9df6f92so1814740f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748251468; x=1748856268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K1x9TO2/YQkmtDC2VBArTOanuI/zX2tDYDIolFgH2xI=;
 b=OwiCnd9bfsHPv/K9Rq7lpj9rP0jH/4OvmxS9J7wYQxYjuNuMCQF8jvINOi8DvvMOes
 eASMf+vIXnGY2Sso9LZa84Uq8sO3SsI2fk+yY+qbP9Lc9YmsLMsZaZ9v/8ICfB9zIkeC
 OQBAcjq+sqya3tgDNP5ublz7riqYRotQqZQF3A2psabwnR0gooqs3Nn35NcbaLPVyrr/
 3wM44UWiWy9WwVBqTmK07LRx0p2o9Tn5KLCJ9hO6sI/v62AZtNOqhHEw9jb5dBhv7nVM
 KsYU6Bz8hk0VhTAWQWu4J3mVc2Lsgd5YV9xMVIdem+7snnTVkQ5oBgftTYQNCBZa6iNA
 oqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251468; x=1748856268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K1x9TO2/YQkmtDC2VBArTOanuI/zX2tDYDIolFgH2xI=;
 b=csQCuzMDohIDvYvgzwEt8rKaWaIx0LIr2xSi5vcWiYwUCJ1wkux/1ZbVmdDFR5pLjP
 /bDEduHIGCUNrhOgoaWfC7gCNSIsj2n7MefMEPHm2nPkxBNQfwwKq2gYRYoEubjju85+
 LVWEZewKDcucAAz4y6E0pbfZmDIQmITaLtcEt09nO9LfigoIEWQDbIT5gZEnEeEvEHrH
 jBFmckiuEduR5e7ZisHHaRuyekIAgKDbs+vMrV3LjjBgittxExIo/81JYpWx2jXYkbUP
 bNgtwm2FRiQbqpyHnBhzWUD3agb96fXdtnMQq1/mbbb6na1rHHOYGBz5aua7wYR2F09+
 H3Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzjzDDFD7KFsdDQPen7BD3/ytO/MvwyVGp7ysF5PYrJ4p2q55wkSfbfuf8Uyp6/iNXEPrC2dnFZuEe@nongnu.org
X-Gm-Message-State: AOJu0YzEqCXBX/bDhvt/t+8jZ1cUofO1HGObuiXUiDvlknxA8qTaZ/VR
 bfyXslsRIdV6vm/qeBntbKkMQlsgCAXp+0tZqwTUyVUJZuFj+DaaN8JI5D3ysVSzYZk=
X-Gm-Gg: ASbGncvJMV5TuUQjQInrCvdMVlcK4JwaYtdzCF5WJPGrGbDxbCMH+HfIDRMurfuzV2I
 U2ZesQ9/h7Iz8qEqO8MNuNz+FB/XcDe1GJpsqXWkGg1q9BHn/cHOBxgXz2ffRIstQYKngSfyw6e
 L4vUIFDh06QOQ0rLTSmGaw0/a8XU8rklNe8Vf7vsNPJvDjQ5A0s1LNjI+GvRRPa1lyhiN8bWxJY
 OGCzNCo94nmNBeCyCrLlVGo/+bb5XWhbv5I7YbiWyb5RuGxOB/52CX6zAFObXkN1OSYRjgsVLiA
 Ta0oX8QmPGCE1hdEPITHMSzl4rxpgRQP6qlcj8Q7ybjzZARnRz4KxCHfolfE/G29WIsm2lfRjdG
 DM9DnofG17ZxL6Gz4KUJh26Lv
X-Google-Smtp-Source: AGHT+IFgFwug9WIJUaJevOQRK1WQO23xnF+okU+94OSe9su4ORYHzogwBf1oVW5/c3+kSyLfUZy9MQ==
X-Received: by 2002:a05:6000:2082:b0:3a3:4ba4:f3cd with SMTP id
 ffacd0b85a97d-3a4cb449308mr7197064f8f.1.1748251468411; 
 Mon, 26 May 2025 02:24:28 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7ca2de7sm228447715e9.35.2025.05.26.02.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:24:27 -0700 (PDT)
Message-ID: <005ab1c3-9472-4c8b-a6bf-86dee9adc819@linaro.org>
Date: Mon, 26 May 2025 11:24:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] migration: Replace QemuSemaphore with QemuEvent
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <20250526-event-v4-8-5b784cc8e1de@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250526-event-v4-8-5b784cc8e1de@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 26/5/25 07:29, Akihiko Odaki wrote:
> pause_event can utilize qemu_event_reset() to discard events.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   migration/migration.h |  2 +-
>   migration/migration.c | 21 +++++++++------------
>   2 files changed, 10 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


