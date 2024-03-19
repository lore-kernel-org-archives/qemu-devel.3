Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA6DC54F7B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmabI-0007oQ-Lo; Tue, 19 Mar 2024 10:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srao@redhat.com>) id 1rmaP8-0006xf-Bs
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srao@redhat.com>) id 1rmaP2-00069g-Mx
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710858315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vs0zNQPuS0zQTBOWdcl3A3HpTkGapmcuFc28uU/bnNI=;
 b=TP7CHC/w+NNzsfQlWhEdKYch3mdyyqZ39sq1MSdxddWq165X5rRWG0cFNUaoFsHUDQnEwR
 jRE4dcZC0zeunbolahTudH/eXIOqQyH7/59dq8d9CcCxcs0BEJR+KhhogV2i/Jq5+ARoAE
 Q0YaTBPkkyPAIJmEw7/KdAwayi1XALQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-Sn7l0sa0M1elL5UMc8K3rA-1; Tue, 19 Mar 2024 10:24:02 -0400
X-MC-Unique: Sn7l0sa0M1elL5UMc8K3rA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29fbe1089b8so1325619a91.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710858240; x=1711463040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vs0zNQPuS0zQTBOWdcl3A3HpTkGapmcuFc28uU/bnNI=;
 b=doL2ePvkMfLl6WyQPPR4ITpNhuGSMXqtZjnBrB4pocNkWsfTEOr3zQrdJz6VTJEeN1
 csDo9G6m5L71j+gWlRGTiQBmq1/fSM4gFfZQjw+QMGnBsPrwIO7ZvZMNqxHPipq9XIfh
 f3tYoFACc/7GhS7aHUzZLFVGb8dK9wmOXEWXzJtcx9hg7LpcTIRjBP+VZIt8NHjl3WbC
 z/7+S2cjp5zhx6P70Y7Udd6W1uYZfY/cLykGo+980OnZrTEps/p8GzxMh5nLR9/FFlrN
 yHiNRDonKekkUg21Ir2wA+XcTD4lfUf0ukDSWrsy8/+fYT29Hz0orYlB3JCGshIhqpjP
 fXRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqEpZKXygVXJjsH9gaxu0AcB/G12PdyPFOZVxbxTQjAs1C+eQo0JP001r+OhJyCah5HcVGod+FgHfVGmWujmouPJcI6mI=
X-Gm-Message-State: AOJu0YycvQww+vJxOwOrr5fQqAeHqGnU3tyE5N6ZFpF5mGwwH6alLrrX
 5T0qJn2YeGVSXcgsQxoWR890EB8Sx/jbo+f5ZMa/MKmfumxosY2t2jaye60p8taOZWEJ1XUqQ+z
 DQz7in1AtJ4wY4qsP6hnTVI+KtaMlhdkRUjBJ36RrYYZLEYX4lYFGUEgZ5I48H9WGowBnxPj2sT
 QtwlujPszjVAX6fzT1W2KSGh1p9kM=
X-Received: by 2002:a17:90b:1487:b0:29b:e26a:3239 with SMTP id
 js7-20020a17090b148700b0029be26a3239mr9240397pjb.47.1710858240235; 
 Tue, 19 Mar 2024 07:24:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPwe3rN96lp9P2/m4pAH0RWz6fBSgKG/Z6BcGRXRe9FIWVyAxURrWpsMry5aoGWLRpTGWYBHM1mq2nPiOobTw=
X-Received: by 2002:a17:90b:1487:b0:29b:e26a:3239 with SMTP id
 js7-20020a17090b148700b0029be26a3239mr9240378pjb.47.1710858239866; Tue, 19
 Mar 2024 07:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240318183429.1039340-1-stefanha@redhat.com>
 <ZfmT1s8hcW48KIn1@redhat.com>
In-Reply-To: <ZfmT1s8hcW48KIn1@redhat.com>
From: Sanjay Rao <srao@redhat.com>
Date: Tue, 19 Mar 2024 10:23:48 -0400
Message-ID: <CACt6rRD0AMVOh5TKLy+g8wGv_r_egpkbBZE3SO6F0EhskevCqw@mail.gmail.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Boaz Ben Shabat <bbenshab@redhat.com>, Joe Mario <jmario@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a61cda061404394a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=srao@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 Mar 2024 10:37:53 -0400
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

--000000000000a61cda061404394a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 9:32=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote=
:

