Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939CBCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcEr-0005GG-Ui; Mon, 08 Sep 2025 09:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvcEq-0005Fk-9W
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:48:56 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvcEm-0004T6-IF
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:48:55 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e98b7071cc9so3860734276.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757339326; x=1757944126; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYp2N1iR1J1nSsb2KYLY6liimaMoZOlI0Jj0eBqptCY=;
 b=vDtPn7SPAjQupp6hRN8SktpXH58MZKo7W/CDmKT/41QdOHZEgnEwR9CIwC1RuS5oH4
 6KrwDc6uHU9XagoqjZFNqrYRkz/A0iVMnp27wcDRyjvogXR+2jbK7Zcdd5hBNvpJt1Zz
 Nc400rHxH+5RY+T7xMDM56brWzzCoPXpOP275jL5wAiQG1ahsDGG6HCJ4Td2kG8HLvvq
 R4E7Bv1vDoB2/Tmernqa8MoBuQrfhgst031qFJpUOzGsgT3FdjOT/GDdnhYe179/2XX1
 giaaycHAbzDGGgX2+LNXTC2cRVgJDIOIa8Zf5KfHFk8UZKsfbuT9MCFD3SkWRSDmf+vs
 Mv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757339326; x=1757944126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYp2N1iR1J1nSsb2KYLY6liimaMoZOlI0Jj0eBqptCY=;
 b=OuyfNNrmCxdT0q7l9+NOh45nNf1kRqpqmq1ifBfyrLeEVfDLUCSaPKslqrFhzQ/0I/
 YFL+yVH2KCgX2HwIHL9puAnbdRga4ujaEv6eHbFTlkL4BCamny/DwhT5zJxFxyMdN/Hg
 w1r0zI0aA1PZn9hK9JR+Y5jj5XFPjAqwJlu5h72LokSohid05C0/Pri8eqDLJPJ/1/vX
 jF//FVMCjMNofVA0t6bmmQrNxeNe2YkfVHlT6XGddYehoyuvhqWeDUBE/v0tLTFMilv/
 VSitUBmf30mcyy/wxj0yeDqA505wHFIhdQHisJvqAeFD5TJzVCB4j8uW6qYz07AeuUUn
 Cibw==
X-Gm-Message-State: AOJu0YxUTChwTi8MYZQNsAFxqkjcU78PLKwGob0p5Ct0gKO4i9kJZTto
 U+op6bdEnQN6vM7X1BVEFjudYw+S/V58yQPdMRAGYm8PAb6YWLQUZmfatdcJc03EHnSHOkfT+WR
 i1Q4VLZepO/CthRqDiUoa9Rj3szGAkn6jfbbgd6Ff2g==
X-Gm-Gg: ASbGnctyZznoVjEdcnMQKKAwf+1O2LiHuFklbhnThrO6HmGeKqDeDs0hPoY/VrL8miQ
 Kie+16Wo+Mv0rnXPdbr+lprTX0iMc0eyh13poM40sHqZkFmVGKiIP1Nk9aWqRNk8bVE8032uUZ/
 8PLkV+ZyOkO+OtsVj/yv0wgYpHI474NJQ7oZre4OKkTF6NumzVK34neiVYyAqloZPwkVDHc94ck
 gT5NjSkh3KIVRT2Ob4=
X-Google-Smtp-Source: AGHT+IHLnwAezEewVdd8j1cqlujsrnrTxLW/xl5zFIQ2bCi2OCYfLLCQ3BWHKflv2SHhdEM+1TCSC1HZsyjeuMzZoTQ=
X-Received: by 2002:a05:690e:425a:b0:600:52c:ab66 with SMTP id
 956f58d0204a3-61031b96e31mr4260034d50.17.1757339325750; Mon, 08 Sep 2025
 06:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA9kGOre7sWjjEi1jAGkkNB4EVQnvq3u5fY79HZjSzSZHQ@mail.gmail.com>
 <aL7dSumeu9RI6-5O@redhat.com>
In-Reply-To: <aL7dSumeu9RI6-5O@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Sep 2025 14:48:34 +0100
X-Gm-Features: Ac12FXxQorF-VaUcKXLLcJ4kl0W5kvxXOxH9ZNpMffcFqezf_RJuf0FxHvqMrOs
Message-ID: <CAFEAcA_Zo44Vv-hF8cKkEC-B=VVPYAK67okwgWMVFjUR8fB6Ag@mail.gmail.com>
Subject: Re: should the functional-testing scratch_file() utility guarantee
 that the path it returns doesn't exist?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Mon, 8 Sept 2025 at 14:42, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Sep 08, 2025 at 02:13:54PM +0100, Peter Maydell wrote:
> > The functional testing framework includes a utility function
> > scratch_file() which you can use to get a path for a scratch
> > file to use in the test. However, it doesn't do anything to
> > ensure that the path it returns doesn't already exist.
> > Should it?
>
> No, we need to be able to use scratch_file() to refer to
> previously created resources. For example, when we extract
> files from an archive, we want to then reference those, or
> when we uncompress a file.
>
> > I ran into this with the aarch64/test_rme_sbsaref.py test:
> > this does:
> >         rme_stack =3D self.scratch_file('.')
> > to get a scratch path, and then uses it both to place
> > specific files:
> >         pflash0 =3D join(rme_stack, 'out', 'SBSA_FLASH0.fd')
> > and to place subdirectories:
> >         efi =3D join(rme_stack, 'out', 'EFI')
> >         os.makedirs(efi, exist_ok=3DTrue)
> >
> > In the original version of this test we used os.mkdir(efi),
> > but this fails sometimes because the directory already exists
> > (typically if the test was interrupted during a previous run);
> > see this email for the error log:
> > https://lore.kernel.org/qemu-devel/CAFEAcA_ZQ13qMRUQsieJiEPV=3DULrDbz8=
=3DEJaW4_kw=3DyEysob0w@mail.gmail.co/m
>
> We have a tearDown function which purges everything under the
> scratch dir location, so if a test is interrupted in a "normal"
> way we should be safe on re-run. Only if python is hard-terminated
> would the tearDown method fail to get run.

FWIW I think the cases when I ran into this were likely
after a "kill the 'make check' run by hammering ^C until it
stops".

If you run with QEMU_TEST_KEEP_SCRATCH then the test
dir will also not be purged, obviously. So the test suite
as a whole needs to be robust against the scratch dir
existing when it starts.

> Perhaps we should proactively purge the scratch location in
> the setUp method too, as a safety net against previous unclean
> shutdown, as the intent of the 'scratch file' concept is that
> the test should have a clean environment when it starts running.

This seems like a good idea.

thanks
-- PMM

