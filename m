Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36829C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 12:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZVNK-0004Bu-Vo; Thu, 01 Aug 2024 08:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZVN9-0003Jm-DV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:57:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZVN6-0000Oi-9U
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 08:57:35 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so1142927f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722517049; x=1723121849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W9BTOh2poU6JigM03HRrC0PUte6Uu+QGv/OjvnAPoog=;
 b=ZXbyjyjC3ZIj1HefxCSFZRZRFv+11plox0FSqbujo/Ynj+19JV6JeWe/L+6UtIMruo
 VlSaZsGHORTtDNanF85joXic/MqT756EoJ4qgoz/Wrf738/HxqNezZzuDk5YBsoTwKi7
 33BnsuD00Ax3PRE0i9e29PP2raQkJydeGOnhiiJxYoyV94NCSBlhFDk/o1/J1VoqpcSO
 S98ihta+qG0YhI64pxY5cAt9HWLWDLBF+TxPikOouvwgkZss4RiJcVr4O0NyK4LYak+o
 LBKqmZHOv2Cf+UHBlDVYwnLlYYkljtCyxRJqZL+HySDo3w7mUeNjqyn8s9h0gIQbVxga
 xSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722517049; x=1723121849;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W9BTOh2poU6JigM03HRrC0PUte6Uu+QGv/OjvnAPoog=;
 b=AtqgJL2MYgSCDU5SHapBfS5dKU0B4VzBBabJAGS4Rm28ukaSWhwsC6Yc7g/k2hbFog
 BbQmDVbPc8NiujX9urQBiNvu71G9AJbbDyRAGqOWXwQoK436kb8HO2K1F/AvlBS9l8ui
 Jewm/BjqxEkUWerdP+Kev4S4NB38UPB9VCqah/ppO6dZcd2zdN63QpbOWtX37vr4YMMG
 L+RIrd5rUE/aDNTCelBm9e3s2SQHUM/WgVa8XelUvnYLtUSSoFTbfCRughe4W4FmDFgQ
 6Ngn0S7bLuyeaBOrRb3WuyIKzo0n0C2z/1nX4TjOyNM6VD1psBnxW3yabAm8wIv8U/Y5
 xmgQ==
X-Gm-Message-State: AOJu0YzHJeyLk5+9Qlfv9RCpqx0eJuKKwYT+P7Yebuo/+PXMD1S0TIrD
 z+/Du06oR2r80Gj0rX8bdLvcD55JraRnHkZ/j3wT2JUSJg06w3xz45xYBfd0wWk=
X-Google-Smtp-Source: AGHT+IFff809S2Cleb/DVo+qwAck9cEgo3thORGHzF3ijxw5uiish8tFPFDDeHTT4mwpcGte0MOZtw==
X-Received: by 2002:a5d:6509:0:b0:362:4679:b5a with SMTP id
 ffacd0b85a97d-36bb35c1044mr1423393f8f.16.1722517049398; 
 Thu, 01 Aug 2024 05:57:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367d95dfsm19358613f8f.35.2024.08.01.05.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 05:57:28 -0700 (PDT)
Message-ID: <a3b0ebf6-47ca-4aad-9489-16458ffd6ff3@linaro.org>
Date: Thu, 1 Aug 2024 14:57:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] tests/avocado/kvm_xen_guest.py: cope with asset RW
 requirements
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-7-crosa@redhat.com>
 <20efca0c-982c-4962-8e0c-ea4959557a5e@linaro.org>
 <CA+bd_6K5S9yrD6hsBsTmW4+eJpPsquE8Ud9eHZzptUwDrHcpeQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CA+bd_6K5S9yrD6hsBsTmW4+eJpPsquE8Ud9eHZzptUwDrHcpeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 1/8/24 05:30, Cleber Rosa wrote:
> On Mon, Dec 11, 2023 at 11:32 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 8/12/23 20:09, Cleber Rosa wrote:
>>> Some of these tests actually require the root filesystem image,
>>> obtained through Avocado's asset feature and kept in a common cache
>>> location, to be writable.
>>>
>>> This makes a distinction between the tests that actually have this
>>> requirement and those who don't.  The goal is to be as safe as
>>> possible, avoiding causing cache misses (because the assets get
>>> modified and thus need to be dowloaded again) while avoid copying the
>>> root filesystem backing file whenever possible.
>>
>> Having cache assets modified is a design issue. We should assume
>> the cache directory as read-only.
>>
> 
> I agree those files should not be modified, but I wonder if you
> thought about any solution to this? Given that the same user writes
> (downloads) those files, do you think setting file permissions between
> the download and the use of the files should be done?

We want to share a cachedir on development hosts with multiple
developers. OK to alter a downloaded file before adding it to
the cache; but then once a file is added/hashed it shouldn't be
modified IMO.

So far this directory is group=RW but we like the ability to track
a read-only directory (like owned by a particular user) and adding
missing assets to current user cachedir, to avoid duplication of
files and waste of network transfer.

> That can make the management of the cache (such as pruning it) either
> require undoing the restriction or being done by a super user.
> 
> Anyway, just curious.
> 
> Regards,
> - Cleber.
> 


