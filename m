Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FD6CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNmE-0007au-Mx; Mon, 11 May 2026 06:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wMNm5-0007Y0-45
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wMNlz-0007gT-De
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778494921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5oVGco+dKkNRiSYKK5kWhC/Al9pg32rX5NM/6TRe1Q=;
 b=WglZyAS2KGpcuxup/uPr5zMPV82kntdahYwtOWYFfAl3Z8xbTOxXjfKRcviO+bvwfs6yXk
 bDHQJT1BfiN0wZ25GAfwjlF12nP3XTmdt5AOpl8HZQhMVgp2s6u4RpRd7YNNSjIXBeGXlK
 UyHQplZGTJ+HOP7lTU98Spg9BsstMtY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-EilqyQLjP3qKdHX7aMqLQA-1; Mon, 11 May 2026 03:13:37 -0400
X-MC-Unique: EilqyQLjP3qKdHX7aMqLQA-1
X-Mimecast-MFC-AGG-ID: EilqyQLjP3qKdHX7aMqLQA_1778483617
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b49424ad88so103449686d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 00:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778483617; cv=none;
 d=google.com; s=arc-20240605;
 b=BFiREdaoMFiXSedDWQgj7qSGVadOq5JcNBURc7GCwvvCqukF4Gxj19m2PlLhQyyVV/
 B7DxihEm4gtCg3Lp1hL5aHdtcJHC1vhSvYafdMwTmR8i0JHjQVVdl0qDi0fLYBaOYk+I
 0pmmI8+xUUouAgE+eG10dchali5cImUM1YL7eQc/9Eko5oP0lgqdqceFLmdMNWi5im7n
 xV2PnVHLjg5fAzBCyYO/XzsjLHQ8r8dpZtlhyokc83Le1ADf0D6BFNiPlNx25DPBK2RD
 WVLUZMkPBk0twjP3AVPboIbgvjZzmIFZhXDSQpFPaL+8snYccfHFO5PiEjh1HHe9kln3
 tnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r5oVGco+dKkNRiSYKK5kWhC/Al9pg32rX5NM/6TRe1Q=;
 fh=OZ/WR0l9E9MfZAg6jxsqeIscAntVYA7+bI7RjwrcHDo=;
 b=go57onoz3Nz8kPODCFKD8N39SQBRDjLspCVoWkdF4Xf+pvjKS3PCSSyyE04E9Ykh4u
 t0/bREuSgsOiWj7ENt2QIo2vKFGgYnt+lDDhQEmdTTYiMydrtXpB29NNnjjmTDrQcehP
 hzPyC5u9ueaWOKQm64cDrIk9f7uQqZ3Lok7QJccgvz9JjgTCRMsMWwsQHvyZvTRKa9hO
 ZkAemjjQvfpxOGW4iBgMD0XSMEkMThEUGnmhq1yprChmM6zDEFhO3kBDHL/ebIqLMi+Q
 9lT64T+cM+bKNh+EJoKDjJAPCA+BVOyDT3TX39leC+yBRfs6gD/4jHBLTTosHF/sUmGu
 5sJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778483617; x=1779088417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5oVGco+dKkNRiSYKK5kWhC/Al9pg32rX5NM/6TRe1Q=;
 b=hJkyOc/7H7gNomRWwvrptZXlD1q0FrB1vaa059B191haBus7G7LA5TQP6N3XdvjNy0
 wa145DlcEpm1MTMqNfwWW+oR9eX2EPcc2wnj4awcJp7Sp6rmK626VgdM+y+kbbmI6n2E
 xYgPb7vG4hfXTJ2+td7ENuo8BgSVBdy0xrQKWHm0NcRSK2LGfKsLbZ82diS2GsJA7gvs
 qjO0pffsHP5ri3F0f8G8ra36B+A11BeJXDbCpw/NR3+WgomfK7lsU6Ew5FsrHQlPnM1x
 Mx+IAwBdWCLJA4gYgoKKF+KGQjHImajSReZzSONDVPA+CKbvS/xexvlrH6xNtHMf7paY
 aDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778483617; x=1779088417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r5oVGco+dKkNRiSYKK5kWhC/Al9pg32rX5NM/6TRe1Q=;
 b=KSgwqCS2j9+ToYmyty7I956dq3Z0BAXAckUpgTD403kk48eWlYBap6yGgsQdjpexT9
 7SPdfplu8U7wRhJrlx1mrjR7/5IOT7I/h0EeG/jbFZVsm2aIKhKvNL/IZvUDyAB7lYbJ
 fuc5O68I1NAqjUoUA8sSzPazgipBCxKFdZhjLdH+pckBOeB4RUBNfAbv7hGWiPrJfrCq
 jgSbT7XI3ggKrP9G1OFdFT9vpQR595vv/9gsYKXRIYvYoM7u9ohyt5B2W/oLHSz6J2L/
 +z/Y4bbuGmDn3dFnn/oblVe3n1SKL0/GzB6GYJZZsXU3bcBbmLV+oAnRAXrfWWClGHBn
 GL5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EA/hb1J02hPEkcaU9qA0Wi4qKRGHLIKQ7cjCJ63fUMsdhTx59y7M1YhWdMZGPHmZrVZtZbJV1QI4/@nongnu.org
