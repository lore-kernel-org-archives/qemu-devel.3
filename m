Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7156CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwPW-0007Gc-D4; Fri, 31 Oct 2025 17:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwPV-0007GU-BU
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:11:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwPP-0001A5-BJ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:11:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so23324935e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945099; x=1762549899; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aOmy+ty/6p4RFEmp6bXRuie0cikeCVAQIgU10DLa72Y=;
 b=CqzNI0BGPEB+GbiaKhm8IDIXmW6HSGiRwkk1C7jHNiEuOjh6s2Xbz/NXb+ZD1BIHkb
 I3Gao1XaAffLNIvez65fO/+9yFRMoSKY2VGbGRjqC+mOQqv0QkCpOnyYtOk+b1tmqi49
 xHfzUcJDlmKyCSogsspMrIv0KZ8BXjOqoQV56L66zl2ULEVNYNITr8D5RtlUbSOauOQI
 lpB+uqpTJzYcG3c/CUOnmBDkaKu+jigQLoR3uCDmADi4/seuU6Ja2ZKykyQ/rbhRwcai
 grHslmUhX+ACWMsHPvbOWaYwd92jIeqVdfO4pFE4bXffrI27Q+YdIrD9EnQ6gB3l1p60
 KLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945099; x=1762549899;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aOmy+ty/6p4RFEmp6bXRuie0cikeCVAQIgU10DLa72Y=;
 b=KH4fey8QFshuFxwySBCJJWDOWqtIZVivF/vMb1Io69YsoMnx7MqOsQSyU2SkJafRRu
 csawswGHcbAztzgpIBCfoHmwA7Pv2t8z/2pWDshI6ypqnuSt6W9wKgBftVvBG6QHh/a2
 uawRSPeiLTz2/10a9wZcWhSOWFUqWhs2AyryC6656yzt47hu3Ce4jFiRr1l3HacEaaKB
 TiyfWTCCGV6kHIjEu4bc30sfDHPRR1O+6ADZvLlIWnM/HGL96b9QXQHqG6GTgqLflObd
 eBl/PO2RaLtImAkKNlm3tqCILMMqP5KM8LAzKIyOfG926yE4XfZf0Z+jGkaVjH6zcXIU
 asAA==
X-Gm-Message-State: AOJu0YwAqaYhqkF/h/tv6szkvRA7Lwe8g5qasbKnwW2j1M13g4rkQpzZ
 bD1e/3BMdt2vwWw/XR0zV7KBaVAvkSToEUjvJ+x+r1jdC8WSq7rykkmdb/gY9U4zXWo=
X-Gm-Gg: ASbGnctWVtyK8hcd2OhE/+UnN4iyPCqNJyiF+v0H4DBtQ1EWmlzSfC8wQuOQnz4ryLx
 /EeZnyKZRYBX+rJnCPiv3GhfI4Gi7za3iybagZdAgkQvT5iP8U7IPc7jgUwmnDEAeygVZ9Nr9vv
 hE1Z5TXKFmqDXKRO6aeolMb4R5J+I4eT6dGK3ofM+q5VSlI6HYdfxJXOYHhbNhLC5W3kNH0p32z
 x1b7PekGfQyWnyvu+ZcROiGsCUljQbz3V6I+WY8BSiH57WMsQvsbTpq58CTtw3uLY0ItQy2eIxz
 Bh0XUkip7vjaZEahivN9cYZ9QqIGEt+47GIgcYk7a6jnqx5J4bN3BLzPXXPT7na4lVBDpmUhTQj
 xcgmc2yQI4TZo/50HTP70bEmO5DQOxy+5wW8nkvRB9ZwCxn8xK4eGxdAuAer81Vi/iS9M/8jT9t
 PkDfCsrZuHPk0wrB3ljfPa12OdibZCpB62dlSNMuAXX2jeiEjaTclUXhJ1xsJtHwcrpA==
X-Google-Smtp-Source: AGHT+IESId6bB+/H4Ac+SSDsVhGxNuIaCwyiIXEwHeCcP2J7QBjB0nq65gZ4V3hBXNBRZPqNfjIsSQ==
X-Received: by 2002:a5d:5d8a:0:b0:428:55c3:ced6 with SMTP id
 ffacd0b85a97d-429bd68d05cmr3841147f8f.18.1761945098813; 
 Fri, 31 Oct 2025 14:11:38 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114ca0csm6262260f8f.21.2025.10.31.14.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 14:11:37 -0700 (PDT)
Message-ID: <b0629f55-5e4c-4e90-9bae-80abc1cdde70@linaro.org>
Date: Fri, 31 Oct 2025 22:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251031190246.257153-1-vsementsov@yandex-team.ru>
 <184b9a9f-cfc2-4595-87c4-92e7c2c789e8@linaro.org>
In-Reply-To: <184b9a9f-cfc2-4595-87c4-92e7c2c789e8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 31/10/25 21:56, Philippe Mathieu-Daudé wrote:
> On 31/10/25 20:02, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all. qemu_hexdump() wrongly indents ASCII part of the output for
>> the list line, it it's not bound to 16-bytes boundary. Let's fix.
>>
>> v2: add test
>>
>> Vladimir Sementsov-Ogievskiy (2):
>>    util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
>>    tests/unit: add unit test for qemu_hexdump()
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And queued.

