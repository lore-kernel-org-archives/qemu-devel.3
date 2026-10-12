Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF067CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 22:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGOQX-000868-KV; Mon, 12 Oct 2026 18:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xGOQO-000843-M8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 18:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xGOQM-0002IF-BX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 18:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791843793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/5bAVXgT4MJMSlxcV/bD/Bu8AfHONRXh44KXr2H1ZY=;
 b=JxNdMIIFGD1630+62I10UDf2v8PxFcZ3Pka+Sj/IoYY8tDIw82BgWxxZMDF1RyMwo5h1Cq
 NgDNH4Wj7UbE9FMwGm1c5GKRBDxN8o99CK4wmIE/3Jo+L3mrf27GuZR/u2naqKElR3eKwr
 gn7nW8u6rkdLX8ZP1PIS2PCMP2qEFyk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-V-oWpUq-MoiqfCf-3EizpQ-1; Mon, 12 Oct 2026 22:23:12 +0000
X-MC-Unique: V-oWpUq-MoiqfCf-3EizpQ-1
X-Mimecast-MFC-AGG-ID: V-oWpUq-MoiqfCf-3EizpQ_1791843791
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3abfcf726dcso1579394a91.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 15:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791843791; cv=none;
 d=google.com; s=arc-20260327;
 b=VadwLNIEqKW8wpBFhz+GLykpTmevnz9DqM1WC7DUQn14q1sIHx33qfDH9WxZmn+z4b
 d+RDkegyjaNweHRrt6IMkauoRi1Oj7k7xLhoqlBIgXWKXKWMDLqxtaH/hhSdOJF0xPVE
 L+l4pH0xazaVmpL5kiG9mJOuHQ1oCGN82nRLprQcRhU0/bt60jqmN++d3+1evoTle83x
 zfu9ILt4xm0WFl+hLST8psGq+ZtQJ+fvw+CGn+yvXi8uE9lMjKftW2YBY3n/jvtwhpeR
 jyBMG/DtcBwub0WcKyMrTfwabrxMWIwkP/zQuNLEhG78CFrZaW/HegNjE91fNxnyFrUj
 zICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q/5bAVXgT4MJMSlxcV/bD/Bu8AfHONRXh44KXr2H1ZY=;
 fh=muKFwrgRfp/xDxP0wgHzv/iNwuGZ/35XDHkFeJz5+K4=;
 b=W/ej8KTec6+yMDZ3eHqN2YGfVAF7hzJSgSwVL+gZbdV3LJSZojSs7/jSTiEogdtscu
 71r671Cqj5wp3f+58tzZp4hmH/pF3EYKRL0UxPxHJytQot260d0OfuzY6XYe9N3rgP5r
 3LgHcIXgIYXP5dPj7KLzAUxvNGVmekG530XFVP0J0L//OGSTUcGfIgXPDaJru7JYqWGw
 NLTE3tkdRWWnfmRjQRurpP2mOmM4L58g7SJYppvUO81VDe+o0TeqGAvTWYdtZyIO1QS0
 YsOSRXXAEe3WaCaxjne2p4i/rMepuO0UmUMuOeLqPddP6sJIL+lgG9p/R1AL26b/ReIj
 LvpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791843791; x=1792448591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q/5bAVXgT4MJMSlxcV/bD/Bu8AfHONRXh44KXr2H1ZY=;
 b=HOIKllnba4YfR2+rysUXgvoNWyfZJM8rkpFa4f0Mh0RG1pMmqTbIpCupX1uQliOal7
 cb1FT/r3JeFPvOrwoT+USNjBXzmz3Pi3s2hzOqhcTrDTheHzUoeuGjRNRqZ9tZq4X2CR
 EQmu1w+pG3tifWE6N3nwksTi8fdhFAiCdkY/iUHc3IjwCIoQZePXH0QtgLUzwRGxKVbQ
 crerWv+4/eyab1t5DVqp9NiwHzgxZu9ziFHuIxx6bU6q91uCCdg18YKOm2lgupBpNEf0
 CULcwFMoGn/uVltbnldYIzfyavHiC6It4abpWfZhDp2OWyvLO1EzsU62yb8B1guT4rO3
 GFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791843791; x=1792448591;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q/5bAVXgT4MJMSlxcV/bD/Bu8AfHONRXh44KXr2H1ZY=;
 b=N3buUoUsuSYRn1CW1gMa8pD3xKC/mhWe35NCu5ANd3OXOBzQq+rDsSMEQfyfXr4jTw
 yR0e6b8Fe5nlYVaVQdfByRd9Ug0D4f4XyznMWcyZ9tMI3AdXqVFWS5E2MWRlwPyeH0uT
 9aw1OLEC0qMSUTZZ6Fh7qhx2A62msjoEaetaC6j+sVUYcWIaBhfDXMaAovdIrkP66zXg
 IlwbyRcUxOLLX80Om4+WEDRf6OEtbodguMwz9sTlq+Xe/EiX2WO/20otsq9hrPLApoY6
 OZLp4n5W8RZdL7cDiB68DPvhCDJziFywSQsUuXpXd9PRMyvPvdy7D/zAzUMFoCvQtsKP
 l2uQ==
