Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3498FC282C6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 00:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpGYl-0007Cj-5B; Mon, 03 Mar 2025 19:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tpGYi-0007CQ-6v; Mon, 03 Mar 2025 19:54:56 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1tpGYg-0003yv-Mz; Mon, 03 Mar 2025 19:54:55 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fee4d9c2efso3458159a91.3; 
 Mon, 03 Mar 2025 16:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741049692; x=1741654492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9GQDteBR8hy5o9ZYBuezM47Cd14MdiKLxkqKkM7dSPg=;
 b=mTKXe1oM0YsQM1zS/Bew3kRRjAcOJRgOKOSR59Gra8Fd/FGrZ2xeVcWDBBUhMz9jf4
 RTD44E6n4O4ntZvFujuKvHQaGFHkfqCcxW78yisgrPKKXd/HCqAQi/h3LTgecKgaMjCn
 9D0EkMoZramFVDM4yjQPkqfMtxOFDrus58HJokGzhIMLiHNIKlzPaSAa3TneDoCgTFin
 EKbYLvhbhp7lSBe1ZnKjq5cDOvZN6D+cJ8lYBkG7pFxNTs00f7LztWWIKxImtU12Izs4
 SGv2/sRB7LpxuaSEdrDBjLgaWNiZHdz1Q3AJYjavHz07z1fgClukLSiwiwiyPygeJLb1
 WHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741049692; x=1741654492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9GQDteBR8hy5o9ZYBuezM47Cd14MdiKLxkqKkM7dSPg=;
 b=NasN47s0mbm9WVixLskPudNg9BZMzHh963eS0GyAhnTy18p2NjH+USaazxxunyjbnC
 oar5/qGv2NzqstX2F4I+5sh95u1YAqsIdN2tRrGQG9YdQ8twforEeSLX4c9N1XNiM0UQ
 eXAFRs9AFbgdEs4bJNX2QVmswcosi5Rv3Tcyj8/Kw4+HW9Uoe5JrhOBYBKWD95DwYYx7
 cSgD78yXedDT4h2lMMjBhN+ntw5rjYym8wixj2GaUaQbCGQ+n7IZ8PSY55O5i2rvh+Q9
 3zXk6qHDYSbItz+ipfCHB5umARFlptLydholvs1mQ1ahsmUqQc6EfYQsYtud64wAHPCo
 uVwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFqoNPuhvPF+TMCkP3dnH/S5deJCold/x1BbjMFd7Hp8NyXQC16YDNUINsy1PJ608PMhbrWficmToQ@nongnu.org
X-Gm-Message-State: AOJu0Yx3UDR1Bnz0DFemUj2AWYrZk59yMMkEazPvUbnu8FAOmck+WF8K
 eYhhXAcI6OvlJhEBJjDNy0PmMYVdTjwubpcGPap9EHPbEvKRQEi6
X-Gm-Gg: ASbGnctzounhAJ0me9soQn9FrKaGl3/qE3BDXFQM3soOJ/jI8O4U61q4QCqNoI8dqTR
 +BBfqiAzvYRjEl8sfQLTlhw/DFaLnY+na3D9T7i+srwKSRGZWZneQqG5rJ9ii3b9q3HvuSrPWQH
 PvUn20H/+7vPbuWrZHkbvB8WBUoMdJvFq4VW8WsmlP/haEZip6YKTaCoZO3m1ULi5Sya38lSpsG
 Dj9krCVW24TxB/LCIEkfjBBA5BlfKfYM3Elm2vC17pEcYUjeEQzHh6Er2E5rDzNpuU6FNS7QjFm
 kvYL7tFv8aylvaBOzSiPsKy0PHScUYV6u/dSAVa7+57Vz0+HPPo8rSaUTqw=
X-Google-Smtp-Source: AGHT+IHGfwn3iZ4SURwJKCQ7u/4YUNzblo9cXiyEntmn5u2VaIWtLxACrHTu9XCWXCdQOuyVpaAFeg==
X-Received: by 2002:a17:90b:1fc6:b0:2f4:434d:c7f0 with SMTP id
 98e67ed59e1d1-2febab57061mr29303699a91.12.1741049692067; 
 Mon, 03 Mar 2025 16:54:52 -0800 (PST)
Received: from [192.168.0.22] ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501d6bd0sm84595455ad.42.2025.03.03.16.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 16:54:51 -0800 (PST)
Message-ID: <929a3460-6ad7-4028-a6a2-01a33884c41b@gmail.com>
Date: Tue, 4 Mar 2025 09:55:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/ufs: Add temperature event support and test cases
To: keosung.park@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "hreitz@redhat.com"
 <hreitz@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Jinyoung Choi <j-young.choi@samsung.com>
References: <CGME20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
 <20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 2/25/2025 3:40 PM, Keoseong Park wrote:
> This patch series introduces temperature event notification support in
> the UFS emulation and adds corresponding test cases to validate the feature.
>
> The first patch enables the UFS emulation to generate temperature-related
> events, including high and low temperature notifications, following the
> UFS specification. This feature allows UFS drivers to handle temperature
> exception events during testing and development, improving validation and
> debugging capabilities for thermal event handling.
>
> The second patch adds test cases to verify the correctness of query
> attribute results related to the temperature feature. These tests ensure
> that querying temperature attributes returns expected values, helping
> to validate the implementation and maintain correctness in
> temperature-related operations.
>
> Keoseong Park (2):
>    hw/ufs: Add temperature event notification support
>    tests/qtest/ufs-test: Add test code for the temperature feature
>
>   hw/ufs/ufs.c           | 78 +++++++++++++++++++++++++++++++++++++++++-
>   hw/ufs/ufs.h           |  2 ++
>   include/block/ufs.h    | 13 ++++++-
>   tests/qtest/ufs-test.c | 24 +++++++++++++
>   4 files changed, 115 insertions(+), 2 deletions(-)


Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>


