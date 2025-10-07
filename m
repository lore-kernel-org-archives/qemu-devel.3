Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0282CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68yy-0001op-8p; Tue, 07 Oct 2025 10:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v68yv-0001oX-FQ
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:48:02 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v68yr-0006wN-4Z
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:48:01 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-36a6a397477so63950291fa.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759848471; x=1760453271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BAsFBM0GpeFyw+RJe82sHa80SQfKdMwywvxBYVJ69mg=;
 b=dC/2/KlXtoK4CA4TWwsTG4Zl7+GoXsETCD9b3zgxRBlxg3Pv2zSw7zxKu3kYkMYqgF
 P9zluoqwXhOAQhU1HdD1prg6m7k642aB8E67e/7Jhd/IEYCu0Vp5Dr3jhcooVFy0Z5Ie
 YzlrazoRVv5cm/HZzeRmxG7Y5VItr2BWaJJZmzrCxdUQwJVzUTXsqCVoPQ/HTVlnDhIL
 nOfLk/OhK2L/o47R/43V29tkuxsXJmxMofZjdlGL4tN8o15igPnRQHJwl01mPaqOS7em
 6+4K7e/IE2xgTFJtOLcZdde3WWOIpFxiS94vbxREpang/KATYGjCp7xRGgF7sX8G6/ys
 gGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759848471; x=1760453271;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BAsFBM0GpeFyw+RJe82sHa80SQfKdMwywvxBYVJ69mg=;
 b=SBKSbSBCemhJlHL+sh2vSoVpLGGaBv66U5bb9BAG16pCQMoJec/tzVmM+E2YO+YKCQ
 gt4wLoN/s9IfIk9cSjRySs+qxbSq5pDVkTqMZwZ1ntRcbb1gsg9/+rte5q8TOrUE4/en
 aE1vlBaROyUCHIzL6/OQtVJrTVG8HRDIvgGdvNsoC2Njhz5Gu6Gcof9bD8tk4y2+9ID9
 Zuo6uPtwMxBClx5X9gyO3pEcXYYXRqhcDvb6xnPvWmxN3sAm47Sxv+Ei91WD4wrG7zwT
 LndwSGXuIfcNgUU9P6pN7UH/33Reu27VDGUsjqmPE4TSZFRRMdoUzsep/TngzrGy8Tbq
 TG9w==
X-Gm-Message-State: AOJu0Yz7QAHkOgPck/h5DPF+wsoX6hT6Qb9zVpXRRX1kyHRyrQ00P14G
 j/odCcdrTiwwzAfJTxeAVcKNSZhy09u6q2XjtLzoLTYgKCU6DZ9hiZpBSZIXEsGXkmM=
X-Gm-Gg: ASbGncvNqX+9pn8vrGM4iJu9OCD3Ou2tnksJm4F8mWDLeiDgmcI7Gp4R+GV3DEpsuHq
 sSM7DlYgqmlsDpKtcAisD775oxaSGFe/qrNUb6AaqXxUCSyB5qLAZxEHFsS1t4B0IBiSKYT0IUq
 UZcevRsjrke4SIIB3KLvQnKca9WQW4O91NC9ngGa1yNq3cD2KOT2CpBFAnKdZlwyd9izvK/Pzl+
 tp2+1eQqpzxn8medzU+IznFD+4RRWLCZ5MvRV934ZDsHW6f1liVjuqA6OpfxoBYCr+gcVsgf8zt
 Lc56OoGxnwk7yPloNevuZGOPLMfiOSwjV2V6F9grP9UATLuak+NkBntNxJJRZJspkhM/sAsGsBz
 SRCDzgm5D6t/F/NrSXzKd2/s/eNdVE5R61NMvdkscaM2v1ESGp0FyXiRe1jXM41bRuPj/uw8OcS
 PlQxiO4BAA8VJqUREv+A==
X-Google-Smtp-Source: AGHT+IGrWX3cax3BfRBxA1WGzIRfFhaHuEY3YmyZOw38GauZr+nXj6BEncYtMwMAMOuLDtmv0SiUdg==
X-Received: by 2002:a2e:a817:0:b0:332:1de5:c513 with SMTP id
 38308e7fff4ca-374c36633cdmr41770881fa.4.1759848471107; 
 Tue, 07 Oct 2025 07:47:51 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-375f39d509bsm10869701fa.12.2025.10.07.07.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 07:47:50 -0700 (PDT)
Message-ID: <a7e21714-e19f-4465-96f1-dc27bd484cdf@linaro.org>
Date: Tue, 7 Oct 2025 16:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/max78000_gcr: Do not ignore address_space_write()
 errors
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jackson Donaldson <jcksn@duck.com>,
 Jackson Donaldson <jackson88044@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <20251007024006.43166-1-philmd@linaro.org>
 <CAFEAcA_ytH+AwTr9LAZBP2nbSTod0FkfuexbewW=T7Pbb3nkmw@mail.gmail.com>
 <66dbc389-4c83-4552-b447-87c0e1ada48a@linaro.org>
In-Reply-To: <66dbc389-4c83-4552-b447-87c0e1ada48a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 7/10/25 15:48, Philippe Mathieu-Daudé wrote:
> On 7/10/25 10:27, Peter Maydell wrote:
>> On Tue, 7 Oct 2025 at 03:40, Philippe Mathieu-Daudé 
>> <philmd@linaro.org> wrote:
>>>
>>> Convert max78000_gcr_ops[] to take MemTxAttrs and return MemTxResult,
>>> allowing the write() path to return error on failure.
>>
>> *Should* it return a MEMTX error on this failure, though?
>> This is a question of what the hardware behaviour is,
>> and there's no reference to the datasheet in this
>> commit message...
> 
> Right. Thanks!

Looking at "MAX78000 User Guide (UG7456; Rev 1; 3/2024)",
chapter "4.7.2 RAM Zeroization" and table "4-67: Memory
Zeroize Control Register", IIUC failure can not happen.

Would that change be OK?

-      address_space_write(&s->sram_as, SYSRAM0_START,
-                          MEMTXATTRS_UNSPECIFIED, zero, 0x8000);
+      /* RAM Zeroization can not fail */
+      (void)address_space_write(&s->sram_as, SYSRAM0_START,
+                                MEMTXATTRS_UNSPECIFIED, zero, 0x8000);

Otherwise, what would be the recommended way to express return value
has to be ignored? Assertion doesn't seem right, since this is not a
programming error.

Thanks,

Phil.