X-Gm-Message-State: AOJu0Yzcg0joqgB8KDd0dc5JYi9d2JRw9QNXtCDu+PQWrGlU1YmYKzVp
 ntesrpleFnrF4wpV4FIJ4xZ4W6pRvMswClN4QRzYLudeBLRvmSNjc+fCFApfY3WgTf0wtK78rrW
 mHrO/jYhTdGrnWfhzDFlJKik8CXXaop9h7tc06Sv3SyX8btkpmIl0DB/XR0pszvQYbw2z4GIZkg
 6C2mfgbw8wlJ6fVoxuxJFVzcYPWIarBH8=
X-Gm-Gg: Acq92OEs1VZVoKGplBzTAo97XaQ6QOOUSohaVbw6FiwzJ2Ul0dDB2Two1FbWJ46FH6m
 3neaoJeGzieFVAPq/Z2vB44p1mZ6jt8KLf7p2hdUoYmOTpR3pQogTNVGhBxKLW1qVVI/YSC/u4y
 Pq2fuEemD8zim5j15zU2ELdFDR+50CZEvaTDoN+EZdYDNh85P+PNNJxSgnfyUDiF5J2Rv+tEPv6
 UvUxxun3+sDAvKZ/IL9hGR1UJGYe/720ZASB7YdOaVdl1M/dQ==
X-Received: by 2002:a05:6214:e84:b0:8b7:4b46:1248 with SMTP id
 6a1803df08f44-8bc443d1085mr405801676d6.24.1778483616885; 
 Mon, 11 May 2026 00:13:36 -0700 (PDT)
X-Received: by 2002:a05:6214:e84:b0:8b7:4b46:1248 with SMTP id
 6a1803df08f44-8bc443d1085mr405801306d6.24.1778483616456; Mon, 11 May 2026
 00:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
 <20260508101901.930781-4-mark.caveayland@nutanix.com>
In-Reply-To: <20260508101901.930781-4-mark.caveayland@nutanix.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 11 May 2026 12:43:24 +0530
X-Gm-Features: AVHnY4L3NPHy_nZVx8qEDS3UDMpQL_1pCh5hS01D9FM2Gy_7h9Zwoa6iF_ofh4I
Message-ID: <CAK3XEhPMTgfAUrpExXuu+1oEuWmgQCReWw9Yq1Ev3M2eKT2H7g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] hw/char/serial-isa.c: declare IRQ as shared in
 ACPI IRQ descriptor
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 8, 2026 at 3:49=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revis=
ion
> 3.0 is used in the FACP table. The reason for this is that if a 2-byte IR=
Q
> Descriptor is used then the interrupt is considered to be high true, edge
> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 sha=
re
> an IRQ then if more than 2 serial ports are added, Windows indicates a
> conflict in Device Manager and these combinations cannot be used together=
.
>
> Change the 2-byte IRQ Descriptor in the _CRS resource to a 3-byte IRQ
> Descriptor indicating that the ISA serial IRQ is high true, edge sensitiv=
e and
> shareable. This enables all 4 legacy serial ports to be used in Windows w=
ithout
> conflict.
>
> Note that it was agreed during the list discussion that this change does =
not
> require a compatibility property since it is not part of the default mach=
ine
> configuration and was already broken.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  hw/char/serial-isa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index a4be0492c5..59df726871 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -92,7 +92,8 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Am=
l *scope)
>
>      crs =3D aml_resource_template();
>      aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00,=
 0x08));
> -    aml_append(crs, aml_irq_no_flags(isa->isairq));
> +    aml_append(crs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_HIGH,
> +                            AML_SHARED));
>
>      dev =3D aml_device("COM%d", isa->index + 1);
>      aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
> --
> 2.43.0
>