X-Gm-Message-State: AFq9FYLemtnKbaJ6hICqYSVsQXFxfVO2K3wz2A9lLPTzHiLBCnrniw+A
 i8qfjE5EiEtei6KPgxSCKF7rAE+nfuA4Eyh9sKfR0xwHwRBOgg/AjRb8JQ3LdFXG2mUIt3uPjvC
 M9arnfzic/P557DUFvjs3G0xtwX11aGG8b2zQePa4mbhEeHnDy10Rm0U7t9/LEKIZ42zdJPXhpc
 hDXoeFcZKuC5//3wiqQvn+FkjTc9fodvo=
X-Gm-Gg: AYBFou3VqI18XOY9Ec/LQ5BDS7mU/X7PeJk4e/hXFt8jtu2lAJjbIOZTUfj6Ca5+7vX
 5oFksl3UjFCldF8grRbkebsHONiZtBFJ2tLpqIC0QESvoN9wpZE6NLQyWJqesIEL7rfChy3b1ZG
 nnMIAohAr3iexvkuVVleYWGeWwkUiBb++8n2WjVJ1hH6KsB6vYlM7wR+eH7gAxJ56PAk3ud4Va9
 VjsN6vGq/cUnDoxMuVw6Vs9rjVn6BT+0/MIzVjBtbxwA5cCz7eOoMWpEdXLwJNJRWhv86catHlu
 Ww==
X-Received: by 2002:a17:90b:3946:b0:3a8:7fa3:fd6e with SMTP id
 98e67ed59e1d1-3ab3ace0294mr9347435a91.47.1791843791330; 
 Mon, 12 Oct 2026 15:23:11 -0700 (PDT)
X-Received: by 2002:a17:90b:3946:b0:3a8:7fa3:fd6e with SMTP id
 98e67ed59e1d1-3ab3ace0294mr9347390a91.47.1791843789905; Mon, 12 Oct 2026
 15:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com>
In-Reply-To: <20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 02:22:57 +0400
X-Gm-Features: AclHuK_7F-NYJKyNgvhAHbH3_FdHawYKE7OIpl6_ufaVBEQtSekG2nG99GKkNMM
Message-ID: <CAMxuvayw0=C5jbB7KZsU=BNixtrFLv8dLO6JEmDG=DgLgW5U=w@mail.gmail.com>
Subject: Re: [PATCH not-so-trivial v2] treewide: use qemu_dup() instead of
 dup()
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, 
 qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 13, 2026 at 2:02=E2=80=AFAM Filip Hejsek <filip.hejsek@gmail.co=
m> wrote:
>
> Use qemu_dup() to ensure the cloexec flag is set on dup'd fds.
>
> The following dup() instances were left unchanged:
>
>     FILE                     REASON
>     util/osdep.c             implementation of qemu_dup
>     migration/cpr-exec.c     fd is intentionally kept across exec
>     {linux,bsd}-user/*       guest syscalls
>     tests/*                  left for future work
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
> These uses shouldn't require keeping the fd open across exec.
>
> Changes in v2:
> - Replace the use in qemu-nbd.c too
> - Changed commit message
> - Link to v1: https://lore.kernel.org/qemu-devel/20261012-use-qemu-dup-v1=
-1-03d94852a6c8@gmail.com
> ---
>  hw/virtio/virtio.c | 2 +-
>  io/channel-file.c  | 2 +-
>  qemu-nbd.c         | 2 +-
>  system/vl.c        | 9 +--------
>  ui/dmabuf.c        | 2 +-
>  5 files changed, 5 insertions(+), 12 deletions(-)
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


