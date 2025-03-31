Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69879C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNHs-0007Gd-Ca; Mon, 31 Mar 2025 18:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzNHp-0007GB-VX
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:07:18 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzNHo-0006RC-6y
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:07:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2260c91576aso78404505ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743458834; x=1744063634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zxDSjOVOC10mvEbMQzvzIxJGttcob6VfA7mpXFoIFNA=;
 b=nEUolyV8qDYGI60nUqcNMTQXCJwNYNy57HsRFjfVrj8g2683LN6vBMHESGtzxH/NI3
 RmWif74AaPEoBVjPaTEzbhNeBsrYELpTKVy+TqzMAv8SlBNesEFpS4KEOeRkPmpjJ834
 7XVOqthfldkGH9rLyQk4cE/z/ZstXwJYKXQqGg4VmVDU609MwxGt7zjHxgjMKPGIT38z
 zQ+713ncLpOFnX13k8Y5S8ppR2M9zK75fCmUtXIWrVhf54vqpZmCsqvXcYyrxGbsBqTI
 fdEGnlYQ+D13EeFozlan42Iv/98emboZ9KqA82OWnNCoVhaWhJhVAzrfEtM7foNlToZZ
 qRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743458834; x=1744063634;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zxDSjOVOC10mvEbMQzvzIxJGttcob6VfA7mpXFoIFNA=;
 b=tF1fBHWfYAlF62pec0G/tZaDmxD28Xl+44feMZoy2mXjrNMC87gNo/oxiXpGqfVHxK
 fk8IfRFcfEhktxNeIJyyZDcYFpDV9sCaB8nc396TpafU9ji5ZvqoDUrujfv8cgfyDJp8
 esA6ZvlWIApcSyp7eRl5LdApXxX6AwrpI4xCxwCK0MqFhqdL65p9mCtr1gwZMpvXasC2
 sBzgYEw6MjUZVk0KvLbGFdAQxP5JaEaRfWH9jcDXAJ15SVq3TjupCmfllq9jkbGBZTcW
 Vza7OqKTM4o+taXujhGHXn6x2V9zBYsrIfbT6kRCAumQyym1xJqdY9aZq1QUiIPFJd+8
 0lBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqGEUBikcE3/B0opGSXhrNh7tKmUUl7d1vLRJFEawDJI6v3Yu+fgwhvKuCCrCKiQ1DqDVkfGnTjN2Z@nongnu.org
X-Gm-Message-State: AOJu0Yzd1DQViVdalxt0kKoBtwHwGOpThXM1mpESkwds8gB3PL5vqneP
 tp7eKzmGu801zNMFByxdNJznQB+blaf6TounvzmJsyzvk0i3f6Y0GDt3gezvgfE=
X-Gm-Gg: ASbGncvnctQ9s6qhZSioT1a5KpDAjI0rnj05WtGablVaMv/e/n5npuumY/TPZ1/Vomp
 +iNVUN+fg3/eg63JZjsw3xEiMGMfqZYto9o1vjAYIre/0h9fhha86Wh1YIEhme1mMKp7wyc2Mgf
 G+vp5FM3/Qef7y+p/tRSdc5SfwEdfr4iV6/2AF28kEpbqfwxcnwcw3MSe37ccXK/ZOIy7BnTBT9
 DZa6VVo4JDAMnbjW8K2MZVySW4VOKehb4vzaxkzIsfIBVfGGyJVsdIeOSRBpHR9yXSZp5ZfntwS
 Tmb2G0De8FyIE44mUKRLwDng6BfIENgLi3g4PrmaKbI76KYAiSnkbbTZuQ==
X-Google-Smtp-Source: AGHT+IFtxyTobbx8oTg6EpiRkh3UlS5tyPEfLqT1o1aZXhSsm/TDTcCZ8XKidYo/zJp26jz0iy4Xfg==
X-Received: by 2002:a17:903:13cf:b0:223:619e:71e9 with SMTP id
 d9443c01a7336-2292f942abemr162615965ad.11.1743458834373; 
 Mon, 31 Mar 2025 15:07:14 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1cdfc6sm74316035ad.147.2025.03.31.15.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 15:07:13 -0700 (PDT)
Message-ID: <4100a56d-d3cb-4dfc-a1c9-00bae5482051@linaro.org>
Date: Mon, 31 Mar 2025 15:07:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/42] include/exec: Split out mmap-lock.h
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-16-richard.henderson@linaro.org>
 <aec3ea95-684f-4498-980e-0d3e0cd7d1a4@linaro.org>
In-Reply-To: <aec3ea95-684f-4498-980e-0d3e0cd7d1a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/31/25 15:05, Pierrick Bouvier wrote:
> On 3/18/25 14:31, Richard Henderson wrote:
>> Split out mmap_lock, et al from page-protection.h
>> to a new header.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This breaks bsd-user which needs some extra includes as well.
> 
> See here for details and a patch fixing it [1] (also attached to this
> email).
> 
> [1]
> https://github.com/pbo-linaro/qemu/commit/86581aa3a01b62f1cd7797fc9df6fbc98be565ef
> 
> Regards,
> Pierrick

I guess you're more than familiar with building BSD variants, but just 
in case, an easy reproducer can be found here [1].

[1]
https://github.com/pbo-linaro/qemu-ci/blob/ae92b220f699cd366e596bfd31f3a52a4e325bbe/.github/workflows/build.yml#L161

Regards,
Pierrick

