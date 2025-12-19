Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A118DD74969
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 09:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWWLs-0002TU-0q; Fri, 19 Dec 2025 04:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWWLh-0002Sl-8Z
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:00:33 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWWLf-0000IV-KW
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 04:00:33 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-477632d9326so9351035e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 01:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766134830; x=1766739630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iw8PYEkc2WSyzh1Yluz9dfu9Sd9QbaIlPFYP+JPcuCk=;
 b=ArvHUJmY8g5Qod2e3NTSxxn3tpnB3eKqqEB0AAkOf1SVvIK/icSHwVYeKvPJiuxVyr
 A3LJfEjQU1Ex9wd3YGaSJJtrc5NDS+q4n1PV//j/UdIiwreIhGn47i3E/mva9Zzo6trd
 7Mg7xENHKfqN2jmcYLadq4DezyvYjB8rj7ivdv78dcaOUGDZ1108dch2apLjlS0C4sja
 zsUr/DsvCN+Wb88bdD3PvjxzLwdWoi3G1JhsPFoy8FQdXKlZQlxOdvA538KdwXelxbI0
 HpcSEW2cJMQdC7VqsJpHBOoX4OUmqqhFnAZHcjyxoCTsQF0nl8sPu6sSKMjFKE2tyI6G
 q9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766134830; x=1766739630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iw8PYEkc2WSyzh1Yluz9dfu9Sd9QbaIlPFYP+JPcuCk=;
 b=wbiZxP+Mj+fKY2o9HdTaYqMaGGkdcpUwpmOY5J6M7PHNFn1hsAh6fcgoYmSJobxutd
 j+mgRXSFnGk2qT41BbjvTxNBoVsU8w+wPJKXxNBjReDPo1YYE8fplLI8zDEShg30MXEZ
 NJ/cBVRSLbFyARdcF+CHYwu8dq8xi30kB0lizNj1Aqn1KVaXOFEhiPAJjDXr3KkJle53
 DwMwQhhEbrBDAlaaVsVaUJNwgouZO34DmOBGWLI5ODmqGYA1dz+YUbwTk4WB1QZ23zyD
 ODrfcnqwSd0OHFE0kv7CgxvDop+dk8x8ERjoko/KSck0mHt0C0hpoyHmNqZ7QYdj0199
 fbeQ==
X-Gm-Message-State: AOJu0YynjHnikATK8LBibM5CsNkspttK3A4RisYkA2CL74WXEqGoKIoi
 6Y75BcQhtiqjyi1HjuLTmFQnoxsraUM/zSTxMkB5mbvp3yYCmZRSECgp2D6mjxUMvrY=
X-Gm-Gg: AY/fxX4eNuJcMscgC5dUSQnz/aOqa2lkT4hhob/k8kJCHHJPU9N2Io/yn0FliJeyk72
 wF+lSt+LPkajYSnbkbSsAL2cuz/4SLk0frW87ygGYsCVWug+d9Nsu3R0zR0ReJYUdMO38xRQG+3
 lDMJ+obA/AeBtcvL3uhXZgwIwqKapoF6RECW1GWea2qJ8r06G7m5UI45AVms6UMf3xDjpR8K7gq
 GNV6BN+QrnOuqH93raPgUg9NNAP3/Cn8ya2rUWjwe0RdZez7PzlRWylrI37ntWGiZQcxbqlP2lc
 Qn64f9z9azTK34zhR7nnmw0mJPFvSDZu1aR5nGJBcFQyznSkuK2fpn61+GawnNOWjH+za+YmrPB
 fHUmfqb9qwH2a1uG7Y/JBfc0dO8mEY4gcrhYCUvQ1YXJQU40Tg3qPvEwWULBjqSJrYXRu+7Okqi
 CubW5pPLjwWlRa0BglRdNcJoyYpgt3rEhBw8x8Q/DJHKzj/3b0JFpChQ==
X-Google-Smtp-Source: AGHT+IFRVSgdezUCKQozNx3Hfty7cZX9Jwxzz0Gqp3IwTeqDfNg+128s+G0UbRMVnTB5XARfeQXLiQ==
X-Received: by 2002:a05:600c:1d1d:b0:477:9c73:267f with SMTP id
 5b1f17b1804b1-47d195aa4bfmr20399925e9.33.1766134829266; 
 Fri, 19 Dec 2025 01:00:29 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3acdb87sm30562125e9.16.2025.12.19.01.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 01:00:28 -0800 (PST)
Message-ID: <19c5ae56-35ba-42fe-a330-fec28aad6999@linaro.org>
Date: Fri, 19 Dec 2025 10:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Machine max78000fthr not compiled in?
To: Markus Armbruster <armbru@redhat.com>,
 Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <875xa27ss1.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <875xa27ss1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 19/12/25 09:57, Markus Armbruster wrote:
> docs/system/arm/max78000.rst advises to use
> 
>    $ qemu-system-arm -machine max78000fthr -kernel max78000.bin -device loader,file=max78000.bin,addr=0x10000000
> 
> My locally built qemu-system-arm rejects this with
> 
>      qemu-system-arm: unsupported machine type: "max78000fthr"
>      Use -machine help to list supported machines
> 
> What's going wrong here?

See the fix:

https://lore.kernel.org/qemu-devel/20251218214306.63667-1-philmd@linaro.org/

