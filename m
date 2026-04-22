Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823ACFA1FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFe7W-0004TT-RP; Wed, 22 Apr 2026 16:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wFe7V-0004TG-L3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wFe7T-0006RV-Jo
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776889459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDwAgUi99M/k+VNoNnF5B+AWxvnadqb5bExcu9bd2hQ=;
 b=JFAiP6qqHR+kafv/86xcYgXk7wNzcNLVni0LL0gnhA8fSNExaO2aHssDXAtxOoR9pbsMeK
 /H76wFWcH2J7zCL05XvqTdVWk4S+ZuwhjkoqaE/I9WKYARp3GpEjGJxGyzANqp2vlQOrIg
 0EGF/0obJOY6zkVQmIlpeOeQjdM5bOk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-OdN_D1FmPLCao27yRujd3Q-1; Wed, 22 Apr 2026 16:24:16 -0400
X-MC-Unique: OdN_D1FmPLCao27yRujd3Q-1
X-Mimecast-MFC-AGG-ID: OdN_D1FmPLCao27yRujd3Q_1776889456
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b241be0126so116548035ad.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776889456; cv=none;
 d=google.com; s=arc-20240605;
 b=FOFM008aWuBBsamFpK9eq0jGhwopmS+qOwaqV4WP55dTWJzWD/50+3CbGqoe0NS2gF
 vfV2stOywRAigcYT0DneXcJ+dYM+myvQG9y+3T9xtWZC1jv487x+2J1JifaeQzNnw1sA
 en41VNHJZnaoDVAgRnxyeHUA9LJGFg7obThiSjB+79YCvIay2+kwW8kNG3QxJa3L0iwE
 1YiwIMHfR4L4OMSiLHspHgC8HD6onD963z+3ZNuDfUA6gtDFiqzgZjttmMDJz46LH12e
 AiXFvOFsk8woPezyUt+6hItc9ET8nrZUfHnQdNODAmbr482RR3ZTZC1YD6Ce3cntVqSv
 krVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HDwAgUi99M/k+VNoNnF5B+AWxvnadqb5bExcu9bd2hQ=;
 fh=M1o8YtjHOdJwxrRFJODNr5/qcd7X/p4/qnPvWA3ACKM=;
 b=jbt6FYrc0549d305IrFY5HouvtT7wmgIT0oi+2zD0D5zeRXOyzkGFXbLFvKkhiMsgK
 aOqUC8o/kZqqcUfSsIXqgeZHjDKm04R+2N+HbzdtuC61qpISikwv2uCj6WWC7JzCqfXu
 HeFuf87CidLZkVyFlD7OSY4Rre3rF6hhVnkol3mecqeC/MvslwUqJL2mZ3dS6dcRr2GJ
 qC5sWibt41esFpXS7QDvizrYM/rppe9Z42qtbCd1BAOARK5/cZCHHBSwF10ETvC0ve7m
 c8ew9gOXTamujYCMJ1vVmAoCIy897H1nTbNsp0ouchJ9cWqb3CZTV4ZY5fMPGrOCj9+2
 6Y4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776889456; x=1777494256; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDwAgUi99M/k+VNoNnF5B+AWxvnadqb5bExcu9bd2hQ=;
 b=jTjCfL0KXgfBQr3DtzAgXryH0KNq+FY7mJyug258YLtNrHxI0/z9aQOOvrCFRI0OkH
 EvHRzL74oyGQn4e3P9tFFEvd2kgqWXupAETAVXL7KBWlh3PBNhTidIvzPe1Loue9Vyjj
 zbC/4iC+KlbB2sE4Te1X3plh4IV3Dfrs2/FFPmDt+D70wlGFMpU39i7J4/I5EC9jPbFX
 pn3+fuPGYmRX0cRFUzcCZBQxMZpVNam6VQ90i+Q2KOafKAJwVyVq4YNrbZg7ZPRmXX8x
 I07ESqllX/POVyt5/ZmABTxqm0vZ3YdyDzLFwAm5jwRU5ZZ+uStXw6m2dXSOio2RW0hr
 W1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776889456; x=1777494256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HDwAgUi99M/k+VNoNnF5B+AWxvnadqb5bExcu9bd2hQ=;
 b=cwkiwPtQKqed0qjVIRFDQ8b533ui3Ob0dTGgnQijsj+9+NS6Q+mlzQygPG/K5M00u7
 rZTejhroXKKIk38NcgaH9TU/ErMoly9kJsUPc7HH5AqgLjco5m+gWanfq15gQWbibnUX
 7CdMxGPNQnDan0UDUk5TKmbTrX67mrfbEt7XHtCnNS6BsARhViJ+dJffWKhoc6NmSNtI
 D92+NxB2QETEgbzhlAax5cHGO6Y877dO4PmJg+tkYkVZd/Iyae1rqASuXdAzOvwURexN
 62fi5oXkVMg1gxg+38eD0gRxH6Fe0kCFzUd7/IjQzTTRoh47b6QY1gjN2ZW1a9c9i3xp
 4Hew==
