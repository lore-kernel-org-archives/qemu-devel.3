Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7CCC36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoWK-00026P-Pv; Thu, 27 Mar 2025 10:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1txoWG-00022l-Cq; Thu, 27 Mar 2025 10:47:45 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1txoWD-0006lV-Vf; Thu, 27 Mar 2025 10:47:44 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c54a9d3fcaso112113885a.2; 
 Thu, 27 Mar 2025 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743086854; x=1743691654; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nteguibeVn3jH35/nVKmHLKNfKm/mJ7uq24j+XbEzF8=;
 b=Ljc9RPZEqcePxutoDLIZ3+g8W+GHgGMdQF3Ki3ivaYJ4lGnbsr9J8UtLRnbek01dLN
 A9H/Dler73SYsjpRjHEskOAzA43gYz45QRy95V8p+FbpfotRbxK0hp5nvAvYW0McNf6f
 GlPrwGpiXiBjskOk+Q5RvXHS1ER0P5AI32UHiRpsd7bKVoKhV+L57TyfXPdPnJs2V4dM
 P/BPUxkhHnTxW+upjzpsfkGZd0vmhRcv1eyH0gTdoDu+gUWmLzxONLFJifqgYkSniE7R
 tVPYhLe+F7Giw3bzhqh1Mny0BQRjscYYWvYuyGEJjiC7VU3yInYq1WBckqf1EGiMderF
 EvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743086854; x=1743691654;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nteguibeVn3jH35/nVKmHLKNfKm/mJ7uq24j+XbEzF8=;
 b=YBHJXGr1+mmz9FJs207PGQF46pLs2BRtFd57oGbZKe98JM2rOQkxXzEZa1OXLQan9t
 /NUzfORKCOTppDQmPVYiKXJU9srcmN6le8oH5k+vLL9x3tt/GRZfznR9OJ6len67iNm6
 Rf9lFqfejuFZ11xlpsYenM9TWKcEqWwzmWBq8Wg7Y0SkBaE2V4jsahnioyoJlP7fkV5R
 CjgvGF+U0s0wjf1NYG0pY7Rs/NNFLnYxzxuDcYqBaVaPBM2i/BlLYwwiAKKujjzN7ETy
 TO+XtGOkMV/xkN8hJDIrFdHoOi/p3Tw5SK3YTQ9TkmhZEgSZHL/dXf2IAy8uUg/BKj4h
 NEwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrpU3QhhWdIpTZxMvRa9wXwmCpfa4u7wCnIJJncWqo6fLEZMZL4KWB3aRNCi7nvP+k8EjoRF+mgb1+GhI=@nongnu.org,
 AJvYcCWhjgyV98kKY9UkvhdSn4Xudg2BVyhP8MvzHRQUk71+dJ6X+438ZNBve/lD4GdlTM/laqVr7TYvRV7R@nongnu.org
X-Gm-Message-State: AOJu0Ywsq1KFxaxd/FF5A/ii4BSXFvbNeXIXNOEdxXmMPOfsP3D0u91B
 4T8IZ27WByQdJ01TMfQJkUxB8SO5qM5Pif5DkE7kIH1JL5ana1xw
X-Gm-Gg: ASbGncszk9JOe9U3IR3/5mMMHdhwabX3rJlrhMSVS/t2rNj7WKPHpjaC/bs5Dx/0aUm
 1v2D2feq7pkwcfFc5ektEje1LwycncBgH6iGSJwUvsjF3EbMWPRh34EATIlXuH2kjyjUfIkIgpo
 h5Xz+AEVTW0SnATQF+Dhi6KHTBus/WY9VHMHjooL1ELNSKT6dOVgUAErxBUB6jnJlbRhNuLBhoY
 7hXoTfB39tNQUZRRUtLPtgcqY+5vkIrRJnvP7UM+uwCQA25doSVhnavYzJ13JZWsKhXQHDGBdWb
 PaitBZbaQtSTqCLtlH+gzoyu4An8GReVfw==
X-Google-Smtp-Source: AGHT+IErFlaejL01/9DO5qxTBIqanQpM+JkB4bgyqKaJHeVbDaE5+DMcKxl2ahPE8EVKseTfPwTWIw==
X-Received: by 2002:a05:620a:40d2:b0:7c0:6419:8bd3 with SMTP id
 af79cd13be357-7c5ed9fa21fmr464888385a.22.1743086854293; 
 Thu, 27 Mar 2025 07:47:34 -0700 (PDT)
Received: from localhost ([94.140.3.102]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5f768e744sm1622185a.48.2025.03.27.07.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:47:32 -0700 (PDT)
From: Stefan Hajnoczi <stefanha@gmail.com>
X-Google-Original-From: Stefan Hajnoczi <stefanha@fedora>
Date: Thu, 27 Mar 2025 10:47:31 -0400
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH 01/15] fuse: Copy write buffer content before polling
Message-ID: <20250327144731.GA37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160635.118812-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1TUTtNN3RcMHqkAU"
Content-Disposition: inline
In-Reply-To: <20250325160635.118812-1-hreitz@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=stefanha@gmail.com; helo=mail-qk1-x735.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--1TUTtNN3RcMHqkAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:35PM +0100, Hanna Czenczek wrote:
> Polling in I/O functions can lead to nested read_from_fuse_export()

"Polling" means several different things. "aio_poll()" or "nested event
loop" would be clearer.

