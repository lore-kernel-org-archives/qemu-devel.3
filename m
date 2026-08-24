Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596B4C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRBd-0003TY-Cm; Mon, 24 Aug 2026 05:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyRBb-0003TI-FN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:41:47 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyRBZ-0005FE-Su
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:41:47 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso1873995a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787564504; cv=none;
 d=google.com; s=arc-20260327;
 b=GPFCTw+vPF/Kw4ldqDX7wjajAo+MS3VDmp68cVasgEvr86MWlK8UDd37jGDBH1oc12
 4zHWAW8eOF5UDKPW0LTm8SHIRM/gz1JPU+kTwEPikhC30hU/xGsq54+YpIgnckhZW1W6
 572NKSTdVNvpwRXZ7uH34NwQh7db+gX65Tye7vDz+vcM7cDaDFACp8SuQF1sHttM0zQf
 Cd1UKiQOFsHqLtSpRW7lGwZTpAK+70Z2ToHFNVBSu/Ol3EjodsSDPmEqpLfr/rX/mH+Y
 WSpuKzwToF0m7mKlq9R7ovhQ35J2g0g2xCos8UfzDtrzQuJtxPt9cjYVGiuEU6GiMrtm
 pSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YtZX0JwmBCnVXw0SCRl/wsXaT4RLeWIj/mu7pjAWmew=;
 fh=GvxbGeovy/Gyz4MIWa4ZFOU1/a+8GXdXlh/fnyPxXVs=;
 b=WGEvoeHHUUNJXNNP+3A13Kg8TO/D5J9WPWV94ERJELu+ouGGT6ZkIL/wTc17+XzLRa
 sTwkMWCyEkSB4imd8b+w6YJLBkoyEx0yGGiABcchZrjsRbhJguOSn/8ZFaQ9JLdjR713
 QxhTrkjZ4zS7w7gjK+FArjepwBd59R53MaVH0Y1HXXQY1CThe6edFXOtX96Pmu3G0T5N
 qgd6T0gCsVMFEO6ZEMe1lAjhFTGmx/uw3WkV3fNZ7T36RDWYoZM/ooDXnRgh/dzGqg2l
 rgDbQOVNgjJ/9ExEncVU7lbIFc63l6gUU41jJVQ4bdqDlZ77yBdcprTTX6ZdiZgv6qlA
 WpXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787564504; x=1788169304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YtZX0JwmBCnVXw0SCRl/wsXaT4RLeWIj/mu7pjAWmew=;
 b=Fl02oYWJl6VyFnbXTyS3A7oaGD+/j1eiJxLBV90p7PxX51/WIMpGwx0lCOPmLSqoqq
 iNvWYc9PxNg59OM0p+xlWBzPQm9lub6DjFDxqqaeHHfaJ+vPwZgBnhqgQhM9wQ7zDPQB
 3RCrkYZPtb68PXq60ltP9eceDDZfMesqk/fsNmNaEfRJymFxhaqUV+bVzuif45y4WZub
 QB3JKWLvhHVC4BTxjF2Y44HJoIO4VR6d8oDIneTAiH3PRUuRw1sw4CmEBP+xGAlfWLPU
 zqPEMsqjejQm893bW+2p9WgiefjdSeY+4y4lpbOtyXZzv1xnNTRdLWj08PkWgIAwTX1g
 6txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787564504; x=1788169304;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YtZX0JwmBCnVXw0SCRl/wsXaT4RLeWIj/mu7pjAWmew=;
 b=lbW6Ez3T1kKnpUAcSa8d0W2S3x0QoZctBjlNoaojT6wxXwElIfRxBY7cAFQG8BX2s6
 A43mq10mBQbIMNwyk36oOqtBCnUu7/8UZetU0kOyHUcYoTWIUtdIL4s61S1yAtRDTtDN
 e0chzFIMYvy4cawxvxk/awsDsRy2oUMuucDaPYu/PH5fs6qFkeSX0ckoiuBwzeTU646S
 cRlCmef+s7Q6lgRpu7lb23IX5D4YOER5k2G7WDBNGPSsKJ6ci+6kqfblJRBbx8Qszx3H
 +oE+JlGOAxx9ssnbUllzy4md+Qjbg4Rtztm2y6x0DR64dxV7hh04dcw1ooSjZLPvAhPr
 20hA==
X-Gm-Message-State: AFuF++k3EArb9NRoZlCtQJMSG7N47o0KB67RvszwKyJ/N6pevyMi9NXJ
 TxHQAbkUSVSNOcEMKlsY5DsYWIqdMP7HfCRuDRhMxtc4ssb42tiVvrb2eFIG++5BMId8NncDHcg
 fV3JM9nksUB5uezBy4QvOipnPjNq6dyU=
X-Gm-Gg: AR+sD12sZMRp2dScRAgqlk+kWfbwyPZgUTjxi9aCsOcSj9BU4GI/XKgk21Y+k+YKHiy
 EzurCMZ8qY8WGKap7DtC3Lc5GkJk90fFsPUfFtU0dxtISWmEi11kw/VFKVVs4PaZ1+2JmC3lTCS
 UbiBnwwnq0ZmNJB8yCjKOnBRxOF1LQ+jt053WTYu6U5eMHo1Ww+qEkbvdzv2ztog61iuo8XyI48
 zpM1jtN3U0IudSYG4ZJbGPUlkQYDt6rnmKCRPeRo914z89Zzx16dGMYgKUaC/8HTnpcHzp8EPwr
 wF8CvxMrGKbiWSTpAdyc8YLTEIfHnGdFDA6lBjpRAkJHEF6EUFjcjENlmRd6NgURaem69CNXlLW
 j
X-Received: by 2002:a05:6a21:1191:b0:3cd:2e96:5929 with SMTP id
 adf61e73a8af0-3cd30156961mr50888095637.14.1787564503742; Mon, 24 Aug 2026
 02:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260823071529.16389-1-christian@quante.one>
In-Reply-To: <20260823071529.16389-1-christian@quante.one>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 24 Aug 2026 13:41:31 +0400
X-Gm-Features: AcwNN1VR0RKmskPVrxxJydo1IDQNC19fbJpwpW0QJlv5hTfL_bn7L12H2EVqEXA
Message-ID: <CAJ+F1CJT2mctop6RtLYSg5Pb4DO6+3FE3vK6w=CqMuYo9Gh+6Q@mail.gmail.com>
Subject: Re: [PATCH] hw/input/ps2: answer unknown mouse commands with a resend
To: Christian Quante <christian@quante.one>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
>          }
>          break;
> --
> 2.53.0
>
>

