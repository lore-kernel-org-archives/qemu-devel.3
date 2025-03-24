Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0ABC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 17:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twlhe-0004w8-Kg; Mon, 24 Mar 2025 13:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlhY-0004r9-VC
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:35:06 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlhW-0007zY-0y
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:35:04 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2239c066347so106141085ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742837699; x=1743442499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wL6zejufrEbdATvCG/8Ytmv1LFvg7CVt+hkjoZn7zLI=;
 b=aizcjNZHgt+/9fQopDJUdWiBLcKn0MlDLu3HtNPSLrXcJ9rgienaqqsCl9HjCn72ZZ
 Orty4db2a0u0yPSsColEqDYvbGyghY2jeLd9W2Knm3L+hsb6fRS9Bq3b6/ymgF/vFTeX
 DYLRTYRoV6J78K4nlB3UIjmntkRVAvD0IXffZrw5HRaaVrtHbPIuC4Ms2VfZfQd2NPxQ
 qsKe9vchO/U/SfqUfLJfJHI63TpVSN+DhP4TnBuxZEThfViKBFqJhPiXR5D9Uw0+fF9I
 lh/bVnhg+zBoRpy2MzCR0LZmgGUeCdJoDytyKYdf5koYHaUJ+rX/RRoK9d3FR2WQHgur
 7AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742837699; x=1743442499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wL6zejufrEbdATvCG/8Ytmv1LFvg7CVt+hkjoZn7zLI=;
 b=KK+ILNAED48sQHD5cWee1e/8NDJMCW3NzZwt6cJzcuOdAXimcuTdnDXSKzrlyVECU8
 MsMVNlEkVpcW5wxIgH4kCBmA/6fJGJma9Z9gnJ9DB227HpGnxyyQ4sU4rMtPO3WBcgl8
 q+JhqNAFk1SuYzIRDlodVrUWoIVjz4xuBVXnTOTqXObLbiLQyJFePcQ2of9YkIMbxmHi
 a2RreGB++w3KoN+FsuM/E7yYLTxbo9qLu1/TNQypfQet1Ry8H2NlXMcnEisfTgdPEQO+
 8ttzdaDCb1RuMt3zcVBZIULRZvDhay3wVc+mwALUmwwfZYkkXAYcFjnFewMY06G0xVny
 mwTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWaGXHrdGVIyTMAX8YSjRESqvVGwFyTwXzL68U0PUE0KJprRxEhHuM3HpfKIXOG/AL2cKt7HtmB/26@nongnu.org
X-Gm-Message-State: AOJu0YwKEbT8+xHyv2EEVWfF0/Bb10J3xSBPRvJSqxm+KC+rMs5cHhcy
 scpnKqtIaH2EL8MyMAnThjrX69+7ouL4H4FY9EGUau+9wi3iYzWcsV0hSOOAlSY=
X-Gm-Gg: ASbGncs5B1fmTAvKvCY3g1O7CNMRnkIK3qLHNoYx6QxkVU/6QRmR/84Czx2EP0XgCF6
 gqy0Ne5NDo1kSi1O+X6of7jGSiWVyPzhS+Bk5LsB1vW41gcuLcBfNcgGJHNZlMvsy8u5mcC85Dr
 IsvujlitqDqLXFeYJGr27MENFj9VlT7CeHNwnVnuzNSUamwfkS39vi3XEM72HDB73H/LUZuUS+h
 ya/5+D1N3P9k7OH48m7XrAr782lLy0xNScMxKpntNWH7XKRUlwu9dTQ1QgezoaCBQ4qdWhuOoWY
 QgnFFZXM6H6d5BQmWoamnOaH72EfvZRzPNES3XBBD3AiQIVyZwAKeWzkahZznIUk4KrnxsXyQtY
 u+jLqpNkl
X-Google-Smtp-Source: AGHT+IHK17LXfEhS5wnRvUe/k0B5oxmMvO/Q0AAugodo5l3UQAf//FaDqtWy9ttMGzV1DNWnoM/stg==
X-Received: by 2002:a17:903:41c6:b0:224:584:6eef with SMTP id
 d9443c01a7336-22780e3fb95mr254254845ad.41.1742837699342; 
 Mon, 24 Mar 2025 10:34:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4618dsm73839705ad.73.2025.03.24.10.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 10:34:59 -0700 (PDT)
Message-ID: <e92e6769-dc30-48e3-ac90-b4f7c4b93aab@linaro.org>
Date: Mon, 24 Mar 2025 10:34:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] target/ppc: make ppc_maybe_bswap_register static
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250324102142.67022-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/24/25 03:21, Alex Bennée wrote:
> It's not used outside of the gdbstub code.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/ppc/cpu.h     | 1 -
>   target/ppc/gdbstub.c | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

