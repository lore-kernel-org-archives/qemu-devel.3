Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6844DCC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJqP-0006ml-LS; Thu, 15 Oct 2026 07:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xHJqN-0006l8-4x
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:41:55 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xHJqK-00071m-PH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:41:54 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-33fb4680717so5410625eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 04:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792064511; cv=none;
 d=google.com; s=arc-20260327;
 b=QQ979LNfNbqzq1NERn7/gBhzvbadVRNJ0Ib3+05krT8rkxjFBXHPRKNUrGLZ327noR
 uTXT+CtC6HsaKX/3WKl43vdP9URRTR1s3tLHksbUS2NdeDndo5QPfofwIPj2kTUQwDag
 nwKiGMbPsNqFxTKGE8G9jouTq8nQnf5d2v+qrgkJhgS6xwIT4PhtMwKfEbX9T4R1NcG+
 34GBochAK/lN/f7/D463RJMWzaG2l6osOMo9OEwzSgfHVVRGsyLEpePkgk2vRUKr6mC2
 IUjRAaZ1v5K6PVtBwGMRZTejXj7PD9yhK9mVS5sspst6TAUeOTY78WU+gs2xWaX6X7wh
 xAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O5bCvO8Gpt28kEYPl4+Qm2T+9y5uuqxwnf6VBHDqJ50=;
 fh=74HhLtoZmP3Bi2Kf+wpAU+61wrCV6ziLWmWnNFtjFVU=;
 b=plst1pJKu6Aunuqqb6Ltv3bFfu5eUN8cGZDcPkS6NY7hVM6A/gPwlHtG62RDiufBIy
 GPNnpylMMIyES371NmzFknARUCqJHym+x1OiL403AS303An/oF3AM4bYGKQUcVm7yDeg
 NGZuSzsLECRvIx+lXiDBnvht5iZWP9D7fac9C+whKjkpCbJxlSzEnCd2dCEbX//tgxEL
 Vrl/+yscs32IdzQC2HQV4TLDaBv+cS/AerniWyLc1WujJ3WBDYD1j6c1H67kiuEDz6Ob
 JvRr0836RkM3d998LANVnuhX+VetoUJN30/IgFurduNMCm/xyg9S+cRRJCN6k3Z8Dyib
 PqyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792064511; x=1792669311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O5bCvO8Gpt28kEYPl4+Qm2T+9y5uuqxwnf6VBHDqJ50=;
 b=MwGCAcsno9gbiTKYT1DAMJD2fwt3KY9Qfh1tgNXcHQl9eze3crawR6pNjX0EKZW1bC
 +SDxk0lMT+1SAnt4HTr2gq4C42aq4HYTmyiPvE4t40U5s32hP6cmT9Ccp5dXjUGPftpi
 wdN3S9A3Jpp7rDCM4/7PEwOAy5HtqecksnaYlfmuIyvmTwmmliHV4S/p1w3eAzwXviyn
 ejQz/nViPaISPQWLd6ppVEuZlh3b0G0EwQvypk3aFOdRlgIyRp/34OETCuo8808sBS/H
 QabmV2mD+9KTBcr6+YOtKiwTU0DHjVv5Y6gfa43EbiPW78MS4G/2ByXokVKG9c9nZvN3
 zQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792064511; x=1792669311;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O5bCvO8Gpt28kEYPl4+Qm2T+9y5uuqxwnf6VBHDqJ50=;
 b=D/ZMJELDK0eCPcDe0p0SlFbDCTJiTDaWmZ+MHEAWAHNznBilqM5FIy+ZghG1RQOndx
 +t2APfl9YQkzemJ4PnHwjtMlwqITOflm5LNTn1x5i/5xBF2h/RdAlbP9xqpAK9jT+j05
 CyEW2WiCZcV0LQ2cv4l7w6OhLgeGV+crOg43XKNIuk1J/vIy0sY7w+Yjlj2bRrdUE6RL
 5f8Fjzqp8L7u/aZXxRMC/yMmit1pjcFv9AZbuTEFtg7oDOXnOI5Mas7vNkfjQ9r/w/la
 WIk8Garqnt2ZZMOvkPICORVN/iRtPOqssUT6VdrRZDhgMMrYt1avCCFAShAue1I+ibyF
 /2wA==
X-Gm-Message-State: AFq9FYJx9bMNvr9hzOYD0vSWiyF3jPtsV3qoMa6FWByyxnn55dyrT32j
 QRbC6LKrv1ZmwAVrDs1XL27RjeNTzvNLkTMnjy0EMQKjq8SbPfbF38if2qfiCyeSL9IXLOELeLo
 olU8JBrqZMOArhV20u16rzUeD30tJhds=
