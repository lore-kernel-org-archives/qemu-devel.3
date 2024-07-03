Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75901C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvUI-0007fJ-8O; Wed, 03 Jul 2024 04:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvUD-0007aN-V0
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:37:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvUB-000894-D5
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:37:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-367601ca463so2895537f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995825; x=1720600625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fQnZ/ASKz4CZYO+IOyuSS4H7TqMZM4RV13YYgk/fM4A=;
 b=wnP3yrWY5J8yac8Oemlj4NzUDOvEvJHY78/wxr5jWOU/E4Vu32G2Sv1u7dcropo1sE
 9wXlgGBvHoNaWomzdZoaBEmZ+zCiqk0YygDyDeF5YeGVUhV2oB9Dwyz39jzWiHI/tU1v
 nNEE3cU66UHJhp6FKKH6qtfLXB01WwJaq0MNF61kteoxU6t5ih05vLhAOcjx0AMP/5r0
 +6kcJ2nCtoiuURUfVUg53Qt0pSBWZWPZSnylejUW+a873SPPkC+A7m5dLp86iiPLE4Rw
 xMcBEgEhDSwY2rO/u4CPDgVQ2ypNdnh+mIO1Uwtiwj9KrfqQqZPNx+q+kQ3jFO4ua+pf
 0NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995825; x=1720600625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fQnZ/ASKz4CZYO+IOyuSS4H7TqMZM4RV13YYgk/fM4A=;
 b=mz7Q5kV/kKfRemt1s4AR+FQuo/hi4kIEjfeIFZybSim4+8UKvDa9fjzsgY0jK2AIMU
 h1jnjvEvUmpZ3VLQwSeJJPtXlO8WbpUg9Nj53nvkhtuum46PbITCTUIU1DKVAvF9+5e6
 X2akPa0ltAauzjikoyO/mUxZa7qHs64wP1dFlrZfWIIr3pgzfmydJ0/fLEzOFWVnB+sJ
 gZkuo0x9lobPaqynudqxZxV6kRhSmS1hjBGBCWq4mQFbOWcilG4sVXauMTAQnXojMeSx
 V1ZeM28zRFmYFTu4957KHbxSq24eWIvya1Dwf2ds8i5bzqbsn5SJnhB79SVxLm3pHvBA
 gbwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl20wp3F77L608Dh5igLrv0k2+9+EWUCTvxFHf+9ikfk1oule0kAdsSGtaCEDNL3A0elwGHS2ctfqGJYtjh19eAkcstxM=
X-Gm-Message-State: AOJu0Yz+bkBhIf9sIONoUl/WqPWFYOYwEeTV4x+pbiqwqf5aEG65EYLO
 SynqzdFhHcwAXx9dMH3wSqSzxy0gTUPvMMhpxQ0CsbuahYJuXfUNBOFjwL9+ub59yXw9syFkvxG
 t
X-Google-Smtp-Source: AGHT+IFDXdeOWEMrfPKichVwPFbV6NN6Q4CLJOlImzeR0hSqaWRneNqp9sh2bSxSMgCwb16Bi/U3FA==
X-Received: by 2002:a5d:6d04:0:b0:366:e9f3:c242 with SMTP id
 ffacd0b85a97d-3677569930amr7432797f8f.12.1719995825326; 
 Wed, 03 Jul 2024 01:37:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678ed75772sm2415091f8f.62.2024.07.03.01.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:37:04 -0700 (PDT)
Message-ID: <85545e56-7a2a-4073-9639-93de59bac3ff@linaro.org>
Date: Wed, 3 Jul 2024 10:37:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/22] qga: conditionalize schema for commands
 requiring fsfreeze
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-8-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 13/6/24 17:43, Daniel P. Berrangé wrote:
> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the schema to fully
> exclude generation of the filesystem freezing commands on POSIX
> platforms lacking the required APIs.
> 
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
> This changes the error message for affected commands from
> 
>      {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
> 
> to
> 
>      {"class": "CommandNotFound", "desc": "The command FOO has not been found"}
> 
> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-posix.c | 47 --------------------------------------------
>   qga/qapi-schema.json | 15 +++++++++-----
>   2 files changed, 10 insertions(+), 52 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


