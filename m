Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C457C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqfQ-0005Um-0c; Thu, 22 Jan 2026 04:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqfO-0005UF-7U
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:07:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqfM-0008Lp-Lb
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:07:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so12044285e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 01:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072867; x=1769677667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZmT2xl+EpJzdTV4I3cuX5ZyTSKTx0rkrxRm/PY0qBY=;
 b=vLJwnfmmM9bGrEKhuTsVwAh3thmowva4KOfcszZ0DV0HjD0CrqgJTKBTL8cu/DAVxr
 giEDVfQxiGuPQ/TpgKXZ7gp8RVwVWwfG66KAuBZ4eHX0E2nzLDqEvm+fh3ip/n4w5xJ2
 whGia0gshB1NwEbE+PmW5qhwyTIPkafpdZLOz5wmOvpWjeExpwebjDktJ6FYhAXnij91
 tDlHNChg02JhTkQ1BV/M7eBMVLNO74JVbY6+DHgrs80jZ2ssTnAyKqwUCE9/9IXHEQ1G
 v4GaYfTn/cYFTc+eLRR+2/C8e4yRQFP3WHpoMJ5nAwYr6ABXreWEzcMGK/VxumJjktPP
 0YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072867; x=1769677667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iZmT2xl+EpJzdTV4I3cuX5ZyTSKTx0rkrxRm/PY0qBY=;
 b=fsur6BL8WzV9FF8m8KnhrcwYlPLP4uAbfBxJ6zoOEmF6b8yuk3TQTnb2ZBqHf/tBK/
 3I7sLT2wN0PFUwROkFiIqUP2Km/do8Zhh5YMHgI45V+nIIWyw4jPK0ny8DEhURSp+pFa
 dywd65rg4AHC6M104oYKAJFDayrZge1zODXqhoTO3P4G3EBhJG/AwwCI97UmlGmsvx4a
 5HX61v0AiNLGCmYX2NdGRT75IVzwA5tdc+Y6YkvKBek5MG0evd8PGO030e+TAkteg7U8
 957BIduomBIr0X6TnQk6l1+FdqMWVfMK5xcxRaSzHtwFAfKm/jTJqVUchScaVFdO4TV1
 j4rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW+2wlIDMmyG3MUaUWvc2tGdmoEIixHK4O7Rg2y/Q3cHzUmjCAHJWVkg/tv5aerjpkcd7oYEqxp9Y4@nongnu.org
X-Gm-Message-State: AOJu0Yz7BVZeGRqxn2OeIYozF0OvXAgNeOR/7kymNIj5m9SALEoDWLZb
 ixv5gSZaUNsaH8Lz5bJ+wf848D+2HF6950YTYgowpLZtB76XWLRvqo0ihtkz0PmJOHQ=
X-Gm-Gg: AZuq6aK/DM+FubduD/TfoeiW4rPhQTvdHben0DdYLv6kX0yPLO2OHWnS43IeuwfJCrj
 hyZDNy/tQuRRdyN+iYNcC51abMm8ZZcn3+7ttQJFahZsfZQyBd51Y2y8/opxjkiFIVFlN3fuySv
 +Ra0qngTEXCZNMYWe2DgVuqy703VWLlFBzyy2uCbsO6N4Ic7tCzXwwtE91m2KnYi6OAZFTidg6c
 xuGBBuzG+He8P4WzmqDQITSELE6qCFbGuTx60lFJ65bsu0M12ORlV2NAuscLqal8B0LwCCBAzkp
 6ZdewgbKwerGgsowEosM57pDOw2IbqHo2pWXYCw2JJBuBLAxBVE5QSkhD0JmJ2AR7QepEirJ16D
 PViNzW591WAk0pTxSmcssH3l96/jcorwOfS04wdLd+bgVaaRwsK9ShkejiWZyeFSLYF/60uRNdm
 gvFzDhIwm4yzOQXNdm9diqOjMfnfctrvI3K7xUeMmK3/RO4r2le+ikyQ==
X-Received: by 2002:a05:600d:644a:20b0:47e:e38b:a83 with SMTP id
 5b1f17b1804b1-48047068f88mr28038575e9.7.1769072866825; 
 Thu, 22 Jan 2026 01:07:46 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm77809535e9.2.2026.01.22.01.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 01:07:46 -0800 (PST)
Message-ID: <06767187-943f-40ef-ba59-3af4b4df44e9@linaro.org>
Date: Thu, 22 Jan 2026 10:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Replace CONFIG_WIN32 with CONFIG_WIN64
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
References: <20260122090352.9901-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260122090352.9901-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/1/26 10:03, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We stopped supported 32-bit Windows hosts a while ago already, so
> let's rename CONFIG_WIN32 to CONFIG_WIN64 now to make it clear
> that this switch is not about 32-bit Windows anymore.
> 
> The patch has been created with a simple sed statement:
> 
>   sed -i s/CONFIG_WIN32/CONFIG_WIN64/g $(grep -rl CONFIG_WIN32 *)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build           |  2 +-
>   qapi/char.json        |  4 +--
>   qapi/misc.json        |  2 +-
>   qga/qapi-schema.json  | 76 +++++++++++++++++++++----------------------
>   include/qemu/futex.h  |  2 +-
>   include/qemu/xattr.h  |  2 +-
>   hw/usb/host-libusb.c  | 18 +++++-----
>   io/channel-watch.c    | 10 +++---
>   ui/gtk.c              |  2 +-
>   util/cacheflush.c     |  4 +--
>   util/sys_membarrier.c |  2 +-
>   scripts/checkpatch.pl |  2 +-
>   12 files changed, 63 insertions(+), 63 deletions(-)


> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3a9557417f7..4cb583bdebd 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3110,7 +3110,7 @@ sub process {
>   			}
>   		}
>   # check of hardware specific defines
> -# we have e.g. CONFIG_LINUX and CONFIG_WIN32 for common cases
> +# we have e.g. CONFIG_LINUX and CONFIG_WIN64 for common cases

Alternatively CONFIG_[MS]WINDOWS?

