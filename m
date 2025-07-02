Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B68C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyUc-0001fK-DQ; Wed, 02 Jul 2025 10:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uWyUQ-0001cj-3t; Wed, 02 Jul 2025 10:31:10 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uWyUH-0000ao-FB; Wed, 02 Jul 2025 10:31:07 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60789b450ceso8470180a12.2; 
 Wed, 02 Jul 2025 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751466656; x=1752071456; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJ0YHEcv8KTCs25GTi/gZlvx+bln4QqEEWvEkWISosQ=;
 b=RvLQo6DFYtqxNEmrQkNmv26AdPUw1n8JoBCqRM7P36l32Uld5bjq2lwO3iUGzF4ADo
 THNVrNlFs3FNI1Fls5gI4y5AjoL6VaNk0QBDwvXFLxSANePCaQ114iWn/SvGi75311yP
 rU2Di8j2RfvDGoR/ZT2wHjuKkZ2Um0LM113aW73dGyZx/F+qYw5Aew6tsUp/+2wXE318
 UTWMqG8GSPsbDITOgK+KqhnkdEOGPNYIydW3YsRRB8zrcO3wyv9vcaU1ZuONr93PsaGy
 DyUM9iYuT9f2/fRLDgKvEygsoL15ubUpIZv0MNzUMjyYjgo10Cg7EJdi7j2xp4s1dADP
 fcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751466656; x=1752071456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJ0YHEcv8KTCs25GTi/gZlvx+bln4QqEEWvEkWISosQ=;
 b=xOrw5reonBztxY3x57CxMs1nFj2jt4iFkFG1lOxLs2Patz3RRjNZGMUJgG71nE6U5w
 ukykrGp7SerrxI/Pgcio8u8mOHLpi2ys+PUSmAz/iqHZW2d+T0GlWp0NtLQri4P31rT2
 tWAMfw3QAZAn4q0pa6e51bl6J6vscPB44aCdYpEi1ENMd4PvpSzKV7oaBqMJDaR0FTUj
 DsQ4OOUby7UeECqRf0XMQXsBCXpL/Z/AgtGSUQI9Yk49KMSLQwcvr1T/RW70BG7DxR1V
 rlyN3SgBQ+i02XLE4hAPWW5xebfHFTFFDGdiMJGTg2NcWnciuzKjMI0JMgjapaEV93up
 Tc1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfd0onIhvhuwOTj2/VEuuuQZ1JXxkdGtMcAeVZzwQ0qfGwqt8YhP/vS9WvCpVjwMNuPlLlXkISdoN7Mw==@nongnu.org,
 AJvYcCXXfG4PXb6DXs/R+v8CKBqTMwq2AC7eba9rU7TjxSp4tpqL1AJrEH4NdcJfapTihmJh3CQikugHLw==@nongnu.org
X-Gm-Message-State: AOJu0Yw9QPxjvMCsB5TqBAql/cLsl0eFq4tdKiYM08Aei2eU4G+k4/mR
 qtYf1ZdPncY8N2IOrpNYBmk7PdNTUAnFcqw6cieM776wuRJO75StxpfoYzRLNBovH2ScCqSlqWI
 62oy978VWUVuBmpQq95gmWh8awe1RSE4=
X-Gm-Gg: ASbGncv+HYJ2DQsYwVO10RMfz7qLwiT7Ez3rsHxirolA8+5vhTfUChocAngj7L87dsf
 MBQvud8LfeNEhSyVrwj8QA0d1PsE5tGC0GaIW73cU/SCrfnuQs2niJ68DlQe8NLX7pIe0D+0cvJ
 qa5LQ1wuFdIqH40E2IHv74ZlLpvKIpDVw2XLHVQDbFQA==
X-Google-Smtp-Source: AGHT+IFhDGibND7PU449eQ/Mmfepsyks6qy9zF3gP9N9dpsTTP4j4N2u4oorOLPvF4DFTesp+uZd5MnXxrjyfECCFv4=
X-Received: by 2002:a17:906:c142:b0:ae3:a810:8fc8 with SMTP id
 a640c23a62f3a-ae3c2e197b9mr330396766b.41.1751466655753; Wed, 02 Jul 2025
 07:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
 <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
 <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
 <9bac4585-255a-4805-b24d-b3b75d2ca9c3@redhat.com>
 <CANCZdfq6+R=VgyYdcdJCmDBTCgLSxDJuqd8h=ehb5F+v-HPT+g@mail.gmail.com>
 <CAJSP0QWSVhAYBtxKV+WDubmif2m=jxTYd-BK=d7ExZXWUNUYXA@mail.gmail.com>
 <CANCZdfqTKUMLbrT9HEXa-O7pyHqfcMWMmYx7iCq=ZU_ewgCaag@mail.gmail.com>
 <CAJSP0QUKx+eLjF5J2+JGrry_x-jx1p5HStCOTfOgQg+3nOpSeg@mail.gmail.com>
 <CANCZdfrxE=GScjtcd87cd-fgRf3uk87T=Ow718cFrB24=iC8iQ@mail.gmail.com>
 <5088018f-cfb5-4256-9f70-6a578a2d53b7@redhat.com>
In-Reply-To: <5088018f-cfb5-4256-9f70-6a578a2d53b7@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 2 Jul 2025 10:30:43 -0400
X-Gm-Features: Ac12FXx1iQYjC36H0YJ29clr68Wgg3-B9oqo2ztwUyakV7UQB9hCspB3PQTS9zY
Message-ID: <CAJSP0QXOabC2i+nzu5p9O0-3sHSenem=YSDjz+4avgQz1pXU8Q@mail.gmail.com>
Subject: Re: FreeBSD 14.1 aarch64 iso URL is down
To: Thomas Huth <thuth@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

On Thu, Jun 26, 2025 at 2:02=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 26/06/2025 04.53, Warner Losh wrote:
> > [...] What's the
> > anticipated load, measured in downloads per day say, this testing
> > generates?
>
> Ideally, the functional tests download the assets once and then cache the=
m.
> However, it's currently broken in the non-shared CI runners of the
> qemu-project (it's working in forked repos with the shared runners), so
> expect a fistful of downloads per day (I guess 5 downloads per day would =
be
> a reasonable number to expect).
>
> > Speaking of which, has someone done the update? I'm a bit behind on my
> > qemu stuff and haven't been paying attention.
>
> AFAICT nobody has sent a patch yet, so it's currently still broken.

Hi Thomas,
Thanks for sending a patch to use the archive server.

Warner: If you want to update the test environment to 14.3 or change
which URLs QEMU's test suite uses, please feel free to send additional
patches. For now Thomas' patch will let the test pass again.

Stefan

