Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69888C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIGW-0003mZ-9b; Mon, 15 Jul 2024 05:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIGG-00036S-GJ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:44:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIGA-0005Rz-0L
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:44:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3678f36f154so2388221f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721036680; x=1721641480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=voOsnZmg1bnOTOj8efHaXA/kRvba9LY5vB88tFa2EpU=;
 b=BVLS/g0wbYZrHZZjG9i09qEVjm53soPIpRUSLlPl1yGgVVBHjTHhGgvqek1oOqaKFe
 vtPk5AVVWgr+l++kYo/J8e8oHjwQQMgbfk7u0ReaRZFdbN7uk6mj5Tr2sj9iU/VCMWNQ
 UYfSe0umIUUOnfmuM8jeDXgsR0Hqj3ae91RnqpGJ3DxVWsOQzoiSN78e4ugDYVINIM5P
 d+s8XVrlm+TekvRXXfP8UiR1MO3b5Mb0XK/WFfa5YI3cPCz/op8ancbs2a4Ii9zbA0OO
 U7igQCIJ5oZ/jHKKfhh1eb5UnUwtFvfD8kqRbe4yiPbGOBb+IjJJTxvmpgMcvlf4fRHS
 T5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721036680; x=1721641480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=voOsnZmg1bnOTOj8efHaXA/kRvba9LY5vB88tFa2EpU=;
 b=g+xyzeTDesN8ihZBelPL7rJyZAg+f4WPbLH1MmVidyfOzGzg4clTbo8rIiNJxudhpJ
 9ohBhjh4WotkoVofDFIkSr5sCrXekbNkSVxWRH5q1e3U+VCBOdlzjF6meJ0gIBg37Da7
 7MI2o+XrqH7JPXiuNFqmi8L4usf96ju5VLCzMmt61rTTsPrg0Lu6q4U/AsmN8KEubh2K
 4ziDdGnfRnC6/S68qrEROR5KcoR9zkKCqTSYuniIIfzOVzEJeI4pezvuJrdPPfFviz57
 1iLX2ccw5IkfPzP92GYT9Jyialc2hKDjvIRWict/K1nDtDuoHso0/2bYtSlHLTmsZ07A
 VohA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8B3SYQO/Oy30UeDEW620tivB2mbd33dQ+b/qH7zfDeILIVB3pYhg2bGuekoJ3GLka4InbJ/ZYKG9d1pDA2n/xszCFbAU=
X-Gm-Message-State: AOJu0YwnOTJ9VigsKzvJ+qetbBgsJZ3xbygApEDBVKsPBp8el3Q3Xze5
 8VzjCMhR8o+apR/v/R6lQjo6sZSl8qOk9Is/u4S8di3Dq9k+IYnDLrDZ3z5vHAk=
X-Google-Smtp-Source: AGHT+IGMuA8a3NNS+Y3b1tSyeFyuvbw5A6fnVnlhZlcJttcgLT/zgAkmHRj13smLnXiKZBNs3qXe8Q==
X-Received: by 2002:a5d:47a9:0:b0:366:e7e2:13c8 with SMTP id
 ffacd0b85a97d-367cea46a0bmr15484668f8f.11.1721036680377; 
 Mon, 15 Jul 2024 02:44:40 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccac2sm5791658f8f.56.2024.07.15.02.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 02:44:39 -0700 (PDT)
Message-ID: <5441aecd-0080-4528-a356-62318cb7704e@linaro.org>
Date: Mon, 15 Jul 2024 11:44:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hw/usb/u2f-passthru: Get rid of qemu_open_old()
To: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-4-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715082155.28771-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 15/7/24 10:21, Zhao Liu wrote:
> For qemu_open_old(), osdep.h said:
> 
>> Don't introduce new usage of this function, prefer the following
>> qemu_open/qemu_create that take an "Error **errp".
> 
> So replace qemu_open_old() with qemu_open().
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/usb/u2f-passthru.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


