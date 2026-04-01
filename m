Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6843D35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rxg-0003Gm-35; Wed, 01 Apr 2026 05:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rxc-0003EB-6C
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:34:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rxa-0006gV-O6
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:34:03 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so79890825e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036041; x=1775640841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L2omJN5FKxWYO5yZ3qFqVysY+L3oBX58CZZ1zCqmtk0=;
 b=eBHNF2kyKg+RvV2soUJ5o/j1Qi0AOvxRr2ndb+/FqD6diTvYzDQMUqwKB93MdFVRL7
 RsIk9gN8Sj3PuWd+ts/tlvMseogiGuSAnpToayKdsRpl2HJIGARBzM3u2tJwClfpkLM5
 bAhtDgVNFUon4eH28yRQdta21BWrXWV1HDfkgqWiYIukfulMgoeV9rQD0lnshgoKCo6m
 kko7PfM6/KrfNmgKRKPzLBMf8aO/LA/P3oaSshez2tD5JgbnSBIPmV6pxK0wP0fyvf4Z
 3DzwkLC3KhlhkV40JIsh4jEHfELdqzDwLRmH/7U7+pi37Y6LDXw0fkE1ldZ6KX4IRlYM
 LKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036041; x=1775640841;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L2omJN5FKxWYO5yZ3qFqVysY+L3oBX58CZZ1zCqmtk0=;
 b=BCwaHFghwJb1B2p82pmHN7w/LQ7ewPKlq93zZgiKEq4iZpnVdUdHtIPovQMPMxL1vv
 esWBkmacz9GbtkDlocaLlLP8oNjdia1FMOLtXEMyD0k0Y5/DGmC7laA9yjnwjZyozDj3
 gz8FEXJvyv+TM6LhK8zeW3avjHAvYaTh3T+AFgXDR9Dd+qQC9TdWbrd9b75K9PUHYxLs
 kzTAVvPiPeZq5De2wKqEm8v6ui1pRsKWXpaIuV2ZC7VoTg1qZnrponoUaCbI76OjuO2t
 pXQrCjphnanDSzRc8GNWzEl8l0kx3wUp7y9DKHJ7qSAvMVY0ztJuM+984SHrY9NFE5/o
 pWGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2ZEdGMjdp996CDZyK/yToXR5qQAqsV3jLTGzNkGZC9/KK77AcL2iDuUTjcv7KemkfIVanx3zt9xqc@nongnu.org
X-Gm-Message-State: AOJu0YyGDKOpqeINvWNm65Gp1EP4G8zn48gdUg0EiKk71KLpoNpvo1Px
 0Ks98GPrFjje6K8z0P1X0VXRPHZ6gky0uLZ6GARgHXOtN5/Xq8vj+tTcRzb6EMJPrng=
X-Gm-Gg: ATEYQzwbqKhlYXFX0Zm9uw4kej+DEYo0n4P/uv0/6df7a6DVcGWuJklaw381OpftO1H
 w6F0DxiD8HgIq2gPqCwV0fNQfh8cmgyW+hJ7V8MwkazA52s+EV3ng1aD64Q7ziCfEFlB8ndXIfE
 EbHrVSXj1ZZLzAabZW19MOJyPbqKBYyO47nQXtO4Ec/8M3ZfP/7ALnM/KwBP0FOBTG9LuRNTgiL
 FmU9lEYQUbV759lje57P6pYew+jcreGyxblqX+VYfy44LQPril2R1tAnM9dVph4Fklo6qHBQYxG
 6l8ZuP5HB2m8+v9MqjsyF5Wfabp3RNjHbmq1tWUI1YxNuJ0kIJ5YS/skFbX+1jfgxVZ7CemzAad
 l/KD/GkemzCXpFU/Yem978stkt3fRfElVLiyTcbh98nIPQRrud9MAZqr23UfDE5fxfMWPVPGqe+
 tuQq8goGRIu0JCG96xuaNHXV9ZEBVqFN5bVuio+knNgAvzj/iNVnAzHVjPVA1gqe0lIQ==
X-Received: by 2002:a05:600c:3e14:b0:486:fe45:483 with SMTP id
 5b1f17b1804b1-488835b30b3mr46317755e9.22.1775036040926; 
 Wed, 01 Apr 2026 02:34:00 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e93cf2dsm94967915e9.11.2026.04.01.02.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:34:00 -0700 (PDT)
Message-ID: <06330740-78d7-4277-8533-6955523fd066@linaro.org>
Date: Wed, 1 Apr 2026 11:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/60] ui/vnc: assert preconditions instead of silently
 returning
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-42-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-42-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
> Replace defensive NULL guards with assert() in vnc_display_close()
> and vnc_display_open(). These are internal functions whose callers
> guarantee non-NULL arguments, so a NULL value would indicate a
> programming error rather than a runtime condition.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

