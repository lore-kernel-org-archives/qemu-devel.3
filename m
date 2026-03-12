Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72D3106ACD6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0l8m-0008Lj-KP; Thu, 12 Mar 2026 14:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0l8k-0008LN-9n
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:52:10 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0l8i-0004my-IZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:52:10 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso1769155d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773341527; cv=none;
 d=google.com; s=arc-20240605;
 b=T34Frd2l/3lvWzenr+WB71Ss2I480+AY82ZvUGcR+wffPl9bKiLHaEezSKqRfJLKCY
 t0WyMPQbah/cqfC3FFij/+hu8Rl126TzUq2nintXnO6/Ps7wkGxVZ0hVFResxFL9DbMK
 0UDu37wpukrFZ0RZ9VploMjPQ4PHV4feYDB304ZMGwGu2ORga8zjvYuRQyqlxWQC3Een
 o3RqsPEYyCMTj7zc9+bjnbD40d8EshWZephkfp0xTgYMmdSud7UPsR3iaiIUwxElyz+h
 4jFOJyQIUlMZWtDwXBr/l/BB+X9te4ZbdQUfmVm/fQh0aScalALpl1DRB6vXTKN5JDRP
 LrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ldbDAsllC5EsnakuIxONVkJmtryfpmh9eJR6A4OvDic=;
 fh=V+cJCrcmHfk1hjMGitR5yugawEi3UN82KrpCYh9oF6o=;
 b=jiPEWgadKhbyXIuwYXW+Z98INB8qkWdzO67XSaTFTlp4vdMMZOda+pizOs60SoqaZp
 kD09/fpQJiIyjefpShtN/E5y4LeX1OftXmuimci8hRjLf/HGxT8f7MBtFz8HyHhBIV9A
 gjvApEwSLPsDYiJIdiu0MhVPv+4eEhKGjR+lEMfIHNG69LdG3OEjvCxOrrjmI4ziF2qt
 POhqk92VPJVyOe1l38LHbfRdd1rVDeOf8p7OEscObuAzi/0tkAt9em1XgpXPPET6vPUl
 3jfQ7z28hF6wAGjTvjT0MqAYkdffJJwP2pCulSAm2Wy0FdQ+z5wn4/Xzv//CY2uixvXT
 iyBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773341527; x=1773946327; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ldbDAsllC5EsnakuIxONVkJmtryfpmh9eJR6A4OvDic=;
 b=d7ETXrv0dyBWAHGNRDfx+7FLVjMVIfgJMLHEDzl3qVjYM3N85+FD9QHajgxWOvyIqc
 4qmEohW1S6CYDXoTTZFhbchLBtM6zMeQcTsTRFWe9vwQGlmjLNQdnPsW6SBvvLA5FNMT
 gOz6cXF5vCagfd6VXVd5a26TIZkYoUlMgiuJe7kDv6NsP+W6m8ZBLMfEzDzpL3k9hMHi
 z6WNPCnPSvkGf+6W3ctDi5aB5zU/Vp8z+U2OwyEntcSaqRhK4oNJuNHn9ukuB9G88igi
 MT3dL4yeDuC9wUEwKeXpGMxYHCkNSQxDbv1zSiGuAVVv9K3cwCg198m0IPiyUnciicYa
 UKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773341527; x=1773946327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldbDAsllC5EsnakuIxONVkJmtryfpmh9eJR6A4OvDic=;
 b=Kc90Dl/qhnoxTJBcR9M6m6gmsrErTvW2PywoB3yqjNEUV4alzs10L2yTrZPen6B5ih
 f1O0v+0Mm71mH/7tjwauDZWe6sl1sv7OAyTpi94yHkgRQYByQBB0W3c17mxLIRR+uIvy
 nql7OkX2Xx7nc6LlpRa02+KvmEMF1RNxQgjjJMhuYei5sDHyqXP8fsY25Ify6H3s4VmA
 sWcFVI0KuZChmxiWaqBiLDkoZ75RhdnSXTaTZ7WxgcDpPR436KjMD6LEvnQfyNT17AMo
 Q3UZw0FNlPTzYA3N9j1VB1TM6lPcJ6eXbrHTtw09QhQz3g8h+I/8eV/rXGj5GPM2fdpT
 4RiQ==
X-Gm-Message-State: AOJu0Yyu9TaLu1TFdCb5XVIezHaYVeiJ81pF6C6h2u/W7Ay03I+BUSbA
 y8C1TVYF2iiPH73jARObkQAEbtUi/XVj1qAlMOUgPQiDfNvMQ+wBdoWS/iQ2wAhn7km8XNwSvfW
 +twzUM6hDcZEYEOx2Hab6AKIRYYZJ0F/oYgvZjyEd1qKmEtb59KP0YGQ=
