Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E468CCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gn2-0005QN-03; Mon, 22 Sep 2025 09:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0gmy-0005MY-Qr
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:41:08 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0gmt-0000JM-G6
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:41:08 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-74625f748a0so11108737b3.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758548461; x=1759153261; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQ20Y8k6XEdPM2+EZW8Cijyra+ZcMG8pux8eabWJVyI=;
 b=E81VjTYiIzNodYq9NGK7ddGzw9jWMdH9jGCFeSamZxEaEdNshbNJpp4CHk+hLyEcHB
 cYsshJ6u9+/lwMeejXh/fVXuJOvYi+lmPF/+9bcQz4x62csVNPtLlaSmmI7ORGS8LpYn
 hGCRcHAcYNf1BqktlZ/QHzd5oqqeEUcVeWV4lnMaNCqZQnDlKa/5/cxYhrGsWI9aHR2c
 2k3kEOuLpoojsKjJ10lCNbHPulQMQHT5RTksXX1NegKXp07y+CGFvP/rysLQfNc2cVue
 ap1YmZ52WzXKRhu1l6v1N/kzSPTtE6kHPYmy+Cnt9KJQpzH6QGxqhp1bWPxj+Ucvt2Cg
 itFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758548461; x=1759153261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQ20Y8k6XEdPM2+EZW8Cijyra+ZcMG8pux8eabWJVyI=;
 b=BTrNV2QpxR+E2Cl8XQOeqhyYQsuITjkvB+J5GE4rH9kbDFQ2/QXqQWpRqXy+AqBKUj
 tzYeLmhSXea97ERvYzNCQ1MMAuyJEu4pkzLlXoEET4cA7U475OM8BLMKj73vjw2dPAZz
 vHpAcNlH/os1/YA9Hmq0jptpV8YpvK6nTB4H31KCuPih5lJ/2Y5Naeytm8CAM0cVVL3Q
 OOGUipJEd+xPa/8mu8XKLxKrHbZ5mtthFLYwmNxewD5UMEVNgmcKREc19x3TGSS/mMoq
 wgO2IO71xYtnbJlttbgNz1MY6Fpn420RyFn19t/uToVL9ef1aH4O0A2VueCTCEMnTqLJ
 llxA==
X-Gm-Message-State: AOJu0Yz+ZuyVo064YyocRq7AMj3Xggi0nMbzTzzy8FROCd4lrAr4a4wE
 2BWaLkCYAyeOPdQTPzl4h2fPHZNzu2nEFJcLpTTMzOidrN0HOA5TCs84j1lfcRRdU3cBKaYK0rN
 8331c9Hk/ObZ66RrS0z8DjYmKmksarRgNgJzqcTnC5g==
X-Gm-Gg: ASbGncs7MbLQzk8RZbKuAOPv2otXkVV11y3ff8hxnLVMly+kSFdvf/t3p908XbWwTRb
 MF8A8MIjtV3TmNJF1U5Hzali36JYV1R3Wr1KHW6hUvPXtmfHX07Ic+uKpwjVwJ7veBPyS1+lxuY
 +XWImI+6Pt008pa+7MPDURTZz/MZrueOq5aMFU8cKC+FYxOD29FKPKgWcia+9SC/p7MNphmfp+D
 CfeMqfl
X-Google-Smtp-Source: AGHT+IEp/u9jz/CRYGKLjPmINp6o0ys2gM7FwzgTUW/mzcGiUnQG3HrgCFqtE9kjUu1ABsepWPtwvfCIBZs8VMP4d7M=
X-Received: by 2002:a05:690c:6f12:b0:748:c4bd:79d4 with SMTP id
 00721157ae682-748c4bd86aemr61422907b3.49.1758548461257; Mon, 22 Sep 2025
 06:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250919115017.1536203-1-berrange@redhat.com>
 <20250919115017.1536203-14-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-14-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Sep 2025 14:40:49 +0100
X-Gm-Features: AS18NWBPHi0p-88LAWisMK5OfADog8hsob1tRcUq6H4a_xuc4sG7D62phb8THng
Message-ID: <CAFEAcA8cdGC7j1WxsuZ4K0yR2i7t8=Zq0gDq6wczoBSOO_vifw@mail.gmail.com>
Subject: Re: [PULL 13/16] treewide: use qemu_set_blocking instead of
 g_unix_set_fd_nonblocking
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, 
 Fam Zheng <fam@euphon.net>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Weil <sw@weilnetz.de>, 
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Bandan Das <bsd@redhat.com>, Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 19 Sept 2025 at 12:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> Instead of open-coded g_unix_set_fd_nonblocking() calls, use
> QEMU wrapper qemu_set_blocking().
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> [DB: fix missing closing ) in tap-bsd.c, remove now unused GError var]
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

> index fe4be6be17..e83e6c6ee9 100644
> --- a/hw/misc/ivshmem-flat.c
> +++ b/hw/misc/ivshmem-flat.c
> @@ -154,7 +154,8 @@ static void ivshmem_flat_add_vector(IvshmemFTState *s=
, IvshmemPeer *peer,
>       * peer.
>       */
>      peer->vector[peer->vector_counter].id =3D peer->vector_counter;
> -    g_unix_set_fd_nonblocking(vector_fd, true, NULL);
> +    /* WARNING: qemu_socket_set_nonblock() return code ignored */
> +    qemu_set_blocking(vector_fd, false, &error_warn);
>      event_notifier_init_fd(&peer->vector[peer->vector_counter].event_not=
ifier,
>                             vector_fd);

What is this WARNING comment intended to mean? Is it a
TODO/bug ?

(Coverity has just flagged this up (CID 1630446) for
failing to check the return value from qemu_set_blocking().)

thanks
-- PMM

