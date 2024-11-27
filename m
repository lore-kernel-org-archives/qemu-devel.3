Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC92D6D227
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGN7H-0005iO-6X; Wed, 27 Nov 2024 13:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGN7G-0005iG-0K
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:50:22 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGN7E-0002lI-GI
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:50:21 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso76316b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 10:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732733418; x=1733338218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3pWNUDTJkDixw7kmpwCGA6gFUoiJv5rfH1reYtxDQIA=;
 b=A/JcaLacAVNq1SyH0SWMA/w/1DCc46PvZe/yl4ml8/IACtS0ZYYlGIeD+jninTpxhi
 XUtXkx64fFx5lVOclsn+laGyGOZ8/il2b8jMbuqEtMC+FqiLRQwF+3SjgDKmzkuScDii
 kY2AJaVrt86K9jAi9dWSaR/kYgS5vNg6G96inS67K+IL4Gsbh5xzgkW0BGImmS8hM/px
 01C18iWWp7JAICrZbn/m33pti9l8kjAETnaTGKcdUuP3ZC75qQsRKk6r8QNuFGAebLuU
 DtZrWUMkEyv6DFvzuXohHCTXv/OfTdUKVrvHBrM5WoCzVNOxozowtQxGvBZTWytaVxY0
 L0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732733418; x=1733338218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3pWNUDTJkDixw7kmpwCGA6gFUoiJv5rfH1reYtxDQIA=;
 b=enWkNeX0eDLNPBAAy6xcTT3QC5ZEsxxqD/l/2nUkXMpQ/Ut9J6Cg3rRICL7RluR8oS
 hEwHJ1kK4NVln8x4AvZrJa1TF6Pl+mGE526jODNZfzyeVVXA2ArItRu94lqZvn7tv0rD
 b0H7WwZM1wXfBkPPJtDqptutf0B+iyh4D694XLOAoxcxQwqeuix/6obuvPHTw+bIm7mI
 n3o9FjIh1zFgu6fRQpF33/gKeGNun9HJNdVdwKvcoBVTf5yYjj1idm4qePAMclTP08JV
 m32AOYniO/I5GqfH6x5uaD7VoCVZyrk6EpKFKYVKpcuIw2NlkXXI5793t3vnsRfGB2C7
 XCXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCHgHnZqx1esTA00l71cuG0sgvsApfQt5zTtPO/JQJ+yPkAKcoSAgavA9FNUl4LP6xaL1PIPOER5eD@nongnu.org
X-Gm-Message-State: AOJu0YwXQCVGF0GeCTlu7yzYCiIhYyzDjaZ4/dhIyKWgB4Pmxt/oK5Rh
 2t5EKYOT/4vLBUTEscVzIVyW/O6ArKBX4fHlY7L8KMDqHMie2ITg+R0Wk7YgxMA=
X-Gm-Gg: ASbGncvZ9JB9FLjXI+WzEMIMoJMxWhZQqR3r/qvMzyPCZDly42H+HoqhIbkDGy0kSgm
 SAItq6wmDSj+BR/Rpm/6GKi9BwQgXMjn5cJ+K3IcryLl6EwwlISUeawyRxfQI669m4X0BVQB1LM
 oWfgsdP7q2TvJNy1nX38pdnQnMyYiOmue+n/K2kkysBgSwrZlEeTadjkrsgstCLqCgiKYouQUyE
 It3ob3Atx8c9fFqH3V9ESyjgqdd+CrTbqwHv6gg6th41m+91mGTGBUZ4zC5D/fE0Gf5cXKT6Eic
 h4Yl/FAgelZAWHddQA3cew==
X-Google-Smtp-Source: AGHT+IHiusr7jcI2woQH7Q83N1E79AV6/Xr95mptpFQ2I7kva56/nBed3wSMW+oJvpqmHbW0W0DnJQ==
X-Received: by 2002:a17:903:2342:b0:212:5d53:d02c with SMTP id
 d9443c01a7336-21501d58274mr47823185ad.50.1732733418615; 
 Wed, 27 Nov 2024 10:50:18 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129db87dc9sm106605505ad.7.2024.11.27.10.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 10:50:18 -0800 (PST)
Message-ID: <dd07a2dc-0141-41f3-8eaf-969103f7e05f@linaro.org>
Date: Wed, 27 Nov 2024 10:50:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: optimize cpu_index code generation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20241126190203.3094635-1-pierrick.bouvier@linaro.org>
 <e5c7e738-3650-444a-bfa0-af6fff4e586f@linaro.org>
 <7355ede4-390b-4870-a59a-a611350e9e3f@linaro.org>
 <c6f0b85c-a72c-4341-9df8-9d3046b135fd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c6f0b85c-a72c-4341-9df8-9d3046b135fd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 11/27/24 10:27, Richard Henderson wrote:
> On 11/27/24 11:57, Pierrick Bouvier wrote:
>> I noticed that it was redundant (for user-mode at least), but it seemed too implicit to
>> rely on this.
>> As well, I didn't observe such a flush in system-mode, does it work the same as user-mode
>> (regarding the CF_PARALLEL flag)?
> 
> Yes, we set CF_PARALLEL for system mode too.  We do it early, because we can tell the 1 vs
> many cpu count from the command-line.  Thus no flush required.
> 
> 
> r~

Yes I saw that now, we directly boot with the given number of vcpus, and 
they are initialized before any code generation is made.

I'll remove the flush part in v2 then.

