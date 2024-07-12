Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8224C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 07:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSAJA-0003Lu-K4; Fri, 12 Jul 2024 03:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sSAJ8-0003Km-69
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 03:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sSAJ6-0002dF-1n
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 03:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720767781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqIpPDnOyuX5sqO1zxtm5WgFHwBeipQ3qUwnF4QODTo=;
 b=fAhZK2CFDnwZ24d7lG5HHZSiuM6nv3HNzZNdT2tIbT6+x8M0CVCLslpawjY1OmayyZr8sX
 je5PHpTHmzAduouyOtvOxUKL8tWUeCKdV4Sntx6XOtkVk6KvBuwxzr7jAMbPa5OCwfxkpo
 shcYIVym+SY2j0N+if0vjNX6s4qdV30=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-4Njd9IahN6KwSXR2TyZroQ-1; Fri, 12 Jul 2024 03:02:59 -0400
X-MC-Unique: 4Njd9IahN6KwSXR2TyZroQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-70377dcee38so1755822a34.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 00:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720767778; x=1721372578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqIpPDnOyuX5sqO1zxtm5WgFHwBeipQ3qUwnF4QODTo=;
 b=V2cX532ZZsT3yWowDYnPPsBd1hip5FBhm6bdlAh6ojlUfqwPQPBBNQ7wVrJjrqdyxd
 a6pb1ts0rSGm7fi5rOHw9yQhp6CH28frmf5Wf60Jk3RXunwapNFVIuZ0u3llM5nAqjJq
 HBiWfR5QB372HQlt25Z4fkd/V1vTU3ZxjiaPzNRch2so4KIwwMUuMJtnyCz7P2/Et3oG
 zCdLWTiWVP20DreAs1eKwvJ63JlfqRz9z3gaO1/CNPQYpQgMLGt/n9MnLHrTlulvCEMF
 1KVlRBEBZZ8Fl/JDRJ01U4Yp8wG3ruedU3XuMX2zPazZUz4Wggp56CDZF/OB9FkyWwny
 SfbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXCP2hln1JDRWiiFg8weggJte6SqNXPvg2HOIrQRC03BhdrVZMh6TShj0TRp22gY02DE9b//aKfl61nwPC9DzDiA6Z4UI=
X-Gm-Message-State: AOJu0Yymr7K6rjXVEkQ3zpJGjOYDVa+lcBYWriX+o1qqfbskO4+kAj8c
 PS8VdckUHFUxEI2jypQ8nXFBWChEY7NipKB6vl608cO0mAeEBS6ZL2u2a8UHS/TfAwh9dKd94W/
 V2lx79IAGFR2nVPyGbBaFK++KfSddyFtZ86SVjGWbC2J+aZHI40mrkf+7kjNsDRaqrT0rm7bYKJ
 t1xmSy6r35O22uoJ5mAL067RQG45c=
X-Received: by 2002:a9d:6744:0:b0:708:b3c0:1442 with SMTP id
 46e09a7af769-708b3c015a4mr3189245a34.1.1720767778630; 
 Fri, 12 Jul 2024 00:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlA8m1sqkMcJm6+rYTxbqgIe8TUiq8WMDavZRBDSGWF9ptfvgSr2pT1PTESSoLEPXwdGysCeONjOGiI5AumOk=
X-Received: by 2002:a9d:6744:0:b0:708:b3c0:1442 with SMTP id
 46e09a7af769-708b3c015a4mr3189228a34.1.1720767778328; Fri, 12 Jul 2024
 00:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240712062452.31457-1-anisinha@redhat.com>
In-Reply-To: <20240712062452.31457-1-anisinha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 12 Jul 2024 11:02:46 +0400
Message-ID: <CAMxuvayehPe==yODKyPHAMm2oHTAkX_mw6kSi+ecsyg4AkztWQ@mail.gmail.com>
Subject: Re: [PATCH] hw/vmcoreinfo: make guest format endian safe
To: Ani Sinha <anisinha@redhat.com>
Cc: philmd@linaro.org, armbru@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Fri, Jul 12, 2024 at 10:25=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> Guest and host formats in struct FWCfgVMCoreInfo are written in little en=
dian
> format. However, the hypervisor host might be big endian. We need to do
> appropriate conversions between the formats before comparing the values. =
Fix it.
>

Looks right, but that shouldn't matter since the comparison is with 0.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/misc/vmcoreinfo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
> index 833773ade5..e00df95e29 100644
> --- a/hw/misc/vmcoreinfo.c
> +++ b/hw/misc/vmcoreinfo.c
> @@ -21,9 +21,10 @@
>  static void fw_cfg_vmci_write(void *dev, off_t offset, size_t len)
>  {
>      VMCoreInfoState *s =3D VMCOREINFO(dev);
> +    uint16_t guest_format =3D le16_to_cpu(s->vmcoreinfo.guest_format);
>
>      s->has_vmcoreinfo =3D offset =3D=3D 0 && len =3D=3D sizeof(s->vmcore=
info)
> -        && s->vmcoreinfo.guest_format !=3D FW_CFG_VMCOREINFO_FORMAT_NONE=
;
> +        && guest_format !=3D FW_CFG_VMCOREINFO_FORMAT_NONE;
>  }
>
>  static void vmcoreinfo_reset(void *dev)
> --
> 2.42.0
>


