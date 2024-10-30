Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABE0D6B6AD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Buq-000291-B5; Wed, 30 Oct 2024 12:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1t6Buo-00028l-LZ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:51:26 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1t6Bum-0007Ff-Rn
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:51:26 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4a4864b8f98so2308423137.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730307083; x=1730911883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgSyPqaOMIfPVMD+02xDfEtUowOQZCGgLM/7SPiELvY=;
 b=ApeshYAEtOHp1iwkrTG73KZycHCg2tBny4oTacMdKpO4fp6XpLwS+Zy0OAH/bfplpx
 vuoydPpvbZPYOGfif/NNbIGtdZJrHXjbzkqCe8YkvltIAYfRHMQbYVAVYVFFZchAI0ME
 X4BpDIOY6Eg7ktMl4Nw67Nf8lwvIP2NUxANRFtJQag6KJcyd/T3xEWt4Hjj0RiQ6lXsR
 Bv7KB+efrvg4B2NALqHp+J+4Sn0o/gV5w2JGEe00QKrGEdFdvgZpiKZf/56GDviaq7gE
 /4nFURqiH+2kH0pMtpeQQmrUh8CZ4LeVe1jkdG2lfz9QaxhbpeV4VJtgrxALJ81o7pSx
 /bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730307083; x=1730911883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgSyPqaOMIfPVMD+02xDfEtUowOQZCGgLM/7SPiELvY=;
 b=KCsqjTIO2Hyq91ljceG+l0nyN9NW4PtDZ8ztyoaRm5Qdj5bD7eoQE5hFBG9CCQc7hj
 4LxeKlImWnmYcunPAnjkMhKzTPUvih/dtCYvVAto1joTBzbjGMmoEmFVKn14OtMSNEVC
 eP+F2f4HnVhagGCeHTlo1gDdg4iLPq1x/EsSTJPH6k8Cl/d0TvRm/nn7mS9hpvhFO6zw
 YsxXsESc+1DWjjVg4BclpgChB/HYUNDRKo5CLRWSux1fmTESGCdJ/NTjoGTeYwvzsois
 b2JyGrxyI6F0w5lix0J77zmGhZ0l7t5QdiTcUZkk4t32ZabQDXmelRFnKxfxz2Z1FDmt
 IoyA==
X-Gm-Message-State: AOJu0Yw593mQSWq8BQdV+FnnQIk4xLGHZC6JeblxdCFg8sA5iGK8BQqo
 ZA1CVFKHpgkJRY9DHh5Jx3LQKBFwjqnf5f98RQqKWD3VLWZSE3Bjr5fy1FXzzJijISKZ5No319F
 beZDKP4aseEqo67IMu3Eg4ulXuaTiagPSoMee
X-Google-Smtp-Source: AGHT+IEo6R/YlxCkDNDrnYiEfHzulbIJbRb/zDXPJmg76TPFr00yO8ZvKlWxdk6fxm+4mskGQFVpSxhxmEplNMElSjY=
X-Received: by 2002:a05:6102:a4e:b0:4a3:b91d:78b1 with SMTP id
 ada2fe7eead31-4a8cfd538abmr14434530137.27.1730307082659; Wed, 30 Oct 2024
 09:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241017153745.509978-1-roqueh@google.com>
In-Reply-To: <20241017153745.509978-1-roqueh@google.com>
From: Roque Arcudia Hernandez <roqueh@google.com>
Date: Wed, 30 Oct 2024 09:51:10 -0700
Message-ID: <CAKbPEtbN8M6LUJuWKXRTznsA4O2UtKLudoL=O8XuO-fJw1ggYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix for multi-process gdbstub breakpoints
To: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, slongfield@google.com, komlodi@google.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=roqueh@google.com; helo=mail-vs1-xe36.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hello,

This is the second version of the patch. I have taken into
consideration the feedback from the first discussion thread. Is there
anything else to do?

Thanks

Roque

