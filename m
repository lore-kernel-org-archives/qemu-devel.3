Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517C3C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFpV-000143-A2; Mon, 16 Sep 2024 13:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sqFpP-0000ey-Up
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:48:01 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sqFpN-0004c1-N5
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:47:59 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5e1ba0adcb0so2140266eaf.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726508876; x=1727113676;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPUeqriH8UeVOkOmJAooKqkB425UhKhyrGPH3csLiQY=;
 b=ceLvroNdfa6vlsbKhX2dtnbetCA0okYyQjoJDSKVQqyNU62Y649k2kYMQn9Uwex8Ey
 tPqAMROCS96oCagLRJ8xdel4t7+Cn+GUEYdekR2MxB6Q0Fst/mo0KQhtlpDzW0WYmdwx
 NQkAtKd0dw/DwG8tGS67ZVTh+GdPP+YqftgRMakIoLuJLAy3s7hjHQiDezjJCuq9XGVw
 EfiBt/6JryUUx6xuuGn6QPV2DaCvW/hfR4XkKrvSIcWvQBwTjRqBwTQSlv+aqiEKWvcH
 ouElkVXYi0Vm83jIIIey6xpx4EPhEE3QRSsFuzEassnwVznmnqYZkapzIYGMfXxWrRQs
 IhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726508876; x=1727113676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPUeqriH8UeVOkOmJAooKqkB425UhKhyrGPH3csLiQY=;
 b=kV//3WiBDoKwtRAW9T2R9yRAH2vJ1/QdzcG71q/7/uN8axCYxhDmL4h7UeLt6DNM37
 M7WYhKvSZkxi0WbIJURCWo4cqRbohV/pQ/cbXKODg2b/z910FFOFkgwIn0gK4T9IgkRV
 Tmz4Z0geggu9XfA/nFYqdgcfm/lxYFnXcJr4SsV7hNjm7ukukiPPlg4soAHDP1vVYKwt
 6pON0C9strP9yFT/v5UDFpLHKoyHoo/57Czic1kaDoc4pZK5Ow/20u1bdOkWT06/BvmR
 /ntq5Fe6tnoCHO5nXr0xv3IaJ6dwlFaRGyDOxndhlgh4kGZfTLdDLrE7TBSqCjooeB4C
 uTZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGN3fkAjOIuX8T7Inr3S+ED+TY4p8wojmrjlAPqVwqln82UYZyxZ0k4/bd5ul/7B/AistaArXqOQS8@nongnu.org
X-Gm-Message-State: AOJu0YyKNYEDTrLi2bU9dVoMdO6bWzVMiRJhVcz3nlnPdpXQmzNqVUiv
 sb6FfchTX95SOD0W3zKHXRIy6T0WZQ6/o6rTqV8c+mlIlxMnatNCRYj32CgHKDf0RRQ4P88JG0R
 buI+WDb0/CQwEfe6Lo2fq47/cbO40y4CsP5dQyA==
X-Google-Smtp-Source: AGHT+IEhywZInTtt/ZkcudAWAeJB/p7WHMAsRdAWKra8B/uqpcG13ImPQ83xT1gNHankF4zpgyx0GxyvCEisuzGvBu4=
X-Received: by 2002:a05:6820:221c:b0:5e1:dd09:153b with SMTP id
 006d021491bc7-5e201454b7cmr7549218eaf.7.1726508876068; Mon, 16 Sep 2024
 10:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240909201147.3761639-1-peterx@redhat.com>
 <20240909201147.3761639-2-peterx@redhat.com>
 <441f797f-a377-45de-bfe6-042542c917d8@kaod.org> <ZuRQirmjwWGj1N2D@x1n>
 <CAGNS4TaDVs9eqb9jO5kgi9bL1t1tmc-GywiyP3xpbgFGgvbkLg@mail.gmail.com>
 <881df54b-c98c-4ce0-a434-05d055cc27bb@kaod.org>
 <c488c507-ae5f-4a95-bbb8-c92799f25630@kaod.org>
 <CAGNS4TZew-JwCatS6JpUq29JOPidYwXkB110X7qabjG0Mc6A5g@mail.gmail.com>
 <9cc9cf09-4d56-4e7c-b8f7-602dfff61f4e@kaod.org>
In-Reply-To: <9cc9cf09-4d56-4e7c-b8f7-602dfff61f4e@kaod.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 16 Sep 2024 19:47:44 +0200
Message-ID: <CAGNS4TZnAknXEOEAjV5D95JX2foWx6cRAqTnYoTwn9V4Fhi8JQ@mail.gmail.com>
Subject: Re: [PULL 1/9] softmmu: Support concurrent bounce buffers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc2a.google.com
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

On Mon, Sep 16, 2024 at 3:06=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 9/16/24 14:41, Mattias Nissler wrote:
> > Thanks C=C3=A9dric, I can reproduce now, and my proposed patch fixes av=
oids
> > the crash as expected.
> disk images for macos9 and macosx10 all boot.

Thanks for testing, happy to hear!

I will go ahead and send the change proposed earlier as a patch to the
list then.

>
> C.
>
>
>

