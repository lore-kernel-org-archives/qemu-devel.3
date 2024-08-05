Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B25EC52D6D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saxG0-0005oc-HF; Mon, 05 Aug 2024 08:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1saxFx-0005lq-Vo
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:56:09 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1saxFv-0007J9-8t
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:56:09 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-368313809a4so3192243f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722862565; x=1723467365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jW+cL0un0yaEuTnEfzHHyqs9PyJTDRK27tK6QVzXixI=;
 b=mWPi1LD7B8r0Y7EIHILx/na1MmkzL7ZLF46ILrorSjRmJu2/v4wK2BzW6/Ev+n0AAP
 qma8SWu0qCmFYNMLjM16/HyJntNzIal+MaA22KArgdI/NknfYUiKDhQfdefPml0k/H4G
 HyXYdwG83ZA9FnAOfnsNASYt3nga3ktyU6umHRlkhugjZs27WtwX6U830EGWpSKhf+s5
 LBk7PxuGZw3TgRezkmYN/RLeG3lJo4Mhsu7VAvyAbb1PZTN+ebU1N5pKRs+WSDt+UXVy
 ruIl40pp8GdMi9joPdZG9LHRz5ShMfcjKPd5I+hNs/SFIVDYEuBsCsbPyyUK84CImCHu
 1bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722862565; x=1723467365;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jW+cL0un0yaEuTnEfzHHyqs9PyJTDRK27tK6QVzXixI=;
 b=pMGbzhj1eGdhOwju4xP5VeiXZuS5tGBM2PCU5U/B/w8rMZFpo4CBGrzVsR37rzkyjf
 IH/HLBbQFucqKyLiKSFKb1p8tfU0bMD+DDJWuZJpCewkQ65/5JNaYkejvZekOgcbAYox
 p5FhEab1ZxtHJ7vnh8v3QG6uoyhm+wolK/TPsljF+vA8Pa8ts1nZfuSeqKCEN0vgQIq+
 ZK+MTBUrgnka/GJQVBLZmGqbx2pBu/OT+9iPuNT10PF2ku3URENoEmzPZDHSW4q1OJg3
 /GpPR1k3G9Rh8cm7of05KYxXu09u37rl2XtkQeusBd6TRo8hckEBF+gnlNky9+z5+aLa
 3+4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs2mPHQiB10Et3dkP+UVY2Q60rDJR/gPldAQLbhAix79MQ36I2hjjnZEEyEb6I4W4E0d+Pv5g6X5SUNc/fa7gbLqXueyA=
X-Gm-Message-State: AOJu0YwoN/jPQUeEIB5jVfG1nnzoyK02w407dOuV36ti5Z2T7Nskqrwd
 zNY7giPc+R5RNeXIfa7yK9xoTMEPj2RUOmNMxd+LtDaacP/MEFrhU2GUtKAsAqo=
X-Google-Smtp-Source: AGHT+IGLZOUg4mgF/QKBxKVkEu2tQr9VDPP3gNGOsSjHhwjnKle6mCm86Fv5LJIsL8SihhzrCTUbwQ==
X-Received: by 2002:a05:6000:2112:b0:36b:c3a9:c51c with SMTP id
 ffacd0b85a97d-36bc3a9c78fmr8135476f8f.9.1722862564625; 
 Mon, 05 Aug 2024 05:56:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd05980csm9842578f8f.76.2024.08.05.05.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:56:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E762D5F882;
 Mon,  5 Aug 2024 13:56:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,  qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] tests/avocado: Re-enable gdbsim-r5f562n8 testing
 U-Boot
In-Reply-To: <3e93ed77-fa43-4f2e-923f-8d5578716a04@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 5 Aug 2024 14:41:25
 +0200")
References: <20240801172332.65701-1-philmd@linaro.org>
 <87r0b3e9yp.wl-ysato@users.sourceforge.jp>
 <3e93ed77-fa43-4f2e-923f-8d5578716a04@linaro.org>
Date: Mon, 05 Aug 2024 13:56:02 +0100
Message-ID: <878qxbruvx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 5/8/24 08:54, Yoshinori Sato wrote:
>> On Fri, 02 Aug 2024 02:23:32 +0900,
>> Philippe Mathieu-Daud=C3=A9 wrote:
>>>
>>> We disabled all RX tests on commit 9b45cc9931 ("docs/devel:
>>> rationalise unstable gitlab tests under FLAKY_TESTS") for
>>> being flaky. However I don't recall the U-Boot test to fail
>>> (the problematic line checking the 'version' string is already
>>> commented out), and I'm running this test reliably, so re-enable
>>> it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>>   tests/avocado/machine_rx_gdbsim.py | 2 --
>>>   1 file changed, 2 deletions(-)
>
>> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>
> Thanks, I'll queue this patch for 9.2 to avoid messing
> with the next release.

Testing updates are usually fine, but I can leave it to you to merge if
you prefer.

>
> Regards,
>
> Phil.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

