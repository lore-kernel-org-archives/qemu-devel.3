Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A297C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzpx-0003Lf-N8; Mon, 05 May 2025 13:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBzoz-00038E-7x
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:41:42 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBzow-00086Y-Ts
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:41:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso4673613b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746466897; x=1747071697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ew70U3lTDz5hC+3m9yRbzo9z4bHliR8+n+FYQbakwuQ=;
 b=wgoqSoyIuP6t+g1tZcN0A1KQFMPmG9lGB1HEcGWFmAcSZkLD5ZOuZmv20r31q2zU8b
 FoaMHOCLzz/gU74YUBCSoTI7jU7BN1HUz8x0UaU2XgCMuIr1zJ52O9ILCj5RJ7Bqi6/W
 SboRDXTmpqCX4v+M5SW+1kDhuj9cjRND4WYe7v2OFdeiEilhebpI78fhLn7CBabm9+qS
 4/ABTON/XmAMyEjt/t/QoF0+ZLHaRLlWEahiIglGVSbk/KW/pXeL69YJ+AyP8bFfqfme
 c6j+AytVrixrAqubhDCupIn1wVvpJ5mOIpCsCWn2W050eONXZf8WEej3H+3xXjY/aACM
 fEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746466897; x=1747071697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ew70U3lTDz5hC+3m9yRbzo9z4bHliR8+n+FYQbakwuQ=;
 b=A5LhM0LJQlAPQ7uR2TzVQy7Pa6JADJxy4ECV352PO/nDdAIauG52dksqDVpxZ7/jMi
 rwndAhD7mQdsBIblv+bbUeaosxeF8DNGKbIG+H2+SjerqBahsg3j0Olna0hsAZS8TBhJ
 Z5Azv0lfanYfsz1wLks8I2Kp0IensL4+Xxke9ZNdFkzbKE1uHCjeCU68Nv5nZQwG/2tH
 PsrqZDZBj+Ko2BTtZYxah7PXiZphWGKixgsksZVJQa7IXEKEl0wuHZioTSSA6o1rofiK
 UEacn52HNxq0lt63Gq5XdguN2nU4BAfugbt2+wLhbZ+SKnnmUSlYR7cpOA+Sn9pW9AP9
 sCQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx/Q/61phK7gY4HibLK//h34hxq1Cr/hmTYmjOg5H044SrUuPensVnDmBpKu9iflD4a06eIwEVbnSX@nongnu.org
X-Gm-Message-State: AOJu0YyZwpMZS5/7CwHhvDgibsk5sAX0gvqUt/K/MnPQ+6KyUJa0mRTY
 JNbrty00pscNNpuFv0l+SE2jipFXdvynTNaYuqwtct7tNUoIfVc39nYZDYgT0CY=
X-Gm-Gg: ASbGncukDz29ri0USkmOGjogJZT+ct4IwEQwCcsu9hRk78/HopQ4YKibfGahh6lw0xE
 SNWd9ZFrp9uBvJLj/qzdvQQfNG83g2IDZsATJmruinP78GF3Ja//tNbS8IWMyB1LhDkwJ95NjYY
 HEXjIO5+nC1bwn6uTSOEE+K29mgpovZxhE5CSySF/ZMjCGhPKO3jZfjPbiDBvxphppwNSmrHO4M
 b4m0/pxevxFnYmUxThMIMX9VMZO7yWThQfT8mzCLd8SXC9qK/CLoqVu29itjq6ba2TKSyEMVa5K
 CYYxH7/Oi9mu6opNYZw+aJg69j6YxlmYxli9nXkqU95wZQojIZEBcA==
X-Google-Smtp-Source: AGHT+IFXaEzxiofDDELYqsPn04eZnaz8QiBcTf59KURdaK3Y2tALU7ijUKo8RT9o0LZf1B9L0ObdVw==
X-Received: by 2002:a05:6a00:1d8f:b0:736:6ac4:d204 with SMTP id
 d2e1a72fcca58-7406f0d9ea2mr9996738b3a.11.1746466897088; 
 Mon, 05 May 2025 10:41:37 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590238f5sm7100162b3a.88.2025.05.05.10.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 10:41:36 -0700 (PDT)
Message-ID: <4e7c2d18-dec2-4a49-9f1c-35e057ba8874@linaro.org>
Date: Mon, 5 May 2025 10:41:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/48] meson: apply target config for picking files
 from libsystem and libuser
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-5-pierrick.bouvier@linaro.org>
 <857f0b9f-e58b-48a1-87af-49c3c52b379a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <857f0b9f-e58b-48a1-87af-49c3c52b379a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 5/5/25 9:59 AM, Richard Henderson wrote:
> On 5/4/25 18:51, Pierrick Bouvier wrote:
>> semihosting code needs to be included only if CONFIG_SEMIHOSTING is set.
>> However, this is a target configuration, so we need to apply it to the
>> libsystem libuser source sets.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    meson.build | 26 ++++++++++++++------------
>>    1 file changed, 14 insertions(+), 12 deletions(-)
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I'm not quite sure how this is supposed to work.  It appears this compiles everything in
> libsystem_ss, and then later selects whether the individual objects should be included in
> the link.  This is fine for internal CONFIG like SEMIHOSTING, but won't be fine for a
> CONFIG that implies external dependencies like VNC.
>

The trick used in our build system is that static libraries are never 
fully compiled (no archive is created), but everything is done by 
extracting objects matching sources available after config. It's a bit 
weird, but it works. I understand it was done this way to avoid creating 
specific static libraries per QEMU target.

Before this patch libsystem was including all object files by default 
(thus the link error with --disable-tcg in Philippe series), while now, 
it selects them based on target config, so it's a subset.

In short: Static libraries in QEMU build system are just virtual sets of 
files (sharing flags and dependencies), and only a subset is included in 
each binary based on target config.

> I guess we can think about externals later, if it becomes an issue.
> 

Most of our external dependencies are not set as required, so if no 
object files selected uses it, it should link fine without the 
dependency being present on linker command line.

> 
> r~
> 


