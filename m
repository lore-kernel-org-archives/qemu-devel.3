Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6D4FC0379
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwSX-0000by-N1; Thu, 23 Apr 2026 11:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFwSO-0000aE-R3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:59:13 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFwSM-0005Ai-UL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776959944; x=1777564744; i=deller@gmx.de;
 bh=OLiBTifpafGD5l7sSBUyVBflmc7u5MAoeamkpWI1ah8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Le9BYTFOnSVh/eunVGTERta9GRNefiBp6whVsO0BPK+biAjoxHlSBbpX1HQuz9o4
 qGsWo4mH+fyeXgg9WQ2suiZWRlODNj0ZB7ZHHtEJOa/D1PQ3sXZyhvS1Rxlc87M2h
 llADDVjfUl28IotLQoKRr15BpxnVUlgjq2J9Q69DQr/RbeErzOf1zw/xcJxVHxxzd
 8T/77gdutLr+3ceRi2dnFaE3qJw4gjSbbtlRJE6Ol0huLPxrQNS25Kb5qZZxfTBIF
 kuyqMRGwbsVL72Y+VYLzbcV0uvey4pyAEes/NB3CnOYu8pfObU0YE0AyBfz1riNX9
 FiSUZ9sklpkJT4p/1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1vUjam1aQ0-011mSp; Thu, 23
 Apr 2026 17:59:04 +0200
