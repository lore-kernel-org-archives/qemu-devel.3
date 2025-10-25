Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D052BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 14:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCf7V-0002br-0Z; Sat, 25 Oct 2025 10:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1vCf7S-0002bZ-RG
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 10:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1vCf7Q-0007Lh-OQ
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 10:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761401981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWaF5dO2asjXmBR7KfsiXP4JFlhQG3v/1Y5mRo5GPzg=;
 b=bIWSHcEGxYSdHYHXGtgcz8IUV3glgj1xEy/OOhHUgvk8aMzoAp+p4j3aPxc9LkVOWTXQMe
 fBXUGyjKz+8bbMHoH7ZHROru+w6c8Wz1fhifE3lHAzxPs3JuHk7Ggm0ALlhVFhmjlBTXY5
 +mGyRSCwxIr4hunpaRQ2sYUgkgGjAOk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-BH_J9_0lMF-QY9CxeSy4mQ-1; Sat, 25 Oct 2025 10:19:39 -0400
X-MC-Unique: BH_J9_0lMF-QY9CxeSy4mQ-1
X-Mimecast-MFC-AGG-ID: BH_J9_0lMF-QY9CxeSy4mQ_1761401978
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-634cdb5d528so5578741a12.1
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 07:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761401978; x=1762006778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWaF5dO2asjXmBR7KfsiXP4JFlhQG3v/1Y5mRo5GPzg=;
 b=ONkBnvtTo+KM7UTXZs8iMciFDDDULyI2CUYNkTM8MymwkI5WT0v6xjXR6IiJ/FoJ7J
 XdfKSq3QbrSsImW8OeM7AR6cbswvy1UzrXGqlHH/qseGDhhUEgJSxS1B28YnWgRcrg4p
 vetZrYZWzVMuxtoleucpx6dWTdqkse5jN5jMy8KC7TCgcgwHHU3L755QJmLaKi3Fwtv/
 q6cLmPLTrhAtHxBlYi/eykBgbu0TqwtKbFxtsYYQGPE6x6CRkX4rcS4KE3Lz3o7DFBED
 S4U0NEv/I6H8ek0r1/ufwqvjTGiyPTOE1/2b4uJS/f9PlII4yPZDTaKHARhCcu+DP3l1
 1vwA==
X-Gm-Message-State: AOJu0YwQjNZ2keA6aUoL45Sr4WNuRq8FaZ+P/5W+CsxygflwALpjzWDL
 0/9I93FxaFK1lnrSfPY+pzJWyxFeiIXoHWIh0pMIN68kRi9D3zW7vu9QVZRpCEH7oCffOW0mum1
 tZv1bYin6BgKspckx1lkf1ldXBoHwu0Oh0VqiS/fSU7U9IsR2Q2KdqEKxVQptl0XK6Ad8v+CgAk
 Yg9hyQDj8qLRHRcCMF8Uo+Ms9UVggshJM=
X-Gm-Gg: ASbGncvLFT6ESQ4qAXPZM5/mCqiqMPHXPP2HOmu1ItREPQTFwjYP+6uy1Q4uIT95EYm
 8Iza8Y9IY3rMKAgZfdjfqGHvEoEpb3dbc/7A8H7Pw5fe4Gb8eDRLH9J9u3sZ3fKL2JsQrJJV5aD
 8w7iHXPZN3wF7S0c0sz9+fkCBYTVA0a7GvCMO0FxPoxZmo0D9Tjft88PK3
X-Received: by 2002:a05:6402:2355:b0:63c:5892:3c3a with SMTP id
 4fb4d7f45d1cf-63e5eb28aa6mr5685393a12.13.1761401978468; 
 Sat, 25 Oct 2025 07:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDUb/BD9kS40s9DUHBG4j/imLyKYTEZugr4cnorGF16ADDMLqEZIm+uy/fbkKZ+rL/pwp9OQB0O7AmHqH0emw=
X-Received: by 2002:a05:6402:2355:b0:63c:5892:3c3a with SMTP id
 4fb4d7f45d1cf-63e5eb28aa6mr5685360a12.13.1761401977974; Sat, 25 Oct 2025
 07:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <20251020054413.2614932-3-dtalexundeer@yandex-team.ru>
 <CAPpAL=zL2iQWQM98R-xRoSFkMEYB+xqtB3KOGc9gAfQnymJxMg@mail.gmail.com>
 <2490be9d-73db-4087-a20e-8f85b1eee2a8@yandex-team.ru>
