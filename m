Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DDBC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 14:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLL5-000368-IN; Thu, 03 Jul 2025 10:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXLKy-00035n-4e
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:54:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXLKr-0008NQ-O4
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:54:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ab112dea41so3176247f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751554487; x=1752159287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5CuO3pqTMb0BUH/1o76HKybPhitETUQyU565y5I0qGA=;
 b=Jx3nTEoFYXqUtqlzKe0EpqlSfa7oNJI4HEnel9ge1gCigwcol28r7eBpkk9yU+f5i3
 V/UlQCzTU2CxKrshsperPJBjSyAYWwgDED9qc6kNYvcwZRxNgQWIbXX3HCHAgYgUrBwl
 +iAjl6SL9psyIVRPVD+VMN3h43O4kzmouTijonuthpAvr0n0YGWBQbesZiJ1fjgaA15o
 bEG5bcGcK8Yd+PP1/Oaa2qIiSvu02J29YU4nF4zBGMj2m1MF5CfbirPjfclTrYiKQpny
 q1GOz3HJuXT4Xgo5O9JGKPzqykglA1rEbRfuzNJu3/+eLv3uLEg4CY1O48NEBnYteHW1
 IgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751554487; x=1752159287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5CuO3pqTMb0BUH/1o76HKybPhitETUQyU565y5I0qGA=;
 b=K/ogFKf5ygX43vue6mNtg3GocmlGkVSHPpw8vNf/EfQfo6ilb0Gu5di+rWv+Hqqj92
 2ogdbeIBHOGbyGdirgvkyNdTVeigKBnKEJtq9QR3w/e1GPgHar3m0AAIw1vkXCuivOjN
 SPfV7sOdzzLyBxnJGDf5P5DdPSeK1Oox5VOWKuHrfkeCjlDZtR4/GJc3yxAYtLQ/vpvL
 X4TB8/BEDsiedOumtSCLTabfVmRil3dDoXAJvBlPpnqJxNl+v3NMPG4X6dDYHb1Ngfd3
 +4iQ551fMoFqeldTBhQnrDFtCJgEFwJ5nInz8Osz9zND57FycG/gjO0tnFd+EP3PoN8r
 u+JA==
X-Gm-Message-State: AOJu0Yy9qO2VTF/7Jf7+/aQe5XtmnjDB/BEGl4fzzlYPpdwv0G6x6KcF
 fhWeUzkJe6TqMnsVF7rbxmRmN7FfshNdkqylSRJgjy/J6So3kULZTFa+ItzgtBhUg6o=
X-Gm-Gg: ASbGncvVMto3Jwnzjy4vYff+TnaOqYXTEO5byzVDhURF1CVm6S8kJi8qS0Um3u377eg
 sDJPE4M5uwBJlJHQKvXlw9GH55P7thOqEKZBYZ4cJTMC04mYGW6Z+Jb1iENTNHsysLKBuh3UCaz
 o6DXc8w+FfCX0satf60ThqQA0MZRG2HSsFQM07IVXcdyZDRjAXHWfK6dyBYOKowLKVU1B6TdGRf
 6BTDwPsEFCHv0gqe28HIm4IQIsQa5TB0bTvVKKiBNDRSEPcjYJt3xls/t7/8Hra9ZJ9MWmS7ZUK
 9Rl0dyfuM5YD52ZD64hTfyPE98nlD2WkfQ55TVgvCZ67NXnPym2b/8M30SAcWBKvLL3+cmIe9Fl
 21RmqdRkOecuIx0fA7wp3G26fy7t0lgPKYV/3zL8p
X-Google-Smtp-Source: AGHT+IHqsM2FFruPfXPPDl9wqNGG2QyW3xMMOPc6KDctgMJmTlkHuAPFM8B+6K09bfBxt8yG0g0flQ==
X-Received: by 2002:a5d:5f8f:0:b0:3a4:d0dc:184d with SMTP id
 ffacd0b85a97d-3b32e801aeemr3139714f8f.27.1751554487301; 
 Thu, 03 Jul 2025 07:54:47 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d07ffsm15451f8f.31.2025.07.03.07.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 07:54:46 -0700 (PDT)
Message-ID: <bd033855-59d4-4503-bbdb-558e53d04237@linaro.org>
Date: Thu, 3 Jul 2025 16:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/68] accel/tcg: Implement get_[vcpu]_stats()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-27-philmd@linaro.org> <aGYt0DyMsPapzGQh@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aGYt0DyMsPapzGQh@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 3/7/25 09:14, Zhao Liu wrote:
> Hi Philippe,
> 
> On Tue, Jul 01, 2025 at 04:39:34PM +0200, Philippe Mathieu-Daudé wrote:
>> Date: Tue,  1 Jul 2025 16:39:34 +0200
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH v3 26/68] accel/tcg: Implement get_[vcpu]_stats()
>> X-Mailer: git-send-email 2.49.0
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/tcg-all.c | 6 ++++++
>>   1 file changed, 6 insertions(+)


> With:
> 
> ./configure
> make -j
> 
> I met this error:
> 
> /usr/bin/ld: libuser.a.p/accel_tcg_tcg-all.c.o: in function `tcg_get_stats':
> /qemu/build/../accel/tcg/tcg-all.c:244: undefined reference to `tcg_dump_flush_info'
> 
> It seems tcg_dump_flush_info() needs a stub?

Fixed in v5! :)


