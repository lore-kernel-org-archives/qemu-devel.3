Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A143C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbbZ-0006fZ-CG; Tue, 16 Jul 2024 02:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTbbX-0006ez-Ru
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:24:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTbbW-0002YA-03
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:24:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fb3cf78fbdso30434775ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721111040; x=1721715840;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E65dLbiJEBOQgNQVHelmWqTJ3n+3xrB7ze7VvagUBwA=;
 b=mBa5tlZMoBhUVgeoC5TCrRdxt8GVS4jaP83gK3fQUHH4UKTqxonozjDssUgMVB2M1f
 dWMSjcFgM1DdWMqQyIj0tNYzY8lfr0M4tCdWHEve4bXnpr5P3X+DgYuiUk6FyCSlKYMV
 GM6/Ceq2Kz/N8F9a8iSOl2h+cjJRV1U6uquD/LK/a6s7btd+0mBptJoVvkNwnAJ24RrA
 AMRsQ7mt+LDsPAN1g4KVUvKdlDP0iBO8xDvs6NoOC/yRBCfRwulpNWGPb303n8n1XgXj
 wbxvCzjb/uXjhih/BlONdfyqxqwb2ZNVI8hY7go3p5Yv/SyH0APTAO0blFXWfu7mrNgg
 MgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721111040; x=1721715840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E65dLbiJEBOQgNQVHelmWqTJ3n+3xrB7ze7VvagUBwA=;
 b=A1c6hKRcVy9KfbqHthVN+uuccKXyvp2kq0yV/8HceMU/S8smqN4Y7W9jOBAPso+bK9
 M367jVVh1ujJoAMy8L7f0XTlNcD3GYiUAx/ahlBt4CJ+hI5wELcqdLy40LM23Nzsxm14
 23hTT7QIw8OFxP753pXAPhN9BVrb4c70EC41EBLNd7EJ4BMfzDD6e9v95xiHUlKB+Oca
 RWtKTSJ9akU0MxjkH0KKVUywnBiYsKj4uCIZUkCg3MzfIcP/Dc1bLDe/Ntn1IhcUJM50
 lQ7R3FHAjG2GaStWaMrzxsaC+69z2pTJw+tg4dIWR4I9k58h3jFXdetVUGcPzmUBU/tW
 rlSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFt67DavSZjyGx7mUudoRMDFB4fIEPtgfi5zJMZwdd0xWme2itYG9GOfB/hi5QifaQc7Jsh2QFEKG+lzVHEVqKVrhqaFw=
X-Gm-Message-State: AOJu0YwRWMzRcgWD1C+LAcqFyW5J+Pak9Qvz/VHRg8q1rHF21wBxQ0LI
 ExLrkbrUW2Z6KhVkmRBgZG4fuV6a/g+4P4MUoJTTJLBPW5V20JHbmQkVFiLDy8M=
X-Google-Smtp-Source: AGHT+IHJ/NFqF4QIw2RYw8hr46b88zVyTpLU4j6x9Lt9LgnoU/WH4mxZk2LapXTBHzJ1WBefiDSiog==
X-Received: by 2002:a17:902:ca05:b0:1fb:7198:46a8 with SMTP id
 d9443c01a7336-1fc3da184d8mr5882475ad.63.1721111040273; 
 Mon, 15 Jul 2024 23:24:00 -0700 (PDT)
Received: from [10.100.1.231] ([157.82.128.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bb9c48fsm50769805ad.71.2024.07.15.23.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 23:23:59 -0700 (PDT)
Message-ID: <8deba12c-ba7b-49b3-b2ed-e5d3fc783114@daynix.com>
Date: Tue, 16 Jul 2024 15:23:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org
References: <20240714-auto-v3-0-e27401aabab3@daynix.com>
 <20240714-auto-v3-2-e27401aabab3@daynix.com> <ZpUMbdszCwd3bFUd@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZpUMbdszCwd3bFUd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/15 20:47, Daniel P. Berrangé wrote:
> On Sun, Jul 14, 2024 at 02:11:02PM +0900, Akihiko Odaki wrote:
>> DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
>> as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
>> is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
>> bool.
> 
> IMHO this shouldn't be implemented in terms of On/Off auto,
> as it is misleadingly accepting much more than PROP_ON_OFF
> accepts. Rather it should be just DEFINE_PROP_AUTO_BIT64,
> implemented in terms of 'bool', with an extra 'auto' value.

I defined it in a way consistent with DEFINE_PROP_ON_OFF_AUTO(). A union 
of 'bool' and 'auto' would have a behavior somewhat inconsistent with 
DEFINE_PROP_ON_OFF_AUTO().

Regards,
Akihiko Odaki

