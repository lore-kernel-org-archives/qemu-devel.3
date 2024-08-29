Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AD0CA0EC7
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 22:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjnRr-0001Rw-CC; Thu, 29 Aug 2024 18:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjnRo-0001Qm-Pf
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 18:16:57 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjnRl-00038H-Dr
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 18:16:55 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7c6b4222fe3so758971a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 15:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724969810; x=1725574610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5VNVkYDCHiUAmtgwCy8Np4W2Fw7Z7u0e65nhBdtQ0TQ=;
 b=nT3rk5U6GBTwqtc26pkp2EzG5vDV9TYKl8oMENibFqqiQ3DoyQH9uhJjhBH5VkLQft
 PvKPVz3171nMuu2R4oize4VN7Kk+MvLpKJC9zVbP9jprLncWYAs7VECxzNsUhtv0DI+7
 JQCVAmEYiu8ChapNqeDYHpsRCfKbQGomSuplNHomy3BcGcgH2VlyFdt90EEcW5n7rBRq
 R1TS+ihyLaacm2eNn9YyzFStQo5jjWVgoOg5j68SPCYtMJpGQljPaf4qkuk2w5sUS2th
 Ag3d5RjQ07NK4+LtSo36Hx18EJSlIWHLH8MMQOBywUF/eAOlTpBFfkd0OZ5cPoDGVLMt
 QPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724969810; x=1725574610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5VNVkYDCHiUAmtgwCy8Np4W2Fw7Z7u0e65nhBdtQ0TQ=;
 b=CE+qT07dh8ZdftN2269rwtR3tfif2CQ8+raYB92nOHMp1t0nYGOWZNmEz/Pvbco6v7
 jEigX356A9pDanssoPR+If24IO4XdEvL9mYmDCBePI0Ee81dYR2OK/9DYWRwompA1879
 iyEwZuWq4tdyAqtbYDqo+DTYn1kIB1eih+qKpJ5Bp6c0HyacqVp+F6bKET0PVE3HRrSB
 8JeJ14LDjbGADLU9S0ToOLH7EmmI5xQk4OE1V5D/As+Un87GieCU/edgEP3E8ps9cbqi
 RdwDUpWFLfGeKzJ/B9qy50bagN0cxK/b8yac+JsLRmuxOGRalmk8CHHa0tzgYsVFeWdw
 nyGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg7vUHOEFXFWChS7d5EVPtdwrsnkvbdy9xOF1eBMVWLS1xZ2nWJi5c0jHxC4k9lnct4u0gPEyAIcZN@nongnu.org
X-Gm-Message-State: AOJu0Yw9EVc3gmgNhV7gaCwmX8hMK81+Zyp7n+qvZOAynxkSVswCgKZj
 SP6f5LinIM1X2/M4FYZGhlIxzD+EWJidLhtEJiHy3tTVewuNzGQhRMF1wGu2Wls=
X-Google-Smtp-Source: AGHT+IEBmNkLLlK9r6oN+yicpMh5AJw08YMD572eotStc0oNqVClMI0XscQZjvhCsEr8r1VH/Ru0nA==
X-Received: by 2002:a05:6a20:c89c:b0:1c6:a65f:299 with SMTP id
 adf61e73a8af0-1cce101438dmr4368808637.21.1724969809984; 
 Thu, 29 Aug 2024 15:16:49 -0700 (PDT)
Received: from ?IPV6:2001:8004:2738:227a:ddee:8ef0:4747:9e05?
 ([2001:8004:2738:227a:ddee:8ef0:4747:9e05])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e55a5b61sm1606609b3a.80.2024.08.29.15.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 15:16:49 -0700 (PDT)
Message-ID: <58dbf60e-9f37-498e-80d1-19ed25d8b91f@linaro.org>
Date: Fri, 30 Aug 2024 08:16:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to
 system mode
To: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
 <20240825145208.46774-5-gustavo.romero@linaro.org>
 <64200fe4-b824-4903-b5f5-fc48c9e00945@linaro.org>
 <69229d7b-15d5-feda-ee4b-1c48992297f3@linaro.org>
 <2c2813aa-5671-7705-7170-d3e8e25d2f7b@linaro.org>
 <65e4c975-83f9-4d9b-a8aa-37d9543afac7@linaro.org>
 <f5b66bb8-bf39-40f6-e641-64ddcfd6ac13@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f5b66bb8-bf39-40f6-e641-64ddcfd6ac13@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 8/30/24 06:13, Gustavo Romero wrote:
>    1 .text         00001e60  0000000040001000  0000000040001000  00011000  2**12
>    4 .data         00012000  0000000040200000  0000000040200000  00020000  2**12
> 0000000040400000 g       .data    0000000000000000 mte_page
> 
> 
> I was not able to make the MEMORY command work. I tried:
> 
> index 46f1092522..dc39518a16 100644
> --- a/tests/tcg/aarch64/system/kernel.ld
> +++ b/tests/tcg/aarch64/system/kernel.ld
> @@ -1,9 +1,13 @@
>   ENTRY(__start)
> 
> +MEMORY
> +{
> +    ram (rwx) : ORIGIN = 1 << 30, LENGTH = 16M
> +}
> +
>   SECTIONS
>   {
>       /* virt machine, RAM starts at 1gb */
> -    . = (1 << 30);
>       .text : {
>           *(.text)
>       }
> @@ -11,7 +15,7 @@ SECTIONS
>           *(.rodata)
>       }
>       /* align r/w section to next 2mb */
> -    . = ALIGN(1 << 21);
> +    . = ALIGN(2M);
>       .data : {
>           *(.data)
>       }
> @@ -24,7 +28,7 @@ SECTIONS
>        * used in boot.S to setup the PTE and in the mte.S test as the address that
>        * the MTE instructions operate on.
>        */
> -    mte_page = ALIGN(1 << 22);
> +    mte_page = ((1 << 30) + 4M);
>       /DISCARD/ : {
>           *(.ARM.attributes)
>       }
> 
> But it didn't work because data section is placed in the wrong place:
> 
>    1 .text         00001e60  0000000040001000  0000000040001000  00011000  2**12
>    4 .data         00012000  0000000040003000  0000000040003000  00013000  2**12
> 0000000040400000 g       *ABS*    0000000000000000 mte_page
> 
> Do you know why?

This is where using '.' gets tricky.
For .data to be in the correct place, we need to place the ALIGN on .data:

   .data : ALIGN(2M) {
      ...
   }

> I also had to use 'mte_page = ((1 << 30) + 4M);' for the mte_page symbol because
> the current location (.) seems to reset to zero for the sections, hence if I do:
> 
> +    mte_page = ALIGN(2M);
> 
> I get:
> 
> 0000000040200000 g       .data    0000000000000000 mte_page

Right.  That's a consequence of not placing the symbol within a section for layout.

I suppose all this is a bit academic. The current method using '.' is sufficient, but it 
feels slapdash.

Thinking about this more, the proper way to use MEMORY is to describe the page tables that 
we're setting up:

MEMORY {
   TXT (rx) : ORIGIN = 1 << 30, LENGTH = 2M
   DAT (rw) : ORIGIN = (1 << 30) + 2M, LENGTH = 2M
   TAG (rw) : ORIGIN = (1 << 30) + 4M, LENGTH = 2M
}

SECTIONS {
   .text : {
     *(.text)
     *(.rodata)
   } >TXT
   .data : {
     *(.data)
     *(.bss)
   } >DAT
   .tag : {
     mte_page = .
   } >TAG
}

Or something close to that.


r~