Message-ID: <5b9fe9d3-6afb-4cbd-9b41-46b82cb5b974@gmx.de>
Date: Thu, 23 Apr 2026 17:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user: Filter /proc/*/task/ to hide
 QEMU-internal threads
To: Ali Raza <elirazamumtaz@gmail.com>, qemu-devel@nongnu.org
Cc: morgan@kernel.org
References: <20260415-master-v1-0-8dd2ef111eee@gmail.com>
 <20260415-master-v1-1-8dd2ef111eee@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260415-master-v1-1-8dd2ef111eee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+k5QDGuUF8G4yx66R7eAClID/CcmWphqjBz+TNRBpf+vLO4DZh5
 Q02UfEtJghpExbsQS24Ix7xEpgB3EPuILb2hcRM40Fu2If1xJ7OUzHDN1EdnJ94vCh+SRGI
 LEd5dg5P4oSqST1ly0+qqEvBIrSFEx9dJZtWD/Aakj8tOmd4Xq9zJ9tN39tKUVqmVEjMNAj
 ayK2yUM24gKPcxj39R95Q==
UI-OutboundReport: notjunk:1;M01:P0:i80tyq5JIoE=;NJulcQKG9Lj4zmfDio04VXds/N5
 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
 o1YTTlK9RwCkx0+yosStlrX1n34=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/15/26 01:58, Ali Raza wrote:
> When a guest process reads /proc/<pid>/task/ via getdents/getdents64,
> the host kernel returns directory entries for all host threads in the
> process, including QEMU-internal threads (RCU, TCG workers) that have
> no guest CPUState.  This causes problems for guest libraries like
> libcap's PSX that enumerate threads via /proc/self/task/ and send
> signals to each one -- signals sent to QEMU-internal threads are never
> handled, leading to deadlocks.
>=20
> Add filtering to do_getdents() and do_getdents64() that detects when
> the fd refers to a /proc/<pid>/task/ directory and skips entries whose
> TID does not belong to a guest thread.  Guest thread TIDs are
> identified by iterating the CPU list via CPU_FOREACH(), matching the
> existing pattern used for /proc/self/stat num_threads.
>=20
> This fixes the psx_test hang reported in containers using QEMU
> user-mode emulation for cross-architecture builds.
>=20
> Resolves: https://github.com/AndrewGMorgan/libcap_mirror/issues/6
> Signed-off-by: Ali Raza (@locus-x64)
> ---
>   linux-user/syscall.c | 80 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>   1 file changed, 80 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f4b74ad350..b5a912dc22 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9108,6 +9108,50 @@ static int host_to_target_cpu_mask(const unsigned=
 long *host_mask,
>       return 0;
>   }
>  =20
> +/*
> + * Check if a directory fd refers to /proc/<pid>/task/ for the current
> + * process.  Used to filter out QEMU-internal host threads (RCU, TCG)
> + * that are not guest threads from directory listings.
> + */
> +static bool is_proc_pid_task_dir(int dirfd)
> +{
> +    char link_path[64];
> +    char link_target[PATH_MAX];
> +    ssize_t len;
> +    char expected[80];
> +    int expected_len;
> +
> +    snprintf(link_path, sizeof(link_path), "/proc/self/fd/%d", dirfd);
> +    len =3D readlink(link_path, link_target, sizeof(link_target) - 1);
> +    if (len < 0) {
> +        return false;
> +    }
> +    link_target[len] =3D '\0';
> +
> +    expected_len =3D snprintf(expected, sizeof(expected),
> +                            "/proc/%d/task", getpid());
> +    return strncmp(link_target, expected, expected_len) =3D=3D 0
> +           && (link_target[expected_len] =3D=3D '\0'
> +               || link_target[expected_len] =3D=3D '/');
> +}
> +
> +/*
> + * Check if a given host TID belongs to a guest thread by looking it up
> + * in the CPU list.  Must be called under RCU read lock.
> + */
> +static bool is_guest_tid(pid_t tid)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        TaskState *ts =3D get_task_state(cpu);
> +        if (ts->ts_tid =3D=3D tid) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>   #ifdef TARGET_NR_getdents
>   static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
>   {
> @@ -9116,6 +9160,7 @@ static int do_getdents(abi_long dirfd, abi_long ar=
g2, abi_long count)
>       int hlen, hoff, toff;
>       int hreclen, treclen;
>       off_t prev_diroff =3D 0;
> +    bool filter_task =3D is_proc_pid_task_dir(dirfd);
>  =20
>       hdirp =3D g_try_malloc(count);
>       if (!hdirp) {
> @@ -9150,6 +9195,23 @@ static int do_getdents(abi_long dirfd, abi_long a=
rg2, abi_long count)
>  =20
>           namelen =3D strlen(hde->d_name);
>           hreclen =3D hde->d_reclen;
> +
> +        /*
> +         * Filter /proc/<pid>/task/ listings to hide QEMU-internal
> +         * host threads (RCU, TCG) that have no guest CPUState.
> +         */
> +        if (filter_task) {
> +            char *endp;
> +            long tid =3D strtol(hde->d_name, &endp, 10);

I think we should user type pid_t here:
pid_t tid =3D strtol(...)



> +            if (tid > 0 && *endp =3D=3D '\0') {
> +                WITH_RCU_READ_LOCK_GUARD() {
> +                    if (!is_guest_tid(tid)) {
> +                        treclen =3D 0;
> +                        continue;
> +                    }
> +                }
> +            }
> +        }
>           treclen =3D offsetof(struct target_dirent, d_name) + namelen +=
 2;
>           treclen =3D QEMU_ALIGN_UP(treclen, __alignof(struct target_dir=
ent));
>  =20
> @@ -9203,6 +9265,7 @@ static int do_getdents64(abi_long dirfd, abi_long =
arg2, abi_long count)
>       int hlen, hoff, toff;
>       int hreclen, treclen;
>       off_t prev_diroff =3D 0;
> +    bool filter_task =3D is_proc_pid_task_dir(dirfd);
>  =20
>       hdirp =3D g_try_malloc(count);
>       if (!hdirp) {
> @@ -9226,6 +9289,23 @@ static int do_getdents64(abi_long dirfd, abi_long=
 arg2, abi_long count)
>  =20
>           namelen =3D strlen(hde->d_name) + 1;
>           hreclen =3D hde->d_reclen;
> +
> +        /*
> +         * Filter /proc/<pid>/task/ listings to hide QEMU-internal
> +         * host threads (RCU, TCG) that have no guest CPUState.
> +         */
> +        if (filter_task) {
> +            char *endp;
> +            long tid =3D strtol(hde->d_name, &endp, 10);

same here

> +            if (tid > 0 && *endp =3D=3D '\0') {
> +                WITH_RCU_READ_LOCK_GUARD() {
> +                    if (!is_guest_tid(tid)) {
> +                        treclen =3D 0;
> +                        continue;
> +                    }
> +                }
> +            }
> +        }
>           treclen =3D offsetof(struct target_dirent64, d_name) + namelen=
;
>           treclen =3D QEMU_ALIGN_UP(treclen, __alignof(struct target_dir=
ent64));
>  =20
>=20


