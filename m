Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A77E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 20:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSMPF-00009c-BI; Mon, 30 Dec 2024 15:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMP9-00008o-KB
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:30:24 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMP7-0000Wk-Ag
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:30:23 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so6855939f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 12:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735590619; x=1736195419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yzzKQhrMu9+ipQPX9U5PUvV4kGHzYUL/8aK4yLnwG5g=;
 b=puB8SIR+4EU1iqgYqTjeUsJIeU8ZWZlz/IxVG8//G5b6EBjhv75CSiNWLPxXV/T1qU
 3neMIB9SLguFUjQ+OZE3Yb9ry/J/nyUxFcoMwzOecWEzpH4tlurE5Qd5tAtGWLNx0eyv
 gkPhQ7K8twse3S/9dEbyVaG0ZBH5uLgN8kuYuuHCGG/4hTL+lghl1coLEUi1JM/fL4Aa
 NNr/W5Zh+n7R/pAYqm/GqM8VXU6CINBeBkzn71Wat9MVZDnkFNfQRR7rA4vyrqE2p+zG
 uYt+iViJYlFfyTAXw6/8FKiOdy40z5UQobM1g+1/b0ajMbS43QyAfwpjdmeyWIFmQSNF
 xCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735590619; x=1736195419;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yzzKQhrMu9+ipQPX9U5PUvV4kGHzYUL/8aK4yLnwG5g=;
 b=QlJOHIMTcDoRpe4ZXIb+RnV7LTO2tCTAevbKbT8uoZGS8tVEJnqnbo4E4AcPrMASMu
 eeJAEUf9JRAjnUnmUJyJIOr6DpFisX8/xy2tl30rxNDftA8ehMRZ5Xn+6/jLo6q31Pi5
 s69Xk7Slik3oYpkWXRqU4S2/pOViEfKQJI96bpGYdAY8KXuTYCMK05YAOMYhV+oE1JKS
 F9qRE9hM5ggEbWK4y373Rp6KapRWq2/2coVodCd185rbe8T7NJA+KOmfqO3lwwOUFkEr
 /FArCGNgPZTjBME+gZWoLtcvB/KFLI3k34fzaatRivKpWHdknUnTQSCp2wXtJv91ihUF
 +cWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBSpcDPRQTg1OZ/Vi8tTKMwUWAH9kQ2/sWUPjxoscwE804ZysCjUdcdyP43/QBOV1kJZnKn8kUPWrP@nongnu.org
X-Gm-Message-State: AOJu0Yyl0ttNDUV/WSaHpdvZCA9v+JY+nDf81cxcPu7BPW343y0Fus8D
 PZr0TP06rkO6d1mkVItpz48vq+ulp9xaUDflUmSvMtB8IVAvR3/vLm7BDC+MiYA=
X-Gm-Gg: ASbGncv4nBfn1MLkVXtig2VbnsMI7uX9xBd3FISBvW+/yysHqwFqNEMaS4FWf1mA5AG
 1MkRHQbuqKStoOfoJxeBLkQMkClS7qvqX6074MKhNfr7HFMp9t/LghIGfFPD/DCHqtwvf58335I
 kByfZuy6ArhunqzoWznw36jLCAN7Ep2ipHy38ChKl2wBIYgaOPZ7eGCHyJU2CaLEmFZFYYdEPtG
 AIgmVF8K4gWvTeji3IUc7cIRWOi0vF0dGscsbL8SCQXchAh4aY5iFpyFk43SecU88b5g2mCXNI0
 2Dk6onLNnHQm/+mknPfQKMYP
X-Google-Smtp-Source: AGHT+IFtKdlySpgTFHcXdq3PbHF71/oV+iI3ZCsMwQy1hsgICs2WJd1dz7sU+bcPysmxbgWgFgI/Mg==
X-Received: by 2002:a05:6000:18a3:b0:386:8ff:d20b with SMTP id
 ffacd0b85a97d-38a221f2f2dmr29322826f8f.27.1735590618884; 
 Mon, 30 Dec 2024 12:30:18 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e8asm30543979f8f.37.2024.12.30.12.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 12:30:18 -0800 (PST)
