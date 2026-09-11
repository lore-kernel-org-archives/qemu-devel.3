Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F169C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wBo-0000dh-JQ; Fri, 11 Sep 2026 04:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4wBm-0000dT-C6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:00:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4wBk-0004EU-LJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:00:50 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ceab75934dso6676675ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789113646; x=1789718446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6SQgygRS1ArlJhJfC3qcKc4b9VIJKGx7jzJC4w95ocA=;
 b=SQtGlvVYLdR0pKQt8DYdxzT7Pz5TsX1cgxbPNkNtS5lwBkXLuDK8t2Mbg39NZPmIkY
 n5VpS/KEoznaAN/UAp6ImdVeE0UfYYgASnhUSG/InRyWwS20ydZgsPwfZ94+b613bd4/
 0N4NdxMtxyTxdcfv8Ox/CYthRKR9/DS4uuOPi2pa3ke5sKitIwNzZDIZQn88djX/n4pk
 GzSfWnWkN2xU1WGKxg1uEG3hI++TSrgcSIlNfovQhjMcT6p0yUo8xS39ApoumPz/gxCD
 VLksGuzw33+A8Htr4Z0YRfB2tnfG4IO0AFq/mO98bAP4Igh+6JM007M+vDDcUI22EFHN
 6yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789113646; x=1789718446;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6SQgygRS1ArlJhJfC3qcKc4b9VIJKGx7jzJC4w95ocA=;
 b=PY/jZGEvy3zLop0I57A5TnGwxYeNNXClpP4OfBDHxe9XRZ7rOZ12Vd9s4OryC8Pdgv
 IDPbkSUAY9Fpfw+og5QTj2ATAm6S7eevPXewDcsfSafemaJA5aAhk7vU4B66y7oLir4e
 N1ZDzWbWhEaXqQcCOPQJkBqHZhiF3ovp5yjF91DFrm4hR+YC6wwo6IygfaX9HVIIM2DR
 fGfw5ftg14ZTW+oi2YvPxFiI6NULl6PF7TjkpoOd2Fc3uyUM4aGMyP3dQOEBZatSeXyr
 xKhnUkXs5pJs2FNGgqMSfn/TXsbwKSf+vfjGyL4W+JVE/ataPnIGIB43m7avl4ZpsAWB
 8SXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxn2mfn0QUZBmtP+8eSp49/9lQ7zOGfFYrJJBV+38sU3NOvTZIHlgTzMOtcdf/61IPQnJEVblE8AyF+@nongnu.org
X-Gm-Message-State: AFuF++mBcN7+OrkfEsZa//Ofy4/GPzJEepsJKdBboJmWbTbmY3NdZMMc
 l95FdhBky/ATr3S4fhofHpbTnjAqTZ3FSMWhl4bvdwAjqXALHuyS4kL0PDyoeP/qAtM=
X-Gm-Gg: AYBFou3EtWjsgFmfWxJwpV55AE3aPfr0XxxuU7QridSYWKzVtR5nZI1KqTyb0ctTM/j
 tiEwuH/HJpz9kycWF6CY2KNabpduoEUlXw5abyP0p5bef1t07AVoFUTE1AXCy5KH/uM+SAj4sRy
 zWUmB7LSE6WI2E67DhdiNxBqPH27hZs1ZDDyMqLdVjsArfAsNR3f2j2lb8E66Q8+TZMHgilVuns
 JgS3oyVNXMXVhXkjPgFEZ1T+dzXbDMj3pKJ32dMt8/rizsEB3PYA6aDeviOOrw1K38MjzW4dWHl
 +JPIZZhlAxxpyMw7DuuowBgjWLyqLCfQktn2dzJQMm0IQtNARu9JNG+xcWkY4/vXUNgAcx/O8i5
 jJDLXCfoLo9DzkbEVkrhNdF7k8xAInFy+3Q73UyObznDxFc8ioMD/JPuzGy2ReFn2bEEWA53NRV
 iIPtIjyTSWyzzVtP2Q3HNTmSW4JqLDmUNnDrCOeyO4pPzTXT1wXjVgEwW3hW0mARtWr8bRDUpMS
 0XNrvv22bIFIFt6sATYeBXHU8kbJnpuWSnhC4uGw7conE4/NCx90jnDErg=
X-Received: by 2002:a17:90b:3dcf:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-39d9bc44857mr5405876a91.7.1789113646315; 
 Fri, 11 Sep 2026 01:00:46 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e95075sm4318619eec.11.2026.09.11.01.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 01:00:45 -0700 (PDT)
Message-ID: <5d853e09-8919-48e0-9e6f-d3a1f1bb84ef@linaro.org>
Date: Thu, 10 Sep 2026 22:00:42 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] next-cube and test patches
To: Thomas Huth <th.huth@posteo.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20260910114522.396396-1-th.huth@posteo.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910114522.396396-1-th.huth@posteo.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/10/26 01:45, Thomas Huth wrote:
> The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:
> 
>    Merge tag 'qom-qapi-pr-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/huth/qemu.git tags/pull-request-2026-09-10
> 
> for you to fetch changes up to 72a02f711d11c78b88869dc00db392ef08504940:
> 
>    hw/usb/host-libusb: keep autoscan enabled for bus+addr selector (2026-09-10 13:34:51 +0200)
> 
> ----------------------------------------------------------------
> - Fix minor issues in next-cube machine and mark it as deprecated
> - Add a configure option to disable tests
> - Remove stamp files when deleting assets from the functional cache
> - Make sure that pyling version is not too old
> - Keep USB autoscan enabled for bus+addr selector

Applied, thanks.

r~

