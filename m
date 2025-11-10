Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841EBCCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 13:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIS79-0001jr-NT; Mon, 10 Nov 2025 08:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vIRl4-0004eW-DX
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 08:16:37 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vIRl1-0000j3-ES
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 08:16:34 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63bc1aeb427so2420361d50.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 05:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762780590; x=1763385390; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LNxPAa5UaJLbl0/PF1b8HrfRNxaf12EH4ci6pH3bpg=;
 b=PEwhWj4Utnjj8VFdKzWXexGn07s5JSrl7oOTrBiZJEoDSyvcZIsFFUm5dkW0aPunLx
 YFfYMmiPHLNXxhbqLf8UPoiRhgfV04yzGPsNl80aoPOtU8MhFFe95xlsxK1Tkk3N3ZtR
 hrQTFwJoIXENlfHguHF9bA31gzU12mke4sxiruvirQUck5+tFBqcWJiMic54FBLe56Up
 wad5q3ld1Nf78Ifk8bdAQWF5iF1aDoUlK5i7zrEz0Df064FRbabBvZxQHxgcxHUqRItf
 tYNHzG0n5iv692r+aVRMyn9xZCL02NFTJUaugi4Rml71hr0JT4E2EsFURzWXQG+AGOD7
 0B5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762780590; x=1763385390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5LNxPAa5UaJLbl0/PF1b8HrfRNxaf12EH4ci6pH3bpg=;
 b=Q7VGa+FGKEGGQ8E23Sk/AitTJdMoIO92G1bcJo+Zv0XSGS5iMm8ywTfixOVu8CXqaB
 qly1EkTn28D9cTIIvDFBRDCVlOfO6ZUGRiJ/nKc3nDZoqV8i5GbWzam9FqN9e/Ttc111
 eBU5NdUYNx00+yWS/6LthdZUjtmG5ujHj3JBPlAIICW8qKGAf11WgIPSH8wdmFi44+mC
 0QBKXutxzx1uo6mobKFd2ckapmYm+pjJWqgtVGLarPbh+rV+lHrNtC2FUEJUP9G6gDgK
 fz6kI8IXpB5aB3ZMtfQl6lOrJNUAAlbMbQEcGP65tV7CDqqdVKqA3XsE/W36wjIaNRip
 kmYA==
X-Gm-Message-State: AOJu0YyUZnei+rPlDMTed3wLlOjP624/ICk8jDB8g6JWykOtx+SlW9xY
 1bdowYuBqdmMBaxfhXujQACROT2tiSqoAcoXzzzeRfK9XOIYHIFmcugnWLgV5bDz+FH9TcEtonK
 4icQoRvk6pJBhZTuj95b4fZq+/+tefGFuB5jo
X-Gm-Gg: ASbGnct53oTe/2w74qeN6rr3upjLYhLlJRf9uVtUsGJ6REl0hGvzGawYF9dyxSb8fo8
 iguGW5MAtHzZbisbBUCCv4SuCUJ2hWmSQme/bivAgXRZnCxsuE44+agQluGA92GkrpesRP5qNKW
 C7EtIDebu72zX/Ehh8S1RqoveQxSKrPZLrznovna1Y8ZPwozCiI1+m+I7kbxuDygpWZPwIeY6Qb
 3rIW7PuulZaHAXhiIDt5JJBGPRuzs4EBeO/bZ7oQkMqeS9KfuSPN4OdrdUMWj0L9B8ZPOwv3Ih+
 vD+zBduK
X-Google-Smtp-Source: AGHT+IHYTAxnRPmn/i/PJBCgTie1eg+ZwvYBZ6U4wcHxtaoefU5MgAUrFkIM2WP3zgT2OD7yRF5gVPQ6TwF3NXrsPuo=
X-Received: by 2002:a53:d01c:0:b0:63f:af64:ae5a with SMTP id
 956f58d0204a3-640d45d1d59mr5862292d50.58.1762780590423; Mon, 10 Nov 2025
 05:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20251110110507.1641042-1-bmeng.cn@gmail.com>
 <bb8eedd0-b061-416f-be49-33a760c6e1f7@linaro.org>
In-Reply-To: <bb8eedd0-b061-416f-be49-33a760c6e1f7@linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 10 Nov 2025 21:16:18 +0800
X-Gm-Features: AWmQ_bmegOQZXccjsK09vxL_dbhtDP_fTuMochwWwBuXQuHfC5kk8BT53RoWlbg
Message-ID: <CAEUhbmUwr+y0jKx=ZGqgsZhAer=ix9X-VkkJS1pF8-OM8-YhRw@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/sd: Fix broken ssi-sd implementation since v9.1.0
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: QEMU <qemu-devel@nongnu.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Philippe,

On Mon, Nov 10, 2025 at 7:57=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Bin, Tom,
>
> On 10/11/25 12:05, Bin Meng wrote:
> >
> > The U-Boot community reported a CI failure [1] where the
> > `sifive_unleashed` target failed to boot from an SD card after
> > upgrading from QEMU v8.2.0 to v9.2.3.
> >
> > At that time, the issue was traced to commit da954d0e
> > ("hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)")
> > which was introduced in v9.1.0.
> >
> > Testing with the latest QEMU mainline shows that the problem still
> > persists, although the underlying cause has changed due to refactoring
> > since then.
> >
> > This series fixes the broken `ssi-sd` model. After applying these
> > patches, U-Boot successfully boots again on the `sifive_unleashed`
> > target using QEMU=E2=80=99s `sifive_u` machine.
>
> Thanks for fixing this issue!
>
> Do you mind adding this test as a functional one, so we get this
> code path covered?
>

Sure, I will try to add a test in v2.

Regards,
Bin