In-Reply-To: <2490be9d-73db-4087-a20e-8f85b1eee2a8@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Sat, 25 Oct 2025 22:19:00 +0800
X-Gm-Features: AWmQ_bmYNKWlr0nR6hdZF3x7BOkzqZ4FiPZ09JhYhfmWLk8BWr0kZMrsoihwlEk
Message-ID: <CAPpAL=yqHqrK5g6GAp=MsjnuzUkNH66UyGEp-7Hx+s8j4=UkjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vhost-user-blk: support inflight migration
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 24, 2025 at 4:38=E2=80=AFPM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
> Hi, thanks for testing!
>
> On 10/23/25 19:29, Lei Yang wrote:
>
> Hi Alexandr
>
> According to my test result, this series of patches introduce issues,
> it prints the following error messages when compiling the process
> after applying your patch.
> The test based on this commit:
> commit 3a2d5612a7422732b648b46d4b934e2e54622fd6 (origin/master, origin/HE=
AD)
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Fri Oct 17 14:31:56 2025 +0100
>
> Error messages:
> [1849/2964] Compiling C object
> libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o
> FAILED: libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o
> cc -m64 -Ilibqemu-x86_64-softmmu.a.p -I. -I.. -Itarget/i386
> -I../target/i386 -Isubprojects/dtc/libfdt -I../subprojects/dtc/libfdt
> -Isubprojects/libvduse -I../subprojects/libvduse -Iqapi -Itrace -Iui
> -Iui/shader -I/usr/include/pixman-1 -I/usr/include/glib-2.0
> -I/usr/lib64/glib-2.0/include -I/usr/include/libmount
> -I/usr/include/blkid -I/usr/include/sysprof-6
> -I/usr/include/gio-unix-2.0 -I/usr/include/slirp
> -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O0 -=
g
> -fstack-protector-strong -Wempty-body -Wendif-labels
> -Wexpansion-to-defined -Wformat-security -Wformat-y2k
> -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self
> -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
> -Wold-style-declaration -Wold-style-definition -Wredundant-decls
> -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
> -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
> -Wno-shift-negative-value -isystem
> /mnt/tests/distribution/command/qemu/linux-headers -isystem
> linux-headers -iquote . -iquote /mnt/tests/distribution/command/qemu
> -iquote /mnt/tests/distribution/command/qemu/include -iquote
> /mnt/tests/distribution/command/qemu/host/include/x86_64 -iquote
> /mnt/tests/distribution/command/qemu/host/include/generic -iquote
> /mnt/tests/distribution/command/qemu/tcg/i386 -pthread -mcx16 -msse2
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
> -fzero-call-used-regs=3Dused-gpr -fPIE -DWITH_GZFILEOP
> -isystem../linux-headers -isystemlinux-headers -DCOMPILING_PER_TARGET
> '-DCONFIG_TARGET=3D"x86_64-softmmu-config-target.h"'
> '-DCONFIG_DEVICES=3D"x86_64-softmmu-config-devices.h"' -MD -MQ
> libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o -MF
> libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o.d -o
> libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o -c
> ../hw/block/vhost-user-blk.c
> In file included from
> /mnt/tests/distribution/command/qemu/migration/options.h:19,
>                  from ../hw/block/vhost-user-blk.c:34:
> /mnt/tests/distribution/command/qemu/include/migration/client-options.h:2=
6:1:
> error: unknown type name =E2=80=98MigMode=E2=80=99
>    26 | MigMode migrate_mode(void);
>       | ^~~~~~~
> /mnt/tests/distribution/command/qemu/migration/options.h:66:7: error:
> unknown type name =E2=80=98BitmapMigrationNodeAliasList=E2=80=99
>    66 | const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(=
void);
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /mnt/tests/distribution/command/qemu/migration/options.h:80:1: error:
> unknown type name =E2=80=98MultiFDCompression=E2=80=99
>    80 | MultiFDCompression migrate_multifd_compression(void);
>       | ^~~~~~~~~~~~~~~~~~
> /mnt/tests/distribution/command/qemu/migration/options.h:89:1: error:
> unknown type name =E2=80=98ZeroPageDetection=E2=80=99
>    89 | ZeroPageDetection migrate_zero_page_detection(void);
>       | ^~~~~~~~~~~~~~~~~
> /mnt/tests/distribution/command/qemu/migration/options.h:93:27: error:
> unknown type name =E2=80=98MigrationParameters=E2=80=99; did you mean
> =E2=80=98MigrationState=E2=80=99?
>    93 | bool migrate_params_check(MigrationParameters *params, Error **er=
rp);
>       |                           ^~~~~~~~~~~~~~~~~~~
>       |                           MigrationState
> /mnt/tests/distribution/command/qemu/migration/options.h:94:26: error:
> unknown type name =E2=80=98MigrationParameters=E2=80=99; did you mean
> =E2=80=98MigrationState=E2=80=99?
>    94 | void migrate_params_init(MigrationParameters *params);
>       |                          ^~~~~~~~~~~~~~~~~~~
>       |                          MigrationState
> ninja: build stopped: subcommand failed.
> make[1]: *** [Makefile:168: run-ninja] Error 1
>
> Thanks
> Lei
>
> I have the same issue on my machine...
>
> In file included from /home/dtalexundeer/code/qemu-upstream/migration/opt=
ions.h:19,
>                  from ../hw/block/vhost-user-blk.c:34:
> /home/dtalexundeer/code/qemu-upstream/include/migration/client-options.h:=
26:1: error: unknown type name =E2=80=98MigMode=E2=80=99
>    26 | MigMode migrate_mode(void);
>       | ^~~~~~~
> In file included from ../hw/block/vhost-user-blk.c:34:
> /home/dtalexundeer/code/qemu-upstream/migration/options.h:65:7: error: un=
known type name =E2=80=98BitmapMigrationNodeAliasList=E2=80=99
>    65 | const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(=
void);
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/dtalexundeer/code/qemu-upstream/migration/options.h:79:1: error: un=
known type name =E2=80=98MultiFDCompression=E2=80=99
>    79 | MultiFDCompression migrate_multifd_compression(void);
>       | ^~~~~~~~~~~~~~~~~~
> /home/dtalexundeer/code/qemu-upstream/migration/options.h:88:1: error: un=
known type name =E2=80=98ZeroPageDetection=E2=80=99
>    88 | ZeroPageDetection migrate_zero_page_detection(void);
>       | ^~~~~~~~~~~~~~~~~
> /home/dtalexundeer/code/qemu-upstream/migration/options.h:92:27: error: u=
nknown type name =E2=80=98MigrationParameters=E2=80=99; did you mean =E2=80=
=98MigrationState=E2=80=99?
>    92 | bool migrate_params_check(MigrationParameters *params, Error **er=
rp);
>       |                           ^~~~~~~~~~~~~~~~~~~
>       |                           MigrationState
> /home/dtalexundeer/code/qemu-upstream/migration/options.h:93:26: error: u=
nknown type name =E2=80=98MigrationParameters=E2=80=99; did you mean =E2=80=
=98MigrationState=E2=80=99?
>    93 | void migrate_params_init(MigrationParameters *params);
>       |                          ^~~~~~~~~~~~~~~~~~~
>       |                          MigrationState
>

