Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB49D35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rec-0001aP-KC; Wed, 01 Apr 2026 05:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7reb-0001Xk-2N
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:14:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7reZ-00042k-Mv
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:14:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43b949bf4easo508501f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775034862; x=1775639662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wO4S3vlmnDAGFNUf2IwELu4YQVV+XZKVZkEBBDognAA=;
 b=xHy0eFzTCbXohOMS/fUZsk3dIgy8RGHY+9GfxhgDIVERcRPf/xGiubVW2LelZJOYtr
 3R3cWtsuziDJV4i4HmeUMCDl1QMuwqEimjx8URKq7G3EZOsoxUjFF5lJirO5y0TmysN+
 wfWImM4liz3b2gC1lbnZn2Qfl8BmgSHUHnE8Gks+k9GbAn9Aqx+WImv/g1hO1KVtyk5V
 W70iHwgJOAOQcB4EVpc/rJ+VMkL9S8nYQKUBU3dNBg2IFQBY97ZlvWeUIZFubIskCNSO
 0GDSK20g/i+843SqmRf9U7lIDkpZc5+njqrsDsUWOVR/8EfOz3mLee0+/RQ57KLQ0Oz8
 HdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775034862; x=1775639662;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wO4S3vlmnDAGFNUf2IwELu4YQVV+XZKVZkEBBDognAA=;
 b=BG3I5y6K/lk3pZ2IyiQAmHWMw9rihvKGyMi6N/EcdM4PEvjk3TLVtmE0WTUTNzWKMa
 k2TM5oj0a5zrCI9/yg6/K8Zjdz7yHMpIX/KANyaUaAPiBQWQhWpLEzmFDGqTmu4gEI9M
 0nzrqnRn+FHINVn8Fi7VH3gRqwi3+lQnxtR0HWq10A0dQbwpqMzUHot+1QgAJI2mSQkp
 B6R4TMlEU0yhvTHeu2DDs2ibNhToOkgMUQWi33CKaLoKyh676WG+ODZU5W/VcPZfmVGv
 iJV15P6PDjtCHI2w7KsTE9hEEoFdo2CzxviAgjW0nLipTXfDgSce9arLHSA1PX9wJ/rm
 798A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiuyOAOihGiwym3/ob0yw2OaMYiL3o06C/LROk3r3f1I96JGVFaVTFFpG4JRrg5z3vBDMX469vypGt@nongnu.org
X-Gm-Message-State: AOJu0Yw5UOki3HegxdMqIj/+ljLWTBO0lEkaH5tf28Xrba5H4Q3mh5P7
 3MYrUASUsT8rpugCTWWhz1PmF4uvmA6DNhvtfn4lzuuaalW5DoPifIwQDjd5SqanfBnr18nSXG1
 7+NI1YQU=
X-Gm-Gg: ATEYQzzaLZIL0FW+PyxSRQ6oTww5UOnIL5u3gu7blznupEHX1jvVTH/6L6FYnA8Rbm1
 bkLkXx/tbGoYXJhjf/qRi+tH8hHbkdmrHBY9XGc07bv7xhAx0N264Gky7XZaOUjhH/G05RW5AUG
 9R47RDjQAG4z7y05SxYaZ6Ug6HEm4mB+sf+8ZhGhCJSwuCGURjJ+17mvDJxU4m9rSOZIqNvaufR
 IxcVauL6mIH08ESoQggToDNQ99oU6yvnDPTo9uDgrF6a3o3ArqTL+omHt3W8bRrxFy7aelVeINe
 gXayoucPt0Xs6sSp6TxvzeF6r8Igb7/0THtzazOuuInBtUMYntSSf6SXzTPyZwjYXsLMwnCFlHM
 lhQCDZXkrpJcKvqoThkgrvLrWz5teSVbUiNu1NalXf+9MSNGnSXWqchU37XzYAMAD4uX/zyMgPb
 h6d/LwrIY/KfzRiofo5mFUeqjaUvNkblE46V/Uea7EcRJ/5VadkcllSw6qVjRnlefhsA==
X-Received: by 2002:a05:600c:8b77:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-488835bc362mr42688855e9.13.1775034861743; 
 Wed, 01 Apr 2026 02:14:21 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e7e96fcsm113229835e9.2.2026.04.01.02.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:14:21 -0700 (PDT)
Message-ID: <8393ef1b-f911-4a79-b6aa-d1a5749b5a56@linaro.org>
Date: Wed, 1 Apr 2026 11:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/60] ui/console-vc: console_refresh() -> vt100_refresh()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-21-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-21-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
> This decouples glyph rendering from the console object, continuing the
> QemuVT100 abstraction introduced in the previous commits.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

