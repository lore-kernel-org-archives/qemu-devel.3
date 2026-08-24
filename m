Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE29C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPY6-0004Lq-Gw; Mon, 24 Aug 2026 03:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyPY5-0004LR-39
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:56:53 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyPY3-0001YE-EV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:56:52 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8111c0c7561so47670917b3.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 00:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787558210; cv=none;
 d=google.com; s=arc-20260327;
 b=A2I+shxQhPixMx3ffogz3KqurPW9mDxNlwr4eyDpFmPPZxiyPQeTqSbNCwvrb4Tr9V
 j61IaNsSFRPWO/W4i0gBCTyFWW+HvQDNdqNpYLNToR5kR5bt5coyG7u/h6DEAsZ1zNFT
 UOBW26l1/7vXBWUPf/UaOe6qHCR+J860oqibe3SADbBZheL3Bvr/FjyVjE8bEgiEQzrm
 ACXWTHFNFC0l3Fu6kAwmaYoZJ4iQqIR2WiYu/pcZbsuJIO+iTSWDWUOMnnVIbB3BKqB8
 XpsXym0beF0iWJP/hlc7M3ztViqK5zdyodaaFQbZgILcZoQLefVd01zWzrnPnobzuEUJ
 cYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aYm8zi3Fj3E0101I/GcssriuqAjhZpCNpZe/4H/OK88=;
 fh=GvxbGeovy/Gyz4MIWa4ZFOU1/a+8GXdXlh/fnyPxXVs=;
 b=bFHQoKlFm8XAZNdLI1XhPVanLGNDi23TMFQ+mv6QwxaWdNs3hGFpCfuXtmrqua/65r
 rly+2tEuTjuKZSf7WQdEGxNrhB6cJp11MAYYYUVl4/aoJi1atWSnCtg9yV38PB0isp6l
 IUeUmx7GAA9tALG3GDI8Gjusj/WB97LYtR4cpWpcRIfjMvp9OFbQT70IBCoE5aO+Ii8b
 r7GgC9rnS1qPton3LrK28DmUUbd2OV2hddXGSKBKRLSk9DlRKYQlo7pHAPLPqGIVIRWS
 ixfTZBkT90csmVJMcQk/BGVP8CK57R6f++Xpz4GkCIzds88S3AIMxGYPh2rrffY2LwH/
 ehTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787558210; x=1788163010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aYm8zi3Fj3E0101I/GcssriuqAjhZpCNpZe/4H/OK88=;
 b=JnF68+2kony06dIc9mG4+tnA7t5jLSN/12zgApOwVNRq2SM6i9hfU7gnuetGyLX+11
 cwtxfAa3Ws+thjIH5CDD26YNr2HZ22053Swae/W5bdv9r9xIz6HodhXeCbUfaKzXZ0p8
 fkhX9IlIhq/jhjFHkDNlCIO7D/E3dI9/AzkHrAYZ52RpaDLpzTR7PToNkVV4HhmTSJDB
 zyy3oDskWGXqoiR16oZ5T8O5MYkvGtw9Qd1jta+SJyOE2OmFcfGsA4iJgjVWeEk7eA5O
 E4A741uZwGjENEHEdNmKUElSe+UCbfQa8CBY5bKWtsrTrPVtwtvxpmTr1SVINFCS2tT2
 c5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787558210; x=1788163010;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aYm8zi3Fj3E0101I/GcssriuqAjhZpCNpZe/4H/OK88=;
 b=pnfmf0yi1HYh4RKuH1HTA9GRxqpwUvF8b0VMG4QFy+OJ/fzZWtqg9WqtUIZVHXs0kG
 ZAm/NTXyz/SR5QO7oq75+aOVU0Tgy6yxMc74TIaLjplD88HZ5LktPnKFWxYRWV2UC1OI
 xdLYkcjXZFgvWoRXSXLbYHIvowP+C96/Zrrq6maC98y5HqyFhujPHffJO/LWoXNuen5g
 Dp5zIN5miN0+hR4ifpypnfgjj9uzqYZUsJuMnlZUjYpSPvbto+X4PoVtnIhPk1a8y1Tm
 4OH79ZLwixeeLwPFIMAUPVfADaovAqiOBMzR9ISxnF7U2/g5fWGEo/Fr4Aq5VSwGBuWX
 yOpA==
X-Gm-Message-State: AFuF++nUyDaeYbOVb4xh8sqSEp68RSPqsqFu6TPxQ1qf5E6X7A2rVzql
 8axvUnrlz03hErHDP8qXQ6FIPmMqz9JhPw4H5rUGSO8kzQtGJr27bZoUGV6aemum9AYw4ruqDZ9
 lhwg8doqIJRNQDJjbBmnUbktKvDrq/dI=
