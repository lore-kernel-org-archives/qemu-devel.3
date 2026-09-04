Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219DFC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2NND-0007uC-Qr; Fri, 04 Sep 2026 02:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x2NNC-0007u3-MT
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:26:02 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x2NNA-0005BL-R1
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:26:02 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6b132a5009eso502047eaf.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788503159; cv=none;
 d=google.com; s=arc-20260327;
 b=Z99kEX2KiZKQImMMXkXhcTx9aZPhtHjlTHLcxrvAdHdBHsNDJonspdaf8BImLOrnNa
 XU6KB8JzqCPDiB7NCiRriYt5ZkQjlsev4WBkO1auFqwjzM1TjZlBo/ZCkpUhprv4n31V
 hvlKUj1Bx+SJ1uodlgIfh2oooE57fn3QV+R6PDkD2Nd2x2g8/c4rYJ/ML330inu/c/9U
 rN+fL5THDeQ+Yz+ZK8Q3FmdSTi53zDz6mj7O0RryR5c8S1hehkO24ue6RXnEoZrBE+nx
 V0FxlJzHjqnMPi4degGyQg2iOV/7Moba8zNPa1Ld+ytvcSZuKucuXY6H5lCr6Q9P79ow
 whTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+NlTpS7s/PNLMQzu/ey6IpvpuXko14fxulDuFRhE5rA=;
 fh=6kJ3CohSxQ+7EgnARanNFMAgatAnP0uu5SOkx3O7QGs=;
 b=HX1/joYGfc13805hLCiM0pyOnrpb7ENIfdROCO/WEkEOx3DJnGi8+ZUxsWWbdZ6V5V
 uusMU6doT8cN9Orbzt+lY6y6/ETEVzZ9UPudi8l7BfvYM1eqB+g3Bg98qgzx6v2K8w1+
 yzR3HXx2LpIFWVEMwJ1L8V7+pghi/DhW2hOy0SJxLlCss1qn86knE4LplItf7Vtgs1wx
 8bVie/Urwij/hnvOO3gKSWOlDhlCDdRnMqLILmhrR3CCS8SVTrJM0yWk9KJYwU14p9Ka
 dZs9QliRn/4RI612H+meCu20AeQbMqiSIzbRjGYIKRBl5TX/nVogkyrdMYQ6XgqQrgk0
 paEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788503159; x=1789107959; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+NlTpS7s/PNLMQzu/ey6IpvpuXko14fxulDuFRhE5rA=;
 b=bV05qYhN0bNNUpZVqnW2EFMDajoU72Z6UdNUctdUDA5TxDM+oo+007lSfaD7QP7dRr
 WFYFCSABy1MI4CJKzayL7aTEU/JkiBc1QqA61gpqnsk6scH5nWd6oC/6jc2+qxSUWAue
 lxRBsQuTWGcM05LuPZ9+J5AarzupkprVywP310qu/SuvAys/7pQeRw+PIv8Jd4qjHIAS
 z+OUkmEBRQNfQ4LRzxqYef7UFRk5Ri/yNDzJD8lPwhCV3TUNO5It7j7VeQB4AdDW9O9F
 UyRI8aEBKLoyHLUpY2VNk0zZAgubYoVG4ZOIgIN7GX+iehZbgsLo0/odFnq36izkf+Ta
 3FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788503159; x=1789107959;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+NlTpS7s/PNLMQzu/ey6IpvpuXko14fxulDuFRhE5rA=;
 b=gPXLsufvVonbuRK+cdlJg/96AWvGCxtfgu+woWANQei9JCSUJMN803c6hzZ3ID6w78
 ApRTX6OlKlZbstbi40/yIc0vzo+sGmHIJKWqH5xG7XSpEBXILBK9w/2qpq22tYq2bXPq
 iq5Mm929dM4zFAekJpZwBdn36xBKliyAMXV5HD7EXjm7dJ2v3uG5DS2PDftEk5a7hjKl
 Vne9Uy3Vl38bCi2LK4g6m374ZYtqEPI9+e7Sy3ss13cl+6BY0YIQ251fbu+U8eRZhwCl
 /ErsfdWfma44tv+/dK0tKDAsXfRmUtVYfSOYsdFs4P+vKi4ET5zHD+/wD7pxJd5iZf1U
 5I/A==
X-Gm-Message-State: AFuF++n5mZSRCukoU6TMHXR917HmXqlTolPWTiMU6zvxU/2858mLZYmY
 JB0fVx2QtRueQiY3C0MfZl39mAfT7a9PAKHv9VuYaq5F00vkVBwJgHh+KM0yvX+NTN+oLoRHexw
 K+/kdIaqp+8Y1SKB4asyfIZ35TPRBQ8w=
