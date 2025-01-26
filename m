Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23714C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1hp-0006L6-ES; Sun, 26 Jan 2025 07:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1hi-0006KZ-C9
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:25:30 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1hf-0004t6-Ct
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:25:29 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216401de828so62241615ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737894325; x=1738499125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kQAXjek+pcsu+DLudIoSaJraMGQVZsBsbzc2x9GQStg=;
 b=ZaNqBelRpkzbtT13Nk8okhkf86PAK8JbriHGxTWjoRiPmouVeKzZHj8NZDI7qyxAsk
 x7xdLb/J/YrvCwZOqtoPKuJVBCdsIKgzcqGOsh1MVqlQYwrAScCR+2kRa9GoUPECevSZ
 0wXIOHM4QuabkdAPIuey0WRJ/hXryFoULmf3YAGo/U1tEb74hTLlmhgGM3z7VWxftV7B
 mEbcvkwF1CoQW0BTnCRuqz72TTG60E0Y9U2/Lx1GDkeIPgVoxFYMpSCEeAOA1jHQZGF8
 /hj7twYyt7jqT2lDps/ienchk2zSV18Phb6aSjRjrFYll53WBfMFms6i8qsApl5jehSg
 WzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737894325; x=1738499125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kQAXjek+pcsu+DLudIoSaJraMGQVZsBsbzc2x9GQStg=;
 b=D964AVV/ju+h2EdTPmzvyycAl0tHSiKeZhi3JsUxN01cqvO8hQ3MmIv2Iwwk69Vhnv
 J/FwEodk/7WeQtcbM+Ahzjiga91nQn+kombCGmoMLrlCQVb1P/n2jvxvqGEWAVbQHGVe
 XawyK7iLw0yPrE/h7zn5Xav/n4+LyPn7m0kThdMk/yCgoVqUEoxIGfmAObRf7lES0Rpr
 Ee6Kfjd8hhOif8DviusVG/3q0PQR+LKSKX1k+nXmEUuTgQHJ5HVrNUijwSadY1JFS7XL
 dAtWxAXIWligdOuJnSgsiDyMbmfnUmvQoUd3L8EJM+kQBM26QQmebnLiN7se0pWmGkTk
 VLRA==
X-Gm-Message-State: AOJu0Yz+FcDpD+yDFSQdpjYOG/lAkwK/do+k8nPkrsW8c+nImj3fG9oc
 QgIKSVu5GeWixOz4lDMjofWJN34q18FN0eJjZjCsHwXxvbb7d1Sa8yHaOzU4AN0=
X-Gm-Gg: ASbGncs4EvtBm1cpaGDRpr8e5UqldCSQ8uQke+WJ7cEZL4TYzkF3hqkeW8XJ+sKGv9h
 yHTgnsoOSp8o+aFNc8zTtT6ZCJeyDMqcbeFs0fnQPinrb/75d+TzIsp0jdoNuNcdFdDfs3P8u/g
 8hbXIjo/joErX735yLlGCvSruEghqDlIBuaIGgweDdlNoMDFATmm9PBv1fzedCaxRe1+TJyNbV2
 oxCT6fXn3XzOgoWTdvooj5X5kd056cNOVU2cx7m58B2UpULae3GCtZHl6lcmGLTzVX+bOLmRO4p
 4AyRWHTbtXFuC4FJL7/b1Ck=
X-Google-Smtp-Source: AGHT+IFniPAV/XB0MxRgo9xkK9jPJ5XJJO2B02v5YrJEd6QZ2Nt5Rem/cQ3B0JXeQ+wDofMaSgHHWA==
X-Received: by 2002:a05:6a00:21c8:b0:725:460e:6bc0 with SMTP id
 d2e1a72fcca58-72daf79f69cmr55273889b3a.0.1737894325284; 
 Sun, 26 Jan 2025 04:25:25 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a761150sm5093663b3a.119.2025.01.26.04.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:25:24 -0800 (PST)
Message-ID: <6457a743-c388-4729-9c43-d684fc481f29@linaro.org>
Date: Sun, 26 Jan 2025 04:25:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/85] target/sparc: Move FBPfcc and FBfcc to decodetree
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
References: <20231013212846.165724-1-richard.henderson@linaro.org>
 <20231013212846.165724-10-richard.henderson@linaro.org>
 <CAAM0arN7MW4+HYHiBDYa9YOqvaDVcDn4sOczAzZM1Tbjb9CsVQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAAM0arN7MW4+HYHiBDYa9YOqvaDVcDn4sOczAzZM1Tbjb9CsVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/26/25 01:38, Artyom Tarasenko wrote:
> Hi Richard,
> 
> On Fri, Oct 13, 2023 at 11:29 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/sparc/insns.decode |   4 ++
>>   target/sparc/translate.c  | 105 +++++++++++++++-----------------------
>>   2 files changed, 46 insertions(+), 63 deletions(-)
>>
>> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
>> index 838f4cdb1d..9ab3f2eb82 100644
>> --- a/target/sparc/insns.decode
>> +++ b/target/sparc/insns.decode
>> @@ -6,8 +6,12 @@
>>   &bcc    i a cond cc
>>   BPcc    00 a:1 cond:4   001 cc:1 0 - i:s19                 &bcc
>>   Bicc    00 a:1 cond:4   010          i:s22                 &bcc cc=0
>> +FBPfcc  00 a:1 cond:4   101 cc:2   - i:s19                 &bcc
>> +FBfcc   00 a:1 cond:4   110          i:s22                 &bcc cc=0
>>
>>   %d16    20:s2 0:14
>>   BPr     00 a:1 0 cond:3 011 ..     - rs1:5 ..............  i=%d16
>>
>> +NCP     00 -   ----     111 ----------------------         # CBcc
> 
> Do we have a convention, when do we use "-" and when "."?

Dots are decoded by something (@format, %field, etc).
Dashes are completely ignored.
See "fixedbit_elt" in docs/devel/decodetree.rst.

> I plan to add a few instructions which do something with special
> registers on OpenSparc, but would be nop in QEMU. Shall I use dots? Or
> rather dashes?

That depends on what it is.


r~