X-Gm-Message-State: AOJu0YzQcdPtaXkNJe5ttZ57NnJI2TvnOC5H+6hrh5t2jhI2+RRNW0TB
 kzOScXafJrb81Xy6Eiq4KFMlvpXDWC+6AJPTD7p3Gu/Ld3Tle0VQ8X7clLyYhlJe8sAA5Uh+ebn
 UgoDTJ2l+Drq9u9w/MWikaJhjY3NrvrHa9IObgYaDjF8G4IOrpREWaEEYmZRCP7iwbIacQ5Lzme
 BleoI/LXkdeBlmUpe+yjDwmxWM4DzBlPs=
X-Gm-Gg: AeBDies+1fim9nBCLpKSxuAM6GBLrYUD7c69oNbZLjHLy5pnJBmMl6n0klwqGDOUkKs
 v/0OqQpjhsCFW9hf5vZEZ1uXDR1xEnoTzezjISYOgaKcRudT3C65Du4UCYdxOMVLKtEnzkEevrp
 zIhFub43FHolXpSjl06d5TboW3nvhSiolOS/9tjc6r40dRDqx+H3AIroAehDRUN1tZccnlTPDGF
 oVHQOhUTLBwWwlUbsHgE6eVo9JbV3RWmpIwBttKm3ab+z6Lxvm9t06FKtPZ4ypsx67o0HncHLa1
 Dde4GqnbXgT6FXWRYSmPo9ScSiyMytsxG2Q=
X-Received: by 2002:a17:903:1aa4:b0:2b2:5771:4ce5 with SMTP id
 d9443c01a7336-2b5f9d5f6dfmr241514035ad.0.1776889455611; 
 Wed, 22 Apr 2026 13:24:15 -0700 (PDT)
X-Received: by 2002:a17:903:1aa4:b0:2b2:5771:4ce5 with SMTP id
 d9443c01a7336-2b5f9d5f6dfmr241513675ad.0.1776889455057; Wed, 22 Apr 2026
 13:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <87a4uvw066.fsf@pond.sub.org>
In-Reply-To: <87a4uvw066.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Apr 2026 00:24:03 +0400
X-Gm-Features: AQROBzDTC9CMg-sJAca6JizZaSJnVLOQi4AgmnlfE84aeWz5wyUppl42buAkAmM
Message-ID: <CAMxuvaxzwfYoguEijwHs4N5_iF8s8FLs853vse+mMaQA0ckQAQ@mail.gmail.com>
Subject: Re: Several QOM objects crash on introspection
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, zhangckid@gmail.com, lizhijian@fujitsu.com, 
 jasowang@redhat.com, arei.gonglei@huawei.com, zhenwei.pi@linux.dev, 
 pbonzini@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 berrange@redhat.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi

On Wed, Apr 22, 2026 at 6:16=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> QMP command qom-list-properties crashes for the following object types:
>
>     colo-compare
>     cryptodev-backend-lkcf
>     memory-region-portio-list
>     qemu-fixed-text-console
>     qemu-graphic-console
>     qio-net-listener
>     x-remote-object
>
> Testing gap: tests/qtest/device-introspect-test.c guards against such
> bugs in devices, but not non-device objects.

Good catch, are you going to send a test for it?

fwiw, I found also a critical in "filter-rewriter": (export
G_DEBUG=3Dfatal_criticals)

qemu-system-x86_64: GLib: g_hash_table_destroy: assertion 'hash_table
!=3D NULL' failed

Thread 1 "qemu-system-x86" received signal SIGTRAP, Trace/breakpoint trap.
0x00007ffff66dd1f8 in g_logv () from /lib64/libglib-2.0.so.0
(gdb) bt
#0  0x00007ffff66dd1f8 in g_logv () at /lib64/libglib-2.0.so.0
#1  0x00007ffff66dd4c3 in g_log () at /lib64/libglib-2.0.so.0
#2  0x000055555604580b in colo_rewriter_cleanup (nf=3D0x7cbfeba71000) at
../net/filter-rewriter.c:376
#3  0x000055555601f9b3 in netfilter_finalize (obj=3D0x7cbfeba71000) at
../net/filter.c:312
#4  0x0000555556598c58 in object_deinit (obj=3D0x7cbfeba71000,
type=3D0x7d2feba2b7c0) at ../qom/object.c:715
#5  0x0000555556598c86 in object_deinit (obj=3D0x7cbfeba71000,
type=3D0x7d2feba2bb40) at ../qom/object.c:719
#6  0x0000555556598d13 in object_finalize (data=3D0x7cbfeba71000) at
../qom/object.c:729
#7  0x000055555659b1af in object_unref (objptr=3D0x7cbfeba71000) at
../qom/object.c:1232
#8  0x00005555568b751c in qmp_qom_list_properties
(typename=3D0x7c1febd88110 "filter-rewriter", errp=3D0x7bffea77b520) at
../qom/qom-qmp-cmds.c:282

