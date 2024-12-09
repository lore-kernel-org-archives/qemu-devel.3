Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEB5E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkap-000742-Pm; Mon, 09 Dec 2024 15:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkan-00073e-Q7
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:42:57 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkal-0003qE-RB
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:42:57 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434e8aa84f7so22858545e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733776973; x=1734381773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t11keofPPYzYAQJAOaIAc1vhlnqXVxQ+MqEJz50hWSY=;
 b=sPzmm98IJ2DNASuznp+HeMUnjdRvdCjTC12iPbcYEXSquu4bkdqRxAq0xs6x5vqmWE
 DkjfSS7gZz+N768XHPLGPQ4R/4Isd3wKOmDUZfjEeJhPpvyij09VoTJKVCckAolTugHP
 lkiy8JMuQZHyYrJbtCIGu4XpPghTn3okVO47lusb89yAKhhVbNkdIfA10iRLwh4U8m0Y
 pQ1XlBrl6DJKfmsucFQB7JSUJL968XCVnmINLwhDVpolgHkCRqFt1ip69R7pTiq+phpW
 jMthiiKy7qplHFIy0XH4TL9qiGDWJu1mYHabKkxHgYGhc+8pdfdo6fypd8jI8b7eHUZS
 gHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776973; x=1734381773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t11keofPPYzYAQJAOaIAc1vhlnqXVxQ+MqEJz50hWSY=;
 b=OTtQzqCcCZN4xAt/GyQK8c5Lea5apBUvF2e6DZJDAEOtocCJMlRI3wuFVZq799M65x
 xIgbGHKetMLxHp0RsDTsXmaBrQFM8KDFuR/XjOmJndfTKFGuw8pphk3Rr6h1fPugcP5L
 2o/4IOam06hwyrfg0voChpydxYV0s6tXnzNk6Ywv47bFEHyPb9ebOFfPRLXK+lQRVAQm
 hd41HQYGn88j9M/1A+3nliHYu9dHM1MblJpDkxpkqGs09olsqK+NXNvGhnEmWkqabZg7
 Cz+b8/GkOY7BjiV3Qs3FZ2BbEyeEIJqlLbm0eqIG/PqQoD2B8FhC1IjVr+/6lLj3aonM
 q6cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKzFopbEexSCFPU/C5zz4RHkeDoZlWcVTvqwJjm6zYncX/4XwYJeECEtA/z8U1ci8SirRsWHhC7Jks@nongnu.org
X-Gm-Message-State: AOJu0YyOFe2mrnELjndsPJ9vPt6SYHfVehFBICK+9Q9gmr/x+MBlhiRS
 TYlvVmezkc47b/tjUhM6mdTS0NT06bylBzr/tMeenBIMDTjaQP0rtnZABrqQDrI=
X-Gm-Gg: ASbGnctAdn6KS5uqnNZDOgkR2va/0ewjh32FfSCrc9X2rfylyfSz2sQHQsja9BUmYcM
 gcEjtpuJI+ot0FSIaLDIzZaCou6/qZ+/1Bbxtk56gbIvfP/iiNbY+y/fgNcT6I3USo2O1rm/4+L
 I9j9h9pt+2I3bvY/RuSTwZrwrhXlxB7goQsmEtTm+0I6b104igDMJyNmtfGrnUkPraORQ7C+aQ1
 enVajA7qQms/ZK4+Ta4aCtWwDm4Yu/JSGmRCXo3WOuGTAeNtZwa+SrbiFxJI0/FIqYnYSf4ygUZ
 KYZiIj2B09081A4Tomsr3HjpOfDLWIV5
X-Google-Smtp-Source: AGHT+IGXt+iABO7Khbbv8wkXWI8pr1448I7XKhX9bqTkqBdjVxzR+S+UyC4by2GtibxqyHAM4UEwgw==
X-Received: by 2002:a5d:6da6:0:b0:386:1cd3:8a07 with SMTP id
 ffacd0b85a97d-386453c5a89mr1611738f8f.7.1733776973414; 
 Mon, 09 Dec 2024 12:42:53 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862190989fsm14292984f8f.73.2024.12.09.12.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 12:42:52 -0800 (PST)
Message-ID: <b92ebc57-9c8a-449e-8b1d-6ec4ed7de8c4@linaro.org>
Date: Mon, 9 Dec 2024 21:42:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0] system/qtest: Access memory using
 cpu_physical_memory_rw() API
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241127191914.34146-1-philmd@linaro.org>
 <878qsobx78.fsf@suse.de> <87zfl4a942.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87zfl4a942.fsf@suse.de>
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

On 9/12/24 21:34, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> There is no vCPU within the QTest accelerator (well, they
>>> are stubs doing nothing, see dummy_cpu_thread_fn).
>>> Directly use the cpu_physical_memory_rw() API -- which
>>> amusingly prefixed 'cpu_' does not use vCPU -- to access
>>> memory. This reduces accesses to the global 'first_cpu'.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Queued, thanks!
> 
> Scratch that, I see some tests failing:
> 
> QTEST_QEMU_BINARY=../build/qemu-system-arm ./tests/qtest/sse-timer-test
> # random seed: R02S7b4a25dac8a32a86ee016342d60e78ec
> # starting QEMU: exec ../build/qemu-system-arm -qtest unix:/tmp/qtest-7386.sock -qtest-log /dev/fd/2 -chardev socket,path=/tmp/qtest-7386.qmp,id=char0 -mon chardev=char0,mode=control -display
>   none -audio none -machine mps3-an547 -accel qtest
> [I 0.000000] OPENED
> [R +0.033524] endianness
> [S +0.033533] OK little
> {"QMP": {"version": {"qemu": {"micro": 93, "minor": 1, "major": 9}, "package": "v9.2.0-rc3-23-g3fe88295e8"}, "capabilities": ["oob"]}}
> {"execute": "qmp_capabilities"}
> 
> {"return": {}}
> 1..3
> # Start of arm tests
> # Start of sse-timer tests
> [R +0.035240] writel 0x58100000 0x0
> [S +0.035250] OK
> [R +0.035263] writel 0x4800002c 0x0
> [S +0.035265] OK
> [R +0.035275] writel 0x4800004c 0x0
> [S +0.035278] OK
> [R +0.035287] writel 0x58100008 0x0
> [S +0.035289] OK
> [R +0.035296] writel 0x5810000c 0x0
> [S +0.035299] OK
> [R +0.035308] clock_step 3125
> [S +0.035312] OK 3125
> [R +0.035323] readl 0x58100008
> [S +0.035326] OK 0x0000000000000000
> [R +0.035334] readl 0x5810000c
> [S +0.035337] OK 0x0000000000000000
> [R +0.035344] writel 0x58100000 0x1
> [S +0.035346] OK
> [R +0.035354] clock_step 3125
> [S +0.035357] OK 6250
> [R +0.035364] readl 0x58100008
> [S +0.035367] OK 0x0000000000000000
> **
> ERROR:../tests/qtest/sse-timer-test.c:91:test_counter: assertion failed (readl(COUNTER_BASE + CNTCV_LO) == 100): (0 == 100)
> Bail out! ERROR:../tests/qtest/sse-timer-test.c:91:test_counter:
> assertion failed (readl(COUNTER_BASE + CNTCV_LO) == 100): (0 == 100)

Odd, this should be a no-op. I'll have a look. Thanks for testing!


