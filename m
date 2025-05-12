Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02416C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uET0d-0003A5-86; Mon, 12 May 2025 09:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uET0S-00039X-GA
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:15:44 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uET0Q-00088w-SX
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:15:44 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70a2d8a8396so35175407b3.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747055741; x=1747660541; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JONDrl7tGqSV3+CjMVDGzQkbH/2m2qt+XUuDUsAMqyk=;
 b=qGqv7oArpwF5pSEAEOOfqsU5N71RGCMcAmlOWtYMCqWvdFvNBE72X8VS12Yei6d7tK
 a300ZYbX55z8qwJN2D+4qUtnWDsuyGa2tvbqV0LtENxVsoQo5aBo8hhFUFk1cFKml2LW
 5WoP8CaQh0xk1FOOQ1cWk1d+snz+n3zi8CiXU7w0PjQx5vTCmy7w6plpIzqpYRCSgJZb
 38+Eq0hFp5SvSSxaGVlbTj0mHcrOCpG8z5YFmv2jXimNuzvrnTkGIsatUi6uIcpTuIak
 3iO4ogYUZoznP7v8nTi32Fr0SokQoKXX9iH9KH1A8Wep531uo9EEkoc94Uk3KujiHf/F
 Ib2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747055741; x=1747660541;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JONDrl7tGqSV3+CjMVDGzQkbH/2m2qt+XUuDUsAMqyk=;
 b=jt8SCC9uwWWya9OX4KwAzDaQZ4sw7Yuak6eTHxE+cnY1aP/lQ+SB9yD0DxNoGz1FUf
 hVqQPZR/9THtUh16Aav8PeN0fhf/STKd3U3O5zZ2ThP2VOprNrXdB85XVpijoDbC2dS6
 Vk2gpfEFyypew+u8xu8sjBLnMB4QBvoys/ABq9eNbEvHezrxEKF+RIZdJFOEMguBk9HP
 ktgk9kw5wyYcy0QLcqQNcv7prziGTpRtgNU6kuFOZF1R6F45YdTnW76cdf5ZeOvi1cp0
 u3t19p73LupHulkAeeS4BvHZOfL32SKYdgmugzOMR9SA+EeNLitdjAEk9F48zdsqbLXV
 0DLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO81GvvCAvXV9x5jIACVZuj2rBkN9d3uEZdgPRg8qNOM5bf5iNHPFyd9EGQFNoiTYu0Xt2Tsipqnnh@nongnu.org
X-Gm-Message-State: AOJu0YzhHqnH0cjgAXCsGpYPqwZAL1n+wgQJK0k5Dn0GO6liHDXk5+Xb
 au0hd8uWMknCb9Hw/yakU8fEQAGuEwDIGhLO5A+muwsXFMSvUWOEmuHLA6/BZhL1w3UdqsrFDXi
 OjW8onoJyihfX8QxFf/yD3Ag8YVzRJbREd9q60Q==
X-Gm-Gg: ASbGncvorkZI/kQa3Uy8FgzfgVf3+Ag8wSCsZ1O1kmH3SGHDYCnsUWX+6/2HTlxZXEA
 yJrtyYV993LGehCd6X5WQvAgIo76gfmboTZKJUBqF3rg3l15SCF8t7TsgIKR6VZJeelmh861dox
 09Y43z++2n6jNej1gi/18ius/wFv87lBHvWw==
X-Google-Smtp-Source: AGHT+IEVd8Jtu0RRr+T3FVbhZ6/QAzmes0CsN2GvS9/RT0oeYLldkve0XlbEYITHS6LZ7w3KcNrI9x7Fn20RR+dlXJE=
X-Received: by 2002:a05:690c:450d:b0:708:100a:5797 with SMTP id
 00721157ae682-70a3fa1fb94mr196653527b3.11.1747055741453; Mon, 12 May 2025
 06:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-11-npiggin@gmail.com>
In-Reply-To: <20250502033047.102465-11-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 14:15:30 +0100
X-Gm-Features: AX0GCFuhBFye6KC6P5XJm2y7KDiA4rty6xAWRuRrF3aDsgUaEcEvnmxViHIxdng
Message-ID: <CAFEAcA_xnnQ6oJZHBFdaAJHxQbCjQ-wXz7urExLCwWmoc-pR_g@mail.gmail.com>
Subject: Re: [PATCH v4 10/22] hw/usb/hcd-xhci-pci: Add TI TUSB73X0 XHCI
 controller model
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 2 May 2025 at 04:32, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The TI TUSB73X0 controller has some interesting differences from NEC,
> notably a separate BAR for MSIX, and PM capabilities. The spec is freely
> available without sign-up.
>
> This controller is accepted by IBM Power proprietary firmware and
> software (when the subsystem IDs are set to Power servers, which is not
> done here). IBM code is picky about device support, so the NEC device
> can not be used.
>
> xhci qtests are enabled for this device.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

