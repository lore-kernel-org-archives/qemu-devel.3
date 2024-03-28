Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA417C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 07:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpka9-0005Hj-LN; Thu, 28 Mar 2024 03:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rpka6-0005H6-Sf
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:53:50 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rpka4-0001vy-S7
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:53:50 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c3d7ce5c69so444629b6e.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711612427; x=1712217227;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+B+vecugjquKvQogudmYBViRJLgOciuG2ohhnNP0oM=;
 b=FBPI4uv8VLIaJ5EQDlwM7XWaBwguFxOCuX0dDObtWWEJpaq/24vvGqjVsZ+c7qZxHW
 Ry5EHzCoHSMwLiKQoEEnVMYDkbRJOcQXQYbMwwsgFR1fC+w/K8NxcID5Lnacnh9VVvds
 XcjmTeodyFqKD0m0HG5zERjEiiXiHwgkLYQPCdcJb7OtMjh3s9bwbLZU0lCaHVmY7Sjb
 9aymS/TlpQI/qFEb992EdXHW7/WANpg25CtrublbXvFo0Gzn2ip7ngnWr+OV/CPRGYey
 7yaqXZ/izB6E8Or4lOilxtYroQNYz4heQ2Gv7B/gtlbMttDWAfFBJoxVnpBiDZwpRcdt
 ZLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711612427; x=1712217227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+B+vecugjquKvQogudmYBViRJLgOciuG2ohhnNP0oM=;
 b=YA3LU9PeSYUcLM7qAO9emZ59l6Q+xKYKbAVihEI+csEojwbPqxT+qJ0Ijh1hgMoM/F
 fHUHE/pP2sTocf4mueLNCIvoe4mWTrKiE1BY/McBXZEjY6R2NW+n9XY+e+i9R4SFzeac
 IPJMdgjuAzEkvPp3lPAZpiJP7OQ7shRMMLnZ2YnnLM/LotLNMk+TqIqLkZchmvcqnyo1
 8JliqIzY3SxB9/Vsr3JPcndDSmvyqHbFzTMQWOJUqL1QXLloY3WS+VT514Iv0Ay53g1+
 57VX9NPbHPIIgdmM4zcD+PsMpleYA/+soUwtzqth3P7WADEqqxDbvek5v+uxqVj75rBs
 suoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDhWC8PhqtA28DZ0dY9ODdSCKy3JPymcPU0aodPPmuSxCWIVx9OROHapWrturpWFdeU5i+oZwm+LLIAib/Mrn8PbxUVwA=
X-Gm-Message-State: AOJu0YzOgVuNCCtday0ahpSuB6JjgOblrQ8bpJVyWNI6zFcA6Pq022nH
 Lnetav7f4mofRjSEbR/tC9jfbCO4+PURetX0AreUXN8hq0ieO4BaI5Wl+kQDksEHQJ9qOJdWEF3
 SKJ1pXNTTxPwD+rIJ4mx3rDAo0zp5ET3PHD0/4A==
X-Google-Smtp-Source: AGHT+IF+9eK02Mg9KuNni2D0ftXELWOsIwQrp+KrXrtgNdIIxj4IZuL96AzVRcOyzHfQEgMNMGr7rcBzk6KGe2BTLe8=
X-Received: by 2002:a05:6871:28a:b0:221:a881:e07a with SMTP id
 i10-20020a056871028a00b00221a881e07amr2259956oae.44.1711612426751; Thu, 28
 Mar 2024 00:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
 <ZeWho6ZW41tg0rob@x1n>
In-Reply-To: <ZeWho6ZW41tg0rob@x1n>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Thu, 28 Mar 2024 08:53:36 +0100
Message-ID: <CAGNS4TYd7qVjLb6VCUSQa9DrYivwJV5UDhdSnSde0t2UCMpXrg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Support message-based DMA in vfio-user server
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Stefan, to the best of my knowledge this is fully reviewed and ready
to go in - can you kindly pick it up or advise in case there's
something I missed? Thanks!

On Mon, Mar 4, 2024 at 11:25=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Mar 04, 2024 at 02:05:49AM -0800, Mattias Nissler wrote:
> > This series adds basic support for message-based DMA in qemu's vfio-use=
r
> > server. This is useful for cases where the client does not provide file
> > descriptors for accessing system memory via memory mappings. My motivat=
ing use
> > case is to hook up device models as PCIe endpoints to a hardware design=
. This
> > works by bridging the PCIe transaction layer to vfio-user, and the endp=
oint
> > does not access memory directly, but sends memory requests TLPs to the =
hardware
> > design in order to perform DMA.
> >
> > Note that more work is needed to make message-based DMA work well: qemu
> > currently breaks down DMA accesses into chunks of size 8 bytes at maxim=
um, each
> > of which will be handled in a separate vfio-user DMA request message. T=
his is
> > quite terrible for large DMA accesses, such as when nvme reads and writ=
es
> > page-sized blocks for example. Thus, I would like to improve qemu to be=
 able to
> > perform larger accesses, at least for indirect memory regions. I have s=
omething
> > working locally, but since this will likely result in more involved sur=
gery and
> > discussion, I am leaving this to be addressed in a separate patch.
>
> No objection from my side memory-wise.  It'll be good to get some words
> from Paolo if possible.
>
> Copy Peter Maydell due to the other relevant discussion.
>
> https://lore.kernel.org/qemu-devel/20240228125939.56925-1-heinrich.schuch=
ardt@canonical.com/
>
> --
> Peter Xu
>

