Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895B9E6FE49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 07:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snYxH-00013f-Pr; Mon, 09 Sep 2024 03:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1snYxG-00012s-ST
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 03:36:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1snYxE-00036H-Q0
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 03:36:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-201d5af11a4so41272295ad.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1725867415; x=1726472215;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UsAKdHV2ZXVU0rXq6wBM2YcbxoOvYr3F9XGHWXUqLRI=;
 b=va5RffeQ3lto23scp9O7qJtj83TiVwtnFSFyG0GlYfR6frpq5S0xJteEHI8/XzWqdC
 hIpRKS+7yhvjXOHKsN/yFFKOQfajgDJiZYlB2x/Lyti3TxA4c8GXh8Pk6aDPYZ7j/ogI
 l7VGK3UohqPNj6hw/nkNuCPoz/l0VnhLCMoOhnMfcWsT8x5uDLW5wCSg/YYuwWgNVJ8H
 b356g/ufkZZFR6+qIuSqBJdq46utivb2F1K9be4ejCvHV+aI0fp+bTUfl85JrPt60zdf
 TKk12cNnuX8Tk6klUueHNZzyaTyaTYTy3auPX50smz6a2MtlzKPFWPD1Ao8XkGuOh6Ge
 8T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725867415; x=1726472215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UsAKdHV2ZXVU0rXq6wBM2YcbxoOvYr3F9XGHWXUqLRI=;
 b=V/S3Ak4hus3bJsKlahf15O+35bePePseP9UeJS7As0dpnb67cObSzmPN8cCO8o8mMR
 UN/LVDP7I1w4QATTGf47GYZX1+FffbaIet9fO+YWaYuaUOpuqN/0XX0tx4KOvvkPC5zn
 RARLSQffODoEPANYTii/9pLqTCLFToFf5kX41xxDUwOwxETycBOjpyclXFNy7TMMr+oK
 pI+EFQo0tKWi9qvvcFem38oNrmYr4dK0LyXcGeeCNdziwKs1KBZAvr5xbGQQekRPeX6N
 ftYx8Dl32vujix/ImcUnkzFON+GS/wqc1AB8tKS1fzxcjimtDta9Rzf2bFURxR84Fic0
 Djgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbIWCdXq48FMWWVzxIDIkLPDRixhfX4Rb6WTQ5ceCNte0VIFQoPx/OUUDfFTEOmuVjZOsT65iZAHe2@nongnu.org
X-Gm-Message-State: AOJu0YxfjAl80VpOFpNcrXDj+cAxpX6DeJk+62grV2LMoAbfPwFi+17y
 ZcNdP7KivM5O86+6iiclC6Akh2khHvptan139GfzEuauPl5+TCK96qxwbsYj+Pw=
X-Google-Smtp-Source: AGHT+IFj1R5f2uiuspkuS6RaLbYOcMiJZnNM8Iu6cbvLYVEIjJcSNXRQYr08L1cInI1nEQ4MdvDy4A==
X-Received: by 2002:a17:902:ec84:b0:206:aac4:b844 with SMTP id
 d9443c01a7336-206f04c9142mr139708355ad.6.1725867414873; 
 Mon, 09 Sep 2024 00:36:54 -0700 (PDT)
