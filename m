Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820F9C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNuI-0007MO-T4; Tue, 20 May 2025 10:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHNuG-0007Lx-Ka
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:25:24 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHNuE-0002vo-6j
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:25:24 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so5014687f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747751120; x=1748355920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3S9b9WHqsNuka2NVPLNeaqXuQyKRzBvYMAZPp1x9eug=;
 b=aY92C8ijxZGo28eM0nFzNCvN5xXe7d2+1We0YpF5/oB4f7Us5FLWTqZUP4a5sXeSC3
 9UEGOQ1OcfM390+G6+vW+KSaaDoHz9uPS3Edpha0LX8FpqEp0gktCLzrqazteVQ/MO9B
 CYchSaRUPaLp0h/KHAvr+kdlEhfolnsQMxdop4LnWc3vG53MGa8NGlATf/ynGoJCX31h
 IFGFK7EKAaH+Dt+BmcXvHF8uevBUMbp34OBljRNRTP01W3Bb6wFpVrsT+2H+mFd45edm
 jdSaVmaJjvHi7QR2I1zLtFHvOUa/XDqE8yFJWmquj15Mp673YzS4v8xhrJilYurk0cq6
 uPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747751120; x=1748355920;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3S9b9WHqsNuka2NVPLNeaqXuQyKRzBvYMAZPp1x9eug=;
 b=SkTVxISuA9bN0m2A7EBrpl4HYNF9YeXy8BBl6/OvfqDpODMThZI7fsM5c0eGHC4pdj
 G2Gi9uJK3kKzWykJgBhynoK+2PMc+fNURj9rg+9fDbYIXgHfNnnr9bx24TWjRptQCF7m
 CuD5aGAJ3glYn9rQ7ehix8Ee3dpCastZ83aPedVAlzZrT6I3O+2Xe/wgtiDDEGM1d/40
 jFV6dhVn0pYBXi6ogZ8Ez8tlkF0nMsttszLm3ugXaHIIEN57vLB8duUmWzyWsekXhTxX
 uC7C76q1gs6OU+D02SwmHNRyO3fenEkbOpWLX9tayWVSKWPFHtwCw2J512mssk15lv9v
 TmJA==
X-Gm-Message-State: AOJu0Yx2YF5MzhQBAw6c94pGWa7kHILOPpj66zkId59nMAFI3TYUubQ1
 a+UHfctBqqx0jnvUtYsXtEcmW3Iz8S/bHgrNv3A+L7k4abKhHGvalaPlJDGE+rsM8vs=
X-Gm-Gg: ASbGnct2tS1eg3NSQX6vZjBkHnp0y6h2ZWEb5J6b71sVDhD+sjY30MBcyBXhj08iUwD
 s+ICKGeFRo5PGvb3NFCTsk7zLKjkO3fX55XaTy1msuR/kYFsRAU/d83z7Uah6WHsbXonyjTB8Gh
 NOYr/X6rA/Va5GXE09ABb802BygxTnydL9i3H72b8+E6gGUMPSU/yGFzIO+sfR+2gnBVVL+otsl
 PR/Gv5P7CV2fPEFF/5vg9obbSKTVu/BHz+be+yrZ2P3XuhHNAbN5yRWfydYkLPr6Ma01OCHuhOw
 sVUnPE6AUVNt5nSGiyQ8l8/9c3vruz027PdSOlMe1TvYPbYocS9K2HG67+ShBq8=
X-Google-Smtp-Source: AGHT+IHwfahr6+7rmqqX1F816oBFLMD4lKGouf1mYrgGAe+I6eO0i5tOgQAkm2ynvj5fTDN4vKoqxw==
X-Received: by 2002:a05:6000:430d:b0:3a0:ad5e:2ee1 with SMTP id
 ffacd0b85a97d-3a35c84f3c9mr14843350f8f.50.1747751119664; 
 Tue, 20 May 2025 07:25:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a36c6eeaf8sm9113626f8f.48.2025.05.20.07.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 07:25:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B49D5F7A5;
 Tue, 20 May 2025 15:25:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH 0/2] Fix for multi-process gdbstub breakpoints
In-Reply-To: <20250508224514.805456-1-nabihestefan@google.com> (Nabih
 Estefan's message of "Thu, 8 May 2025 22:45:12 +0000")
References: <20250508224514.805456-1-nabihestefan@google.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 20 May 2025 15:25:18 +0100
Message-ID: <87tt5f9x69.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Nabih Estefan <nabihestefan@google.com> writes:

> This patch series modifies the gdbstub to address a bug running a
> multi cluster machine in QEMU using TCG.

Was this a downstream multi-cluster machine? Do we have any examples for
upstream? It would be nice to add a gdbstub test case to cover the
multi-inferior behaviour.

> The machine where the
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
>> Breakpoint 1 at 0xf00add
> info break
>> Num     Type           Disp Enb Address    What
>> 1       breakpoint     keep y   0x00f00add in foo
>>                                            at foo.c:1234 inf N
> continue
>> Continuing.
>>
>> Thread 2.1 received signal SIGTRAP, Trace/breakpoint trap.
>> [Switching to Thread 2.2]
>> 0xf00add in ?? ()
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
>   gdbstub: Apply breakpoints only to the selected PID
>
>  accel/tcg/tcg-accel-ops.c | 37 +++++++++++++++++++++++--------------
>  gdbstub/gdbstub.c         | 10 ++++++++--
>  gdbstub/internals.h       | 13 +++++++++++--
>  include/exec/gdbstub.h    | 12 ++++++++++++
>  4 files changed, 54 insertions(+), 18 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

