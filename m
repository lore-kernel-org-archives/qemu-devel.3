Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9F6D4A607
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgdu2-0001wJ-Ig; Fri, 16 Jan 2026 02:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgdu1-0001wB-A0
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:05:49 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgdtz-0007r0-N1
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:05:49 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b874c00a3fcso275318066b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:05:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768547145; cv=none;
 d=google.com; s=arc-20240605;
 b=dwsfmtpnV/ttNhbHVhcFyU+MssxLKE4HEeu3lrnuwEObdxIF+Mgn6Jw2+jfTbzPft1
 sIK3CpjRfy1yt5RD25CTB2UPH+iqdmb2pcmlFGpTFROcYYJUMp8AX5joMbHO9Db9Xjxt
 /Jv248LEGt0kQfKfAgZi+UxAHa/hoqYjgovzz0UM9dR5OBki33oJHAaE3yVxM7DYxOeZ
 Un3T/L0Yxv7mc5JQDk/KdUgQEqtOHKK/vLoEA89QWyFPKoZqFyfTJpVC5yXkeA8ELPSR
 LE9cKVJZCGtw15y1me5LastPIUN1ofnORf9w2CGOSa9qTJLABhDUWPsa69kIMusPKQAG
 gY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AsqEc9PXMF1ro4pWK4CMXB6LDGqoxaqaq/aPc5UncC8=;
 fh=IEUzuLXylejbDGG2MK70eEAf260NzTwK6+PSBf6A97M=;
 b=QoJR7/rMDlXuE+CI9q0VhlohDMHFjyQ30wLNW953uq9EaFpc7JPw/JMTfesdayDJ6s
 Fa+40F/9XkiBNbFc1jZIoaBvenJ37Nh7SMfz/aVsPL6DLywgiTUmMKeXhorNuzgX/mkY
 vNsWQciD0A+zzuLfQaJ+a+wwzorLRVNtikTNP4ODN5B5loza32uxGkEs487AiO2dN1Uk
 0r43MK0VPZIh05L5/X5VdaFft2/6nUio9mFexk0E34BEB11loilWYmnjPx54+fEZbTqr
 QlKZ/gGj0PSqDVawJB2m3yJrHr5g0tIDQ2wsxpRbzS9EGroiQXzfdLEfJLDgemBS/daZ
 ynsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768547145; x=1769151945; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsqEc9PXMF1ro4pWK4CMXB6LDGqoxaqaq/aPc5UncC8=;
 b=U1NqMe7Gwd5x6U5ofrK1idchP3Eve5z76egrLAPy00Ooh6zbnhfmNNb97WzxfT8fFN
 ERIOK8WTQtXGPfMTz7Evmdex6cSL+kHNW7msKIKGkXwvoGc+2p+4isXuIZIUwNmyMLI5
 dQgzsxanJyPoQAOvF02Ho5jV1ZU91Fq6riYgr32S7ta2JGVYcau5G64ctJ+CsL2Uxanv
 UZs3a3Yz1jOWj+5uMs78v46nHe91nY0xKuaeGakYZmr/FJytPU/a3qHnZGR3ZOlfhE3s
 4VAZqkx6L8QqaFJN0fHcKeHQa6fiOKhHY2gHoZMcHYfKrTN3cvHYm5Q39/41pipwyiBY
 5kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768547145; x=1769151945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AsqEc9PXMF1ro4pWK4CMXB6LDGqoxaqaq/aPc5UncC8=;
 b=eQ+TzGQOCrhnpvkBdCLYSnaWP0/uja+axrd9eRlJQp4o6+qdr7AkHhlHRO+daRbvN5
 wi1SGD/d+JqEql+s5t6PFpansYXE3SOXG6nwxHh003chj0KN78PlKknvDWNKipgP/pay
 pN8xhZXgYbuGAt7MTyy1aDH14hWflYc5RU4QNBYvIg2yMPDMRDAkCfnfxSQzk7nkqrb0
 sQU06lVAl5TYDGRKZ9sPg4n7Ds5U+m5lulvAMO38kk87CsOsCgfAzT4uLQU5bt/li5LY
 +1Z00LF5cgIqPBS/v3wl5WSF5J16gMK+KXzl+56vQYWFP70uQjzcN+PN3m/ISvCypICS
 L5sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjJMhHsZKpAEd1asA8UlnaOkGmnK0QaVMGvzmdwbtpYXTwzrl6H8dItd1jb9Au6IKON1nL2fqrr99p@nongnu.org
