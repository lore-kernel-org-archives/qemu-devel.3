Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43EEC36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn4f-00065g-Sf; Mon, 24 Mar 2025 15:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twn44-0005YB-66
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:02:31 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twn40-0001qv-W0
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:02:23 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso8776294a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842939; x=1743447739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ig0JnE6xCsEvFMrbFP8mqCsI5EhedfI42Ru3qi77Oqk=;
 b=AUGW0tMAAQOtqS7txw8RuQsCydsTyUASo5cpDl8smttL9C8Aw/v8dYHoelNtfzoRsf
 bvQXVeGF6WMibZqwo42qNEJe985/RukH5NrgVhyPqZ2nPp0/goz+Tb4d5RbZW2m8G13S
 GRD9mKqutrOB4fp6j569zunYVc10jWvDiwIzbz2PdecO0TkNEBcWiHD8MqHujol7R+x+
 pLedzYHiPdieJuCaLdO7sQLz4dECLEvVqsfMigIpFzZNpLoSvm+MpR3RD/y4AFMMcXx/
 z3Gx2up6uBzF9/FKpOdJ7UEze+1spwYUFSkLcHMQ19G4Io2BR/KtR8zzDsscYDNcAjZG
 4rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842939; x=1743447739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ig0JnE6xCsEvFMrbFP8mqCsI5EhedfI42Ru3qi77Oqk=;
 b=Ab4s/99RIqHrl78essoKU5pzHGIZHjZKOrjRxvvkqkaK4mozP1AD5HvC71NinW5eYJ
 xTyIX57wRSS0ZX2TxbPh2b/KMKgabLaZ5EoO/hLG3nJLhdpVlY8HZUfGyQE5sFNRdvb2
 04vJwYtK9EhyD3eUr4oVM65UMTg5/ZIVD7sC4zVDWND2O6i2yGTPYKeECT4gZk2DwqUn
 JPnR6sg/sXafN3gF372BRLfsM+n/Za8k0GKXA9SIFlD5zn/65GJ6rNRP0RV1qNqW5tzB
 GXQSN31f5/oz5wavgtTu+fQGJFJ8C9Vq9ZNdK7T03Js+BjPwnsd07zr1WD9oxiMYK2Sm
 qWHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/VHIsbcxPdcwierGlryOVBxB7BOnTKCgNMxfHIdNV8t96uOi22epYIU+EOjG+5WVx+pBxkd/mI+VV@nongnu.org
X-Gm-Message-State: AOJu0YxGYvpI5uhhK9KpZe5GE0MuhpteYh3rmh1mBOqPoL0oiTK2V3I6
 QJ8P8CeQHJLxUCOWV+rSpXI2LxHWaPUM7Cd+NC2Tcfu9rY0ooRhyfqBXkMKQgxA=
X-Gm-Gg: ASbGncuyYOPrDhiEGdB8LL/gIe9dZ+Hl7eOt8JHQ6vrRUitxooSDgYAFXjc7kh8bDtl
 ENepaL85+rEufwR41Y/1qHxICiKGITuvbKaKNewJKFhjfhqZ6CBSII4AXjx9Q12oc45JsrAmPqd
 f+SaSc9feWmeVMmyhdTLAGY6s80aPB5G461tjw795FxFB7wI/Cp8+LjQ4DKOUr4lCyRPfKfCR/w
 ayE3Gj4rWORIqYUq1yqP0JZOVxd6s/SWUgXeLBOSDrPQuihzc4I1Q7s18r7OAMUMalzyA+1rq6g
 oIhu0z+aFl4QgJURE9fxp+seLcn+EsShrDe/wxb9/yARaFvfALiSHRJxqzvz9r9mN2iuLur/vT4
 xdVeI4Kwu
X-Google-Smtp-Source: AGHT+IGLlxdO59O4lopHBuY4HXD+eU8tj25isZwNsAdMGDLooo7lZ9RZYmQx+Q/rRu4UWTxl/EW8lQ==
X-Received: by 2002:a17:90a:d008:b0:2ff:693a:7590 with SMTP id
 98e67ed59e1d1-3030ff08de9mr27404051a91.33.1742842939048; 
 Mon, 24 Mar 2025 12:02:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5d787asm8629729a91.19.2025.03.24.12.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:02:18 -0700 (PDT)
Message-ID: <fb9e488b-b6c4-4270-aeaf-d5bbffa942c4@linaro.org>
Date: Mon, 24 Mar 2025 12:02:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] target/s390x: Register CPUClass:list_cpus
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250324185837.46506-1-philmd@linaro.org>
 <20250324185837.46506-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250324185837.46506-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 3/24/25 11:58, Philippe Mathieu-Daudé wrote:
> Register s390_cpu_list() as CPUClass:list_cpus callback
> and remove the cpu_list definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/cpu.h | 3 ---
>   target/s390x/cpu.c | 1 +
>   2 files changed, 1 insertion(+), 3 deletions(-)

I really think this has to be merged with the previous.
I strongly suspect that it either doesn't compile separately,
or doesn't function as desired.


r~

