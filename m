Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0376AD42BAA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtrP-0007ew-61; Tue, 12 Nov 2024 11:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAtrM-0007ec-2Z
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:35:21 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAtrJ-0006qJ-2I
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:35:19 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cef772621eso7307943a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731429315; x=1732034115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtv2v/FtQ0MJwY0Dq9yPPHWOTXHYS50EWcbqwJJAa8o=;
 b=RinffX8R9dVO1quz0sHo1hqGrywsPZIPdivAdW/HDBCj8QDGlxXhAp+ApZ2MzKqwAk
 AmAmAROvl+xPi5sbuibJ/3Cgcv1on12RHGT27nycuBE+rzNOpyngPqtL88fHrLIuKV5X
 RpW4PWRJDSuDVkIMtSANoo0sGWXr7gaoI2dhBaMsyNL1wiw23CvrIq0PbMSO4DeXhHWa
 Gbmkbpw1OmGgU3HTo7VLfQEt4pdeTCOFmVkpCSDNdoPN9+l22sy2BHZv12aI5Hrr9znn
 genTe0zc6nheSSkpAn0XcoEnVbBUurLgXfOZX9oF1ViGGBD5aNkktlSinoN5Xbje1vMy
 ZCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731429315; x=1732034115;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mtv2v/FtQ0MJwY0Dq9yPPHWOTXHYS50EWcbqwJJAa8o=;
 b=Nc/4O6LAJ192vh/0U0eCqH0q8IaiaYHW60KAyPZoQ357hbIBFQrYbhU5aR50a+TLoB
 pBkuCXNkd4L+WVNMUNVO6a1smUgdDqhYoUFntRNs1KjIUndfoPv9NdLTsIc9Jkv6xuiM
 2p3/rcFtKbpHRF9Yvi254XVx0qfB0C70krpE8RVDsxemBuPlewQa8K9veENMfR/pyAdw
 HzYVnBISM34+kosK+KYh2ZxK5ibMt3VpwF+U4DDY+UFjCXwrisbMLPE0+tkpLqSmRFkS
 6hN8GQuSVILGvDpnoW5lbaWrUKu4CME3bbJI7Io/rp+Rr0imGJ/UwwDayLYnq6Y5oNYy
 3gkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURlKCPwxVoKOc+teUEu0ycj6nl+lY3DwkyyZDXZclZfBMBljT5yJOYk6dn8ATFENercnJifg7Lgd8E@nongnu.org
X-Gm-Message-State: AOJu0YwX8RtaRVgHMw+ToJG84dRPRukcLKeG2aetx5uAazgjY0+fOdCH
 +uDk8nH/IMNvDOBQ0q4VCRseKBISAwNna9P19GVgonY2rHkbErQJEnihcnsl+ac=
X-Google-Smtp-Source: AGHT+IFW8v5HccavQj4jnFrf2XdDvfleEtnikWRGSvLyumIZ897lRap0dC8tqM71XOUzHsOvfVbcnw==
X-Received: by 2002:a05:6402:d05:b0:5cb:b65d:2b6 with SMTP id
 4fb4d7f45d1cf-5cf0a45e6abmr12643733a12.32.1731429314659; 
 Tue, 12 Nov 2024 08:35:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03b7eb16sm6174746a12.28.2024.11.12.08.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:35:14 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2709C5F7CB;
 Tue, 12 Nov 2024 16:35:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Patrick Leis <venture@google.com>,  laurent@vivier.eu,
 peter.maydell@linaro.org,  qemu-devel@nongnu.org,  Peter Foley
 <pefoley@google.com>
Subject: Re: [PATCH] linux-user: Add missing mmap include
In-Reply-To: <dab7363f-48b5-4f15-893d-1621ec9481eb@linaro.org> (Richard
 Henderson's message of "Tue, 12 Nov 2024 07:50:53 -0800")
References: <20241028181821.1440988-1-venture@google.com>
 <dab7363f-48b5-4f15-893d-1621ec9481eb@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 12 Nov 2024 16:35:12 +0000
Message-ID: <875xoswgu7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/28/24 11:18, Patrick Leis wrote:
>> From: Peter Foley <pefoley@google.com>
>> error: use of undeclared identifier 'MAP_FIXED_NOREPLACE'
>> Signed-off-by: Patrick Leis <venture@google.com>
>> Signed-off-by: Peter Foley <pefoley@google.com>
>> ---
>>   linux-user/user-mmap.h | 2 ++
>>   1 file changed, 2 insertions(+)
>> diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
>> index b94bcdcf83..de769f9253 100644
>> --- a/linux-user/user-mmap.h
>> +++ b/linux-user/user-mmap.h
>> @@ -18,6 +18,8 @@
>>   #ifndef LINUX_USER_USER_MMAP_H
>>   #define LINUX_USER_USER_MMAP_H
>>   +#include "linux/mman.h"
>> +
>>   /*
>>    * Guest parameters for the ADDR_COMPAT_LAYOUT personality
>>    * (at present this is the only layout supported by QEMU).
>
> In what context does this appear?
> Both glibc and musl define this in <sys/mmap.h>.

I'm going to take a wild guess it's bionic:

=F0=9F=95=9916:33:53 alex@draig:bionic.git  on =EE=82=A0 main=20
=E2=9E=9C  git grep MAP_FIXED_NOREPLACE
libc/kernel/uapi/asm-generic/mman-common.h:#define MAP_FIXED_NOREPLACE 0x10=
0000

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

