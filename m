Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF4DC982D8
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Ppv-0008Fr-4e; Sun, 20 Sep 2026 18:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8Ppt-0008FI-UK
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:16:37 -0400
Received: from mail-pj2-x27.google.com ([2607:f8b0:4864:39::27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8Pps-0003kE-GG
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 18:16:37 -0400
Received: by mail-pj2-x27.google.com with SMTP id
 d9443c01a7336-2dd77300825so24343145ad.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 15:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789942595; x=1790547395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QPakDuR4CS3JS3cjDQ16PZUqEzhoMnxSYlBhFJLYSdc=;
 b=TR+pNcrDOnibOy6ctBnEXrNzKRwxkkV3x7iopBt99xbW234G+R7rLmiuXV9U5tswpl
 MwkGTa4tbIRFss0hEmm8Ej5RF+CinXGywr4QRTYkEPu+N+Lcu4IRZPQbAhmjeuOlVK+G
 hGtMtH7qXKARgMSBvzIa5M7lZTkCQPQkQJpj7BezJLD2Rg7GlaYBvuGGy4qAyBjI3xZs
 YFt+RGBWSASp+AZ45jUdnMz0kIkM907jb/Z15KkXg9EqvA3INgSKMFUm5f/FxmLzGJQe
 Gz9Pf5TJEZMgKHdL2+weN/CODida148+3minRo8cAtypi/wKWb0tiXs6c5LQK+RF5qU/
 HXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789942595; x=1790547395;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QPakDuR4CS3JS3cjDQ16PZUqEzhoMnxSYlBhFJLYSdc=;
 b=tFrMug104ii/KCHHN7Lp7H5YDoE9Fd1ECMFMCwEVeHqQ8xhZc8Yu4CVw2Mp0aL0r/5
 4Eg8Kv1O55Re1WyeUMzeqpq6EjQQpIVcnVL6DKLaNvFwCGADpkVWLmhVtxg8HVQ30c0i
 0WtKoOlMl1VISpcBBvrT/mpjhavXpptq3JGkejJy7NkymFJN8TAG5WuUs3wpePtksBTQ
 xdf3mV2huxu7A9Rug281YXJSBCg+xInilPtVX3wYhTsnfCl36pllQnHUFzLdjzM43+Q7
 Mvj2ayT6tBqt80BiskI4koB3KgHy6mul9mlt0qGDlmZnJ3/oXlscFBXqBlQUYEpl63N6
 HPjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5GyQoj1bdFQ17oYhlx6PrwVRtQJ2OaqhBwzULBKpmZU+SApPh1TEM3J3RDuAKt2tE9uQdI0af45/7@nongnu.org
X-Gm-Message-State: AFuF++lOgI9pFXMhZJ+XtL570Tb7+hSoB8xrcmfSNL7SU5gi2WL0ToW5
 a8J3WYCoiDzWOKhJf1kJoI79je3N06AJZOPwBMnIOELZmsc1a/d5gi2w1fdojbC18j8=
X-Gm-Gg: AYBFou0IgMQ/TCtl+LlBikd4ULn85szOXiczklaF7VFtMvjVUh4zJiN6nIv/gmxajFP
 NgUcgre86SqMO4lq0HIdq5XJOwNL5nY6g1HD9IajX7tvzINm8Od2o0msr3lMOW6uetMvkNUMxyB
 byQUtoa/Wr4tu7XTAXKvLmlh2YwO43pYW0Q8YEQbhJCs5EfqllhylUMQllLk1RZECI7sxo20GVC
 70KPuLfMvHWaTQkUf1rFfaqZZ6wgaSxwlMGkHx/2u/V/brhHIktK+oj0DGVkyIsm2uwNY6dbXvO
 tc1ZUMFdiinkJdhTnc2zniWVGH2OkO0nr8EwmP7qLwgWiIhbCQcjIhNKSUJCBXBldoV9Iaiv6Af
 D1azAVHJD/pELWSIIpdOt8vGoHqno/isCzeot45JaSaep0zabYnEADsZ6BlWIPgugghuZAImhvr
 V644uKQSnphXW2A8eSvuuUoDzOBoiJq8e9SK53UCfoN0SLpKXm8Cx3B59kKWz4XcM/ipkboV64V
 PUbF28iJDELZazGtxOKGc+E8WRTNWABwRY7JdmhufVoOeoOSNgbIx7jwvBlUxS4KnjqvNtZ
X-Received: by 2002:a17:902:fc85:b0:2dd:c100:a5d8 with SMTP id
 d9443c01a7336-2ddc100a697mr77270235ad.44.1789942595043; 
 Sun, 20 Sep 2026 15:16:35 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5f56:e854:5df2:d786?
 ([2603:800c:7900:ed00:5f56:e854:5df2:d786])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3313d907sm13753038eec.11.2026.09.20.15.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 15:16:34 -0700 (PDT)
Message-ID: <9c69a49b-abfd-4e1c-9083-97991b9410eb@linaro.org>
Date: Sun, 20 Sep 2026 12:14:36 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] bsd-user: Eliminate unused regs arg in
 load_elf_binary
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-11-ebfa61049bd7@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-11-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::27;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x27.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/19/26 19:20, Warner Losh wrote:
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsdload.c | 2 +-
>   bsd-user/elfload.c | 3 +--
>   bsd-user/qemu.h    | 3 +--
>   3 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

