Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1525C531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbrh-00058o-Jr; Sat, 25 Jul 2026 08:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wnbra-000585-H7
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:52:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wnbrU-0004sZ-Ka
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:52:19 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ce87c7e3bbso14703745ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 05:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784983934; cv=none;
 d=google.com; s=arc-20260327;
 b=iOdRZmhfo40bOxdyQ1U3HGXZ+4RmcbaAiKTRumDT3X94/bMFEIeQ6fDK2R/j0VSxb2
 SwCTFj9Q20FHWPyLFTVk70SfFAMmmqyfSNU5ZvuWzkjzzxDUVYQ4ByyZFUf2dQmhOcLj
 xHsff44Dr/77NjxPUNjDxHN3+Pa6deHLj4LamPSP2qnlVUBz0/l5Omx/DJXqBL+fZmP5
 o1q4X2jrwd9AhMeqkyXgADcFCV3AQ6rUEb4TYeVmJNUmWV2omLlS4Y6ybBfsv5CwdQBy
 ugRudpnF2/7GJ6o/LYUgumt4IXFFHNkSMXDW9GZcvSuELtLu4AXVYOraIwjz6uW7EBX5
 gMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zRNjUib7c2a6hq6rs2SK9nrbYkRKK7rhN44oQNQubgc=;
 fh=KnxVq+/dNMGR5XtbHr3cm7WMCtMcRbEU6z8PkW8LG2I=;
 b=GgbimTe8ggjQ7jFRQglG0QxHN+DoiYcZzix9mVg3P8NZqWRnLq6OMYH34SbyyfSHu9
 HbWV6+Yfkc029waoDSiUxlf/wjI/kZ9fIB175wnkEL0skbsxTnzHRec7ORxdsaqw6Mw+
 W2nPx1gxuaEndnE4ND9OGwEU+1P1TOaM/iEiky02J/MJ7LtFlo1OMTo8U+b2zTiqLbr5
 lQcEWmMYmrOxmKUWQOmAaieZ1BjIwZH+4z9FDdXBvWYbHsE5lZdOSPKzDSrVX0+GY9Ei
 veGXye5PqSeayK1DYY92pLHXJ+kjnbpK0eapL51AjmwW+yyXAYAc+WmU15SYab5TtXyS
 rnqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784983934; x=1785588734; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zRNjUib7c2a6hq6rs2SK9nrbYkRKK7rhN44oQNQubgc=;
 b=leBRJdyZZGKCmKWuvwmFhWQJiXWWSca6HB0WjWrl+/DevrEZylfuZ81ydDoPPG83ZZ
 9r8fcgl1HUwiiuTcAibgW3LDvQhugWavxYQQnlqZ2TxouDep3Vv0EwbxWihnkdD8w/KK
 P8KYR0lwcgLj76wu52gT5H34/NOZKPwBHRxLa8+Whem9N+sQVrPYIssl2L/eFt+eSYTI
 WXAy9mcMTZ9vmvj9NE5pxRtJt/RZCCL+Z1EPlEsIEvSVFoBj1E1EMO5l1jHy9VkN1QyG
 /MENavtOjEIN5d95+lRhzEIgAClHt0fDgnORF0KigZEe6G8/7fQYCbY0c3KyO6Q4m5TW
 gkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784983934; x=1785588734;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zRNjUib7c2a6hq6rs2SK9nrbYkRKK7rhN44oQNQubgc=;
 b=H6tWWf5SoV+L+uPTlGu96QrLP1rbQa5nt/wBXrQ6E0RPBojTrvN4oP3Wjj6wXzVsEg
 3RwDrQ5FdRscF8k/9eL5UrJ8H4iN8CqRsXg3swXmhjgfptczWvJ7lI+XxBHUMXCIMOvO
 tAHkHpELzLu7nIgHRgd224c9rVrERmbVdUjJDqYKeCIP7x/efQvgqbu0TZrl2Qb/DPff
 2W4eBQK1IwO76yMLlGDPfKZxDUR6l/6lRkOG9jk5EULZeWofazCJVi6Y6wdXS6kU0Z7R
 qWrSGpfozfVYxMEasdLFWieKkA6/cuyHAfJHUsBg+UkNBGlyG9JmI/obe2aKh4dBfYAI
 8TSQ==
X-Gm-Message-State: AOJu0YxeYAJbiSJis3AhNRQxKUNHAwWfq4v6XKwtkxlBP7fbjXM7Bu5c
 MpP9vI3oRqMaiGaS/ETdA6qcK6ieiJTmdX+oMOQW3BBxe9aNKpK7kOptK/TMJJ2sX6N7Y5ydBS3
 tW2aJo4uQShrOmrgvB7iM4/TTeCx+UEM=
X-Gm-Gg: AR+sD118daodulJ3mMP5bUi0RXBaidyUgnfrECOVf652BnZXRPSefFjriKtChw5xgoX
 fUMJuBtSgaypWBlLcuxQzEOTlrReLdZUf8kx4jo6+ZtLgNGo5l0JB66v/H4c+HYe/6a9+E8+Da4
 7A+dA3rJhenYfouQHNMN6gMfpPPjK3cNyla/EGGYNGsBY8qjEXU8gxk1QlgjJ6VNqLrdWZuCcir
 Uu9xJHMO8+/X61qwafXH+fVxllsKzTWBxfgtafs56APatHZcFdQi8Jv8oUMH8Sy4GljHhRW+5Pl
 gHv7D5rdrNkIL+7DBA==
X-Received: by 2002:a17:903:46c3:b0:2cf:bfbb:61e2 with SMTP id
 d9443c01a7336-2cfde8778b0mr19642485ad.39.1784983933682; Sat, 25 Jul 2026
 05:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260725-blob-v1-1-f643fbd76398@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-blob-v1-1-f643fbd76398@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 25 Jul 2026 16:51:59 +0400
X-Gm-Features: AUfX_mw4XwgFeRKsL8gAocp0u8J-CO1yybH-Syf_oLKLHypE9-MtPodgVbAwLU4
Message-ID: <CAJ+F1CLHMXaStvi67ruFKJ74bELf1ir5hCwS23S+5f+EDLMAEQ@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: Reject non-migratable large blobs
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x629.google.com
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

Hi

On Sat, Jul 25, 2026 at 11:14=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> The blob size is encoded as a 64-bit integer in the virtio protocol, but
> it is encoded as a 32-bit integer in the migration stream, and
> a large blob whose size cannot be expressed in a 32-bit integer will
> be corrupted after migration. Deny creating such large blobs.
>
> Fixes: 10b9ddbc83b9 ("Revert "virtio-gpu: block migration of VMs with blo=
b=3Dtrue"")

also
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")

Damn, my bad.. I wish C didn't silently accept this...

It may be worth adding a TODO for the v2 version.

> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  hw/display/virtio-gpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 718ba3039290..a5aa37aebd0e 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -352,6 +352,14 @@ static void virtio_gpu_resource_create_blob(VirtIOGP=
U *g,
>          return;
>      }
>
> +    if (cblob.size > UINT32_MAX) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: blob too large (%" PRIu64 "> %" PRIu32 ")\n",
> +                      __func__, cblob.size, UINT32_MAX);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
> +
>      if (virtio_gpu_find_resource(g, cblob.resource_id)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n=
",
>                        __func__, cblob.resource_id);
>
> ---
> base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
> change-id: 20260725-blob-8a6a1a85601a
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

