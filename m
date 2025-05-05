Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658F3C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzA7-0003RQ-BY; Mon, 05 May 2025 12:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBz9w-0003Pf-A5
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:59:17 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBz9t-00030p-5V
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:59:15 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af5085f7861so3213738a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746464351; x=1747069151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U9OTFqGp8mCWvlRmY2T5kbkW+mv+S6TaxK3o9YJyPUs=;
 b=JjWRuQT9JX9Hvz7kDLQ3N8AgUykgk4+muERnrAJyLLbQBKqub3pKiDAgsm2PrjNGHf
 ra6t60zvhPLi982YmajNcQVwC37TrAAZxPzAnCAgOVXVMkeMBKhBimen+gitGoUhvgx5
 CYPtCpLiAOjlaC8YLOoYo5rVj+JHlk0jgvEdz1Ju0zKi2u3wWfb7eOlsuHNAbyTzyEsB
 Ovnlud1OR63wvkGE9HXFXiu+IT5TbQO6vnRcE4P5l6ocsjANFg8rw9oyuNZtfP+LspAK
 q+W2NqxS3N/XIDT75ANr1mGFHoy6zdxSob3/LXpktFBNjsghTVDT8676C7T/w/nQMBQY
 wxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464351; x=1747069151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U9OTFqGp8mCWvlRmY2T5kbkW+mv+S6TaxK3o9YJyPUs=;
 b=Tg2nv/I/Y4ouvThsDEaw2unlwp+PDyRvKNIHvBcR6oWIBuIAncUuHLIvfC2mwHwrNW
 a9pZM5DOcIWHYVFybdU1npVC7VxiEi2GUjVDowPhs4LILdFi6oUWiBrL0kLjcR4HfUrb
 y/VUzZVfA3d6b8Uqyh0snOIPuA/6gkhsW6b6LxxdZC75bWcq3AGo6179/4MQ/QKuXGdG
 HyVkMlDcsEenggmQP/WKaG+zT0cRlhZmEFkB7SfzXcHhyY6AFnpZ32GWf3gKSe88MLRH
 4urzKVLju1/5fL+uRcmAJzeKbotDWR1+/Ix0FgaEpzgOXACvB9+SEeQy9XXR5pzd9kYZ
 S7rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJR3cTQw/5VW/39dBpUZoLt4jGN/lpbR97Tz7N8GtwUjFQN9zNxxnur4xyHTY0sANpa3UuU/tNHH/1@nongnu.org
X-Gm-Message-State: AOJu0YxnVwlGitKMe0dm6RxTEoVvHOWl2AEMJna6gP6NbhGpyKIIV36A
 5BTePsFpDA1A8JAOriHgck732OWJ4+RRmL2ifwl6vwaW2Yv8vAzBNR0Vdq7x2w4=
X-Gm-Gg: ASbGncvXfwbktvkClpgwa3HFcqbXY+LqoxTCYSo9L+K1VUKspJgvIkmxrdLHR4lL3kn
 FcBMMwjkT227piriJSnVJQY5eJ3Lss8Foj2yttKCyjU+2IOc64NUpQWCp8rkQniZzbvTldlERhL
 Xye5cogVByix3M2FmLKiTwhIj7ftbSN7C1ESGYCkkZFqxtitGwooqLsGyNUvMwHmuBJNrXpoCEw
 xsH8AT24AVvOa+cyuTo8Ozb1ePhjnt/Te1cUNW1Qer4/ccktdRBfECWT6rgV1XZzHvfjiUnRbhA
 cweVC3pwqQgMGRR4NUlgqppF7yeeei4etTFWBhrUnI5+b8RK7W56InUcPt7Byjbi9p9vIlqCkP/
 PENo2MUM=
X-Google-Smtp-Source: AGHT+IGV4mvjBxjuUac2hqTkiakJrNcMLiL/yCT2vwZCoMaGvyR+N0l58cjWbCbjip6vwNGvfemS6A==
X-Received: by 2002:a17:90b:520a:b0:301:1d03:93cd with SMTP id
 98e67ed59e1d1-30a7c0cb75bmr202365a91.24.1746464351450; 
 Mon, 05 May 2025 09:59:11 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34748935sm11971734a91.13.2025.05.05.09.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 09:59:11 -0700 (PDT)
Message-ID: <857f0b9f-e58b-48a1-87af-49c3c52b379a@linaro.org>
Date: Mon, 5 May 2025 09:59:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/48] meson: apply target config for picking files
 from libsystem and libuser
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 5/4/25 18:51, Pierrick Bouvier wrote:
> semihosting code needs to be included only if CONFIG_SEMIHOSTING is set.
> However, this is a target configuration, so we need to apply it to the
> libsystem libuser source sets.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

I'm not quite sure how this is supposed to work.  It appears this compiles everything in 
libsystem_ss, and then later selects whether the individual objects should be included in 
the link.  This is fine for internal CONFIG like SEMIHOSTING, but won't be fine for a 
CONFIG that implies external dependencies like VNC.

I guess we can think about externals later, if it becomes an issue.


r~