>
> Example crash:
>
> (gdb) r
> Starting program: /home/armbru/bin/qemu-system-x86_64 -S -display none -q=
mp stdio
> [...]
> {"QMP": {"version": {"qemu": {"micro": 94, "minor": 2, "major": 10}, "pac=
kage": "v11.0.0-rc4-14-gcb2bd9a2e6-dirty"}, "capabilities": ["oob"]}}
> [New Thread 0x7fff6b61d6c0 (LWP 2882851)]
> {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
> {"return": {}}
> {"execute": "qom-list-properties", "arguments": {"typename": "colo-compar=
e"}}
> upstream-qemu: ../util/qemu-thread-posix.c:96: qemu_mutex_destroy: Assert=
ion `mutex->initialized' failed.
>
> Thread 1 "upstream-qemu" received signal SIGABRT, Aborted.
> 0x00007ffff49c33cc in __pthread_kill_implementation () from /lib64/libc.s=
o.6
> [...]
> (gdb) bt
> #0  0x00007ffff49c33cc in __pthread_kill_implementation () at /lib64/libc=
.so.6
> #1  0x00007ffff496915e in raise () at /lib64/libc.so.6
> #2  0x00007ffff49506d0 in abort () at /lib64/libc.so.6
> #3  0x00007ffff4950639 in __assert_fail_base.cold () at /lib64/libc.so.6
> #4  0x0000555555ee3187 in qemu_mutex_destroy (mutex=3D0x55555761d4a0 <eve=
nt_mtx>)
>     at ../util/qemu-thread-posix.c:96
> #5  0x0000555555a18c65 in colo_compare_finalize (obj=3D0x55555887e4f0)
>     at ../net/colo-compare.c:1423
> #6  0x0000555555c8bb31 in object_deinit
>     (obj=3D0x55555887e4f0, type=3D0x555558053a90) at ../qom/object.c:715
> #7  0x0000555555c8bbab in object_finalize (data=3D0x55555887e4f0)
>     at ../qom/object.c:729
> #8  0x0000555555c8ce2c in object_unref (objptr=3D0x55555887e4f0)
>     at ../qom/object.c:1232
> #9  0x0000555555de8d38 in qmp_qom_list_properties
>     (typename=3D0x5555581ef450 "colo-compare", errp=3D0x7fffffffd8a8)
>     at ../qom/qom-qmp-cmds.c:282
> #10 0x0000555555e90311 in qmp_marshal_qom_list_properties
>     (args=3D0x7fff64003150, ret=3D0x7fffeccccda8, errp=3D0x7fffeccccda0)
>     at qapi/qapi-commands-qom.c:326
> #11 0x0000555555ecdd9e in do_qmp_dispatch_bh (opaque=3D0x7fffecccce40)
>     at ../qapi/qmp-dispatch.c:128
> #12 0x0000555555eff09b in aio_bh_call (bh=3D0x555558bee700)
> --Type <RET> for more, q to quit, c to continue without paging--
>     at ../util/async.c:173
> #13 0x0000555555eff1e3 in aio_bh_poll (ctx=3D0x55555807f180)
>     at ../util/async.c:220
> #14 0x0000555555ede0d0 in aio_dispatch (ctx=3D0x55555807f180)
>     at ../util/aio-posix.c:390
> #15 0x0000555555eff6f4 in aio_ctx_dispatch
>     (source=3D0x55555807f180, callback=3D0x0, user_data=3D0x0) at ../util=
/async.c:365
> #16 0x00007ffff6deb323 in g_main_context_dispatch_unlocked.lto_priv ()
>     at /lib64/libglib-2.0.so.0
> #17 0x00007ffff6deb5b5 in g_main_context_dispatch () at /lib64/libglib-2.=
0.so.0
> #18 0x0000555555f01202 in glib_pollfds_poll () at ../util/main-loop.c:290
> #19 0x0000555555f01290 in os_host_main_loop_wait (timeout=3D0)
>     at ../util/main-loop.c:313
> #20 0x0000555555f013c1 in main_loop_wait (nonblocking=3D0)
>     at ../util/main-loop.c:592
> #21 0x0000555555993773 in qemu_main_loop () at ../system/runstate.c:945
> #22 0x0000555555e0d468 in qemu_default_main (opaque=3D0x0) at ../system/m=
ain.c:50
> #23 0x0000555555e0d522 in main (argc=3D6, argv=3D0x7fffffffdd58)
>     at ../system/main.c:93
>


