Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FD6CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 13:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtocO-0000tN-I9; Mon, 08 Apr 2024 09:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@cloud.com>)
 id 1rtobw-0000so-Hg
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 09:00:33 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@cloud.com>)
 id 1rtobn-0006QV-KD
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 09:00:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e703e0e5deso3886390b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1712581219; x=1713186019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q714Nm8ZXiiNOCBkZLSgaliRMxIwh9vQdiua8gm1DEY=;
 b=YuiJ84H2p2PMtEwChvS8tRq/sALplGzfU5Im+nc5s/g7nWtXJszlal1+UmdqjsopY9
 4fWuV6259y3jVlpbaBrmwRyC/kVjd8GqVLt66tMMDOx+sqFVmUDj3pU0g55gkdqbmokZ
 21/0/SQCW9wzv6GoZKeF6MfQMk3RU/Ekdu29g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712581219; x=1713186019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q714Nm8ZXiiNOCBkZLSgaliRMxIwh9vQdiua8gm1DEY=;
 b=PqIrEOnZZcLDyKZpEfTEXF7G+jIlGap1tqCSJbvicOXQLInWtAjK/NiU8A06BWfc+H
 2qp90o5kMrwxyuq3Vx1+uPPfr+iG6FZYdEtU/CcDXLY8qW1+E+H6OU0ZCDMBoVZ6zJkT
 adHprN9RSjdaWL1AOAKi6gM+kUESTxWkSlp5xKLvO5OgJgUYHG8CIWWpgGwqX898Be+a
 jd97l5mnBRmIuNB3aG4ajaqVTlr70Xywvs1A/mDwvStlS8Fu6MaLocYF32/O9zW87zne
 bjEmw+zK1+GLdSjrjurwfZnXKsSV8WoSuBPEKKgDww6OPFMZoQ7Vn9upy7hw5CyMOXM/
 b02g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi/5hz/i8GYbwn2ZiVQFr0DpiY6VegAwtkvOXUZHR6zon/NpmhEE3xVQgZjt9zRUaSLgQWF2jJ07uyyN4tOBGM2ZSTM30=
X-Gm-Message-State: AOJu0Yx4hawJiFSLx+3bHK8Tk+Fz6joHw9LX+MQ6V0pN68q+YJ3OJRDK
 Zi+hB+hnroq2F5qR7wWF8XzQ1PUhfk43Yg90PbP8RK1nbwteGg/dLJ+NKlWJqBCMFakfjB75yMi
 I7MWb/Vc3KVlKhmzq0PmM6g5rd4HU1ONxXSQV
X-Google-Smtp-Source: AGHT+IGOQK5Q/iV+vLPvm6a80+xbazHGAgGRWtRhX4Ai4j+kQswxdaL01v/QNZT38gEUJu8sNtf0/rKTLFEvRKTaDNk=
X-Received: by 2002:a05:6a20:7355:b0:1a7:42b1:f18 with SMTP id
 v21-20020a056a20735500b001a742b10f18mr8358272pzc.52.1712581218689; Mon, 08
 Apr 2024 06:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
 <6fad8151-4bde-4a02-96fb-27b99d93757f@gmail.com>
In-Reply-To: <6fad8151-4bde-4a02-96fb-27b99d93757f@gmail.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Mon, 8 Apr 2024 14:00:06 +0100
Message-ID: <CAG7k0EqEwfS75n8FCncrr_VzPtJZk46KrLiYaMDfWfrZ6CEApg@mail.gmail.com>
Subject: Re: [PATCH] xen-hvm: Avoid livelock while handling buffered ioreqs
To: paul@xen.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, 
 xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=ross.lagerwall@cloud.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Apr 6, 2024 at 11:58=E2=80=AFAM Durrant, Paul <xadimgnik@gmail.com>=
 wrote:
>
> On 04/04/2024 15:08, Ross Lagerwall wrote:
> > A malicious or buggy guest may generated buffered ioreqs faster than
> > QEMU can process them in handle_buffered_iopage(). The result is a
> > livelock - QEMU continuously processes ioreqs on the main thread withou=
t
> > iterating through the main loop which prevents handling other events,
> > processing timers, etc. Without QEMU handling other events, it often
> > results in the guest becoming unsable and makes it difficult to stop th=
e
> > source of buffered ioreqs.
> >
> > To avoid this, if we process a full page of buffered ioreqs, stop and
> > reschedule an immediate timer to continue processing them. This lets
> > QEMU go back to the main loop and catch up.
> >
>
> Do PV backends potentially cause the same scheduling issue (if not using
> io threads)?
>

From what I can tell:

xen-block: It reads req_prod / req_cons once before entering the loop
so it should be fine, I think.

xen_console: Same as xen-block

xen_nic: It reads req_prod / req_cons once before entering the loop.
However, once the loop ends it checks for more requests and if there
are more requests it restarts from the beginning. It seems like this
could be susceptible to the same issue.

(These PV backends generally aren't used by XenServer's system QEMU
so I didn't spend too much time looking into it.)

Thanks,
Ross

