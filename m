Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114E5E6BF30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 17:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlsRr-0002Y6-5t; Fri, 30 Jan 2026 12:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlsRl-0002Xp-1b
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 12:38:17 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlsRj-0000n9-Be
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 12:38:16 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81e8a9d521dso1366534b3a.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 09:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769794693; x=1770399493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJA5OpBpy4yzfAls2pTQGQg6WkhuLKumDAOPsaVWFJw=;
 b=PbKZ6w0FaXfJD7/xB3yLwmeMqNWHrCJlKnd9wntkiowkjFBY3LJdY04kba7aC/G2uA
 q8hHQ1tfvEfV081n4HRmtSVdjvZF4IPykhsFO1IJlV2h7hrbWfaMAzfhEj1u9TFYTniM
 UoXcYO8G5E81uwah2QCWRnRudW4sIcpxXeo42ZmyMXx4diiuEM6YfnN+nSuOG3aRSL37
 M8kZ+xqGyKHLqBdAg/oLhDmpJKVJ4RuQ+Muwql2pa8XDjKoBNtAKTYxnL6Ttp71gE5u6
 XGsp2rdP8XLuyCoPuqIeCWsg8tmd/wflHADxO+V643FBXPuUIBi0F3iGqlGjcav5OE6W
 A2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794693; x=1770399493;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJA5OpBpy4yzfAls2pTQGQg6WkhuLKumDAOPsaVWFJw=;
 b=FPPveDR1wpP6J4ARqmN76VitH2cFGFtJ/RCpCD415M/RRpEldsSzsU91hJ5IsHAuEU
 VyZIDm6SXRRvH6LVY99FkrC5Q/m0m1zfE6Zd5x3XmRDgrnCkieSmLZeliBybg9jc1wvO
 6j6G9ZO2p2EcZSQoHl9K4dKh/4oQJHoMy1nJ0PgncFiu+QZ8SYI5Lu7ofJWTh6DjTHUQ
 upHnhq330YJmXsfX5Ztg2u3Of5qqbbNErLPbIklml6jwQILPchU3eIi5IROWib1BPC4Y
 f3hZm5tlhcU2xCpgRpAwtGoX12Drydsg+cBjYBn4yfE89ZSAYqBHMN4b1IilvKl3nP1U
 /Z4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO0yz4l0CcKGkr502dP2npca9bzKE9jDIhPFvoooCW5GRRc5M0L//7pK7IcLFVWutSHr99GcuwYJx8@nongnu.org
X-Gm-Message-State: AOJu0YzJJHel7OedvuE1wuQ79cQpre6UbVQk5KikZ+J35TTdStjQlBB7
 sIRX47YrHngFuRbpOAg+TrfkMjGnQDanqaWok3CywqE5QYav6vnSI8CYGzisera3stE=
X-Gm-Gg: AZuq6aKjS9TP5sJMM21UifKwgAEVPqBORZBeNQZT7wFSjHlhHPZZN8UHNYdkfOaUBGy
 bxFA0ySimMBxnTlaQOP8nG1h+Wnum/xR3wXTCh9ZXPLi7jM9geNZQ2VvAA0RVyK5CYs3L5aO9/+
 gp1uupBHrFflZe9qm3zy/ueYGr/YH1mEgFLzEsa3n7rl6LPjRaH3dO6ErakZLjhAZxOLFLa3gpP
 OWf+YYc1YO4lkdedPGVLGtLfkrsY3bf2TigZbUVwbxRUNl/6WHgxaGHqbVO179qEIy1zxxfXTBx
 EjR/JDuf7yl5yj/Doo4MzpST/LtEa/DafNV95j1QBEeG/T9joyTzYZsxXLNN5jNtCMI3+9NMsuI
 BRA/es1yQy2SPQFZ59Wg/ri0ASiUZvNLXZufaF/MWCKSm+qJxhbpdVQR+aFSogYUJiEu65SwHCD
 AeIogwIo+SJ3XUOP4OItMTgD1bBjmJ+EZ856fxAphKYqsV8qo3ovt3lFvf
X-Received: by 2002:a05:6a21:4603:b0:347:6c59:c728 with SMTP id
 adf61e73a8af0-392dfffb9a3mr4059750637.8.1769794693496; 
 Fri, 30 Jan 2026 09:38:13 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642afc045dsm8216553a12.35.2026.01.30.09.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 09:38:13 -0800 (PST)
Message-ID: <b0493553-8c26-475d-98ba-fca17d1f9ea0@linaro.org>
Date: Fri, 30 Jan 2026 09:38:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs/devel: Mention enum typedefs forward-declaration
 is not allowed
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Will Hollins <whollins@google.com>, jpcottin@google.com, jansene@google.com
References: <20260130170417.43356-1-philmd@linaro.org>
 <20260130170417.43356-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260130170417.43356-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 1/30/26 9:04 AM, Philippe Mathieu-Daudé wrote:
> Do not allow enum typedef forward-declaration to comply with C99
> standard chapter §6.7.2.2 point 4:
> 
>    Each enumerated type shall be compatible with char, a signed
>    integer type, or an unsigned integer type. The choice of type
>    is implementation-defined, but shall be capable of representing
>    the values of all the members of the enumeration.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/devel/style.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 

Shall we modify checkpatch as well, to make sure it doesn't come back? 
It's easy to detect with a single line regexp.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

