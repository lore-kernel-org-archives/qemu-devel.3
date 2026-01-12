Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6ABC9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJZL-0000Mp-Gw; Mon, 12 Jan 2026 10:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfJZJ-0000LA-Aj
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:10:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfJZH-0004oh-Uh
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768230654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jsVySCq0P0ERiwF09RupWUcBhWy810Uz4Q6kTItaWlk=;
 b=iOixtRMNeZbg77GFPOVSHvSN2uO04M2Ch51J/6Ftg5U8XnbGbt8Mg4uKd0mavv74CsBeod
 qhtszi8gUaIeYhhupuLyXUUhgUfw8D4NriBXUf4NXgr7mB5WXknKP02B2YsHlmje2+c8ra
 +xLbyVq5FtTlhv/20YQlp8sCbV/XjH0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-GII6I4gMM1uuTFuiukmUZQ-1; Mon, 12 Jan 2026 10:10:53 -0500
X-MC-Unique: GII6I4gMM1uuTFuiukmUZQ-1
X-Mimecast-MFC-AGG-ID: GII6I4gMM1uuTFuiukmUZQ_1768230651
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47918084ac1so62735235e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 07:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768230651; x=1768835451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jsVySCq0P0ERiwF09RupWUcBhWy810Uz4Q6kTItaWlk=;
 b=II65rY88BQ8ILEDR3Ykj87276wwhZYeHJZ4XB4fNZBePj+s1wGBMJqglKxY7HEvojd
 QHYxLUj6op8GijaRkePV+vVIqRPtbHus9bGU5towoItCIP9DE7WZxMNReGQSYVgkdtD5
 acIRju3AyMjg7rFcY94gISh7im+ylpJr2hdivSYkIIyQDPYTKapmu0Pem/LiucHKsMo3
 lsZSJmxxnQtSMLaF8l7EyXvjRdAiOjNxeC3vjQV/YoUl+Ta2bN7eLYx/8kR9dPCZSggX
 lTh3pAXs0GtV/oN25SAvAYg00h+vDqAMESryIcTEfBM7BactfhCxWeo4E7NW/apZqF+Y
 yY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768230651; x=1768835451;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jsVySCq0P0ERiwF09RupWUcBhWy810Uz4Q6kTItaWlk=;
 b=qkph5Kxi1uQVNJTIGBLqkFpUAs7fIEMrwq2hJAU2ZCnbh95jLexrHcs98Wdm3yM+/d
 trSqXS+RptyrLEAyNOvltPbvFN6CoG/vy//K9TIuvWnwhpdguQx5lIB0t9LzncLvvxge
 qwHYebBUqhIdjp1C7LlMV05hZ6xoYzHh19nZSQjGW//QfaugZwraj0aOG3wSDDDlAFuv
 XA8rxVBF20k9mJTL2DUynZ2SOO1mMSII6hXrVCeKIB96XpsyDbhjJ0bFUZknwhOH/d/L
 TTSuMcWP/kZE7xxH97bSqXUm/m55yv9+7tFUreRbbZFtn/xNA6pXGotDxtwXn+MispQj
 9I+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwOAzYxGS97CF10R59jzpBonoFyUX7xgTtwp2228gcBgkgXcpWCWgLyS9f46srQDG/rA/Wyl2Noser@nongnu.org
X-Gm-Message-State: AOJu0YySeYqJqy+5Gq0kVSJlXO2wxrHq/rstLem0XG770sgUI2ncPTw+
 ee1GDlxXAJNl2nb9TTj4deAWNawxxr2YsecrJKmTYP0qfpCm2Q3PGOKiulU+8YcDvDZLyVhtm1S
 gIO2527ha8DSV9qxNWY7ZwP7RHczu9zogAa1GhzLjvgYrA3bDTK09Y5ncTR/BDcX8
X-Gm-Gg: AY/fxX7/kpz/1LgYwXtAgBO+YZ42WUUapnECvNRi2lmZQ+28WXTdq/PQSb5mep5Qgwx
 XqDGSfc+wC9UH27kuFdFixJXTSREL0MefgyFxi9nxZcL3NyLnf0x8jtEyXNDp7zZpxXoAhfZeQP
 LeXlsh9edIk/6pmcfMF/nSPVhQ2ZzabGpHziQnGdar3ASsN1+/T1DP9MEpoS/vzn6CFERRE+Tvp
 LBsyyiJgyyjZNh7vUgIO9Edf6boDofepBuPqqLGAGroWjPYK+IcBgPuIqw/OgORJcGy+4a7PY9J
 QuM08F0gWuDu+75nlTUooGBWI4BUQTzSyn12DYHyGuWMEIhEBh/NIrs3ZpCVI771v7hlavXPb22
 WB0ydoNoRzV2d3tX9Ro3SYTb5RS4blH+wma8LhjaC65UuPRP2bPpl6j5RSZ6ZqXgHemlMLpy6nY
 LHKOcQ8v6NZZwxsQ==
X-Received: by 2002:a05:600c:3e8e:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-47d84b1820amr201910665e9.13.1768230650974; 
 Mon, 12 Jan 2026 07:10:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMK199SgxtROfI3uQQJpQIBf5Tvfru1q7n9ZU6PDWrmJ4WIktsKweV9u+StK3Zpl4vvQBZIQ==
X-Received: by 2002:a05:600c:3e8e:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-47d84b1820amr201910345e9.13.1768230650543; 
 Mon, 12 Jan 2026 07:10:50 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6953fasm349405985e9.5.2026.01.12.07.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 07:10:50 -0800 (PST)
Message-ID: <bd69aaf1-e7db-44c1-bbf6-6e3a9f2d08ba@redhat.com>
Date: Mon, 12 Jan 2026 16:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/50] Remove 32-bit host support
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
References: <3b5ddc4e-f631-4412-9fd6-ebbf49c55ab2@redhat.com>
 <afa3adb6-a94d-4ed8-b5fb-50071b5d4b22@gmail.com>
 <f30d20ff-ca96-48eb-b837-b3332ef4559e@redhat.com>
 <CAEDrbUaTn3r_nmE8=nQQgeSy5WJNWzf9ZA8xAoRx4RYrGtuJFw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAEDrbUaTn3r_nmE8=nQQgeSy5WJNWzf9ZA8xAoRx4RYrGtuJFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/12/26 16:01, Kohei Tokunaga wrote:
> Hi Paolo,
> 
>  > What is the performance of lowered 64-bit vs. the TCG_VADDR_BITS
>  > approach?
> 
> For comparison, I ran a gzip compression on 500KB data using an x86_64 guest
> [1]. The TCG_VADDR_BITS approach was 1.14 faster than with -sMEMORY64=2
> (approximately 18.8 s vs 21.4 s).

Thanks.

>  > So I think we should go for TCG_VADDR_BITS anyway.  It's surprisingly
>  > *un*invasive.
>  >
>  > I assume wasm32 has CONFIG_ATOMIC64?
> 
> It has CONFIG_ATOMIC64.

That's good.  If wasm32 wouldn't be hard to keep support for, even with 
this patchset, then that's much better.

Paolo


