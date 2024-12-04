Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5D7E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 10:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tImFa-0004xY-Ss; Wed, 04 Dec 2024 05:04:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tImFZ-0004u4-3n
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 05:04:53 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tImFV-0004QG-Tm
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 05:04:52 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fbbe0fb0b8so4965706a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 02:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1733306687; x=1733911487;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FRlC53zx7CTBPvkyUd1yQ7GAZC3qCVELzcDZmTQWxu0=;
 b=GXAK9BOaFA5RPODHd/Dui28FBG6iPHwz2QjuvjUecIvpj8fjfEjRCOKY5rll+Su0eR
 87erB/eo3QZfZEUGXgfYoUOFvX2vHftjUVwF2mO6ziWkgKLNr88hs8e2L3tafjfBsTTx
 g5aO+4FQsJd8hazX0QnP0nEPUnMBhBDhNCnbmbM/olhaL7BZmif44/NIK97qWa29Dzrv
 QhF+C2ZqK8CNmTdAHt9VuRGWo8cvGXKslq/2jKyP29LEcXHBqVsuXQWlcaMQD8+0fzhg
 tv2UU30tRsRpLZyTifBv9kCOesU1I0Wmux+J1y5Z6ZLwJkF3XGU3uNiPii9jVx8+t8ju
 D7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733306687; x=1733911487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FRlC53zx7CTBPvkyUd1yQ7GAZC3qCVELzcDZmTQWxu0=;
 b=tW4JYR7wjYBVXxpIJsjtBaC99+7Q2z2QQxayvm05KGQO9Ybp5XyjvBmO1IzdctbD0J
 xCsJaPzZ39PLefHEeapQyjqfnPCq8TnUdWYWVakkE9RkKjL4oO4UyXM42gWA1AU2K7iU
 3RAaEk5MyEr0/H5JUkuFMPeqj2PtJCrP2HYOecNOnbN7iR5OYk3vxI3/gERclUg7LAq4
 pQDodWWQj4iB2eUPCjefOBHNL8ajE+DlsI9PgFnF0dQJmVVJgNjfZ714Wdv4/B+yY2+r
 QkstuewC6tHAM21OtWtjQOmK4qFWIRYS9nK7b+zz1E+mxNxHBgYdoXdUvKR/NFOB0q80
 kL+A==
X-Gm-Message-State: AOJu0YxLVKVyYsMJCXq0J7TjsPkXOdiXBlg+RCRNssRPWSbr58tSvH7o
 lQFHgQE1U5glXX6orWNgiScv2zh8hZJcnLmoNSLcbvbIaNgNn5y5AkWzZDRevLM=
X-Gm-Gg: ASbGncuiboOlxZwcLH1OlaEG3gpwlMhzee2zf2oIrjCBUXjlSUd3nM085nJe9F727et
 5aCPAF7o5TbU0AQlrOMoAZJK7m4sx2lJRt9gRs75v2x7LtAmb2W+1c4ToM8N3c35DIuAzp334Vo
 901y2CNS6QZCSW1rJTQP9+uFtgK8ScS+QRI3ssz8VDt6QLKs8aRUK66N8Ek/YDW/RIzc7hk9XSj
 7tDaHKznYZdLDBa3+Iqxi7itSLJ0aUfepsWgSP3UxEbGSVdnQwSIOV095f6dwb9YkhKwJo8+Dg=
X-Google-Smtp-Source: AGHT+IGaTKyg/Oq0u5ua5JYgLLmC8aqnZOoqwMu4G75fcZzNVLWqxo4woXBkXhzuzmJb7zCWL6oodg==
X-Received: by 2002:a05:6a20:7f8f:b0:1db:eb56:be7c with SMTP id
 adf61e73a8af0-1e1653f333bmr8969413637.35.1733306687183; 
 Wed, 04 Dec 2024 02:04:47 -0800 (PST)
Received: from [10.16.166.2] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f165sm11928286b3a.41.2024.12.04.02.04.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 02:04:46 -0800 (PST)
Message-ID: <3f6c5a91-b106-4782-8fba-d227c0cb7cb2@igel.co.jp>
Date: Wed, 4 Dec 2024 19:04:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] support unaligned access to xHCI Capability
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, its@irrelevant.dk,
 foss@defmacro.it, qemu-block@nongnu.org, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, farosas@suse.de,
 lvivier@redhat.com
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <0ace2747-efc8-4c0a-9d9f-68f255f1e3a5@igel.co.jp>
 <CAFEAcA8oDPD7xdhMC__Rp3WOzSdm9CnSHw-bepvQnxK3BMzVOg@mail.gmail.com>
 <1499e05e-acf6-4e4f-8929-e8bec5b92fac@igel.co.jp>
 <CAFEAcA85NOxbmzpCT-5jv5uvcFH2WU5zm+fRTAK-VVG6LQRLbQ@mail.gmail.com>
 <ce5fc614-a54c-4003-b27f-6f08e56dbf08@igel.co.jp>
 <CAFEAcA_d7CUqJH1aJfOsBhmA4yZQh61Mw74NDJkJciZoeC5WNg@mail.gmail.com>
Content-Language: en-US
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
In-Reply-To: <CAFEAcA_d7CUqJH1aJfOsBhmA4yZQh61Mw74NDJkJciZoeC5WNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/12/02 23:17, Peter Maydell wrote:
> On Fri, 29 Nov 2024 at 03:33, Tomoyuki HIROSE
> <tomoyuki.hirose@igel.co.jp> wrote:
>> OK, thanks! I got understand. I thought MemoryRegionOps had to be
>> 'static const' .
>> I will try to improve code so that it does not require the use of
>> memaccess-testdev.h.inc .
> Great. The other thing I thought of this weekend is that
> we should document the behaviour in docs/devel/memory.rst.
> We could have a new section there that describes how the
> core memory code synthesizes accesses that are permitted
> by the .valid settings but not handled by the .impl
> settings. That way device model authors can know what
> happens without having to read the source code.
OK, I will also write the doc as I can.
> thanks
> -- PMM
thanks,
Tomoyuki HIROSE

