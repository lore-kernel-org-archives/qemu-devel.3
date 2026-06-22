Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31779CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbggE-0003ci-4d; Mon, 22 Jun 2026 11:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbgfx-0003U0-9H
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:35:05 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbgfv-0004Pl-HL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:35:05 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-660e9ff0587so2462695d50.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782142502; cv=none;
 d=google.com; s=arc-20240605;
 b=VNBDX0eT97i4A/N3rCbdadW77GG/3lmZqcaAKBFqb87SuKjsZqbdHZdy0ndMBJ4bzz
 bvRTUuDhCe39QvOb3KnnGnIgBBdE4oEtrLE3eYPul15qUpOJYhthsKnxUZckIO9x3jC8
 tohEwNl7vpvU270KE/Q8Go08EGLKBrm9jSVcHkxzzdx1KDqaFdJvihJrStax/YhdbMAT
 jtr8qBYE0wvO9KQ/UnpgzOTfvjD9rv7xoAK0V/XhAjptXhH4frCNjXYZ2/VU12obHzs2
 6tJ+lsHm+4hOpEqypqNY5k1PrP+VSjjNA/MQoDoL5ChAZH7cxdxmMfad1ghBOWnAOb1K
 RYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XnJFClG0+ifr/1YPJ413D2fJmer+mNxQYv7QXDhif/k=;
 fh=E4+ktKk/Irnu4jYXTzXXyfaxzHVWXmRvGxiRnTEcMes=;
 b=EONRgf+eo7G2efy8q1vyGX+d7CzhaSz5cnlvVd3Fm5RUzJBq02WBAWOijH4/i+2lM+
 ibOgfjLgPdloo8CRgaD6eoJxE11L/okc6EgtZt+62+jkSh5r+nt6FSwofMsHh2XW/F+v
 l9YtjPJ7arcAGrgdLc9dCc73Gdd1VILxN22+UzWMkn1IzF/9AxzPyuOh7V/rV/uwZNMB
 Kes15YJOs/jf5O5efCefCN6WDg1TehBOOWbi3nxsonlofWwQIUd6M2JBddRA1OuEBD6i
 NT10uP+naT+l4HSc0E6dS/2JNwJuuBpwjnoSNwbGB6PH+Ft2c6jfRnq//tAWziwhC3D/
 GJww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782142502; x=1782747302; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XnJFClG0+ifr/1YPJ413D2fJmer+mNxQYv7QXDhif/k=;
 b=rtTsNBXZCzekmYluBRcmo4Ers6lPStPm9Gng8G6jNjTIXTXmr9iySX+jCIWWndHq63
 xHNmJWkhBtGRyv/cpjeW+vMNR8FwvxQVfTncTGmv5UdTne8xdZ6LJDtJy/7D0ecyECxs
 P4abnQWiapcqwhQS6e7z3h2MyzPFBBjQxYx1ypF07AtXtXnvxorWNLx2qncpnvAtd0ak
 SPcWMoBLLGkKaBfC2hIJRjK/rUxK1CIc2kZWqz6ihKk2EwtmhSXYSrdoLKhtUBA/Nb0s
 VBCyilGHcLQpd7kGipijb9ovz4cx0EWTKKAjDm4a5eBlfujEiVt67caRhCukjzq2T4fV
 xVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142502; x=1782747302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnJFClG0+ifr/1YPJ413D2fJmer+mNxQYv7QXDhif/k=;
 b=X9UyGkfJ498orh+J25K3cZlB7rR/d95mvmfIEnhIIEdS619DKcVBn19gtGyHYvFef3
 q+tWzn3enbuH840KAsF5Sw2y+wlL4EMxD8UoXD3uOfxjA/BlJDjJ+CLm5l6BTTDvWfsb
 RAU2hLy5xg7lwf+wJZxfjJCdtR/gbh+2f99OdcoMjr1AqdaKxJGhmmcGCmUYskM58/lG
 2IWRmu3bDEJET55YU53vx37Mcm6AAoq88WmwOITx06EKKtu+8t0EqQ6QboJ7UUWxMsdv
 iqtBgsAoOwKCrL360joopHa/m4EzXt8KbmLB3TlQp/VW6zXtl5Eh86qzyrkLIkOO2BwM
 /A2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RocXky11A+WCBAUdIEPWuVKktOjkxG2kwNmgNCjlAghwvSG53XwYMtKRCL6kL/AlLDhtRWRDKyiWDrV@nongnu.org
X-Gm-Message-State: AOJu0YzoJyqt7jIemnsnROZpM64RMZgNYcFQva94ThyFlrMyhBQFH/jd
 t4C16oTykz8jfZr6VxRr4SP9lApMKlAgE8W3D4XpaRGdUBbmBxwA0HDONB8zGdH2SPyKTjvgMfr
 eUb4ngehn5BzlZqC5OVmvxEe/6NUK21uwx05/I2jbfw==
