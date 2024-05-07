Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1EAC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LWt-0005s1-Hv; Tue, 07 May 2024 10:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4LWr-0005pj-80
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:10:49 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4LWp-0002EK-Fv
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:10:48 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-23f2996b634so1732240fac.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715091046; x=1715695846;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3R6Lk/QApqGQwg4iLpmJs4WsUbaQofw/C9Sm7wgwQPM=;
 b=ZucqT3VsgeknayTPrxeOK18uf41AxjEfKfc8hCoMbBXIGaWAK4kbm61gKND/qYW+Kk
 p937eDbU6Dv1EA6Duf31iAyrYXhHx/MVg5Vndn3wYpXxaostOr73EUnW398LNmye6mMS
 86hUMyS6ZLObku/KOVbIUhPkXW+trYvgPQkti8Z4OyEMIVKPxUHXy6/RREYDFJFj3INM
 s80fnm4nuiEYr4RHIob4TNmlmf5iUEkKXWqna/cA/ibI3gpaikF/9hKMTg4cXkWpTRY1
 v71Xk9shoX5v2mj7wevgsjr+2H5XAiQPrhkOVVUKnaWLVPxC8KP6XvKP8yLVHN4y/mWA
 Iw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715091046; x=1715695846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3R6Lk/QApqGQwg4iLpmJs4WsUbaQofw/C9Sm7wgwQPM=;
 b=lDjbgAhOM3mQjJajpNvu98wwcBn/KJFGDaZb+vA57nPMYMLladO/TWYA0TJWBsvvZc
 sagLRBmJgGNEtxno9DqFVGQnkghXV4LmFWRCOFj/ekzRqt8z5igVnDh6CXkCEI0VQKTB
 C/Rrdf7nTt9nm9F1toI/C4GCg8Ii9LuifnvhHXyql7stHEladpIZ+ZMl3BZvEQh243vG
 RmKtFJak6xZD7l1ryikdwvLVPVd3heaXPhW/UTKKDFgL6mAO9Ms4AZ7h5OUoMLV83ZJ/
 quVL1zrjk5FXZ+9oSrKequuSakQmy2AZqSxHDG4oPOK9Szc7zFkCasgW/X+JoXjjDHPP
 JUZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6EsDhEaDhALL7ytnY3wE+Xhl/sdmByLCxev977Wqhw82Y/WsXQRp8MPjCHaIC/B5fd8w2xgjt4m3hqWhlYLLaxwi+y0A=
X-Gm-Message-State: AOJu0YzmjFJs+U7XlELiPYI3b125E90L4Al3lzR2qKMD8lhB2K5IYAOE
 MxhkyNsFQZvrPz101z1KElhICcfvzX7nKCX/WKQG4Yd5TF1L1Nz6A/s7T/Zly3VP2HKe2yb0Uh/
 h8rnDsSltXp2RJri+DU1fB4J8LKd4eDx7vN3QEA==
X-Google-Smtp-Source: AGHT+IFa/6TO1BQN23FrKhR7IdURQmJIqvvpgvXuxA7eCmq3rwYHlV58fJmcXJmem05niRBk5xnOsKYc4vlcpbhxszY=
X-Received: by 2002:a05:6870:55cb:b0:23c:2690:20ed with SMTP id
 qk11-20020a05687055cb00b0023c269020edmr14564362oac.28.1715091045811; Tue, 07
 May 2024 07:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240507123025.93391-1-philmd@linaro.org>
 <CAGNS4Ta9aV7ch5DCdMe=Pk3eB_3+0xx8fCekvuiAPb6hz=Yx_g@mail.gmail.com>
 <2280ede5-0455-4086-9925-bd9d473d190a@linaro.org>
In-Reply-To: <2280ede5-0455-4086-9925-bd9d473d190a@linaro.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 7 May 2024 16:10:34 +0200
Message-ID: <CAGNS4TYfUN8NwtxoPY8XpVKG19TeaugEzL_cDswB8aUFhg0sKA@mail.gmail.com>
Subject: Re: [PATCH 0/3] system/physmem: Propagate AddressSpace to MapClient
 helpers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, john.levon@nutanix.com, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x29.google.com
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

On Tue, May 7, 2024 at 4:02=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 7/5/24 14:47, Mattias Nissler wrote:
> > On Tue, May 7, 2024 at 2:30=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <phi=
lmd@linaro.org> wrote:
> >>
> >> Respin of Mattias patch [1 split to ease review.
> >> Preliminary use QEMU_LOCK_GUARD to simplify.
> >>
> >> I'm OK to include this and the endianness fix [2]
> >> if Mattias agrees, once first patch is reviewed.
> >
> > To be honest, given that this patch series has been lingering for
> > almost a year now, I'm fine with whatever gets us closer to getting
> > this landed. I believe Peter was also considering doing a pull request
> > for the series, so you may want to coordinate with him if you haven't
> > already.
>
> Well I'm sorry, today is the first time I've been looking at it,
> and was trying to help reviewing. I see I was Cc'ed on earlier
> versions but missed them. OK, I'll see with Peter.

It's fine, sorry for being a bit negative.

