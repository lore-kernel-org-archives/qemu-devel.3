Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4379CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRdHs-0002CA-26; Mon, 25 May 2026 17:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdHk-00020g-Kh
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:56:35 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdHe-00077V-Tx
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:56:28 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5a40cfab24dso6085582e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 14:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779746185; cv=none;
 d=google.com; s=arc-20240605;
 b=HsLtmkvaUyy3dvBzrCl5vz6NgS75QLLMO66kugANxpeHTO5NEPlJWUdMKkOOg/c4SC
 kKnZiVUMwNbotbIRhhTOoUddz3OHe7kKchB7X6w320ujCasDWlRoIgbwLWJ0uSiV/U8B
 5eECSPZK5VgZNaMPfiV9h83lIt3XjGTrx21xyICEsUIpm+Ho4nC4QAIfBtpphGLTOMs2
 mKeCPEQtfw8Q1HPJdu/nAEQV+qUixYbktlLDTi/dWY5HZ+ayQgP4n0CO53U6w5EAYWgx
 2wqSovzI/R15qkM8+wTAl9MIViG5ixuEiQtSh9iNOxsQq6wOMf+awmNng8c8ds+aNod9
 DUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zoUOUpW3E75Pe/cwgLThJIq3RQ6h/mAzS46vXJVSYdo=;
 fh=VDGqiENZLmjMFMZWY1xbVB15zxWtxE1H+z48zMSi81E=;
 b=IiRzFnNb9NLqpbOF36x33MtdsLWcjIQot42BiBPltlSbeVciX1tSlv9g/OVdHZJjUg
 DJiqfbrNtWzd7fQ0ZrIzEMS/x2G4IAsZnaxTnuycdi05jR2+sJFa3zb286KzR2Pok7rt
 cRtUX5v8WCH4+faWJbNFDHFHP1ywSs9XZwlzoRPlgBHFktgNHpj8+N015fqGSByHfPPy
 5OTzZhl+920eBB1+dggMTsqXRXipZk0kW8YDBIezcrL2kqoQoqoIthtHH+1YC3boZ/lN
 /RrBKQMowPP8LDN8h2sn9anlzKXceCSRGpXtBAAqy3AsekdehbT9NATMGMJgYDqi2b7L
 JeAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779746185; x=1780350985; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zoUOUpW3E75Pe/cwgLThJIq3RQ6h/mAzS46vXJVSYdo=;
 b=m53xYrNAa4ZWYx4HIXAYgHT7OeiH3qJOHoBpWdyvOWEotM1UaqczjhsVPbLeG6YlpX
 /sCy5Ko3D4k5ep5EdpP67fXK6tm7T4u3tkaUbH9kgRQFGNkOlo62OLi/LA6LpNrv1msU
 fnyJDaYm5ds4SBjruTLXR4OY5YsFN7P6j8cWm39qqJweEk49gu73tdctzRNJTaZ8mpog
 Lq7HThxfVVUocwVtIXOB7N8nGLs3lsiVM32u8WjJkt5FCKDX88JaC07uZRxguJwD6LnI
 phRzzCc5vY6A1eBEX/ikcjwr9QQPa4qv/SFjubn/0GZXC9oFXBTYomJ9t3NzvzBFI+TA
 r3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779746185; x=1780350985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zoUOUpW3E75Pe/cwgLThJIq3RQ6h/mAzS46vXJVSYdo=;
 b=Yr8WcRzt474fwINe77E2EYRCnbzDmT7zk9tePfpbpRRgoHPXNY/3i6i9GOJmA+5ssT
 rsubVmelcJzdRkK4soO4j55pNYi2CSHGWRua8kcrb1h5NpJAB1dawYsHbp5L45ofGUfz
 7+HBc+i5hl66Rz7tsfeQaaUQikV+VGNke2SIzjn296hMOMMR34nexo6+8a0OarBLDrJI
 9rocrMKCLcvP4jNcwiKFHGIw8gowrYwBZHDMkt1kYHxBHHReS9WZdKUgfWkQ1ufX4wEE
 nFhFXOJ+tG0+lFswMMC0oY2+EBie+ZITtv2F7MZ4hbqBYC0jtX16VnuX2X8uvYyAzZBC
 P0aw==
