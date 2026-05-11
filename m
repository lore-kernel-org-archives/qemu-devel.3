Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59244CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMO0y-0005Y8-RY; Mon, 11 May 2026 06:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMO0h-0005XN-Af
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:37:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMO0f-0005tG-IL
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:37:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so30014905e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778495832; x=1779100632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7JoOKyLSG9ozP1XDCyS++1vUHt6QquHii6vF91UvK0=;
 b=VJIBCIjqohtNNLWpY0VNeIV91nma9VR9Xgt96izql6MRiuOyjF4a0A7mbX5GjT4vw7
 8Pf+9aa9ewzLWz6qArKquWwT8gF4aGytaGzuReAMjidEdNOJfAO/a73Psd8rlJDNNdnh
 AUP/008mbnTE1zz75LLZ0PGsvbkt6MHR6eYE9JO6APRfD57xZlGAolsUKPOoMnKOiaRN
 WefzU6FvZ46wFvcxFo/kufW7ZS++S/VhVU3YKgEqDMI/NWxXHGQORg5bIn/5jhDyD56Z
 w1kwelqj58dpaM0SLpYhhW13cha4GrM84rlmP5TQvIm72XmikGZAGPtyjVStQrGz/IjM
 j8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778495832; x=1779100632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7JoOKyLSG9ozP1XDCyS++1vUHt6QquHii6vF91UvK0=;
 b=sAPpcNQpHinkkHwxTIQznK6/pw6WZJFXRmeCpETzM4W0DgadsBl0Pfuu4r+Cd6G59i
 KYCB+eVuhnZykWNuAUnyOfOcAXmEZG0vqZv+Kwy+Mi0jXxc/lRqvUXCroZAMCBI6ubYx
 33w/3ouH77j0RKnOLwW3NVddQ/zcli6Fw+LOJybAGAjkVgbQ0ZgX8DwgMiQnuZVrf77N
 gWJkNcWHbwUI/vs6D6s7naDlzH+uCO7hcjtkXpsO1A/Oa8QMz9bq0gUxMU0X5l1JKAf3
 8Vx0Xm8Wx9SBLNwVXzkNJiFkjv4DhTM6USKRGYcRRsZJWUCm7gDJ5OOrKXdDOcwj544J
 WMAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WKeJ+Y36cTRvxJ463sELaB8XZdmef/lrWHZwgUdM+SbCKETZ4y+fodBrIJooIaa4wAVjIJ4JkCqDi@nongnu.org
X-Gm-Message-State: AOJu0YxJyV0WTEbnLFYdeRQqhc2mbg4hsx64UaHCVUPPmDMuKkUGYvC0
 HAdg38DMITucrUAsuGlkKJKmvFh7BclNDgUBLQ+ZiNd7l6rH9AS5y0EmYkSIATBxR2g=
X-Gm-Gg: Acq92OGL6kGh6NkxjWFgOZVHmFRQfPSnO+isdKvmLL8iFTAi/g9y3tdgbeCyy59dS/Z
 0KUAlBTzNQYEHUJiTPgv56fyigkxhcYfJ8ZoR5828I0zA+SDZ5PTTfK1nVierALa4XOTB5p20k3
 Q8he8TACVQR/Ok2WntrpjoizAmyA+XOy3Yl3HEAhehuJzaPUOO17arCWp1MIutJTZupoPoJV1A6
 wRnnH31nDiJ+fgkKYAZ+tWUUoY/hIgFbXpchO/9lpahSRWP6KVjvrnoofuZ2ejwAGFz6nrsjbv7
 flyh9NZtiYoV0613GuwT51QND2i3Yds2kpXu+EmHBRnZtBfP6IGrVAg5QoQkSWUlNCEpDjbBvk2
 qNqAMs0W8iHNpjYMqRDrOwIR/qkhxIzly/0f71h+3rKai+HUhEpnnuO//xA3q+OB7TGL50uL8GY
 3pG0SYMfsvWm8s9kMte1UOVZLum2hAK4wCmU2KjV9dCRtQwUvkjmyYsINKYx1o+jO9Mg==
X-Received: by 2002:a05:600c:32af:b0:48a:534a:eed8 with SMTP id
 5b1f17b1804b1-48e5dfcd722mr164655295e9.1.1778495831680; 
 Mon, 11 May 2026 03:37:11 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e701e89fbsm160775865e9.4.2026.05.11.03.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:37:10 -0700 (PDT)
Message-ID: <5ce088fc-9a18-41fd-9982-9a353a809d08@linaro.org>
Date: Mon, 11 May 2026 12:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] qom: move object_set_prop_keyval into object.c
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-7-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260508112429.643360-7-berrange@redhat.com>
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

On 8/5/26 13:24, Daniel P. Berrangé wrote:
> This matches the location of the object_set_props and object_set_propv
> methods, since this method is not inherently tied to the user creatable
> interface. As part of this, object_set_props_from_qdict is also exposed
> as a public API since it is still called from object_interfaces.c.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qom/object.h    | 47 +++++++++++++++++++++++++++--------------
>   qom/object.c            | 36 +++++++++++++++++++++++++++++++
>   qom/object_interfaces.c | 36 -------------------------------
>   3 files changed, 67 insertions(+), 52 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

