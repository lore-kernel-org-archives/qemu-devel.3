Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD9AFF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXG-00007c-AR; Tue, 07 Apr 2026 14:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wABTw-0003uc-4q
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wA1JD-0002nX-12
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 03:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775548634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0KYySOHThciKi0+KWw6NJzMR5Rud7fOUjQf/noC3hk=;
 b=VKE4VUNLMXtKyIBMknt6a2ecYtGZELkcse1J0RJVJhZNttqr4lQqmUc5iADcLun+qbizQo
 FEnFDNEiknhxJAZaqo6SNbeTEXwj+4l30/I36fDIBa+gyYUSe8Hr3/DOGVvvMriAoliT1P
 9H/cH23Wm9XRQED5zLo4FRnkSN6z6T8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-_xpYLsYSOJqeAJXOfeV2Gw-1; Tue, 07 Apr 2026 03:57:12 -0400
X-MC-Unique: _xpYLsYSOJqeAJXOfeV2Gw-1
X-Mimecast-MFC-AGG-ID: _xpYLsYSOJqeAJXOfeV2Gw_1775548632
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b250d3699aso116126785ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 00:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775548632; cv=none;
 d=google.com; s=arc-20240605;
 b=UPWWU74chpoqQGqbaMdawccZz+Z9AjG+82P6t7FYxt3/FzsB7uK+XDDXS2+bPy2Z1A
 lJ9vZvVTPu31rPiZ+obs/q3UEtUjOpOiuF/Anm/PTygnoyesjEvCMkgPxJNQmzzM1oUf
 3Ay1O2tUjfqttQUlvn0Br0v2aUC3s8w+qD3Q7O4SheMi8Tx/6Foeb+MSFKSdDnYywiFe
 65s3uEY68gk+aaAjC+ZOqpCUTgsYvmwwI016WUPxrAL54gQsuGKGqNVDvR1PN66OG8L4
 tr0A5GfcxUEsR9puX3oX953xEwhu/LIFBwKo+wmAvvjGZVuDYIF4V4e4B9P35V5w7KXv
 ovhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S0KYySOHThciKi0+KWw6NJzMR5Rud7fOUjQf/noC3hk=;
 fh=DjCsBAlzHiQ7urn9emqwzALbJ1ZadaQmzpiSJrrLJFk=;
 b=SM1CMsFYZgW8TJ8V3kjJHzvKkPqsTd2kPXOSCH13iDCR5GN3eIpOYMi8LcJKkmDKOs
 NCpcY8/+mSMA/JIMucie5yaXOBCqQOpg5QW1vJg4lcVpma2phxBttrS1kUzPlEZRkNDS
 Zn2qFsVkPPMiDJctylivk4J/7C+s2UM/uz6yf65UUY7a4UxRrgHHrRbXPybqyMKXymB1
 LibEiTvkrU5tPUBRReGLoKg1eEMV05tav5rvmuMzvVJnlkigvcaWu7y5SXRaidGM33MQ
 /Jz6G3OGkTwL/sIO/odq+hjqUpEEyplgf04/+7947y90fNtYGaiPX2AJM2eW7KANNCOH
 uV3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775548632; x=1776153432; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0KYySOHThciKi0+KWw6NJzMR5Rud7fOUjQf/noC3hk=;
 b=EF/TchZ3lIT9qtFUbmu61NUdDiaF0qD/Ji/xkpSzUlQkRSZTb8+KYclILlb32qHq5B
 ncjOJGjWshsUqlye9IGf5nJqFK7Osba/BV4KelV51S+OlMTDolfjLo+C6hvIEYzM+1aL
 NCxxyySYQ+vfRgLKT0KknK/n4UT8FhXxuiV9bjMTb7ZuT7eEahUvpu8bGaxlmEFKJKLX
 4y9VcYUzH5jr0vwvYW8qE+T793zCUmw1jENN9P9GVrNxipk5ZdtYDphXu055a9TnkKnc
 9AG3+xgNj4YJ3lG0ai4P6YFGVSungMzLCCGa4zpgO7C4NujrEX9YiRouL33+2cPkv6ne
 pKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775548632; x=1776153432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S0KYySOHThciKi0+KWw6NJzMR5Rud7fOUjQf/noC3hk=;
 b=bihaoQos9HOPvI4UlDuMQM6rt3QGaL4IqFHMFzLXQ1aaXnpPn9LQeegR/Q56tuvG3y
 Qt4xRUpo7N/fO7sN+Nwjbi/RY8TiIn9g0MI7ubEO8PpqokwAB2QtT/iywi6Qel0Q4Zv9
 ZjyVnTUTN0kw9im73Yz+9FUUmxF0OPNwqiZmHhdw0Ua2BBgDCOWkNUSlqHKtG2COW2bF
 bVQejuUWCEXyQjB4AqJESeyy9uSq3lfYoQkTT84ANE6fYqq+2VDqmitZYyxwQbjbQ7/N
 gprysDFHulCoZhp2hCQ1Hzjlf+FXuRILspTqosgnjJ2s/dk9VYHviqrBqSxMKxOy0DUz
 GdAA==
X-Gm-Message-State: AOJu0YxTWTTg/8It6JFrdTukWFh+OSbnr+VN5Ny9v+zZR//SshpHpCJZ
 yf7m/6jzt5Ou6fZrRjp9F9b6vpBaJNdDKZZwQIKJDj1lSK+C9xWK0TDNyav7lcCOX4oMfu0kwkM
 BcnRWNPSGH2kLBdNYfpLlrjURo3llow+K+iv7x+oO74g8roIb4ZxizvMsURi6md4L6YFZAbyHuk
 4eAxqwl69wyKGR0PZNEihapE+JLBbQvSs=