X-Gm-Gg: AYBFou33X+TMszHsBDmJFncHSnv2hSe/HhG/tQw//8UeLC1H/c6LM58qegLxRB4a7Gu
 FDRR83jeX3FL5EnPhQL+MIhO9eiPYywkMMuuyXqgVqim43EiD3ij58vsfO+lAuJqZdD/l9/snL/
 pCKMW3VwEZtIUV5H6Z0iz8VKuoY9g1KSJ5r+rekg+Whrw+f+iaQTJGPcpfvOQ3PZxgYOhY2s6Gk
 NgEOM2uBqBeI0JDKkHYdlhp5gIV16ND+7ullxjssFQ7XbLYk7UX88tvGtk0G82/3ICHdxmW5HbK
 65+MFFFh24O4W77E7UbDt89Iun5c8fIaXRQCxlslAgNSDoLr4jVHq77tbkLaRn9MczwmP3Tcjyf
 2tP7r3REGtkN1rHbp4RNctA==
X-Received: by 2002:a05:7300:b096:b0:35d:8c39:b2fd with SMTP id
 5a478bee46e88-35d8c39b6f3mr7046108eec.1.1792064510717; Thu, 15 Oct 2026
 04:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-use-qemu-dup-v3-1-ca02b5927725@gmail.com>
