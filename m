Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F7BCFA478
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 21:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3j7K-0006xG-JR; Wed, 23 Oct 2024 17:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3j7H-0006we-GE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:42:07 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3j7F-000110-Kb
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:42:07 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71ec12160f6so185868b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729719723; x=1730324523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jCkPJh12O0xzpGusA8hDKMyWs4aOKC/zKINHHOek7eQ=;
 b=WUtIVc74k+FvrpDu+ZTlLgXi0ZwHvFGgdokgDyyVanpkUmfK3n1PMJt2aK91Q+ZNRU
 yQ2KMQOfvwxjUrZcuYGSXQaHbKkxie9IOXNMRDywltBnrk33ryFXHNrLfug3+s6DJ5fr
 9Iu0W3J/7egD6s+F1ppmvdxPsec8EYMTFo/qyr8xxV7LHAlV2KCXdMdmsMcmktxUotp2
 1NyDJr1hcqUnkwW36t7kMacjph59vBPVTOQE2p8RdMb+G+Vt63A59ZL5GOX1Bm82DKqM
 vqW89TrBZbWMgRr84Ti/RUB/hN56XKyYvxjPHsitJjL4AF73vnaT39rM9NLAA2owungY
 9JSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729719723; x=1730324523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCkPJh12O0xzpGusA8hDKMyWs4aOKC/zKINHHOek7eQ=;
 b=I53Qb7dbKpOoa6uCw8mvnLh2P9HXdn+vEnJyOpZmrV9ZwGgzCGA6rR+ftVcpgCmJAw
 GcFkUXGJl75z+obWmIbQfXF2l/8vzNX/Pc6ElcngkBCkWdDy6Rsn+rOmbuSOgCK8m7mU
 tfnUUA/1q3h2apJgGJQGfiJbkYQg1lokrD/OW0VMELd0I1KP7TpdUBgsO/HQ7GNwnG8X
 qIHVBvrXPYZr6Dgx5m8444974JwH9sPJ+AClUcRWOYaobTPQTWIgBMd+h+KhUM+opYLO
 xyUmLIX7zrIV/GTeQVUyeKnRPtD4/jLH1wF6ETCnGIY7TBJAjBCX4tVeeKN8+Z6HcMz1
 /0EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7DU/ev90Js0qDqIug1qPgtMQxKP5O1CymfeFx7uiQyQlGJel82LzFs22UXLFpwXyl2U4uCW1tWjin@nongnu.org
X-Gm-Message-State: AOJu0YxG/FN+bBVYKkIHCKBtSdg9UcmBsL6EGIMeTFjjAaNXCjCjRM6R
 Ncdtq0ZIa8iCTj03Ykyr00/efPPu6dHTy/i7VXi8CPaG5CbN3cNDAScPLqWrjJg=
X-Google-Smtp-Source: AGHT+IETGYJ+HDGBMUoC54AGXmx0QCcmcSDv+vk+EF9lJGLv12KO2UbUT/FnGkATMNoXgCwXBo/I1g==
X-Received: by 2002:a05:6a21:1191:b0:1d8:d3b4:7a73 with SMTP id
 adf61e73a8af0-1d978aebeacmr4611527637.4.1729719723468; 
 Wed, 23 Oct 2024 14:42:03 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeabc2b1csm7417781a12.75.2024.10.23.14.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 14:42:03 -0700 (PDT)
