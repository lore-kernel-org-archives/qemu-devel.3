Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C914EF070B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 05:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpJYc-0002rl-2e; Mon, 09 Feb 2026 00:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJYN-0002qt-Af
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:11:19 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJYL-0008Sy-NE
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:11:18 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-823075fed75so2286391b3a.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 21:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770613874; x=1771218674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XEInEsbtA7C5c3ggAOe0PCoEv583kqmg82QgOAs7IVM=;
 b=fJGlC/LwMul9UQK87EdaUu2ikL+Uq/ZPXduvQ/tzvlY097uyx4IEtagPQNnCP9ii8Z
 fxSZdlUX7tCTuY0cN3Eg40v59xx5kfmZdVw3eqWRh8gZt1lSmbSDHGyN10CR9fFIgPuK
 xNKsJVzOKg6e4Exqj9NtysBHwY2jinicsUjwm3OYdsYoxH0DYFSr0oeVuTknvCWBIMqE
 Z+lOjo0xAMuUwj2KcDmuLNY3W6M13OwW/HSDwaGi+W6tkRxY2xgTHKJV0m0TLxU70Mom
 6nvEQA2Bb0IWyJQNPURkz5krOv1U/I4cDUkJEGaqdCowk00O7VvuCIY3vkTeEMxsVA9I
 nZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770613874; x=1771218674;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XEInEsbtA7C5c3ggAOe0PCoEv583kqmg82QgOAs7IVM=;
 b=hwgk8kcz93V/80SGwl+js/axWzaHZhxvIkP9Ey7HIkfnOe/5wOdXScKvcV28+AU933
 sgVBfGqTJERTFATjhm3nNd3d5dQVElaigl20hVKiSXUw/ncSKy8KQg4D4Y9xKmLhLFpQ
 rjUXVIOUP+dyLPWTxx7kngePcs5sdm5rXbNUwHurGm4TGHZgb0O+sUZcvEhuesFcwleb
 R5RMl0qxAM0pTSLEgRU1YN2CidDVHPHx0V2H9CrDAPw7jiU8/Ty5FMriYjQVYqlHynB1
 cla2/Q7hKMi1O9es0aHTwGMDnqXtb6Wr5RLRsqOv/dSeiXGL88JcmW30orjxU1yAvG3/
 NvIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ/gZAFzW3De73Vv5oHsyg2jimFbc9c2ukXrNxUzPnqkgW4E9JpWqtzzMioNPgzq1ZdA4WctB28wgD@nongnu.org
X-Gm-Message-State: AOJu0YxUT7FYExBt6e8vXhWBcS5grgF7y0dNgEh4WcV9X3oFUFj8axkb
 qQpn0lVUadlg0mxWNznWjMv1K380UgAJUCyb5NfLvrADIY0pMakfl7eWcO0elM9GbRY=
X-Gm-Gg: AZuq6aIf0k5NTaKAmGktd1oxsTuvcZHHcFA2zZ5AGkSzB5KzNaU4kw1tbvXdFX9tY0G
 EiXb8uFremcI+VTKBXv0TZma4uI4RyGPzH/zWjV3YEKETGRFgACVZlFd77wMUTfL9OUSbvPAy3t
 0Y9xYwMgbuBTbNOK5Zyd1CEzMzqq07Yb00+qqWzwOGkeEx4BCoZDhiLm9bet1YV1690JimJyJqN
 nkl+9/krxJ4g870Y0Smxqp7X8BcnzBn2pV8HUk9Gw4WKNfVUlWeX1BRbnHnFh+OGBprEMvyDhoq
 5rWmhdubgtdWw8d3Z3TB8/Pyrr7cMZuhB13JEHserIQsky6Qqhtr8K+4D50BXYWmrBpMpOX9KI+
 ZeJHrtDuomGe8WRYblRMmR7HbnK01deOhFoXigo/eFC7eelFYAdU+2xE5cUxejdZ9mofETEumz0
 4pjhdw4dBXgTuI/LqLuUzFYkpdV5ZyOQJb61LCPJnmDsK3LNqrpLWmNySdBxeRxxI=
X-Received: by 2002:aa7:88c9:0:b0:81e:1b77:9e61 with SMTP id
 d2e1a72fcca58-82440db3157mr9546147b3a.25.1770613873948; 
 Sun, 08 Feb 2026 21:11:13 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244152456asm9328818b3a.0.2026.02.08.21.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 21:11:13 -0800 (PST)
Message-ID: <2195fc2b-90be-4134-ad28-33280072a95c@linaro.org>
Date: Mon, 9 Feb 2026 15:11:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] hw/virtio: Use VirtIODevice::access_is_big_endian
 field
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
 <20260206221908.1451528-4-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206221908.1451528-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/7/26 08:19, Pierrick Bouvier wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> Endianness access is constant between device resets.
> Use the field instead of calling the same function.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 24 ++++++++++++------------
>   hw/virtio/virtio.c                |  4 ++--
>   2 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

