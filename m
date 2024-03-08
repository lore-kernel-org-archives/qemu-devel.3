Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD56C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 06:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riTiN-0004ad-UD; Fri, 08 Mar 2024 01:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1riTiM-0004a0-2q
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 01:28:18 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1riTiJ-00077c-Fa
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 01:28:17 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so5146387a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 22:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1709879291; x=1710484091; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=quEnzlhDPUiMc/s4TlpoBoSlY4uMRnTAUyUCE/SQwO4=;
 b=L2f7RnKiBuBsxCsSGQ2Qm8Y4b7YH98QO6G3Uw+8Pd0VCmY4yDSO5X83PUd20/K2TI/
 CMXpL9KE167kumOP4S1juiwvX0MKfQsJp8uJKJ7goPl+fIrR1DIoAR/m92isqN0LrLm1
 iOmNfuJjQY3qCL8qMv3F7CFs0FR5JJTDbdtBsfvCvhPzuT2dtQy2wKNwmvRhfmrfRlSH
 ecaKMvNXlcQ5c6PmL6W50NQLhqOah1LVDkL9PFat0WrgZYi2ZbqfUCSPA07ZIVO6rPsz
 c5H3oq0SB7PoVj0jtSi4EY9wkxZI8Fbf1D9M68Vvi7hLfEMoeWaHotYciaOQ6ecZoWat
 sZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709879291; x=1710484091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=quEnzlhDPUiMc/s4TlpoBoSlY4uMRnTAUyUCE/SQwO4=;
 b=pv/SNQvosmakB1qSj/GkCB7kg2T8N0lcTzl53/xYd1Cko9JhaGj4POBKew5I2MSgQC
 No0BRXzp37cg/EHZtXjDeL+w2sEsZlF4dU0pS0+sg4HY3Ba/2h6jpzCk+ZfpZiPPaRWl
 6Yqkv147KZPFCX0zdjhV7upqADcAeD4TkUn7EF2swZZWzzOZ2m6EI/tA5Hu7APiMK63i
 mizkmqT1mketdaRTiQtLQqqBt965WFt7A74JH0FdsSUX/q1wbElbdKi7/4quh0LDTDP/
 3A9o0U4Nj4wmXuzBd5Jdq6uNXuqpDu9+0b5Yk1GEc0H9XWxwli3I5w4iUPPAgoB5k/rM
 v/qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUieiOAWIUX8b1TZ2fLjDIFBB78Lusw2sRGCuuEeT9BfwcoKHoFVOGzGDVz4a6GMROchrOw8mG5qDIGR/UP/ZYxbUJ9JeE=
X-Gm-Message-State: AOJu0YyFaNK+8JGCT3DX1O9B36iTGcvW1qxxJ34jALg/FReQmtav7eMl
 owSHMUGAXtkYipqhBdN/cXgUL9kG5FsbhciBpmxYsNWEi7JQplBsXEyQDpfCRX0D0on0LDrdIM0
 Q2TUS80peDwL//l+gw+ucrKu1d1oTT8zGJJp9aw==
X-Google-Smtp-Source: AGHT+IHtGdqwKHevl3UaF1RyBaGGU1gpkBoMvRv5VLefU355Bq+8DlGvMihgmwgAjuka9MdK9Hzm+ZY76e6RwFbwk90=
X-Received: by 2002:a17:906:5909:b0:a3f:50f0:7a0a with SMTP id
 h9-20020a170906590900b00a3f50f07a0amr2228072ejq.20.1709879291604; Thu, 07 Mar
 2024 22:28:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
 <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com>
 <Zek2UFoAyVrC7yh6@x1n>
In-Reply-To: <Zek2UFoAyVrC7yh6@x1n>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Fri, 8 Mar 2024 07:27:59 +0100
Message-ID: <CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com>
Subject: Re: Problem with migration/rdma
To: Peter Xu <peterx@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Het Gala <het.gala@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Fabiano Rosas <farosas@suse.de>, Jinpu Wang <jinpu.wang@ionos.com>, 
 Alexei Pastuchov <alexei.pastuchov@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>