Hi Alexandr

> When I send a patch, did you know, is any CI performed (like compilation)=
?

To be honest, I'm not sure if there's such a check in place upstream.
I discovered this issue because my local CI tool caught the files
modified by your patch, found the ones I was interested in, triggered
the tests, and only discovered the issue when I looked at the results.

Thanks
Lei
>
> I was thinking that there was some issue in my environment (or some other=
 code) because it even reproduces on the latest master if I add this includ=
e to the vhost-user-blk.c file:
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c index =
c0cc5f6942..70235737f0 100644 --- a/hw/block/vhost-user-blk.c +++ b/hw/bloc=
k/vhost-user-blk.c @@ -31,6 +31,7 @@ #include "hw/virtio/virtio-access.h" #=
include "system/system.h" #include "system/runstate.h" +#include "migration=
/options.h"
>
> So, it looks like there is a problem with the client-options.h file (that=
 needs to include the qapi file) or in qapi generation process. If I apply =
this patch:
>
> diff --git a/include/migration/client-options.h b/include/migration/clien=
t-options.h index 289c9d7762..38cf53388d 100644 --- a/include/migration/cli=
ent-options.h +++ b/include/migration/client-options.h @@ -10,6 +10,7 @@ #i=
fndef QEMU_MIGRATION_CLIENT_OPTIONS_H #define QEMU_MIGRATION_CLIENT_OPTIONS=
_H +#include "qapi/qapi-types-migration.h" /* properties */
>
> the problem goes away..


