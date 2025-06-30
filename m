Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980ABC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 18:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWJhX-0005Km-G0; Mon, 30 Jun 2025 14:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWJhV-0005K1-60
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 14:57:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWJhT-00088g-Jr
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 14:57:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-235e1d710d8so55148155ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751309873; x=1751914673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xe9pQwAt3Vvln5P1EamKTrpXUgfr3sECDeGt9C3N5wg=;
 b=LyFB0hFnpyUS2GY/AbnMftP46j0hSb1ViU4rehMY+CZKh9BzPhC9O3U8v9TbfVYZle
 nEft35IqU/uoUav39UU8gC1Dfe9fj6OEkmM6CZLAyNOvRcA09L7XQhErm0dRM63WV48G
 bfmyJj0j1eL/j2Npk5uSi5OvKTMYjVDF6Xpd0GTWgmfF4m24L0gNktIPEK77kHEuIQg3
 rbJOSTu+XANc6F3vo3OdUrknmeKA34kxiHh0iRPljXa4COm2oXI46mvZRN+yqEg1z1YI
 BQCqnayCMS7UQ6Zscsww4Eh2RANZtNGOvSFGBLaFAg+ybOh4JyQMBNTFNyCgAmtOriJ7
 ISSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751309873; x=1751914673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xe9pQwAt3Vvln5P1EamKTrpXUgfr3sECDeGt9C3N5wg=;
 b=KgpAUbxu4At3n4lLNbPLg4dMRVubyosvwBZ0EnqmtCOSPph9xvsLCcoQTqrSRgOava
 iL9D7HY1KSSoGfL0ieW26B+m5fWKVy+2TJkI+Z0G2oD8WASofSxwzleT8w6sMjEqPYqw
 eUqIOdtkReL5efbDDuIw6L9f8ek+A0JSjPvkZVv0q/cg6uSLW5iFzMcKytAqcuz2bC16
 TdGOwKgyph0Qa1jgk7vpCq20aNs049EaTWJ8Ppc42RI7QiCTJK2rjXpTFnFv/2Ahav3r
 crwbo+3hhHuYHEir6/UqhO6PJUhfxwj3IIMK1E9pAqaXvu1GkvPHO086rpKQe8vDv9Jh
 fxXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4vPAh/VD8SjCzp2Xtp+M69nhGA2xsgOOD5SZ1e2EmRXKbTOBst+HU3jxlqwgT3uwbPBHiDECKAhD9@nongnu.org
X-Gm-Message-State: AOJu0YyDU/3AQswZJzoZNiLou0GOifh49FSmVdZcsdhTmNxO73GZOj4I
 Chi/Q6ldHzL1842qix8/C8xCElTz/YwRwIsU3Z3f9KQOq8YAqYI+qWW3buwcNtw/Nk8=
X-Gm-Gg: ASbGncvz0HijQykbPevydvaebHcoDeq4xWXt24RQkY6zdMID1TAZnqW7+T++vDVGiVy
 1cqeOX+kb+Z2s4mi/83Z9gDMGPE/G5K09ZQUZVqLY+LOkepLtYc4yzJN0LD+zW1hddArPNliPjH
 ec58Z98nyX6ih/BiQpe7QX8PaNwHbk2dTSs5WzKLElyiAy3B8Nusf4UvZUpzir/lLiiP/2RDa0p
 QyABLAm7Y7VHhcu14XYpAqqv6NH5TYAGzbKxM0YY4MZvT/cTYfe7EngnPgnr0qXma3fnc3FrMJV
 3zsIYJcrVjtksabp6IJ7C6qECGiaVUBK5ft1a9QaURleAzGuX0m5OkoGMftBavabVc8aZXZVAYu
 NDtzrDCnpdQ==
X-Google-Smtp-Source: AGHT+IEq6r2bx8+7POp633irunuoAM62udx/GXWUnJsBiW+oQm4YZOgoQDnYXf+jBqz3MKzP3aGLjA==
X-Received: by 2002:a17:902:e746:b0:234:d292:be7a with SMTP id
 d9443c01a7336-23ac3bffdbdmr217232185ad.1.1751309873515; 
 Mon, 30 Jun 2025 11:57:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3b7bafsm87114955ad.167.2025.06.30.11.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 11:57:53 -0700 (PDT)
Message-ID: <81d022a7-fdf7-4a03-9a3b-cb2635c96cda@linaro.org>
Date: Mon, 30 Jun 2025 11:57:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Options to output the preprocessor code
To: mindentropy <mindentropy@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAM2a4uyBMNSdKNtJWWTgNivj6dpDFzJJepkfpU5RN-wir9vQEQ@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAM2a4uyBMNSdKNtJWWTgNivj6dpDFzJJepkfpU5RN-wir9vQEQ@mail.gmail.com>
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

Hi Gautam,

On 6/28/25 3:18 AM, mindentropy wrote:
> Hi,
> 
> Is there an option to generate preprocessor output while building the
> QEMU code? It makes it easier to understand some of the macro template
> function generation.
> 
> -Gautam.
> 

You can get verbose command for building by using make V=1, or ninja -v, 
depending which command you like to use.

Then, you can get a preprocessed output by using '-E' gcc option.
Don't forget to remove -o option, emitting the object file (or replace 
path).

Regards,
Pierrick

