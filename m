Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E9BF3D31C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBNx-0001Iz-UU; Thu, 05 Mar 2026 11:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyBNu-0001FV-Sb
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:17:10 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyBNs-0004sF-AU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:17:10 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-899ed41208fso94499586d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772727427; x=1773332227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lByb3b/EvMI1o9ZwzQIMiVAuzl2p739LeJrSqTT9irk=;
 b=M6KZDr8kOt+FUpBB2o1gByySXV7s1d90b+ih1Plxt2AL1RLdjfAQxtt/2oFPpKrG8m
 MFUnMeKzcl1yl+VZ/8vYViLTeboc76xLXh4S8C0wFcjnjZyjaK+LIhcokrcLryio17Bq
 5ShfoA1tjLM69XI6FSyDclSXmbhBIDc0S/LzsfCakmWrUO3N8QBApYu8Azj72uOvRx0R
 LbH8+mt8GTHHkzIY2Qcrl9ci6QBQ9mza8mOTjW9MaTDE14scSkqbkzLO8b5VuCCYrzGw
 dV5+cF2o5EcZZlTkJFgehlO9AyYXdCNPZcWq90PujtCUxPRyDgo4xaWQxZie3GWWMhT/
 x2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727427; x=1773332227;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lByb3b/EvMI1o9ZwzQIMiVAuzl2p739LeJrSqTT9irk=;
 b=N+n2F6TYFcHvFekXsJQgJ8d/ABfUMiXQaVVJ7w3rjIs4gPNPpDfuGkkCVcL2E5IQoT
 0cix7r9Q2V0cPqW2N5RG9ZS5o1AX/lJHwLS2DNa58cdBC6Yg27Z5wvXRUBUn3UpXooL0
 CRFgL0xNmCudMr9PCIVKjv4gHz4TprhRBClMUdPrx5tRNBUUcLqTD5n+OD8yg0qckpj3
 9MJ6Nrj9J3zOIisoHAjNTC2aMpX62jItOnGPmRRZ5soGdGtkg5t1BpIHav6AZ+e6QzCq
 nnKys9EyDZZeofObuXfUED7CuAtbe74/L63SggGjiBSyp333EOvsWc8Cf4f+G3diV+GQ
 fOhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEpcg0cfe+7P/F7aOCJY94BHtknS2bTeLGeiLrJ8kQEBjHmo5IIUjQvU0a8wj3YP29QNi44+VbUfTu@nongnu.org
X-Gm-Message-State: AOJu0YwgkimNFKQDDD/sF2eomY0pRPLGZ3PGqYyX5qm2PXNrBzU8EKU9
 kes22KLGoPzvTg07DAkx91uCS0AXsKZLi6qeTEiwOnJKwwZY9dZVb+Ti4milZdWaGfM=
X-Gm-Gg: ATEYQzz3yv+LgNmmrAoC6T+tR+h23egRQXEwsRGdRESfBMYVHmhzjCK43ZNMc313jIg
 PV/1WrpDx18P84iXXrN6iflhFAKQYWgM05fp5f1eC0XDUEvttq9jwtXOocX85+p0UMirMLNKhl7
 H47cSAGxsSALmJUhbAs1TJ+KXvwHqJ24HbQcsbel2AFht9XBFxM0vD5IpppcG/G3PgAiZjDUZ1/
 jR39+p+XCaqT/BrAvBapFBukVx7cn2JJqO1BqwN5oJNHErh4t+/7XhK3MUOWBet295eM0e0G8/4
 Cj3CXs2Bj9jQDW7IrL+AEDyfuW7jSPm8vCspuWou2cty6RjQviFCw5/In6Y5hLrCu9kGgL0OnIr
 7y5Lm6lFC+QkkHdXk4zIE5LaKUsr4hiSAgLSamAI+Mikwk12AyscWycsV7GwNd43YDbGK96XoWw
 AGLnxssXqjgwL8cgmVYAV+Imhm8xvxzlzqxcEQoAmg8qRsLzQ/jzW0GKXQj6sK/adb0cJe
X-Received: by 2002:a05:6214:ac1:b0:899:e9bf:3747 with SMTP id
 6a1803df08f44-89a19e41cc0mr87342416d6.53.1772727426936; 
 Thu, 05 Mar 2026 08:17:06 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899f8ad5b8asm122617646d6.0.2026.03.05.08.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 08:17:06 -0800 (PST)
Message-ID: <45ba39c5-ee1f-4aba-a962-bd25549f5242@linaro.org>
Date: Thu, 5 Mar 2026 08:17:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/tcg/plugins/mem: Correct hash iteration code in
 plugin_exit()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260305161531.1774895-1-peter.maydell@linaro.org>
 <20260305161531.1774895-3-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260305161531.1774895-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf2e.google.com
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

On 3/5/26 8:15 AM, Peter Maydell wrote:
> In plugin_exit() we call g_hash_table_get_values() to get a GList
> which we look at to print some information. This code has
> multiple issues:
>   * it names the local variable for the GList "count", which
>     shadows the "qemu_plugin_scoreboard *count". This isn't
>     incorrect, but it is unnecessarily confusing
>   * it doesn't free the list, and the leak sanitizer complains:
> 
>     Indirect leak of 2328 byte(s) in 97 object(s) allocated from:
>      #0 0x5589b0b72293 in malloc (/home/pm215/qemu/build/x86-tgt-san/qemu-system-i386+0x1a2f293) (BuildId: 26964cad9e3f81d35fc144d7cc88b53adf6f60c7)
>      #1 0x78fd8cfa1ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #2 0x78fd8cf96e4a in g_list_prepend (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x57e4a) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #3 0x78fd8cf8b318 in g_hash_table_get_values (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4c318) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #4 0x78fd84d1a90c in plugin_exit /home/pm215/qemu/build/x86-tgt-san/../../tests/tcg/plugins/mem.c:87:25
>   * in iterating through the list it updates "count", so by the
>     time we get to the end of the loop we no longer have a pointer
>     to the head of the list that we could use to free it
>   * it checks for the list being NULL twice (once in an if()
>     and once in the for() loop's "while" condition), which is
>     redundant
>   * it skips the loop if g_list_next(counts) is NULL, which means
>     it will wrongly skip the loop if the list has only one entry
> 
> Rewrite the iteration code to fix these problems.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I am assuming that not printing the region info when there is
> exactly one region is a mistake, but perhaps it is intentional?
> 
>   tests/tcg/plugins/mem.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

