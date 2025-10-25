Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78490CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vChJ0-0006qb-TP; Sat, 25 Oct 2025 12:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vChJ0-0006qT-Ck
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:39:50 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vChIy-0007UP-Br
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:39:49 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b5e19810703so494211466b.2
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761410385; x=1762015185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B8DaJI68J2oCfpKfO1vb/9weD2ULKg1WhGnNMq0n5u8=;
 b=grmC4TkIqbBvBD+M3P3+zEJkjyb5gwwPWkVo+pAhWDIU7knwBqXjHmBqu2ABkBS9zV
 3FO9TLVZffHZavkegjnRVt8lcwCzPocTOe99pVYxrnNASm9nSEKZa20gPSEwDlk2mc8R
 rAk9oRjeEGykySIA7k0qprRjL+Y5+MINh8/w60Kcn/bo3oP42pp8BG8XQ1fmFWZJukYl
 f0Z/EE9Oo3XvRdxscaWBCusA53Z+fOMUQzvpdoGbbE8NIl8dUIZhDB8c8eXNZe9SLhtW
 zjJOZ6yLG/i25ivy08djsWR9+/xx6R8UJ4zqEMZbMTYdDz0ACm+vFUTUPRSp8NZQCrAD
 kkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761410385; x=1762015185;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8DaJI68J2oCfpKfO1vb/9weD2ULKg1WhGnNMq0n5u8=;
 b=rNUnmk9TKzQZhbH2xGEJGIiuUijL+fHNhzCnGv33Yp7nc2PG5TM3xS09RXmjEDxCzX
 ylyLjZzkUL6t4Fq4+CUue/E0/kEBFahHcak/zKl7zkylkxU/oR5UmscvB/Xzdu0J9i+l
 s73vnRR5/PVRrjzXA7wd4TwUVQk7BOZCek4AXZr/ALO7BrBbsauJJtRqVyb019wDrRhy
 5QG1/FBabJgcbPuoPYUcWe3EVL221XfL2v3zjQKjT+5pJGS4smlYkVEyK56YkjlG9ClK
 C8lO7T9IyjSOQ1f8DXyW6qVrjNhgzvk8fScpNC6uX27MLmcpC7wI1p1hqR03vvq+VksN
 oK8w==
X-Gm-Message-State: AOJu0YwiMGqm/ngrZ+uKk4wtv7Tmx5DZ4DPKX4xb4UlYX7jgMgXxgU8Y
 skHGL0hehAgEJzZbI0AnHRqPUZisaqr6FSr6RVappDHIuedgqjjVEjg6m1+MG/Ud220sFR9RTeb
 dyXSevZQ=
X-Gm-Gg: ASbGncueM44wo+X8vVqdpKJhxUHcOmt/fxgE2GqKU5qR4xG2Pz5h192zyH0WCK0UYgZ
 QdOZZCg4m3JPE0C4qnTTQraG84gOogH5zvCN2VdlGJ7EMqLKFmfCvWzFl9daYKcFm1BoHoM2XRR
 VQEpcldj4dddJEDzZ7yRz827rB+j6ul4g635ptrf97TWJHksrEV/ydmqZvQYiIzZiHRd2Lv3BLL
 U8CkkSnNHaqeczRMjgGXfj9c3Kj8+dm9n5awFLYYC0DG7y4MqnQULEQBLwTxFbbbljdjtJjTM9n
 6tEFTh/oL1a5KCVgVG2aGwHS158ouC5IBKpJ8ccY8JTjBh/nyY0bY9JaxJNhlILkzd2nF8VrS0U
 x+fxeZcGlBriyaLSM9fi3vyaCuTGzKB6na5I6/kShe4CT7ch8AhIwWzuJq+CfN6rSvcxMAwjbip
 3t/fDi1CS+N9zPXjUqjjXX1FQfO0j5449Bwg4x7cBcFKQ1CxpefNe9tAIVb7ku+2X+xmYpwEKRZ
 Qlcbqgf5tNB
X-Google-Smtp-Source: AGHT+IFk5KwU44t/1ZJShGvxd2kpatViF0ClDfW6+GvZsk+9zPBlfgyPE3bbPIB9EoLB5xnimoQIkQ==
X-Received: by 2002:a17:907:3f21:b0:b6d:6ef8:35b with SMTP id
 a640c23a62f3a-b6d6ef8087cmr749912666b.16.1761410384738; 
 Sat, 25 Oct 2025 09:39:44 -0700 (PDT)
Received: from [10.240.88.227] (ip-037-024-071-028.um08.pools.vodafone-ip.de.
 [37.24.71.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85445e75sm235656766b.66.2025.10.25.09.39.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 09:39:44 -0700 (PDT)
Message-ID: <8a9760aa-4f5a-4c3d-b52d-9fb886f201e2@linaro.org>
Date: Sat, 25 Oct 2025 18:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/13] Next crypto & I/O patches
To: qemu-devel@nongnu.org
References: <20251024154024.227978-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251024154024.227978-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
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

On 10/24/25 17:40, Daniel P. Berrangé wrote:
> The following changes since commit e8779f3d1509cd07620c6166a9a280376e01ff2f:
> 
>    Merge tag 'pull-riscv-to-apply-20251024' ofhttps://github.com/alistair23/qemu into staging (2025-10-24 10:53:02 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/next-pr-pull-request
> 
> for you to fetch changes up to 3b3257b00fd256b8704db13373f4fa9c8bc40342:
> 
>    crypto: switch to newer gnutls API for distinguished name (2025-10-24 16:36:48 +0100)
> 
> ----------------------------------------------------------------
> Merge misc, crypto and I/O subsystems changes
> 
>   * Fix use after free in websocket handshake (CVE-2025-11234)
>   * Improved stack traces fatal errors/aborts raised for
>     user creatable objects
>   * Stop requiring 'key encipherment' usage in x509 certs
>   * Only sanity check CA certs needed in the chain of trust
>   * Allow intermediate CA certs to be present in client/server
>     cert file
>   * Fix regression propagating errors in premature shutdown
>     of TLS connections

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

