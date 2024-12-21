Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFB6E77188
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 02:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOpdl-0007XM-41; Fri, 20 Dec 2024 21:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOpdj-0007Wc-2R; Fri, 20 Dec 2024 21:54:51 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOpdh-0008AS-H5; Fri, 20 Dec 2024 21:54:50 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso24850845ad.3; 
 Fri, 20 Dec 2024 18:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734749687; x=1735354487; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IR1ONrbG+4Eu5GMmRAwxZJqrILWRUFwZXkXfN2DLQvs=;
 b=Q/v0Qsld93zLop3aezYUwOYt5FG/OYx4Dp23SdXFSi0rfVYDZqJg/Q52vt1nRO6S+i
 +YVWvJAzAr6hAiGlGUBkL/PEG67L1oLY6hYTuNuVhJVzzv2J2yYllXYnqk8PuK0WFGCr
 KcNnjYRRzXPAMLWyV9Qy8oMCI7EbCfk/3JAr4aFedouQPUtVYFRPbHKYz6HApdNQeRDY
 Phq8IxS0fImxrK6qWtiLRFssEav3Uhzclt8XxcNtVaL8ueqtGio11DMsxGj0r238Ob6a
 03okjjfbyqBho4Ei7OlnLgxw/7UgsgvuviydFYFf/8pl9rUWJjJwcwMYIQUrlOWjnU1Y
 i2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734749687; x=1735354487;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IR1ONrbG+4Eu5GMmRAwxZJqrILWRUFwZXkXfN2DLQvs=;
 b=Z/qJHOjN0ahbLl/nXoJvR8+AQgIF+nhkvdeFuk+sWRfFv22drwFVYGSr9pNMYN0f+V
 HzGeQnayMbDsevBcRANcqER89hehG6vC3A3J/jK73dJXAZ0AICpfv28fHwx1+IY3OqoA
 dvi1QFyUmmBOOLpfS9IW4Qfw3CxIFoHvVljcsrz4Af9bK7f49Mij9jKf2XhRl6i3+Oyq
 as0omGIG125vxNqyJq+Tlf4NsZPNoTFEsurNf+AKzvVE84SqxucURyiv+NDX0kN44dKE
 19aNp5IEfDae7qisK5wEPDSh0p2Xxwe4KhIUUlsQlk5Iuh3YPK6nIWV2yHLixNQBRaaf
 05YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXLg6TIOzXIgQVvpHwbTNtFCUmh2NBuldWaNbZc1xyI1mh1u/3PglTaiC5zatokphsNF4OdPGdjdcx@nongnu.org
X-Gm-Message-State: AOJu0YyTH/BawH3ooqSK9JtPalFqNGIAucNuC5aBmjSiUwcvUBmBJeRY
 aXy5LscdblU4qceMgiQ55aJE2o5C61zH2lMU2PLDUsWYGbOF0oqWsVD00g==
X-Gm-Gg: ASbGncsma+xbeiJ/eCIx4grpniSTxiz58t/FPsVB4770eVlLLBbG1MvdPcE2ECoFBxE
 ruMixPtnwQTYPeGjYYI0IBDAVLZg+Nvl1264kaJ2w4J5V4JCsOGZ/p7+7nDBaycmnzKVXGuoSI5
 yUNF7kWAfOj7G1I0+3poUt5swJmFPRmYV6mza4XsOiLdOvU9rqfC+Xwq2X3PD3/RnRcJbp9q0mQ
 On1c2J9uXyLbVxWgaOSl4baDQpu6E1eIURwAZAJmJDNF878EJVx
X-Google-Smtp-Source: AGHT+IHIjI+N0bxfYcGEQVavbDZFIczqkticzIh90WhpqtYsmal40ATnsD1FUJoA3t6pHomk6hwzIw==
X-Received: by 2002:a17:903:41c1:b0:215:b45a:6a63 with SMTP id
 d9443c01a7336-219e6ec0883mr75028145ad.32.1734749687038; 
 Fri, 20 Dec 2024 18:54:47 -0800 (PST)
