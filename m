Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15096FF6E9B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 22:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dO5-0000Fq-QU; Tue, 17 Mar 2026 18:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2dO4-0000Fg-Jr
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 18:59:44 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2dO2-00028L-Lb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 18:59:44 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c739e680bebso118556a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773788381; x=1774393181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fNC+XVAk099ybPuxER01A0Kcd/XgdWr9OXxKrj++y24=;
 b=x+kgc+J80Moywutnf/J1ocn1Iech0qB5vgfnPS7qCz1QLjsNb9CyLgSNxtwiBcihrt
 yF6QXFszv87tevQLuOTgZig9EnHO98ppGV4SznhfouM1/6uJt+U5q5mwaKP3Hxe0ZCma
 sg8P7c20ZsynxFBqlNhzNjfVuKhYJ2h+XsZZeDrsmcmdP1X6GqbY17RpDBDoTjoajJ9h
 g31QamA8eg3zNg5cTNO0lATqkFdXvIQUb2JDbGQguM8e7PR1xEcvzl6E8SZCumjSJna4
 FGP4Y6wRnte/W9r9Xfl5MydMP3UtYv7zGj7Lq7uLTdICbJbCZTSMSaXlZBczWNIGWcLa
 LUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773788381; x=1774393181;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNC+XVAk099ybPuxER01A0Kcd/XgdWr9OXxKrj++y24=;
 b=epkEkToSYs1gVbdJghYEfom7EgjH1Hk73WjTMRchu6bBTEaNwA/NveNq5Nifch+254
 PksS90gnHbqNdQM41ZqFZpmXvt8lL8ZscGMyrgx/IkmrKaz2Hn43zHu8Fl8wnz74Csfz
 Q0GnHBJ2y7PvXvGLG0cQNlf70y1+kQznTue8XrR0oF0/kRukVdG/oDGXFx3xrZK5EgGy
 Sx7O3vO45fbBrxlcKTTWjQvZQqEwyJ+Cs7wb2YurgdnS6xtRsBBqMBJBQR7UCyGKAbE6
 vtlbz5LSnTVHvcEOmjUrVm4lgITSYvIguTF54ABoXj8cuEqEbyC4pdPa49dlpe0uJiL6
 kN6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfCZCX6gWPwFqpMdl7Rm6RWz5MGT4euRH2+w7C5JgbO3IclGwheW2WElqwA7zDAz+jFJqmjMF3yZ8+@nongnu.org
X-Gm-Message-State: AOJu0YydurapMF9eoZW8A2zCEXFnRyEO8+VGhiQ/p1qS7dcSgDgEttYp
 EJay+ZpEoDPPWAnnYq2DJX83/4gQVldnudtChxbCMPvzObZ7UUhEQciDGZWnfgkI0E8=
X-Gm-Gg: ATEYQzxQC/rZrmmXX5+/vI4LHRG9RDeX/yq95T9E2jptWTvSfXwjKM+vp2cTNliJFAk
 CPIrRQO6jetQfyypYqeTyt//gkm6NaU49xWY4jTfLDe71z4oc7YNUrFGBKyHcDo7vkkzkZcOwh0
 vGBmaa+67sfGu+x0QCajKOIZWtByAddYSuVQrVYuVKyzVV18YcRsRKKb+z3GX2MnlV663lFFsBZ
 vaj9+6prfe04EhFgjkdEWiv4zRlxm9hlByvbYSwMR3NQZk9Bt0M+609LQP9JVQY8wLKvlC5/dFr
 x6QG/JEs2YXH5qF8YDsQQqKbZcJBvzOah7h76RGoDvCXPIzf3nQo0MWRr7/jaNWL+UQGKyjYQDg
 zo7PvEAvcLfKu2NFHhRQ4xFNT59u+hgJ98vTWGXKoKA7zYFdusKJBX9Pot90jqyH5FxXBJ5t5L8
 Oo6WBUppDaDLZw3kEhfLKVGZ5ZrQYejqypx8W3C9mRoXWDi7n9trHG9ivC8YH1407qPcyl
X-Received: by 2002:a05:6a21:1505:b0:39b:8e94:c4b2 with SMTP id
 adf61e73a8af0-39b977fa4b5mr1102666637.12.1773788380853; 
 Tue, 17 Mar 2026 15:59:40 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbb2f41sm469275b3a.33.2026.03.17.15.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 15:59:40 -0700 (PDT)
Message-ID: <9ff1cda3-f9e1-4145-bbaa-75d60703f99b@linaro.org>
Date: Tue, 17 Mar 2026 15:59:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] hw/vfio: eradicate CONFIG_IOMMU from sources
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-ppc@nongnu.org,
 eric.auger@redhat.com
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
 <20260315070834.198331-5-pierrick.bouvier@linaro.org>
 <8bcc2cb9-6562-4ba2-be95-04f8b23e40f2@redhat.com>
 <0cc139d6-9289-44a0-9122-d701426dae0c@linaro.org>
 <e8254fe0-4c23-4b92-9549-a15ce2627bfb@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <e8254fe0-4c23-4b92-9549-a15ce2627bfb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 3/17/26 6:55 AM, Cédric Le Goater wrote:
>> Writing my answer and seeing current behavior, I wonder if we could not have better error messages simply by checking if /dev/iommu exists when setting the iommufd property of vfio-pci device or when realizing the iommufd object (-object iommufd,id=iommufd0). For the latter, I need to double check order or initialization/realization as it might be tricky to catch before setting accessing vfio-dev/vfio0/dev.
> 
> yes. as said before, QEMU attaches to the device before connecting it
> to the IOMMU backend. So the iommufd object is unused until we reach
> this step of the device initialization.
> 
>> $ qemu-system-* -object iommufd,id=iommufd0
>> can't create iommufd object: /dev/iommu not found
>> Is your kernel config missing CONFIG_IOMMUFD?
> 
> Why not. Would you have time for it ?
>

Sent a separate series here:
https://lore.kernel.org/qemu-devel/20260317225751.1325098-1-pierrick.bouvier@linaro.org/T/#t

Regards,
Pierrick

