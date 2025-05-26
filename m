Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA5AC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJU33-0002Hg-34; Mon, 26 May 2025 05:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJU31-0002HG-CH
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:23:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJU2z-0003FL-K2
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:23:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so12403905e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748251382; x=1748856182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1zct0DIpKibdh+ahQdCuBhZq7QvEo5EKrV1DUsza9eg=;
 b=KPwu6Ws3IRZyR9RcZampmOnwbKOPCrWxZ1ytWnO8IwX1nG6Jffax0FkU6GXLVgMPLc
 afUZCiCl7YPoC6Tva/ubgI3IswtVy5PkxJOaB3+fgQxP//5kRL1TB9iNEtSKm03HQqjK
 9NBUk9ls5Uqf/crf9ulNGtTH2IxL+mTSAU769osVgxygwvhe2p/0d0ZJYGLviENpF63Y
 qtQUFP07s3u5AbPerQC/0N3K6aBRNVPblLoesiAoNlxhe7EtD2fONjCqtih6lwSeiFw3
 f59ANuLpezgwXF64K94qrmEbraIBUFIGDH31o6foqgiM/vCqOC3CF/mqDvKT4Y2I1Guh
 3SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251382; x=1748856182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1zct0DIpKibdh+ahQdCuBhZq7QvEo5EKrV1DUsza9eg=;
 b=DXVwiQiktz1vMWzJ8Z58UVIYvbfStvddRX6bG4jPnfjJuDsuEOlV7flwgO+sEIfL4r
 Dfl92Kcrqr5rsuLJqt9SdiL5Mr33NlH0i1SW2EMtJclqaO1fFUB1k+Um/+/o7iEM2+WC
 QLLPscAXSr0W6wa7xf7elQOYaNAnjwVKBeultqsLMVg5oK2QsW4I2XSu1dnbarzo21nd
 vZwo3WvzJ1YwO+UGroAs2b082RO/G7onB97LL0V0ZaWpruSka+ssZ2psclTmpmCQh5Sm
 jrQT2S11op8c2LdUHqc7eZ0Uhhkywljqa5IuM6QWacLvfeSSj93kehGjMMsW0zxhdgkh
 ts8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyBR/IC2u8qRocwDI+Jlnv7qBDjYzgXG7JROG7cwzXGtPhh+CfE9CZppaVJcyGRXzkHmoIcHDcZ2ed@nongnu.org
X-Gm-Message-State: AOJu0YzN75umFPAnZp79QkDjlXbXpApIuQagqmeM0eaWN2vQh2kkRJfZ
 QdCZDVsom7gBFi8dWm3cKi1ffouHxtQ8N7hzLt4ePJfzbGO4iUQfaeM4BzYDpW1hA4s=
X-Gm-Gg: ASbGncu3SQ+TwBiPB9DE12wzC6cR7zGtBa3SlqeGtBE9anciCNaQXmScRQ4SOeFQ7TQ
 SgPpbspFPYgh1z7vPobPC7y/Cn4Ge67mEQ1jDYsBJeAxbeNgtnZlay7Hntwd8ocxjOP6P0y2UBC
 csJB2/jinX3KKM/mIEXNp/5tUimqPRRfDCXcuJAA2PcInLOAudWjs4hBywD6zgP445CAhIbjZcx
 y7x04GJCFb9/a5/GYrDtXq0MgzfGxqPr9CE4j+SRoL1hPPK8VOKp5JFLZP7pC4mOcBXWqGTQT8Z
 Jow59PDKJr7B32GfJqOatULVPHfKTWirjq5RJzVUJGTWFP7M9mNkHksZnJAaDJ2bZX9pyxiS08H
 o9GGjks6PX7sSycSm7SPqqkYt
X-Google-Smtp-Source: AGHT+IGMSZNbk8CCon3B24oBur357SUyTzSLe8LlH/rH/yjfm6avjOOPFksAtoVxu9TUcHjkfKz2MA==
X-Received: by 2002:a05:6000:2287:b0:3a4:d99b:f51d with SMTP id
 ffacd0b85a97d-3a4d99bf6dfmr1805031f8f.11.1748251382341; 
 Mon, 26 May 2025 02:23:02 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d10e98f8sm5103206f8f.42.2025.05.26.02.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:23:01 -0700 (PDT)
Message-ID: <0d7e20f8-42f3-462d-8c8d-de10b316a5cf@linaro.org>
Date: Mon, 26 May 2025 11:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] qemu-thread: Use futex for QemuEvent on Windows
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <20250526-event-v4-6-5b784cc8e1de@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250526-event-v4-6-5b784cc8e1de@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 26/5/25 07:29, Akihiko Odaki wrote:
> Use the futex-based implementation of QemuEvent on Windows to
> remove code duplication and remove the overhead of event object
> construction and destruction.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/qemu/thread-posix.h |   9 ----
>   include/qemu/thread-win32.h |   6 ---
>   include/qemu/thread.h       |  11 +++-
>   util/event.c                | 122 +++++++++++++++++++++++++++++++++++++++++
>   util/qemu-thread-posix.c    | 121 -----------------------------------------
>   util/qemu-thread-win32.c    | 129 --------------------------------------------
>   util/meson.build            |   1 +
>   7 files changed, 133 insertions(+), 266 deletions(-)

Great.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


