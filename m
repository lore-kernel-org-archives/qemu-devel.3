Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2183FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDbD-0004ku-It; Tue, 05 May 2026 07:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wKDbC-0004km-6G
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:05:58 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wKDbA-0007r0-Ix
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:05:57 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso6837500eec.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 04:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777979155; cv=none;
 d=google.com; s=arc-20240605;
 b=gywa39OiHR8ue8R30vpeLBDuodnPs2eG+bWtUCQN2tT72TYQhR3jpem/N/okxw77sN
 yAy7NnQAM+08895Nbmy7Jcc9bP4rPAlOtC/iNYQHPz6RYpdxkXR0qn0hZNteoCNrJUpt
 VQPxP4WyUjAOeb8JWa/oAMMehKgtXpwPsgXPQMfSFmYs5iT20it5VUQtQQ4BGQbufj2T
 a3K/8M4+XS6icJmsBfsg9z6fd8rbmXfZGYmk3dZYtMnVKXgt/v10Ye9PggtzUNxQAv1P
 tmwsqsv+B6GPO6NMs9JRNIfEl1vwyN9dufOlye43YVs5dqEID3d7Ls4N7qd1WCP6dDIM
 ej+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bPHWlEIfQSozwzPnaHVKaj1B+K78bWZEzYzNIvC096E=;
 fh=6a/0+Tnmhtf6N05Hbb/MPZiRpazLdtLxrkI7VBoMkkY=;
 b=fWZZCypoYzpi22rwEHC196tp3QSl18OetS+Mr9wlzR+SPdumTN0qqkhErsJdkt1ifv
 9hH+vf75mkDiAoTVOXKAn9EsnTk2Vz+jHLSn7m1K7gUDMDV602zqZWZhfOeUF9EiU5uB
 LGZ9wZbw+sjlOPGLlEHxAQ8HdslgJDFqBOXPExf6RtUYGE7aKfbFykZWIz3zO7O9vzuh
 YHIsm7ZyZXSm7ImFUGRYmXt1rBGD4clRMba2e9Lc4a3YvL74QTkvh+7B2CalFNjwRA2r
 Z5MuF/PcZYwhZpYPcL5sh2PxWb3vU0kzjWShUYlqo0BluD7/zRQcBzgBbaxY850GVdJh
 OX/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777979155; x=1778583955; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPHWlEIfQSozwzPnaHVKaj1B+K78bWZEzYzNIvC096E=;
 b=qGnFgnTPd1X+zF8vLTz+o6pPdD4K+sMD7pyVYQ5cahkr3tz2BIVX+fLCypNPfEeo8Y
 1ARJaSSDYaKb2oW9SMJwxmljDaG6y4GaWpbdWqhKejh14DPlo67TdZypHnyS1CfaCF/0
 Gkblmi0CRGinxKKEO1670IRjNU+vLi6bwxwPGofCAmHtxpFOhURGjK2tM41JdeR/5tmn
 A2HiOkA2C5ouaCcK70yKI2NNLBIqN14K1dCI18iZ/nWkwU4Vv9g/bKwIBK2zxhGxTlG3
 7ydZHY1VzICIdJwSV+IqkGTkyCvVvFShyp6SeJOTrhIY/LHOGMqlkPuDdsZOgkm7Dnze
 XBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777979155; x=1778583955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPHWlEIfQSozwzPnaHVKaj1B+K78bWZEzYzNIvC096E=;
 b=iamxNXMKCFsPqTbltnBuOFF4ZM9HsRbJ98F1a+3+BxvSciW03K/qWpFnxKl/Hsdz1j
 gIDue+piQoZAnMhkqwBGAq4GSoh2ss286xXAFjC1WAT51JlpXV2JTVrAmiLACS5LlST0
 k2gfdsz2wWR8vVg2xDQLdNXe9G4qFt2njY3nQHCDWysT2W3z5FEP0+YOg2b99KfzdUeS
 Cnpx7XPWPhygthe9allH9JSmca9oX/k2FdaPHZoDcKvdl/1i+R2wx5xgLz+wFE9o032X
 rKldLsQY3TKeWP0FgrHhBHk8cKO5ZQ9xcdqZ/vt2z0Nf4YlkOj/TiHZfy214p0wlzTxb
 wZ7w==
X-Gm-Message-State: AOJu0YxrgaxKZLu86i4sRc121Mh5a8A87AJoEV4gCLkr0/UUSkR87RpB
 HKgEprzC7I9lKhj2GvhuSSGhMcZKq+G4o9zyyqOE4a8ppdmfqLVxA9mj+ooqZ+b1FZKG4AeIOSG
 ZRF5KvumT2tlkqPybmt09vNtzitrrgro=
X-Gm-Gg: AeBDietB5sA6X2/MuHZA+/1eGkof7V8D51BxWu3XljvuwyZSC28lqDDDT1vZvpJwfAa
 x6aG5SNbMqMidfPXe5VNy75ED67NHX4jPvdnZIBx3/f1e9bpHQ4k+wGVqG8iwyWN+U35xxSxzLe
 uk5/HMyGSfl+lzW5l8LZLCTbDbZ0ijXi3kG7EZqCgQdPj2d1EnCcAeuiWgQ4Zv6yXd7ltmHQAAS
 jZ0EgkDaRxXiW/v4d52Kimsg+YhsyrrvzIu6KCi19ED8VyNmINOrEAlwZ3Cpb0t0SEhI/kkdC7A
 9nVpOJVaHlvTlbPA
X-Received: by 2002:a05:7300:c618:b0:2ea:4228:ab11 with SMTP id
 5a478bee46e88-2f407852e12mr1112168eec.3.1777979154821; Tue, 05 May 2026
 04:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260505110036.47574-1-munkhuu0825@gmail.com>
In-Reply-To: <20260505110036.47574-1-munkhuu0825@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 5 May 2026 15:05:42 +0400
X-Gm-Features: AVHnY4K-FSSL0aV4StiW_bjHxpCMm9a3LXPY7pm3ID3kQDDPYl6bXB3l2j-Vrog
Message-ID: <CAJ+F1CLXOfy6Wkw7tnxA_-TE8u1f-uNvMrFXkLj2RDFxLWcY0w@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix memory leak in ohci_service_iso_td()
To: munkhuu0825@gmail.com, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1332.google.com
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

+BALATON Zoltan

On Tue, May 5, 2026 at 3:01=E2=80=AFPM <munkhuu0825@gmail.com> wrote:
>
> From: heropd <munkhuu0825@gmail.com>
>
> Fix a memory leak in ohci_service_iso_td() by calling
> usb_packet_cleanup() before freeing USBPacket.
>
> Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/usb/hcd-ohci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 6ed8046fc2..43c49a42ec 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -748,6 +748,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struc=
t ohci_ed *ed)
>      usb_handle_packet(dev, pkt);
>      if (pkt->status =3D=3D USB_RET_ASYNC) {
>          usb_device_flush_ep_queue(dev, ep);
> +        usb_packet_cleanup(pkt);
>          g_free(pkt);
>          return 1;
>      }
> @@ -756,6 +757,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struc=
t ohci_ed *ed)
>      } else {
>          ret =3D pkt->status;
>      }
> +    usb_packet_cleanup(pkt);
>      g_free(pkt);
>
>      trace_usb_ohci_iso_td_so(start_offset, end_offset, start_addr, end_a=
ddr,
> --
> 2.50.1 (Apple Git-155)
>
>


--=20
Marc-Andr=C3=A9 Lureau

