Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED251C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsyp-0001pu-9k; Tue, 25 Feb 2025 06:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmsyl-0001oe-8O
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:19:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmsyh-0000za-AE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740482386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0io6ySSM5ej83Ld1cHgExCtQZQEElVh+dWV/5hGTYI=;
 b=Rv5v8Jd9NZnHp2gTGMsnFmth8+rfVknDX0ySHbxnmrljc3rxzBXh9hU1oqeAiwTKQu2T6/
 VEVxhweCZaEJlXyVl095m8WvgB+kBTqVztptf9UhFyslT5rZyBaVGrAM1o+XDRsW1UCMrS
 FfdNCHGOqh4KFmqL+kEPWvar8/bn558=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-Ud9VdWbvO-qA9Sc57yE1Pw-1; Tue, 25 Feb 2025 06:19:43 -0500
X-MC-Unique: Ud9VdWbvO-qA9Sc57yE1Pw-1
X-Mimecast-MFC-AGG-ID: Ud9VdWbvO-qA9Sc57yE1Pw_1740482382
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f338525e1so2275466f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740482382; x=1741087182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0io6ySSM5ej83Ld1cHgExCtQZQEElVh+dWV/5hGTYI=;
 b=TkZ/SoY+wAh3w4vZbjIxeZMN/r5Di/Eu9IdzWKNDt8dJZRhWUJKuCmGu9eVcPHxmvX
 cah96Yx+5T6ljDG9E67pHbREM3PzAu7tahMUqaMgAHXWfmXTnwgie4otTq/feT/KY8Pp
 HzLOAdw88u/DNzxWs9zyE3v2uo4SqrEfisXkBNC/6+zV6zuaWpifdvnS8gGVX1rsbQ8P
 Q4c520HEBbDeYTn/I4F4XmZEYaRGjPcDLFW86QlSGqQazRenfSj5a9vM6h70sVSSBERJ
 nYuafyz+P9nqprhYFn6jAFBrjlAH1imDgCbIo4KaRnN4tYfaTOTcfGYYa9bIiMLE0U+7
 RtuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/MNtfzCy7L0/EbWnMX0h/tT24W5Y7cRWLgA2AzVVg6WQow67VyEagAdMnUVRkHGEEnTlioVk4gCYM@nongnu.org
X-Gm-Message-State: AOJu0YxZHInDH8qJluxL4W1ANAD/i3Mw92GofRC6kZmVE7kyiKd8mzrz
 FNZ6PaHwg2/H6xjJX59tHxBgrk17SEAcvOxfEWOUsuDngaYN4BI6MaAXMfe2ef1hHBUyhn4CEnA
 MJbGtURH1dD/9irOSn3ov3gBQH1onG61z8JV8Zqa5lNlyOJT7eGbm
X-Gm-Gg: ASbGncstoOgdLHFUueLBwlJblEoBjJD8X5XUTW4t8exuFHvoG2CNTwKzbNuU7SqeSSu
 WKIsewHV5cED1sjjU3wzf0jqzpE4TDOCFz0zAKWWDAw2awevAe4CRX5qSxHXwZd/Ts8qoxWGwQN
 9RkOSFakEs5cQ5KTaQql1AYWqzvQNtdZW5j3bkcUnC2yzmk9VTfiJLaqqTw1B/tsVTYQH3GFEmo
 zCxKqK9rzcDzbTSVllVwRo8tqzeCbJK8D+lbRmSjiWUE616B9o3uhESfA+/70W2hDcFz5Lr48/P
 vdIwM/ittrWeHu89Z7mCQhFSkGZXN464DmgmcOasFcwRgUBMcnFnr7UyAGGtTv4=
X-Received: by 2002:a5d:6dae:0:b0:38f:4b2c:2464 with SMTP id
 ffacd0b85a97d-38f708626c6mr13087750f8f.55.1740482382299; 
 Tue, 25 Feb 2025 03:19:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5If+e8uydgroaBKofhWOCk66OLcSAGV1a5YRWSzA7HvQUEtYTJkl7bMOtCNhQmlKX5LrX7g==
X-Received: by 2002:a5d:6dae:0:b0:38f:4b2c:2464 with SMTP id
 ffacd0b85a97d-38f708626c6mr13087717f8f.55.1740482381764; 
 Tue, 25 Feb 2025 03:19:41 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86cc6asm1968277f8f.35.2025.02.25.03.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:19:41 -0800 (PST)
Date: Tue, 25 Feb 2025 12:19:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gavin Shan <gshan@redhat.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <mst@redhat.com>, <anisinha@redhat.com>,
 <gengdongjiu1@gmail.com>, <peter.maydell@linaro.org>,
 <pbonzini@redhat.com>, <shan.gavin@gmail.com>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 4/4] target/arm: Retry pushing CPER error if necessary
Message-ID: <20250225121939.7e0e2304@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250221110435.00004a3b@huawei.com>
References: <20250214041635.608012-1-gshan@redhat.com>
 <20250214041635.608012-5-gshan@redhat.com>
 <20250219185518.767a48d9@imammedo.users.ipa.redhat.com>
 <7caa54df-abe1-4833-bb59-cb83f8241962@redhat.com>
 <20250221110435.00004a3b@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 21 Feb 2025 11:04:35 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 21 Feb 2025 15:27:36 +1000
