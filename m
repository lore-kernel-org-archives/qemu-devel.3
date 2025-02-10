Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C408C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUSb-0005Qu-EI; Mon, 10 Feb 2025 09:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thUSW-0005QR-IH
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:08:24 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thUSU-0004GR-O7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:08:24 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so3826095276.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739196501; x=1739801301; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xMydYF9T098euIszM7ik4JTCZxbWbtFNiTuzagikfbM=;
 b=tG+XLSG7m1DfbWVdi1ZOz/ybfbmNHh/SmbR5fsxcQTcGRNy9S/lPHsX9OJARp3Nfcv
 oeZfF9kH6uxPxbICLfmm/o40ElqrAhPF8avSJTRPb6ErRi8hP7kkGef8uVuvFCCOAK27
 +9SATE19/vwvDQep2w1GTGPQLWQ524j2jMf0Ek2F5iVn3AaHduk8As1NIKI6Wo/hhB7T
 sHfoVxn90QJNhBJsOImFyBHwzD85T4G4X5N24Djg0brqXEiMHT5mk22+fsQadi4KpHpe
 roRfgYL5onfawW8oJaGe1Uy9NXeZhV1gnpcANIHhgU7emn4dOQi+d0m3XaNX8GADGfcQ
 d6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739196501; x=1739801301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xMydYF9T098euIszM7ik4JTCZxbWbtFNiTuzagikfbM=;
 b=RJHqwwVn0yg9hCNqjmC9A1PqmDArBIYXvrUvzJIMjtL5G5Q+2qVw5nOMP6fnmUMScb
 V6bZiykjVE69BP/Yq+tipko6Thjk6x4ZAnif3LVVd8RIPqxUkuQVTptUxNbcLjwAZhE5
 ENN2/on91pFDNH5pcJWTEErR/LWV5FfDq1Zm5gIQ+pxMnorwD1MwaVczl6AZpUJBhm4l
 Xeb+E5iLnPmEnZ/1wvcK4LZ8JFb2HraUQRyHENsIe1I0VBC4GvyaAr03Gi6DE5UVoxKX
 vP2UoYy7EC9P2WsYDkqJXs5JyeXMVDCp2nx/An6Ny0DjfPmWTEF9gh8zz5lX5opyZg/z
 OWPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzKK4n+jiOjUDolK2G3uWZVG5KyloK7Bsbd99TymgFCsa5PHmkqhwXY9pCaPpUU2B6H8fBAiLvExWY@nongnu.org
X-Gm-Message-State: AOJu0Yzy/PgUFqYLslE6jl0GpM13Vg8DdYWYTDjI3vZ5QaE0m1Yk+SP2
 cnRRgOlXnOGwm6ZIRdE74s6d37NCtBBjyYHuT06K6ecHiUG8L08h/HpM67cgUpDUwQTPjK618U9
 jKgD+8gGSfzQKU7nv/QYLo2aXL7TBQnQebXJjZw==
X-Gm-Gg: ASbGncsNYLMuRL7CF9HKPOdq7VcdJaOe2ybII/LuQ/oWgGaZxWEraUm+XuAGdpzvEwl
 RmQFOSghjiRwTNQqm8PRW9sVFgkCBg3TO+uwnKvwnrtmMAUhxyHws4426J7/zn56JZUa3BaosKw
 ==
X-Google-Smtp-Source: AGHT+IGYtgvlbMteA8OshRfdmMAGYPL2A88mFNDr3gV4EUJ+eM89dSqUEk7RN5fsm6T9auPUoV71FAGHZlyC9MRddj4=
X-Received: by 2002:a05:6902:170a:b0:e57:fbf0:5016 with SMTP id
 3f1490d57ef6-e5b461c3280mr12034195276.22.1739196501416; Mon, 10 Feb 2025
 06:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20250210135804.3526943-1-peter.maydell@linaro.org>
In-Reply-To: <20250210135804.3526943-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 14:08:10 +0000
X-Gm-Features: AWEUYZlYGcA3eOXPzrsb89SM5uWj_mQXJ7tTOfjEylXNA0MUkyl1g0cGYJ_1XAY
Message-ID: <CAFEAcA97TpSfRVpNOg025GMw3pduR+73gr2LDmncoCpTDfV3jg@mail.gmail.com>
Subject: Re: [PATCH] util/qemu-timer.c: Don't warp timer from timerlist_rearm()
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Mon, 10 Feb 2025 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Currently we call icount_start_warp_timer() from timerlist_rearm().
> This produces incorrect behaviour, because timerlist_rearm() is
> called, for instance, when a timer callback modifies its timer.  We
> cannot decide here to warp the timer forwards to the next timer
> deadline merely because all_cpu_threads_idle() is true, because the
> timer callback we were called from (or some other callback later in
> the list of callbacks being invoked) may be about to raise a CPU
> interrupt and move a CPU from idle to ready.5A

(oops, stray editor damage "5A" at end of line)

>
> The only valid place to choose to warp the timer forward is from the
> main loop, when we know we have no outstanding IO or timer callbacks
> that might be about to wake up a CPU.

This raises actually another question: should the call to
icount_start_warp_timer() in main_loop_wait() maybe go after
qemu_clock_run_all_timers() rather than before? (Haven't tested
whether that breaks anything ;-))

-- PMM

