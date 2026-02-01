Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB060E65286
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 14:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmYe3-0002VG-Bx; Sun, 01 Feb 2026 09:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmYdv-0002UR-O7
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:41:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmYdu-000159-8j
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:41:39 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so26331285e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769956895; x=1770561695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A6WUHaWmQUnLYDIquEhb/uIJH0KDes8AY/SlsD96FEE=;
 b=kmnyaQv0+YGI3tuTJyjImC3hsKM7Tuv7SMqhWYtYc8TH3FIH1oOL2wwPXJsCM5CnF3
 FISfiw7vkgPhL8DBrw3so8f0zKejmJ6qSDqRocn/K44hwtCPBL8jnYjO30Md33YobP+/
 oSN1RDWo6MjpTTZK6ScibLBPmgI5wmDeJQOSwqkyelcV9J11ar+EaFxDBvIEJmC7PWeF
 uZoEhnY8VaJ6NCQiT1RyyudPOEjvFh1WSbk7lLLeq0pUnwN23YQSr+kFTOaZfMOsuyUw
 blmAOpcnIoDwBbLiXUm/4maZxJXVGMPTbzPuFJTu73vbLBLgky9eEtVWHV5Q0g1Um27Q
 W9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769956895; x=1770561695;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A6WUHaWmQUnLYDIquEhb/uIJH0KDes8AY/SlsD96FEE=;
 b=eht/LdWbJNhY//VVtoUbqh4u/0xW3mhF0/9AlZ7c+MKAPlmAxhavx9zttuIJkK26Lz
 OfRGRh7A+jcUwizLOJqS6FEy//e9H2JGfwTYPPPNHblGPhD+RtmR5GwsRlKLGk16im/p
 Aua3pVe5qoXGslmGGJ42lu69BxT4SL+inisom9debyxaaTMtkRP8Ntw66dgpylFG53K0
 UNn8BzjWuA0kcg5iEf2xarocsCipPa4ZheWv+46cjBPNN6uwVsPMlXI3Z+XtfKE8f9K8
 UefMxtaa9wikH/HbRkhNskT9p1lBmPikPkoh42T5JWMv7KIes9GTKA5EcCKaJezhfAmG
 nqFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcoO0ll5O3QHr7IykwnHQclOgw9g4MpG7eigTGa2OhFakzEW9YkZxNyELFW0VJvuL5O7gZj21e/Nj8@nongnu.org
X-Gm-Message-State: AOJu0YzYne7woVYkhJggctCCvM/aAjqPpOwS6cKDi+yIfgEjpazESCLz
 d7TPfEaz5vmMAjCCfJ3wUfimXFWGYXpBhOu6ksx3EB97qjSrXEVD11cuqWrOarbEfovWCxp5m1L
 tBnd/IDk=
X-Gm-Gg: AZuq6aJK7CfvrMo3Z+Sn1MYHs42v9ERBEdjkf0qZQ6sMLM3rl9JfwwIGBmgZHIea9JZ
 YaXHZ2ZwGtJniKbP7KROMI+cBdTJ+dKhIf0Gnb+B4N915gYRKxa5zD1OdbdXUE6m2riIpl3a18h
 33Be8S00OyNM67S/Bwj/yn3HLhBJzJg41stL1JQGlrR08VlV3mw05jeSrsX/BDb/s5R4h7515L0
 0JwEVJKLxcqDFAJjgDOg303wh1tM/wf0s7RBfUZmcVv7HcY16tMo20em9k/Ta7QHfOOcmlgcJ+d
 X6x/S93UkhcWSx7FRVcqzNdVW9M9J1PC2P4ct+ZEtd2YzLTnfYFkzlK/T8/9/3BhCw6aIvEqek3
 gtV/CCKl9GCHrQc0h34TgRqX//WFL1mRgkfD70Z30lmqceeUF4yr3Fu/YWoU8xMB2HqTzEgfhzj
 oj74lzOGzSUwdY7qZCkXonRKiTfJZZc9EhfcwQnFaB8xpiebiV1SAEn5JPRuaQo2Ge
X-Received: by 2002:a05:600c:4750:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-482db447b7emr109620515e9.3.1769956895080; 
 Sun, 01 Feb 2026 06:41:35 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e135422csm38702893f8f.40.2026.02.01.06.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 06:41:34 -0800 (PST)
Message-ID: <623cc137-97d3-438a-80b1-427b4270848b@linaro.org>
Date: Sun, 1 Feb 2026 15:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about tb_flush()
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Warner,

On 31/1/26 01:08, Warner Losh wrote:
> OK. I've updated bsd-user fork from last year to yesterday. I had one 
> question.
> 
> I see that we've gone from tb_flush() to queue_tb_flush(). Why was that?

This fixed a race where a vCPU kept a ref to a flushed TB.

> And is it a drop in?
> FreeBSD's fork has this in the thread creation:
> 
>      /*
>       * If this is our first additional thread, we need to ensure we
>       * generate code for parallel execution and flush old translations.
>       * Do this now so that the copy gets CF_PARALLEL too.
>       */
>      if (!(cpu->tcg_cflags & CF_PARALLEL)) {
>          cpu->tcg_cflags |= CF_PARALLEL;
>          tb_flush(cpu);
>      }
> 
> I think the right thing to do is to just change this to 
> queue_tb_flush(cpu), and that compiles. I'd like to get some 
> confirmation, though. Did I parse the changes right?

You should change these 4 lines by:

     begin_parallel_context(cpu);

which calls tb_flush__exclusive_or_serial(), itself described as:

  * Used to flush all the translation blocks in the system.  Mostly this
  * is used to empty the code generation buffer after it is full.
  * Sometimes it is used when it is simpler to flush everything than work
  * out which individual translations are now invalid.
  *
  * Must be called from an exclusive or serial context, e.g.
  * start_exclusive, vm_stop, or when there is only one vcpu.  Note that
  * start_exclusive cannot be called from within the cpu run loop, so
  * this cannot be called from within target code.

See equivalent commit 430014bee7a ("linux-user: Split out
begin_parallel_context").

> 
> Everything else is mundane changes that were more annoying than difficult :)

This is reassuring :)

> 
> Warner
> 
> 
> 