Received: from [157.82.201.226] ([157.82.201.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f342edsm28667145ad.286.2024.09.09.00.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 00:36:54 -0700 (PDT)
Message-ID: <dab54af1-cf9d-401c-a11f-657334b52d5a@daynix.com>
Date: Mon, 9 Sep 2024 16:36:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: support locking on change medium
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20240909015847.40377-1-j@getutm.app>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240909015847.40377-1-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/09/09 10:58, Joelle van Dyne wrote:
> New optional argument for 'blockdev-change-medium' QAPI command to allow
> the caller to specify if they wish to enable file locking.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   qapi/block.json                | 23 ++++++++++++++++++++++-
>   block/monitor/block-hmp-cmds.c |  2 +-
>   block/qapi-sysemu.c            | 22 ++++++++++++++++++++++
>   ui/cocoa.m                     |  1 +
>   4 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/block.json b/qapi/block.json
> index e66666f5c6..35e8e2e191 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -309,6 +309,23 @@
>   { 'enum': 'BlockdevChangeReadOnlyMode',
>     'data': ['retain', 'read-only', 'read-write'] }
>   
> +##
> +# @BlockdevChangeFileLockingMode:
> +#
> +# Specifies the new locking mode of a file image passed to the
> +# @blockdev-change-medium command.
> +#
> +# @auto: Use locking if API is available
> +#
> +# @off: Disable file image locking
> +#
> +# @on: Enable file image locking
> +#
> +# Since: 9.2
> +##
> +{ 'enum': 'BlockdevChangeFileLockingMode',
> +  'data': ['auto', 'off', 'on'] }

You can use OnOffAuto type instead of defining your own.

> +
>   ##
>   # @blockdev-change-medium:
>   #
> @@ -330,6 +347,9 @@
>   # @read-only-mode: change the read-only mode of the device; defaults
>   #     to 'retain'
>   #
> +# @file-locking-mode: change the locking mode of the file image; defaults
> +#     to 'auto' (since: 9.2)
> +#
>   # @force: if false (the default), an eject request through
>   #     blockdev-open-tray will be sent to the guest if it has locked
>   #     the tray (and the tray will not be opened immediately); if true,
> @@ -378,7 +398,8 @@
>               'filename': 'str',
>               '*format': 'str',
>               '*force': 'bool',
> -            '*read-only-mode': 'BlockdevChangeReadOnlyMode' } }
> +            '*read-only-mode': 'BlockdevChangeReadOnlyMode',
> +            '*file-locking-mode': 'BlockdevChangeFileLockingMode' } }
>   
>   ##
>   # @DEVICE_TRAY_MOVED:
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index bdf2eb50b6..ff64020a80 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -1007,5 +1007,5 @@ void hmp_change_medium(Monitor *mon, const char *device, const char *target,
>       }
>   
>       qmp_blockdev_change_medium(device, NULL, target, arg, true, force,
> -                               !!read_only, read_only_mode, errp);
> +                               !!read_only, read_only_mode, false, 0, errp);
>   }
> diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
> index e4282631d2..8064bdfb3a 100644
> --- a/block/qapi-sysemu.c
> +++ b/block/qapi-sysemu.c
> @@ -311,6 +311,8 @@ void qmp_blockdev_change_medium(const char *device,
>                                   bool has_force, bool force,
>                                   bool has_read_only,
>                                   BlockdevChangeReadOnlyMode read_only,
> +                                bool has_file_locking_mode,
> +                                BlockdevChangeFileLockingMode file_locking_mode,
>                                   Error **errp)
>   {
>       BlockBackend *blk;
> @@ -362,6 +364,26 @@ void qmp_blockdev_change_medium(const char *device,
>           qdict_put_str(options, "driver", format);
>       }
>   
> +    if (!has_file_locking_mode) {
> +        file_locking_mode = BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO;
> +    }
> +
> +    switch (file_locking_mode) {
> +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO:
> +        break;
> +
> +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_OFF:
> +        qdict_put_str(options, "file.locking", "off");
> +        break;
> +
> +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_ON:
> +        qdict_put_str(options, "file.locking", "on");
> +        break;
> +
> +    default:
> +        abort();
> +    }
> +
>       medium_bs = bdrv_open(filename, NULL, options, bdrv_flags, errp);
>   
>       if (!medium_bs) {
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 4c2dd33532..6e73c6e13e 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -1611,6 +1611,7 @@ - (void)changeDeviceMedia:(id)sender
>                                          "raw",
>                                          true, false,
>                                          false, 0,
> +                                       false, 0,

This change is irrelevant.

Regards,
Akihiko Odaki

