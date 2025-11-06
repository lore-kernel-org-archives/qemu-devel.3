Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263C0CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 10:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxVX-0000WA-6y; Thu, 06 Nov 2025 05:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGxVU-0000Qd-Hd
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGxVS-0001wY-KO
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762425977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Up+ukWwHkDoEVhfSrrAF2Mn5BJY2/caNC2Gy5QaY59M=;
 b=bn0Vyc6kSLelwhPGmHawnydjwTxrBh+UaSZozeyr6e50CZUvfH4FdqBN9oRggyCt3jmSev
 6mr3wsTZS3sTogjSRbxWCEIXPWr+8Qh403Xx1/DdNUUKtuo0VsXjnvhT2qSi/57Hwpx53v
 7AiEbTmWnZN71gEy7V+9pZF0IcBzf8E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-yZ9_XRJxN4CMu5WsGc_m8Q-1; Thu, 06 Nov 2025 05:46:15 -0500
X-MC-Unique: yZ9_XRJxN4CMu5WsGc_m8Q-1
X-Mimecast-MFC-AGG-ID: yZ9_XRJxN4CMu5WsGc_m8Q_1762425974
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c5c8ae3bso876180f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 02:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762425974; x=1763030774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Up+ukWwHkDoEVhfSrrAF2Mn5BJY2/caNC2Gy5QaY59M=;
 b=hPWYUxa2Gyz69GPj7zzoeDoIMNnyzfls90xkF5xsPOSBgkBWMg7AAAO8K29Oh1NuXz
 iFW0qT2cjih0YFMeZU+jiGeF+wuiODrjX0paqGd9XdNf5nU/X7TkJPuzA9qyjllRlPPP
 4r6mnifufbyHgnqdI00F7BgR8q9GMuNDQ8TaV0P4lypsoxkG0mKVs7itDlBObLc879Ud
 4OZzE5Qo22bDFKwjP2RwFw+Pj80X5xmTn/jX3B6BYVP6Uzr6o1FHGsZBy+ijwB7hslB2
 Cjz3A+sNKqreTthdOp5ity9ZykMulDS+W8XGYMGeisd9LL4aL307TE0YMmgIKdK1KosB
 PqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762425974; x=1763030774;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Up+ukWwHkDoEVhfSrrAF2Mn5BJY2/caNC2Gy5QaY59M=;
 b=WjNVqE15H9t7OiGRUU/pDRukOUDrxW2DRLNeTcUNAZvHAL6R+AM5JAvPV8vesM1/q6
 NV0qieLaAOlxkUXnqJb6EocHOBsr/6p8sJ2stG6uRUwzxdQec3morkikUufnwWvYEHIT
 pDHrUbMgm+EUwr3A2lR+zRU4jfzLnjYwfL068zRTMKOeUzFFWY1GHAa8QuqOh1zCw4ef
 ZwMis19VSXxoas7V54ocZFoCXbO4tlzr2EnEuFHblI8XTVYnIW4Zv1nmi0udWNeBrY3p
 c+7L4zZWgm/ctYZ5Y9bScvTF4koTE4yj3dowvjidMzfMxErFT24AXfXQOO9KihK86uud
 5nnA==
X-Gm-Message-State: AOJu0YyKOr1Ibh6PyOG/ljNRsvyQxTIGWVLlbOTKuqyybs49hFgGCm4w
 y0dXzsBBu/nhhYBnqWj0hVhk2/I1acw/N+xKSJwBZ5XoxsaZ76nTusyJsgZqvI1I8zVItfRPO7w
 UC2dD2UBY1ffH044UNa65RXN3M7Mp21ZFobAiaacyoEOPlDyoY5QBN+d1
