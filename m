Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332DEC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 10:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulPtQ-0007FZ-FN; Mon, 11 Aug 2025 06:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPtP-0007FM-Bj
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:36:39 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPtM-0003yP-Ri
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:36:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b8de193b60so2335135f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754908594; x=1755513394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kdDsJTJgleMiXHv27Bjb4RqFU5padoh0Hu4nYN/RaBs=;
 b=aKJnmWkiB/ZfODfquunHJaW/A5IpKXUm9sgAsIXrLnQx0QuRkzH90ON1EQjZKOktvW
 eoz++Am3GtpJaM8YJ9O0BYtTsZMbDhCRrFX5DOtr4KSstjhz2MGh45F0i77/74v1eJeG
 8L5k2B2Hc3FG4GcujbpFDvIn4xjYwA0ibIV6SX8IJ6Nlvk0WScFPQOlQ6dhTBWh415Vt
 +G3o7Zf+zAFRvdoopde8zgVFw/vkIYzd+csTV6dc0EnqrNcMiWq/mt5jchKnLUgvwiOQ
 TuiQeCJTbEj10FEhMffW8Il3y5DnmN0LLTh+CGoJ50G+SzYzrpXoa0vEKE3Ydycuu+v1
 utSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754908594; x=1755513394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kdDsJTJgleMiXHv27Bjb4RqFU5padoh0Hu4nYN/RaBs=;
 b=egvA39vg1zlIOLDAsZJqdTSUtQH4WG8mNgZs17mqVkp9dvcAH7nmoxRRwyYgpxxOfQ
 TzFtdHYO5fDPhogFzXqU0NH5wsv3wJVmJnL37+UmabtTBhJRkpPIbpUO3G6YVwRUFvvt
 lzrnDt2OOiPoT9++5sAwb2UlWQMPlVqOJThSjoH/4FS+5LJEDQ2GhZ+9tQsj8Yn/k4Nq
 boMBdkzhtwIGu964e6/+UHTPxCb1Ypzvr7+dgEWWXiL6cMFChrOkSqmXEBL9VTM0iVM5
 CTZaC/xb7N9zWuTJNkbUKFBHeXE8DnjPSrc2tyor68f+1K+PgxD2VY5qRM58z/ZjHwU2
 nuOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwlxaQJQxoU+WTWJEq57OXrypZmleQnNadzPNrdHZBDuLroFyVk4DSddEly2tg0khRyHjSgjvLq35k@nongnu.org
X-Gm-Message-State: AOJu0YyV/NBX6pm04VZegPIpaGugrbDWFP1T45xrWc1uZzDQ674yec9W
 9xCd0/LKFnp/8oMWIrb4M1FUQFRrESfeepSDt2IiQuYatm6IlRBNg5mCwbXC8gZbj1WMLuYmp6r
 mMjDJ
X-Gm-Gg: ASbGnctT0Je5DDiZe0bby8SGPcv5osxV8ep9WbblEGhzQXZRs7uTLKWnbQ0tYfzmR9M
 i+8FdAkN1E9Z0ASzLmCajUAoGNh8FRGVIoaHENGLKiygl4IVyEPnnrbebmf0E5gi/KRBpPZLO3S
 xik/vU7LWvVYbEUSFy10dczH2qxnV+AfMOXJq6KiAGScNBxvbe37F9TyRVBDkY7g54fwJyCpdt9
 WlqMqQKCH83mUhdot1whcIaowzkhIZxSQ1SHmUTpBayc88a6sLc59fwWgoupGcnTxFHs7OISnmA
 Tcj8RINGJ8nfGbNlh3Ka21UnuUVOCc+CPfqyoj8psRedRVxiTjYFu7bZDaQ7gfY/IPjWGBaGCfN
 QGTYKI1emhIELsf9UlAtbmGUrSdNROl0xAfE50sdQMJnTp2erb1uVuN7qrY9+HrkmlQ==
X-Google-Smtp-Source: AGHT+IE7NSK3IcDsKvgs/lTqux405OnJ5h41TFRzxg9y3Ir0AXK5whQ+TsyBj3jxayYC+aofHtYtQQ==
X-Received: by 2002:a5d:5886:0:b0:3a4:fbaf:749e with SMTP id
 ffacd0b85a97d-3b900b50a59mr9432627f8f.49.1754908593863; 
 Mon, 11 Aug 2025 03:36:33 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459ebede65asm201496705e9.8.2025.08.11.03.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 03:36:33 -0700 (PDT)
Message-ID: <09b9cd96-6542-4ef2-8e78-41d70ccf9840@linaro.org>
Date: Mon, 11 Aug 2025 12:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] hw/cxl: Convert cxl_fmws_link() to Error
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-4-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808080823.2638861-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 8/8/25 10:08, Markus Armbruster wrote:
> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
> 
> cxl_fmws_link_targets() violates this principle: it calls
> error_setg(&error_fatal, ...) via cxl_fmws_link().  Goes back to
> commit 584f722eb3ab (hw/cxl: Make the CXL fixed memory windows
> devices.)  Currently harmless, because cxl_fmws_link_targets()'s
> callers always pass &error_fatal.  Clean this up by converting
> cxl_fmws_link() to Error.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/cxl/cxl-host.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


