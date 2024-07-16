Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3D0C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 17:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmOp-0003OZ-TN; Tue, 16 Jul 2024 13:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmOn-0003O0-Qp
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 13:55:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmOm-0006Uz-7j
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 13:55:37 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-36799a67d9cso4613276f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721152533; x=1721757333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2JtLVaSHTcwZrnH3hhlAKRbz2d7cw0GWWMplk6YEffc=;
 b=mPeHkUIX1mhYsv75GUka8aAwTEzIPExOsBlaGn+VG4gGv0MkNrnuENHal/f7t/kl1Y
 y1a8OmAoltD6PeoO0TL4B7KmzLTvFOIPNwsFvRXaKTD3k86LbTyc1QCMu4gYrj5dbfnE
 N/Z6bQ6gGV8G88lM1agWcpc3tDWoezK6nw+ZW4zbwqpkZhxKaIA8LXNNXWDaPspgx+O5
 J2gb+z79iBH1/lo5DmO311Gl0IsBWI9rmzXFa8f3SHwBVnx0rD9wKVR6jSHkB6VG0iB5
 +SuLqEMScZBrjMpZ5cuiSSa/n/1GgGPq3hIT9m7j6/G8uBG9eoe7qblATDOdGSINuhhk
 Nyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721152533; x=1721757333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2JtLVaSHTcwZrnH3hhlAKRbz2d7cw0GWWMplk6YEffc=;
 b=dz8MFtk5IuqqKAVQSwFR8rqv9Xr2eHKq8XJ7Mu7ueAfSiQYGcwhw4SccxYh6v7nZuQ
 IFcnc3jjiAvrXRNBDMwyxWBLFG8ypxXwz6XeE1yYSWUaTnQBT14WFNtid5r/OWKEO0ka
 uBsUk1HnarcUVyqoOBxRrhqGKDXqV8OJkkDkOfmn7pffJXYlrIWWMUqvfxud1RXYIkMf
 Ek1MiH1vjE0wYQLV9qn/FkZioUR8bcWE0nBgkfJs7cL7/BaaZPFGDQbN3HxrG2hUIwgE
 XvX5eNoKtTMZHXB4B90hHDW5awJ6H/jgY4hTyU+s3KMdZW8iCTWCPfE62TX17+Lwn8d1
 YAXw==
X-Gm-Message-State: AOJu0YydO+fFtOuLhtGBJSHslBkWNCOxSp71DDRJe/jTmmD8Y0ck1WSt
 Ully6PMsM1TXZ8Jyu6wJrhAh0USrcYCy4LhZQVlTRAMdd+V3PPR+E+fLCsFyR2w=
X-Google-Smtp-Source: AGHT+IFszDSgYbVcPiQn/zFdKhZltYa75AaHrGm3SXrA6tJl5KdAFiY5bN1wvVuO1gq1chC+4bwxCg==
X-Received: by 2002:adf:f808:0:b0:368:12ef:92cc with SMTP id
 ffacd0b85a97d-368261eaa1dmr2070328f8f.46.1721152533554; 
 Tue, 16 Jul 2024 10:55:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf416sm9594571f8f.45.2024.07.16.10.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 10:55:33 -0700 (PDT)
Message-ID: <46cb3e8d-c20f-440c-b5e1-0ed3d67fdf70@linaro.org>
Date: Tue, 16 Jul 2024 19:55:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] ui/cocoa: Add cursor composition
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
> Add accelerated cursor composition to ui/cocoa. This does not only
> improve performance for display devices that exposes the capability to
> the guest according to dpy_cursor_define_supported(), but fixes the
> cursor display for devices that unconditionally expects the availability
> of the capability (e.g., virtio-gpu).
> 
> The common pattern to implement accelerated cursor composition is to
> replace the cursor and warp it so that the replaced cursor is shown at
> the correct position on the guest display for relative pointer devices.
> Unfortunately, ui/cocoa cannot do the same because warping the cursor
> position interfers with the mouse input so it uses CALayer instead;
> although it is not specialized for cursor composition, it still can
> compose images with hardware acceleration.


> Akihiko Odaki (4):
>        ui/cocoa: Release CGColorSpace
>        ui/console: Convert mouse visibility parameter into bool
>        ui/cocoa: Add cursor composition
>        ui/console: Remove dpy_cursor_define_supported()

No issue with rudimentary testing, so series queued, thanks!

