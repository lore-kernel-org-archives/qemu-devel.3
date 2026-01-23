Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5A5D74EF3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJSZ-0007zQ-1y; Fri, 23 Jan 2026 10:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjJSQ-0007x1-6W
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:52:24 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjJSO-0004X0-PV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:52:21 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7927261a3acso26223897b3.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:52:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769183539; cv=none;
 d=google.com; s=arc-20240605;
 b=Q0Y4vCcAzX27TkJFDkgwYyl0uHTIC8HYoj5ZtJkM1PIh1j1wr2ucJ+t/Ge8g2bxPHH
 TLHo/bSWFhG9iPt79wD1GoOAz/QsXcT6XKumWqOOTY0iksRcjHGUA47rgCf6gKMIfrX3
 EvdcnO80+ROpKQTkIzvD/QBYGdO4CaFZqNz1oyaDprEa//yZOrRkNj0R3oj+URd/ioqf
 bjHXWXDjw6OxRCacryY/oKfkaFP3Sn025XcnKUxH4oLbG8zS0f5wLxj01uCf6dExV2y+
 xzmePnjUMnOte/1yl+xx5kE8f2UZpkuZIOJiyS51q8xiDlQ1KWemtC3guaE9vfHLvbsH
 NPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Py6OOOe03sGrUA6aLICoMpiuus4jx7uTMb7a4QEH98Q=;
 fh=vlPiiGePwvhUEOSQUmpdTQQ6CFGVwDWhikjqNfuem50=;
 b=NrcwTMzSLmXmK9HF5JF/47Z8euczt3W9Tj69vDDqTJTJ92iBQuI50O8VJhny7jSU5w
 DaFZe0oZYsOltp/QP0gDGwmiY3v7LWhHv4lTZdj7mnMwAEZE9UdPbH/MY0Lw8hRoOKeN
 1sBXA9vQoAHig5V+fIqsDotOGUqakZfsDv6utGhllTrrK9wHkCzPhuZNscxq/YjvFRp0
 33dKjX5Eukusv5Rp7MVo7qxjp6a0V3j2WHdwLjVu6WtpNsftgVEB5hKvxFRI3uLlsvbS
 fAHScHvAVzO5a7Yamw6TwZN/9CnisT2LcOpVuqk19GDVoO4k6Fvmo956SPeeZLcM23LH
 Fs9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769183539; x=1769788339; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Py6OOOe03sGrUA6aLICoMpiuus4jx7uTMb7a4QEH98Q=;
 b=q4N8PEroPOdn74yZ0wZshRfD5kwc9tsMJ44O13AzSmRTWshxcnQb9yAeYTazQe3heq
 oMvvpK9QddXXO+R1Kt3+k/lbhtw0vKfk44O163PAV7OQ1poTGyWrHJEK+G/1Lj0tnZn3
 wQixGoGsHzvfp5KT6VvS1Y5T/TuD4cmTYMtccKyGreOEqfy66yOexe8he4hC4nrMNg0O
 H+FSgsk5VKrnyPh9H6H5o8HgDbC6dByI5mZjSbGCQTnta9kLuJoN5ZAEobeIN8ENdNQJ
 jK+b5zc/64eOc9yCH3ATevA1Nm9LPcYp3s2o7sjJqxOfMzdmnn65G1EKZ8VDML7lhjX4
 ezGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769183539; x=1769788339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Py6OOOe03sGrUA6aLICoMpiuus4jx7uTMb7a4QEH98Q=;
 b=QzRgGe6kOSu+wBYPd8LN/zfK6ZB6DjIHQ8TTskY+WTbWabncPRaEkeyTSeuE/g2FQy
 Os54DajPjH8Q0m2U9RdEXaeW+eh96+KSZkI++69e6R3TvZuww2sp02Wvsr+pA9HwU1GB
 WgFaRHRt3FxH40UdEfxSh4A8b0KQT+t7viljNbYhbfTw3GH7E36VauB+tAZjg1bIwKtp
 sv1nw0IqcHScfh5KoRPwoCbCciVNI+AXFQUerHpcCG+dLsWElB8/edT7U4Y8+hTvqyIy
 9CRnXpHbAOsFz6wv/tyTJ62Qt4m3V69R6P/VhuwFtr40BzbJ7MtrKUu1zfykcCKNJVZY
 Hv1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0HGASl4PBruu4TBdZ3OB5XeQLr1JILMQxZPUUZ/rQCNy5ik4Hukst5d2duwVCT029zM4EsGIUHlHD@nongnu.org
X-Gm-Message-State: AOJu0Ywp89LkPMFZleuQx0jyGiXpaeVHAS+atWKytzIE+gIkn520hKAD
 cif0FOg4UaiAeg7V/W9vq/Tr/967fL6mUaHQrQB78GnYMph+hc8G4/12litUC838dQUJf6d7FRO
 BisnLYuaLZrL0djq6NvndoF66eYERwP5g2CCUz44ccw==
X-Gm-Gg: AZuq6aLLM6e1UoZ+d6587N7LCejggov7DGjZWEXjj9CZpGnyPGu+ORAsjcqhlaL45+E
 wf0zXQhD/pZeT9LJEltpf0dJMsRM2pitNhh3dKdiRkTDh6s4XAMDvJ+m+h8rN20T09x5o8zFk0B
 LUYvHahYlxgKovtiJeJzaLgHu//X/98moNeO77g3RBJZRiqCOZN1TnVpH4bP69jxg60ypcLibon
 ng70yWjYcyZHizXLnq9WR4I5aiCO8NisNf617G6rzWf3I06Kv1773Hx3P00levVYIK5kQ==
X-Received: by 2002:a05:690c:f15:b0:794:1f9d:4004 with SMTP id
 00721157ae682-794398e5c9bmr27889207b3.16.1769183539562; Fri, 23 Jan 2026
 07:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20260123150921.17891-1-deller@kernel.org>
 <20260123150921.17891-2-deller@kernel.org>
In-Reply-To: <20260123150921.17891-2-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jan 2026 15:52:07 +0000
X-Gm-Features: AZwV_Qg0D1Y6bDG1U8vQSxU0T_RSjdIasmdpZd613AeIS5rLt_scGTSmkKXoG5w
Message-ID: <CAFEAcA8ZjW7y4nueS_UHs=jPqE5SWUhnXk-kECZnmdZcLen98A@mail.gmail.com>
Subject: Re: [PATCH 1/3] linux-user: strace: Fix 5th argument of futex syscall
To: deller@kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Fri, 23 Jan 2026 at 15:16, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The 5th argument isn't printed, but instead the 4th argument is shown twice.
> Fix this, and print the FUTEX_BITSET_MATCH_ANY string constant instead of -1
> if the op is FUTEX_WAIT_BITSET or FUTEX_WAKE_BITSET.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/strace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 18bc6c800c..ca67cfd09d 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -4150,7 +4150,12 @@ print_futex(CPUArchState *cpu_env, const struct syscallname *name,
>              break;
>      }
>      print_pointer(arg4, 0);
> -    print_raw_param("%d", arg4, 1);
> +    if ((op == FUTEX_WAIT_BITSET || (op == FUTEX_WAKE_BITSET)) &&
> +        (arg5 == FUTEX_BITSET_MATCH_ANY)) {
> +        qemu_log("FUTEX_BITSET_MATCH_ANY");
> +    } else {
> +        print_raw_param("%#x", arg5, 1);
> +    }
>      print_syscall_epilogue(name);
>  }
>  #endif

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

