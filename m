Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75690E7718C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFa-0001oo-QY; Thu, 19 Dec 2024 11:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOEcT-00057k-3p
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOEcR-0006lK-Hy
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734607380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jQ6/8NMtlqWWCNBKARXRvWwGokJfek4UCgnIm8vVzHY=;
 b=Z0tReYJZnD3nf6e/gtYa1Ne5/bl+hRSZv1/fCcvxwhXJKr8WQ3wY0A7zGw2DodbKcfdxIk
 Z8gbcBf0TrWU41t5JofXZacopFxWULeZn41/lxEyzBkJxaYevMqyKSdp7WG5FKeiw1MMWL
 hmbOHfOOdvjXWq5WJ97aLX+AgZoit0E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-9Gy5g6UzMuyoQDLvuf2ccQ-1; Thu, 19 Dec 2024 06:22:58 -0500
X-MC-Unique: 9Gy5g6UzMuyoQDLvuf2ccQ-1
X-Mimecast-MFC-AGG-ID: 9Gy5g6UzMuyoQDLvuf2ccQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d80576abso413149f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 03:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734607377; x=1735212177;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jQ6/8NMtlqWWCNBKARXRvWwGokJfek4UCgnIm8vVzHY=;
 b=UhOiNtai80wGRJh4abUpKw4SQNIvp0Rw3TVRrtvSB1WMIExyCS4zYWgGO6KvwO/+hO
 4ZA/n6oSrZqu9xX/mhkaqem5YlEYzCLehuNGZF5xX4JrbtJFdkKwibzxkWfAX72Hrx0/
 pIel3LcY1o90VmeBFRhAt88Etv53KbGMIu9/JSvaUCAkQfPDndAlP+SchLYuRs20bh0N
 ThIrXaPqqlr4DhyrWCb0cd5zNV6JTliuN3O+JfxemrMHaZTVOwxOq9qxkfqKAXdgTJI3
 i5X8IKzQ5S62Cp2ceBV7aFtA2oGkeuIf1p4V5yPZmnVwYPhsULdPThJxUxzktSvEz5Mt
 XdJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMD29cwI0w5CH4lcwtfOXCKUSn0OGj1zSnmzNj8thZh+wlHDDcXRH54Y0tIZo9X/bgOnEW8rcpBcoj@nongnu.org
X-Gm-Message-State: AOJu0Yzbw8jDMeUaM4kAhXvnLewh8zvLFEvxj26jXuKFpsOWSLDb2zZ0
 d0vkUdrBXtlMY8Tt6f0YkyflsFsiirC2+QcSxVZ6fZ1AzHkFhduU7Ezw+0GuLLUbDQrDmtl/XbW
 KupClX1DDNUzKgyg3PP+qRt5FcMoY2J5F49wW5bW4mplqKrCOu4ME
X-Gm-Gg: ASbGncv0cVGF1P9HSLdY7onZlmfw8HlBqgXIWWm+tD47Tk5FmRYf+hgtLSStOxFN3x7
 DqiRbXxmaxt69plKdnUP6jo99R3oKt9+4jVxPW8Rw1VzeuToNRSUKvegc/P8g1++RJsJFKzvr6R
 Lq1NGrsWACEnwZfrHvaBo/7Oo+MqelzBn5DRJgfxJOenalV7rRHvK1uluKgCh9vKq0GnCrqg03l
 4XxNIDbBRB1KWLiAMkr69MXK4XwyXtg19GkAuluziNPPiNesNborfp5rYqI
X-Received: by 2002:a5d:648e:0:b0:386:3213:5ba1 with SMTP id
 ffacd0b85a97d-38a19b05284mr3132794f8f.24.1734607377334; 
 Thu, 19 Dec 2024 03:22:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7NKjiQ6q6ALCW46rzPheq/kNgn7btUlqyb3U7x1ybj6jMY48NtUUQ78NOOBeub7tc/6YNyw==
X-Received: by 2002:a5d:648e:0:b0:386:3213:5ba1 with SMTP id
 ffacd0b85a97d-38a19b05284mr3132766f8f.24.1734607376974; 
 Thu, 19 Dec 2024 03:22:56 -0800 (PST)
Received: from [192.168.10.27] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8ac93csm1316091f8f.95.2024.12.19.03.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 03:22:56 -0800 (PST)
Message-ID: <05747238-adac-4be1-b516-358a04aca803@redhat.com>
Date: Thu, 19 Dec 2024 12:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/40] rust: build integration test for the qemu_api crate
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
 <20241104172721.180255-13-pbonzini@redhat.com>
 <A90FCF2F-C8D9-49B7-A881-B0F849AC11A0@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <A90FCF2F-C8D9-49B7-A881-B0F849AC11A0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/19/24 10:53, Bernhard Beschow wrote:
> 
> 
> Am 4. November 2024 17:26:51 UTC schrieb Paolo Bonzini <pbonzini@redhat.com>:
>> Adjust the integration test to compile with a subset of QEMU object
>> files, and make it actually create an object of the class it defines.
>>
>> Follow the Rust filesystem conventions, where tests go in tests/ if
>> they use the library in the same way any other code would.
>>
>> Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> meson.build                  | 10 ++++-
>> rust/qemu-api/meson.build    | 26 ++++++++++--
>> rust/qemu-api/src/lib.rs     |  3 --
>> rust/qemu-api/src/tests.rs   | 49 ----------------------
>> rust/qemu-api/tests/tests.rs | 78 ++++++++++++++++++++++++++++++++++++
>> 5 files changed, 110 insertions(+), 56 deletions(-)
>> delete mode 100644 rust/qemu-api/src/tests.rs
>> create mode 100644 rust/qemu-api/tests/tests.rs
> 
> When `--enable-modules` is passed to configure, this patch results in numerous undefined symbols.

Thanks for the report... This doesn't seem easy to fix without adding 
more hacks on top, but I'll try to do it right.

Paolo


