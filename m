Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47EAC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfgH-0005cj-9Q; Mon, 10 Mar 2025 12:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trfg5-0005Y5-GT
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:08:31 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trfg3-00085H-Mo
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:08:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225477548e1so35144305ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741622905; x=1742227705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5j6InvUXXOdD/4L/+KIhZmigmpZZAdS9mdDEY83n6LM=;
 b=CbotsNT0vFHg5gaB9IOUN09aVF6MvbE0igWFhsnNf6glpKqRNMlAMOQx/qHESoj5kH
 61JbC0J6QzjR+LUZegvPBKDT0CkP7VZv7nppUEBP9UjyOj7zqUCp0PPRfY8Nnbrg9hJl
 M/vjuo+mWTtxRt4g1fRgrM8+lGKXeFyG2rbutXfWQRPnvfTjeSSiJ9aENZwaAvoD/cFJ
 bgxldrW0uOd4V0CL/QcIeJuEjpXJdz8ThKXJVGqRuGliV9exeBZx8mXxpdPWNpTWC9Ze
 9GuCnpVU2or9Ob3Dgtaz7U4QcpLWS//NQcyJRXu3sI3A3mesTt1L8FY3rNKC9FCStIK9
 dAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741622905; x=1742227705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5j6InvUXXOdD/4L/+KIhZmigmpZZAdS9mdDEY83n6LM=;
 b=gSSweTWgSOJ0MiGJ4V3khH3bpdRYDAl0Jme66wuw6uDDwOj97K289IswhtNy0J/8cw
 JNKPs/HCaV1Q9Nu3iiMIXF4s9WY2gVrZXUMUOuNo9Org9fBFZdSgjoZVMy4XOk5wKmLi
 x4NVDqhXT7QRDYus92lsawTploEEnLJ8Z9a+OhRDwVTtjVFxEyOBJRrw7kZvIXBxqXUl
 9iiae/61MZnMqRPfXo96CEP+Y0bUIbtbtUNauYHnDqevVL0y2IZQzYG00ZiTGjgkfelf
 lqHixSRJTsGQCoacSeRp9wRh80zZK8LtdYm2rvpZVN65kEUK8zDfgv42VXPymoHzE9uE
 xymQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyzlGKnQWofDWgq5I4361E5XRDWXOh+tTqluxEZwqIyPS6tmy41BHXc3ctzT5PdwFChYL5HvOS3QcQ@nongnu.org
X-Gm-Message-State: AOJu0YwsJLOAcxfQLmrt8tkhtfk4cDB9Vtd0L/rBbmo7K33NvhOJWq2G
 qoAnl00543MjvWVNVS0lOxl2j4FiQ5X+Q4rd/po4gHRcQCHL91tWkPCDZomyuWVl4P21AV07iKI
 E
X-Gm-Gg: ASbGncu3Hoz5WeqgGdago596M4rpKXbCTsF3iw8LuUmjf4b0XdOGdHiUMb6IlufxTqW
 djJvNZoz6VhB7biBDeZtfwl7xo7YrRpMXicnBXHQ/aFqkm3ulCFHDbHJ64MuI6BriTc6zAqPBWK
 QmK6jQU9kD8p9myCL0OX0TbrRjqPfSMr8vw6enJVqoTOkVJs+U11GgDwIOejUg7Ap17cVtpVJkH
 stJRtE8OYCv3GjuYTvKbDCoYxplc+DHrrEqhg0oKVIS/TCPqSqsPb51YZa9nb/iTMh7ReKjr+B4
 ax1aJCIYyG8mvTG0KpqLqEZqgO2uq/42i39mvjaNrM5Oo6gKFDGKI9YglRUynfTjGcAI/b/JPzT
 JDahUPfVqe2D6OQ4TtZo=
X-Google-Smtp-Source: AGHT+IE0W5WoKGrp1OUTFgTYbw82ev0QR1AGaeyap3vb2gUmt/1YfGr9PY5w51hFXPuGjAR5C6BhTA==
X-Received: by 2002:a05:6a00:2e17:b0:736:3954:d78c with SMTP id
 d2e1a72fcca58-736aaa1ce42mr20232886b3a.6.1741622905105; 
 Mon, 10 Mar 2025 09:08:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736be7845c8sm5095558b3a.109.2025.03.10.09.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:08:24 -0700 (PDT)
Message-ID: <4ac28725-33bc-4b29-a941-03784566d330@linaro.org>
Date: Mon, 10 Mar 2025 09:08:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] qemu/bswap: implement {ld,st}.*_p as functions
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> For now, they are duplicate of the same macros in cpu-all.h that we
> eliminate in next commit.
> 
> Keep code readable by not defining them with macros, but simply their
> implementation.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Why do you want these in bswap.h, rather than tswap.h?
They're target swaps, after all.


r~