Content-Type: multipart/mixed; boundary="000000000000c92c980613204b94"
Received-SPF: permerror client-ip=2a00:1450:4864:20::52f;
 envelope-from=yu.zhang@ionos.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000c92c980613204b94
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Zhijian and Peter,

Thank you so much for testing and confirming it.
I created a patch in the email format, unfortunately got an issue for
setting up the
"Application-specific Password" in Gmail. It seems that in my gmail
account there
is no option at all for selecting "mail" before creating the
application password.

As it's tiny, I attached it in this email at this time (not elegant.),
so that it can get
included before the soft freezing.

Really sorry for this inconvenience.
--------------
From c9fb6a6debfbd5e103aa90f30e9a028316449104 Mon Sep 17 00:00:00 2001
From: Yu Zhang <yu.zhang@ionos.com>
Date: Wed, 6 Mar 2024 09:06:54 +0100
Subject: [PATCH] migration/rdma: Fix a memory issue for migration

In commit 3fa9642ff7 change was made to convert the RDMA backend to
accept MigrateAddress struct. However, the assignment of "host" leads
to data corruption on the target host and the failure of migration.

    isock->host =3D rdma->host;

By allocating the memory explicitly for it with g_strdup_printf(), the
issue is fixed and the migration doesn't fail any more.

Fixes: 3fa9642ff7 ("migration: convert rdma backend to accept MigrateAddres=
s")
Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Yu Zhang <yu.zhang@ionos.com>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index a355dcea89..d6abe718b5 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3357,7 +3357,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         goto err_rdma_dest_wait;
     }