On Thu, Oct 17, 2024 at 8:37=E2=80=AFAM Roque Arcudia Hernandez
<roqueh@google.com> wrote:
>
> This patch series modifies the gdbstub to address a bug running a
> multi cluster machine in QEMU using TCG. The machine where the
> problem was seen had several clusters of CPUs with similar
> architectures and similar memory layout all working with physical
> addresses. It was discovered under gdb debugging that a breakpoint
> targeting one cluster misfired on the wrong cluster quite frequently
> with no possible workaround since gdb was also unaware of any
> breakpoint in that cluster and simply reported SIGTRAP.
>
> The sequence that discovered the bug adds N inferiors and adds a
> breakpoint on inferior N. Then after continuing an unrelated thread
> stops the execution when its PC hits the same address of the break
> targeting a different inferior.
>
> target extended-remote :1234
> add-inferior
> inferior 2
> attach 2
> ...
> add-inferior
> inferior N
> attach N
> add-symbol-file /path/to/foo.elf
> break foo
> > Breakpoint 1 at 0xf00add
> info break
> > Num     Type           Disp Enb Address    What
> > 1       breakpoint     keep y   0x00f00add in foo
> >                                            at foo.c:1234 inf N
> continue
> > Continuing.
> >
> > Thread 2.1 received signal SIGTRAP, Trace/breakpoint trap.
> > [Switching to Thread 2.2]
> > 0xf00add in ?? ()
>
> The main problem is the current implementation of
> 'tcg_insert_breakpoint' and 'tcg_remove_breakpoint' insert and remove
> breakpoints to all the CPUs in the system regardless of what the
> remote gdb protocol implements.
>
> If we look at the current source code of GDB we can see that the
> function 'remote_target::insert_breakpoint' in file gdb/remote.c has
> the intention to select the process ID of the inferior where the
> break was inserted.
>
> int
> remote_target::insert_breakpoint (struct gdbarch *gdbarch,
>                                   struct bp_target_info *bp_tgt)
> {
> ...
>   /* Make sure the remote is pointing at the right process, if
>      necessary.  */
>   if (!gdbarch_has_global_breakpoints (current_inferior ()->arch ()))
>     set_general_process ();
> ...
> }
>
> https:sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dgdb/remote.c;=
h=3D2c3988cb5075655e8a799d1cc5d4760ad8ed426e;hb=3DHEAD#l11023
>
> This would not happen when we input the 'break' in gdb but it is
> deferred until the time we execute the 'continue' command. Because we
> might be currently selecting an inferior that is not the one where we
> previously set the breakpoint, the remote gdb has to make sure we
> move the focus to the process ID of the inferior where we inserted
> the break.
>
> In the previous example this will translate to something like:
>
> HgpN.M
> Z0,00f00add,4
>
> Another thing that is wrong with the current implementation (and it
> affects both TCG and KVM mode) is that the remote gdb protocol uses
> 'Hg' and not 'Hc' to select the process. Functions
> 'gdb_breakpoint_insert' and 'gdb_breakpoint_remove' receive wrongly
> 'gdbserver_state.c_cpu' instead of 'gdbserver_state.g_cpu'.
>
> This is supported by the documentation of 'H op thread-id' where op =3D
> 'c' is reserved to the step and continue:
>
> https:sourceware.org/gdb/current/onlinedocs/gdb.html/Packets.html
>
> And it can be verified that the function 'set_general_process' in the
> previous code snippet will eventually call
> 'remote_target::set_general_thread' and not
> 'remote_target::set_continue_thread' if it needs to change focus.
>
> A third scenario that has to be taken into account is the case of a
> break on a specific thread, for instance the sequence:
>
> inferior 1
> break bar thread 1.3
> break bar thread 1.4
>
> The remote protocol expects the gdbstub to apply the break to the
> process ID of inferior 1 and considers the specific thread-id as a
> breakpoint condition (not too different from a 'break if').
>
> In this case the packet exchange may look like:
>
> Hgp1.1
> Z0,00ba2add,4
>
> There wouldn't be an independent set of packets for 'Hgp1.3' and
> 'Hgp1.4'.
>
> In the gdb source code, the handling of the specific thread-id
> happens during breakpoint evaluation in function
> 'bpstat_check_breakpoint_conditions' of file gdb/breakpoint.c
>
> https:sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dgdb/breakpoin=
t.c;h=3D17bd627f867cf3d4dc81322ed1919ba40cbb237d;hb=3DHEAD#l5550
>
> The proposed fix inserts or removes a breakpoint to all the cpus
> sharing the same process ID as the one selected with the latest
> received 'Hg' packet.
>
> Roque Arcudia Hernandez (2):
>   gdbstub: Fix wrong CPUState pointer in breakpoint functions
>   gdbstub: Apply breakpoints only to the relevant CPUs
>
>  accel/tcg/tcg-accel-ops.c | 37 +++++++++++++++++++++++--------------
>  gdbstub/gdbstub.c         | 10 ++++++++--
>  gdbstub/internals.h       | 13 +++++++++++--
>  include/exec/gdbstub.h    | 12 ++++++++++++
>  4 files changed, 54 insertions(+), 18 deletions(-)
>
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

