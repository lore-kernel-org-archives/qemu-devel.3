Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD9BCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 19:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGM7D-0004XX-NU; Mon, 12 Oct 2026 15:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xGM75-0004WZ-IU
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 15:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xGM73-0006Ua-Ag
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 15:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791834905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLJeDYUYjeX9xlerYn4DvwzSnpNc7rU+oKijboDlKzk=;
 b=gAqtJhlLosTfQzYqgOLBD82jnVd2VDSuSdZfoIioWnzL21WyUETPVsxTmh3hrKP5NJg+mU
 AqrohM1EcVE92cE9VY3dR5ccib0HOskYJ/gep8kn62KlTEi7rl9WgsY9JKGuqRi1wUSbee
 azkHT2Y/s9PcftT7Y7CTa22GY+OBiwE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-5re8oTlqMsyiC9uHUm6DTA-1; Mon, 12 Oct 2026 19:55:04 +0000
X-MC-Unique: 5re8oTlqMsyiC9uHUm6DTA-1
X-Mimecast-MFC-AGG-ID: 5re8oTlqMsyiC9uHUm6DTA_1791834903
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so2919234a91.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 12:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791834903; cv=none;
 d=google.com; s=arc-20260327;
 b=U5PHzmYGcVL4U4mfgIuQ3GYx2H5P0mIGU4C+9Wu4r8syNkylokIiiMkC0ij322M4cf
 +ay2167GNyH3fIZvgp9Q4MMuxYvm5sz3gGtyecgwovMgKkLLuwriwKuRJceBlMc6/rE3
 3zBmkH7T046PAWgpoXIe3xdAl8upBzWQVRPjEjWwfENuqjnUQc0+8N0oxc7R8QhEgkWL
 rCi3NYAuNG/sl7CkM55ovl4Q8n963rzkCLNwc1LGdi6Tx5Gijote49FvfviMlZvVc6jN
 xfFFvN8nDdKZFCBeW7ssWxe6qNUA80VfvDbqTos1bV72UVDGUYpovZednSE/dos5Sem3
 78iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qLJeDYUYjeX9xlerYn4DvwzSnpNc7rU+oKijboDlKzk=;
 fh=gabgjmGRizZRna6sTUX+qa2A1eQNICB4L1qL/G9t1YE=;
 b=kHPEesUMmKQPgYyYEBRz7EL/3StivKzphM1oUXeqWM4ktNKeYeZKRmlHIVzyy0wMP/
 weCnWQKSqHNpM4RfhSbk2DsV+9AC5yF4eIsNWF3nOIOoZPgDZ6B4qFA7TS6533wzKUK/
 NEblPSmr0q/zO6pGLWVhiM6YysC/Vhs3sFoNKMtw4uH2BaVw552QoEBM3Ct5YuwcMaTL
 wL5cfReHIgBCsYD8PvT4jjAKCv57Z0qnEn+23rlBgqGrboQs0AgKBfaY6IfnOFgR3cJO
 i1bMAGk5iEk/lUokikLcwZxrzrU+KVlgPsKZb4aa0dlAZ7cGNAcKScW6vcRj5awu637a
 ZJOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791834903; x=1792439703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qLJeDYUYjeX9xlerYn4DvwzSnpNc7rU+oKijboDlKzk=;
 b=kej3xP6ChZY9un75dxN3Ttsof6rHCxaVHTM4wjXz5NvgQb14AF1tpfUrPJtRsPft5e
 HPdm71DcIBpSuXX3KFP0s5Ve60rG85Oas6GmFBJIlQQDHs+OSlSRBPSRovme4j5w2pPT
 0fPp92J075PJhYmwUZaXeWHDu35KYrIuPfYmWdf5B+Bqtl0Od/q6C+kJxfxBQ0qm1XN7
 XHsMEmouXnISAyPIPw6XMVD+QCOGL8dWahgqiUSX0xzOQdgEKKYe3IBH9E18zTD9QE2u
 bvmjY1ak4nU1vQN6BDQHftkQtNuuRv99I0oBVch+ctGEtNg2y/+o6Vm/nXESNIBzWOzl
 Rnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791834903; x=1792439703;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qLJeDYUYjeX9xlerYn4DvwzSnpNc7rU+oKijboDlKzk=;
 b=ceuEEPUEdP8MWdFULOXceExZgF4F6//SHRTgBAYNyYa77GHOvIwrn2oYXlGp7Rvdkw
 JEdxZVHStKPfxjpnv6/olHzKSX9HZU9OASLokdP6Za2brEmNu0fgG7uxGTaom0D0ZGOa
 4y2hKxGEgwLfKRUx7yoVYk7X9aAQ4eT1zQVD2CxDyflGHsKEAGPyZoyc3GXJchnQPoGO
 pFiArG6RFX0I4wIStHai/OQyqe7mDfKnagSVi0bUmP2GOyaPb03kzUnss/uyQmnzOHXK
 pg8866gPwLVbC8v9ZCGLR3YRbuzLna/EVkLL3iR4z2aH2lJir9hrVGoHtR3ft5RC5biL
 IU7Q==