> Gavin Shan <gshan@redhat.com> wrote:
>=20
> > On 2/20/25 3:55 AM, Igor Mammedov wrote: =20
> > > On Fri, 14 Feb 2025 14:16:35 +1000
> > > Gavin Shan <gshan@redhat.com> wrote:
> > >    =20
> > >> The error -1 is returned if the previously reported CPER error
> > >> hasn't been claimed. The virtual machine is terminated due to
> > >> abort(). It's conflicting to the ideal behaviour that the affected
> > >> vCPU retries pushing the CPER error in this case since the vCPU
> > >> can't proceed its execution.
> > >>
> > >> Move the chunk of code to push CPER error to a separate helper
> > >> report_memory_errors() and retry the request when the return
> > >> value from acpi_ghes_memory_errors() is greater than zero.
> > >>
> > >> Signed-off-by: Gavin Shan <gshan@redhat.com>
> > >> ---
> > >>   target/arm/kvm.c | 31 +++++++++++++++++++++++++------
> > >>   1 file changed, 25 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > >> index 5c0bf99aec..9f063f6053 100644
> > >> --- a/target/arm/kvm.c
> > >> +++ b/target/arm/kvm.c
> > >> @@ -2362,6 +2362,30 @@ int kvm_arch_get_registers(CPUState *cs, Erro=
r **errp)
> > >>       return ret;
> > >>   }
> > >>  =20
> > >> +static void report_memory_error(CPUState *c, hwaddr paddr)
> > >> +{
> > >> +    int ret;
> > >> +
> > >> +    while (true) {
> > >> +        /* Retry if the previously report error hasn't been claimed=
 */
> > >> +        ret =3D acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr=
, true);
> > >> +        if (ret <=3D 0) {
> > >> +            break;
> > >> +        }
> > >> +
> > >> +        bql_unlock();
> > >> +        g_usleep(1000);   =20
> >=20
> > Igor, thanks for the detailed comments. Sorry for a bit delay of the re=
ply, I
> > was checking the code to understand it better :) =20
>=20
> This is moderately tricky stuff so I'm not 100% sure of some of the things
> I said below, but will be traveling for next few weeks so want to get some
> comments out before that!
>=20
> >  =20
> > > even with bql released it's not safe to loop in here.
> > > consider,
> > >    a guest with 2 vcpus
> > >      * vcpu 1 gets SIGBUS due to error
> > >      * vcpu 2 trips over the same error and gets into this loop
> > >      * on guest side vcpu 1 continues to run to handle SEA but
> > >        might need to acquire a lock that vcpu 2 holds
> > >    =20
> >=20
> > Agreed.
> >  =20
> > > GHESv2 error source we support, can report several errors,
> > > currently QEMU supports only 1 'error status block' which
> > > can hold several error records (CPER) (though storage size is limited)
> > >=20
> > > 1:
> > > We can potentially add support for more GHESv2 error sources
> > > with their own Read ACK registers (let's say =3Dmax_cpus)
> > > (that is under assumption that no other error will be
> > > triggered while guest VCPUs handle their own SEA (upto clearing Read =
ACK)) =20
>=20
> This one seems straight forward but I'd kind of like to know if real syst=
ems
> do this (I'll try and find out about ours).  I don't think there is
> any association available between a cpu and and SEA source, so linux at
> least will just go looking for any that are active on each SEA.
> Locking looks fine but it won't help with performance
>=20
> > >=20
> > > 2:
> > > Another way could be for QEMU to allocate more error status _blocks_
> > > for the only one error source it has now and try to find
> > > empty status block to inject new error(s). =20
>=20
> Let me try to get my head around this one...
>=20
> Each GHESv2 entry points, indirectly, to a single error status block at a=
 time
> (only one address to read that from)  Curious quirk is the length for that
> error status block is fixed as that's just a value in GHESv2 not an indir=
ection
> via a register - however I think you can just make it 'big'.
> So what I think you are proposing here is that on read_ack write (which w=
e would
> need to monitor for, the value of the error status address register is up=
dated
> to point to next one of a queue of error blocks.

All my suggestions here aren't recommendation, but rather thinking out loud
to see if we can find a crorrect way to deal with the issue.

The part I don't fancy doing on QEMU part is read_ack write intercept.

>=20
> That can work.  I'm not sure it actually gets us anything over just queui=
ng in
> qemu and writing the same error status block.  Those status blocks can co=
ntain

benefit would be that we won't have to maintain state on QEMU side
and then migrate it.

> multiple Generic Error Data entries, but unless we have a load of them ga=
thered
> up at time of first notifying the guest, I'm not sure that helps us.
>=20
> One thing that I'm nervous about is that I can't actually find spec langu=
age
> that says that the OS 'must' reread the error status address register on
> each event. That isn't mentioned in the GHESv2 flow description which jus=
t says:

that bothers me as well.

> "
> These are the steps the OS must take once detecting an error from a parti=
cular GHESv2 error source:
> =E2=80=A2 OSPM detects error (via interrupt/exception or polling the bloc=
k status)
> =E2=80=A2 OSPM copies the error status block
> =E2=80=A2 OSPM clears the block status field of the error status block
> =E2=80=A2 OSPM acknowledges the error via Read Ack register. For example:
> =E2=80=93 OSPM reads the Read Ack register =E2=80=93> X
> =E2=80=93 OSPM writes =E2=80=93> (( X & ReadAckPreserve) | ReadAckWrite)
> "
>=20
> The linux code is confusing me, but I think it wonderfully changes
> the fixmap on every access as it needs to do an ioremap type operation
> in NMI conditions.
>=20
> > >   * it can be saturated with high rate of errors (so what do we do in=
 case it happens?) =20
>=20
> Make it big :)  But sure big just makes the condition unlikely rather tha=
n solving it.
>=20
> > >   * subject to race between clearing/setting Read ACK
> > >      (maybe it can dealt with that on side by keeping internal read_a=
ck counter) =20
>=20
> I don't think there are any races as long as we update the register only =
on clear which
> should I think happen before the next SEA can happen? My understanding, w=
hich may
> be wrong, is the OS must just take a copy of the error status block and s=
et the
> read_ack all in the exception handler.
>=20
> > >=20
> > > 3:
> > > And alternatively, queue incoming errors until read ack is cleared
> > > and then inject pending errors in one go.
> > > (problem with that is that at the moment QEMU doesn't monitor
> > > read ack register memory so it won't notice guest clearing that) =20
>=20
> We'd need to monitor it definitely.  Injecting all we have queued up
> in one go here seems like a reasonable optimization over doing them
> one at a time.
>=20
> > >=20
> > >=20
> > > Given spec has provision for multiple error status blocks/error data =
entries
> > > it seems that #2 is an expected way to deal with the problem.
> > >    =20
> >=20
> > I would say #1 is the ideal model because the read_ack_register is the =
bottleneck
> > and it should be scaled up to max_cpus. In that way, the bottleneck can=
 be avoided
> > from the bottom. Another benefit with #1 is the error can be delivered =
immediately
> > to the vCPU where the error was raised. This matches with the syntax of=
 SEA to me. =20
>=20
> I don't think it helps for the bottleneck in linux at least.  A whole bun=
ch of locks
> are taken on each SEA because of the novel use of the fixmap.  There is o=
nly one
> VA ever used to access the error status blocks we just change what PA it =
points to
> under a spin lock. Maybe that can be improved on if we can persuade peopl=
e that error
> handling performance is a thing to care about!
>=20
> >=20
> > #2 still has the risk to saturate the multiple error status blocks if t=
here are
> > high rate of errors as you said. Besides, the vCPU where read_ack_regis=
ter is acknoledged
> > can be different from the vCPU where the error is raised, violating the=
 syntax of
> > SEA.
> >=20
> > #3's drawback is to violate the syntax of SEA, similar to #2.
> >=20
> > However, #2/#3 wouldn't be that complicated to #1. I didn't expect big =
surgery to
> > GHES module, but it seems there isn't perfect solution without a big su=
rgery.
> > I would vote for #1 to resolve the issue from the ground. What do you t=
hink, Igor?
> > I'm also hoping Jonathan and Mauro can provide their preference. =20
>=20
> Ideally I'd like whatever we choose to look like what a bare metal machine
> does - mostly because we are less likely to hit untested OS paths.

Ack for that but,
that would need someone from hw/firmware side since error status block
handling is done by firmware.=20

right now we are just making things up based on spec interpretation.

> > > PS:
> > > I'd prefer Mauro's series being merged 1st (once it's resplit),
> > > for it refactors a bunch of original code and hopefully makes
> > > code easier to follow/extend.
> > >    =20
> >=20
> > Sure. I won't start the coding until the solution is confirmed. All the=
 followup
> > work will base on Mauro's series.
> >  =20
> > >> +        bql_lock();
> > >> +    }
> > >> +
> > >> +    if (ret =3D=3D 0) {
> > >> +        kvm_inject_arm_sea(c);
> > >> +    } else {
> > >> +        error_report("Error %d to report memory error", ret);
> > >> +        abort();
> > >> +    }
> > >> +}
> > >> +
> > >>   void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> > >>   {
> > >>       ram_addr_t ram_addr;
> > >> @@ -2387,12 +2411,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int=
 code, void *addr)
> > >>                */
> > >>               if (code =3D=3D BUS_MCEERR_AR) {
> > >>                   kvm_cpu_synchronize_state(c);
> > >> -                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, =
paddr, false)) {
> > >> -                    kvm_inject_arm_sea(c);
> > >> -                } else {
> > >> -                    error_report("failed to record the error");
> > >> -                    abort();
> > >> -                }
> > >> +                report_memory_error(c, paddr);
> > >>               }
> > >>               return;
> > >>           }   =20
> > >    =20
> >=20
> > Thanks,
> > Gavin
> >=20
> >  =20
>=20


