Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2E1CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Qbh-0005lo-GN; Mon, 29 Sep 2025 23:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Qbe-0005lc-Ht
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:00:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3QbW-0003SW-Gl
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:00:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so36359975e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 20:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759201233; x=1759806033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b/hv/3GrGGdBrjqDhkGziv/l9BjnzqX5+ubPW41cLL4=;
 b=QhWlrpXm9HQ0kaZEPr7dpKrCWlFk2AJPmgtmFGc4/5YPKGIGy1VqWckDxvS69wTPO1
 MBNt4rBB6ZT52kaZxJbf0GZZsAhlnraNGCgVt5h9ZGVY5p3Z+P+fi2tf/Dp5Fqq1/XFn
 5hbGHc7RDtYte4E8G1jCPTury4pvmg1hd3TL5x/9y+F4RgOLxRnzVOWs7K9i3BH07Y7b
 DNcuoTRdhtG2HeRe4qwLxtR6E6Nt9/6CuF+B5hpEiozV6joq4OHUpEhfMzXtNiw4yH3b
 9dV38iuKJFwGyzBsNDZBQIaKP6L4hgVArds/MFo9cJ9DZMS3EHGCbKuUSWleqQ3gmnnF
 bIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759201233; x=1759806033;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b/hv/3GrGGdBrjqDhkGziv/l9BjnzqX5+ubPW41cLL4=;
 b=H00ZvMZmyzIDwqDnQ/CwwxM573OdHW6+4jyShDOBBAu+57aAy6KhSxyAll1gU2kriq
 p3z6kTTdnSy2OHJxMASG+qYXrlaPJfN8oX7XdANh6Ik5xy8tCbDT0E8Dd6s9ZvL8rfjm
 7qFRxtsdctGWZfrXGZs9sndO26+QcGYvkvXtpQlBOrUao4DxTDQgsUgUZNw0GLnr4IsC
 uErmzL6+glm3Olz26MdXfEsWcFoETdvDAsFsZGfhcVx4+25QuErS4OVmuNrz6spzeCPG
 0326G1L1oZ18mTRiThythrJ1cu/9Ii3H53Bim3HhmiwvRTgwkEmFum3tcAPDWVtGre5e
 +P1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBIJq5qpH7UscJdZnfwAM+kVfmje/+tvJMqw+VNKPEgdoA/cJuVdX+1OjjMhNQh5AQ5sWZXFdX6kb8@nongnu.org
X-Gm-Message-State: AOJu0Yw2mlMrhQUH6iCpaXD5f77Sv7RotNUpabrKhaOW9OnByQ75Wu16
 BO0P2eGmCjahod9EXq3FmSOUNzb6p0TwH9SrKnyRKnTyFfcY27hAsbvdidtqBDdVH/A=
X-Gm-Gg: ASbGncvV+z6rWZRbT9o7297VzVVE4dLpM4rLaEt9SO3UPSxNptp2x5hD5OHDK6d1e0s
 kieDz02FsgJ8gQSd7Jc1Dn4+Ar/eHcgmqMzmVkExmV7ovItZf5hlDnj+Haj5IYr3i0GpYqb+cD+
 VytfwxrSoZDrnmFGPay9qwe3yTN866xBC1ZG26HOuws7qwQX5nnyujRbU5eJ8BOQcs0mTXXyWQM
 nYTEJf1XQ+e7jcA010yMjRFEiIcKnijSsAB3rqZ/UsT3xIikSLtI/d1QEfOXdzwQsiybY2fYujQ
 uf9vYztusplUz+ZjX28wCZGFATBfv55qdABwW6YcprILQBysDJhZMuecGegOLllDzhFy+e/o5tT
 pAQrDQm8wpeT2gi5j2OmW/bf1Up9DydwK4D3FDF6QzUFnLaheLB96bEcbTKqPg3H1PQU4qOu4SG
 k1Xy0RFlYyuP4g5MtU1acY7xQw70YkZCapAWY=
X-Google-Smtp-Source: AGHT+IGEelNP/lg9tXtwopHMKswVUBJM2tw/p4SUuvPY4kDW9PJ0vOqJ9DW93DzQbJqPzd8B+ECvcA==
X-Received: by 2002:a05:6000:22c2:b0:3e7:ff32:1ab with SMTP id
 ffacd0b85a97d-40e4b294f33mr13948290f8f.50.1759201233432; 
 Mon, 29 Sep 2025 20:00:33 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc72b0aeesm21094452f8f.49.2025.09.29.20.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 20:00:32 -0700 (PDT)
Message-ID: <a7c48a36-8a7b-41b3-bd3c-3cd56b1c1a26@linaro.org>
Date: Tue, 30 Sep 2025 05:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/ppc: Have gen_pause() actually pause vCPUs
Content-Language: en-US
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, bharata.rao@gmail.com,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Aaron Larson <alarson@ddci.com>
References: <20250924173028.53658-1-philmd@linaro.org>
 <20250924173028.53658-3-philmd@linaro.org>
 <4b0138bc76c60385de71c26eb55a4aecd8d1786d.camel@kernel.crashing.org>
 <8099d09f-029d-4562-b035-7b832ac27ccc@linaro.org>
 <5923fc8c7ac36d8bcae7a416cfd072c18c8698ec.camel@kernel.crashing.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5923fc8c7ac36d8bcae7a416cfd072c18c8698ec.camel@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

(Cc'ing Aaron for commit 9e196938aa1 "target-ppc: gen_pause for
instructions: yield, mdoio, mdoom, miso")

On 30/9/25 00:59, Benjamin Herrenschmidt wrote:
> On Mon, 2025-09-29 at 09:51 +0200, Philippe Mathieu-Daudé wrote:
>>> What will resume it though ? The smt_low() case isn't meant to
>>> *halt*
>>> the CPUs permanently. smt_*() levels are about SMT thread
>>> priorities.
>>> Using a "pause" that just gets out of TCG (and back in), is a way
>>> to
>>> "yield" to another thread, thus enabling more forward progress when
>>> a
>>
>> What you describe can be achieved with a helper doing:
>>
>>     cs->exception_index = EXCP_YIELD;
>>     cpu_loop_exit(cs);
>>
>> Is that what you wanted?
> 
> I suppose so... this was many years ago and I don't have much context
> anymore, so I don't know why I didn't do it that way back then.

I *think* Nick implemented something similar for sPAPR in commit
e8ce0e40ee9 ("spapr: Implement H_CONFER"):

     /*
      * The targeted confer does not do anything special beyond yielding
      * the current vCPU, but even this should be better than nothing.
      * At least for single-threaded tcg, it gives the target a chance to
      * run before we run again. Multi-threaded tcg does not really do
      * anything with EXCP_YIELD yet.
      */

     cs->exception_index = EXCP_YIELD;
     cpu_exit(cs);

Nick, would that make sense to implement smt_low?

