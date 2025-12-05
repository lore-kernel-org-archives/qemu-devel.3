Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775B3D32D62
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 14:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRX3S-000200-U1; Fri, 05 Dec 2025 09:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vRX3Q-0001zl-7m
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 09:45:05 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vRX3N-0001yk-K6
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 09:45:02 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6432842cafdso1945233d50.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 06:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764945900; x=1765550700; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BjxtfHT4xz1xk6ih1qyrbNnTXa1K0Qn5l7NXue+n1A0=;
 b=FFz/OdHujPaq+bUB5lWLIcSUQMTJSriTBbiYG0N5nszpyCKBxMO5T3aZujTTEYlAio
 vGe/q1tSj6M6SAuCRh4KAZuwNKGXcNTvM8wztKfaqGx5SvS4BHR9q1JslaXhMJ6nqKsz
 r5X0ZD/cZBi+fy8Ab3X8cz9qbd/qaPpjpjsSwEvKbBNPb1msH6bGFxVbL9YQ4haKn2ew
 v7oXqD4f8cG8RPz0ngq5E3iO9DvRDaHWYUrJcN/iP7kjbnLe+DlNU5U0JcwaXX9+OWym
 58L5fBITLoNRxxg6dp77s/IITr9hA39JsK3SJpXQsGuQRPfXn3yftFPf9KEwmvqzVUE8
 352A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764945900; x=1765550700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjxtfHT4xz1xk6ih1qyrbNnTXa1K0Qn5l7NXue+n1A0=;
 b=JXwB+xHewZMuXJbfDDd4ttGXkqnjg8Lwe2HLo7cUQpdvfTkMVrmp6+/VwfEv3lAKL/
 G1tCnP7weA/LOU0tXOXdh0C1DiST3fB1QH/OGx3aHgMpzTwzbg7/cR1dPvPC9/v6/JAr
 rziDgvLZh9IxyrtY5xC7NUMfjCakr14ROpbxIVzG+E/hPJ07PhoEvE0h7DZ2VIjxZ4ux
 GTi7LSWRt2I3BEKmwDnGUswSdi7I3BtvW/5PUGZx63A74uLEJaRK7JOi0Ooq1UKkn5ko
 joCUEcutT3EVij1X4/MY05yJRKAEy1rVImHsJreAYD9Y/uY0X4RrdcPNYBYQKTgr6b+k
 A8xQ==
X-Gm-Message-State: AOJu0Yz6Ry0oALe7qYN3y7gUiqzYuLd8GeOMfyrUxSFmQMeDGLeB1t8F
 G8cUT1SEdTpIt9pY3IHddu0E49rR+mUKYWM/MKFmuhpupPNK3tQTqOr68SmvQaDfvuztsBd1EBJ
 xjc4QzS7tNabnt3a1KpufTvpPp8uXudQAlJ014XBNgAG+kdEjhCkNr94=
X-Gm-Gg: ASbGncvETQ5Kap5hE3tUELJH48UT6S1xhhSClfNAVMHRHLq7t1Hlk/GWLsOEdZhgQ+i
 RiF4cMFp+aLluCsNWjObngYLnrZOfz+6ipNOpSTVDe3gnjHDGRKcekQkhUdVzAjL62PvqYgNrAd
 pwMwZGV35ZFQpnDuM44j6qa7SEOneRc8IrOSuM/fjm77MUoM/q3ysLu3ZK4E5bYzu4fxdFJNz3H
 c9rHhaF+EzVLOCrD1gz7f5TzOvmk2LkJvdw/Y5mfk22RCS4GU+Aoa9Yf3nEKyNjovGoAkL4
X-Google-Smtp-Source: AGHT+IHHLuomsiTLiotBypV7gZQUviA6YV7Ci89ZTbqI7HXbnU3+7xfxYi6srdQLsVVONFM7/Wpn7y/kthUtl7c7/sU=
X-Received: by 2002:a05:690e:120e:b0:642:1d3:adf5 with SMTP id
 956f58d0204a3-644370394bemr7260244d50.48.1764945900152; Fri, 05 Dec 2025
 06:45:00 -0800 (PST)
MIME-Version: 1.0
References: <3d73bcbc-d3f0-4271-9f99-d53fb5a85db6@ksl.ci.kyutech.ac.jp>
In-Reply-To: <3d73bcbc-d3f0-4271-9f99-d53fb5a85db6@ksl.ci.kyutech.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Dec 2025 14:44:48 +0000
X-Gm-Features: AWmQ_bllnWx1htotPYmK686nGlvGtXqpF4Lrp1yNq-OzH2OQRBTx2WI5_yeu9xY
Message-ID: <CAFEAcA_XNdUDFLojnqYdsBqh2jZyg45ds9wJjiS9ujhPnX2z9Q@mail.gmail.com>
Subject: Re: tcg: Requesting clarification on return value of prepare_host_addr
To: Shusaku KURAMITSU <kuramitsu@ksl.ci.kyutech.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 5 Dec 2025 at 14:27, Shusaku KURAMITSU
<kuramitsu@ksl.ci.kyutech.ac.jp> wrote:
> I've noticed a possible discrepancy between the comment and the behavior
>
> of i386's prepare_host_addr (located at tcg/i386/tcg-target.c.inc, line
> 2157-2260):
>
>
> ```
>
> /*
>   * For softmmu, perform the TLB load and compare.
>   * For useronly, perform any required alignment tests.
>   * In both cases, return a TCGLabelQemuLdst structure if the slow path
>   * is required and fill in @h with the host address for the fast path.
>   */
> static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
>                                             TCGReg addr, MemOpIdx oi,
> bool is_ld)
> {
>      TCGLabelQemuLdst *ldst = NULL;
>
> ...
>      if (tcg_use_softmmu) {
>
> ...
>
>          ldst = new_ldst_label(s);
>          ldst->is_ld = is_ld;
>          ldst->oi = oi;
>          ldst->addr_reg = addr;
>
> ...
>
>      } else if (a_mask) {
> ...
>      }
>
>      return ldst;
> }
>
> ```
>
>
> The code appears to always assign (in case of softmmu) a label to `ldst`
> and return it,

No; if tcg_use_softmmu is false and a_mask is zero then
we will not take either the if() or the else if() block,
and ldst will still be NULL when we return it.

This is because:
 * softmmu always requires a slowpath (because we might
   look the guest address up in the TLB but not find it)
 * linux-user mode needs a slowpath only if we need to
   enforce alignment and atomicity checks for this
   memory access (because linux-user always has "guest
   address == host address + some constant", so most
   simple loads and stores cannot fail or be complicated)

If we don't have to do either, then we don't need the slowpath.

> As I understand it, there is no way to determine, at this point, which
> of the two paths to use;
>
> the generated machine code (see L2233-2237), not the C code here,
> performs the TLB comparison.

That's right. We are generating the code in this function
to do everything except the final "load/store from the host
address" part. If we're using softmmu that includes all the
code to look the guest address up in the TLB.

I think the way to understand this function is to look at
the functions that call it, like tgen_qemu_ld(). They do:

 * call prepare_host_addr()
 * call a function to generate a plain host load or store

If the prepare_host_addr() code wants to do an out of
line slow-path, then the code we emit looks like:
  - do stuff to figure out if we can fast path this
  - conditional jump to out-of-line label for slow path
  - fast path handling; at the end of this we have the
    host address for the memory access
  - host load or store generated by tgen_qemu_ld etc
  - and then fall through into code for the next guest insn

At the end of the TB we will arrange to emit the
out-of-line label and the slow path code.

thanks
-- PMM

