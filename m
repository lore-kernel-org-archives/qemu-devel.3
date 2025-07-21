Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B20DC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 17:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uduiW-00025U-Fq; Mon, 21 Jul 2025 13:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uduga-0006bM-35
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 13:52:24 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udugY-0005oY-70
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 13:52:23 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-31223a4cddeso3575508a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753120340; x=1753725140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b4Rm8dbL9WQHbdp6ZMYCR3xDAu2X477zlz57sxDrILI=;
 b=kmD+KtarP4R04h3lbSYL2FC56ke1EPr3jVrldosifz7xEnn8IlkTdUMWurJgj/7Q28
 tdI4tlrQkH8eC7XulevxznnVsObs7HiSrRdtkrFGU6YAvDqZ7TYZDYj9GUGE8IHULK9y
 yF6RN01kvGIRzWUox9lSRanfUgFwMLwo/5++voPa4O5YbkOGU1wbYw2nw80AD1m0odx+
 fdlZzn7ohGiCrLyMLLGn9vbiyK3KLrH22N/4aDN36peFiSOo9X4x+AgUNZpHMTanQ2+X
 W8KsG0DKfrBplidNNPvZm9ZMbXIzg/lgZXkzrpEM8eN13lbOPsaD7wSetpk4YEEsEMUV
 noXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753120340; x=1753725140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b4Rm8dbL9WQHbdp6ZMYCR3xDAu2X477zlz57sxDrILI=;
 b=WU8rINZn/Jw79JGplwMd7MD7dMP90bdtMnz5O7ueVn9HOTtfFOERb3hng5BoqXPOTT
 EYAZFP96gkUvSBdqcUZeFOeKVmzxIiPvRPPTAeAJ/IkLhewLD3DBxEf3F7VtSu7YKndB
 kLaff2K356FgXbBtq5HuhvM1TSzCkOERJg3suYHJ95ctnSrsBXa58qERPQQ7oNRG4eNg
 3tEuBrwwIdKjXuEtSDfqQcnFpVvw6C3SmiSXS9G6jy0QRwUnu9qYrH3X4qQdgM+lUMRN
 6YW/HZqsiswIt1bNtpFlDyu5WVGIno0/Hc6v11QAK84NWKeTgteE0NgRbkARU3vwr7zT
 vRuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVejvM3cO/ce/eqt9nGlfePILec3PGmHQMNwyaXk5F5wVd9X2xxT5QUG5yFzFdFCbFtEfZtNO0loMF0@nongnu.org
X-Gm-Message-State: AOJu0Yzr5HemSIlw1qMTgX4VzWAAfOohJjazcF9MlcF3hh8u/fDKr8ry
 xcv1baV79Oaqt9QIrFScfCYPzLTrsOv+1ygGRGiFjvlbAufyMo8069IDf6MSetNtprs=
X-Gm-Gg: ASbGncs3AvmFjisA4IS2ATP+KkKiVXLUl/Q9bH9XTcEmWuAlhWAXAXrI6jekYvLntnS
 bi1BLIVMP3GDAS4/Hxo2zvIBg65qe2jZc8BgLSR9OwkawC4bk5/41HjFUf0bHwCD0W1dg/84/hS
 ZTAK6voILTFzKCkO/etyDaVrYmJyeKPIpUEyyFMefMQPR5wMDAMpV/akrM2v16i6gEOQjdsWhwo
 e9rT83PQijxzcutf9xhSoXPksANKZOpdkLCj3afqWA/Sb540Kk1v0rX+JzlEhzyvGNaV6OSl8Pe
 TURtuGveQ1l5P9XZi87NygMzoiaedan/eri6/J4GauAvUTW1RbNomSu+uAXiJdK09bpI43FrIrw
 9yvX4NAHHauq2uCmhaNBg8lAKnCJsT7oNerc=
X-Google-Smtp-Source: AGHT+IEgYh3+/LAOGN5/Jv2rf1dPAEd9FEluqHqJ+wTOQrPBgQY2Npbj/iToMTiYAfzjFMqYmgqWEg==
X-Received: by 2002:a17:90b:254d:b0:31c:3c45:87c with SMTP id
 98e67ed59e1d1-31c9f44b592mr26940236a91.13.1753120340337; 
 Mon, 21 Jul 2025 10:52:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9153a899sm7640792a91.0.2025.07.21.10.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 10:52:19 -0700 (PDT)
Message-ID: <1ab1dfd2-9cfc-487c-8a27-f8790ba4f770@linaro.org>
Date: Mon, 21 Jul 2025 10:52:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apparent race condition in mttcg memory handling
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Development <qemu-devel@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <abe00af4-3af5-4c6b-8443-b7350a4d9349@tls.msk.ru>
 <96201a23-784b-4268-b011-a6912175d237@linaro.org>
 <c0878723-62e3-47cc-810e-6ba8a0bd30cd@linaro.org>
 <8a50f07d-ef0b-43b1-b49c-335ca6a7ff70@linaro.org>
 <bd3c403c-6aa2-4583-a50a-5cc5fcaca2b8@tls.msk.ru>
 <e1272431-f38d-46ee-8140-38e2c3418399@linaro.org>
 <CAFEAcA9zM1+qWLhfErnokzzYWbnMizKLfBe_Be-AqrqG72c7jQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9zM1+qWLhfErnokzzYWbnMizKLfBe_Be-AqrqG72c7jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 7/21/25 10:31 AM, Peter Maydell wrote:
> On Mon, 21 Jul 2025 at 18:26, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 7/21/25 10:14 AM, Michael Tokarev wrote:
>>> rr is the first thing I tried.  Nope, it's absolutely hopeless.   It
>>> tried to boot just the kernel for over 30 minutes, after which I just
>>> gave up.
>>>
>>
>> I had a similar thing to debug recently, and with a simple loop, I
>> couldn't expose it easily. The bug I had was triggered with 3%
>> probability, which seems close from yours.
>> As rr record -h is single threaded, I found useful to write a wrapper
>> script [1] to run one instance, and then run it in parallel using:
>> ./run_one.sh | head -n 10000 | parallel --bar -j$(nproc)
>>
>> With that, I could expose the bug in 2 minutes reliably (vs trying for
>> more than one hour before). With your 64 cores, I'm sure it will quickly
>> expose it.
> 
> I think the problem here is that the whole runtime to get to
> point-of-potential failure is too long, not that it takes too
> many runs to get a failure.
> 
> For that kind of thing I have had success in the past with
> making a QEMU snapshot close to the point of failure so that
> the actual runtime that it's necessary to record under rr is
> reduced.
>

That's a good idea indeed. In the bug I had, it was due to KASLR address 
chosen, so by using a snapshot I would have had not expose the random 
aspect.
In case of current bug, it seems to be a proper race condition, so 
trying more combinations with a preloaded snapshot to save a few seconds 
per run is a good point.

> -- PMM