-    isock->host =3D rdma->host;
+    isock->host =3D g_strdup_printf("%s", rdma->host);
     isock->port =3D g_strdup_printf("%d", rdma->port);

     /*
--=20
2.25.1
--------------

Best regards,
Yu Zhang @ IONOS Compute Platform
08.03.2024

On Thu, Mar 7, 2024 at 4:37=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Mar 07, 2024 at 02:41:37AM +0000, Zhijian Li (Fujitsu) via wrote:
> > Yu,
> >
> >
> > On 07/03/2024 00:30, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Cc'ing RDMA migration reviewers/maintainers:
> > >
> > > $ ./scripts/get_maintainer.pl -f migration/rdma.c
> > > Li Zhijian <lizhijian@fujitsu.com> (reviewer:RDMA Migration)
> > > Peter Xu <peterx@redhat.com> (maintainer:Migration)
> > > Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
> > >
> > > On 5/3/24 22:32, Yu Zhang wrote:
> > >> Hello Het and all,
> > >>
> > >> while I was testing qemu-8.2, I saw a lot of our migration test case=
s failed.
> > >> After debugging the commits of the 8.2 branch, I saw the issue and m=
ad a diff:
> > >>
> > >> diff --git a/migration/rdma.c b/migration/rdma.c
> > >> index 6a29e53daf..f10d56f556 100644
> > >> --- a/migration/rdma.c
> > >> +++ b/migration/rdma.c
> > >> @@ -3353,9 +3353,9 @@ static int qemu_rdma_accept(RDMAContext *rdma)
> > >>           goto err_rdma_dest_wait;
> > >>       }
> > >>
> > >> -    isock->host =3D rdma->host;
> > >> +    isock->host =3D g_strdup_printf("%s", rdma->host);
> > >>       isock->port =3D g_strdup_printf("%d", rdma->port);
> >
> >
> > Thanks for your analysis.
> >
> > It will be great if you send this as a patch.
> >
> >
> > isock is defined as a _autoptr VVV
> > 3333 _autoptr(InetSocketAddress) isock =3D g_new0(InetSocketAddress, 1)=
;
> >
> > I'm surprised that it seems the auto free scheme will free the member o=
f isock as well
> > see below valrind log. That will cause a double free.
>
> Right, all the QAPI-free is a deep one.  Thanks for checking this up,
> Zhijian.
>
> Yu, would you please send a formal patch (better before this week ends) s=
o
> that I can include it for the last pull for 9.0 soft-freeze (March 12th)?
> As 8.2 affected, please also attach proper tags:
>
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Fixes: 3fa9642ff7 ("migration: convert rdma backend to accept MigrateAddr=
ess")
>
> >
> > =3D=3D809138=3D=3D Invalid free() / delete / delete[] / realloc()
> > =3D=3D809138=3D=3D    at 0x483A9F5: free (vg_replace_malloc.c:538)
> > =3D=3D809138=3D=3D    by 0x598F70C: g_free (in /usr/lib64/libglib-2.0.s=
o.0.6600.8)
> > =3D=3D809138=3D=3D    by 0x79B6AD: qemu_rdma_cleanup (rdma.c:2432)
> > =3D=3D809138=3D=3D    by 0x79CEE6: qio_channel_rdma_close_rcu (rdma.c:3=
108)
> > =3D=3D809138=3D=3D    by 0xC2E339: call_rcu_thread (rcu.c:301)
> > =3D=3D809138=3D=3D    by 0xC2116A: qemu_thread_start (qemu-thread-posix=
.c:541)
> > =3D=3D809138=3D=3D    by 0x72683F8: ??? (in /usr/lib64/libpthread-2.32.=
so)
> > =3D=3D809138=3D=3D    by 0x73824C2: clone (in /usr/lib64/libc-2.32.so)
> > =3D=3D809138=3D=3D  Address 0x13daa070 is 0 bytes inside a block of siz=
e 14 free'd
> > =3D=3D809138=3D=3D    at 0x483A9F5: free (vg_replace_malloc.c:538)
> > =3D=3D809138=3D=3D    by 0x598F70C: g_free (in /usr/lib64/libglib-2.0.s=
o.0.6600.8)
> > =3D=3D809138=3D=3D    by 0xC058CF: qapi_dealloc_type_str (qapi-dealloc-=
visitor.c:68)
> > =3D=3D809138=3D=3D    by 0xC09EF3: visit_type_str (qapi-visit-core.c:34=
9)
> > =3D=3D809138=3D=3D    by 0xBDDECC: visit_type_InetSocketAddressBase_mem=
bers (qapi-visit-sockets.c:29)
> > =3D=3D809138=3D=3D    by 0xBDE055: visit_type_InetSocketAddress_members=
 (qapi-visit-sockets.c:67)
> > =3D=3D809138=3D=3D    by 0xBDE30D: visit_type_InetSocketAddress (qapi-v=
isit-sockets.c:119)
> > =3D=3D809138=3D=3D    by 0xBDDB38: qapi_free_InetSocketAddress (qapi-ty=
pes-sockets.c:51)
> > =3D=3D809138=3D=3D    by 0x792351: glib_autoptr_clear_InetSocketAddress=
 (qapi-types-sockets.h:109)
> > =3D=3D809138=3D=3D    by 0x79236F: glib_autoptr_cleanup_InetSocketAddre=
ss (qapi-types-sockets.h:109)
> > =3D=3D809138=3D=3D    by 0x79D956: qemu_rdma_accept (rdma.c:3341)
> > =3D=3D809138=3D=3D    by 0x79F05A: rdma_accept_incoming_migration (rdma=
.c:4041)
> > =3D=3D809138=3D=3D  Block was alloc'd at
> > =3D=3D809138=3D=3D    at 0x4839809: malloc (vg_replace_malloc.c:307)
> > =3D=3D809138=3D=3D    by 0x5992BB8: g_malloc (in /usr/lib64/libglib-2.0=
.so.0.6600.8)
> > =3D=3D809138=3D=3D    by 0x59A7FE3: g_strdup (in /usr/lib64/libglib-2.0=
.so.0.6600.8)
> > =3D=3D809138=3D=3D    by 0x79C2A8: qemu_rdma_data_init (rdma.c:2731)
> > =3D=3D809138=3D=3D    by 0x79F183: rdma_start_incoming_migration (rdma.=
c:4081)
> > =3D=3D809138=3D=3D    by 0x76F200: qemu_start_incoming_migration (migra=
tion.c:581)
> > =3D=3D809138=3D=3D    by 0x77193A: qmp_migrate_incoming (migration.c:17=
35)
> > =3D=3D809138=3D=3D    by 0x74B3D3: qmp_x_exit_preconfig (vl.c:2718)
> > =3D=3D809138=3D=3D    by 0x74DB6F: qemu_init (vl.c:3753)
> > =3D=3D809138=3D=3D    by 0xA14F3F: main (main.c:47)
>
> --
> Peter Xu
>

--000000000000c92c980613204b94
Content-Type: text/x-patch; charset="US-ASCII"; name="migration-rdma-fix.patch"
Content-Disposition: attachment; filename="migration-rdma-fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lti9ppab0>
X-Attachment-Id: f_lti9ppab0

RnJvbSBjOWZiNmE2ZGViZmJkNWUxMDNhYTkwZjMwZTlhMDI4MzE2NDQ5MTA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdSBaaGFuZyA8eXUuemhhbmdAaW9ub3MuY29tPgpEYXRlOiBX
ZWQsIDYgTWFyIDIwMjQgMDk6MDY6NTQgKzAxMDAKU3ViamVjdDogW1BBVENIXSBtaWdyYXRpb24v
cmRtYTogRml4IGEgbWVtb3J5IGlzc3VlIGZvciBtaWdyYXRpb24KCkluIGNvbW1pdCAzZmE5NjQy
ZmY3IGNoYW5nZSB3YXMgbWFkZSB0byBjb252ZXJ0IHRoZSBSRE1BIGJhY2tlbmQgdG8KYWNjZXB0
IE1pZ3JhdGVBZGRyZXNzIHN0cnVjdC4gSG93ZXZlciwgdGhlIGFzc2lnbm1lbnQgb2YgImhvc3Qi
IGxlYWRzCnRvIGRhdGEgY29ycnVwdGlvbiBvbiB0aGUgdGFyZ2V0IGhvc3QgYW5kIHRoZSBmYWls
dXJlIG9mIG1pZ3JhdGlvbi4KCiAgICBpc29jay0+aG9zdCA9IHJkbWEtPmhvc3Q7CgpCeSBhbGxv
Y2F0aW5nIHRoZSBtZW1vcnkgZXhwbGljaXRseSBmb3IgaXQgd2l0aCBnX3N0cmR1cF9wcmludGYo
KSwgdGhlCmlzc3VlIGlzIGZpeGVkIGFuZCB0aGUgbWlncmF0aW9uIGRvZXNuJ3QgZmFpbCBhbnkg
bW9yZS4KCkZpeGVzOiAzZmE5NjQyZmY3ICgibWlncmF0aW9uOiBjb252ZXJ0IHJkbWEgYmFja2Vu
ZCB0byBhY2NlcHQgTWlncmF0ZUFkZHJlc3MiKQpDYzogcWVtdS1zdGFibGUgPHFlbXUtc3RhYmxl
QG5vbmdudS5vcmc+CkNjOiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+CkNjOiBQ
ZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFl1IFpoYW5nIDx5dS56
aGFuZ0Bpb25vcy5jb20+Ci0tLQogbWlncmF0aW9uL3JkbWEuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL21pZ3JhdGlv
bi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jCmluZGV4IGEzNTVkY2VhODkuLmQ2YWJlNzE4YjUg
MTAwNjQ0Ci0tLSBhL21pZ3JhdGlvbi9yZG1hLmMKKysrIGIvbWlncmF0aW9uL3JkbWEuYwpAQCAt
MzM1Nyw3ICszMzU3LDcgQEAgc3RhdGljIGludCBxZW11X3JkbWFfYWNjZXB0KFJETUFDb250ZXh0
ICpyZG1hKQogICAgICAgICBnb3RvIGVycl9yZG1hX2Rlc3Rfd2FpdDsKICAgICB9CiAKLSAgICBp
c29jay0+aG9zdCA9IHJkbWEtPmhvc3Q7CisgICAgaXNvY2stPmhvc3QgPSBnX3N0cmR1cF9wcmlu
dGYoIiVzIiwgcmRtYS0+aG9zdCk7CiAgICAgaXNvY2stPnBvcnQgPSBnX3N0cmR1cF9wcmludGYo
IiVkIiwgcmRtYS0+cG9ydCk7CiAKICAgICAvKgotLSAKMi4yNS4xCgo=
--000000000000c92c980613204b94--

