Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C67BCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkSU-0007Q8-IU; Tue, 12 May 2026 06:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wMkSQ-0007Mt-AL
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:35:23 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wMkSO-00081t-4v
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:35:21 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso7148082eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778582117; cv=none;
 d=google.com; s=arc-20240605;
 b=lv7LNcszxE55u/a5layhcm01GViVWo376QRNE1Nz6zMFoO48jrv1n8JCOg2fk7/+WO
 KcnzwS2SoaVUaXHfL1Iu3+6Wt0cLgLL7RuOonSA7UeQPVMSQTjvUwi3klGyC8T7DGE4p
 4t8hi1PUFFsJOn/WaIMmb0G1K6hhjf4Tp6khjpWaZrBsWJtWjnCVOnYreavO0WnVbUM9
 dblPTmvHDFJyq+iyNQMVYTXhqxiEVApLUelfLXRB1Vdug6qFYVnIAW/HnmtONlsE/bEd
 z7XbYWJoDTglAECTlKMdTjsySVFE+yFx5jbppT7CqMBb9qPSXZFM9aZ8l7pbnbLYW1Gr
 tvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1jSO5sUdtbhpGfeikIbf6FOp9bfR3ui7oOo/GbtAWZw=;
 fh=uGvLNvSDeW2j9plmhwgtPGPeDjgXdPgNgOS3dEsn9S4=;
 b=iob1BUZr9NWF+Ph0W0bvZNUNEBHjY4yZPnVX2xWOPj40dgD6Dy8Cwyb2a78LExiY6c
 WOc5HkoutVmok2pkJT4fxeIAOKr/ru+r7LBbj5KNyHp15/2gYhOKLtC1bJVmhhc7HdTf
 gVilWhszItBHYkVYLDosyzTp0z0SwqF4JbwosEnp92OL4EBcuY9eH3Nus1TrOl7V4ysl
 4eS1hIdIcqFxYKfOs4Yk6wZ1pvAKSTjUS5JuiAh/81lwNhJvLbgBIgs59RVu1Z8OwGuP
 tRNHSVgkVLwAxhbX+F2VcbwwwqdRiFnBWk/6Elp5CedfF/6eGvzYqfn4Z9PnYlBKVBi2
 jTPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778582117; x=1779186917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jSO5sUdtbhpGfeikIbf6FOp9bfR3ui7oOo/GbtAWZw=;
 b=mdrNSNA+qVC5pOM1yyu/puVnTe7uHhL0OO/tDkve7+3U8HktSmzFHoVnh19R1VEmp/
 XstbTYH+atSFonchqrhm0thyC2U+QxH4WG132o0KMNW4fscdpO//cvGINJQL+jxGijB+
 VaB2u2bS0NUV1bCRKdmgpYZvUewaiaElTfH9emOVJjVVycvtkDITRcV7osKJ+213j0tj
 F17XYoaKM229xJtRdvPkfv7vj4hzhl7dN4he1WIXOtkltU1wJRjPyu5iCy/5FVuNwQS9
 M/idv5bRlwoIkeX3uCKmu6CxND3wi0SBK2T8XcuDBmgs2P2Y6Bd+Qil/cXNEe/gcBN3L
 Izaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778582117; x=1779186917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1jSO5sUdtbhpGfeikIbf6FOp9bfR3ui7oOo/GbtAWZw=;
 b=bpibzqJOqntRG5HFWMb8DWB8SnbhzkiHqGcDLWCYMsbDau9AQtUQtdeioVvpw27X6+
 pEKIjg6WfhXlxaoS0amhdWLWJelUyuiYqS1AnbKr+SHJqczGpw0LltV9uJXplu3dS8pD
 ujL1nbjOeTfbvbhiC/xNWGTSWh+1KpKbYHHgq6FloHPMpaSHCOVYESRab69dOQjveHOf
 rSzOJkbcOsnUgbo+dbBmnIRU7c/SEGQgjTPTp5EqSrL6Pn41Bz004etnyeXsTjek2udI
 mP7YGKOcVca9ipgYLoPsNLR+ZQ6OZRz4Jn/OP8NrWr6iFjAjdTE111HZjuoTL8O5D7R6
 2Feg==
