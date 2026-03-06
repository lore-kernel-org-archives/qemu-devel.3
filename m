Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49350FCB604
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWad-0001TG-Ec; Fri, 06 Mar 2026 09:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWac-0001Sy-0m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:55:42 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWaZ-0001nL-Ts
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:55:41 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso11580177d50.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772808938; cv=none;
 d=google.com; s=arc-20240605;
 b=CdLK2J+L/m17iQ6r/fJyh9X0L8Ko7EtwwbUEsia21EnyM7bvfn2edPc1lPPTCSLr7P
 hdPkYygRiVMFM7Tjt4NR2f4smmXVHXjU7Wepy73ZQuhrSduIoqMNLoBHVW5HJtoCPjU0
 d0BndzKwZXeH3MpXWE2+bpppiiG/ojKMP1pxQ5FVNo+t4Nkg6AEyPOCrYYddboANwZbZ
 +dz60BPDDq2v2BKOpgqKip6qc6fBdHIq3PNUVvXh2Exs/U93jEc2nlihEfD+ilZbCX0M
 nL5MW5Tb3mcWDUcn08ixEjNNuvInalHqx4c8ZPDXpO/XALnLGtsYZu6RSEpxCeeJOrhA
 fwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BKAmOWji1n6ggVADnuheLD6Nay5eP6uG9lEgHu/2NAU=;
 fh=3G3i7W57o5nCkbMfIY/bQRfQQcJiliZ+tvE0nXjwDG0=;
 b=bprvwJfcid0OY8cOqKZ6+5lXAAcLu7uEnka36v/N7vWMyGIW4/W8wyyHipEcXp9nYA
 WItcSAVuMdnYGnEtNuX9LisqOshr+NOXhKunr15Wrc6d7hMKAXT6Nst7ZSK3/rbRULR1
 cfCSotMACktqDYh9QDd/B1biS8rvq7VqOtiRSVgaEynYHyrBlta1SPMqzzzkI20JJ/Oq
 /0SBltarMnRmD7ZWCm0wUq56SVzp1B0NewoDqDjqgragK1WHE6kgL4Ev5LvbKFjopGKM
 DO0cl3rPn4YbnzpOJHcyRonC3eT2PaIv8hIGKHazgJCBfZCij/u3ndnzba0aa7HTUU5x
 Ycmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772808938; x=1773413738; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKAmOWji1n6ggVADnuheLD6Nay5eP6uG9lEgHu/2NAU=;
 b=PFoqfba9wISPaTjIPMRuA98UAzjuUIKWe8xwdWY2gtEPydN1OJWkfGss7x3gBlLYqm
 PJqBwgIWFJg1rh2mJ3JVLgtQbGDLtfl0x0jAyhhmayuJoXiOe4E39Aorh4RDdXtPUiI2
 lwX0VPAJP/dGEpnQQzm03navC+m457cXzMYVdpWZU28sh/Cus5L5VY6UZZub+izgauz2
 FDmChIgJGFPfEqoPaGi0/zNvEmDNIxbBULpyIzcbt4f7NI9lrWHUqZYQDZ6OWRUzIsrF
 hQCwgz9TSVyNETrUQqWrDVPBokjqwt0jzTde4ZC21nrLfy3WoiGMXLVtrcLeZLnV6pr3
 Bmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772808938; x=1773413738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BKAmOWji1n6ggVADnuheLD6Nay5eP6uG9lEgHu/2NAU=;
 b=i6UmHpqAOQTMPyHyorQfWpEVA3Yx8pwKpINgVj3WDWLR4YSHlKbiC75/08SHLA97Ws
 4xEtV5aCeiVgRkj9rmGOojlKhmk4X6yHlQACQ1ptyP2HP0fMig5aXIsc5iGo2mg3P32S
 O6mbGPnxB6FH/W8aOCJc86IZaQnKtvdFvgqWebrVxyx4mIQow4cBX0TWfHNImr2ftJiq
 MCAQrT46i2Lptd9hvevnGc8mJ6AfxFgxUGyFiep85eLhkobEq4GIcRgq2DB7zmo7loVl
 Y69L+NPYaqPSHOey5HaW9/aPVJMGV31FfZxlR51/RqQXvnyJqsZGsDk2ZWbvWegDjeyz
 86Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwIpmDpYS1TQsJu3meUrJHa1oIC8V+0jYGq2/a9KrJ1E3FtIMAOthY6r3YsaNHNyGvoC8txTH5DJtH@nongnu.org
X-Gm-Message-State: AOJu0Yw3gzsADPQfDj1uYQoMj4b5Mm6tbq72V5v1rOmWC7cFyGU1Ow7c
 5WqG1uEpKB93eK4okNqp63Sg0zE025+Vel+F1aVnHIzG8WxFeswEk2n98PNt1jpH4QoEr54aqQB
 nvrzpkDr2odq3O7wIqfzNnLWc4/ihYNIQ8R35p8E4TRYVI7E59Fnm
