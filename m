Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0626ACCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RUd-0000n5-IM; Thu, 16 Oct 2025 13:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RUa-0000m1-QN
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:10:20 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RUV-0003XE-Vq
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:10:19 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b57bf560703so676320a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760634611; x=1761239411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W+y9590Rju55IBWNEEnri44H8IFlGQsvQbodRDeKMnE=;
 b=b05ygwiUzLm7S3GtlRL27lIH6WT13WjJQgp6T2xpFnt+zlm/+KzmkqdrZxpWIFJjEO
 Cq74KrQoKbCNaNs4UKaGLQhyroS7I6AjOAoJxt6J/6xsDCjYihfc/FsI/LqCq0cD6f/E
 gIXMs25vzP4bdglDxrZtgG/k5Rtj/kqlxyIaxKa9aYARPusTg+hZqzLG4Z0Jop+YAImm
 ZExp+El6onUh6iBiqJ9PV+PdvMyjZK6sEtbv+lNH9DRlEgxLInIuflWkTwYwO5hMRBxX
 yIEgnREe1UrEWDeEEP3/uSYYcX+Mz7DTV+74DtW3cSA5LG0ndBlCTMbUUHZr6+dwBsTf
 CnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634611; x=1761239411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W+y9590Rju55IBWNEEnri44H8IFlGQsvQbodRDeKMnE=;
 b=DRFTU+HmO7Y4PQKyKERDqzgsZD4ZXbl6K5YvaCzf3vvv4fL2GR+yBWjqsK/l/5nxzX
 WFVHtREVQWdqtUJy8JZaf6TKijkM0cnheY+CZOur462Pzq8CksUn77H3H7MlUMaj4C7D
 wLqkhxdQzeYQ1CwtgHQN0Nkue/JxeVApQa3s1g8Q5FiB8riDwLzMjUfrXnP829gS8wol
 yRp3VABGz4bKwOYBqJQ3hgBlllZlA7g4WnM3qualTsbzfQZVKcldOpaowYskmyo+7C/w
 GAWUpDVbNPdM5Zf7FoDv7ZTiJyl0KNIsOwv9npbkSOCHAPAafH+RquGLU6ITPXYkNe38
 nr/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWke5dLGCIJnhV7zoR59a+gbjBKA3/pR6+qLr2dXLVZqdiomRXmQO02JtfuFKeMcZMmIS4uRpIwrWRJ@nongnu.org
X-Gm-Message-State: AOJu0Yyq6VmdSNiEh55opc+VrqJqHeyjaCbDJJaSMvi/rhOW3Vqvqe/o
 AeuNKClYt3O+FH7Wiauf8Ud5ffnB51+VGHTNtsXXAY/LuOF8EZaETnmr58Mz5n6Ybao=
X-Gm-Gg: ASbGncszftayjFhCbLSUVNDOtbo0g5kazFgZ5iu7YWAgx1TdK22exquPBc+k7j0wC7f
 x0QxPySqqm30V9m9/rEQUQ3XRQvPntcVWjQYoA2L5yxwPueJ+e6IyBLuyZEf7mmkT1hdqL+9qhI
 /uICrAMla1/aQEELDlvfzZ5Ch7eaYZ0LU9BipPShC1d2KqRbIoofZewXZfOdyQTdqt9j75ZEiEg
 /WZFyKJ7LpuwwwAJfJqyTsiVXneYpExZeCsQorwU0tdy+oAOMnhMaAk71EHfe+ReoOy3yFT0f97
 uc8tWRG31IB1XtFZ/GVkYwF1L/9UXAgqFUdPQk2uCd27PSlj8r3OV4xF2fkhoIX7CX3kZfDmX+k
 18nC+5uSlAEAuySd3fZhV6xn9rUheFdrw+TezAJj8VOKmIoNK/DmblbvN3iN23zTZN65i0JeEN9
 iiwWXBsLCNfM5oIb62oWN1nUY=
X-Google-Smtp-Source: AGHT+IG7g9yccGCOr/5huwpVE+juN7DtgCivkbOxdSHJ6ZzNVUlh2v23F9GTlu369LKOQmKWdP6tJA==
X-Received: by 2002:a17:902:e944:b0:290:b14c:4f36 with SMTP id
 d9443c01a7336-290cba4edaemr7926005ad.31.1760634611255; 
 Thu, 16 Oct 2025 10:10:11 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-290c5c7d305sm10174435ad.70.2025.10.16.10.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 10:10:10 -0700 (PDT)
Message-ID: <72f680c3-e2f4-4023-a6c2-b508e5af1c0c@linaro.org>
Date: Thu, 16 Oct 2025 10:10:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/24] tests: data: update AArch64 ACPI tables
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-6-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016165520.62532-6-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
> After the previous commit introducing GICv3 + GICv2m configurations,
> update the AArch64 ACPI table for the its=off case.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 164 -> 188 bytes
>   tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>   2 files changed, 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


