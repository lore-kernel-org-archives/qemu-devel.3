Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96265D1BDDE
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 07:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8EFL-0005JV-DE; Tue, 05 Nov 2024 02:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8EFJ-0005IJ-3Z
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:45:01 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8EFH-0000pd-JH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:45:00 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20ce5e3b116so40381615ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 23:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730792697; x=1731397497;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RMKlRRvn82mT8R/GjyiywQBWv99O2uNSf7ONsN0FFAc=;
 b=2O61IH7cJtPGrUlfNr6dsQf+R3bbKHZ7rkMyV/oIRCTWqtRkfWXYGoihMPSzuKCVX3
 mVrz2mnQPDbSnaChT2vnOry2/LjtBrA1twmdxItJnE2g81M78GOuQJbUG9JE9nqBupPw
 u1TS4vF3T5+Su5std54p4aWduAQaCqdb5bRLfWSngpcF6n6rVtX4qIsGT87TwNYxA9l8
 /pbgi8vzhcwlb9moTLSDNGso1mOWca8LEoyGgacdK1m2GDKSz2UoHLJ8QIuKtiN8faB4
 e4SnctQnm+8X9adoVQLA20qzmFc99BJJ8Lmhrsguael3sm9sEFAiB1wUN2Q+LfX2DUyq
 O55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730792697; x=1731397497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RMKlRRvn82mT8R/GjyiywQBWv99O2uNSf7ONsN0FFAc=;
 b=W7oTe/G+zs0xIKEbE0g+fZslv26HL16td+D4sg0CH74fJGfjH1l02HoNRz7UNy8sFm
 CXe9STGMN8Igwd6K1tP4lutNdmvixL9z1BMeSNGbQZI14hZ3AETNmXDwCwr9mezZRGdi
 iv5OrCNMvyCKZRhh05m/xTD53DAEILtnD0fn1NpokXtW0rLPjibC8gv14YtYSsImbtA3
 aYqsc+EcBc85mPnzEHutSRXOcleGv+xCOv01USneyg7CQ6BC/+DsFiBVD/j2W3XM+Lww
 55yMRpNq6XNkl6C0f7FkfkRZoO5byv3HJDLko3UZ4TP+mABNotYfob4rWoV1TmLTw+g2
 X6dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH2lbj8gk4pWa9IazQP5WNzv5YTKPl7yHGr0tNtjD/FnnOd+NFdHg0OVQIWjgSRRbXMNI4Yrd5Mirh@nongnu.org
X-Gm-Message-State: AOJu0Yz9gE2GZrUPTF7eCwSQLtza9nfRsYcmZhcdbQDSNf+by/KnDSgA
 x37zXbNiys7owvTt0jCVFmiTh+/VDBuwVY5dmn/3qh24IkiVfFefqCBEoZaJiOY=
X-Google-Smtp-Source: AGHT+IEVpXu8ZAwV3hzl+eplxudwHqntFaNXHSVGbq04xNdETQoXkVD0WcYirRLY0wkoM0KbvVrjlQ==
X-Received: by 2002:a17:902:dac4:b0:20b:a9f3:796d with SMTP id
 d9443c01a7336-2111afd6c25mr175705165ad.44.1730792697401; 
 Mon, 04 Nov 2024 23:44:57 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057d44cesm73005705ad.255.2024.11.04.23.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 23:44:57 -0800 (PST)
Message-ID: <fe00d848-e775-4df7-9a0f-dfbeca9118a3@daynix.com>
Date: Tue, 5 Nov 2024 16:44:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/15] ui & main loop: Redesign of system-specific main
 thread event handling
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20241103150037.48194-1-phil@philjordan.eu>
 <20241103150037.48194-2-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241103150037.48194-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/04 0:00, Phil Dennis-Jordan wrote:
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
>   * For other UIs, or in the absence of UIs, the platform's default
>     behaviour is followed.
> 
> This means that on macOS, the platform's runloop events are always
> handled, regardless of chosen UI. The new PV graphics device will
> thus work in all configurations. There is no functional change on other
> operating systems.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

