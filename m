Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19461125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MNA-0001PJ-IG; Wed, 11 Mar 2026 12:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1w0MN1-0001MX-7E
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:25:15 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1w0MMz-0002W5-Mz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:25:14 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-509062d829dso614831cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773246310; cv=none;
 d=google.com; s=arc-20240605;
 b=NtZUmybNoDkrJ5kAJziDj+oRsR9bXNNfFeu1r2EAg1aOYRGmSZtS8y5zt9rrUcKfNt
 JCyif6+Cqcgp58Oq4USBw4QyA79aE/hHA5OhtBoLyWAqW0MsKgjon2cMyqwDQU4AZKS+
 H4y6p/oeaAMHqk3EughtdfnYjnJk0ME7MQ75d8SM4p4QQ3E8fUOcBHbVksVCbufddPW1
 ZZYAP3ywz+rbvBRF+CRxf41e02IWFyMe7Sm7/I723oJkFu9wJ75EWGo9gnlDLHmMqNIX
 Swz6Cj78pBLjSEZ93Oyqu2t/JsuSaGqu458YDzxKb3//NfV4CjmtOilTgelLKMHza4Gq
 HZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OLwpQSjv4JvNZva1mkhjTKm0dwhoAis8cK6NdtPDebI=;
 fh=a1k9SM8TH5zGCcSjVSHfv0Sls351MzKkipa1NRErkwY=;
 b=CQIW2BnWtNxG2GJLAG1bR5SNRYMv3HTdnz7BdUdMS1+Zwa8Ghf54R3eiJv5NXn/v7b
 xqTta1yiV7ddNm1MChFsi8qdo6vCCMGpb8XLT2ZGICf6APGXMAiOgNYDaxQ3UYHJiEVL
 Z99aGO/er3iWlWxG7HQEnojpyT6Tk2HxnE2NKz5nFY5gIIfTzeraz4YEucQ3t2NZldX2
 PUb7aHlqw4M4csfWYeCgvTvBN0INt1zgwNx1uE6V+3e6cngEepMlb2Tp1EmXFPaCWtgg
 H6GH8twFQDcguqUBCuX2TbRfIJG3+nrGpsSN5NS1IgH+QZoyFsGcAaYM9BULDvRLZXeu
 P8YA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1773246310; x=1773851110; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLwpQSjv4JvNZva1mkhjTKm0dwhoAis8cK6NdtPDebI=;
 b=vBsppwBR07TgdBHtAEod372k7uzsaHOoVak/QRimHfut/r7C21NkEYoGcqh1bU+jGc
 Ln+fuJSuesnwCEMg+oxl/LLBM5NaG5FR+y8Mb+txLuXg4H//HK6WZCpyfqodM8SVVa6C
 ok2YGnRKZ0VPmSgdx6WSr8/WAQ+NtitPHhYqM1lbiRfHZ06nwCSU1X2HVBxDuI78qZcz
 vO2Ggm25DeDwUMem1JJ/oh92+6BiqMuP45ULjla2ct82+E7DvTHUscIIE6fodPxJOshH
 wvYF7FVY43WX1TkK2xJjrAjAPVtodRdHa93KOrdWgSwzRTu4w9CkupHCpyJ8U6pNgphc
 85fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773246310; x=1773851110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OLwpQSjv4JvNZva1mkhjTKm0dwhoAis8cK6NdtPDebI=;
 b=QxtrhzOM3xJxVazwAgbAiv7Uu7qEhz8FiPx8SVpRvszkbNEglDJqSco7l1KnaHLyC2
 zZndhju+Hiz8EH9hbouo6/LyynJ9IiITuDIGtnLXQzqkRNleByi/nO5BIRs2gxn3wyxJ
 IFiLOJXgjqy0GnUyB6vmvwSu7WiLjPjH9IAtOEKzjDYkOJkzoz6Rl7NqON9OYqj77Ftv
 quHswXjK0zde6HGhzeFm5697kfSgFei+MJ3QCK+VdJv9nwtEN98hrpvWDjj4kJlfM058
 U2ib1kcY7d4ofZtKrcfWgFuycr/B2gWEwBDIqLgAahlapkZC5RksU2j/fKM8BZFfvCjA
 kVDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXINa2LOueSVV+1nsPZr+FMlR58JM5Wu+PPQoEHWJbw6o6lnldnbXCGFoGXps33+1T/hw6IM2VGbQ2Z@nongnu.org