X-Gm-Gg: ASbGncvH5O4SCkktl3Pkc7q3GvrEnGdcfVCFyaeInTMY5wBzW/yziRs7slDZNmjxXd9
 cTD3NhmGt/yb/EyHvaAqsKUXEQDUCtqTCQhUcMJ5qkSAwspOgWOxRd5LqKhRUELt4rRJedAsTGZ
 uijeko/gOEv6CWxx34Sy3xXnAm05CO0W6dAxR5TvCk3N1u7TjRhxARc3weQxGtcrLC7C/zGycVR
 X4u/0TrE24CAxq/uJCMwDq2F6oq7Ir4hHVDPJup0lmPIfOPpx9KS5bU8tFaJWL/23VIFlS1Yq/p
 cn7n9jKOJAqiD1F8Yq12AA6I7QKiZaclpR2stLY4GIIlbrwR6ue7RhsTicCDHPjHKhbSq2TQXp2
 igbNcB9BzT9vmC/90zHNPDhAk0CgbZzj8E8DZr81PpGcZRWoDgdBmkP4fkPA8Ke1/tkFW2B5km1
 YA/F2tV2H1J0vy/Nq7I5jFIlkA0GhK
X-Received: by 2002:a05:6000:2508:b0:427:928:787f with SMTP id
 ffacd0b85a97d-429e32e9289mr5044521f8f.21.1762425973989; 
 Thu, 06 Nov 2025 02:46:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6/i3Fl5ruHaSnnskThEyvpBmJzmuvn4+KwiUi64NvZ8ndC8kUvaOwdt6zCpu6MREtJCJlJQ==
X-Received: by 2002:a05:6000:2508:b0:427:928:787f with SMTP id
 ffacd0b85a97d-429e32e9289mr5044496f8f.21.1762425973587; 
 Thu, 06 Nov 2025 02:46:13 -0800 (PST)
Received: from ?IPV6:2003:c1:b731:ac01:f439:afb3:7d4f:72d9?
 (p200300c1b731ac01f439afb37d4f72d9.dip0.t-ipconnect.de.
 [2003:c1:b731:ac01:f439:afb3:7d4f:72d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb49c394sm4223217f8f.41.2025.11.06.02.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 02:46:13 -0800 (PST)
Message-ID: <c860c211-f0e2-442e-954b-cfeafca511b0@redhat.com>
Date: Thu, 6 Nov 2025 11:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] riscv: Update MIPS vendor id
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
References: <20251104150708.3345289-1-djordje.todorovic@htecgroup.com>
 <CAKmqyKNV9Dc5-mszwg8aFCkqLiASLZ_u+dbLLyG_59usMAL6Mw@mail.gmail.com>
 <5301acd3-6e1e-41f0-9cf0-f262bd8c5521@htecgroup.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5301acd3-6e1e-41f0-9cf0-f262bd8c5521@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/11/2025 11.16, Djordje Todorovic wrote:
> 
> On 5. 11. 25. 00:08, Alistair Francis wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>>
>> On Wed, Nov 5, 2025 at 1:07 AM Djordje Todorovic
>> <Djordje.Todorovic@htecgroup.com> wrote:
>>> We have already sent patch set for introducing MIPS's
>>> p8700 CPU in qemu at:
>>>
>>>     https://patchew.org/QEMU/20251018154522.745788-1-djordje.todorovic@htecgroup.com/
>> That series was dropped as it failed to pass the CI tests:
>> https://patchew.org/QEMU/20251023041435.1775208-1-alistair.francis@wdc.com/
>>
>> You can just include this change in a new patchset
>>
>> Alistair
>>
> Hi Alistair,
> 
> 
> I am looking into the
> https://gitlab.com/qemu-project/qemu/-/jobs/11827080939#L5859
> 
> and it seems that it did not get the binaries from:
> 
> https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_payload.bin
> 
> The test for Boston board should try to download that, but there is
> TIMEOUT set for it.

According to the job log, the test has been added to the "quick" category. 
If the test downloads assets, it has to be in the "thorough" category 
instead, otherwise you might run into timeouts when the download takes to 
long. (See also the "Asset handling" section in 
docs/devel/testing/functional.rst)

  HTH,
   Thomas


