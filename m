Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43807D3515E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rhO-00041Y-OZ; Wed, 01 Apr 2026 05:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rhN-0003ww-E1
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:17:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rhL-0004M7-ID
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:17:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4887d4c6234so19213075e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035033; x=1775639833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MB73ZSDnZRB9JY5X17nOeUCVvqmZKtv0Fb5V3WcSBSc=;
 b=bSG/cjqK3nJAPmB8XTAYr14WG18+/w4EVqTqiisCMFUZF1WzTmqa9SWTN677xRkldN
 lg/Rx4tbe4cLJCiGObaFmlM4OE0L+YqkxcEnt0H07XHAkUWr3KYQY8rKUhKeiaPmQ2W6
 Dnifz3+i0qK3WaEBlRPPs2MuvKyAJjp/WqCfhDXZPU8hD0wsGyg3xLXVbDfkJm/X7CZY
 s1+ddxmixnW/in2ONlPb4MdSZZfO1lDwC46xr79Q3qFEa/0UfiEe14ViQyd5+9KMMLJR
 gli9LqKguLjGk45y1+93EGHIV1e6jcFbybmkdVwA0zMxzh0TgScdgWh8Mj4JoGb2MW1g
 GjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035033; x=1775639833;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MB73ZSDnZRB9JY5X17nOeUCVvqmZKtv0Fb5V3WcSBSc=;
 b=SDi89R/gH6Q844Y+xDq+v3gJmi38Hx8ZtWznO2417lfUotk82rgSkFbRond4rR54jf
 mZO8WHqXfmM/iE3iW2T+Mb5RVKdmgIJikQPdB8w7HMP7BNb3T8YYmavxRHpNHspNdJSk
 JILKQTEKDktMrfp//EyFckXQZnB7RprHmnj8qeXfx4s8dXNYjm9cI2V5eeLjaUSCc+8r
 dMP+MMjlQBL03GCe/bnfHnzNUmlb6MUvgeutXLWzH4qANwFkQdh5j+FEJBK9IJQyEcV0
 1ygRqmnBb28FsTREOTefrXmqMGQELR2nikgWxxi/v+PlPQkjE0NgALNSU4jOMDf65DO8
 YrbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR+iHpYCXaVGlHHMlDvWzu0vndUCqIkrcDZRGsK3FHaN2SkVn07HADo8QDlusCTBLcgRZsfG5uZPOY@nongnu.org
X-Gm-Message-State: AOJu0Yw9eUVTiiqdLPrhoZV/kOLgifURYMkOFnUHJPywjJ0eZpASi35W
 UQ+JCquoCy7A7as+AOOYeixVfDHLTDVHXJWq2Hnf2/+7C16qAGo2FGKhr3KAAqMEJgA=
X-Gm-Gg: ATEYQzzKvsc6ldRkYFsTDEUOvXbJytoXgvDRxTmbiqDcn2uYbigvXzn7u8fI/o+kuOR
 8JA+CcBKUGX4uUVNMDgEPRcFRaAb0lJIfthKzBfZNWPBk9AER8wgV938Tt7Kr33//szza+o0/p/
 RdD2aPbDRm9LIe80OeGJNl0Is9+l09AL5JEtvL4y7b5N8OqSia88JoD9m2NJLi/GCHaBTwMIw9q
 2hUFBpTSdrymc/HYfghUSHUjQnPTCKWkQgBMBUidkBR9BSPPO1UoyTcMIlPLhYUBRxfvmInQyWs
 K88h6gXtjPFTDCzbwyLXUsbrbNQCwxYHEWxuEXfGNxHvWvY+dvXe5S8L9bG0kRl0ygJS/qbcuZS
 eeB2t6UQly6XmUMF7wnvA4f2X4slEqthU9EkSd0YtoqLnRrzoNKUiIaC1XOTs/n6m4XwL9WawyO
 RJI4yVtoeMO2WWtgQz6v+Dw9lDPb1+lL7ZyhAz1qdo7dXYgDMVi5sLS0+uCAogjx1LNA==
X-Received: by 2002:a05:600c:5303:b0:485:34b3:8587 with SMTP id
 5b1f17b1804b1-48883562deamr44395135e9.10.1775035033226; 
 Wed, 01 Apr 2026 02:17:13 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c884c10sm36897265e9.19.2026.04.01.02.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:17:12 -0700 (PDT)
Message-ID: <90642606-419d-4217-8e8b-b6063d660a05@linaro.org>
Date: Wed, 1 Apr 2026 11:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/60] ui/console-vc: decouple VT100 display updates via
 function pointer
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-20-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-20-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> Replace direct dpy_gfx_update() calls from the VT100 emulation code
> with an indirect call through a new image_update function pointer in
> QemuVT100. This decouples the VT100 terminal emulation from the
> QEMU display layer, allowing different backends to provide their own
> image update implementation.
> 
> The QemuVT100 typedef is changed to a forward-declared struct so the
> function pointer signature can reference QemuVT100 itself.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)


>   static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
>   {
>       ChardevVC *vc = backend->u.vc.data;
> @@ -1205,6 +1220,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
>       }
>   
>       dpy_gfx_replace_surface(QEMU_CONSOLE(s), qemu_create_displaysurface(width, height));
> +    s->vt.image_update = text_console_image_update;

Isn't it better in qemu_text_console_init()?

>   
>       s->chr = chr;
>       drv->console = s;
> 


