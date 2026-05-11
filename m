Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FCECD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNkl-0006wi-1Z; Mon, 11 May 2026 06:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNki-0006of-DY
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:20:44 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNkg-0006aG-KR
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:20:44 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso300493f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778494841; x=1779099641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tmLrBdtBIQM7i1IDc8Gim+osakNjM9qPBV6yHh5N3EI=;
 b=zBb8kg8DYctZmuv70TNTuxO9uuh0o+c8Hahopysnpjhw9Yi8Jpc7smhmKbcwQSTtux
 cQUmsUPbf0NRLg9n8A0b5gbWhBadd7z4JBB1N0iKOVHHMACRquqHFAk72als7ed3C9Nm
 oUcvVtsy0cqT445hETC/QbBLuGU5bjgiGFEI8WuUTYdnFYTR62afaAutk4GC2mxYV+jA
 pULz7BEZ0VywWtPGrq9NM0IisNAN5fCZLE9YenLk7qFG47j1zzyKCdRa4A5ZdzmrlbOd
 g7LUzrlh8rlxnlhxLbn2mSaoWnZ1Liu/poMMRDL6SMLYTZj1VXyz7NxPmBmb7cYRSrdd
 SlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778494841; x=1779099641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tmLrBdtBIQM7i1IDc8Gim+osakNjM9qPBV6yHh5N3EI=;
 b=g+bJPAAs9n7tvqzWxYCEwrFfmhXIsUQOC+XfBtsTaKUBLtgDeWjoebEm5WoP+NI5c4
 /nYiyM1pmJ8IdG9AgAUymB0IfCMQoARToVZ6ixl8WOXS0bK7vC2UqykLp1hrnWcNu/ri
 lLcmpVXJKy3iY7UiM84/k8nm4KtFHPY4mV2f8yxrEPj+tu65slY6OkOtPzWknoYIXu+X
 7F60Mzk2X9t1MGJ/ZLzZ3bu5HtCnycEWIaKeNRflJHrQ5Huql5Dj92d6ay/Z6HUrHx0m
 fS9c6l9hurAWALqe0kh2ewTLR/ISo7O2oA8qydn4WCK0qxhKDgXkdptdeEjNIuttU/jW
 yOyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sfpPzgo/yGpYxZVIaVuXXsybGiv1SlLrfAxZ6Aw91AU0IB9ZRDcaa2JMM4rht4ipzrzZEe+s113q0@nongnu.org
X-Gm-Message-State: AOJu0YybYGYxlNU2v+88MLCdDANBgNK1Q9f2so+OYbcVqC+Rz3JnfbDe
 fJackPX4xXPh8Oi6qBOQcFUqoUDorD15EFt2xnuO1YiJDoCL8r0k44LFRdpc0WuaUd4=
X-Gm-Gg: Acq92OHLMGUTcQKx74602PoVcr5XVMezJrAmxtGgCKJq50mqpdDZ1rRCZ7SZk2tx7yq
 zv0lTylJVlJ8mR1mPbez+UO6sne7aRbyD25t2TnePwwvQssMJt+2v3JqaPP9oTP+MqbrW2n1QPa
 GLEf05w1n4ACbAz3y3d0e3Q9ddSsUkOkajOmobyyF3Cgh5ZtxcGpZBTTHdewiGrukBcF2jrUDQH
 HCXx1txRuDGYa3A6R3nyuM3GvM+gZfbQsGGtH8zvMTX+DVCzpmfBFRTjj3hS0S71rTUrzlcDBtT
 Rqa60Hnd/VC42bUkBLYnErGKO4VxbVnYq5dS1GvN4fNernUhbktSf1WxL45cOn60mvWs7qJcKgb
 WayYo50OX3G5dcvC4q0tTtNnfeq6B9mwDGj1hFWjdtF6by40oemIhE/us/2DI0rnUArrYqbR9lD
 +luZL82ekUjMJg/qQucClcOAZIO93wjAzIUIdIM7Esxgpr8VVTNt2egiovpGP+ww9lRdOZhMJDS
 rVs
X-Received: by 2002:a05:6000:26cf:b0:44e:902f:e341 with SMTP id
 ffacd0b85a97d-45462c342a3mr20830809f8f.20.1778494840789; 
 Mon, 11 May 2026 03:20:40 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c79fsm26001277f8f.15.2026.05.11.03.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:20:40 -0700 (PDT)
Message-ID: <aaa19d8b-bc79-42e8-9783-62d0912941f5@linaro.org>
Date: Mon, 11 May 2026 12:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/i2c: Add designware i2c controller
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 Joel Stanley <joel@jms.id.au>
References: <20260507120524.111056-1-npiggin@gmail.com>
 <20260507120524.111056-2-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507120524.111056-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 7/5/26 14:05, Nicholas Piggin wrote:
> From: Chris Rauer <crauer@google.com>
> 
> In the past this model has been submitted for use with the arm virt
> machine, however in this case it will be used by the upcoming
> Tenstorrent Atlantis RISC-V machine.
> 
> This is a re-submission of the model with Chris' permission, with a
> light touch of updates to make it build with qemu master.
> 
> Reviewed-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Chris Rauer <crauer@google.com>
> Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
> [jms: rebase and minor build fixes for class_init and reset callback]
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---


> diff --git a/roms/seabios-hppa b/roms/seabios-hppa
> index d9560852a3..1a8ada1fb7 160000
> --- a/roms/seabios-hppa
> +++ b/roms/seabios-hppa
> @@ -1 +1 @@
> -Subproject commit d9560852a34f156155b3777745baa0d96d553f22
> +Subproject commit 1a8ada1fb70643172e251aacbac673c9ecda99e9

Unrelated change ;) Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


