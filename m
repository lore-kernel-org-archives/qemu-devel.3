Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7B3C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 02:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJjkk-0003M2-Rp; Mon, 26 May 2025 22:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJjki-0003LT-GC
 for qemu-devel@nongnu.org; Mon, 26 May 2025 22:09:16 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJjkf-00046w-Uq
 for qemu-devel@nongnu.org; Mon, 26 May 2025 22:09:16 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so2109323b3a.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 19:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748311752; x=1748916552;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a+buw7xcPFGDG8cQFSge9bx9YyPU/vEVsP3JjThIDRM=;
 b=No13PIJXXwgAHTP3sMJVRv+lv75PbQtJLPxgQy8Wk5SWiwhoPTe05Yg/MQ1aB5aGxp
 MbU0Kzjh2b0JUnm5OON2zk+i5B133bB+viFZpgMdivolYwlV7+UduES67+TDygc+QpQ9
 fo0aAMlUzfe+ufudjyo0Y+Yl/+0u1gXWPHbjqksO9Ax3lFsTPmYV2P+6GKY9ImISrl/T
 7stlUqCuW325X3PaElgGhTFSdO2ylVcPp7YXfRFAt81os+XrKPo7Mcbvig6NHvriWDbS
 rFBK5EhsWGFq9PVOERt94iv3XcUJ9P/OpmpWV1hcvghvCaN72w8HLbmApAjIUyyoS2MA
 ygUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748311752; x=1748916552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a+buw7xcPFGDG8cQFSge9bx9YyPU/vEVsP3JjThIDRM=;
 b=ImuZZGKkp5Ba23+C6UxPmvkeZ2DNxlC4/tzs15G0ujO0lUYyqHC/uPgAUhq1lKsvBM
 GTfqLq+WV0NGp9cBmYylI/2WQ6J15BBAlMCC/6hHqIJthIArJhzKEGIPZUBO5FZkOiMK
 h9hIaYvUQ0EEMZXnYeXEiMyvIQ2gpkaRzcujTkY8BZoO0/1WzzeGpgT1HwAMyy6VhesW
 bhw+bx/q7JGofrRkvJuLypYMuy7RDyKzUja+PuiX9SmWkIPV2v3IkI8x0Dg+glJmGznb
 Wc2oR0B3fOSGvPhFrAFMeFYsu/KAwXr8W2xj4BwchjzCDiDDkLoFXouXTyOFHBjFH8GY
 VvEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4VPEA/04gq5N9Wu7X+TRpXrYKIoiYUiT4x7ibmxZlT8GGOwT3QT4omF6HrJbEHbSCC57I60NzAeEg@nongnu.org
X-Gm-Message-State: AOJu0YzXH1m2dXtX0MOavNzuhVyi02C1gSVFMm5MlQqF+hxDdOqvem3Y
 PDc9QUcQSB3ZEeOON9bKcumdE5c0M82t+gK1fjs2W8YOoXQ4YbFQMbaLLLE3ON3TtWs=
X-Gm-Gg: ASbGncuhXjFGjd+KjCfOhuTvq1UGxv6l3jLpsyfHoQDu9REr+YtBHzcW9yCRyTVsCxg
 iY83AzA4V2W9dIqQ3D7+CFKAJRqjSF/STYfxowLQCX50YJ6bP6kp0G8MkfFva3E8S1oGf9/rPTZ
 L7wmSy+o+KPlZSeOV+kjIx36CpL+L3fXRReCCsRmoi3K4U5dd+MZsl5VzrypwUEcw8GLnrauAHy
 fwzeYRDGw325i8/o9v8wqwRb1Ecnv7z1TDaj4nD+viQZFLQyFfF52fBW+0WcJcKf1MLe8izZvSZ
 R+oYAf8HI2X1AZW9DM80oRrqjNrg45wjgVLm0WgdUGtSXW0QzE2smOfOdVjdXzPSDAo+B5B9
X-Google-Smtp-Source: AGHT+IFx9uQwPEcVlByo3+v+jxdeVCZLSR0cZ6lU73FTNso++oVTYDcV9wTXAdx99zw2Mp+4hIxlUw==
X-Received: by 2002:a05:6a20:1587:b0:216:5fa9:55ad with SMTP id
 adf61e73a8af0-2188c3c772fmr17159893637.39.1748311752272; 
 Mon, 26 May 2025 19:09:12 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7461b3afa98sm1829314b3a.102.2025.05.26.19.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 19:09:11 -0700 (PDT)
Message-ID: <ceac6afc-a300-4ca8-a14e-7f60b31b75a0@daynix.com>
Date: Tue, 27 May 2025 11:09:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Improve futex usage
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <aDR_J5iYsSlBTDJm@x1.local>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <aDR_J5iYsSlBTDJm@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/26 23:48, Peter Xu wrote:
> On Mon, May 26, 2025 at 02:29:10PM +0900, Akihiko Odaki wrote:
>> Akihiko Odaki (11):
>>        futex: Check value after qemu_futex_wait()
>>        futex: Support Windows
>>        qemu-thread: Remove qatomic_read() in qemu_event_set()
>>        qemu-thread: Replace __linux__ with CONFIG_LINUX
>>        qemu-thread: Avoid futex abstraction for non-Linux
>>        qemu-thread: Use futex for QemuEvent on Windows
>>        qemu-thread: Use futex if available for QemuLockCnt
>>        migration: Replace QemuSemaphore with QemuEvent
>>        migration/colo: Replace QemuSemaphore with QemuEvent
>>        migration/postcopy: Replace QemuSemaphore with QemuEvent
> 
> In case it makes things easier.. I queued the three migration patches;
> AFAIU they look like standalone to go even without prior patches, meanwhile
> it shouldn't be an issue if they're queued in two pulls.
> 
> I am still not sure whether patch 1 is needed at all, but I'll leave that
> to others to decide.

The migration patches shouldn't be applied before patches "futex: Check 
value after qemu_futex_wait()" and "qemu-thread: Avoid futex abstraction 
for non-Linux" as they fix QemuEvent. Merging migration patches earlier 
can trigger bugs just like one we faced with hw/display/apple-gfx*

Regarding patch 1 ("futex: Check value after qemu_futex_wait()"), I can 
argue that we should have it to comply the generic "upstream-first" 
principle; the upstream (man page) says to make a loop, so the 
downstream (QEMU) should follow that until the upstream says otherwise. 
But I think it's a good idea to spend efforts to understand the 
reasoning behind the man page since it's so important that it affects 
not only QEMU but also any userspace program that uses libpthread (i.e., 
practically everything).

Regards,
Akihiko Odaki

* 
https://lore.kernel.org/qemu-devel/a8b4472c-8741-4f80-87e5-b406c56d1acd@daynix.com/