> calls, overwriting the request buffer's content.  The only function
> affected by this is fuse_write(), which therefore must use a bounce
> buffer or corruption may occur.
>=20
> Note that in addition we do not know whether libfuse-internal structures
> can cope with this nesting, and even if we did, we probably cannot rely
> on it in the future.  This is the main reason why we want to remove
> libfuse from the I/O path.
>=20
> I do not have a good reproducer for this other than:
>=20
> $ dd if=3D/dev/urandom of=3Dimage bs=3D1M count=3D4096
> $ dd if=3D/dev/zero of=3Dcopy bs=3D1M count=3D4096
> $ touch fuse-export
> $ qemu-storage-daemon \
>     --blockdev file,node-name=3Dfile,filename=3Dcopy \
>     --export \
>     fuse,id=3Dexp,node-name=3Dfile,mountpoint=3Dfuse-export,writable=3Dtr=
ue \
>     &
>=20
> Other shell:
> $ qemu-img convert -p -n -f raw -O raw -t none image fuse-export
> $ killall -SIGINT qemu-storage-daemon
> $ qemu-img compare image copy
> Content mismatch at offset 0!
>=20
> (The -t none in qemu-img convert is important.)
>=20
> I tried reproducing this with throttle and small aio_write requests from
> another qemu-io instance, but for some reason all requests are perfectly
> serialized then.
>=20
> I think in theory we should get parallel writes only if we set
> fi->parallel_direct_writes in fuse_open().  In fact, I can confirm that
> if we do that, that throttle-based reproducer works (i.e. does get
> parallel (nested) write requests).  I have no idea why we still get
> parallel requests with qemu-img convert anyway.
>=20
> Also, a later patch in this series will set fi->parallel_direct_writes
> and note that it makes basically no difference when running fio on the
> current libfuse-based version of our code.  It does make a difference
> without libfuse.  So something quite fishy is going on.
>=20
> I will try to investigate further what the root cause is, but I think
> for now let's assume that calling blk_pwrite() can invalidate the buffer
> contents through nested polling.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 465cc9891d..a12f479492 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -301,6 +301,12 @@ static void read_from_fuse_export(void *opaque)
>          goto out;
>      }
> =20
> +    /*
> +     * Note that polling in any request-processing function can lead to =
a nested
> +     * read_from_fuse_export() call, which will overwrite the contents of
> +     * exp->fuse_buf.  Anything that takes a buffer needs to take care t=
hat the
> +     * content is copied before potentially polling.
> +     */
>      fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);

It seems safer to allocate a fuse_buf per request instead copying the
data buffer only for write requests. Other request types might be
affected too (e.g. nested reads of different sizes).

I guess later on in this series a per-request fuse_buf will be
introduced anyway, so it doesn't matter what we do in this commit.

> =20
>  out:
> @@ -624,6 +630,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t ino=
de, const char *buf,
>                         size_t size, off_t offset, struct fuse_file_info =
*fi)
>  {
>      FuseExport *exp =3D fuse_req_userdata(req);
> +    void *copied;
>      int64_t length;
>      int ret;
> =20
> @@ -638,6 +645,14 @@ static void fuse_write(fuse_req_t req, fuse_ino_t in=
ode, const char *buf,
>          return;
>      }
> =20
> +    /*
> +     * Heed the note on read_from_fuse_export(): If we poll (which any b=
lk_*()
> +     * I/O function may do), read_from_fuse_export() may be nested, over=
writing
> +     * the request buffer content.  Therefore, we must copy it here.
> +     */
> +    copied =3D blk_blockalign(exp->common.blk, size);
> +    memcpy(copied, buf, size);
> +
>      /**
>       * Clients will expect short writes at EOF, so we have to limit
>       * offset+size to the image length.
> @@ -645,7 +660,7 @@ static void fuse_write(fuse_req_t req, fuse_ino_t ino=
de, const char *buf,
>      length =3D blk_getlength(exp->common.blk);
>      if (length < 0) {
>          fuse_reply_err(req, -length);
> -        return;
> +        goto free_buffer;
>      }
> =20
>      if (offset + size > length) {
> @@ -653,19 +668,22 @@ static void fuse_write(fuse_req_t req, fuse_ino_t i=
node, const char *buf,
>              ret =3D fuse_do_truncate(exp, offset + size, true, PREALLOC_=
MODE_OFF);
>              if (ret < 0) {
>                  fuse_reply_err(req, -ret);
> -                return;
> +                goto free_buffer;
>              }
>          } else {
>              size =3D length - offset;
>          }
>      }
> =20
> -    ret =3D blk_pwrite(exp->common.blk, offset, size, buf, 0);
> +    ret =3D blk_pwrite(exp->common.blk, offset, size, copied, 0);
>      if (ret >=3D 0) {
>          fuse_reply_write(req, size);
>      } else {
>          fuse_reply_err(req, -ret);
>      }
> +
> +free_buffer:
> +    qemu_vfree(copied);
>  }
> =20
>  /**
> --=20
> 2.48.1
>=20
>=20

--1TUTtNN3RcMHqkAU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflZQIACgkQnKSrs4Gr
c8hIuggAiCBxC5BRCq9pXrGlH6QdnNKI7ZhLXNH0dyOf6j67GVYFd9qrhB3p+nvG
W5gv2DqFGe2ncdBU4kdoEaBEEztx6sKqYvsCJqnAx4wnePWLzHLYlxJ3NRqn/Zt1
DtJhnMvwQC8q3LrwSNSyaMTwN0NDLgGVz+eYhfYu3mVsXOguiwsr4nytPYy7ah5B
vaH6DJlewgr3uTYqqTLmz62IdqaGeHSqtgZ0I50WXXKcWHVFxcsmmgvVmfjWUzlR
3/E//gLRQqtt2597f9D9Wy3EefTN/Wy+aNT187Je5iCMVgoQTnfKYgxWKZxqRFgE
Cs15giOveJVSaMW8Pg26fAo4hmFGAA==
=EJG1
-----END PGP SIGNATURE-----

--1TUTtNN3RcMHqkAU--

