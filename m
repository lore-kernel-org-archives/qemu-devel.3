Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61CCC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 15:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbdT-0000fx-4Q; Sun, 04 May 2025 11:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBbdR-0000fP-MG
 for qemu-devel@nongnu.org; Sun, 04 May 2025 11:52:09 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBbdP-00039q-SK
 for qemu-devel@nongnu.org; Sun, 04 May 2025 11:52:09 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso4759736b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746373926; x=1746978726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FzJ7KBiUM62Kou2rvlVI27PREsZpJnLCrsZBTZ6Q1cs=;
 b=UECxmCSimBgH6IToI+1vGoM6pDWD7VAgehm3o1JohFVEG8eHF0KKMwT6F0qj/PulkA
 uCqxnDc36TUKoSg1Xz5JQQwBsLuDTGpafjFhZWyQZizTGJViNs2+BGTlJ/B2oqA8pnvw
 UUltpP3OCdzTZqaWR2K1POUQX37M5ujhQigTIutr2/ReZbOwt32lZzACvqofaRqiWuIs
 bfQECkiQM1fWo1BYcTWk4jvW/hbmj1VQW8eOufhLZNHxkvo77BAsoafGK8rKqcZweXFp
 BPSCUxobN8qWUaFBqgcws0y9XGuhl3id7D2j+ODAVrfvDDoT0oRvEMX16EDyq/8dHsNA
 3Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746373926; x=1746978726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FzJ7KBiUM62Kou2rvlVI27PREsZpJnLCrsZBTZ6Q1cs=;
 b=BCPbegNFennXvZ1W/VsJ73e+D+TXkIa0vkR579jlXQTMKQV0xuRKaoTxS6ywJr0WcN
 c+YxtBunAtgSsRk2XDA57wldyBA6H4UvHW4GKpoBDA6YpCvMXTR7POkMg4rNVWQDFy17
 WPCg5jQQGoCVqrtQgbr/+4cE/gyuExx1WzDykBi9/rw3yl5oNAdtRUUgIl0yhHPbVAzr
 M5H5HVAJA8aMTid8hH7hj/32JZ0HWvtDP3b5AJoqDSeEM/k96NQxMOV/GVEWTEr3ElEX
 yEmXALn+n40DKrVW/d1Js+ZdHTjFp0ULBO8iJkoTuBKzVi6VUIBic7iEsxNyn0Bty+ZD
 zbdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV3LLDZjoJdJdReW3Ckz67scHlnrahM+rP0vzHpwKjY7QtzWgYsoxBglMWYVeaVyNJGgn+uqch+zQm@nongnu.org
X-Gm-Message-State: AOJu0YxNSXaH+IpzTDQAqS2XrtXy/xpmKv7xHyF1WFaZOFuwyGXb/iMt
 PjygL9jscDqDLUN9XUm6w30BsvhbTYjytL/fbE/el/oo4RU/Obzz2QNAg9k6DU0=
X-Gm-Gg: ASbGnctgwNVa2XFTi8v1IJotYe0iUsiqIMmbSVlgBYjpH2MaCBzIm7ipJothzTx3i93
 Jl7vFUgyvt2xWJB89B5fVJuR4syAjAvjr2awnHcZ61aDSCfUx8XKhpTkJQ8s7BaZSip418fj9jZ
 J7+Q8kgTZ7hu3jJ3VUrxUwU7u5lMLX62QTTs3VvuXixVKJhgioRyvs1zug1O1qlcAgnFPng/gmJ
 g/0z3AaXhioYAngtWwncDy8L22LzUYaj7E/bfHAC3JejrvoZTZU85pkXEPj3aQN0xeC0wFGuTju
 S7ua8NHyXCEDJDOYCWI3tDyrR8OdmK+19cPhKpDbNtL0xFryo6MnJOQ7QTugAAt+4RDM8tV1iMv
 mO540l2E=
X-Google-Smtp-Source: AGHT+IFVnnGElWZWktJSHhHrK1YBadBJiOCAhPHj3KmwBboK7qXHH78eZTQ8uPZhXv/BS1Ff8Cq9qA==
X-Received: by 2002:a05:6a00:1c9d:b0:736:a8db:93b4 with SMTP id
 d2e1a72fcca58-7406f092fe6mr6000996b3a.2.1746373926019; 
 Sun, 04 May 2025 08:52:06 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020dd4sm5003693b3a.117.2025.05.04.08.52.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 08:52:05 -0700 (PDT)
Message-ID: <866305e9-1751-4264-a984-7379bce6358d@linaro.org>
Date: Sun, 4 May 2025 08:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/33] target/arm/ptw: remove TARGET_AARCH64 from
 arm_casq_ptw
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-31-pierrick.bouvier@linaro.org>
 <a6fdb501-438e-4591-b166-87c8dbd14887@linaro.org>
 <3ba2f0d8-ce65-48a5-a662-f2350903a5c6@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3ba2f0d8-ce65-48a5-a662-f2350903a5c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/3/25 15:48, Pierrick Bouvier wrote:
> On 5/1/25 9:24 AM, Richard Henderson wrote:
>> Are we still able to build qemu-system-arm on a 32-bit host with these changes?  It may be
>> tricky to check, because the two easiest 32-bit hosts (i686, armv7) also happen to have a
>> 64-bit cmpxchg.  I think "make docker-test-build@debian-mipsel-cross" will be the right 
>> test.
> 
> By the way, I'm usually using debian-s390x-cross for testing a HOST_BIG_ENDIAN build. Is 
> that the best choice available?

Yes.

r~

