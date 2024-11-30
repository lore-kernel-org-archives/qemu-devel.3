Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EE4D735F3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 06:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHGj5-0003Cc-8L; Sat, 30 Nov 2024 01:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGj1-0003Bu-8q
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:13:03 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGix-0001qm-Fk
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:13:02 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-212581a0b33so21001455ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 22:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732947173; x=1733551973;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0cSOkNFUc4ZXADQXD91Veo1S7vpMMbKlSC76D0xMA+M=;
 b=UPya3VdAxviY50Ha7ggpzcK4vQh9s1m/UV0ZwH+aOUSKLXnY788VYKmm96zEWpYMzj
 54A3cxg6by8E+NUk+X2WC8oXmyVeQU5fZk9UhptZR7szMT+ZDPo+hOlis9m+mZ2KTYzc
 OO+Ptlh1JTYcYoWfK44Si7QndssJk2N//mXz3fnf2pvu18bifGEbcVCIrvDi0oQHOS6B
 5UsPt94VvkDfgxM05MpI28eBWdnJCi0lHz2g56iDE7jYwF5P1FSajIFyzIe2Vu4/zwac
 4Tr++nh+OeZdg2eVtzVlTlh5zKM9CHcrEWS+K4VpEwEb9CdrLKkY/yCNPgh0GCIqxCFF
 8p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732947173; x=1733551973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0cSOkNFUc4ZXADQXD91Veo1S7vpMMbKlSC76D0xMA+M=;
 b=asbTTpSK3zJbGBMNXr6b2UujBLlk6/iikb16DkbIKWlG5mJO8RN+x4YtW7MMbscNsF
 vOOdrNCEqGQfH+its2LT8zDjOTJZvfKBAEVwWpBbiLJ7ug3XctpLbB08OiqhE/jJdkL3
 bMqcVylZylAdGNnfNQtrzwWjaFloHoGJtoNgAt9lUkQdZidKJYBvGFqnnwOw+iXqGWkV
 2kYtEee7HpBHdtCvgLOu/4kXsDhVc98rJiUmVHszZPmuRyyM8t2c/nQY0X1fAacsG8zf
 qZEfiVRTBzo2tvNP8enUjy9GiYPmYclnKq3t13/5ehfLL/8Z+Zwl+VSl2Ytb0r9b8FCi
 p9fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXreAA5PnvWTVRFIKvux82XDdQqpaTSXGRof03Aik10jBGFDfr+q947zRlttXr8USpQQVUOuSZIUI0a@nongnu.org
X-Gm-Message-State: AOJu0YwqKHrsOgwTvrT1LegEtpLLOCunoTI2nduCPPdK7VqKRy+3hrEF
 rikqxOmx8rqD7QDEGaapd5Ymhn7I1z3ug47O5gY6ErEAQP1iB70e7okFTPA+5n0=
X-Gm-Gg: ASbGncvkv3zIhiZ8Y7x5r09MbCRY22ewPa5mgV4lhf8MhKkZjxRCezNeuU8G9y78qhi
 ByCpaL0RYlmbQJ0qj55D0291TVCq0pg9FhmQ3ALgekm3LTMe3cNwvm8BsBCylRVhQE6okftMj1e
 wRQiXidVKQmEUzJLeMoWkDtv2SdG0q8bbqzYRmDrtZOlsFJvwDZMD70RpF+08ATK7r1T3hNlNw2
 WO+cqrkrA2vT9spmmxIhjrPdQcafVVv1Mwmn+cENL9joAkbXcVp+gyzlptImtE=
X-Google-Smtp-Source: AGHT+IH0oC4UmyAaoHAK1nvtKwW0Qu8ft5D0ON9uM7oWSetdswmnPntsyMYmJ7EjIbwKBakP5uX1NA==
X-Received: by 2002:a17:903:2381:b0:20c:89b1:e76c with SMTP id
 d9443c01a7336-2150138506cmr193276565ad.30.1732947173233; 
 Fri, 29 Nov 2024 22:12:53 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215219672e7sm40136055ad.130.2024.11.29.22.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 22:12:52 -0800 (PST)
Message-ID: <28237c12-4420-405f-9d30-d1578e0155c2@daynix.com>
Date: Sat, 30 Nov 2024 15:12:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu
References: <20241129152506.59390-1-phil@philjordan.eu>
 <20241129152506.59390-2-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241129152506.59390-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/30 0:24, Phil Dennis-Jordan wrote:
> macOS's Cocoa event handling must be done on the initial (main) thread
> of the process. Furthermore, if library or application code uses
> libdispatch, the main dispatch queue must be handling events on the main
> thread as well.
> 
> So far, this has affected Qemu in both the Cocoa and SDL UIs, although
> in different ways: the Cocoa UI replaces the default qemu_main function
> with one that spins Qemu's internal main event loop off onto a
> background thread. SDL (which uses Cocoa internally) on the other hand
> uses a polling approach within Qemu's main event loop. Events are
> polled during the SDL UI's dpy_refresh callback, which happens to run
> on the main thread by default.
> 
> As UIs are mutually exclusive, this works OK as long as nothing else
> needs platform-native event handling. In the next patch, a new device is
> introduced based on the ParavirtualizedGraphics.framework in macOS.
> This uses libdispatch internally, and only works when events are being
> handled on the main runloop. With the current system, it works when
> using either the Cocoa or the SDL UI. However, it does not when running
> headless. Moreover, any attempt to install a similar scheme to the
> Cocoa UI's main thread replacement fails when combined with the SDL
> UI.
> 
> This change tidies up main thread management to be more flexible.
> 
>   * The qemu_main global function pointer is a custom function for the
>     main thread, and it may now be NULL. When it is, the main thread
>     runs the main Qemu loop. This represents the traditional setup.
>   * When non-null, spawning the main Qemu event loop on a separate
>     thread is now done centrally rather than inside the Cocoa UI code.
>   * For most platforms, qemu_main is indeed NULL by default, but on
>     Darwin, it defaults to a function that runs the CFRunLoop.
>   * The Cocoa UI sets qemu_main to a function which runs the
>     NSApplication event handling runloop, as is usual for a Cocoa app.
>   * The SDL UI overrides the qemu_main function to NULL, thus
>     specifying that Qemu's main loop must run on the main
>     thread.
>   * The GTK UI also overrides the qemu_main function to NULL.
>   * For other UIs, or in the absence of UIs, the platform's default
>     behaviour is followed.
> 
> This means that on macOS, the platform's runloop events are always
> handled, regardless of chosen UI. The new PV graphics device will
> thus work in all configurations. There is no functional change on other
> operating systems.
> 
> Implementing this via a global function pointer variable is a bit
> ugly, but it's probably worth investigating the existing UI thread rule
> violations in the SDL (e.g. #2537) and GTK+ back-ends. Fixing those
> issues might precipitate requirements similar but not identical to those
> of the Cocoa UI; hopefully we'll see some kind of pattern emerge, which
> can then be used as a basis for an overhaul. (In fact, it may turn
> out to be simplest to split the UI/native platform event thread from the
> QEMU main event loop on all platforms, with any UI or even none at all.)
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

