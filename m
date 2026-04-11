Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B345DF3ED5C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 22:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBgn5-0003lU-Ao; Sat, 11 Apr 2026 18:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgn4-0003lJ-Is
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:26:58 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgn3-0004KN-40
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:26:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d7213b6ebso99942f8f.3
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775946415; x=1776551215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rI3e81KRJR+NbKrOU+fL1YrFiQ9FlYizv25LmKP7ON8=;
 b=js+2KCsb/Ac+9MQH81IZKicQOEFBmTiXXEVg0lvf//aMYTdxHmA1jJdGwlk60n8mae
 /mDiEALrVJ9YgyYmvn2vCpTf94GJnUtaZZKJTYq+hrXTryKMvNElEyTGGL06h8vKsdja
 niEKqAjDsSATbRVo/TSwlLAFzRP0hTG+4fvrXpnnhmeRYbifbhUvDm9K6LAJEgaJBneJ
 nfXeKFCtki73NAO95Pk6jVIoeEBvll5nLnoCvRjbSlqarPgbGNvCdae+MmfMcYjJLYfq
 kAKB7eFhwBNsFiK/Dkc3vgZizqB5xrIKEgpIU33jYxeUxWp7jaPHim1wpO8ND+p7YMha
 KoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775946415; x=1776551215;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rI3e81KRJR+NbKrOU+fL1YrFiQ9FlYizv25LmKP7ON8=;
 b=d2WKFw2XnQNtQPfAnuxnNTfJP2PQFNzjeO1qT/gW1EFUqP3fxp39M45Ccw7792q5HC
 SrrwoyDH1IemqPijAeM02lwMwR2ZqOq8RgCU7fpNM4VsL7L40jbI8kVPy+psUcKuj5Zs
 4qjs+mkJpElfqRO5P6I1cUrlMxak4rEK90OEb0vzQ2Fgl6yM4NcW8XNf5OsU3NSrzx40
 h5PSRCXfdkxlukRORoxDIKHNFxKBS8Zv9TDba/50Za9591nwIZD6GEbiQ24zVp4pwNEo
 UntQ1hcJ0byBIvs6vL4kNfmBMYOUy9Tv2zazLPBjJkkxAQJHCS1XcsuolIs/dcXtKvK0
 ukjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rnObMbD6z2uLTr+syYPakmWo4eLVNsErBy/lmkZIK5/ayFJlg6eLdi9YZswYTJ4Ns0limfzRilIxL@nongnu.org
X-Gm-Message-State: AOJu0Yxxl5DJs+oG2HFmXlGBdXCL29e7L4d8MbnxsB76AJN8D6GhAzLw
 PiEOIMRtS42IfU2lke7VMwTLC0e6OrNF7owkrGpB4kGOHh+O2i/U9Z1GzTaxIdsOszc=
X-Gm-Gg: AeBDieuoiTnIM/5x2eDQzIqhiOxdfCFigg32o29l+bcKnkOYExU53b23gHc74EVCJkQ
 koT2vJeUAoKzVo7RcgZhPMB8PYGwGLoMt6S39cGXi7T7Z+9OBgiInO9xcuoUgi6NfCb+ixdZoWQ
 oEy1Ag8aDM5A4ZBrfQ98ZPU6q2X1FgGZg6vLS5orffMdgi30zDBFhyuc54ZaDqiJdLb4fyMzF/s
 XZBNAa2FDAWy88wpd8iBaALqJ+eEo7aiQEESn9T6YSK+GRaZVNf3bY4i5lxnvq9wZ6w/GQUOv6g
 WduXG73lI/2vjCBmI3XN6qnLak8i5RFHeuNA7p4ZKdfzb3l6srz5vW6JrAXsOem+wd86zkMkgI8
 MUXCnLmb6aI9WNVLx1efSnPww/lCqVFyWUcZNCjwjW1YnHkVlZI8a645qFzHRE+rzOxyiAeDAhP
 qe0HQc9yEvQt1lS0K3Kcu+LHOCimKqLpSrFSMD28+UnnCIf+lvYawq1KtDmAZ5ELFbww==
X-Received: by 2002:a05:6000:1847:b0:43b:4f0c:aefd with SMTP id
 ffacd0b85a97d-43d642b9e05mr11090047f8f.23.1775946414918; 
 Sat, 11 Apr 2026 15:26:54 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50200sm19098287f8f.29.2026.04.11.15.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 15:26:54 -0700 (PDT)
Message-ID: <8fded74a-b72e-47f8-a298-07f78218ed27@linaro.org>
Date: Sun, 12 Apr 2026 00:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 43/67] ui/keymaps: introduce kbd_layout_free()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-43-231416f76dc3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410-qemu-vnc-v2-43-231416f76dc3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 10/4/26 21:19, Marc-André Lureau wrote:
> Enable callers to properly tear down keyboard layouts.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/keymaps.h |  1 +
>   ui/keymaps.c | 13 ++++++++++---
>   2 files changed, 11 insertions(+), 3 deletions(-)


> diff --git a/ui/keymaps.c b/ui/keymaps.c
> index 2359dbfe7e6..d1b3f43dc8a 100644
> --- a/ui/keymaps.c
> +++ b/ui/keymaps.c
> @@ -178,6 +178,14 @@ out:
>       return ret;
>   }
>   
> +void kbd_layout_free(kbd_layout_t *k)
> +{
> +    if (!k) {
> +        return;
> +    }
> +    g_hash_table_unref(k->hash);
> +    g_free(k);
> +}
>   
>   kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
>                                      const char *language, Error **errp)

Worth renaming kbd_layout_new/init?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


