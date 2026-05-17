Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC8ACD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 15:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOdf5-0000Rc-FU; Sun, 17 May 2026 11:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdf0-0000QX-1d
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:44:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOdey-0007LD-Iq
 for qemu-devel@nongnu.org; Sun, 17 May 2026 11:44:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso17499935e9.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779032647; x=1779637447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8cVzxk+YN7YKnlarLlhPpaw0x3QOtwR4VSG1m65wGpA=;
 b=lNOKmSMRAmaSnwLHN96pkoSBvmQy4mTxLzm5YyLbLIvoWZVDFTnxQU2mQtktOZYKbe
 LidhFZE7BLdAsJERvkJUn9zaUqDIVyU0kexKHm7TiwhYXQumTmNYd92BiaQILi9X8m3k
 xmvrMYGD7OJXcByhvYWsJBvZoRH22VdNPhl49YApHbTt1CNvX9QCDR/bi2p3UKEmgBqe
 tssXckUrXyEvuAmvYS3KADe6vNPXDPawXDmHtCwZtj+eTBvy7Jq8qracWo7sbFm5U8a4
 QYQe3ELqnhbHApAXoxlLo9sndeQ60vYsh0XfdjaNk+VIdO18nZYP2nkEzczzA7HNSXis
 pdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779032647; x=1779637447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8cVzxk+YN7YKnlarLlhPpaw0x3QOtwR4VSG1m65wGpA=;
 b=UXML6CE2/7sthQBrdPBOgF14u8XJwIZfqisO67wHo94A7k59FRCuASSW/EIqxHjHfW
 lAo8XAcGhea6LpWgG7WuEqvWoMQiUhl/rs+R7nANg9qpT0DaD0N2r6hbOnXC5yVzeDrH
 huDLwrBdaFyirokxCsAHoDfMMY99lnsOoD3ctF8nH6PdeJmyS1b25KrSlhH8u3J0vK6I
 UjbLProHAVLDOysqirfdZ0lasJq9Rr2XBx/XswH0ygFw3JdIPsPdeJKjxqzB188Vil/M
 Mox4axomz0ZuQVW5E9jmVHPkrXILXEKqzXc8vr+DhRWSC27TImnzvMo3YWyPHBK6eMg8
 JY7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BoUJ8xLCG0/NA0jByxlGOCS27EX4LEfDMd0KaDuN1m47sJtQBZrhNvxLFmGdLrKODndCpRNGSLWUw@nongnu.org
X-Gm-Message-State: AOJu0YyzoDyF9tYqWVzYJ0oPilgPln5LrTZ7HuaMl8HVJI4QVumuTVJr
 CDs7Jt3P7ut9qyT7TwiQU0b6Pzci/anTRONZyIbMJlL2XgJ2JiU6onex79GGSjwUnCs=
X-Gm-Gg: Acq92OFVwFVtBmCV10bIEXOddf7PTZ56/wv2OVvXk8fiLmmDeVZP/RZ6tTAEHvbRdCx
 GPY/BdrgX7Gq2VQiLPm5euhKLWO6xlE0U0Gk/ceUDxMXT+1/MSHKqyee4Vsv94F0YFbm6TJYTzE
 sESaFY6fXincI25ukJLBXorffvZ86JJW4Rg1/fpLbtcLG8gb/BRv7vyqnjxcZojxSydhyvGtzoU
 jbrsq+xcc9a8jZv81aLOQOgnDJpMZRbrX2dUuyjMUVBa32iSwiTVX19VixL8H61odlTRQTQxUKo
 k9KBJ87PrP/qcwEvZRUbxX7MDQzpLBuYhOoM9Fzs9pxQTDsXAKZrKZcgAEC8t48JZ8ILtesSEsd
 q0Gz0/yz6TAJo4Ga6z3J1wmTYIL9kvsBuwBpgHum7dqO+bZM/WOPGweQ5dtSEowTw4g0HJ0Xoy5
 62LF3lhwdu7BW2n4sGgdoldAA5HUYBpAKWTA7qlYwcpezIbiu3adocsfy07gB6uMwBhQ==
X-Received: by 2002:a05:600c:4e47:b0:48f:e1ac:c94f with SMTP id
 5b1f17b1804b1-48fe60eb0ebmr189903215e9.10.1779032646796; 
 Sun, 17 May 2026 08:44:06 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fffb9aac4sm137006855e9.9.2026.05.17.08.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 08:44:06 -0700 (PDT)
Message-ID: <c4a32cb9-ca87-4ae2-a6cc-5e0ad97de4e1@linaro.org>
Date: Sun, 17 May 2026 17:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 26/27] target/riscv: Pass address as uint64_t in
 cpu_set_exception_base()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-27-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260515180437.23620-27-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 15/5/26 20:04, Anton Johansson via qemu development wrote:
> The corresponding field CPUArchState::resetvec is uint64_t anyway, no
> need to use target_ulong.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 2 +-
>   target/riscv/cpu.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

