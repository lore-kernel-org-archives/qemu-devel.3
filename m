Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C2CCD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgUc-0001Cr-2q; Wed, 20 May 2026 08:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgUZ-0001CH-DV
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:57:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgUX-0005UP-Rx
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:57:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso33559235e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779281860; x=1779886660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pWuNbzmVAeKu9X/6BOYVhCLAmYo4BzOwAgml6T0nJLE=;
 b=W+TeAScClQzd8nOLTNaI+Qu0N7Kn+0I1kKE5wsZwDBe5OF1itZhwzzIlaL35KCZyve
 J1WIehsfzMxI60CE8592F4f9o4Xw8fW0bl84LY/Fz7f06gvrovpVL1K0oY2PJZfoS1AJ
 v1HsCzhiCLDLkCqEy6oMf7nQo2Tc3qGvY2EY/877cu8yBMwKflxMPZZ5Obcf9JG7U/Mh
 LbSO1BkEDvhgt/w4Qd3JxKYnkJNjc0N94waoVWSkXSjgK8TgN5f3QRJNkd3PoFV2Zcum
 jQKGE3OV+EEDtdLoNg1u7jMb9R1Hnxzsi7aKakWi858UzO+N4GzSvyboq9N1LM7D5AJF
 2PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779281860; x=1779886660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pWuNbzmVAeKu9X/6BOYVhCLAmYo4BzOwAgml6T0nJLE=;
 b=rAWraae6dju34VVrTTSMcBVdX3fJ925TDyf6EG8uQF195X8uf1qsxD6JX/eh78LfZ8
 2tQvNqDpwLlSLTLiC3Sh0SPzUuIwh0zxKzbL/EuCcAR4NwdRA4RtEeI2AUMrjnNM/sGg
 ARnLNcaJD5H3BS6BtSCV4gxn0dO70GytynH5ADVQr/B8ZcKKatdIYZqgSr5xy+cHDa3y
 E4qaP010fkK+sjBiuu/Wq2QCXmA7sbE4BAEeNJSIHOnP3ny3c8XA2vVhvejIOaqOL5WK
 gtWBRB63TsTIQF2YpUkTZ4ufDr1QOhPvk89WnFZhUOPPMUWVNAnw2skNINQj5GtZtggj
 CS6g==
X-Gm-Message-State: AOJu0YwdWhf+RH7Zv84U26nDw4YotzDrelRtJvMve86Us9Od2JDgOz9C
 3eJ0YjqudztlttJ+RziYQcNmFEZ0X2YFUWQpS0f9MCYZUs8t5qsl4HcQFlYjnM5QO/g=
X-Gm-Gg: Acq92OEWGFrj2v0Y4zmv7gcEvzEwnAnk7gl7LaWwpFPPGqHLWbdvGWr11rsboUvtl/a
 if9D7f/NSzmQLhpnuNqRysHZb79a3n1ounRWa6RZi+sxvbgPdw3o2yKm3kDAjapZstYnCnD9Itf
 6fGtOs1lnl42EDHXp7u0CTil+7b5UfG7Q/4ie2yoHw1rlH1NENKBnSMON995rn0wjYPqMi40oj0
 deaCGXfn3sBd8qjaT4Yd9Ji+6YmjZtvxcGXUKdFgsnRMlHzFinM95n21Xe7SlnPQ75lXQgBOqRT
 nX1F35a29bonR1QE4xwrAsDSM9xNdn7G0NeLp1mbNg4t3AJcwJrIuwRDz30sMXpFMG7n2KlQ9bm
 Korko8RL8dy//2cYLjhI8U7uztHieb+HTVfncvGupNiTaEqZ7QKWyyriFC9TSJTKgfYJUOT8B4l
 8piN/gcsmouG0/qemlzg9s3huCJailLrtCGNtg6Khzg05Y8ICVB1EjdgDgc+QY6iJXC9fHoQ6IE
 2ha
X-Received: by 2002:a05:600c:1f94:b0:489:1d23:4524 with SMTP id
 5b1f17b1804b1-48fe60de736mr352601145e9.5.1779281859600; 
 Wed, 20 May 2026 05:57:39 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c90b27sm412772665e9.8.2026.05.20.05.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 05:57:38 -0700 (PDT)
Message-ID: <f52ebf28-1921-4ada-a7c5-ec3342cd3acb@linaro.org>
Date: Wed, 20 May 2026 14:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260520123947.12711-1-philmd@linaro.org>
 <87fr3ms0oi.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87fr3ms0oi.fsf@pond.sub.org>
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

On 20/5/26 14:52, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Fixes: 812b31d3f91 ("configs: rename default-configs to configs and reorganise")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b75f3222f2f..2a4d124fb3c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -256,7 +256,7 @@ X: target/hexagon/gen_idef_parser_funcs.py
>>   F: linux-user/hexagon/
>>   F: tests/tcg/hexagon/
>>   F: disas/hexagon.c
>> -F: configs/targets/hexagon-linux-user/default.mak
>> +F: configs/targets/hexagon-linux-user.mak
>>   F: docker/dockerfiles/debian-hexagon-cross.docker
> 
> This one's wrong, too.

Already fixed in Alex's tree:
https://lore.kernel.org/qemu-devel/20260518102222.80735-2-philmd@linaro.org/

Pierrick suggested to repost patch dependencies already queued in
maintainer tree when posting series; while this seem counter
productive it could indeed have saved us time.

> I have an unsent patch fixing both.  In fact, I have an unsent series
> fixing *all* F: patterns that don't resolve to any file.

Oh :( I already sent various patches about that yesterday :(

> 
>>   F: gdbstub/gdb-xml/hexagon*.xml
>>   T: git https://github.com/quic/qemu.git hex-next
> 


