Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB6BCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 04:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1GxM-0000nj-O2; Wed, 24 Sep 2025 00:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1GxI-0000nG-JY
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 00:18:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Gx8-0003Nb-Hd
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 00:18:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-45dd5e24d16so60446705e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 21:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758687476; x=1759292276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=49ejThG34uYGiRjjAOs4ZyOqNSVZISCvSiKOVDVIQ3Y=;
 b=Fh4bMhrP7UOKO6Ua1foo/0QrilqVpTMxzjK75K5ZXqGyMFirSq+BQ4lpDw0WR9/YYs
 P21MdJt8bAj6vGxm6ADlnZsEQ821xvYCyqNn7tPbAPM9V83/NC2c8CvrE3EoWULEUaAW
 I2b4F+dsA0bffMbkujCN70TKPEMbaAeNAdVciAkLCme24cwoLoo4E7z+Fo+tlDgswq8X
 gsDr6NYX+csKi7NntZ0RBFWA6yiuiBhWbN/x6gX7rmop7hKk4+9Lwp2MKB3eh5S5TFAY
 N1omyl3g+xOO4k7f3NW2sRyLc1PxoJIS+fkyDyOsosn00W4gSFZa8dyAkz+qcKVQSlxa
 jt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758687476; x=1759292276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=49ejThG34uYGiRjjAOs4ZyOqNSVZISCvSiKOVDVIQ3Y=;
 b=F0JbUqWl/pKYhhU7m70BApS0OBe+EtJ2B/V6Jp7bTacAap+Ql7SW3vuhRSHfnwS1vV
 qDrzr07bL4LG0JRLpGkuLCbxMszOMnaovtEQxTTzxx9bUaMAxXGDrV69oK7zgadO5g4s
 zO4VQ2kAIgDBtROgS6Tk4iKtlbBP2Fd71B++K9fd59Ifpg6Q9V2XLEgO0N7UdHv5hwri
 FV/m7Hpgy553qBJmUBy7k/AkYiRsdZcTLARgTEdoGUU4lwJhW5Hyp0y2oJ9g93FNERSY
 EXd0rOVUncwPp7uZupVShFFDvLmNNXNBfpgUQScCv7oILLI78FW0yGMz9RGgSW2Xc9nG
 q6vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMvxEgcZkWofueca/3+Wkw6VljtC25YTubN/oYRPIJaScuycx5IFp795jsvipLnwdrsaOoKxhUP3ry@nongnu.org
X-Gm-Message-State: AOJu0YzXgkFm6cN2qOUxLHlp47V+D1Ofx+9n0ctc98ZC29Kn8LNBDXUe
 8ZSdkvQbm+4PSM31VN8ijFAUqhKhIXwddc4ONMxWgqrPmsFM8/HwVOySmXTE0ipb/2g=
X-Gm-Gg: ASbGncuxNNH2hwG3e7+znF9yL46ZJbQcX1qReohrtYgujza4ixiNIuQi5BXMqvhxjTo
 Ywyjn5BQPHRuzWGT7wI/skzaLzES/kmH20y0xZiRRYbBcXxbabwyJH03CF5zjQGyK9DOMAlDzPK
 /+D87qJUiKx+JZ6C87wyBigFYbX47li+9F5s9dh2XOsTdinBusz1+FAkF+q1RRUgSbhxbZh5aYw
 ZqyFFTsMGw0sz576rbjLOZWagKZlg/RGZiRsFzDDtIC2RBDYHzH0O7jMiTIZrxtKkybxyHU5vdy
 hEpjy+DYLe88sM7s6YKB6J/Gt6dPGsG38R/dIO/pKSA6jwYdwjTfNxmBmWGoo6FYedU/TbEURr2
 KfOX5iNKf9l8xOHKowcfoopZSM1xUhfTd0pgyLRxcEohANivJ408oj1JhLV+yn24SPg==
X-Google-Smtp-Source: AGHT+IGbgvKVm8VURTvI5f5ntC0WwuxkPUzzmj4rs+2hlAuUfCtcsDq/pH6ynjmXjwTHwZ8eRGT3BA==
X-Received: by 2002:a05:600c:1d07:b0:45d:d97c:235e with SMTP id
 5b1f17b1804b1-46e1daa0526mr52556555e9.12.1758687475701; 
 Tue, 23 Sep 2025 21:17:55 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407d0asm26279671f8f.17.2025.09.23.21.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 21:17:55 -0700 (PDT)
