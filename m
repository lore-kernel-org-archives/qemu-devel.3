Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9FBCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62yO-00055T-94; Tue, 07 Oct 2025 04:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62yK-00054B-8O
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:23:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62yE-0002ph-DF
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:22:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so46608275e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759825372; x=1760430172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ni65aq6eeMY8ZiyxYk/tUncMNYRfZ++SRJOaZbGZiF0=;
 b=IS0rXOUTk609hCA2O7IfaEhP/VW5r16mpZdEhsnWsoYJSz7B87gwc9Ty6b5w5YQs15
 +QMfxBQOh+uc6hqR8zyxGroTMVOSrMLcSvLeXd5utDQ4ZBSR7YVNUxrjIcCGMhAP3T12
 CixH91p1XRRcc9OcQk7tjykJ5ACPL21nJR/SBQ5l88NKkqw+nBa8iP2iPmpqiIwYp3ba
 GlEwUqwHNUB3DA9XLkcfpLPK/2gzk3ANKd/2g8xrojDZPZ4jeE1+DJTf6JJfs/TyMmOg
 K+aeFQF15FiulB9C8tf5Xi/g6tUB7DbYUlUaNEootLDBHDsdVUouU6688WuTCQbXFwcG
 blKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759825372; x=1760430172;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ni65aq6eeMY8ZiyxYk/tUncMNYRfZ++SRJOaZbGZiF0=;
 b=E2mGj9X5USpl1+3sqIsVtVuR5tN3+whj7YRIjyHDrJG8wUomM7IBGsunrZpOBbE1qX
 74+fWItMxnZqDV/glfMm7wPnia7HCNviwvgBP5yJHOs5TF7dIiaqwthIC7zYTKwZnGmk
 QfaKIZHrK4gh+JwgonX6TG7W/7+SGlf2PkzScp0dRGyIT3g9T9kgJXCdL4kL9ZvY0L4d
 wYNW5388HzOZcI6snh1AJOqVilOUk7F8+xaUrdGYgN9+eeWIIEBYaNA6cAZZcXdJoIFw
 hpCuSRGjHRLmD28/HQJOSc1clzbAqR449AKKL7GWXYXI8BXp45svvOWMD+eXdqS4beGO
 yBUQ==
X-Gm-Message-State: AOJu0YyN/mz5XKCLHWPhcg46u5ENtAUyRxfMeAr9dgY5nnm/D7UJzoNG
 6S+edOy3Ra6v4K+ck87+wJpaDcPXlSYU2c0/0rV0MXAvWFn6prpBEYCo66cUYfBG8AyEJViAsH5
 uPjsvb2u/7Q==
X-Gm-Gg: ASbGnctVsGGI3/jYiGLNYPSd99mIq0cyvajWgxuZciemVayWeg9gUNMwALbiPkOIfIO
 fo43bdoO6JDfbiv9wPZCXvrnlYfIHccGYGOuBMjAyHeYEn01BytfYSdyl5ug+vHKVvW/DnqEGZA
 kogUXEuDp/EpDxeu3dLo2M919OXPaO7BeTPCq3/D/yeV1rfh3NphXjcngKb9YW6+v+U5lU/GG3k
 zaCfjw3jt4Kr8lIwJ6CyZsuQ5w6EwD2co5goWeNFLUE8wMdMAq81/v3ebW/so9lygmbNOQNmk5/
 jHThL/X6AIBoef9B8gFvZCyLYEIlxLNzlUVKo4VW4fl/PyVwa0cTIbB2Gn0EZcwXSEvIRJhKahe
 LzPx7JXNIefd/3+V8xEkIgJzGbQBi/LdJscOlIlSPkNRg5+mc8fV0aouuvRD+RRo8CVuZ+x5sQf
 LJUvCW8MoK6f7wJ1zXZ4k/J1Rnd5gv
X-Google-Smtp-Source: AGHT+IHKenG9GKd9RBXUQUzux/3UMLjNWs+HIDpBafa8MA+Fes0tqNgPZmUkmL8RuU8WI6Zogn8Ngw==
X-Received: by 2002:a05:600c:1909:b0:46e:326e:4501 with SMTP id
 5b1f17b1804b1-46e7110aecfmr119029675e9.10.1759825372629; 
 Tue, 07 Oct 2025 01:22:52 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e58asm191484425e9.7.2025.10.07.01.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 01:22:51 -0700 (PDT)
Message-ID: <4b3d360c-b18c-4191-ae1e-1c745ca9d34e@linaro.org>
Date: Tue, 7 Oct 2025 10:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/openrisc: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT32()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Stafford Horne <shorne@gmail.com>
References: <20250925004855.59084-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925004855.59084-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 25/9/25 02:48, Philippe Mathieu-Daudé wrote:
> Both OpenRISCTLBEntry fields are of uint32_t type. Use the
> appropriate VMSTATE_UINT32() macro.
> 
> There is no functional change (the migration stream is not
> modified), because the OpenRISC targets are only built as 32-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/or1k-*
>    configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
>    configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/openrisc/machine.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued, thanks.