X-Gm-Gg: AR+sD12xoLUtQzouZZyg4Bjcd6AxLj5UN150TH5zq8qc7kBce5tR9uWDMdMaIJGXCnK
 ISCd9i9o/gWtLBGiNkGC791pb3G3JyQkF95+z4FnC06StwVtYa09djtfvbzowHt7zGs/x7n46+9
 InlmCWj5xLYLDWQj7wnzCMgq1qKljug6d8b3GX9/f8DubZvy0rpduLeDFAdGTwYGwmZnc2THPLN
 ryHeONCdkhm93T8MH7DhvcVOKptz4YHbkPhNkKgW14Kb699XH32GNZhkjLX2mYK5IBsDaJ2jQO3
 Cv0MvQHC/i0ham1sjj1SacMmOmR9DxbWZeYGqeniIJlG/Ll3lStxaYoGsYAuR1M/stg7ES+SS1D
 z
X-Received: by 2002:a05:690c:6d8b:b0:820:1014:526a with SMTP id
 00721157ae682-849f5fedbacmr98768627b3.29.1787558209911; Mon, 24 Aug 2026
 00:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260823071529.16389-1-christian@quante.one>
In-Reply-To: <20260823071529.16389-1-christian@quante.one>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 24 Aug 2026 11:56:36 +0400
X-Gm-Features: AcwNN1XbzY3LHDxpz0X_zDqIgjF4MQ2bOYdOeFHTrfRH9O9m4NjTTSgsX__CjFc
Message-ID: <CAJ+F1C+ZvQ4Jmm9UpnJH5=UQQL+SSGB0ecOSDaYCpgOP9wR13A@mail.gmail.com>
Subject: Re: [PATCH] hw/input/ps2: answer unknown mouse commands with a resend
To: Christian Quante <christian@quante.one>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

Hi

On Sun, Aug 23, 2026 at 11:17=E2=80=AFAM Christian Quante <christian@quante=
.one> wrote:
>
> ps2_write_mouse() ends its command switch with a bare "default: break;",
> so an unknown command draws no reply at all. A real PS/2 device answers
> every byte it is given -- ACK (0xFA) when it understood one, resend
> (0xFE) when it did not -- and a guest that gets nothing back is left
> waiting out its reply timeout. The keyboard path in the same file has
> always answered unknown commands with KBD_REPLY_RESEND.
>
> Two guests were measured on this.
>
> OS/2 probes the mouse with the vendor command 0xBB, which QEMU does not
> implement, and then polls the status port until its own timeout runs
> out. On a Warp 3 guest that wait costs about 25 ms of every boot under
> TCG, and 2.1 s under KVM, where each of those polls leaves the guest.
> With this patch the wait ends on the first read: the guest takes the
> same error path an unexpected reply would, and does not retry.
>
> Linux probes for a TrackPoint with 0xE1 and fails the same way. Timing
> the psmouse detection from a mark written to /dev/kmsg to the kernel's
> "input:" line, three boots each of a 6.18.35 kernel under TCG:
> 426.7/428.8/441.6 ms without this patch, 21.4/21.6/21.2 ms with it. The
> mouse is detected identically either way; libps2 caps its retries at
> two attempts and ends in the same -EPROTO the timeout produced.
>
> The specification's second stage -- 0xFC (Error) when the byte after a
> rejected one is invalid as well -- is deliberately left out. It would
> need state that has to survive migration, no guest is known to test for
> it, and the keyboard path has answered unknown commands with a bare
> resend for twenty years.
>
> Signed-off-by: Christian Quante <christian@quante.one>
> ---
>  hw/input/ps2.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index 5516eb262d..1e8c6d983a 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -73,6 +73,7 @@
>  #define AUX_SET_DEFAULT     0xF6
>  #define AUX_RESET           0xFF    /* Reset aux device */
>  #define AUX_ACK             0xFA    /* Command byte ACK. */
> +#define AUX_RESEND          0xFE    /* Command NACK, send the cmd again =
*/
>
>  #define MOUSE_STATUS_REMOTE     0x40
>  #define MOUSE_STATUS_ENABLED    0x20
> @@ -955,6 +956,13 @@ void ps2_write_mouse(PS2MouseState *s, int val)
>                  s->mouse_type);
>              break;
>          default:
> +            /*
> +             * A PS/2 device answers every command it is given; an unkno=
wn
> +             * one draws a resend. Staying silent leaves the guest waiti=
ng
> +             * out its reply timeout. The keyboard path above answers
> +             * unknown commands with KBD_REPLY_RESEND.
> +             */
> +            ps2_queue(ps2, AUX_RESEND);
>              break;

lgtm,

maybe add ?
        case AUX_RESEND:
            /* Resending the last packet is not implemented. */
            break;

