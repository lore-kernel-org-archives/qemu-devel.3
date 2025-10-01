Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172C8CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v41j1-0005RC-Hm; Wed, 01 Oct 2025 14:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v41in-0005L5-BQ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 14:38:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v41ic-0007VY-2S
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 14:38:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso957775e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759343902; x=1759948702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3/bwK0Puit+/BlxX00s7LpTO74tTRI4xjl/ObzNkssw=;
 b=yJnhzy+4hs1zI5Zboa7tzn4GvL7v4jIlqMrxrqABCClJaSWqhmBKF6IeS5uFP4xQjr
 sU1gpiPfjvJB4aS4w4rlz5L1yCI3DBd3hM1JTeBEbZvD9zCs6ic2LFLUp1gUD2x1xpGy
 ATbeZFHTBO24asKSi8Gypi5KqPWdOA+aRL+EjVxhP5k3HqKE0rQCeinx6Q+V6/YNK8A9
 CSAhjwP7R/nkGbQz3y1I63m5wWtZfSzV9sMSlMjVWUO256oqMz2NRoa9vZ5KaRaiIO0x
 wLxv4v5XM/v0dG7W/ngWNErZxrRyeJ2R5C4mycEG26JseYkDE9px6k/pwu7s8yubsdeA
 8LTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759343902; x=1759948702;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3/bwK0Puit+/BlxX00s7LpTO74tTRI4xjl/ObzNkssw=;
 b=Z1TKkbm/ZWHHzih7Ws3dx0OQDOsbohBHbbza4YTiwqlRg4K4GuRCPQEZD9TFouZ8Pt
 QIAOXaDlx4znWXd+DuoqbcGOSFFpeBgTqui1IxCbx3hozN54kaX0R75W5E2y5ZPCNw1A
 T05k2B70cKheGfYDUJhvVpuuWz5Mug88q6Ao/5I2P0u2Zz6JXN56yb8lwC42Mb7191m3
 ri6FIdWo0dnPWgRSUfT7h44hnafDKPV2EmHQ7SHE3ol/6Fz+YK1SPHFjaTJft3aiwA8W
 y1fKzze1Sqptjw83GXUc9TxrXyExNl7Hego8pB+VSZS4iVmtjLNnMNGMDMJRc0gbvLG7
 V32A==
X-Gm-Message-State: AOJu0Yy1/N7+GNji39CiGUoWdK6LtY6TD0LlsutRKWBQ7nnQWv4DNYtl
 joowJazymyQxV2DBS7D1zfMmjepPOfe+J1HZ6Kn5rofyPTG5obQWmaV1y0FqmFt/tz0=
X-Gm-Gg: ASbGncvwie9Y0Fd9CA6RzKUTVQu4LJ2r3sJjBi/bzqdiCoYfjSw3lDRDhnr/1iu1hmV
 hji6lFssQ7SMV64bTxhMK2cxXYIhqMuobx0pW/m9P60JBGIkqT++7B1Z2La1FGvg2SCsftM+ZMm
 srEy9i1cj5AC5jnsZPjhFukoYW4yL/ljbn8yuUfidJcqxXq4Ep+EOvS7FdZ0OgvqKMub0DwF4XI
 i6wau14UtKVOn2m96gax3Vrb+OtNrTu1Td9zcPmDyy8r275BgDE8EAZWbIatI6Rofl2EvS9w9Ks
 FdMJ4Wt3OXPq5CyqaaOtZM7O3iAwUro3cK7l3FxRjwBc2YGAoNcccxuJBhJpfz5I8/lfAyqMHhU
 t4mgsbnK0sVgvuZOQfPhbievxhjP6fAbAZD1kHGT9UfhTmTKyI6TTXFWC6e0Ne45LEnra7RIGh/
 zoVvmkxX9WZZyKm2HCFww=
X-Google-Smtp-Source: AGHT+IGx6UiTpbvYa5RVE+Ww2cUlmGQoD+6deTu6MRRli7uzDzb8L4c1jhtw/9ZS+I6gAwit2m2h1A==
X-Received: by 2002:a05:600c:c093:b0:45b:4a98:91cf with SMTP id
 5b1f17b1804b1-46e61faa217mr24206275e9.15.1759343901417; 
 Wed, 01 Oct 2025 11:38:21 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e675b557fsm25329725e9.0.2025.10.01.11.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 11:38:20 -0700 (PDT)
Message-ID: <5556bf04-0a3e-4963-83e5-a7ff25d65567@linaro.org>
Date: Wed, 1 Oct 2025 20:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] hw/core/cpu: Remove @CPUState::as field
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, armbru@redhat.com
References: <20251001150529.14122-1-philmd@linaro.org>
 <CAFEAcA-daogqBPxt72qTM6BuMuD1wuw+vXZwxLUQftwY2FZk=w@mail.gmail.com>
 <b5280074-e87c-4838-b816-eb9e42dd090c@linaro.org>
 <2a53049c-01e2-4f0e-ac51-f55d50173b22@linaro.org>
In-Reply-To: <2a53049c-01e2-4f0e-ac51-f55d50173b22@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi,

On 1/10/25 18:42, Philippe Mathieu-Daudé wrote:
> On 1/10/25 18:35, Richard Henderson wrote:
>> On 10/1/25 09:08, Peter Maydell wrote:


>>> Targets that use multiple address spaces need to be careful
>>> about which AS they use by definition. Unless we have a
>>> track record of code in those targets carelessly using
>>> cpu->as when it should do something else, I'm not sure
>>> that there's a benefit that makes it worth making the
>>> "use the one and only AS this CPU will ever have" more awkward.
>>
>> I agree.
>>
>> Moreover, '0' as a default is just as bad as cpu->as, because you're 
>> giving no thought to the selection.  Similarly using 
>> MEMATTRS_UNSPECIFIED.  When such things matter, we need the real 
>> attributes and/or as piped down from the proper memory reference.

W.r.t MEMATTRS_UNSPECIFIED, is it better to have a legacy API using
it discreetly under the hood, or have it explicit by using the
recommended API without changing the default values?

To kill a legacy API such replacement is worthwhile IMHO,
otherwise the code stays in a limbo, we have issues with
developpers using different APIs / styles, etc. Also maintainers
are Cc'ed during conversion series, so they can suggest better
replacement for defaults such MEMATTRS_UNSPECIFIED.

Regards,

Phil.

