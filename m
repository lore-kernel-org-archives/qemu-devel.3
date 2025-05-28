Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F164BC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 20:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKN8r-00044M-57; Wed, 28 May 2025 16:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKN8p-000445-Jn
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKN8m-00074h-Cb
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748463157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J8H4HbK7DFMQBNuYuBVVFcJLaOgVQDK4pDwvp0Mzvng=;
 b=SLW3MgGPf+JzL6rEmFDT4RPS8zpPWyXQ+QoLzRgB7zjFz+GVbokHkv0vu762nOnCSpKKD9
 J0FE4YiYdV891CVRnRLarSnXk5xYzYB7PrpisVdZQsvwkgNzRhgwCxadz64teqY4q/klf1
 trOgrAAXBRBpUy9yELTVKNA3wuWIpOU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-1eKcpUsIMSyFxbDynyBk1w-1; Wed, 28 May 2025 16:12:35 -0400
X-MC-Unique: 1eKcpUsIMSyFxbDynyBk1w-1
X-Mimecast-MFC-AGG-ID: 1eKcpUsIMSyFxbDynyBk1w_1748463154
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad212166df4so10158566b.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 13:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748463154; x=1749067954;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J8H4HbK7DFMQBNuYuBVVFcJLaOgVQDK4pDwvp0Mzvng=;
 b=GEp3k4nnGoe4Du23CHI9SbnJJxQLVMHXUrRs0V6TmnAXktNvwjc4bN04k6uHTPGpV8
 XK/+37xGw6nR1XQwctZ7a6XGw94MUeU1Vn9wWNvPZybpbfAJO/xKbw3i+OsrQ5gUKmPo
 uezKcSWC9f2MbcgYf44JPy/5/kHhCtGioGwDLhcjNHJLfcC6/z2EioIQn4PjiE2P9QGx
 zAtG33aQZhIvc9NdeBOOoynmwxPSblGguEpfWvBTYTKu3FeanVSb/O0+82yP58TM2W/H
 eTMOOh6mqrCoKsOwMsrWwbTQA2mbhW2KpxsJl/ee0pYQT8+EIkWKox3Rl431XotHqg0g
 fVEQ==
X-Gm-Message-State: AOJu0Yyk4cQ+NOLH699M2gTZgEnNs5nsYhT9zUvEK8tf1tclGwcy1V8H
 icn8K5GVzsW3fh4/etrGRBNiGQXFZbkxVOfOxeCXi3gZkvgPo/Z28bT1pF9U5EZUMLvO0kJRhJF
 HcF5RN/KG8ir2zu6JT5m21JAqYpY78RiM4XEb4jtIM9TnYEKkIl7XlDU5
X-Gm-Gg: ASbGncvYSmMbMouCT+23NLnLTLhN+fy1tkFO12g7VmZayK2fGOxlG81JOvmL5OboXuH
 S7i9h9Wohm/NemVVgQkeMYjt54xozzsvXrV+BTchhK/orXy6SMEKyKSRmHENuo/ceLLJd7cQ59j
 EWuyGL91wlnq0LvtyY2AwIvRPk6RMlDVJ/O4jTfGVwF5POcpbilyBrrZzsgrBMriCEsljL+gUve
 cNr45giWUVAuPEYnKA0vhRzTvznifS3CTxof/oJRIUyU4R798Dx7xL+Xj9HUPdj9gXIbz4ajj+P
 jvgKHk9DOU1d4suFCdxQg23IN/k1jVaUZ6bBtsVGNaDpg2wJTF41
X-Received: by 2002:a17:907:3ea7:b0:ac6:f3f5:3aa5 with SMTP id
 a640c23a62f3a-ad8a1f0d657mr359129466b.16.1748463153623; 
 Wed, 28 May 2025 13:12:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3B8L0AiLXGzYQXGEERgT5RjLGCuolVyHSomlAMcgRAztNhXxsKWmxB6kkDZpSzzV7/FJecA==
X-Received: by 2002:a17:907:3ea7:b0:ac6:f3f5:3aa5 with SMTP id
 a640c23a62f3a-ad8a1f0d657mr359128066b.16.1748463153190; 
 Wed, 28 May 2025 13:12:33 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8a1b29785sm163686166b.93.2025.05.28.13.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 13:12:32 -0700 (PDT)
Message-ID: <34256440-efd5-4395-8eab-49ca5bbe0377@redhat.com>
Date: Wed, 28 May 2025 22:12:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/27] Functional tests, Microblaze endianness & pc/q35
 cleanups
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
 <CAJSP0QUpxsVEMEDT8opTZrhs6oFfFJk+jUqdR-dZL=TzQcYbWg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QUpxsVEMEDT8opTZrhs6oFfFJk+jUqdR-dZL=TzQcYbWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.904, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/05/2025 21.23, Stefan Hajnoczi wrote:
> On Wed, May 28, 2025 at 6:12 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>>   Hi!
>>
>> The following changes since commit 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e:
>>
>>    Merge tag 'pull-aspeed-20250526' of https://github.com/legoater/qemu into staging (2025-05-26 10:16:59 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-05-28
>>
>> for you to fetch changes up to 9c2da02e184fddfa7cd7d7813455c2306daae99a:
>>
>>    tests/unit/test-util-sockets: fix mem-leak on error object (2025-05-28 11:59:47 +0200)
>>
>> ----------------------------------------------------------------
>> * Functional tests improvements
>> * Endianness improvements/clean-ups for the Microblaze machines
>> * Remove obsolete -2.4 and -2.5 i440fx and q35 machine types and related code
>>
>> ----------------------------------------------------------------
>> Alexandr Moshkov (2):
>>        tests/functional: add skipLockedMemoryTest decorator
>>        tests/functional: add memlock tests
> 
> Hi Thomas and Alexandr,
> The memlock tests are failing:
> https://gitlab.com/qemu-project/qemu/-/jobs/10181084830#L5421
> https://gitlab.com/qemu-project/qemu/-/jobs/10181084865#L5476
> 
> Please take a look and send a new pull request. Thanks!

According to the log:

  Output: qemu-system-aarch64: No machine specified, and there is no default

I think it likely does not make sense to run this test with the aarch64 
target... Alexandr, would it make sense to limit this to x86 only?

Also, quite a bunch of other tests failed at the same time in the aarch64 
job, too ... I wonder whether they were running out of memory now?

  Thomas