> Am 18.03.2024 um 19:34 hat Stefan Hajnoczi geschrieben:
> > The coroutine pool implementation can hit the Linux vm.max_map_count
> > limit, causing QEMU to abort with "failed to allocate memory for stack"
> > or "failed to set up stack guard page" during coroutine creation.
> >
> > This happens because per-thread pools can grow to tens of thousands of
> > coroutines. Each coroutine causes 2 virtual memory areas to be created.
> > Eventually vm.max_map_count is reached and memory-related syscalls fail=
.
> > The per-thread pool sizes are non-uniform and depend on past coroutine
> > usage in each thread, so it's possible for one thread to have a large
> > pool while another thread's pool is empty.
> >
> > Switch to a new coroutine pool implementation with a global pool that
> > grows to a maximum number of coroutines and per-thread local pools that
> > are capped at hardcoded small number of coroutines.
> >
> > This approach does not leave large numbers of coroutines pooled in a
> > thread that may not use them again. In order to perform well it
> > amortizes the cost of global pool accesses by working in batches of
> > coroutines instead of individual coroutines.
> >
> > The global pool is a list. Threads donate batches of coroutines to when
> > they have too many and take batches from when they have too few:
> >
> > .-----------------------------------.
> > | Batch 1 | Batch 2 | Batch 3 | ... | global_pool
> > `-----------------------------------'
> >
> > Each thread has up to 2 batches of coroutines:
> >
> > .-------------------.
> > | Batch 1 | Batch 2 | per-thread local_pool (maximum 2 batches)
> > `-------------------'
> >
> > The goal of this change is to reduce the excessive number of pooled
> > coroutines that cause QEMU to abort when vm.max_map_count is reached
> > without losing the performance of an adequately sized coroutine pool.
> >
> > Here are virtio-blk disk I/O benchmark results:
> >
> >       RW BLKSIZE IODEPTH    OLD    NEW CHANGE
> > randread      4k       1 113725 117451 +3.3%
> > randread      4k       8 192968 198510 +2.9%
> > randread      4k      16 207138 209429 +1.1%
> > randread      4k      32 212399 215145 +1.3%
> > randread      4k      64 218319 221277 +1.4%
> > randread    128k       1  17587  17535 -0.3%
> > randread    128k       8  17614  17616 +0.0%
> > randread    128k      16  17608  17609 +0.0%
> > randread    128k      32  17552  17553 +0.0%
> > randread    128k      64  17484  17484 +0.0%
> >
> > See files/{fio.sh,test.xml.j2} for the benchmark configuration:
> >
> https://gitlab.com/stefanha/virt-playbooks/-/tree/coroutine-pool-fix-sizi=
ng
> >
> > Buglink: https://issues.redhat.com/browse/RHEL-28947
> > Reported-by: Sanjay Rao <srao@redhat.com>
> > Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>
> > Reported-by: Joe Mario <jmario@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>
> Though I do wonder if we can do something about the slight performance
> degradation that Sanjay reported. We seem to stay well under the hard
> limit, so the reduced global pool size shouldn't be the issue. Maybe
> it's the locking?
>
> We are only seeing a slight fall off from our much improved numbers with
the addition of iothreads. I am not very concerned. With database
workloads, there's always a run to run variation. Especially when there's a
lot of idle cpus on the host. To reduce the run to run variation, we use
cpu / numa pinning and other methods like pci passthru. If I get a chance,
I will do some runs with cpu pinning to see what the numbers look like.



> Either way, even though it could be called a fix, I don't think this is
> for 9.0, right?
>
> Kevin
>
>

--=20

Sanjay Rao
Sr. Principal Performance Engineer                   Phone: 978-392-2479
Red Hat, Inc.                                    FAX: 978-392-1001
314 Littleton Road                               Email: srao@redhat.com
Westford, MA 01886

