Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3A4E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 14:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM6vC-0006wy-Lx; Fri, 13 Dec 2024 09:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM6v4-0006vS-Vz
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:45:32 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM6v2-0007aL-C3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:45:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so1221634f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 06:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734101126; x=1734705926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ZKbh6n87dnJ5NzwW0cT93xRdQvDP6ludu960AA4sOQ=;
 b=mjUagkSeSAJL4414u//LEUshs3RgANjWVnq0/Jr7OHdr+CEfSaw9Ae7kHVspJ7TPjp
 CITWO6JvFtaO7YgOPytV6q3ObxMf/U8aCE3EDSeou4W2nEjDvUmU3CMB4/mUuSEEEi5D
 1xBdKYvwSgN/pryodN7qegnYya5yYpw6j4ml3NxQaOXsk3QnLskqnlIUH+VilTHqwCbm
 MUE7ZfWJAwYZsS4p/47vmh5VAvpGWIisanD7jpQ/YZi/vCfJQQRXHWSVzocsZoMjC/5k
 7OEg3VyetOYLgRwjOdCwVjJIq973c72MqMnJ+sbgnXz6MNkGcBVUpK6iLKBjx9VbqlU8
 Unvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734101126; x=1734705926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ZKbh6n87dnJ5NzwW0cT93xRdQvDP6ludu960AA4sOQ=;
 b=nhGBd0+RV+hbXFCGIlvvMXoYFKskp8HIUeUtGmgQcdXPBc6OOpqqlWoUlHvZG05v0Q
 AKkUs2rHCe9t/hT1tc7FMeF4tFELyY+dnJYfg1RktM2WS6o1OlulOll3q1oIL8auW5SB
 rJYU3SpxxqrCrzBctR/YCDFa9Z7Bga6E5XbUhmB/K0qy8ZcXezMSlvY/ORlfbhl9/H23
 cW/VIPYpFMgqMGgA7vMupL/8Q0itPQCfVCBEG2Yu9//kpBdRr4VX6RSVaRdE6mOmyunX
 3RkOq8XTPTKysyrPDTZHjcFvV+ci/98N9aFNEwG5NoZN1wjKXPxrFI1uQ80dMq/B3hjZ
 oNdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXplkumdXgcHq/6UbKRTbjfTmMAG69PgAUNXHTVGlzLcPKAuIIPbRNLfDdw7ZrNJbtISYxVn4S1eCR3@nongnu.org
X-Gm-Message-State: AOJu0YwUa7fE1rTnpls4PrF7wD087CIFd6YCV9XzXSmiG6S7Swc/6dIF
 QtWn0vyP0RAwuVs8JAa64MQfondSXrupOKsf8aTslEswFPvNVqJIR8Z70VTCdAmvJMDnNdG4EcS
 H
X-Gm-Gg: ASbGnctA6RO5xgi3g4L6AWL8mFvFh0tBeNQaR2xfOc2N6geEHzsAmav/czSKwPtHSfe
 Nw6j4k3uCAPX39ZCW/eqj6rMdATeBTKJb7NtN754zFr2DNqAAjs9eHvEWLmS+i2wjllGyLb56qH
 LVD/hWG6oBk/ItX6SJcLSMOyuC90UBM14oALpWwzh7Vy/Ok76Lo70idHVQ01Og9m1/kznovvc9F
 TAXhvmojCIwrQ+aMAEKTGwbFmLpRlOl1mHKkNnybOV9vWn8wwF2B47gtp5PbfT43eG2fYPN3ZDf
 0lyhaGx25UH7hnXto0YIGDkLkNxy8w==
X-Google-Smtp-Source: AGHT+IHxxB2q+wtTqr/rcOLIHQjl7KXAjXoW69hgrMyZHxn3uVhmDXVJmeC+6qHjthCANxtQk/IlLA==
X-Received: by 2002:a5d:5f92:0:b0:386:34af:9bae with SMTP id
 ffacd0b85a97d-387887c24damr5373962f8f.4.1734101126182; 
 Fri, 13 Dec 2024 06:45:26 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514e6asm7357799f8f.79.2024.12.13.06.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 06:45:25 -0800 (PST)
Message-ID: <72afd862-a6a1-43d5-9787-35df0139c404@linaro.org>
Date: Fri, 13 Dec 2024 15:45:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] AHCI cleanup
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241212110926.23548-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212110926.23548-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 12/12/24 12:09, Bernhard Beschow wrote:

> Bernhard Beschow (2):
>    hw/ide/ahci: Decouple from PCI
>    hw/ide/ahci: Extract TYPE_SYSBUS_AHCI into dedicated file

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!


