Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47EBE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV7Nm-0005IK-8q; Tue, 07 Jan 2025 06:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV7Ng-0005HD-RZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:04:19 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV7Ne-0007cl-8W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:04:15 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so57544445e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 03:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736247852; x=1736852652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5RdDsr3PQuFGZtSwE7HmTvoj9mL1DHpEvyfMWYgvZMA=;
 b=BhqUW9feHyC2z4by3SzuszKoxl2nRvj2ZuEu5UwbTWgdV+cy/XQEyMrjxkJCmJC95p
 vNzoZtwzXTgw0em3GTRjtwpOBAfZ2dFGxvRfNoDDTR5elbuHoi2KtbyfszKNiXyGavvz
 5YU8QPlHAStRB/FAx+WHzk8MtldbfqQ/8Nl3hTGWOHkkqqyK5RACYiX36AVlWPGrr9XC
 6gxWJnZfQG2xj8iAwZiL7wFj9BnRewzj0jMlZ1ktS2z8BJYyT4XH0T+SH4CxA+yDeCtA
 iY7jwktEkrWhvN7QLtwAGhdvnmOKT9NxP8IvgPWRI8rynxtXKKGrn+dlSii+RByHrc3w
 5SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736247852; x=1736852652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5RdDsr3PQuFGZtSwE7HmTvoj9mL1DHpEvyfMWYgvZMA=;
 b=Gj6Bcp554JIE7soQMHrPmay0pp/anTOfC60oCMEohQan11PQNsXbnPLSYIxd+AewBA
 II1i8dvO7Ar7P7AcWqKuTasIbwHb03ys/y86vjbbDSSOgjflRHUKfDyZ/rcx6vm3Na6L
 W3R5QbcM8lDZ794D/vikwPK0quPQwKbRlFnP7Cuf38mHotSEldknIPPbnpuMVPaM6xqO
 HW2uzTtzWGDOfPDFvSY53baAUT9bgJ7qKU9XsSF1Ih9gluk4axACP2Z3wa6oEXh4kyn2
 YfCgteCGZzsHiWfyjknT9SmrDsgG+RpVw2ktlo46+r0zF3yIRUxzUYYhgqFoqvkUVc24
 WOUw==
X-Gm-Message-State: AOJu0YyOMT2TzOW6AGN3BKspdDsGnFPKdgHylGMof5mDT6P2/zZHteG1
 kXtekLrgRHU5FrTXDLduoYioDe1cyxrCDmPTuEljfV05ufyejiLMYtIDgCShfCE=
X-Gm-Gg: ASbGnct2jHyxruYB4xleWWgT9M1C1lcx2DK5t8y60JRoFHcuDK8TrUSMgXtlclzCdCg
 NBVJkZ/uBJVmL87LpPfuxeLe1/2l2ghPAYs20O6X33e07J1vXyRUe5en8BdtLdpKGp70xJGbwAV
 cfp362qiumxh8kFjGMgCB6QYz6kT97NmOH3usDLxf7F81d1yg3Rm7YBnXHmlyik56N4nyOsdgjo
 iFFH92Qb4W9BxfVpzgno7SNs9HJlrwl3S+zsS72GC2WI5VpLvztrZ3nV2OVt+TjuwiV6jRfk8bF
 xWqPmIIhrWDP8RlbiSNTWpR1
X-Google-Smtp-Source: AGHT+IEoFjts2AAclOpEUB91NGG6rk5LK7I4QZoUF+DLR8g9AYr6ohcQEwJ+ogKD5c840LvmqfvAug==
X-Received: by 2002:a05:600c:548e:b0:431:5e3c:2ff0 with SMTP id
 5b1f17b1804b1-436686431a0mr487970175e9.8.1736247852622; 
 Tue, 07 Jan 2025 03:04:12 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661218f43sm597984655e9.19.2025.01.07.03.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 03:04:12 -0800 (PST)
Message-ID: <6a44b034-bf6a-4bf9-91ed-97b8bf42c3b9@linaro.org>
Date: Tue, 7 Jan 2025 12:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hw/s390x/ipl: Remove the "iplbext_migration"
 property
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250103144232.520383-1-thuth@redhat.com>
 <20250103144232.520383-6-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250103144232.520383-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 3/1/25 15:42, Thomas Huth wrote:
> Now that the old machine types that used this property have been
> removed, we can remove the property and the corresponding code.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/ipl.h |  1 -
>   hw/s390x/ipl.c | 10 ----------
>   2 files changed, 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


