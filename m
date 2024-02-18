Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A0AC4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 07:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbbVa-00040i-TP; Sun, 18 Feb 2024 02:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbbVZ-00040P-Ie
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 02:22:41 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbbVX-0002zs-Rs
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 02:22:41 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so2368579b3a.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 23:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708240958; x=1708845758;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BQ7pE+9RmVhbgtouxnxbnLPPUIVySuKhNhNXmYTwBKE=;
 b=oI48LKKHrDEP/kKlvK1JW9UXMb3mcUSl2W2nHNI6i+pO1m5u1NsRKjjO6DRCFTyOND
 8JYw0v75Q2H+RR+mzXfjXZY9ePLgs4kq0Hukw52su8djt38h01baUEjxhZVacrBw+8B0
 1TFV4GJJdhzMTrBS3Cj5PfAP8uXUKt+ljiXjatZQ2FseV5tbTBi183R++YATWB+zOu5T
 si2AuW3LqjNnQuDf84Ljf8EbjZNfN3wVoRi8oTdHtYnXYQVpdUi9ImkeGPlk5gj/xlBZ
 7vdhAfIAMOdEltXMwItSd1Z8sDgReaBVPp9Y05pWxRrxCJkiK2LCUtjQfWJynKvk4I7n
 gK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708240958; x=1708845758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQ7pE+9RmVhbgtouxnxbnLPPUIVySuKhNhNXmYTwBKE=;
 b=qcxQjXUYQvPr1aH8Gquhpz6YMhJ/tquEPHWcOoAkmkfytesXC+bVgAJ+fssbUNmfbF
 dCEv1i46nGHVm7c0KR9Rk/RhnaqbYzS3LUrHgkVgEzCFhS+VeMI27YSrqlHSsBrbTgjl
 wNU+uKVIzXZkPqA9pAVd0PcTYjDpMvAKCGEkv8f7HoEXmRnSOuxLPE1d22CeJSJjOm8x
 pf4jNgt7Qv1rAKqz8VDrEdMNrbmcFEoZDLHy4mpYpQQexbJeFYrKWIbiOiDoy6rhRKdM
 cnZbxxWt59Eji+6vH0B2imyju0kyUfi5Leh5bDMeMrqOJ74yg7Op22tOnOEYzjn53j34
 ysUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGbyx0PzD7j/U6ngiIcVz5RPXB98SABoEL/8ZoZcSXxeAW12euDq2itxRkkbcIScGHU3fHHZnxNNTn8QA67igpfATKu60=
X-Gm-Message-State: AOJu0YxOc0WEnckNwaDHtCt0+JUlxYloBTZqzLxCdiezteOr/oXJ9M9n
 4mmI74YqlKLe4Kqme4N3hs087Okq0ao5hTPIZ7q35CMutVYujtZpdoOrztYCLKo=
X-Google-Smtp-Source: AGHT+IFxS914RaS3qFL4uLBNR8T7+/9741AHy+9PXQ+Zmi7B4k3lkbZGMBRybS2ozcQF8hHb60iUsg==
X-Received: by 2002:aa7:8ec5:0:b0:6e4:59b7:1dd4 with SMTP id
 b5-20020aa78ec5000000b006e459b71dd4mr1068154pfr.31.1708240958495; 
 Sat, 17 Feb 2024 23:22:38 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 r27-20020aa7845b000000b006e45a40b2edsm463459pfn.212.2024.02.17.23.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 23:22:38 -0800 (PST)
Message-ID: <4e007fd4-294e-4969-80a3-2508a518cea8@daynix.com>
Date: Sun, 18 Feb 2024 16:22:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vl: Print display options for -display help
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231216-help-v3-1-d51db92740d0@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231216-help-v3-1-d51db92740d0@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Marc-André, Paolo,

This patch has Reviewed-by: and Tested-by: but not pulled yet. Can 
either of you pull this?

Regards,
Akihiko Odaki