X-Gm-Gg: AeBDietGJbw6Sj8rlAjZ3yWul1dxil5tk0LmwaE4dlzVN6PW6WkbSd8O8/OpKw+5YmQ
 YpwovK7UVe6rty2DZTCvt2AVBZAujrPhWGPqCZsVZZzsX/nyOgDVr2ChUE2KF06H0BWdkIlK4qt
 dAhcbTQUNzjeesUM1ZCr25p52NjUnl2KCX6oVCrkbWuGnikt6cDWI/buKXbR6TKIyuGVLtK84nT
 ZYdLOAoAhir0yZTYVuUQ45GiefmO4/fbEms9bIpAe/xHxBkhzrvWkI3Kqz/oANhpGXMRbfnVlXH
 iWN3YW2+uPqzdR5kEyn7dV4=
X-Received: by 2002:a05:6a20:3d94:b0:39e:f994:f697 with SMTP id
 adf61e73a8af0-39f2ee03404mr16156114637.17.1775548631792; 
 Tue, 07 Apr 2026 00:57:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d94:b0:39e:f994:f697 with SMTP id
 adf61e73a8af0-39f2ee03404mr16156080637.17.1775548631327; Tue, 07 Apr 2026
 00:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-4-armenon@redhat.com>
In-Reply-To: <20260406141735.25844-4-armenon@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Apr 2026 11:56:58 +0400
X-Gm-Features: AQROBzD0SE4tJJrizT42wl7xoz8BU99qQfsgKEzrQIpLucpnL9BYYhfAuzPwWNE
Message-ID: <CAMxuvayywHuA4X8G8gfuOnW9MTP5BLuNayOTJq_k423pdFDKGg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] hw/tpm: Add internal buffer state for chunking
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 6, 2026 at 6:18=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
e:
>
> From: Arun Menon <armenon@redhat.com>
>
> - Introduce GByteArray buffers to hold the command request and response
>   data during chunked TPM CRB transactions.
> - Add helper function to clean them.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/tpm/tpm_crb.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index bc55908786..d65b3e2cc1 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -38,10 +38,13 @@ struct CRBState {
>      TPMBackend *tpmbe;
>      TPMBackendCmd cmd;
>      uint32_t regs[TPM_CRB_R_MAX];
> +    size_t be_buffer_size;
>      MemoryRegion mmio;
>      MemoryRegion cmdmem;
>
> -    size_t be_buffer_size;
> +    GByteArray *command_buffer;
> +    GByteArray *response_buffer;
> +    uint32_t response_offset;
>
>      bool ppi_enabled;
>      TPMPPI ppi;
> @@ -85,6 +88,13 @@ enum crb_cancel {
>
>  #define TPM_CRB_NO_LOCALITY 0xff
>
> +static void tpm_crb_clear_internal_buffers(CRBState *s)
> +{
> +    g_byte_array_set_size(s->response_buffer, 0);
> +    g_byte_array_set_size(s->command_buffer, 0);
> +    s->response_offset =3D 0;
> +}
> +
>  static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
>                                    unsigned size)
>  {
> @@ -134,9 +144,11 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr =
addr,
>          }
>          break;
>      case A_CRB_CTRL_CANCEL:
> -        if (val =3D=3D CRB_CANCEL_INVOKE &&
> -            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> -            tpm_backend_cancel_cmd(s->tpmbe);
> +        if (val =3D=3D CRB_CANCEL_INVOKE) {
> +            if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> +                tpm_backend_cancel_cmd(s->tpmbe);
> +            }
> +            tpm_crb_clear_internal_buffers(s);
>          }
>          break;
>      case A_CRB_CTRL_START:
> @@ -240,6 +252,7 @@ static void tpm_crb_reset(void *dev)
>          tpm_ppi_reset(&s->ppi);
>      }
>      tpm_backend_reset(s->tpmbe);
> +    tpm_crb_clear_internal_buffers(s);
>
>      memset(s->regs, 0, sizeof(s->regs));
>
> @@ -306,6 +319,9 @@ static void tpm_crb_realize(DeviceState *dev, Error *=
*errp)
>      memory_region_add_subregion(get_system_memory(),
>          TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
>
> +    s->command_buffer =3D g_byte_array_new();
> +    s->response_buffer =3D g_byte_array_new();
> +
>      if (s->ppi_enabled) {
>          tpm_ppi_init(&s->ppi, get_system_memory(),
>                       TPM_PPI_ADDR_BASE, OBJECT(s));
> @@ -318,12 +334,22 @@ static void tpm_crb_realize(DeviceState *dev, Error=
 **errp)
>      }
>  }
>
> +static void tpm_crb_unrealize(DeviceState *dev)
> +{
> +    CRBState *s =3D CRB(dev);
> +
> +    g_byte_array_unref(s->command_buffer);
> +    g_byte_array_unref(s->response_buffer);

I have a preference for g_clear_pointer(&ptr, g_byte_array_unref), it
is safer, but unrealize() should only be called once after realize()
so ok.

> +
> +}
> +
>  static void tpm_crb_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      TPMIfClass *tc =3D TPM_IF_CLASS(klass);
>
>      dc->realize =3D tpm_crb_realize;
> +    dc->unrealize =3D tpm_crb_unrealize;
>      device_class_set_props(dc, tpm_crb_properties);
>      dc->vmsd  =3D &vmstate_tpm_crb;
>      dc->user_creatable =3D true;
> --
> 2.53.0
>