X-Gm-Gg: AfdE7clU5i99GydOpf6glRzR3vzQ+YptkHFMuK3OPCNFSspZIP6x/EH8i7fgL6R7V8s
 NeltQvay0IqN/3ou3GM9qV7wD/jSv8SCG3mMQrcSGAYZQHKWXz9+nhgSpPV039LKllWGBvebyT2
 7wKNwWoXaGLGj/+fmSbrb4fBf8l+9LA77tnQhWTi+130WQOF1LHwANMPM75o1a5fZnNmmoaYcK3
 iCKHe6Ri+zgt/hVRp19pUVFYHHcJiq4qdtVhMtxfwK7iHzvFCnh+2ThfITe0o93LdUpSr7qaylw
 6sEd4rWltyX42gNR56y34Tk6QMkANkd9arW3T6v1+DifSSCx0a+kHn9d
X-Received: by 2002:a05:690e:11c4:b0:663:1161:cf49 with SMTP id
 956f58d0204a3-6631162052emr10979888d50.46.1782142501690; Mon, 22 Jun 2026
 08:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260610164549.5699-1-deller@kernel.org>
 <20260610164549.5699-7-deller@kernel.org>
In-Reply-To: <20260610164549.5699-7-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2026 16:34:50 +0100
X-Gm-Features: AVVi8CeN6gK2IKQmoSJjWCEbUGcK25E_W_NWXS_YNxA9xJ8TXaQ6SQNUVQ5ccX0
Message-ID: <CAFEAcA9To_qhKCF7ebsrDRgB5yQkmRdSZG+x=e+_-0C=XDYLCg@mail.gmail.com>
Subject: Re: [PULL v3 6/8] linux-user/sparc: call block_signals() before
 set_sigmask() in setcontext
To: Helge Deller <deller@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, 
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Matt Turner <mattst88@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 10 Jun 2026 at 17:46, Helge Deller <deller@kernel.org> wrote:
>
> From: Matt Turner <mattst88@gmail.com>
>
> sparc64_set_context() emulates the kernel's `ta 0x6f` trap by calling
> set_sigmask() to install the mask supplied via the user's ucontext_t.
> The contract of set_sigmask() (see its comment in linux-user/signal.c)
> is that the caller must have first called block_signals(), which sets
> TaskState::signal_pending.
>
> Without block_signals(), if a guest signal is pending-and-blocked at
> the time setcontext is invoked and the new mask unblocks it,
> signal_pending stays 0 and the post-trap process_pending_signals()
> call in linux-user/sparc/cpu_loop.c never enters its while loop, so
> the now-deliverable signal is left undelivered indefinitely.
>
> This affects programs that use getcontext/setcontext to swap signal
> masks, including libunwind's unw_resume() out of a signal handler:
> without this fix, the test program below loops forever printing
> "calling setcontext" instead of delivering the pending SIGUSR2.
>
>   #define _GNU_SOURCE
>   #include <ucontext.h>
>   #include <signal.h>
>   #include <stdio.h>
>   #include <unistd.h>
>   static int got;
>   static void h(int s) { got = 1; }
>   int main(void) {
>       signal(SIGUSR2, h);
>       sigset_t m; sigemptyset(&m); sigaddset(&m, SIGUSR2);
>       sigprocmask(SIG_BLOCK, &m, NULL);
>       kill(getpid(), SIGUSR2);
>       ucontext_t uc;
>       getcontext(&uc);
>       if (got) return 0;
>       uc.uc_sigmask.__val[0] = 0;
>       setcontext(&uc);
>       return 1;
>   }
>
> The 32-bit sparc do_sigreturn / do_rt_sigreturn paths already get
> block_signals() from the rt_sigreturn syscall wrapper in
> linux-user/syscall.c, so only sparc64_set_context (invoked directly
> from cpu_loop) needs the addition.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/sparc/signal.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
> index fda5508c48..ba692c3123 100644
> --- a/linux-user/sparc/signal.c
> +++ b/linux-user/sparc/signal.c
> @@ -619,6 +619,15 @@ void sparc64_set_context(CPUSPARCState *env)
>              }
>          }
>          target_to_host_sigset_internal(&set, &target_set);
> +        /*
> +         * set_sigmask() requires the caller to have first called
> +         * block_signals() so that process_pending_signals() is guaranteed
> +         * to run after the mask change.  Without this, a guest signal that
> +         * is pending-and-blocked at setcontext time is left undelivered
> +         * even after its mask bit is cleared, because signal_pending stays
> +         * 0 and the post-trap process_pending_signals() loop never enters.
> +         */
> +        block_signals();
>          set_sigmask(&set);

Hi; Coverity points out (CID 1660058) that every other callsite of
block_signals() checks its return value and does something if it
returns non-zero (indicating that a signal is pending and typically
that we should return -TARGET_ERESTARTSYS to take the pending signal).
Is it OK to ignore the return value here? If so, saying why in
the comment would probably be useful.

thanks
-- PMM