Received: from localhost ([203.221.215.169]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dca02888sm35857975ad.261.2024.12.20.18.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 18:54:46 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 12:54:37 +1000
Message-Id: <D6H1FS7JDKTL.306GHC0OE910D@gmail.com>
Subject: Re: [PATCH 02/17] replay: Fix migration replay_mutex locking
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Fabiano Rosas" <farosas@suse.de>, <qemu-devel@nongnu.org>
Cc: <qemu-block@nongnu.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Kevin Wolf" <kwolf@redhat.com>, "Hanna Reitz"
 <hreitz@redhat.com>, "Pavel Dovgalyuk" <pavel.dovgaluk@ispras.ru>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Stefan Hajnoczi" <stefanha@redhat.com>,
 "Fam Zheng" <fam@euphon.net>, "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "John Snow" <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Jason Wang" <jasowang@redhat.com>, "Vladimir Sementsov-Ogievskiy"
 <vsementsov@yandex-team.ru>, "Peter Xu" <peterx@redhat.com>, "Dr. David
 Alan Gilbert" <dave@treblig.org>, "Markus Armbruster" <armbru@redhat.com>,
 "Michael Roth" <michael.roth@amd.com>, "Wainer dos Santos Moschetta"
 <wainersm@redhat.com>
X-Mailer: aerc 0.18.2
References: <20241220104220.2007786-1-npiggin@gmail.com>
 <20241220104220.2007786-3-npiggin@gmail.com> <87r062tscl.fsf@suse.de>
In-Reply-To: <87r062tscl.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

On Fri Dec 20, 2024 at 11:08 PM AEST, Fabiano Rosas wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> Hi Nick,
>
> I'm ignorant about replay, but we try to know why were taking the BQL in
> the migration code, we move it around sometimes, etc. Can we be a bit
> more strict with documentation here so we don't get stuck with a lock
> that can't be changed?
>
> > Migration causes a number of events that need to go in the replay
> > trace, such as vm state transitions. The replay_mutex lock needs to
> > be held for these.
> >
>
> Is it practical to explicitly list which events are those?

As a general rule it is something like "while the target can be
producing or consuming rr events".

There is some record-replay handling in snapshot code (flush
events, get icount, etc) as well as SHUTDOWN_CAUSE_SNAPSHOT_LOAD
event generated and possibly a few other things. So for migration
it's not just a side effect of calling other APIs, but it is
explicitly "replay-aware", at least in some part.

I actually don't know full details about how snapshot/migrate
and record-replay work together. I know reverse debugging can
use snapshots to load the most recent possible state to
minimize replay, but that is "external" to the machine itself.
But I don't know why you would want to record and replay snapshot
loading as part of the trace. But facility exists. Pavel
understands all the big picture much better.

> Are there any tests that exercise this that we could use to validate
> changes around this area?

Yes I added some more avocado testing which includes snapshotting
while recording, and that's where I hit these bugs. I do plan to
submit that up as soon as this series gets in, just trying to keep
things managable. In that case we could defer this patch from this
series (the replay_linux test does not do any snapshotting as yet).

I think once you have some regression tests, you probably won't
have to worry _too_ much about record/replay details in migraiton.

>
> > The simplest approach seems to be just take it up-front when taking
> > the bql.
>
> But also the thing asserts if taken inside the BQL, so is the actual
> matter here that we _cannot_ take the lock around the proper places?

Yes, that is part of it in this case. Some other code drops the
bql then retakes both... but that is more complex and requires
knowledge of calling bql context to be sure it is safe to drop.

> I also see the replay lock around the main loop, so is it basically bql2
> from the perspective of most of QEMU?

Unfortunately it is a big scope yes. Basically it needs to
maintain atomicity between the event log entry that we record or
replay (run N instructions; raise an interrupt; get a character
from keyboard; etc.,) and the actual running of that operation
in the machine.

Thanks,
Nick