In-Reply-To: <20261015-use-qemu-dup-v3-1-ca02b5927725@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Oct 2026 15:41:37 +0400
X-Gm-Features: AclHuK89-VhSG9H6R3wHOwHLpY2Wb3WPSjJTggmdnnAFTAM7yLo-lGruOjyCOC8
Message-ID: <CAJ+F1CKHygyWjVAtFrN9wYOecay3H01uQ2E0PmDgX0UJgUHWVg@mail.gmail.com>
Subject: Re: [PATCH v3] treewide: use qemu_dup() instead of dup()
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 15, 2026 at 5:36=E2=80=AFAM Filip Hejsek <filip.hejsek@gmail.co=
m> wrote:
>
> Use qemu_dup() to ensure the cloexec flag is set on dup'd fds.
>
> The only direct users of dup() are now guest syscalls in the user
> emulators and the implementation of qemu_dup() itself.
>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> For each call I replaced, I checked how the resulting fd is used
> afterwards. In summary:
>
> hw/virtio/virtio.c:
>     the fd is passed to memory_region_init_ram_from_fd, used for mmaping
>
> io/channel-file.c:
>     the fd is passed to qio_channel_file_new_fd, used for reading/writing
>
> migration/cpr-exec.c:
>     the cloexec flag is cleared
>
> qemu-nbd.c:
>     the fd is stored into old_stderr, then dup2'd back to STDERR_FILENO
>
> system/vl.c:
>     no change in behavior, the code was already setting the cloexec flag
>
> ui/dmabuf.c:
>     the function is called by qemu_spice_gl_update, which passes the fds
>     to SPICE server
>
> tests/qtest/bios-tables-test.c:
>     temp dup of stdout, dup2'd back to STDOUT_FILENO
>
> tests/unit/test-util-sockets.c:
>     one fd is dup'd again and returned from mock monitor_get_fd; another
>     is converted to string and given as address to socket_connect
>
> tests/unit/test-vmstate.c:
>     passed to qio_channel_file_new_fd to create a channel
>
> Changes in v3:
> - Also replace the use in migration/cpr-exec.c and the tests
> - Link to v2: https://lore.kernel.org/qemu-devel/20261013-use-qemu-dup-v2=
-1-12ecd94263b7@gmail.com
>
> Changes in v2:
> - Replace the use in qemu-nbd.c too
> - Changed commit message
> - Link to v1: https://lore.kernel.org/qemu-devel/20261012-use-qemu-dup-v1=
-1-03d94852a6c8@gmail.com
> ---
>  hw/virtio/virtio.c             | 2 +-
>  io/channel-file.c              | 2 +-
>  migration/cpr-exec.c           | 2 +-
>  qemu-nbd.c                     | 2 +-
>  system/vl.c                    | 9 +--------
>  tests/qtest/bios-tables-test.c | 2 +-
>  tests/unit/test-util-sockets.c | 6 +++---
>  tests/unit/test-vmstate.c      | 2 +-
>  ui/dmabuf.c                    | 2 +-
>  9 files changed, 11 insertions(+), 18 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index c9f9e5b511..70779fbd56 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3204,7 +3204,7 @@ VirtioSharedMemoryMapping *virtio_shared_memory_map=
ping_new(uint8_t shmid,
>          return NULL;
>      }
>
> -    fd =3D dup(fd);
> +    fd =3D qemu_dup(fd);
>      if (fd < 0) {
>          error_report("Failed to duplicate fd: %s", strerror(errno));
>          return NULL;
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 5cef75a67c..3f707e80c9 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -48,7 +48,7 @@ qio_channel_file_new_fd(int fd)
>  QIOChannelFile *
>  qio_channel_file_new_dupfd(int fd, Error **errp)
>  {
> -    int newfd =3D dup(fd);
> +    int newfd =3D qemu_dup(fd);
>
>      if (newfd < 0) {
>          error_setg_errno(errp, errno, "Could not dup FD %d", fd);
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index daa50916d2..2f38db30bb 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -44,7 +44,7 @@ bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
>  {
>      QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
>      /* coverity[leaked_storage] - mfd intentionally kept open across exe=
c() */
> -    int mfd =3D dup(fioc->fd);
> +    int mfd =3D qemu_dup(fioc->fd);
>      char val[16];
>
>      /* Remember mfd in environment for post-exec load */
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index ed5895861b..db1a70b008 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -975,7 +975,7 @@ int main(int argc, char **argv)
>
>              /* Remember parent's stderr if we will be restoring it. */
>              if (opts.verbose /* fork_process is set */) {
> -                opts.old_stderr =3D dup(STDERR_FILENO);
> +                opts.old_stderr =3D qemu_dup(STDERR_FILENO);
>                  if (opts.old_stderr < 0) {
>                      error_report("Could not dup original stderr: %s",
>                                   strerror(errno));
> diff --git a/system/vl.c b/system/vl.c
> index 468a9fc247..9381e3d7f7 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -614,14 +614,7 @@ static int parse_add_fd(void *opaque, QemuOpts *opts=
, Error **errp)
>          return -1;
>      }
>
> -#ifdef F_DUPFD_CLOEXEC
> -    dupfd =3D fcntl(fd, F_DUPFD_CLOEXEC, 0);
> -#else
> -    dupfd =3D dup(fd);
> -    if (dupfd !=3D -1) {
> -        qemu_set_cloexec(dupfd);
> -    }
> -#endif
> +    dupfd =3D qemu_dup(fd);
>      if (dupfd =3D=3D -1) {
>          error_setg_errno(errp, errno, "error duplicating fd");
>          return -1;
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index f6dfa4131b..c4838322fb 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -529,7 +529,7 @@ static void test_acpi_asl(test_data *data)
>                      const char *diff_cmd =3D diff_env ? diff_env : "diff=
 -U 16";
>                      char *diff =3D g_strdup_printf("%s %s %s", diff_cmd,
>                                                   exp_sdt->asl_file, sdt-=
>asl_file);
> -                    int out =3D dup(STDOUT_FILENO);
> +                    int out =3D qemu_dup(STDOUT_FILENO);
>                      int ret G_GNUC_UNUSED;
>                      int dupret;
>
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-socket=
s.c
> index 006f5e579c..c47ad6c82d 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -62,7 +62,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Er=
ror **errp)
>          error_setg(errp, "No fd named %s", fdname);
>          return -1;
>      }
> -    return dup(mon_fd);
> +    return qemu_dup(mon_fd);
>  }
>
>  /*
> @@ -115,7 +115,7 @@ static void test_socket_fd_pass_name_bad(void)
>
>      cur_mon =3D g_malloc(1); /* Fake a monitor */
>      mon_fdname =3D "myfd";
> -    mon_fd =3D dup(STDOUT_FILENO);
> +    mon_fd =3D qemu_dup(STDOUT_FILENO);
>      g_assert_cmpint(mon_fd, >, STDERR_FILENO);
>
>      addr.type =3D SOCKET_ADDRESS_TYPE_FD;
> @@ -189,7 +189,7 @@ static void test_socket_fd_pass_num_bad(void)
>      int fd, sfd;
>
>      g_assert(cur_mon =3D=3D NULL);
> -    sfd =3D dup(STDOUT_FILENO);
> +    sfd =3D qemu_dup(STDOUT_FILENO);
>
>      addr.type =3D SOCKET_ADDRESS_TYPE_FD;
>      addr.u.fd.str =3D g_strdup_printf("%d", sfd);
> diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> index 23f3173070..57f1e3263f 100644
> --- a/tests/unit/test-vmstate.c
> +++ b/tests/unit/test-vmstate.c
> @@ -42,7 +42,7 @@ static QEMUFile *open_test_file(bool write)
>      QIOChannel *ioc;
>      QEMUFile *f;
>
> -    fd =3D dup(temp_fd);
> +    fd =3D qemu_dup(temp_fd);
>      g_assert(fd >=3D 0);
>      lseek(fd, 0, SEEK_SET);
>      if (write) {
> diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> index 497f82cc61..6d5dffdf84 100644
> --- a/ui/dmabuf.c
> +++ b/ui/dmabuf.c
> @@ -95,7 +95,7 @@ void qemu_dmabuf_dup_fds(QemuDmaBuf *dmabuf, int *fds, =
int nfds)
>      assert(nfds >=3D dmabuf->num_planes);
>
>      for (i =3D 0; i < dmabuf->num_planes; i++) {
> -        fds[i] =3D dmabuf->fd[i] >=3D 0 ? dup(dmabuf->fd[i]) : -1;
> +        fds[i] =3D dmabuf->fd[i] >=3D 0 ? qemu_dup(dmabuf->fd[i]) : -1;
>      }
>  }
>
>
> ---
> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
> change-id: 20261012-use-qemu-dup-38628dbac3ee
>
> Best regards,
> --
> Filip Hejsek <filip.hejsek@gmail.com>
>
>

