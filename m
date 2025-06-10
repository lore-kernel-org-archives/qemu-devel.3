Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C5EC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtFu-0004Nn-H4; Tue, 10 Jun 2025 03:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtFo-0004Lv-Oy
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:18:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtFl-0000zY-Pn
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:18:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45310223677so15737695e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749539915; x=1750144715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2egj7saFpkJTNPblG8lLPbrlx8M/too8DFtqOMiwuzo=;
 b=Y/TE6QLlHB7cDAlqSJHkltH7iaR/fXxY3KDAXD2SuhVnTgBEJ5Db3ssthwPqbLeSrn
 HIgnuREAwkXoRVlPJAlUgjDzlKmxBnUJNGBlPcvRaz8sTuAMQI6alf8sxdzjE6j9n3c5
 /gWr2egJgGcZ+uXtDAJYZ0+2r0HgBWEUQ0xCSuUIoWutEOh06VRF8Au/b6lpsJmK7D9M
 +yrCfzFmkhJIMAlFg9l7LuiQI22/F1BYoFbBJnsOn7uLh4yq6tY6xOlELATEi1kEx5fv
 kJ2fcxjSu1N4CHWKjlD5fBbyZtk9wR/cjNrWgP+xNLzqPg0DUjgZEtHdRlzrjj7LuVDs
 XmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749539915; x=1750144715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2egj7saFpkJTNPblG8lLPbrlx8M/too8DFtqOMiwuzo=;
 b=IzWlr9zSBy+hmv8ZV9Bx11I9C8yYw9KCb4lLUxvMJeoE6kg1CmSsqLUQUecK4JiXXc
 YpbSalrKxJZlD5Li9i+IGbhtjEPf+DL+3uMdkDr+fS48ZBpEAqfX7Do/m3slh5LXYx4I
 7PQ2ZAJegckYBOtBu0H5tB/WEHpZKNAc8aPMwKF/MMOjYC2IXKMl9Bht5PKeTEEVBXuC
 sadHzVDXSXuMXSEq6HfR9qe9XSJnxUTG5cEJtF9c5Zt53yRt6B4mQgzFb4gM7YkxclDB
 x95WHk08MnRwuUUT+suelSHVfWroMK11hzaiyu8zgv44DF98aOKZDlxHaysCz35lAg/E
 3j/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwgv3eeFnnvyKIEi84o6ackADiz6Y4MmEv1DYoK8DaroAomyHFGzKBuFn9lhf5f8wZBq9Y6O+7QJuu@nongnu.org
X-Gm-Message-State: AOJu0Yy4hPuUI2U4HpjppMIamuRfo/vJaZcT1v0OdKEL/vPVseNFZWma
 ryYNKJde6b610XWQwGZi9WQSgRKZ6da7v8j7mczegVSExeUmbpwKFOfU9vfAoOyXL4o=
X-Gm-Gg: ASbGncv2zEXm1UssIlLwtfSC9Qk9jbn9hHZ/KERmaa/Z6817zlkyYh9BgHOyc23uUMY
 LbTGWMOwwc79z2mqtZ4bE+pD4pzcO1xqhwxTIXC9kidBDAQLdz48bklPX/1iafNgCeyC7g4Ntap
 DdLJFKxKpit4DTKp5Ex4EYwp9DtYTLuP3jwTkbq5QeC42xvqkCKlJq9rEvQiVUQ3sZZgdjVp4dl
 9+E38SM4BMiBQ8hdPJ6+JbFIx5xOZDyyU5cqrF5GFrWwAlgyJjLmerTXk/FWnij1Bt6oJAoeEPW
 I/DBBUfPeGjmoJxNp3U09hzp4MchnUUZ2VFWylEp/NqKcHwb+bWXU1n5RyCkR7sAO15QkFuWmGV
 jGR+cZdr6ElKscGcZHJx+7yVdbIO3wiydW2Y=
X-Google-Smtp-Source: AGHT+IHr4Wb9NkmXPfJaMm1yGOkCtf3+Du0tSJRTLix7jeACN33mgK/IK2DR/gCLOG2JOikLq4VarQ==
X-Received: by 2002:a05:600c:c4b7:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-452013841d8mr179232095e9.10.1749539915016; 
 Tue, 10 Jun 2025 00:18:35 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45213754973sm131592225e9.35.2025.06.10.00.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:18:34 -0700 (PDT)
Message-ID: <1b32c381-ccf4-4898-9e44-cf6151991974@linaro.org>
Date: Tue, 10 Jun 2025 09:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pc-bios: ensure installed ROMs don't have execute
 permissions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cole Robinson <crobinso@redhat.com>, Helge Deller <deller@gmx.de>
References: <20250530152118.65030-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250530152118.65030-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 30/5/25 17:21, Daniel P. Berrangé wrote:
> We have been inconsistent about whether ROMS stored in git have
> execute permission set, and by default meson will preserve source
> file permissions when installing files. This has caused periodic
> problems in RPM packaging as executable binary files get analysed
> by various tools/linters, which can trip up on the ROMs.
> 
> Tell meson explicitly that all the ROMs should be without execute
> permission when installed.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   pc-bios/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

