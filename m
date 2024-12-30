Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CB6E7718F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 17:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSJ9a-0002GW-8x; Mon, 30 Dec 2024 12:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSJ89-0001Sr-Vl
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 12:00:38 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSJ88-0002Rv-2K
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 12:00:37 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so4825686f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 09:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735578034; x=1736182834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uysGPqHIQQVe1qBJd2EeF+py+w14vPg5GTcj8zRTN50=;
 b=JG07gMSLp8BUdlHj4ouSCldp10lHru78gKT1MMJ4azQU5AjFwXlY9wmXHoTNzRPtqV
 giSJ+ZlSd8rubujU4c5J9ksVxZiuzGQU7qN77CiWwCKjy1RMwjUznE69f4NVyYx2QlBY
 kW/u4+w6I0YXvaq4GT2yeKZru+kwEPTmLvYZeTDA+wFkx3pB1aso1ZpkZ4ClxZnLoun6
 UXxmDnHbFVcqoCQ5XpGg752j+pRkVHCz5AWl9/znEwPaBpZHFOMn0oYHqz+eLLimCfB2
 WsF86FPvqULMEOzyVhfncD+q07mDZqaRR1I5a6koKWJ1LU7WGagP3dpiBMAH33l8Epnu
 6wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735578034; x=1736182834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uysGPqHIQQVe1qBJd2EeF+py+w14vPg5GTcj8zRTN50=;
 b=XfT21bH9rEX8ODYwQv4huuSXimVyLpUeyvVibsLvYMHkSlwyfrpSIITYoGJ8Hhduw3
 iC7G0nJIXjmUgMxVK5lI0v+ANTjh0ajG3c/mB91XexZFRqPpPsf/quAnzWv/rkg2ziZ/
 h4jNJzS9RcMj7ABrDd+ksWvqCM9LfUbg+ol1RhJOwY8oRb0lcRheSuv3pSI++2FNLa02
 DGElyspHRSffpnc1arDWdJ1JsR7t5i06l2OlYqwGFVUUWyVSNSLAPFXQj5BIp8Jq5iKk
 wvr05bwazAjQpDkP0wRSENLJA2ixeK35H9sL+sV/viE619fDhbx5cHvguthBMBfC8pQ4
 z6/A==
X-Gm-Message-State: AOJu0YxE9eaX+/KKHcJF/IQ5y54bP0HnGz5jOhZClPOZpprrAcJS/PDJ
 AXqhtlf9wOoQAwZkBpy/Fz/pvYMl30snfNsEZ2dnJ9i8SVVkuyMvGJcBNJqKRvU=
X-Gm-Gg: ASbGncvCMExIULWWqM5aN44LQXJIj3YMkYzEknhsFqpd1y5dJ8q2wG6e6sPxy3yL7Qa
 /7WlGWzs44ff0lO0BvvIBccfhzVifE1rBIDFInTc29MiFRvdlO+AyDTr60mQY8kQOYatEkIbKbz
 DuXoZsrWbrZShDNfTyg8q7k5i4QkzEtZzJ0+A9XtXysiWALvae4JX20UJMUuyUG5+cDaOtsc2mZ
 cvqpGKa4v7GQxaDt5VCkpasVdwM3mLbaCSOMS8PTaapwwNvho2MNwmpN24Uut/Dbh616wId5JOu
 3Ns9gdL544meTjNVoJwk0e8s
X-Google-Smtp-Source: AGHT+IH9hwW1umq9dNzSUY3QfahCxuPQLAmi1OpI1yimD5k1cRlGQ4Y2uLBn0FrI4cPBVgNa3I1ZTQ==
X-Received: by 2002:a5d:5847:0:b0:38a:2b34:e13e with SMTP id
 ffacd0b85a97d-38a456cbf49mr10495703f8f.18.1735578033902; 
 Mon, 30 Dec 2024 09:00:33 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acc02sm30178332f8f.104.2024.12.30.09.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 09:00:33 -0800 (PST)
Message-ID: <d3f20436-74ff-4bfa-9b70-c6687d95b423@linaro.org>
Date: Mon, 30 Dec 2024 18:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2] hw/avr/arduino: Check for CPU types in
 machine_run_board_init()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Iris Artin <iris@artins.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20241118130109.7838-1-philmd@linaro.org>
 <CAFEAcA9YQcseyQ3Csf3T99xRfbmvgetkTPZYO22_QE4SZpis-w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9YQcseyQ3Csf3T99xRfbmvgetkTPZYO22_QE4SZpis-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Hi Peter,

On 18/11/24 14:07, Peter Maydell wrote:
> On Mon, 18 Nov 2024 at 13:02, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Leverage the common code introduced in commit c9cf636d48 ("machine:
>> Add a valid_cpu_types property") to check for the single valid CPU
>> type. This allows reporting an error for invalid CPUs:
>>
>>    $ qemu-system-avr -M 2009 -cpu avr51-avr-cpu
>>    qemu-system-avr: Invalid CPU model: avr51
>>    The only valid type is: avr5
> 
> This is a nice user-convenience feature, but why for 9.2?
> We haven't bothered to error-check the user specified CPU
> before, and we still don't on many (non-avr) board types.

This patch was motivated by a confused user:
https://lore.kernel.org/qemu-devel/84975169-3c87-42c8-96e3-7ae724cc4692@linaro.org/

Not checking valid CPUs on boards which only support a limited
set looks like an open gate for more user complains.
IMHO checking them should be the rule, not the exceptions.

Back to this patch, do you object to it?

Regards,

Phil.