X-Gm-Message-State: AOJu0Yxk4RhstIRnWzKtJo6B3BUnchcVPM2hv9d73BJfUoNYC4r07LE0
 kF6j2WbkMUcEdC6+7wP7iZ6hkcMqGbMGKKSQBAv9fBpqh6Y4FP8b9Ra570Af3bx6wIEq1yaTiA7
 SPd3GRi23L6NvR0SDm6dhNACSnSdGby+qQNiNIhU=
X-Gm-Gg: Acq92OHZWW0KI45frOsEv42+VwbbruNI9xcYZxs44mugEneEIdJnngin12+cb/dkSa9
 bOCqlEzpI4pfim1xnMu7w783f4C6enk7YsvXbB0acsoStBCTVocos37Ky6ehSXesIdquc52p6GD
 tT/AjT7Aw7oJA0+/JXAKD0u3iV0rnC8r5J443VjyEB0sSUH0yKMGmTi5AgKZ2H0iTJq1sEp15GM
 e7dLinFxa3PIAjCH08rG+YP/HZjT9O9HSbP9xfmazRYCKT8DOQze5rhtSJ9OkrLs+cSBnejpeJc
 aoykzLLdpA==
X-Received: by 2002:a05:6512:318e:b0:5a4:1798:31ba with SMTP id
 2adb3069b0e04-5aa323ac3d6mr5047983e87.21.1779746184633; Mon, 25 May 2026
 14:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260525152642.4121729-1-mattst88@gmail.com>
In-Reply-To: <20260525152642.4121729-1-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 25 May 2026 17:56:11 -0400
X-Gm-Features: AVHnY4J2LnN5Ut_00JfS3BPyHGy37reLgHCf3jSPbAb1hALTBOBtdUrh-MgTEyI
Message-ID: <CAEdQ38Hrjf+PDj+Cmmdt3TfN8V0kW71gmNuU-vyVXB1UeNKdxA@mail.gmail.com>
Subject: Re: [PATCH 1/3] linux-user/sh4: preserve T/M/Q bits across signal
 delivery
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, May 25, 2026 at 11:26=E2=80=AFAM Matt Turner <mattst88@gmail.com> w=
rote:
>
> QEMU keeps the SH4 T, M and Q status-register bits outside env->sr, in
> the dedicated env->sr_t, env->sr_m and env->sr_q fields; cpu_read_sr()
> folds them back into the architectural SR value and cpu_write_sr()
> splits them back out.
>
> setup_sigcontext() saved the bare env->sr (so the T/M/Q bits were always
> zero in the signal frame) and restore_sigcontext() wrote the value
> straight back into env->sr without updating sr_t/sr_m/sr_q. As a result
> the T bit was never preserved across signal delivery: on sigreturn the
> interrupted code resumed with whatever T value the signal handler last
> left behind. Any conditional branch (or addc/subc/rotcl/div1, etc.)
> immediately following the interrupted instruction could then take the
> wrong path.
>
> This is the cause of the long-standing intermittent failures of the
> tests/tcg/multiarch/signals.c test on sh4, which was marked BROKEN. With
> a SIGRTMIN timer firing every millisecond across many threads, the race
> was hit a few percent of the time and corrupted the guest heap, surfacing
> as a SIGSEGV in memset, a malloc assertion, or an rseq registration abort=
.
>
> Traced on a deterministic rr recording: a cmp/hi set T=3D0, the timer
> signal interrupted the very next instruction (a bf), the handler left
> T=3D1, and the resumed bf took glibc calloc's MORECORE_CLEARS branch,
> using the old top-chunk size as the clear length for a freshly split
> small chunk and running memset off the end of the heap.
>
> Fix setup_sigcontext()/restore_sigcontext() to use cpu_read_sr() and
> cpu_write_sr() so the T, M and Q bits round-trip correctly, and drop the
> BROKEN annotation on the sh4 signals test.
>
> Fixes: c3b5bc8ab3 ("SH4: Signal handling for the user space emulator, by =
Magnus Damm.")
> Cc: qemu-stable@nongnu.org
> ---

Signed-off-by: Matt Turner <mattst88@gmail.com>