Message-ID: <c2ce4e80-d918-4cf5-ab40-ac9e84955423@linaro.org>
Date: Mon, 30 Dec 2024 21:30:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/14] ui & main loop: Redesign of system-specific
 main thread event handling
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 balaton@eik.bme.hu
References: <20241223221645.29911-1-phil@philjordan.eu>
 <20241223221645.29911-2-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241223221645.29911-2-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi,

On 23/12/24 23:16, Phil Dennis-Jordan wrote:
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
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---


>   include/qemu-main.h | 14 +++++++++++-
>   system/main.c       | 37 +++++++++++++++++++++++++++----
>   ui/cocoa.m          | 54 +++++++++++----------------------------------
>   ui/gtk.c            |  4 ++++
>   ui/sdl2.c           |  4 ++++
>   5 files changed, 67 insertions(+), 46 deletions(-)
> 
> diff --git a/include/qemu-main.h b/include/qemu-main.h
> index 940960a7db..2ee83bedff 100644
> --- a/include/qemu-main.h
> +++ b/include/qemu-main.h
> @@ -5,7 +5,19 @@
>   #ifndef QEMU_MAIN_H
>   #define QEMU_MAIN_H
>   
> -int qemu_default_main(void);
> +/*
> + * The function to run on the main (initial) thread of the process.
> + * NULL means QEMU's main event loop.
> + * When non-NULL, QEMU's main event loop will run on a purposely created
> + * thread, after which the provided function pointer will be invoked on
> + * the initial thread.
> + * This is useful on platforms which treat the main thread as special
> + * (macOS/Darwin) and/or require all UI API calls to occur from the main
> + * thread. Those platforms can initialise it to a specific function,
> + * while UI implementations may reset it to NULL during their init if they
> + * will handle system and UI events on the main thread via QEMU's own main
> + * event loop.
> + */
>   extern int (*qemu_main)(void);
>   
>   #endif /* QEMU_MAIN_H */


> diff --git a/ui/gtk.c b/ui/gtk.c
> index 0d38c070e4..c023743148 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -38,6 +38,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
> +#include "qemu-main.h"
>   
>   #include "ui/console.h"
>   #include "ui/gtk.h"
> @@ -2485,6 +2486,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>   #ifdef CONFIG_GTK_CLIPBOARD
>       gd_clipboard_init(s);
>   #endif /* CONFIG_GTK_CLIPBOARD */
> +
> +    /* GTK's event polling must happen on the main thread. */
> +    qemu_main = NULL;
>   }
>   
>   static void early_gtk_display_init(DisplayOptions *opts)
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 1fb72f67a6..445eb1dd9f 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -34,6 +34,7 @@
>   #include "system/system.h"
>   #include "ui/win32-kbd-hook.h"
>   #include "qemu/log.h"
> +#include "qemu-main.h"
>   
>   static int sdl2_num_outputs;
>   static struct sdl2_console *sdl2_console;
> @@ -965,6 +966,9 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>       }
>   
>       atexit(sdl_cleanup);
> +
> +    /* SDL's event polling (in dpy_refresh) must happen on the main thread. */
> +    qemu_main = NULL;
>   }
>   
>   static QemuDisplay qemu_display_sdl2 = {

This fails the build-oss-fuzz job as:

     /usr/bin/ld: libcommon.a.p/ui_gtk.c.o: in function `gtk_display_init':
     ../ui/gtk.c:2491:(.text+0x3df9): undefined reference to `qemu_main'
     /usr/bin/ld: ../ui/gtk.c:2491:(.text+0x45f1): undefined reference 
to `qemu_main'
     /usr/bin/ld: libcommon.a.p/ui_sdl2.c.o: in function 
`sdl2_display_init':
     ../ui/sdl2.c:971:(.text+0x2e8c): undefined reference to `qemu_main'
     /usr/bin/ld: ../ui/sdl2.c:971:(.text+0x30bf): undefined reference 
to `qemu_main'
     clang: error: linker command failed with exit code 1 (use -v to see 
invocation)

Therefore I'm squashing:

-- >8 --
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 8274000bd55..ca248a51a6c 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -41,6 +41,7 @@ static FuzzTargetList *fuzz_target_list;
  static FuzzTarget *fuzz_target;
  static QTestState *fuzz_qts;

+int (*qemu_main)(void);


  void flush_events(QTestState *s)
---

Regards,

Phil.

