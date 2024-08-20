Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E19C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 07:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgJNr-000474-0k; Tue, 20 Aug 2024 03:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgJNp-00045i-Dy
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 03:34:25 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgJNn-0003vo-Qb
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 03:34:25 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3de13d6bdcaso68113b6e.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724139261; x=1724744061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U/wqIQ/8uvGH5eVG88kuA7M83jVki1TJ+28zl82Qy4Q=;
 b=GpnU23zZpXIsFaBxEO91rbGeIW/ugfrVC3Nfo48C4oRhAI5ak/aGizFK4rfmynKW53
 1qaGemEBlRR59xfUjOI8srK8/p2VW143mksheGRTflEbkNBqUyLNREdMEg85NL/eTxdU
 iqoAp/OQhqBcnwY0yevLjQVkcw/NpQi6JMO4pdDj3cbe0/TD+A0qWBdFsZ/lwTICQ7Oa
 sUo0ahRaxfuuhjswMtV4GT9IYgUJJ1zgtWPY9WPuYk7b+aXDVsnkZbHSo5KwtDI4mXoJ
 VSS6LfyASDgjJaiJM6fd3hXiV+EeKcLm0iXgkbklz2gcRW/kv5oLnj5xgVR8JXlKlrdx
 kiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724139261; x=1724744061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U/wqIQ/8uvGH5eVG88kuA7M83jVki1TJ+28zl82Qy4Q=;
 b=vYBybJ5UO97Tn0+/WLD3nlKrGd/yxFJoPKQVLnNJLGuewl/5w/J7QSPkuKDhWTmigC
 yIfchG3cX1tVrSiQF0tmPKsn7HCTarw4gm0G5UuZHQ3ltg5BhxWWYTI3vkb7HIotA+kx
 61EDp7IgHw7iQqlVs9hvFJAfFHLyX1aKnTTpttbSNNAbZ1MWXI02+/E51IPMwKHGo6cb
 jHgl96gel17G8Z+UgUGbdhLfultcprnOCRwfr4hcERCwxcznLeXu/1jW4iCskh1/YwJb
 X3nb4gj7virtRIx55J6bu3xBcfJnN2FY+UVrLEblJRMsRkPhWpfTwbljjffUqQvLj1jj
 IzVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmxrl9DXj3/UD6GpHMHmHFzEqmblFIJd4h7pP10oVc8Yx2VRVKmKDu+pXai2hZ0E7dUCOPNcRPImm3@nongnu.org
X-Gm-Message-State: AOJu0YwfsCkJ3rqFwxiN3qk4J4Ytr96FdEb35M7qtLnDGaeveY146woo
 CnOF3r4XLa8fi5HLzJo03dEfc+Pjy0eGiX0ZJSsoK/mD9qdhFoMmKSDh0sN70/Y=
X-Google-Smtp-Source: AGHT+IFvlW/ah6kWDfBcHFYYXr55CysRwEbfUr3QRjCo5LVB4YgyymXZrT5w2gw7Mkf7wu0S8QubUA==
X-Received: by 2002:a05:6808:448a:b0:3d9:2aa5:4077 with SMTP id
 5614622812f47-3dd3acb8acamr19360775b6e.5.1724139261491; 
 Tue, 20 Aug 2024 00:34:21 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b6356ca5sm8778141a12.71.2024.08.20.00.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 00:34:21 -0700 (PDT)
Message-ID: <d8bbf72d-29e5-465b-a8aa-508ed2960631@linaro.org>
Date: Tue, 20 Aug 2024 17:34:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char: suppress sunmouse events with no changes
To: Carl Hauser <chauser@pullman.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <cb338cdc-d09d-4513-ba16-5ff3f792bbfe@pullman.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cb338cdc-d09d-4513-ba16-5ff3f792bbfe@pullman.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/20/24 09:18, Carl Hauser wrote:
> @@ -959,6 +960,15 @@ static void sunmouse_event(void *opaque,
>       int ch;
> 
>       trace_escc_sunmouse_event(dx, dy, buttons_state);
> +
> +    /* Don't send duplicate events without motion */
> +    if (dx == 0 &&
> +        dy == 0 &&
> +        (s->sunmouse_prev_state ^ buttons_state) == 0) {

Were you intending to mask vs MOUSE_EVENT_*BUTTON?
Otherwise this is just plain equality.

> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
> index 5669a5b811..bc5ba4f564 100644
> --- a/include/hw/char/escc.h
> +++ b/include/hw/char/escc.h
> @@ -46,6 +46,7 @@ typedef struct ESCCChannelState {
>       uint8_t rx, tx;
>       QemuInputHandlerState *hs;
>       char *sunkbd_layout;
> +    int sunmouse_prev_state;

This adds new state that must be migrated.

While the patch is relatively simple, I do wonder if this code could be improved by 
converting away from the legacy mouse interface to qemu_input_handler_register. 
Especially if that might help avoid needing to add migration state that isn't "really" 
part of the device.

Mark?


r~

