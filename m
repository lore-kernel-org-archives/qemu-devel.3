Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8342BC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3qk-0000WY-S9; Mon, 03 Mar 2025 06:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3qb-0000KE-MF
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:20:37 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp3qZ-0006b4-P1
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:20:33 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bbd711eedso8584185e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741000829; x=1741605629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GCBhr7Rs84KJs9aNppVTQJy1q0Is9M04/EMErGDumZ4=;
 b=XHJR09rMJePkbmnCNlUTFlC9aZQ4dJH0w/PE+WAsY2BFAbzSRwEz3vDSIAfVpjfYjp
 Ns+V2zEwIL/JcoznyC1+x7AHf+omh5QPmQ6hSRDMdoLkUol8b18eywkIfwanqZR9hAUW
 wKg0Z1F5/P3e6E4NFfMuoLsuK7cv4BhPbdM6D8hq57Sjuevvaa34Kh+B7wfT+tURFGoz
 C0ystTM5NjD8MYKgzs6uyQDWWct+XiqGnjck8AKpdXnXrWr/L5VtLiYTR4tQLugBomtj
 3MoT+8rwBRCx3KHPofBzSCnOGWdxu74VJ4ycIVbW5hYl1YEEd+LF2shMkh1xzJKvP1p3
 LNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741000829; x=1741605629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GCBhr7Rs84KJs9aNppVTQJy1q0Is9M04/EMErGDumZ4=;
 b=AkXK1SEsKOTRP92hoV1nubn3iPIXfe1m8oviyF/XIV6NCeZX7SoK5HZ8AUuMe+jPpD
 /pUEVXjnjpXax0S4WE37VC2Johx0hYT6h439Z9ST3gGQk4K0w7CNTIietGOjMZkjHIwh
 ro3XexGoKq0iXEyvasyw77QYBVQ0Ghk3QBLB/w9bdV31ULTjccPRVehMpaqoi7+nKN3J
 uU9bp7KPuUN5Cb1RHKJtMxz7k+/Yawz9b/iGq+VInubp68OHzqG6sb1WTZ2VwTf1lCPX
 x4z/+mMWw1qKzp6FJhXaymY69CB+pNPFnK3X7DB6qNB+Devvsa8w/VeoX3pXKFBXHD8u
 XWIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIfOeOK2M76SLP4sqoviyMzCUXYhpVgKMQ0DkQZWNtcuvy4UTSIEFq/yMGqA5C68QBqqJWVsE414k6@nongnu.org
X-Gm-Message-State: AOJu0YwaB/Cs/j/PxikIWkuZu2k3u2OwQyIuKgftTKsODVkMEwQH6BT9
 ctoIkd9oqKpCFZKiRltg5KybG3sESis9WDZDL8lZK3I/UDUc/nw7uMzprfUvA+cjrzIEIQTUj0F
 MXaJNsQ==
X-Gm-Gg: ASbGnctYB83tDrr6hz9h9ymJkqi1NzTiaREr+g3ysPsuqwJMRsnnyWuKGqOcRtNfp6X
 BfKxApKYipuH5M3WHnvHCWFIb3yAZzsgchSIOgV/uvWsiQdvEvn5yBaWTWvZyqXZRXONs78q6lQ
 30Ev2wrQ7tP6nvYnxTZItfcaFvhrEDz/M25mUQJe2waH/NJcou7LGsu5J8XDLRUhatoY+/jM5kL
 4sVvZCF2LfhC7wUt2MHWUviisdjIs1NSpN/BGV2iMcIJ3zM+e9x4Qx4fVzwkIlPXePLWUm022nJ
 cU5zN8+2U11ALNpQXRo3dtW45OjkFRotA22kA/+nBosTepvKVraAXJ+zkwbbq+XVCuLPhMRxa2O
 5vbqps3MK7jED
X-Google-Smtp-Source: AGHT+IG4IA0EfgqevCU62fvz298RVfjH0GIP+oXuS7Q9/9bqgWeGwB+36gbsWcnsK+MHSssjPe14Yw==
X-Received: by 2002:a05:600c:3549:b0:439:91dd:cfaf with SMTP id
 5b1f17b1804b1-43ba66f9dc4mr108812895e9.18.1741000828761; 
 Mon, 03 Mar 2025 03:20:28 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc6a8ff01sm16230505e9.39.2025.03.03.03.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 03:20:28 -0800 (PST)
Message-ID: <b2049037-4324-4e8e-8c86-059b25995740@linaro.org>
Date: Mon, 3 Mar 2025 12:20:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/nvram/eeprom_at24c: Remove memset after g_malloc0
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1740839457.git.balaton@eik.bme.hu>
 <ff281851e6d824ecd01b8b5cd955328dae1515a0.1740839457.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ff281851e6d824ecd01b8b5cd955328dae1515a0.1740839457.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 1/3/25 15:35, BALATON Zoltan wrote:
> Calling memset to zero memory is not needed after g_malloc0 which
> already clears memory. These used to be in separate functions but
> after some patches the memset ended up after g_malloc0 and thus can be
> dropped.
> 
> Fixes: 4f2c6448c3 (hw/nvram/eeprom_at24c: Make reset behavior more like hardware)
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/nvram/eeprom_at24c.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