Message-ID: <9246474a-a235-4168-8ba0-141d9ef566b6@linaro.org>
Date: Wed, 24 Sep 2025 06:17:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tap-win32: fix multiple tap support
To: Gal Horowitz <galush.horowitz@gmail.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>
References: <20250923-fix-win32-multiple-taps-v2-1-d497e5ac446f@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923-fix-win32-multiple-taps-v2-1-d497e5ac446f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 23/9/25 21:42, Gal Horowitz wrote:
> Currently when more than one tap is created on Windows, QEMU immediately
> crashes with a null-deref since the code incorrectly uses a static global
> for the tap state.
> 
> Instead, this patch allocates a structure for each tap at startup.
> 
> Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
> ---
> Changes in v2:
> - Add cleanup of the structure fields
> - Terminate the thread before freeing the structure
> - Link to v1: https://lore.kernel.org/qemu-devel/20250920-fix-win32-multiple-taps-v1-1-bee41dcc213d@gmail.com
> ---
>   net/tap-win32.c | 44 +++++++++++++++++++++++++++++++++-----------
>   1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/net/tap-win32.c b/net/tap-win32.c
> index 38baf90e0b3f121f74eb32f1bff779c84ce03114..1b83423191c5a6f248c771d5eb5582cc80e8abcb 100644
> --- a/net/tap-win32.c
> +++ b/net/tap-win32.c
> @@ -104,6 +104,7 @@ typedef struct tap_win32_overlapped {
>       HANDLE output_queue_semaphore;
>       HANDLE free_list_semaphore;
>       HANDLE tap_semaphore;
> +    HANDLE thread_handle;
>       CRITICAL_SECTION output_queue_cs;
>       CRITICAL_SECTION free_list_cs;
>       OVERLAPPED read_overlapped;
> @@ -114,8 +115,6 @@ typedef struct tap_win32_overlapped {
>       tun_buffer_t* output_queue_back;
>   } tap_win32_overlapped_t;
>   
> -static tap_win32_overlapped_t tap_overlapped;
> -
>   static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t* const overlapped)
>   {
>       tun_buffer_t* buffer = NULL;
> @@ -402,8 +401,10 @@ static int tap_win32_set_status(HANDLE handle, int status)
>                   &status, sizeof (status), &len, NULL);
>   }
>   
> -static void tap_win32_overlapped_init(tap_win32_overlapped_t* const overlapped, const HANDLE handle)
> +static tap_win32_overlapped_t *tap_win32_overlapped_new(const HANDLE handle)
>   {
> +    tap_win32_overlapped_t *overlapped = g_new0(tap_win32_overlapped_t, 1);
> +
>       overlapped->handle = handle;
>   
>       overlapped->read_event = CreateEvent(NULL, FALSE, FALSE, NULL);
> @@ -454,6 +455,8 @@ static void tap_win32_overlapped_init(tap_win32_overlapped_t* const overlapped,
>       overlapped->tap_semaphore = CreateSemaphore(NULL, 0, TUN_MAX_BUFFER_COUNT, NULL);
>       if(!overlapped->tap_semaphore)
>           fprintf(stderr, "error creating tap_semaphore.\n");
> +
> +    return overlapped;
>   }
>   
>   static int tap_win32_write(tap_win32_overlapped_t *overlapped,
> @@ -604,7 +607,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
>           unsigned long debug;
>       } version;
>       DWORD version_len;
> -    DWORD idThread;
> +    tap_win32_overlapped_t *tap_overlapped = NULL;
>   
>       if (preferred_name != NULL) {
>           snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name);
> @@ -645,15 +648,35 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
>           return -1;
>       }
>   
> -    tap_win32_overlapped_init(&tap_overlapped, handle);
> +    tap_overlapped = tap_win32_overlapped_new(handle);
>   
> -    *phandle = &tap_overlapped;
> +    tap_overlapped->thread_handle = CreateThread(NULL, 0,
> +        tap_win32_thread_entry, (LPVOID)tap_overlapped, 0, NULL);
> +
> +    *phandle = tap_overlapped;
>   
> -    CreateThread(NULL, 0, tap_win32_thread_entry,
> -                 (LPVOID)&tap_overlapped, 0, &idThread);
>       return 0;
>   }
>   
> +static void tap_win32_close(tap_win32_overlapped_t *overlapped)
> +{
> +    TerminateThread(overlapped->thread_handle, 0);
> +
> +    CloseHandle(overlapped->tap_semaphore);
> +    CloseHandle(overlapped->free_list_semaphore);
> +    CloseHandle(overlapped->output_queue_semaphore);
> +
> +    DeleteCriticalSection(&overlapped->free_list_cs);
> +    DeleteCriticalSection(&overlapped->output_queue_cs);
> +
> +    CloseHandle(overlapped->write_event);
> +    CloseHandle(overlapped->read_event);
> +
> +    CloseHandle(overlapped->handle);
> +
> +    g_free(overlapped);
> +}
> +
>   /********************************************/
>   
>    typedef struct TAPState {
> @@ -667,9 +690,8 @@ static void tap_cleanup(NetClientState *nc)
>   
>       qemu_del_wait_object(s->handle->tap_semaphore, NULL, NULL);
>   
> -    /* FIXME: need to kill thread and close file handle:
> -       tap_win32_close(s);
> -    */
> +    tap_win32_close(s->handle);

This patch is doing various things at once.

Could you implement tap_win32_close() in a preliminary patch,
then convert the tap_overlapped global to an allocation?

Thanks,

Phil.

> +    s->handle = NULL;
>   }
>   
>   static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
> 
> ---
> base-commit: ab8008b231e758e03c87c1c483c03afdd9c02e19
> change-id: 20250920-fix-win32-multiple-taps-ed16ccefbd17
> 
> Best regards,

