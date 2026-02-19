Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6489E9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7oo-0005Ev-Rt; Thu, 19 Feb 2026 12:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7oZ-0005EP-Mv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:27:47 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7oY-0002pU-9K
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:27:47 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-824484dba4dso1053406b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771522064; x=1772126864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NoGUW8O9AdJiHGjYIjm6oIYRWJBTn7GVjZyJ88YcGU8=;
 b=QNr0Nsu/WrQiCOJ04CpXB+X3juT+yc96so8F8FbfWrtdhI9CO3yemjGSson2obiU+L
 36x3MoW2/69YqR0Hbe++bk4y7oWoPbP2HfEnE0RDv8a20SNqzkmTxJwu3b6hhACV0FeK
 W9KiF718J/QfzZLQnqDVd2OwXPrXMUWupXDw9n9h9REq/bzPN5RVL2EEpvuoHqwG9brG
 qyWumRP8LwNfaNqllYYbZ6m0F6spS+pbQ3NqSL0tcsRLq6T8C1TnV5It07HdsebrE8Wu
 z6Tk1lFYdb2vtkIFTBjE8MzNnmlsRY80CiPwqSqGkbcDp8o/Ul+ofSXr090XXLgTylmZ
 T8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771522064; x=1772126864;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NoGUW8O9AdJiHGjYIjm6oIYRWJBTn7GVjZyJ88YcGU8=;
 b=wM+n08cIFn2TAiS3O4NcunSb5i+6pvj2qJ5ETEroLYFFfn+zd2mNgr652z3EBZ0/bF
 S15XLIETDOTm7QwP29ETzr1ro51oHIFzK3eaFF9cb7zLXGWKe1VwYOS6g1E9XUUh/Hga
 ecvmpCylp7SewewkOJaX2db6FJhXRFBOOyODTEvhPyq515Ny3r5Nb6/rZYPK2PuUUMhQ
 lIEpbmNHYaL/4bDBIHEA1ZAB6hyiXfgfwHBE40ALoMfKHLfeCQkWmCLn+cm5xQ+GtcZU
 TWbO1049cr57IGLhtHgiWkppXvMDqMX24kRfW1D2SP7sUM3J6mZKVD6TrXhhWfoyHgOJ
 krPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbbThF+f1cvEN6pAjzklCjHkWVtCpZ/TkD3lBnfb/oYqAYxj21OwKtpMa+ZMLXVL3ROf5zvBhyxzLV@nongnu.org
X-Gm-Message-State: AOJu0YxtxBEuM1TroOsl4FWBDn2KniNXEgnYF0H4Mz3ASVP8D5ExT6/2
 jOPQvwmcDqi3UtKwKEljKRsi1ISYtUFczbTNOMNaxeSBBFvwSWSLtSAB9u6vhekkD/A=
X-Gm-Gg: AZuq6aKfxnnjNr2ErEkKAt8q3uKz+lEeD4twg010Bpz7cOOUOpjhVIywk/MQFMnLndh
 1w/qC/ERxPODWSg94cYFpdPAEHdh4tSAAri2sUUlqPBtj6oaqrPIutlzNhBKIremtV9m3R0xXAr
 Jl3nrMS4kX5JdwCWqS+lEcoO89jC+Xx4SYZLY3fpOVPyzNlOHysnYi9m7CrF6dUTFXunvmHiaBd
 kVkjqGmFtZ0cLFucaynlELWK+jVCGgw4Z//9ZNnBv7DRIDmYgYpXixjTnhDbyEnVH/l25lwb28m
 BLZYQPpiba73OuOEJ1OEImVVWYSeCUJCpoT00IzMG2ucEmqQh/7RBWxlUNMXNwb8Gv5MF7bwjOH
 7gwb1vShnuK/KziN/DtPlbRhAsvpecCEMu1B7eAWToryEb84lfB1jJXI8/M8UGy+3jjRcmbPhiN
 CQvZToMVtrrzKzCkTiMtTcbwzGiMaeWjolIWZA00hYHZtKyqvQYsy8jFj0ZuYK1rZttf2W
X-Received: by 2002:a05:6a00:170d:b0:824:a182:1dd4 with SMTP id
 d2e1a72fcca58-825275ef38fmr5669293b3a.54.1771522064297; 
 Thu, 19 Feb 2026 09:27:44 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b9495esm19998306b3a.49.2026.02.19.09.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 09:27:43 -0800 (PST)
Message-ID: <9d25efc4-2233-4124-8405-35c8764413fb@linaro.org>
Date: Thu, 19 Feb 2026 09:27:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/14] hw/m68k: transition virt machine to
 multi-phase reset
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219171810.602667-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/19/26 9:17 AM, Alex Bennée wrote:
> We don't need to re-create the architectural reset behaviour now it is
> handled in the core m68k CPU reset code. We do however need to add
> support for direct kernel booting so we stash that value in
> env->direct_kernel_boot_pc and enhance m68k_cpu_reset_exit() to use it
> if set.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - re-write to use proper 3-phase logic, so dropped all tags
>    - favour cpu_reset over resettable_reset(cs)
> ---
>   target/m68k/cpu.h |  2 ++
>   hw/m68k/virt.c    | 34 ++++++++++------------------------
>   target/m68k/cpu.c |  5 +++++
>   3 files changed, 17 insertions(+), 24 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