X-Gm-Gg: ATEYQzwUBg4XA+7W6pyb1C8cYApbSQ+w/sIIOJSd9poBZYc/v7jnb8Mahw6GRRfh0VM
 IR42AwWigheULfgYrZFDsp20K75i7T5bRLWX4s+s9wxCNAHlYHVDKcM/kkt9tFPc+Khjk9lws5d
 BCx95nab56W393bMzWKNKz+R9aElBSTFM0nJuAcXXLC8KgITxKu72YLWeLIdNsiYZUWbY4SAJLt
 KajKGHATdxioh1SZFy2iG5t1/53qJ631i/oVxq07J8HKZbc+xqhJbPUhkGqBcmQPMAEiJJ6aA0L
 gO0nNJDoSB0yzM0krR74vLKFMmkeAcWq7QuijGlsP8CTHjYWQs63DwpZE8U/WCB2JO8=
X-Received: by 2002:a53:cc91:0:b0:64a:d311:2cee with SMTP id
 956f58d0204a3-64e6310c257mr489023d50.89.1773341526717; Thu, 12 Mar 2026
 11:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260311183432.214960-1-viking4@gmail.com>
 <20260311183432.214960-2-viking4@gmail.com>
In-Reply-To: <20260311183432.214960-2-viking4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 18:51:55 +0000
X-Gm-Features: AaiRm51pfVFdRELKQGU8oa084X46tV0zxjrldoG7W92PJLb1kJGC4-hhBD6UjGA
Message-ID: <CAFEAcA8D1f4hapWS5nW9XQqNTBYVmxbq5ipi16gbFDBHhRqgWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] hw/core/loader: fix error handling for
 load_image_targphys callers
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 11 Mar 2026 at 18:35, Trieu Huynh <vikingtc4@gmail.com> wrote:
>
> From: Trieu Huynh <vikingtc4@gmail.com>
>
> Use QEMU's Error API to handle load_image_targphys() failures
> consistently across callers.
>
> - Use &error_fatal for callers that previously passed NULL, ensuring
> the process exits early on failure instead of continuing in an invalid
> state.
> - No functional changes.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
>
> ---
> v2:
> - Use &error_fatal instead of manual return value checks.
> - Remove redundant checks for ppc callers that already use
> &error_fatal.
> - Note: This replaces the "ret < 0" approach proposed in v1.

Hi; this patch breaks "make check" for me:

  13/1040 qtest+qtest-m68k - qemu:qtest-m68k/qom-test
           ERROR            1.35s   killed by signal 6 SIGABRT
 113/1040 qtest+qtest-m68k - qemu:qtest-m68k/test-hmp
           ERROR            1.36s   killed by signal 6 SIGABRT

This is because these tests check that every machine can
be started without errors (when run with the 'qtest' accelerator),
and now next-cube cannot:

$ ./build/clang/qemu-system-m68k -display none -machine next-cube -accel qtest
qemu-system-m68k: Could not open 'Rev_2.5_v66.bin': No such file or directory

Where the machine init code is calling load_image_targphys()
because the user passed in a particular filename to load,
then we definitely want to use error_fatal. But some of
these cases use these codepaths for "try to load the default
BIOS filename" and rely on ignoring the error if it doesn't
actually exist.

I think of the machines you change here, only next-cube
has this issue, and that change has other problems:

> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 26177c7b86..4bc8e72f3e 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -1326,7 +1326,7 @@ static void next_cube_init(MachineState *machine)
>      memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
>                               0x20000);
>      memory_region_add_subregion(sysmem, 0x0, &m->rom2);
> -    if (load_image_targphys(bios_name, 0x01000000, 0x20000, NULL) < 8) {
> +    if (load_image_targphys(bios_name, 0x01000000, 0x20000, &error_fatal) < 8) {

We were already doing an error check here, by looking at the return
value and insisting it was at least 8 bytes.

>          if (!qtest_enabled()) {
>              error_report("Failed to load firmware '%s'.", bios_name);

We could if we liked report the error to the user, by passing
an Error* to load_image_targphys(), reporting the error if it
is set, and otherwise reporting "file too short" (since that's
the other reason we'll get here).

The reason for the !qtest_enabled() here, by the way, is to
get the "report this error to the user if run in the normal way,
but don't report the error if this is one of the tests that
is doing the "check every machine can be started" test.)

>          }

thanks
-- PMM

