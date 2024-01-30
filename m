Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10EFC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmGe-0003EJ-KT; Tue, 30 Jan 2024 06:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmGa-00038q-Hw
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:27:02 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmGY-0004dh-Sv
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:27:00 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40eac352733so44816385e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706614017; x=1707218817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kH0vP915RQMsyhW47FN6iEZZ/Kg87TbEo3Jn46QLj7c=;
 b=ESIyh8Z/r1apX84UCZESocucL/O6ZhAfJ/+ngKTvqEzVnqlGdrPy4ulLNtm3arEfqa
 2rLUgWJr61Ol2WzBOyfpGy/Wyw6KZAXMmh4+MVc7IlY3S+GaIkp9tZ6lxuyyyqLH7GoG
 pGUVaj8nYdMJHc25QUxto0ggXu7jIFftJijIuQjWMb0gdmr71/O0yoxMMVt118eQUS0i
 5JLiOdZrI6VU/5rKzw9TVw1mCMAq82G79wQVqeHecC/VgiWgJa70xaSXEXlxrE3IIW1e
 4DRAdunZkDcq76aYjdl9POmKFmRfV1aOjGThY7GREiM29hsjjQSxQGBspWhymu6a4qYq
 pKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706614017; x=1707218817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kH0vP915RQMsyhW47FN6iEZZ/Kg87TbEo3Jn46QLj7c=;
 b=g1prfGNkbJnhsl70WRVU6/Ts9wcXoowbEQ56hVPA2AcBiJtpn3Ea8/Vk3s+s2i7p7A
 NBzXZlzkyx4jNaFzCD/e1dKNbl39XyuLvnbz553IpBf6AkZPi19CxnCL27vd/lF+yMwG
 +say6KsnVw2+Nn/DvjseIhxdT78ZmYyFxRkk7jIg9azsQTKeYuiJ8R0VxXSkRI/xGKIW
 MSjMNc6oVp3sw1V8r0gytC17uGVKySUM4Ljjfj3L6VLveWm+YER999coVfIbVWDVsa9F
 PtGj9fIhzaq1B82nhuYfGHbQSBdD/ep1ALyMEmtY4di+U7TrXYguVg7NVuV46n7LQfYz
 EqnQ==
X-Gm-Message-State: AOJu0YyKIJBtBs8qnhZU46n80lnb1GWJoFRgIhTxFeQ0zVCVboUB8OqX
 wP0HnX3Qms9DNEJe0dhoXyC8ZjHHyGsotcIOrRugW/CxV0KfZfTdxQW7rD9yIwRQCfCLXHy4Dgq
 W
X-Google-Smtp-Source: AGHT+IGefXlmoIRMBzLX6OjatTKIpSwKej6c1KXe+9FCk9Z7CD7M4Ap+4taGdHYdQOfMN9etFnVgag==
X-Received: by 2002:a05:600c:46d1:b0:40e:d3ed:1cd0 with SMTP id
 q17-20020a05600c46d100b0040ed3ed1cd0mr7806891wmo.26.1706614016849; 
 Tue, 30 Jan 2024 03:26:56 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 je16-20020a05600c1f9000b0040ec66021a7sm12967876wmb.1.2024.01.30.03.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:26:56 -0800 (PST)
Message-ID: <cd312f6d-d385-4237-8271-d123a2c7b7b4@linaro.org>
Date: Tue, 30 Jan 2024 12:26:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] include/hw/core: Add mmu_index to CPUClass
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-2-richard.henderson@linaro.org>
 <238c5053-47d2-42c2-a012-5a88f318e290@linaro.org>
 <ab8d0b2c-4ee0-43ff-98a1-afaf02320dae@linaro.org>
 <7b142c6e-07c4-4f57-bc47-b8490b2810d1@linaro.org>
 <a720b9a1-8e2e-4e2f-a673-d5e342e3b284@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a720b9a1-8e2e-4e2f-a673-d5e342e3b284@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 30/1/24 12:02, Richard Henderson wrote:
> On 1/30/24 18:20, Philippe Mathieu-Daudé wrote:
>>>> Can the index ever be negative?
>>>
>>> No.
>>
>> Then why not return an unsigned type?
> 
> The existing function didn't, and I didn't think about it.
> Does it really matter?

No :)