X-Gm-Message-State: AFq9FYIO+v6SBSZ/DdWDdQIgyHRUm9EZce+sF/ZzB8Ya/+sH5wrpJlvX
 IdzLPl1y67ylVZNviUl8RDmxbDK9zaxJbafCUn6eFyAQUOBzgLNx8VO4wJito4FXKpcEzj2J2Ji
 5wrD4LnA+Rr32mjfbmCHkjqcbmfRBowxY94ydzALBFlAgc/Eb6U7OkjFHS+SGGOCj7adX1fSebV
 IzautVsMs4JUeM5r+/V6pquoMxZh7hJfo=
X-Gm-Gg: AYBFou0KhUXZ3H0kRzzaGamC6lPhM7+EklPSU8EgTcdumCFZzJRBLtkXt3YwfU75Hti
 W5w1WNG0FYbSwcIfUnxr2JJ03/+l5ZcoxFwh2c0X3lyLaYQw6qQ3DhtZF3UoHV5djbTI48A+ry+
 +RNtsp0P7lnG2cQRDOpGXr2Cjlob891T9aeoJ8AOFflvndDieIFsDphsG0B/87qO/wf/VkxrSrE
 h8vf+SoHgOPoXumejGfi+0synzEx1puwupCojKhKkuotjnzn4RpEPD0QieRB2nG+TDAVBgVKqS+
 mg==
X-Received: by 2002:a17:90a:d007:b0:3ac:3588:b548 with SMTP id
 98e67ed59e1d1-3ac3588b5edmr833168a91.13.1791834903220; 
 Mon, 12 Oct 2026 12:55:03 -0700 (PDT)
X-Received: by 2002:a17:90a:d007:b0:3ac:3588:b548 with SMTP id
 98e67ed59e1d1-3ac3588b5edmr833147a91.13.1791834902756; Mon, 12 Oct 2026
 12:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com>
In-Reply-To: <20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 12 Oct 2026 23:54:47 +0400
X-Gm-Features: AclHuK8l3L3goL5VpSPfzJvVuCXKjQCpqYY89uQAfl95EL5a-ZsDVBXW6lFf6Lc
Message-ID: <CAMxuvazc5iHk=GDysFHVFN0xtf-g75AobhoKdPXaR6_Qz=dDNg@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL] treewide: use qemu_dup() instead of dup()
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
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

On Mon, Oct 12, 2026 at 11:44=E2=80=AFPM Filip Hejsek <filip.hejsek@gmail.c=
om> wrote:
>
> Make the use of qemu_dup() more consistent and eliminate the possibility
> of accidentally creating non-cloexec fds.
>

Not so trivial, in my humble opinion, as there might have been some
reason it was avoided.

> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
>  hw/virtio/virtio.c | 2 +-
>  io/channel-file.c  | 2 +-
>  system/vl.c        | 9 +--------
>  ui/dmabuf.c        | 2 +-
>  4 files changed, 4 insertions(+), 11 deletions(-)
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

After review I think these changes are valid. These changes shouldn't
impact the exec() code paths in qemu.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
> change-id: 20261012-use-qemu-dup-38628dbac3ee
>
> Best regards,
> --
> Filip Hejsek <filip.hejsek@gmail.com>
>