X-Gm-Gg: AYBFou2eKDia0dZC+j9Mgkc7Zvmqr88f0w8GP84PLtIArQRGYh1wYdBMunc0f+iu7KS
 h87mvEGyZwnPTVWjgaOsFx2VzgsynNdUfSO9UKDQ2Q6l56HTUj9dMXric4WX8cPb1fVNTLM2Bwv
 0GSUrnuWCgcU0OPCyj4UHklHXrOPRlPDp9tlO95yOAQOdIa6xMFN4eeuLTg0Ca1ezqoXcYnjuuZ
 T/uuz/cs/6inyoNU73yJ+WzR5jiITkx+ACMu+cCsVOj4s5yIa0ThsQsO9vMnv2Coqfk9zoba9i9
 no/1VnXLiog1KXH76sSEpO++IFGSqbkQ064A+aRzfxt2zfzFK3ulG355SIcn8S104ezBlrbeWbo
 o
X-Received: by 2002:a05:6820:2211:b0:6b7:46fa:169c with SMTP id
 006d021491bc7-6b746fa1a60mr1255735eaf.49.1788503159537; Thu, 03 Sep 2026
 23:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260903220523.2849019-1-farosas@suse.de>
 <20260903220523.2849019-3-farosas@suse.de>
In-Reply-To: <20260903220523.2849019-3-farosas@suse.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 4 Sep 2026 10:25:47 +0400
X-Gm-Features: AcwNN1UqxEktoRJvJAzbQ9FMw7hIIXtn8PdyVIzsx6fEYxQH6wfrVtwoHLQtUsc
Message-ID: <CAJ+F1CLWCrMqNazT0mMpSzPQ45BnVbeKudbnLR0kfVzOSBZ3Pg@mail.gmail.com>
Subject: Re: [PATCH 2/3] migration: Drop iochannel reference during snapshot
 setup
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oo1-xc31.google.com
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

On Fri, Sep 4, 2026 at 2:06=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> During migration there are usually two references to the iochannel,
> one from the channel creation itself and another from the ownership
> transfer into QEMUFile.
>
> - The reference from the QEMUFile is decremented at qemu_fclose.
>
> - The original reference is decremented at migration_connect_outgoing()
> for regular migration and not at all for snapshots.
>
> The ide-test has recently added migration support and ASAN has
> flagged:
>
> Indirect leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x55ca12aac0b9 in realloc
>     #1 0x7fd97d7e5a05 in g_realloc
>     #3 0x7fd97d7c98c6 in g_hash_table_new_full
>     #4 0x55ca14e186f1 in object_initialize_with_type ../qom/object.c:506:=
23
>     #5 0x55ca14e1a590 in object_new_with_type ../qom/object.c:706:5
>     #6 0x55ca14e1a7e8 in object_new ../qom/object.c:722:12
>     #7 0x55ca12de896f in qio_channel_block_new ../migration/channel-block=
.c:32:29
>     #8 0x55ca12ec8f2d in qemu_fopen_bdrv ../migration/savevm.c:172:49
>     #9 0x55ca12ec8b42 in save_snapshot ../migration/savevm.c:3375:9
>     #10 0x55ca12ee18e3 in hmp_savevm ../migration/migration-hmp-cmds.c:49=
7:5
>
> Change qemu_fopen_bdrv() to drop the original reference once the
> QEMUFile has taken over the object. The xen code already does the
> same.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  migration/savevm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 5b0e89ca7c..8d4bdc28ab 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -168,11 +168,16 @@ static bool qemu_loadvm_thread_pool_wait(MigrationS=
tate *s,
>
>  static QEMUFile *qemu_fopen_bdrv(BlockDriverState *bs, int is_writable)
>  {
> +    QIOChannel *ioc =3D QIO_CHANNEL(qio_channel_block_new(bs));
> +    QEMUFile *f;
> +
>      if (is_writable) {
> -        return qemu_file_new_output(QIO_CHANNEL(qio_channel_block_new(bs=
)));
> +        f =3D qemu_file_new_output(ioc);
>      } else {
> -        return qemu_file_new_input(QIO_CHANNEL(qio_channel_block_new(bs)=
));
> +        f =3D qemu_file_new_input(ioc);
>      }
> +    object_unref(ioc);
> +    return f;
>  }
>
>
> --
> 2.53.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

