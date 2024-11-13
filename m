Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDC7D462DE
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 16:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBGMQ-0003UD-T5; Wed, 13 Nov 2024 11:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBGMO-0003TE-QH
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBGML-0007Cd-OC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731515807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZoB7bHEPr2ZQyJwgbQsINSE79T6gtdN6t7gS/CsnTtc=;
 b=gc5n6qSaAXiVBIy9OyPL4y4B8qSrgmEgFj0msK3AQUnJTiLfMv9t89mWmp/7cp8oH9IBDN
 7edBXi3ZdeZQiFVZWtBWkXQZmWUIY3duYx5fV0MrL/B/J8mMJxPEtOGt6G/+f6L0wOJTvn
 rfTXpYgD/EX7IVRxXRGkxxX2YWxU578=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-A1UFbdemO7m_ioFXPw9CPQ-1; Wed, 13 Nov 2024 11:36:46 -0500
X-MC-Unique: A1UFbdemO7m_ioFXPw9CPQ-1
X-Mimecast-MFC-AGG-ID: A1UFbdemO7m_ioFXPw9CPQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d45de8bbfso5566161f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 08:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731515805; x=1732120605;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZoB7bHEPr2ZQyJwgbQsINSE79T6gtdN6t7gS/CsnTtc=;
 b=kKC6YkSV1zwfm9jJ4LScC2jyEVnLU7dXA3TSB8CrP2WgTHMgjSKSo8FafHDebfbrUs
 ILtjxdF68n7YkOPDAAUP5xVyrfKJ5z2WVnt4oRet3JRZehNiX+B6S02JVbfBloQEOchM
 9TvRcdVJOBBHEZ+OleFhNimfSwZTTrI3kCKIuEg/dSxeNPrfMngmjGENG+bhb03Gv/9g
 DsZiZsbOYlr6upIJRLk3i7b/YSoiWcjxGAIdAUak39Pl+JLx5gjVl/97JFXusLwq8VME
 tT4PjkgjZ7VL3k1Q+gx+tniB0Hd5ET6coJ6DDFE90RIkEU3rn+yI0mcY1m2ZnnHFCpQu
 AyKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmiWVvG3Yl9LyfsZK9UvWWkoaj2JIGRG4er3StY3hTLKWFQ7v0f9rzrVz+4rvFQhHjbo2Lbn0cR4A0@nongnu.org
X-Gm-Message-State: AOJu0YxlMgnHSPj3zzbofTU+W4yPhS6p3V0h5vfo1JyOAMjI7oAspr8F
 nSAegoHvted5OuxmSNxL2+WqPbRKaxyRsoOas/gFBnxKk9i8pdZQihueSfH+Ah5nkRTV0hJ9pve
 /faRH4bZ6LcxCR+5V8dEQ12K7G9m2zHA0R3KYsEMZI2efVJDGf636
X-Received: by 2002:a05:6000:1865:b0:37d:7e71:67a0 with SMTP id
 ffacd0b85a97d-381f1866b1amr24546594f8f.9.1731515804873; 
 Wed, 13 Nov 2024 08:36:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPTSqbPPPLI53qChEyqKm6CWjyixEnke43e3OFPiEn+3ZuoB4mTH3x4CUkG/153Un2x6Ou7Q==
X-Received: by 2002:a05:6000:1865:b0:37d:7e71:67a0 with SMTP id
 ffacd0b85a97d-381f1866b1amr24546545f8f.9.1731515804409; 
 Wed, 13 Nov 2024 08:36:44 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381ed97d658sm18710851f8f.39.2024.11.13.08.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 08:36:43 -0800 (PST)
Message-ID: <c0983059-ab11-4bc5-ab60-c5b23d1c290e@redhat.com>
Date: Wed, 13 Nov 2024 17:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/15] ui & main loop: Redesign of system-specific
 main thread event handling
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, rad@semihalf.com,
 quic_llindhol@quicinc.com, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 balaton@eik.bme.hu
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-2-phil@philjordan.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241113142343.40832-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/13/24 15:23, Phil Dennis-Jordan wrote:
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
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

I checked what GTK+ does and, either way, you have to create another 
thread: timers are handled with a CFRunLoopTimer, but file descriptors 
are polled in a separate thread and sent to the main thread with a 
single CFRunLoopSource.  It's a bit nicer that the main thread is in 
charge, but it's more complex and probably slower too.

As long as it's clear that any handlers that go through the CFRunLoop 
run outside the BQL, as is already the case for the Cocoa UI, I see no 
problem with this approach.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


