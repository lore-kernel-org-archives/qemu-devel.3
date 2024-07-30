Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9473BC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 06:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYgl9-0001O0-52; Tue, 30 Jul 2024 02:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYgl3-00014l-Td
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:54:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYgl2-0005RR-FO
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:54:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3687fb526b9so1888221f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722322491; x=1722927291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XiEk3ao15YVtRfpEP/OfkaZF+KYpCboS2otN2KssSf8=;
 b=XykJQib32BJfhwPtlERmpgkxXIpdnajlsYzsjK/ZGQbfgFjvJLY8Z6Q10TcV2hcHFY
 dVgNspkSrgEBxfni1YJss8cxGVGnnfEVPnk4+e6QcfWrfovHBHHAdh4prjjtfLNRFOeJ
 34hsjBW4ylST995I8LP8Jt8ryXV1KZ8VVa293aiXZtmdb1ejuzvTItzzEk01iOg6Ls/O
 cOe0lXgZqL2j56KPoExRenldJxkE9IZLuCNyUagBoJHzaeCejwPnaOaENpIYftJlj0Or
 p9MCGMFLgcAYRQpkU3p83S7BadYyezB0LH+cDhe6gMrYLMvGGYEQoT2g90i0uV/iWjOL
 PaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722322491; x=1722927291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XiEk3ao15YVtRfpEP/OfkaZF+KYpCboS2otN2KssSf8=;
 b=UrU0RMeVqj04qEHTW+tXX7iK/qQFYh+My1OJMrwSWYafzFIX9gp8bAQqdda74lzyai
 MeV8EX/HDZdejjYCQmz9N8UivvgAltOsxf59z0CcCg0dwUAE6UqkVWYLZWsrlzveMz/b
 orICnoO/x+WIM2+4tOfJeZWtlGCsiqK5gEk0AUYkdIwEAitI4va0O/Su5Ca41RdNP2tn
 T5ikZk/terYbtcfWS5Ru2GSx6okCi3HojizgOeoAp6gxjojd2Q7H+Y3sWqC9pgBsgfP3
 2bVBXUhZMtpq/j6Bh11oSmwCSW7Lf4KkmC8eOIULUGnZoFUyEe6YE0ty1mlYnOiBIwH9
 UZgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7WF3/wj38iSF0/iGjxTjP8tLgIxYIpPzpvO1u14MqHGAM9IbF6opQ5YfnO5iA64/ADDCN5/xwA6ps+85nlD3Kji6k33Y=
X-Gm-Message-State: AOJu0YxTabGG67mNjnK5nDqVAkSXY7r+x2KTysoJuwBBah3e82Iwnm/v
 U6zxgc/GjYNlhtgNpjrVNo2aLDlSN+h2QJWDit7HGFkHeUWMbeVGiKLtUSKH/cM=
X-Google-Smtp-Source: AGHT+IEt1mJa2PHObB02Dt2D+4zWZNyVZAx0vOKuqaerhbUQQAJJRqVcxEk/Pnf0fNpT9ZJd3XVSBw==
X-Received: by 2002:a5d:480f:0:b0:368:2f3d:ae6f with SMTP id
 ffacd0b85a97d-36b5cee984bmr5782456f8f.2.1722322490593; 
 Mon, 29 Jul 2024 23:54:50 -0700 (PDT)
Received: from [192.168.38.175] (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805730bdbsm204024685e9.5.2024.07.29.23.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 23:54:49 -0700 (PDT)
Message-ID: <32505268-0a17-4c95-b5d1-fd7c3debb6e2@linaro.org>
Date: Tue, 30 Jul 2024 08:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qemu-options.hx: correct formatting -smbios type=4
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240729204816.11905-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240729204816.11905-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 29/7/24 22:48, Heinrich Schuchardt wrote:
> processor-family and processor-id can be assigned independently.
> 
> Add missing brackets.
> 
> Fixes: b5831d79671c ("smbios: add processor-family option")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   qemu-options.hx | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