X-Gm-Message-State: AOJu0YzP1/x95s+Xi/lfLqrB8rQyojZcDrfxH2/D1JzQqP48e8qIuAAv
 8WkJVBOr+tqMvmOJDtgBkVDIXI3oyvutU1jpm3hFx7+CFU6HsetT3mTsj487f020BcGnwHLyRbV
 /kE2/yvwfbqBSfXeNMOs/J+xXUexOQ4w=
X-Gm-Gg: Acq92OGr0ahftCfEgdqwB8FAybt2Pfezh3l7nlWVvY+ZWGBpxqQETlM9D+yErp5sS7n
 y7YLXt7YbksV82IkBtRChTekAUJlKG2tBWMYmREczccvkUNH7dZD7S3Fs5we8Gaa7mBwcYqV2gj
 JGOetCfbJHrS+otNrRA2diwLTG9opayvJ45RcHr/HUunwC4cDoD/ayXP+sPuKLFj5bsBZ1OzWWg
 IGk1vilc8EdqAbOjOGZQNppFlY/frUv4vOQpurhadQkrpDyCqXsNB+taJb8q1NTKUdyoVKaKD97
 BcDZaHTimUcDImQMBDup1A7VZeha1MQVZ1VckEw=
X-Received: by 2002:a05:693c:2c01:b0:2de:c5ca:c1e8 with SMTP id
 5a478bee46e88-2f54d696d50mr13406287eec.4.1778582116981; Tue, 12 May 2026
 03:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260512095543.459949-1-berrange@redhat.com>
In-Reply-To: <20260512095543.459949-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 12 May 2026 14:35:04 +0400
X-Gm-Features: AVHnY4Iazosim9Buv204B5tL5Q1XwSZWI7_Bl7DxtHvh3V8wQQsMP1F2oJDr1Zw
Message-ID: <CAJ+F1CJcoOegJ6xyCztHKH31y7hnEXKE2b8r=GZi3cz7P8_mGg@mail.gmail.com>
Subject: Re: [PATCH] ui: fix validation of VNC extended clipboard data length
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Feifan Qian <bea1e@proton.me>, 
 Heechan Kang <gganji11@naver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1332.google.com
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

On Tue, May 12, 2026 at 1:57=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> From: Heechan Kang <gganji11@naver.com>
>
> QEMU's VNC extended clipboard handler inflates a client-controlled
> compressed clipboard payload. The code checks the declared text size
> against the total inflated buffer size:
>
>     if (tsize < size)
>
> but then copies from:
>
>     tbuf =3D buf + 4;
>     qemu_clipboard_set_data(..., tsize, tbuf, true);
>
> The correct bound is the remaining data length after the 4-byte length
> field, not the total inflated buffer length.
>
> As a result, a VNC client can make QEMU copy up to 3 bytes past the end
> of the inflated heap buffer. With a second VNC client, those copied
> bytes are observable through the normal VNC extended clipboard PROVIDE
> path.
>
> Fixes: CVE-2026-8343
> Reported-by: Heechan Kang <gganji11@naver.com>
> Reported-by: Feifan Qian <bea1e@proton.me>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Heechan Kang <gganji11@naver.com>
> [DB: added #include and 'return' statements]
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vnc-clipboard.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
> index 124b6fbd9c..fa05d86f42 100644
> --- a/ui/vnc-clipboard.c
> +++ b/ui/vnc-clipboard.c
> @@ -23,6 +23,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "vnc.h"
>  #include "vnc-jobs.h"
>
> @@ -282,10 +283,16 @@ void vnc_client_cut_text_ext(VncState *vs, int32_t =
len, uint32_t flags, uint8_t
>              buf && size >=3D 4) {
>              uint32_t tsize =3D read_u32(buf, 0);
>              uint8_t *tbuf =3D buf + 4;
> -            if (tsize < size) {
> +            if (tsize <=3D size - 4) {
>                  qemu_clipboard_set_data(&vs->cbpeer, vs->cbinfo,
>                                          QEMU_CLIPBOARD_TYPE_TEXT,
>                                          tsize, tbuf, true);
> +            } else {
> +                error_report("vnc: malformed extended clipboard payload =
"
> +                             "with text length %u exceeding available %u=
",
> +                             tsize, size - 4);
> +                vnc_client_error(vs);
> +                return;
>              }
>          }
>      }
> --
> 2.54.0
>
>