X-Gm-Message-State: AOJu0YxeF2zphNzfyt7drUaMi8W35r66RfHY+jZ8GcQZ7K9mDKwoqPeB
 qQWnZ1KhshXjOnNrVyxcr3vqtnZjEY8MQw8fbSQ4yat6b0C5mSDJlwR5wHh0N0clZ6uTYGHrbzJ
 T5fvXku0dvK1NrEwE/87SJ+ivHrr5zIs=
X-Gm-Gg: AY/fxX4YMZuRLEYDHD9jmQNVnuIC6Dr2r2d9MEY6b0uP/UWwzPmTgArl+WEj3CMZNW3
 7qpUuNOq4aAy2xy7j6yWReVhdrfAqEJfgBMd00RVb+QrZtl2GuefWD/rHzD2pgqQ2aGUlLqOJed
 FOeTo5ChGDXLWz4zkMJP4UwharJg8PPW5YQMWVdaMnHJ5Bg81+dAeyJ+DbEkrmOd/03hufHj/Zd
 0lC6kvho/W0y2f2yT+9qOyfzVMazb6/vZ5JSiwBSM5098S3+u65LEeIBa9xY7KAbikpIaz8
X-Received: by 2002:a17:907:70a:b0:b87:1e50:95c2 with SMTP id
 a640c23a62f3a-b8792d67e48mr198873766b.3.1768547145177; Thu, 15 Jan 2026
 23:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
In-Reply-To: <aWlxY9TWGT1aaMJz@gallifrey>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 16 Jan 2026 15:05:04 +0800
X-Gm-Features: AZwV_QiKpG1RN4-Q_eK8RtIUWgKbsVxU4bgoSXUMwo_KAneYTnaJI3aaZdMTKzA
Message-ID: <CAK3tnvLTmpjhhZPa7m-pbhGg-jMjo0KQO5_9Jr1KCBFmckRe5g@mail.gmail.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Peter Xu <peterx@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-devel@nongnu.org, 
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 Juan Quintela <quintela@trasno.org>, zhanghailiang@xfusion.com, 
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x630.google.com
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

On Fri, Jan 16, 2026 at 6:59=E2=80=AFAM Dr. David Alan Gilbert <dave@trebli=
g.org> wrote:
>
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:
> > > Nack.
> > >
> > > This code has users, as explained in my other email:
> > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/=
#mc99839451d6841366619c4ec0d5af5264e2f6464
> >
> > Please then rework that series and consider include the following (I
> > believe I pointed out a long time ago somewhere..):
> >
>
> > - Some form of justification of why multifd needs to be enabled for COL=
O.
> >   For example, in your cluster deployment, using multifd can improve XX=
X
> >   by YYY.  Please describe the use case and improvements.
>
> That one is pretty easy; since COLO is regularly taking snapshots, the fa=
ster
> the snapshoting the less overhead there is.
>
> Lukas: Given COLO has a bunch of different features (i.e. the block
> replication, the clever network comparison etc) do you know which ones
> are used in the setups you are aware of?
>
> I'd guess the tricky part of a test would be the network side; I'm
> not too sure how you'd set that in a test.

Hi Dave,

For the COLO network test part we already have some qtest for that.
The original COLO-proxy function decoupled into several QEMU netfilter modu=
les:
The filter-mirror/filter-redirector/filter-rewriter/colo-compare.
Only the colo-compare is COLO specific one.
COLO connect all the general modules with chardev socket to finish function=
s.
Current status is we already have the qtest for filter-mirror/filter-redire=
ctor:
like the qemu/tests/qtest/test-filter-mirror.c

If this discussion ultimately dicides to retain COLO, I can cover COLO
network test case.

Thanks
Chen

>
> Dave
>
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