X-Gm-Message-State: AOJu0YwJHAA0qfA1GNRVUXA5rWufh52ikdFOIBxcywStPnOwazKmyrAe
 IADGXINCiIfaPWCY4+Ama2Ueg6bD1/kA8XTab6ZtKdnCKXu8sMA6/wf2gFs2CkxlRUPsDGPohjG
 iOqCdBGh/mBTAMzHtyAMAt94LlkkiAedDZvzIqX7e6BImN3JDzJaiWnV6
X-Gm-Gg: ATEYQzyZj28Fkn6DTHmfT3zTIbn4b9GyPKUqu7l2oYgzPcap1syBhIxotkJW0m7injN
 kTB+odNzW0Y/FMArmg52ycxgkKoN1cWb2rOgui2Jh+fKV8H5CtoIxqxbZHtu1FUkqAcR2cPDdOe
 Tk6uhbUCKFuXhrusdq6ppHzU8HNhzfZZc9Nectb6aMcfgZTXRIvRB8xw5jl3bAmAHEnqr0a2lr3
 R2ApquH28FIiTCL3ldSiieAJ4hFaR3DHXjYJYpqziEd+iYUEvtaBJe/vHgldf7Dg+lLyBGP2TA9
 l53k1U4bN6ugs6qjTGIWFIyvhZrWvPsNZ7qm9DzT9CiA02fqaNstSAdw7/vwi+C8A0+qRRjqZcf
 n8zIzDtzPX56KiPPm+1Y+B4hJ3RGFFVEQ7A==
X-Received: by 2002:a05:622a:1449:b0:509:105c:74a9 with SMTP id
 d75a77b69052e-509382ae1camr16137011cf.18.1773246310077; Wed, 11 Mar 2026
 09:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260311021319.1053774-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311021319.1053774-1-jamin_lin@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 11 Mar 2026 09:24:56 -0700
X-Gm-Features: AaiRm512a0n_we7-xU-YVUlFLTZ_xvmoD_ikbaxUc5Dgq57j8ruQtpvHmnkm6FA
Message-ID: <CA+QoejVienYxGqEC6QHccBupwQ_r6hLrXE276LR3qCVwGD+KjQ@mail.gmail.com>
Subject: Re: [PATCH v1] hw/i3c/dw-i3c: Fix uninitialized data use in short
 transfer
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: Joe Komlodi <komlodi@google.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Nabih Estefan (he/him) |  Software Engineer |   nabihestefan@google.com



On Tue, Mar 10, 2026 at 7:13=E2=80=AFPM Jamin Lin <jamin_lin@aspeedtech.com=
> wrote:
>
> Coverity reports that dw_i3c_short_transfer() may pass an
> uninitialized buffer to dw_i3c_send().
>
> The immediate cause is the use of `data[len] +=3D arg.byte0`, which
> reads from an uninitialized element of the buffer. Replace this with
> a simple assignment.
>
> Additionally, avoid calling dw_i3c_send() when the constructed payload
> length is zero. In that case the transfer has no data phase, so the
> controller can transition to the idle state directly.
>
> This resolves the Coverity UNINIT warning and clarifies the handling
> of zero-length short transfers.
>
> Resolves: Coverity CID 1645555
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>

Thanks!
- Nabih

> ---
>  hw/i3c/dw-i3c.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> index 3d8b95a14c..aa6c27c8de 100644
> --- a/hw/i3c/dw-i3c.c
> +++ b/hw/i3c/dw-i3c.c
> @@ -1211,7 +1211,7 @@ static void dw_i3c_short_transfer(DWI3C *s, DWI3CTr=
ansferCmd cmd,
>           * ignored.
>           */
>          if (cmd.dbp) {
> -            data[len] +=3D arg.byte0;
> +            data[len] =3D arg.byte0;
>              len++;
>          }
>      }
> @@ -1226,10 +1226,16 @@ static void dw_i3c_short_transfer(DWI3C *s, DWI3C=
TransferCmd cmd,
>          len++;
>      }
>
> -    if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {
> -        err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
> +    if (len > 0) {
> +        if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {
> +            err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;
> +        } else {
> +            /* Only go to an idle state on a successful transfer. */
> +            ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
> +                             DW_I3C_TRANSFER_STATE_IDLE);
> +        }
>      } else {
> -        /* Only go to an idle state on a successful transfer. */
> +        /* No payload bytes for this short transfer. */
>          ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
>                           DW_I3C_TRANSFER_STATE_IDLE);
>      }
> --
> 2.43.0

