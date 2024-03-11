Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095C8C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeLJ-0002q4-Rp; Mon, 11 Mar 2024 08:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjeKp-0002au-8a
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:00:54 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjeKi-0004g9-SQ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:00:49 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-51344bebe2fso2781399e87.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710158443; x=1710763243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGAQ9vkbliJvxZscO7R8k+WrJmN8Sgb45sar6P183j4=;
 b=q7P8pE7CTUlsJQdW/OA9FlhVceZ3MDbHlAPtdpgq7ydp5pQJkVoi9OcsP1sOTt2X8T
 v+x7gEF2RXuTDGu7ndY81d536AYz8P4kFlNLQEpIe+Ge3vdG8lUS+4ypUaxdYxIr0NRZ
 83Nct+UKkRGQdDXtgftRr/Tl9+sj8gwvWJE9dKMXx6aUG8dJr9y825YiuHX2XTN/nbLx
 GK2n+g10/ClRfsr3XAdOk9OhOKPOcEZ6PB6XbB0jH3jKgVEp6ewpOZQzrzRTuoHF8o2g
 k2vZ6Ny/rS0w2Vc9rjRLgoB2R0tiKvP7l2lvUpyOs2nimrd2v78G3v/p/HVz/w/PKXOd
 Ppng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710158443; x=1710763243;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uGAQ9vkbliJvxZscO7R8k+WrJmN8Sgb45sar6P183j4=;
 b=fE31Wiv/CS9RKXLCGinyKfbpYpVX3ezaL9dbD9KwbCEEGx/hjgyLwai6fqtDzJ/Rcp
 /wF1zrxh5RZ9wdZijHHgkH0jvuYhcRfSFkjlf524hCwtflAnh+LSdgaYHDbGxypZPsqw
 J19OwKcGMSYrLiHpBGg7mFJiODpCVpNAUTXjcqrg+Gi+hacztllCwHIFyCldd+4OPDit
 l2wij8fX6Y7WYOXEOXzZO5E8b5EZZATzfNJmaKgcQH0e3SMQxHc9hKB8034C0ru6ucjt
 Ni2Bqvs3DUADQRkAxc+9Ta09yGWO6b8jgGdQyydU9drh5AUtvhd1T5e9tt4mE6tndLO2
 hgNg==
X-Gm-Message-State: AOJu0YzAlH1XlQKEZFpDMN5lww1PDp7ouWSI9OQcnQ4pgCTkSgYpAIVR
 +FQkGss4Pwa0z50dBZ+lkHFIQChWvLO/vh+Nu/557mPRE9HKV8UOjsa5sZ9Z+zQ=
X-Google-Smtp-Source: AGHT+IEmNn6OBuOTVD+1Krn29J+oCHK/DUpZ2xMNpOYAMmUZuwIDpUaB4++aPnou20qv7NCZu/53JA==
X-Received: by 2002:a19:f703:0:b0:513:572f:88ea with SMTP id
 z3-20020a19f703000000b00513572f88eamr3453294lfe.19.1710158442633; 
 Mon, 11 Mar 2024 05:00:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c468c00b004130378fb77sm15625368wmo.6.2024.03.11.05.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 05:00:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B4ED5F88A;
 Mon, 11 Mar 2024 12:00:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 26/29] disas: introduce show_opcodes
In-Reply-To: <9db53a92-42bd-4bd4-9b68-31b923f7fc9c@redhat.com> (Thomas Huth's
 message of "Mon, 11 Mar 2024 12:02:02 +0100")
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
 <20240306144041.3787188-27-alex.bennee@linaro.org>
 <9db53a92-42bd-4bd4-9b68-31b923f7fc9c@redhat.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 11 Mar 2024 12:00:41 +0000
Message-ID: <875xxtq8pi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 06/03/2024 15.40, Alex Benn=C3=A9e wrote:
>> For plugins we don't expect the raw opcodes in the disassembly. We
>> already deal with this by hand crafting our capstone call but for
>> other diassemblers we need a flag. Introduce show_opcodes which
>> defaults to off.
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20240305121005.3528075-27-alex.bennee@linaro.org>
>> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
>> index 2324f6b1a46..b26867b6417 100644
>> --- a/include/disas/dis-asm.h
>> +++ b/include/disas/dis-asm.h
>> @@ -396,6 +396,14 @@ typedef struct disassemble_info {
>>     /* Command line options specific to the target disassembler.  */
>>     char * disassembler_options;
>>   +  /*
>> +   * When true instruct the disassembler it may preface the
>> +   * disassembly with the opcodes values if it wants to. This is
>> +   * mainly for the benefit of the plugin interface which doesn't want
>> +   * that.
>> +   */
>> +  bool show_opcodes;
>> +
>>     /* Field intended to be used by targets in any way they deem suitabl=
e.  */
>>     void *target_info;
>>   diff --git a/disas/disas.c b/disas/disas.c
>> index 0d2d06c2ecc..17170d291ec 100644
>> --- a/disas/disas.c
>> +++ b/disas/disas.c
>> @@ -299,6 +299,7 @@ void disas(FILE *out, const void *code, size_t size)
>>       s.info.buffer =3D code;
>>       s.info.buffer_vma =3D (uintptr_t)code;
>>       s.info.buffer_length =3D size;
>> +    s.info.show_opcodes =3D true;
>>         if (s.info.cap_arch >=3D 0 && cap_disas_host(&s.info, code,
>> size)) {
>>           return;
>
> I know it's too late now for a patch review, but anyway: What about
> the other spots that set up a "CPUDebug" struct? Like monitor_disas()
> or target_disas() ? Shouldn't we initialize the new struct member
> there, too?

Hmm maybe. I can post some follow up fixes.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

