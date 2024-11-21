Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791B9D75BDC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3PU-0001BE-DM; Thu, 21 Nov 2024 04:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3PS-0001A7-Ur
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:23:35 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3PR-0007EY-D2
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:23:34 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539f8490856so611609e87.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732181011; x=1732785811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fGCq6fhGq6Wql1CEL9N4RCP1zXWoMzyXA14jOHv6Wrc=;
 b=tX0Ierwh+dre82L/tedc4vKlVXIDpTaSQioOBtJLPmXOA1xagkiwd0pa+C9USd1LiE
 zCMmQeHLgPR/Y0o8v3aoIJy06bNHtAPR4FbduxbGTOa7WSCXuKGMQplzegHPLJJEy5tv
 vk/zW7VreIgLOtg/aYZ9DDr5966y4y7jhqr8kOWrqLuzD7l8uK3ivpXEw2NE2TO2oILu
 mTG9B06Im1TvX19e0KIEWyNJhoo+aAQEo+wSTSH1xherA5h6O84sXQux684VnSzaRHw8
 z4McNyoIBBFb5MWyrGfc2qt61eujygYhZsO/6B4tMub+xLCUrIYJR9w4dIyRcZLuC0fE
 l42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732181011; x=1732785811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fGCq6fhGq6Wql1CEL9N4RCP1zXWoMzyXA14jOHv6Wrc=;
 b=fclZIu3RGW9Zq8MJB51IICYLvedDH2PPIk9bq/Xk/uXuFVx/dxmYQITVj1aJ6B6YRJ
 QtG8zH1v0rs3wOZpkIVbFO9L7V0kJRO6m+u+dvkbh3RTgtQh9o92M6SqlM85SF88VVkm
 kE2aoynfyKCpH67G0o92QjQ5vTwW994lS1TUP6eEAh5t8B7+kKyaqO6r/oFK+z4M36FS
 /7FSHjrKbL6U1/AiBC//5GGjgez20drtD/SagjD88L6vnAYxfwTp0X4XCE0Lm0tMTmYk
 /O1k85qXSo2a9c84K85HFiCkedpjZ0u5ugmUSqQx9rbN+IGNdEFl2WaueFXho+KbRGjX
 FGSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVfNmP2KNyx05JmnoX2jvQ5zqKGm4i4ogTWCDRZMBTybKxj2ByinIuNa6mdRFDMWKWOmC+OtfbbdIY@nongnu.org
X-Gm-Message-State: AOJu0YxaN9X27pReYmhx3im5OCV8Yc0jv5wQ6BCjWCUxZyDDm8B5lWtI
 x7fBaOiLkFAW2BNCeb3FQCnYjHG0WOK7bHN+UZpf7TxTHtSnzY7rPO6U2HE1+XM=
X-Google-Smtp-Source: AGHT+IGVslgxuBh+jH6ieSTY9utCh7iKHFDgP/gdRTP9S0gtf8qiczyvQqldOaJCQxcYalyrsca7Zg==
X-Received: by 2002:a19:6a04:0:b0:53d:c162:e0c7 with SMTP id
 2adb3069b0e04-53dc162e19fmr2056791e87.5.1732181011556; 
 Thu, 21 Nov 2024 01:23:31 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bd4d1sm48106335e9.12.2024.11.21.01.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:23:31 -0800 (PST)
Message-ID: <816bc7a6-a196-4b02-b65d-dd13c0e3f37d@linaro.org>
Date: Thu, 21 Nov 2024 10:23:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] qom: Add object_get_container()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-12-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120215703.3918445-12-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 20/11/24 22:57, Peter Xu wrote:
> Add a helper to fetch a root container (under object_get_root()).  Sanity
> check on the type of the object.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qom/object.h | 10 ++++++++++
>   qom/object.c         | 10 ++++++++++
>   2 files changed, 20 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


