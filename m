Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8115DCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zjA-00088z-1b; Tue, 23 Sep 2025 05:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0zj2-00087S-VR
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:54:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0ziw-0007oq-9n
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:54:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-467f6fd4e82so14735535e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758621248; x=1759226048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M8HWTywZJA5XsGKhJb/CfwAo8EaWdiOZwZpe3Qd80+k=;
 b=VUQezyadD5nAfQR2ZOquWda8z+9/Snhtt8yxaRMz4YLegJVrMo9MVVtP3/yXWgBiSl
 GsJKUwymdvDN0eV0sqU9XUxGyKCO6D86Zk0f/4YMsskhmPnZk5MB6m8zUpCmaIu8dUNf
 B4csAy14/I0KscU7cr50QilzJqifmKdUHRJMQ/b0sDrkMC0zelPZfz3x2S+k7jZ9hrbs
 lws5YjYBmkLR2OKPkawBYHXShCRE+kuuIA5ndfNahgDJNyNoRDSpFm+9tN5Doadb9MUQ
 JwJ9C5z8IEbcL8HiTASNNSQabCbjFI3vq2uoR1WqnSiBoAyesvkNHOGYptBg1jNHTPwO
 7ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758621248; x=1759226048;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M8HWTywZJA5XsGKhJb/CfwAo8EaWdiOZwZpe3Qd80+k=;
 b=DyXssqk8iCpEg1vq5B7ygeUwGq28jzQnMbouOijGQxQB0gtcVLLF/vv7Tne+45Zhi4
 QcBobd95wc9aXX2zxncAppWKyz6HS/gZhuRAnY1Mm2RRoaxAfsi42h2AnKRN7Da8430T
 yKP3xhZ+XRVD5xXQe6oFC+vQHWjE452sfE51TJ4xtVRMzr02eTcao8y7M3lwE8I/TEdf
 rmKzroosyEwIxOCo4kWA+16OlbYKMyPuyWMxXCUbU35OC+xt5vEVTrIKk3bdTNWgG3YQ
 u+dq2dm4Q7IWA+B70cMpibx/OcauQZzW+DV1I/VgLzqY19s7rRF0jXVDs2wk0XsFmiem
 AIEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt7/reFjkBitSNfleYauCXNACbhnXrf/e4nYLBI3SOAtALKhWw+vbz1SPUiQ0qVESefeNEEODgvMfe@nongnu.org
X-Gm-Message-State: AOJu0YxGB8VrhYW5Ib8yWPl4VFH49W11hWvDNXgNEWFTi7wGRwwJP8Dr
 3TQlIAx3EyVUXZGcWcjmL87zLgofM1uP3UNbJTPDcuZvlpoNMn+HY1IsHP8LR+i8QSw=
X-Gm-Gg: ASbGncu/7EQerl71UrHHEAuA5X7m/Axx4NqDqWoKqgo7FKNE7bobpRz0t1L/0no6wJj
 8XgwkmJOn/HGn29Wp7PVTkF7UyJsOmY92WTJYEZF8JZfB2PymGPfYKjQWfefh3FnY1JzQxrU/tS
 85CBFXiUmru4EFKH1NUSenN7HwQc+6gNixms+HjiD2X7UXkFJTZMbA3NhxomJe7HLkXasx5p+Dt
 H6aVWMFIlxFMqzI4Qw/saQ6K6JhYnZraYA6SP6lKXIoIMPulVvl6/FUr59IPyYg27UJBB4YfFJV
 kuDNTc+CtmdT0fo1a0HC/fMKF4TT2pDk4yCBK0r6BXiG638+lxbONbBR6nebaTe0nsRXi2fsAek
 ysvjdr3+YUAblSBuXIDKeBvLoiTDt0s3nxepTbNp1+zZxCkQM443bX8aDciiVwQ2bWVdJkwSUsj
 aZ
X-Google-Smtp-Source: AGHT+IH3V5geDG7QetsRMJ1a8Pk1fouv29l1up5nWysSsWJVBYryHismctD9heJIbKy8QLTLT+Tk5A==
X-Received: by 2002:a05:600c:4343:b0:46e:1ebb:49af with SMTP id
 5b1f17b1804b1-46e1ebb4ab3mr12413815e9.24.1758621247687; 
 Tue, 23 Sep 2025 02:54:07 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f527d6cdsm268531945e9.12.2025.09.23.02.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 02:54:06 -0700 (PDT)
Message-ID: <b4128c1c-04b0-4c7b-8d3a-edc443789b29@linaro.org>
Date: Tue, 23 Sep 2025 11:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] monitor: Clean up HMP gdbserver error reporting
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, vsementsov@yandex-team.ru
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-2-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923091000.3180122-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 23/9/25 11:09, Markus Armbruster wrote:
> HMP command gdbserver used to emit two error messages for certain
> errors.  For instance, with -M none:
> 
>      (qemu) gdbserver
>      gdbstub: meaningless to attach gdb to a machine without any CPU.
>      Could not open gdbserver on device 'tcp::1234'

Orthogonal to this patch: interesting. This comes from commit
508b4ecc393 ("gdbstub.c: fix GDB connection segfault caused by empty
machines"). This feels wrong to me, as it is OK to use a jtag probe
to access memory or program a flash, even without any cpu online.

Yet another side-effect of use of the ill-first_cpu global variable.

Back to this patch description, probably not the best error example =)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> The first message is the specific error, and the second one a generic
> additional message that feels superfluous to me.
> 
> Commit c0e6b8b798b (system: propagate Error to gdbserver_start (and
> other device setups)) turned the first message into a warning:
> 
>      warning: gdbstub: meaningless to attach gdb to a machine without any CPU.
>      Could not open gdbserver on device 'tcp::1234'
> 
> This is arguably worse.
> 
> hmp_gdbserver() passes &error_warn to gdbserver_start(), so that
> failure gets reported as warning, and then additionally emits the
> generic error on failure.  This is a misuse of &error_warn.
> 
> Instead, receive the error in &err and report it, as usual.  With
> this, gdbserver reports just the error:
> 
>      gdbstub: meaningless to attach gdb to a machine without any CPU.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/exec/gdbstub.h | 3 ---
>   monitor/hmp-cmds.c     | 7 ++++---
>   2 files changed, 4 insertions(+), 6 deletions(-)


