Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F20CEE343
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQVK-0007Za-2g; Tue, 18 Nov 2025 13:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQVI-0007Yc-36
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:32:36 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQVG-0001Zx-IE
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:32:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so39331025e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763490753; x=1764095553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d/uW5xhAdkkbUSv0iFNaMOjk/XEPGG4W51LWNCO8iAA=;
 b=j40ZTJ4MEaeKX0fmDAsSYU8IhxIJHTUZ8jvPnVCfioeW0tDlz5XDNSl0p24UNBmuvi
 TU/bwIu1DkTPsiNElKKbqCnGr7b7Xh+CxLQhyo1WehMOs0aysXnfgTYXrl56k+ppHFJn
 klKoXT5Lfexit+HjVgC0atZxnb1UbtDyePELHX+NyM2xLR0qREHNXfPWaQaxVJ2U3uFT
 g8k00tdCA6D19TmPK7Elymb+2fcjd2hIrv73iT0pjwVOJXkfYIQBbfVl4QeV1AkmzSXT
 ucar8RkxttVQyAWAoMIKk7XEO83hQvXM1VyAxE5Ls/7OIUuKDAnlAIRtmTLmhUalWF3c
 OyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763490753; x=1764095553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d/uW5xhAdkkbUSv0iFNaMOjk/XEPGG4W51LWNCO8iAA=;
 b=EHFaUDDTAM1wmTtyEAS7u9eNFQB19LoE8T6eifEsohzhasixQVLeH2z9E8V2PWTYib
 oLiirvnkYNorWP4F+amOpl5z7NtbsfPFYItkgHgynPDG8m0unhwd/0bAm3Ptw5BLWugR
 2mCwTsOaZrlKRMI1KRAZF4iDfzqL48tbpKA0sWVMU7hFKKCL3zR15UvIMOUtVfLoFTQX
 IWRA8d3plqDatCSyOQFQyUxUBAB+6a92tDrCOcIKyiVgYoXvwGLYAjpisipyZIYJJtIp
 93e66AgOR7Glfp1XR26ITEs6CEIgKk6iPpZvl3TJlN1HbZrGsgJYVU62CtFxj/uj7At0
 NTPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRiw1S4oRaTC435tqTUeRjS7XxPEyMwsdEQPZZtWRppuMvzsZbBR9yPqM4zsNlV2luBWUuL4ASQOXD@nongnu.org
X-Gm-Message-State: AOJu0Yxpj1ibeFigIZkRU4j/b2RtL43cgDQx1lCCfaeSZqKC/DrwlLPr
 PXqDsk2UtntbckbbmnS9ohAkgCA7/Q67Z6KhVlhHEpHTH7YMRIbx0ZEwVhGIRTb4USI=
X-Gm-Gg: ASbGncsSm4Oiqlpm3pEWchpkpqdkF2++dGYJIec64NLGWVFK1p25J385SyWwtZYWT3d
 5DIevtqOiMErdsUSsuepkPFQl0jgIsnC1ENlXTGXm1LAGqKZZOHhUnJxnDYGG/m4KIkDTbNiwJ+
 YiglxVtl+dz2Borv+fD72puszjCQUhB0oxoAzin+9ETcqQayxt1wJoul26mncRR9WQuxSJGK+F/
 88KdWU/qC+FZ9mOWdJwErCcPaGXzXZksKXmdrI3lH07P4/9txr77/PH8V16o6SQ5ooWU29o5Ees
 V+CvP2GS97VgHj26EG6oXk6X6OJcQ36Rj1BHzMdqfZcdR9sA0o6eBl6jbD8VrRVawzTJedCaOtA
 TXrTF24LbhD4JNZHmo+f2vVo3FE9AgFnzZi144YiABabzWWBt2ERngsVmWYg6LLd+BVSjQKVBGn
 +MFYnDCKM4++9RNB/r7S7XWcOjZLjleG27fKi/CSX7loE5Qdix9usWtGf5NCAZlO9l
X-Google-Smtp-Source: AGHT+IH8As0k+/qjIsRxSGFWSXrkQNipyVInInfO9IazJV+xqM6wRvyQCswVI0x7uEeQl0TUmXRrfQ==
X-Received: by 2002:a05:600c:8b23:b0:477:7bd2:693f with SMTP id
 5b1f17b1804b1-4778fe60615mr166243085e9.6.1763490752689; 
 Tue, 18 Nov 2025 10:32:32 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477aa387473sm21714325e9.4.2025.11.18.10.32.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 10:32:32 -0800 (PST)
Message-ID: <f25dd5eb-260a-4bc2-acde-3fee7291f49b@linaro.org>
Date: Tue, 18 Nov 2025 19:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qtest.c: Allow for multiple CHR_EVENT_CLOSED events
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251107174306.1408139-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107174306.1408139-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 7/11/25 18:43, Peter Maydell wrote:
> In the qtest_event() QEMUChrEvent handler, we create a timer
> and log OPENED on CHR_EVENT_OPENED, and we destroy the timer and
> log CLOSED on CHR_EVENT_CLOSED. However, the chardev subsystem
> can send us more than one CHR_EVENT_CLOSED if we're reading from
> a file chardev:
>   * the first one happens when we read the last data from the file
>   * the second one happens when the user hits ^C to exit QEMU
>     and the chardev is finalized: char_fd_finalize()
> 
> This causes us to call g_timer_elapsed() with a NULL timer
> (which glib complains about) and print an extra CLOSED log line
> with a zero timestamp:
> 
> [I +0.063829] CLOSED
> qemu-system-aarch64: GLib: g_timer_elapsed: assertion 'timer != NULL' failed
> [I +0.000000] CLOSED
> 
> Avoid this by ignoring a CHR_EVENT_CLOSED if we have already
> processed one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   system/qtest.c | 4 ++++
>   1 file changed, 4 insertions(+)

Queued, thanks.