--000000000000a61cda061404394a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 19, 2024 at 9:32=E2=80=AF=
AM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 18=
.03.2024 um 19:34 hat Stefan Hajnoczi geschrieben:<br>
&gt; The coroutine pool implementation can hit the Linux vm.max_map_count<b=
r>
&gt; limit, causing QEMU to abort with &quot;failed to allocate memory for =
stack&quot;<br>
&gt; or &quot;failed to set up stack guard page&quot; during coroutine crea=
tion.<br>
&gt; <br>
&gt; This happens because per-thread pools can grow to tens of thousands of=
<br>
&gt; coroutines. Each coroutine causes 2 virtual memory areas to be created=
.<br>
&gt; Eventually vm.max_map_count is reached and memory-related syscalls fai=
l.<br>
&gt; The per-thread pool sizes are non-uniform and depend on past coroutine=
<br>
&gt; usage in each thread, so it&#39;s possible for one thread to have a la=
rge<br>
&gt; pool while another thread&#39;s pool is empty.<br>
&gt; <br>
&gt; Switch to a new coroutine pool implementation with a global pool that<=
br>
&gt; grows to a maximum number of coroutines and per-thread local pools tha=
t<br>
&gt; are capped at hardcoded small number of coroutines.<br>
&gt; <br>
&gt; This approach does not leave large numbers of coroutines pooled in a<b=
r>
&gt; thread that may not use them again. In order to perform well it<br>
&gt; amortizes the cost of global pool accesses by working in batches of<br=
>
&gt; coroutines instead of individual coroutines.<br>
&gt; <br>
&gt; The global pool is a list. Threads donate batches of coroutines to whe=
n<br>
&gt; they have too many and take batches from when they have too few:<br>
&gt; <br>
&gt; .-----------------------------------.<br>
&gt; | Batch 1 | Batch 2 | Batch 3 | ... | global_pool<br>
&gt; `-----------------------------------&#39;<br>
&gt; <br>
&gt; Each thread has up to 2 batches of coroutines:<br>
&gt; <br>
&gt; .-------------------.<br>
&gt; | Batch 1 | Batch 2 | per-thread local_pool (maximum 2 batches)<br>
&gt; `-------------------&#39;<br>
&gt; <br>
&gt; The goal of this change is to reduce the excessive number of pooled<br=
>
&gt; coroutines that cause QEMU to abort when vm.max_map_count is reached<b=
r>
&gt; without losing the performance of an adequately sized coroutine pool.<=
br>
&gt; <br>
&gt; Here are virtio-blk disk I/O benchmark results:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RW BLKSIZE IODEPTH=C2=A0 =C2=A0 OLD=C2=A0 =
=C2=A0 NEW CHANGE<br>
&gt; randread=C2=A0 =C2=A0 =C2=A0 4k=C2=A0 =C2=A0 =C2=A0 =C2=A01 113725 117=
451 +3.3%<br>
&gt; randread=C2=A0 =C2=A0 =C2=A0 4k=C2=A0 =C2=A0 =C2=A0 =C2=A08 192968 198=
510 +2.9%<br>
&gt; randread=C2=A0 =C2=A0 =C2=A0 4k=C2=A0 =C2=A0 =C2=A0 16 207138 209429 +=
1.1%<br>
&gt; randread=C2=A0 =C2=A0 =C2=A0 4k=C2=A0 =C2=A0 =C2=A0 32 212399 215145 +=
1.3%<br>
&gt; randread=C2=A0 =C2=A0 =C2=A0 4k=C2=A0 =C2=A0 =C2=A0 64 218319 221277 +=
1.4%<br>
&gt; randread=C2=A0 =C2=A0 128k=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 17587=C2=
=A0 17535 -0.3%<br>
&gt; randread=C2=A0 =C2=A0 128k=C2=A0 =C2=A0 =C2=A0 =C2=A08=C2=A0 17614=C2=
=A0 17616 +0.0%<br>
&gt; randread=C2=A0 =C2=A0 128k=C2=A0 =C2=A0 =C2=A0 16=C2=A0 17608=C2=A0 17=
609 +0.0%<br>
&gt; randread=C2=A0 =C2=A0 128k=C2=A0 =C2=A0 =C2=A0 32=C2=A0 17552=C2=A0 17=
553 +0.0%<br>
&gt; randread=C2=A0 =C2=A0 128k=C2=A0 =C2=A0 =C2=A0 64=C2=A0 17484=C2=A0 17=
484 +0.0%<br>
&gt; <br>
&gt; See files/{fio.sh,test.xml.j2} for the benchmark configuration:<br>
&gt; <a href=3D"https://gitlab.com/stefanha/virt-playbooks/-/tree/coroutine=
-pool-fix-sizing" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/s=
tefanha/virt-playbooks/-/tree/coroutine-pool-fix-sizing</a><br>
&gt; <br>
&gt; Buglink: <a href=3D"https://issues.redhat.com/browse/RHEL-28947" rel=
=3D"noreferrer" target=3D"_blank">https://issues.redhat.com/browse/RHEL-289=
47</a><br>
&gt; Reported-by: Sanjay Rao &lt;<a href=3D"mailto:srao@redhat.com" target=
=3D"_blank">srao@redhat.com</a>&gt;<br>
&gt; Reported-by: Boaz Ben Shabat &lt;<a href=3D"mailto:bbenshab@redhat.com=
" target=3D"_blank">bbenshab@redhat.com</a>&gt;<br>
&gt; Reported-by: Joe Mario &lt;<a href=3D"mailto:jmario@redhat.com" target=
=3D"_blank">jmario@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.c=
om" target=3D"_blank">stefanha@redhat.com</a>&gt;<br>
<br>
Reviewed-by: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=3D"_=
blank">kwolf@redhat.com</a>&gt;<br>
<br>
Though I do wonder if we can do something about the slight performance<br>
degradation that Sanjay reported. We seem to stay well under the hard<br>
limit, so the reduced global pool size shouldn&#39;t be the issue. Maybe<br=
>
it&#39;s the locking?<br>
<br></blockquote><div>We are only seeing a slight fall off from our much im=
proved numbers with the addition of iothreads. I am not very concerned. Wit=
h database workloads, there&#39;s always a run to run variation. Especially=
 when there&#39;s a lot of idle cpus on the host. To reduce the run to run =
variation, we use cpu / numa pinning and other methods like pci passthru. I=
f I get a chance, I will do some runs with cpu pinning to see what the numb=
ers look like.</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
Either way, even though it could be called a fix, I don&#39;t think this is=
<br>
for 9.0, right?<br>
<br>
Kevin<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><pre cols=3D"72"=
>Sanjay Rao=20
Sr. Principal Performance Engineer                   Phone: 978-392-2479=20
Red Hat, Inc.                                    FAX: 978-392-1001=20
314 Littleton Road                               Email: <a href=3D"mailto:s=
rao@redhat.com" target=3D"_blank">srao@redhat.com</a>=20
Westford, MA 01886 </pre></div></div></div></div></div></div></div>

--000000000000a61cda061404394a--


