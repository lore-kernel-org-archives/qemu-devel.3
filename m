Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE61C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 06:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTFd8-0005OE-EN; Mon, 15 Jul 2024 02:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTFd7-0005Nj-2h
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 02:56:13 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTFd3-0005Cq-Li
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 02:56:12 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52e9c6b5a62so4087864e87.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721026567; x=1721631367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2m/51CZJRYThEaHOA3B56LkbjLHUlGg6N9pWHYRg/H4=;
 b=MgCHqDFx31iEh+uzYaox0kFrd6S/HgXIMi/mLOIs5CRM2DSofLWvF9LRlGip/qqZi9
 tRW5zJzo4fkCRSbbuBs3PtMjtOTyrojUxZe6s10icceodjgRvTz7xM1eCJLocQ9c52g1
 IsrQwM//APLR2Y42X4TU6R36a7MwATlM23rbb+ueWEiLxXh0JroFbo5/ATGdVum/CqPe
 J5/0JrFQzG1/h2VCdq2zlyqb7kqdFA2x5XswPTYC6vfhuitpU5VtVfjED2WamEF31spN
 mskjwYpG6GU3jVCudtEG/RFL0WC19+MAYcuKPw5Xg16c+4JbK7o3SpBW1nIHFV9HmYKp
 g6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721026567; x=1721631367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2m/51CZJRYThEaHOA3B56LkbjLHUlGg6N9pWHYRg/H4=;
 b=AmPFxnX5xhVwVlGFwFIPEp5HsCpF6SuJQG05CxESTRbm9hX9kXmCA0XKa8W50iX5Vl
 0jgAmqSrFFzQoksWp5IGmSDNQlBFjHPiW7GXXCAe9rIeD32ApSCOhOaqUbvDROHLR0/H
 yG9A1xo/N9O9yjmQ8dhmgPKuaizAkzrO0Elr1VbizVMon/IE2oSwbSXAxAvcTzjOb5UU
 0rL0lnvglR4p6d91WpDKWvXwLzFE0tPrqXx5n/ngZvl+2XlMGijVnyOP6DvdKEVzwtsl
 naJ7VocY1fxKAzcf7t70kfrGKHNUAFn9k9PMma1BO3lPNZ0tIrAkXsk8toi+cUDlXrFP
 ck1A==
X-Gm-Message-State: AOJu0YwSMWbmzFvTC7jz9l536lnxx68XhL1R1V8bylQJpAYeVMwyKWBt
 Hdj1NrPSh6k59PSupCkq4zwkbppDNLkIf5GPLVSCU/jNVt7wCfi4MvG/CdbrLyQ=
X-Google-Smtp-Source: AGHT+IEVQGxtAhY/lIR36tpzxl3a+WQUFYfpnGz9PWLW77IL2gSxNWJ6Kt7RqAr8gPxQ4IDAspMOJw==
X-Received: by 2002:a05:6512:b12:b0:52c:da09:ae65 with SMTP id
 2adb3069b0e04-52ed0f429c7mr4337365e87.9.1721026567185; 
 Sun, 14 Jul 2024 23:56:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.134.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef4617sm72621895e9.41.2024.07.14.23.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 23:56:06 -0700 (PDT)
Message-ID: <b3925b50-841e-4893-a921-5c5fc4656943@linaro.org>
Date: Mon, 15 Jul 2024 08:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] ui/console: Convert mouse visibility parameter
 into bool
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org
References: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
 <20240715-cursor-v3-2-afa5b9492dbf@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715-cursor-v3-2-afa5b9492dbf@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 15/7/24 07:25, Akihiko Odaki wrote:
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/ui/console.h    |  4 ++--
>   hw/display/ati.c        |  2 +-
>   hw/display/virtio-gpu.c |  3 +--
>   hw/display/vmware_vga.c |  2 +-
>   ui/console.c            |  5 +++--
>   ui/dbus-listener.c      |  2 +-
>   ui/gtk.c                |  2 +-
>   ui/sdl2.c               |  4 ++--
>   ui/spice-display.c      | 11 ++++++-----
>   ui/vnc.c                |  2 +-
>   10 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


