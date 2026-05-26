Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA57ECD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRssj-0002V5-0m; Tue, 26 May 2026 10:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRssR-0002TM-HK
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:35:31 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRssP-0004t9-Rm
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:35:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso55155735e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779806124; x=1780410924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qB4L/AZ5trifDDdSMq98eqH/+l50WKyyBEZ3CvsgjmE=;
 b=e6WzRMs4n/OtZRKj7vB9u9WD/SgReXTAaNl4qs874VbFQt2qPpwRofntxzWwd/4szf
 UoP27kkTYKB+rzUXfy3K0d0FdLzs0B4WapP3ROgvhi7aKVDtsqtEyHiqTAD6epaNRgDD
 ExzinBXwphLYFf4hv3Bc1Lp9/nkvu/siSetaVDRbgsIxmVO8o2xntYlsTHx40CzAt38A
 cG4RJgGFADuXwAEHarHZjk5KULPI11g6GmkaIy/yWa1DFYPn4E0MXUepbs3yynOzwLbe
 H9SkCVDco+7gN0IHntwZ0HfAaKA6zBz8rnAAL6nqtyEQIWbfx9tCRMb8UqwQrcMvkAWr
 yGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806124; x=1780410924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qB4L/AZ5trifDDdSMq98eqH/+l50WKyyBEZ3CvsgjmE=;
 b=hKB/I0XcbDBPY+O3etR04jcS6aMCVyHcaSImGZE3cSfOxRjUlGvIk8Z0CiRN/igGzI
 C3ivTSNJgKZPnP9TmG2XdNY1INya1RiCIfa10xbzznLbaCvdv/72DVVC5lI/ZAZQJJ1E
 fxtvVdqVof82GOdAYXwTuBsW13dp3VhICqwaDTPP+sNxMqTbKKprWcULQ2/m43cFnA44
 H2naWFU67djL3qamVf6pFYtHs1pUkyrjGQioz/p8DnrJe67I8DoKGkYYNQz03PTbaWMa
 Q5ekoDdwomSJFEHdLg1dKjLxvgTepj1SZzR897Hhdsm0NQD18Mw69AX6nXpFms8KvCsJ
 3XqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/z7X9iOWMCLE/ShAk1eKE3l7IQEe+v3qb+5Qvtk74BwNSZdcN8VuUsIWkb6Hh6Ug/fwjorloqLZhA1@nongnu.org
X-Gm-Message-State: AOJu0Yx7xwnG5yFqv32S8w0dAK0hjHpZyK2eed8/yKXMGzAVno9b/LPv
 mI7zj2FrqdbOqNhyVtN/M19/XBSBEy2On1E/CCS6vTPQPv+jqCg2kvtjuWLjDVv74F8=
X-Gm-Gg: Acq92OGiYrRtml2w4CwsunrHGkYenVwq0ZAEot/j0PBCZNpJYOL0Oiv8Y0Klv2l3kxD
 ptyG2j+jaB4BYw3D1qfL+iwspoHE/vQYGQvEM9B7N7Pq0VDiRN5dnoAMnwjv3eD29MNC9qqQ20W
 H6hH4J1zMx9aBKZVvlv47u6EfL6aujwxmKqm3AzYsNZSpv6tMkdnbmjVP8gV8HdsgAHOp4kBfZd
 1WV0rIoyxEa/6FZhLns1ytTbAxwvQRanDmkgDUqJXxTdlzMrq58BpcLGWkITP/W2c7VmdQeVr7a
 P03C4ZqyKiM7crk0EGacefJ/Ky9KVi+LxM8M0YSzbfLPvEBK0A4cpJxvy2QJHhCHMwoNQzqy+dC
 DiqkKZWG/jk4L0W9hiG3gmjnHwsXYPPOzNEwq/CJnBKiwBZTHeBrcpYzSsDZbpePqw6avWuXhtF
 yWEAuT5lt04rxjMiLvvpIT3Pipk4DqPTqkqGjMVGvE8ML533i0pJZemJYzPVTcEll0dg==
X-Received: by 2002:a05:600c:3b8d:b0:490:50eb:b753 with SMTP id
 5b1f17b1804b1-4905eab6ee4mr200368135e9.32.1779806124112; 
 Tue, 26 May 2026 07:35:24 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd151asm35250042f8f.13.2026.05.26.07.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:35:23 -0700 (PDT)
Message-ID: <a63e95c9-d878-407d-8f42-beeb26010304@linaro.org>
Date: Tue, 26 May 2026 16:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/uefi: fix parse_hexstr
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: mcascell@redhat.com, Feifan Qian <bea1e@proton.me>
References: <20260526135948.599148-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260526135948.599148-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 26/5/26 15:59, Gerd Hoffmann wrote:
> Make sure we actually have two input characters available before going
> to parse two hex digits.  Fixes one byte buffer overflow of the output
> buffer in case the input string has an odd number of characters.
> 
> Fixes: CVE-2026-48915
> Fixes: 12058948abdf ("hw/uefi: add var-service-json.c + qapi for NV vars.")
> Reported-by: Feifan Qian <bea1e@proton.me>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/uefi/var-service-json.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

