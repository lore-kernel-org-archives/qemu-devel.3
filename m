Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25479CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHETf-0003Mb-Im; Thu, 15 Oct 2026 01:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHETd-0003Fx-48
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:58:05 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHETb-0003KO-De
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:58:04 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6de1ca1b05aso3213103eaf.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 22:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792043881; x=1792648681; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QUzUC7JdXl6CrHhZZ73NTDUvjd0hawpqFwqvMLWS/ro=;
 b=nZPg5+deWxvqjga3+4W3/hPq28h03eMM5uxiWIwIrmqzXZurqJgIHFpG7BciwnF0us
 bd7wxfZhLSNTGhqp8loMR3IN8E+A/c+nsst2mPro5O0ccmZjd6wYkWG2hfTY3F2qA31M
 4f1BAj3LRy7B1Vg1feAZhwRWp+gNM36UPBAU9ui1XPf+bWxGQYgPsM3R77NEJMNcCve0
 Lby7WwY1UNxnwejAUQEwXprfEq4csOzmjjLLZ5C+BB6VnbL3yp1FsxP+nlEULJyFbwEG
 JvDXFpZNM7MSxXZC4KZXwDfIvIqo2p6iAva2ii1XA+O/R0NjPA0vvheTcF+gl1SmrcjA
 KVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792043881; x=1792648681;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QUzUC7JdXl6CrHhZZ73NTDUvjd0hawpqFwqvMLWS/ro=;
 b=IWE6hoT4uo+rBv7yXA/JEkLi5AIvhpoisOZ6hvkXhYWFqVUDIaTzK2LpvkNlnADzx4
 HHWv/wCuPuESAi939GXgr0u9a+Oia6YCr89g8M1aH2MvaeWSTmNUhuuqXoqTQ3ND41oR
 FVRpaJtd1/VpwdDJ29Vhr/mIPZsZfZb7LsgL/1EtBLyF/6tck/8giyFgjzRBYHkVZorb
 ZVdp0d9LVzODe1FpaleihQfSBGYV/li56rVnRLvKuVHWJ3Ak4uSjrADPIiVrZOwgQEqD
 wAyCwdHKB2EHwUlyldwgJN0lD+CRASDX8bdV2udS4rn/5fqdN2HyOz8cuzuppZ+7mmbY
 lPuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByALmu58oEoCl/EItHtwPBwrWtYciRe+GxHzjb+/JnXvI3PTk3sSBpq/5wkzgj2aBL7pu/cC/Vruifo@nongnu.org
X-Gm-Message-State: AFq9FYKnKob5YPurpsx4fj22Ut4XVW234UdGoX6Lf8r6ikxZ1+RPyk7T
 gVO8bTV5vqAw+SMuKiKiTET9Eo0+ZDQ7w8E1kyvkmSIZITP6pZ029TKqBEcEufKKLLs=
X-Gm-Gg: AYBFou1g6rw0UiFUGAMAZhBBUwcobQcS+pkxRGtoB/zVnAQcWng5uX0Dp21oTTfrh6d
 Iw3CqiU6YShgm9DkDeYC3qj+WSesyT+1/8qeEbaFQyIcn84Y4Sw07Bi6diotowjHh+lzNtmfzNi
 szCKfgALccYvAbzfDgf+hZSpykN9VddnUiOvGiO8TkQnmw4RqnwGZZujEqt4+EkM4uGDZsw5DHR
 wPE/Aq+FDDQJcjY9SXOWGb9S/9+8BSCl9AFbF1e3lc3j3Q+pppuR89Wmerb72wkizpt8sne/EoU
 GalfR/s2n3xDQKOTimxKKOO818/PkjjDP90RN4o+dcmyFFJMhN5TDSLitl1ckbAE0yEk4ab/keO
 kfTqb6sKyUa7y2pBXwPY9ZLqlH98DW3iTSV8gehaqSItq5H9VbvJiZP6aU8Yk4kptb9LYZMjfBr
 7tC2ErjESzgpqya50iN2E29yP4LlSwu9Mpn8diOobqlD7ZIAK/vuJM1zH1FVysNuSKLujHiwN+b
 HkygilmTNRjME48VGayW9SymK68Habx/OEG4N8=
X-Received: by 2002:a05:6820:162a:b0:6f7:75ab:f969 with SMTP id
 006d021491bc7-6f775bb41f5mr7994451eaf.66.1792043881275; 
 Wed, 14 Oct 2026 22:58:01 -0700 (PDT)
Received: from [10.86.151.227] ([172.59.192.11])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6fba22b94e2sm4098071eaf.8.2026.10.14.22.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 22:58:00 -0700 (PDT)
Message-ID: <e4efaf34-e62e-4141-b652-934bec6da0ff@linaro.org>
Date: Thu, 15 Oct 2026 07:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 00/40] UI, Audio & Chardev fixes + Terminal Resize
 Support
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/13/26 15:22, Marc-André Lureau wrote:
> The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pr-v1
> 
> for you to fetch changes up to 919711cab29776f12209b375a4db251007c6d96e:
> 
>    chardev/char: fix use-after-free on mux creation failure (2026-10-13 17:22:49 +0400)
> 
> ----------------------------------------------------------------
> UI, Audio & Chardev fixes + Terminal Resize Support
> 
> Adds end-to-end support for propagating terminal size changes from the
> host to the guest. This includes a new CHR_EVENT_RESIZE chardev event,
> qemu_chr_resize() API, a chardev-window-size-changed QMP command,
> SIGWINCH handling, and wiring through mux/stdio/win-stdio chardevs,
> virtio-serial, virtio-console, GTK, and text console backends.
> 
> - collect ui, audio, chardev and display fixes
> 
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>

Applied, thanks.

r~