On 2023/12/16 17:03, Akihiko Odaki wrote:
> -display lists display backends, but does not tell their options.
> Use the help messages from qemu-options.def, which include the list of
> options.
> 
> Note that this change also has an unfortunate side effect that it will
> no longer tell what UI modules are actually available.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Changes in v3:
> - Dropped qapi/qapi-commands-ui.h inclusion. (Philippe Mathieu-Daudé)
> - Link to v2: https://lore.kernel.org/r/20231215-help-v2-1-3d39b58af520@daynix.com
> 
> Changes in v2:
> - Noted that it no longer tells the availability of UI modules.
>    (Marc-André Lureau)
> - Link to v1: https://lore.kernel.org/r/20231214-help-v1-1-23823ac5a023@daynix.com
> ---
>   include/ui/console.h |  1 -
>   system/vl.c          | 11 ++++++-----
>   ui/console.c         | 21 ---------------------
>   3 files changed, 6 insertions(+), 27 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index a4a49ffc640c..58f757350647 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -470,7 +470,6 @@ bool qemu_display_find_default(DisplayOptions *opts);
>   void qemu_display_early_init(DisplayOptions *opts);
>   void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
>   const char *qemu_display_get_vc(DisplayOptions *opts);
> -void qemu_display_help(void);
>   
>   /* vnc.c */
>   void vnc_display_init(const char *id, Error **errp);
> diff --git a/system/vl.c b/system/vl.c
> index 2bcd9efb9a64..f9656667ee54 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -915,16 +915,17 @@ enum {
>   
>   typedef struct QEMUOption {
>       const char *name;
> +    const char *help;
>       int flags;
>       int index;
>       uint32_t arch_mask;
>   } QEMUOption;
>   
>   static const QEMUOption qemu_options[] = {
> -    { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
> +    { "h", NULL, 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
>   
>   #define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
> -    { option, opt_arg, opt_enum, arch_mask },
> +    { option, opt_help, opt_arg, opt_enum, arch_mask },
>   #define DEFHEADING(text)
>   #define ARCHHEADING(text, arch_mask)
>   
> @@ -1094,10 +1095,10 @@ DisplayOptions *qmp_query_display_options(Error **errp)
>       return QAPI_CLONE(DisplayOptions, &dpy);
>   }
>   
> -static void parse_display(const char *p)
> +static void parse_display(const char *p, const char *help)
>   {
>       if (is_help_option(p)) {
> -        qemu_display_help();
> +        fputs(help, stdout);
>           exit(0);
>       }
>   
> @@ -2880,7 +2881,7 @@ void qemu_init(int argc, char **argv)
>                   }
>                   break;
>               case QEMU_OPTION_display:
> -                parse_display(optarg);
> +                parse_display(optarg, popt->help);
>                   break;
>               case QEMU_OPTION_nographic:
>                   qdict_put_str(machine_opts_dict, "graphics", "off");
> diff --git a/ui/console.c b/ui/console.c
> index 7db921e3b7d6..c230951dce62 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -26,7 +26,6 @@
>   #include "ui/console.h"
>   #include "hw/qdev-core.h"
>   #include "qapi/error.h"
> -#include "qapi/qapi-commands-ui.h"
>   #include "qapi/visitor.h"
>   #include "qemu/coroutine.h"
>   #include "qemu/error-report.h"
> @@ -1691,23 +1690,3 @@ const char *qemu_display_get_vc(DisplayOptions *opts)
>       }
>       return vc;
>   }
> -
> -void qemu_display_help(void)
> -{
> -    int idx;
> -
> -    printf("Available display backend types:\n");
> -    printf("none\n");
> -    for (idx = DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
> -        if (!dpys[idx]) {
> -            Error *local_err = NULL;
> -            int rv = ui_module_load(DisplayType_str(idx), &local_err);
> -            if (rv < 0) {
> -                error_report_err(local_err);
> -            }
> -        }
> -        if (dpys[idx]) {
> -            printf("%s\n",  DisplayType_str(dpys[idx]->type));
> -        }
> -    }
> -}
> 
> ---
> base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
> change-id: 20231214-help-9fa146fc6e95
> 
> Best regards,