Message-ID: <30454e0d-7110-4caf-b7f1-14a55beeea4d@linaro.org>
Date: Wed, 23 Oct 2024 14:42:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/tap-win32: Fix gcc 14 format truncation errors
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-stable@nongnu.org
References: <20241008202842.4478-1-shentey@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241008202842.4478-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/8/24 13:28, Bernhard Beschow wrote:
> The patch fixes the following errors generated by GCC 14.2:
> 
> ../src/net/tap-win32.c:343:19: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size 176 [-Werror=format-truncation=]
>    343 |              "%s\\%s\\Connection",
>        |                   ^~
>    344 |              NETWORK_CONNECTIONS_KEY, enum_name);
>        |                                       ~~~~~~~~~
> 
> ../src/net/tap-win32.c:341:9: note: 'snprintf' output between 92 and 347 bytes into a destination of size 256
>    341 |         snprintf(connection_string,
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    342 |              sizeof(connection_string),
>        |              ~~~~~~~~~~~~~~~~~~~~~~~~~~
>    343 |              "%s\\%s\\Connection",
>        |              ~~~~~~~~~~~~~~~~~~~~~
>    344 |              NETWORK_CONNECTIONS_KEY, enum_name);
>        |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../src/net/tap-win32.c:242:58: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size 178 [-Werror=format-truncation=]
>    242 |         snprintf (unit_string, sizeof(unit_string), "%s\\%s",
>        |                                                          ^~
>    243 |                   ADAPTER_KEY, enum_name);
>        |                                ~~~~~~~~~
> 
> ../src/net/tap-win32.c:242:9: note: 'snprintf' output between 79 and 334 bytes into a destination of size 256
>    242 |         snprintf (unit_string, sizeof(unit_string), "%s\\%s",
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    243 |                   ADAPTER_KEY, enum_name);
>        |                   ~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../src/net/tap-win32.c:620:52: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size 245 [-Werror=format-truncation=]
>    620 |     snprintf (device_path, sizeof(device_path), "%s%s%s",
>        |                                                    ^~
>    621 |               USERMODEDEVICEDIR,
>    622 |               device_guid,
>        |               ~~~~~~~~~~~
> ../src/net/tap-win32.c:620:5: note: 'snprintf' output between 16 and 271 bytes into a destination of size 256
>    620 |     snprintf (device_path, sizeof(device_path), "%s%s%s",
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    621 |               USERMODEDEVICEDIR,
>        |               ~~~~~~~~~~~~~~~~~~
>    622 |               device_guid,
>        |               ~~~~~~~~~~~~
>    623 |               TAPSUFFIX);
>        |               ~~~~~~~~~~
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2607
> Cc: qemu-stable@nongnu.org
> 
> --
> 
> This patch was just compile-tested (which fixes my issue). Testing TAP
> networking under Windows apparently requires extra drivers which I don't want to
> install (not my computer). So it would be nice if someone could give this patch
> a test ride. Thanks!
> 
> Changes since v1:
> * Use g_autofree and g_strdup_printf() rather than fixed size arrays (Peter)
> ---
>   net/tap-win32.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/net/tap-win32.c b/net/tap-win32.c
> index 7edbd71633..671dee970f 100644
> --- a/net/tap-win32.c
> +++ b/net/tap-win32.c
> @@ -214,7 +214,7 @@ static int is_tap_win32_dev(const char *guid)
>   
>       for (;;) {
>           char enum_name[256];
> -        char unit_string[256];
> +        g_autofree char *unit_string = NULL;
>           HKEY unit_key;
>           char component_id_string[] = "ComponentId";
>           char component_id[256];
> @@ -239,8 +239,7 @@ static int is_tap_win32_dev(const char *guid)
>               return FALSE;
>           }
>   
> -        snprintf (unit_string, sizeof(unit_string), "%s\\%s",
> -                  ADAPTER_KEY, enum_name);
> +        unit_string = g_strdup_printf("%s\\%s", ADAPTER_KEY, enum_name);
>   
>           status = RegOpenKeyEx(
>               HKEY_LOCAL_MACHINE,
> @@ -315,7 +314,7 @@ static int get_device_guid(
>       while (!stop)
>       {
>           char enum_name[256];
> -        char connection_string[256];
> +        g_autofree char *connection_string = NULL;
>           HKEY connection_key;
>           char name_data[256];
>           DWORD name_type;
> @@ -338,9 +337,7 @@ static int get_device_guid(
>               return -1;
>           }
>   
> -        snprintf(connection_string,
> -             sizeof(connection_string),
> -             "%s\\%s\\Connection",
> +        connection_string = g_strdup_printf("%s\\%s\\Connection",
>                NETWORK_CONNECTIONS_KEY, enum_name);
>   
>           status = RegOpenKeyEx(
> @@ -595,7 +592,7 @@ static void tap_win32_free_buffer(tap_win32_overlapped_t *overlapped,
>   static int tap_win32_open(tap_win32_overlapped_t **phandle,
>                             const char *preferred_name)
>   {
> -    char device_path[256];
> +    g_autofree char *device_path = NULL;
>       char device_guid[0x100];
>       int rc;
>       HANDLE handle;
> @@ -617,7 +614,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
>       if (rc)
>           return -1;
>   
> -    snprintf (device_path, sizeof(device_path), "%s%s%s",
> +    device_path = g_strdup_printf("%s%s%s",
>                 USERMODEDEVICEDIR,
>                 device_guid,
>                 TAPSUFFIX);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I ran into this as well and reimplemented something similar, but less 
good than current patch (which should be favored).[1]

I can't test it neither with TAP networking, but content of patch seems
correct to me. Hope we can merge it soon (before 9.2).

[1] 
https://lore.kernel.org/qemu-devel/20241023183009.1041419-1-pierrick.bouvier@linaro.org/

Regards,
Pierrick

