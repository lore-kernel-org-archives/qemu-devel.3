Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D31FEFB7EE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 02:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuial-0001BW-IT; Mon, 23 Feb 2026 21:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vuiaj-0001B0-KZ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 21:56:05 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vuiai-0008NR-5E
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 21:56:05 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65c0e2cbde1so8617718a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 18:56:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771901762; cv=none;
 d=google.com; s=arc-20240605;
 b=GcZiITV1o7XR7gOSAC0mxnh/0zHxXN4Wsum9RMRVfe68F7kkeBXGElYgXlpJLVjyQD
 QbkT6SltAuOXhCVxxX6SV+cpN3KogWZJDGvmf/B5AtPS11NIwHKXHeTqxrhESKZImFKr
 2hl7YAQV1ubCpKU/a6EoI6ITZ8aOXc0z81BA4OhfEBC9qYA8NRPM3OIoUlllgPe3gRJd
 JMxHxtK1JRg45gz0V7TtKXsBVLsXKZoyD88VI89obx74Ns5xZBa4Z78fSLSCj3tkdZlX
 Q7DsX3WErFjuDsLfQtbw/lIm+AkCWqzz13f9bz/n6UcEMIgkFbZfXaT8IchaLDnG9tdP
 nv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rA6niDEjlaNqbSF1j0rSPepcH1/Y/R0sRkLQbUT3Ewc=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=aw8gRpN0O1MyfV3LKdwCcbSXzDDvEddhn5uCuBcpFjOWkXxWPuv2BGzTkYgg8pcZfO
 QxN78azGypoIr5XRc40rvbfaxBHFoPxCNbsjdO2e+/b3jwo3qwM+wJJnZBVzU00qylYO
 z8BFqur5hB48lo6cZf/6sgMaZMJXJxM7VOGn4uUMitf9KPWfG00NlPxlJgN9UTAkZQ7x
 8wCCydcBvniOdS9dP7XNixHGE/Y5AVgqMW0GnJQ8ComfhpgKUUNsi/Xhza+8pQgCQ0kA
 WEW2JU2R7Gm4PJrjO9CieW/Z0SvhxEMVouCAXhzGdlDLNmsOPl5hSRup2lObTUhTQLjT
 pwDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771901762; x=1772506562; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rA6niDEjlaNqbSF1j0rSPepcH1/Y/R0sRkLQbUT3Ewc=;
 b=dgT+B1txjAJ0pRSl2YN9GU7CO7QblXZwDFmntf3u43mTWedEjWT3hYKFLqbw/BKY0V
 e/DIt8YOflo0wxGAbgCSrPQ+4D7/UuG2uV3/eHhvUUtOZk305bNfA5yNJV6AsIH18PTY
 /bAF3qG3HMjPmhD9yZiBBgc5jDCTpP/iXHfOEJg9abdKqf2GvGq9OlxbZayASp/pVq4N
 ho5fO9JqhDznXyozHab3zqkuweSBzmnmjDGODNOcCuNFIEtcBgOjtbJvpnGKXU8so2fV
 1hEZ+/exRSJDj9TyZYp/K1+wlpqBn/lrV2mgp2fISRVyPTURViE8m5Rri2oC0Cb6QXee
 5KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771901762; x=1772506562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rA6niDEjlaNqbSF1j0rSPepcH1/Y/R0sRkLQbUT3Ewc=;
 b=f6mHkUWyvqoD4/mUn/+MsAPIOJVH0dwCu5xm9lrsduCccsCF4BEFw5k7ZlhaqDqL2Q
 kQUU4YCgC/no7lmcC1rmphb42/KjdDBCOCnLUOBtYfc+A4zpUV+sTASMVgLJROtsj9hJ
 g9nyUlFr5zLcYFJyH7N53ONmpLjgBJvHwFag3Q2Lc6ZbgrKk22jHxUH2yCYHoma9kV06
 L4QxQQoESUS3/AdO7/i6Is+4x8qJSICWGknGlAJwC1zYBP4kD3dqcin5NI/26DobR1yF
 SB/eu30rKfOTXk0cs5HBDnfyg/1vt53HihaobbF2Gh4nsH1zrZR3PnA3lIIqh4qGwyMl
 Sm2Q==
X-Gm-Message-State: AOJu0YzQ88FZZte6j3T0UcaDLDA77fycDrEhH/OsM14nMliw5fWdZwi2
 0ZEVaaNUmW0yCcLdfR76GxT/Dk3QTsD/99JAPhc4H5QGPNmseF5Cu1KoL4hq+c+B2pHGcPvO+rC
 IO5g7T6X5kx9GbyynkQcDSt7AvpL+LgY=
X-Gm-Gg: ATEYQzzAq3ahYgfsPRUwAhYhiR0zZ4R7+sKKwLEdRIqa7E0GrjbCSO96Rgt1oClF4Jf
 zKlrD6FGJShQO3CZW6k8CZje2OdHYtkpFpcy85R2U2PYfdX5bt1gMcQ1n3vzK/OKdO1/n3TsnTV
 q3a4hfbvwXJpsQgcgl0NVXY8hZsCRJPqNHDFgHUnonaGKxKtA7bqWjgDAxiI/JJ3q6o96XeqvX4
 SWdWyhjRv7O2x0bQcoSsXqvqH1CfXdZMrGldqv93Tr5lMLjp+XFqyyCnrK4KPTeYSdJ46wXyHU8
 YDatJH7z
X-Received: by 2002:a05:6402:13c2:b0:658:b4b3:4258 with SMTP id
 4fb4d7f45d1cf-65ea4f1a768mr6911687a12.17.1771901761846; Mon, 23 Feb 2026
 18:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20260213171622.55629-1-zhangckid@gmail.com>
 <20260213171622.55629-3-zhangckid@gmail.com>
 <20260218205518.GC620422@fedora>
In-Reply-To: <20260218205518.GC620422@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 24 Feb 2026 10:55:25 +0800
X-Gm-Features: AaiRm50dOIPVaoQJDpaf4Oa23rVHB_3XKvaiXbKv-cbc0Ibg_E4u0wuTZaXFR14
Message-ID: <CAK3tnvLh+FZxuWpG8zVS+vs9-9MAbgw=iCcgRC86++OzwroWHA@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] iothread: track virtio-blk devices using IOThread
 reference counting
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52d.google.com
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

On Thu, Feb 19, 2026 at 4:55=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sat, Feb 14, 2026 at 01:16:21AM +0800, Zhang Chen wrote:
> > Future work will extend this ref/unref mechanism to other iothread-capa=
ble
> > devices (e.g. virtio-scsi).
>
> All IOThread users should be tracked so that this mechanism is used
> consistently. Otherwise it will be hard to change the behavior in the
> future: software that runs against multiple QEMU versions won't be able
> to rely on finding certain objects in the list if not all objects are
> added from the beginning.
>

Sure, this patch is a demo to confirm I do understand what you mean.
I will add the "iothread_ref/unref" to all the IOThread users in next versi=
on.

Thanks
Chen

> Stefan

