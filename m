Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E149CE69E93
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 21:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDbH-0003Fx-Hx; Mon, 02 Dec 2024 16:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDbF-0003EO-Co
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:04:57 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDbD-0004JI-NH
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:04:57 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso2051381f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 13:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733173494; x=1733778294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b7pHA1ZzxA35HB89aNQKhK/RkVG2io8s/fOWi0XjtcQ=;
 b=k8JgItxv2I0fMvNcTqXDyJJdzU9qFErca8D/MDHA3pztGiZwLk26529nL6/4o34DX9
 oq1pmTBLLBtEJMOutNfySldOMRUvz0Ox5LYY359nJFIwHwpBiGElsqiMwPVE4pUgc7Iq
 Z2MpmHzquD1RLw32qOjqZRN4Uw03A9EPx1uqH7z+tSpChMf6UfSvMeECOuSnBxtvI988
 3tgZkeWJ+5ofcz1lX8m4O/LNYdlKTDtYJjiCryyqQbXlTXc7GeUkg9i6WaOFZ0aXW7/U
 OukXlR5r0hX180ms5UbDM8DGYG/K7IZPPHjeD9ozVJLKXuiz7GOyio888Ql9Yy+iwA1x
 C6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733173494; x=1733778294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b7pHA1ZzxA35HB89aNQKhK/RkVG2io8s/fOWi0XjtcQ=;
 b=gspcMFnjRlGEi5BghmZclGsRD58ZoJw7oWaqOhnxr5TJDSVnAQqJAWQEFTe8EFEL0i
 sbwR5o7RzHNCl2LFNRNsjUYxXChS9hs8zerKExewclkykHOPu9FuEKYp6Yy2Go2oYVNE
 0DuM4aliXuyu8KmZXRRUi/HLNVKmcTEXD4bUR3Mn+ObS7duKhcGrVuzdJsJIgqSu7rSM
 WRDTxOwOAF+OWGHgS3sU4xV9oWy7JPeoNP+zmZA4U9doLWBL8UqKx/7LcCo1Vevhpm6P
 QR459cl2hi8Kp945Ed6pGrgJZQVKScYe9VCtCzQ8KPnSq3jTyg8Da2x4SzLgWE5ONAr2
 VPJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrfm5IqNjA8EgVLOe71m8e2VkhZUrSh6887/1C3GFqibVcvLwsAT4yRKbNaSpZ5xoLKuwpAVKChkN3@nongnu.org
X-Gm-Message-State: AOJu0Yy15dI7hXsgIcAjc2ejg4pxxVsN3A849olwXY6Eq1+Mn22Ok8uf
 R632wvdz8xxF+94qUc8YaEfcStk5DxRK/jARUi6XUleGmA2qV8eRQMzPO2Xr2EpzKeMhA44Nzsc
 Bn4Q=
X-Gm-Gg: ASbGnctJ9KdXn6XcOGM7Au3FIDtgtN8gegzEUrixuzre6khpbyomEp+ASGcJelT84N+
 XU00sb6Jmv3vInkf3ozx9dlc6CNomLdNhh4CE4mJcLD+m81S6zK7kvstGMBAgPKvkljEiCH3bLk
 Lzh2mRXbLtTWY69rtDXs2THiSbHfoNmQcskRinZbqBMxdKC+y1SdBkgh5BwJwKvCHR6FLdkDGgv
 l4U0gjbli49OV0toRp3WOm76EEbmw0uZ9E7GiLa9b28+C7ADBQJjipLLSIt80tuIw==
X-Google-Smtp-Source: AGHT+IFJHhQgLJUelLNXKKUQ3HA7Di3OSJEGAxEy+oIAYzsJZdmDeV8NRJnBSh2a5dDgwnzgKbdEkg==
X-Received: by 2002:a05:6000:79e:b0:385:e429:e59a with SMTP id
 ffacd0b85a97d-385e429e74emr8527459f8f.25.1733173494018; 
 Mon, 02 Dec 2024 13:04:54 -0800 (PST)
Received: from [192.168.69.223] ([176.176.160.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385d7611af2sm12092866f8f.22.2024.12.02.13.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 13:04:52 -0800 (PST)
Message-ID: <d4c27234-6f39-4509-9352-4e3a33982d50@linaro.org>
Date: Mon, 2 Dec 2024 22:04:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/67] target/arm: Convert CRC32, CRC32C to decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-5-richard.henderson@linaro.org>
 <59d6b035-8be3-43bb-849d-5664bcd34795@linaro.org>
 <c626df3b-3994-4898-a97c-e4d4a45c6636@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c626df3b-3994-4898-a97c-e4d4a45c6636@linaro.org>
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

On 2/12/24 18:49, Richard Henderson wrote:
> On 12/2/24 08:01, Philippe Mathieu-Daudé wrote:
>>> -    if (!dc_isar_feature(aa64_crc32, s)
>>> -        || (sf == 1 && sz != 3)
>>> -        || (sf == 0 && sz == 3)) {
>>
>> We are not checking the sf bit anymore, is that intended?
> 
> Yes.
> 
>>> +CRC32           0 00 11010110 ..... 0100 00 ..... ..... @rrr_b
>>> +CRC32           0 00 11010110 ..... 0100 01 ..... ..... @rrr_h
>>> +CRC32           0 00 11010110 ..... 0100 10 ..... ..... @rrr_s
>>> +CRC32           1 00 11010110 ..... 0100 11 ..... ..... @rrr_d
>>> +
>>> +CRC32C          0 00 11010110 ..... 0101 00 ..... ..... @rrr_b
>>> +CRC32C          0 00 11010110 ..... 0101 01 ..... ..... @rrr_h
>>> +CRC32C          0 00 11010110 ..... 0101 10 ..... ..... @rrr_s
>>> +CRC32C          1 00 11010110 ..... 0101 11 ..... ..... @rrr_d
> 
> We are forcing sf (bit 31) to match sz (bits 10:11) in decode.

Oh, indeed :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


