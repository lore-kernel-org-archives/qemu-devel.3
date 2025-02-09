Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336C1C0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 18:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thCRU-0003wd-OR; Sun, 09 Feb 2025 13:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thCRN-0003wC-Or
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 13:54:02 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thCRM-0001oD-1X
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 13:54:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso35878155e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 10:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739127237; x=1739732037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/OLdNjHEjfOqTMScWyjsiUV2YXHaIx+Pfh4IOnlGvuc=;
 b=FNCgXn6mgSemB6aG6Y5EEWYmsFe3L0/Y1XHvGUbDNW+VEx/qe88gOyLMFh3rEeru5/
 4pwXOG9yXIBX//htqjKxCq6zsboXOUwpdcKwe/VLWjYg4b7BTNQ3fyVszlB7XYJDElUD
 nyklM5CP2rEMhHcTYtxIZeJCUaz79IUpuQbJGLMkm/dM+lBtCrPH/xhBJ1ARyXd/1Mzf
 z9l/ArPYFl+EDFp+bZKzKrjEgyjk1pk2wSkjpZyPsM7D4JYqDXU/eGD9lQ5uxftO8nVu
 CmZVjGVS6rcRo3/uzOd3qUhOyhJFPls7SyVflPgp6ocYUgtwZyw2xYmkVaslPN2QpSGS
 Ogug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739127237; x=1739732037;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/OLdNjHEjfOqTMScWyjsiUV2YXHaIx+Pfh4IOnlGvuc=;
 b=uPwOmRFIocLWpAO/eGduj55+vTRGWh5TULMUnVSumvYW/kElhBdjGD3kvFJf+ZYnKq
 UinF5GYNY2EC4UkYqL+Oi5cFiWgOIDmifxAJ1OdOBLCmUSmnenGTdEuhL6PxOM2Wv9PF
 bQUFzzyAxZVDVl5cHhSF3LWntjvi88pUvfXUofQgUnxBocoBH04WuwsIc6BDd/c3aMgZ
 /qZpV2lIrYZ2ATm+UqcjsXuXQpAniko8vSeQ4kekHOs7sC5CrKYLsJc4mi3fUZMqsYKX
 FvhqGjgvIkaLG5ZiF10l/XZTvp5PaRAy/TH5iYb1H0qlP2L/n3Y4NvsRJy+rlJLwcmAs
 y0Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf4gkoRm/S8pR2fYDVqaSHcmQTnMf5neMfILW1LW+5JY4nnXqLjHJ0Q5f8tZw19apKtn8qfSbnaJvK@nongnu.org
X-Gm-Message-State: AOJu0YwjNY3xWs76kgSZsz6/CnhMnxCv8K/DQ+8rsW+iMuEI3U03U+T7
 HnWXmUt3aIjtw0j+e3MVoKqy37Te9MHXU2+b0X2p+6N6JcUKh+tsoiju5l60Nds=
X-Gm-Gg: ASbGnctnBqUI3wn/8SBq5sAnCVp5HqBBzemaY/C2SZHME9XsmoFAzond7xzoaS+6FVP
 NSoNyk4QMfczoibeJkdvEvnLb0UwWEI3MMF4QxYeU63wihYoiK62+BS1dltSgHY0Sx7Oe5YRNnm
 oGrlmnnEd0IcBhhX2a2FTCvIDzDiC+1ONZ+oTpPoGJ1YuInvW2qK7w1oS478aaSsnzfQqT9FB/+
 U5UYTGL60KneCQVQZx4mGGJXxuZoSCa2T8tUKpcGPIcPow+XJIJ4khppUpRqfFF8DGPBIuLkqU/
 YpgrdgMyqHToFDtpQ/3pTETKhC1L640DJGZpRWuxNjFCHs0t2UhTY8G8t/hyeesO
X-Google-Smtp-Source: AGHT+IFKDSU/9bdaYLp0jvhY6G4SK14nrXtH2r/Em+hsKX01zieUoOmUwJuBc5Qd8s9SCGTcMN3gBQ==
X-Received: by 2002:a5d:47af:0:b0:385:f6de:6266 with SMTP id
 ffacd0b85a97d-38dc90eb26amr7526067f8f.24.1739127237563; 
 Sun, 09 Feb 2025 10:53:57 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dccc1f531sm7036827f8f.87.2025.02.09.10.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 10:53:57 -0800 (PST)
Message-ID: <60d03735-35ae-4f96-8914-0049216eaa13@linaro.org>
Date: Sun, 9 Feb 2025 19:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] target/riscv: introduce RISCVCPUDef
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
 <20250206182711.2420505-3-pbonzini@redhat.com>
 <f4ec871d-e759-44bc-a10b-872322330a3f@linaro.org>
 <d375a630-d136-4e0e-9103-fd4dcb1e03d7@linaro.org>
Content-Language: en-US
In-Reply-To: <d375a630-d136-4e0e-9103-fd4dcb1e03d7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 9/2/25 19:44, Philippe Mathieu-Daudé wrote:
> On 6/2/25 22:16, Richard Henderson wrote:
> 
>> It would be nice if this were const, i.e.
>>
>>    .class_data = (void *) &(const RISCVCPUDef){
>>        ...
>>    },
>>
>> This will in fact create an anonymous object in .rodata.
>>
>> We have other uses that do the extra casting away const,
>> e.g. armsse_variants in hw/arm/armsse.c.  Although I suspect
>> *all* usage of .class_init can and should be with const data.
> 
> The only non-const use I noticed is Xtensa:
> 
> static void xtensa_finalize_config(XtensaConfig *config)
> {
>      if (config->isa_internal) {
>          init_libisa(config);
>      }
> 
>      if (config->gdb_regmap.num_regs == 0 ||
>          config->gdb_regmap.num_core_regs == 0) {
>          unsigned n_regs = 0;
>          unsigned n_core_regs = 0;
> 
>          xtensa_count_regs(config, &n_regs, &n_core_regs);
>          if (config->gdb_regmap.num_regs == 0) {
>              config->gdb_regmap.num_regs = n_regs;
>          }
>          if (config->gdb_regmap.num_core_regs == 0) {
>              config->gdb_regmap.num_core_regs = n_core_regs;
>          }
>      }
> }
> 
> static void xtensa_core_class_init(ObjectClass *oc, void *data)
> {
>      CPUClass *cc = CPU_CLASS(oc);
>      XtensaCPUClass *xcc = XTENSA_CPU_CLASS(oc);
>      XtensaConfig *config = data;
> 
>      xtensa_finalize_config(config);
>      ...

Which I suppose can be fixed by calling xtensa_finalize_config()
somewhere within the class register:

void xtensa_register_core(XtensaConfigList *node)
{
     TypeInfo type = {
         .parent = TYPE_XTENSA_CPU,
         .class_init = xtensa_core_class_init,
         .class_data = (void *)node->config,
     };