X-Gm-Gg: ATEYQzzoS+HSOHG0qRoLYkkYdrdpfYoKMv1uriuT/SXOYpG/h7tJb6GyspAXKBGXZFG
 x8SXXaxzSVzwz4wEhMu4yYFLGSmUFFeJxHRE+lvOlVzZCR8eL3OSugeEZtmrEsRVuDJXHudXeLY
 vJ3zvZcvO1aelAJKlaBAG1aDlinU+Ove2qpQr9sN7CzGlmFVti7K/SuaSSlV94AWFd9kbqf3cKs
 ctJMN/t3nohUTyuws47UzhmnwAKf6spe0beBBT8idJdOYWE8Px24Q4MUJz4xwrKdLxpD+WIsarI
 9vVJuIV8B3j0qWS1mx1ydGQ2WGqwnsGmSpwBlc5qzXTi/TYLNe1fF6JpFGmAFeSpWWcOr3PY/nb
 AAg==
X-Received: by 2002:a05:690e:4106:b0:64a:d716:c8e7 with SMTP id
 956f58d0204a3-64d070f0e83mr5151389d50.11.1772808937595; Fri, 06 Mar 2026
 06:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20250515222014.4161-1-farosas@suse.de>
 <20250515222014.4161-5-farosas@suse.de>
 <aCsPOyZCu-AcZOI3@redhat.com>
 <CAFEAcA_BvkKaF-qgJm25wSwuLEBedxL_pRVedQadCh1fVQBr8w@mail.gmail.com>
 <aagKqykyAO1svo_f@redhat.com>
 <CAFEAcA88RR05VXhz=j_+EiDYHUUtsMW0kX9PV04B1toK_dd95Q@mail.gmail.com>
 <aarpcvImyt35Hido@redhat.com>
In-Reply-To: <aarpcvImyt35Hido@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 14:55:25 +0000
X-Gm-Features: AaiRm53hezqka3d9hGfuCmKkB8jn70KieOTveob_Ica5MX_V2zoztjm_6HyW9KM
Message-ID: <CAFEAcA9qVXvzLYCtWeSekK+1aooEDzzs8TvDHvj1Cu97a_c_KA@mail.gmail.com>
Subject: Re: [PATCH 4/4] chardev: Introduce a lock for hup_source
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 6 Mar 2026 at 14:49, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Fri, Mar 06, 2026 at 01:57:45PM +0000, Peter Maydell wrote:
> > On Wed, 4 Mar 2026 at 10:34, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > > It is subtle, as the QIOTask object deals with 2 separate callbacks.
> > >
> > > The callback that is provided to qio_task_new() is what is invoked wh=
en
> > > the task is marked as completed. This is guaranteed to always be
> > > invoked in main event loop context.
> > >
> > > The callback that is provided to qio_task_run_in_thread() is what run=
s
> > > in the throwaway background thread.  When this callback returns, the
> > > QIOTask creates a glib idle source in the main event loop to run the
> > > completion callback.
> > >
> > >
> > > So wrt char-socket.c, tcp_chr_connect_client_task will run in the
> > > background thread, but it only calls QIOChannel APIs so is safe.
> > >
> > > The qemu_chr_socket_connected method will run in main event loop
> > > context, so it does not need locking wrt other chardev I/O
> > > callbacks.
> >
> > This is starting to sound like the problem is the test code. The
> > test code is calling qemu_chr_new() and qemu_chr_fe_set_handlers()
> > from a random thread it created by directly calling g_thread_new().
> > So these calls from this thread do not have any kind of lock and
> > can run in parallel with the qemu_chr_socket_connected method from
> > the main event loop.
> >
> > I guess we need to take a lock here, but which one?
> >
> > > >  How is this intended to work ? Is the test case code incorrect to =
assume
> > > > it can work with the chardev it got back from qemu_chr_new(), or sh=
ould
> > > > the chardev be handling this case?
> > >
> > > The test is really rather had to understand, but I feel like somethin=
g
> > > in the test ought to be looking at the CHR_EVENT_OPENED event to
> > > identify when the connection is actually established ?
> >
> > The way to get a CHR_EVENT_OPENED would be to set the frontend
> > handlers with qemu_chr_fe_set_handlers(). It's the call to set
> > the frontend handlers that is already going wrong. (But the test
> > doesn't really need to care about the EVENT_OPENED: it can
> > just wait til it gets the "you have some data to read" callback.)
>
> I'm rather feeling that the test program would be better off not
> using chardevs at all, and instead using QIOChannelSocket directly.
> The chardevs are horribly complex when trying to deal with
> connection oriented semantics, as they are really not a connection
> based API; the event stuff is a hacky afterthought that barely
> gets us by.

Perhaps. But that sounds like a lot more work than "identify what
lock one is supposed to be holding to validly call the qemu_chr*
functions and make sure we hold it in test_server_connect()" :-)

-- PMM

