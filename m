Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755FCECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sneQs-0004TK-KY; Mon, 09 Sep 2024 09:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sneQq-0004HJ-EW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:27:52 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sneQo-0006TX-Nb
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:27:52 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c3c3b63135so4578941a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725888468; x=1726493268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lwbiLqDAs21UIo/+lcO0DfO38fNxtDnmTM45HG+vtNQ=;
 b=M+qsnADV3ADNyRDouLrG3EvTLq1x8WO75CYm42wr+9IgmwGs/vLW+/r4CixhktYCOD
 idac+UPk1CccoTYQN/Xyhr8arxSZ3qyTlbH0nAPStzDm6wUXX7kznRVlnD5TPqqftUD1
 mqSVys1Rmdb6/jNQbyzoj69f4J9VuJeCBtYXGf9lbE0HjJXDeiKp0DQmGl3MM7q7U7mU
 FFYvEquF7u9v536VrAm7H3cHTsNUwNODemF5qfLMJb1RILVc1nPNFPuftagOtw+YS8AD
 qX/09d6jKPgos5iZWOvIskeXLdUUBnIwZE4TEUwId4pp4zti01AWZn910XmnSpyy5Bbm
 TE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725888468; x=1726493268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lwbiLqDAs21UIo/+lcO0DfO38fNxtDnmTM45HG+vtNQ=;
 b=uSN88L4Y5NmdQnhLHs96ii551KTBl9RczvAxpUBVAfn/PiwvYxLMVYz+RK3zehJ+HH
 PpDFnnC54jj37O3Sxp+YVcoeG9Y6sI7Q+N6pvNKk6AlrCvh+nFeUhbMtLej4WEzL6lOv
 yGa7HN6iPSTno70/LFigGPYp99ScBT7bgioGGcg1ZEX9NrP7rFLI86zRJ6+gwLpiiz7i
 LuMXAIgJx6YGgLmYZXY2Su+TejAJGJgG3r6WU2kON9Gs64zp4Sin/WOThh6TEsASGUcq
 1hl2IcjQ0edRbTalXPfGTphh7YYC/mYCXLNiJiSylSTDyl34MAi4C8QPgxvOoJmDvXm9
 Wi0g==
X-Gm-Message-State: AOJu0YxrFYSDE4bSVnk6mC0zDDGD/SSQkfoi1Z2LyMolOS8TiGy0mp58
 LlAKiGMHqlpi2BOjq7oM/8Q7MSyRyu7RidI0faZ0A4wjmMPa8MtI3PSv0TEF6E8=
X-Google-Smtp-Source: AGHT+IGsvvtZ+fYyWG8LfK57boEZU5Z3ysge5KDFTVpy6QAWAJ3LNXjVpNCSfUwyRV6fDvtkXLx7fA==
X-Received: by 2002:a17:907:7f03:b0:a8d:5e1a:8d7b with SMTP id
 a640c23a62f3a-a8d5e1a9021mr240840666b.43.1725888468039; 
 Mon, 09 Sep 2024 06:27:48 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm346735566b.173.2024.09.09.06.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 06:27:47 -0700 (PDT)
Message-ID: <a75781ff-9798-44fc-90e8-0581dabc8677@linaro.org>
Date: Mon, 9 Sep 2024 15:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] hw/char/pl011: Implement TX (async) FIFO to
 avoid blocking the main loop
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
 <4bc83012-3b9c-4b99-8b6b-65f041652540@linaro.org>
 <CAFEAcA-x_avaFQcrWQj=-e8-5_C4NeWUNxgRqLqKbrJ2HpK4pA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-x_avaFQcrWQj=-e8-5_C4NeWUNxgRqLqKbrJ2HpK4pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 7/9/24 12:38, Peter Maydell wrote:
> On Sat, 7 Sept 2024 at 06:42, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 19/7/24 20:10, Philippe Mathieu-Daudé wrote:
>>
>>> Philippe Mathieu-Daudé (16):
>>
>>>     hw/char/pl011: Remove unused 'readbuff' field
>>>     hw/char/pl011: Move pl011_put_fifo() earlier
>>>     hw/char/pl011: Move pl011_loopback_enabled|tx() around
>>>     hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
>>>     hw/char/pl011: Extract pl011_write_txdata() from pl011_write()
>>>     hw/char/pl011: Extract pl011_read_rxdata() from pl011_read()
>>>     hw/char/pl011: Warn when using disabled transmitter
>>
>>>     hw/char/pl011: Rename RX FIFO methods
>>
>>
>> If you don't mind I'll queue the reviewed 2-8 & 11 to ease my workflow,
>> before respining the next version.
> 
> Sure, that's fine. I don't have anything pl011 related in
> my queue that would conflict.

Great, thank you!


