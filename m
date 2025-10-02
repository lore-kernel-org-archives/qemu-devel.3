Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B476CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 01:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48Ch-0005SL-U9; Wed, 01 Oct 2025 21:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v48Cc-0005Qz-Ms
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:33:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v48CN-0003kx-N5
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:33:49 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-28e7cd34047so4173815ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 18:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759368799; x=1759973599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=js+AlCCQeeSaEmFZzfSrLXMm9s77lf6lYcygkZuoOrE=;
 b=ArnbgKfIiHoqImquAecmOE6PXGn545b8jXgwXfU+6tkbDAfxhWVzpCpEWe25O9174w
 GLR3D5Ct+lZYmwN4U0X4x0YTtCZTwWL4gJ0Qdhv79yUFl+SliWcyOFayIbLs4mR5Y0TQ
 YAsz8doGJIjFNQCuwGHE2dqVBJhrzbGXLN721TL+ZeornN5tYNjeeImzJlujgZvHTOcJ
 m866bq/H6wN+qUs8Y+tymYr/P81kF+g4wLvpOrxrT51BLGMsJ/pIgz+DZnRCqiscB4G/
 hgd2YKjudimGnAymg2GoX8O56oFlxhfXS4Mb/v2FUGZLiaNLnQhbIrIR/jDSSk6z8ZtQ
 VxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759368799; x=1759973599;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=js+AlCCQeeSaEmFZzfSrLXMm9s77lf6lYcygkZuoOrE=;
 b=DCQREDVWfQV04dtvp8Ywe8sGGsWVhAclq/nzB1C87HtogPHFjFdb4rGqBHtEbecwbM
 bjxZdMZwvU5fsUp2LhrCyIZYRr7/POTw/2Or4KViPaCcMetDfoiUBYbFeSHF/MnVukcm
 xCdFq7x2CsgwCx9HNvAds8BPO24DMLDDcnSR2PPuwIQxqtCAUCHl3ukgiGZpwq2Fj3qc
 je33qO1E82ttnnNSwWHtbv90e5+XqwDbjLWcrUEqKoJOSs8V2WNrwBzGNvBofmZtzmee
 eh6ucJ5RLhYxTXqoR90cD00HY3fde9i27jfJdK66t84d3M6WcO1Zf190hQcYb5qXV98S
 Kx6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7dNBzBTn3XWhMrwBz5YlzGq8TOOClC9zL+XuBwrnYZesUnTPLyyki1ZO40mLXQzoLl0U80KkajnRI@nongnu.org
X-Gm-Message-State: AOJu0YwiRREZ/7AT//xwG/H8xD8KT5uMoCo0x6x6zH8x9Rj3qEoGrSJb
 AzwjPiTIO3wdlfPF7qLP1vGYjx8hPOoA+BbIwTVqNeyxolpzrsqbkhB9b0vUMRmlox44hvRnZkp
 ycTVy
X-Gm-Gg: ASbGncsFnzduYrXEP6xk5QIl3fphyhHCKUhioIsVWSs/Truie4H69H6ph0JL1NVuMBv
 ibcibWsZVsX4nrzfsXJTFT9LjHLTLJNRmtA3xjtskMXiSMvQ9npa+Mg54qZsKXc/yYvom0Pl7na
 NZ52Rl9Gy6uFeRV2nUGDKp9yFiRvK/SGa1SVVLIoksf5OYqKgIN6kTUt7Crv4TC41KrVW4TW2lL
 BWsjCgNc3LjDeaw9K50ZadmjPRmR3yygaZD32sYrJq9YpN9m9xzHpJEfrL1h5MXCxYmBc+4ksog
 3W8cLYHJ4ebl9ytgDsqe7QHnXyfumAlmpNtr9tZMjOoIAwv+dtH7PchgeXV/aIzSWlFdyo5NwbH
 dINZNW9w2i1QVdWrtXKnbSEdwOzC+jTFMmG68/IA7COJ/rhFzbAmtVcYf/fXghqQ=
X-Google-Smtp-Source: AGHT+IFZpVk5JyZVxXd25afY54UtEAaLI2i7zys//Ep853RXXpL5BW54BeSA7K5GVZIUGxkUh6z3ug==
X-Received: by 2002:a17:903:17cb:b0:24c:caab:dfd2 with SMTP id
 d9443c01a7336-28e7f4dd9f0mr60673865ad.61.1759368799189; 
 Wed, 01 Oct 2025 18:33:19 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d584esm8871355ad.107.2025.10.01.18.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 18:33:18 -0700 (PDT)
Message-ID: <2dde1493-db82-4b3d-a962-2cd92355a3c0@linaro.org>
Date: Wed, 1 Oct 2025 18:33:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/35] wasm: Add Wasm TCG backend based on wasm64
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
 <ba60c570-fff0-4ab8-b3bc-d191663d2912@linaro.org>
In-Reply-To: <ba60c570-fff0-4ab8-b3bc-d191663d2912@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Kohei,

I've been able to build qemu-system-x86_64 for wasm.

When running it, I could not get any output following instructions on 
https://github.com/ktock/qemu-wasm-sample/tcgdev64.
Anyway, I could run this using emrun, even though output is limited to 
javascript console, and not the graphical console printed on webpage.

Am I missing something obvious here?

As well, I tested this setup (edk2 + linux):
$ git clone https://github.com/pbo-linaro/qemu-linux-stack
$ cd qemu-linux-stack
$ git checkout x86_64
$ ./build.sh
$ rm out/host.ext4 # too big for file_packager, does not handle sparse

# copy needed bios files (.bin, .rom) from qemu/pc-bios
$ /usr/share/emscripten/tools/file_packager.py \
   qemu-system-x86_64.data --preload out \
   kvmvapic.bin vgabios-stdvga.bin  efi-e1000.rom > load.js

When booting with:
Module['arguments'] = [
     '-m', '1G',
     '--nographic',
     '-bios', 'out/OVMF.fd',
     '-kernel', 'out/bzImage',
     '-append', 'console=ttyS0',
];

Boot fails with:
ASSERT_EFI_ERROR (Status = Device Error)

While it boots linux with native qemu. Do we have any restriction on 
WASM build that could create this, out of a bug in tcg backend?

Thanks,
Pierrick

