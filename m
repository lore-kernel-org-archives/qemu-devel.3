Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303A9C5B555
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTSu-0006FT-BR; Tue, 03 Jun 2025 11:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTSp-0006El-7o
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMTSn-0007HA-CB
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748964121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+yUE+tTUa4mp1fTc6f9QfOTvZjjWKt7+qSu1VMRok+c=;
 b=TuQPQBg3vMgzBebSYDiWb785Sri7wuJNujs5xSFvlbGjFRciTwdLIB4vPR0fKt0vO0/86A
 deonq9dEandt8yaS++MeeCGZ0rOqg137gL6EirJVzsxWIpyO5NgmUlAvJJxj1GhsWHrgxV
 JzH7tRPSriBWsKWAxFu4fflxyknlWTc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-0mif5PzYNz2gvOfMy785dA-1; Tue, 03 Jun 2025 11:21:59 -0400
X-MC-Unique: 0mif5PzYNz2gvOfMy785dA-1
X-Mimecast-MFC-AGG-ID: 0mif5PzYNz2gvOfMy785dA_1748964118
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451dda846a0so15818565e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 08:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748964118; x=1749568918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+yUE+tTUa4mp1fTc6f9QfOTvZjjWKt7+qSu1VMRok+c=;
 b=FUqTIyg0Cc+WINPCiOivHZCETs8fiHrd2ZwWtvcYd1pGNrGyrnIKXdTkiiUBsDo7av
 6aRe+FyNmoT7PNSUdV2B4BxbnqXHmCmQdSG++YkYdzMlUwzSl+LXB9UYyxrn9N8uUn/J
 dvq7UKxkckYOvTpFjGWry1rDQ0jTw14pf/rwc6lFFU7vUHWhWECAdvqKHo07yKTQVIt3
 Pv0QZN1CBrLixGLji5+OhEdtW0cVKn7z2GiMeCDRcUjhxlJdpUn+Kom5I1ul2wymx9a9
 Ss/xzvTPMgSgzF3UYpj17EmiKSm5JINahZ79cWGIEVGv5+6GokFmXtV0a4/omu9OI3Hu
 tjrQ==
X-Gm-Message-State: AOJu0Yw1MlE3dC5Xfp/HNvj6SBC/Ut9OOCkVRC8Lklxl/rhcomxri/Zr
 tjmsEPiDRLk6JVuZilyVgFqymScnZsdG4QxHVAo/UMvGmUJQjQtSnseJukzo1DPg+jlZy7rs5qp
 aWzyY+3+rhbFuKAsIE62uy6GZIbeONOvzLtT+140KIyKRLrs+K2+dFBJL
X-Gm-Gg: ASbGncv/CCrl9+nciEIQC9Mi+hY/sfxSUJQgDWb5bFbiAuobJW3MvsRX59rf4vjNrpd
 kk85JTvkT1bmJVCYADdGk8affX88wiFKH+uZ0+U1iF6NbvyD8yUmdLI+K6zfxaWFsyKt/VgG2C2
 CLbOxtEAa7UCGtnBd1nkldQlQaEw3lSJrSS9AKhyy5eWQhgIMbvgDKCF3WKYxkE/Y5Jydi7EouD
 JlE+2Ohi2F44S6uLxpl4pZFfWKic1TbdVZC14K5Tt5RfMfS2qFvVW/KI4ikfZG7xw5WZUTmzLta
 LB7zeR3nmEs1NeAOWd0QhaOJfJG+d0aC
X-Received: by 2002:a05:6000:144e:b0:3a4:d6ed:8e2e with SMTP id
 ffacd0b85a97d-3a4fe395675mr10947806f8f.41.1748964118212; 
 Tue, 03 Jun 2025 08:21:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFefqfx+yIS94sHF41DsqzOATq75PLFZ8DvniTgubVaA1RPqpyQ1swoom0k/4TGMpyocz6tog==
X-Received: by 2002:a05:6000:144e:b0:3a4:d6ed:8e2e with SMTP id
 ffacd0b85a97d-3a4fe395675mr10947783f8f.41.1748964117815; 
 Tue, 03 Jun 2025 08:21:57 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a03bdsm19046004f8f.91.2025.06.03.08.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:21:57 -0700 (PDT)
Date: Tue, 3 Jun 2025 17:21:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 02/18] hw/i386/pc: Remove pc_compat_2_8[] array
Message-ID: <20250603172155.4ded95fe@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-3-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu,  1 May 2025 23:04:40 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The pc_compat_2_8[] array was only used by the pc-q35-2.8
> and pc-i440fx-2.8 machines, which got removed. Remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h | 3 ---
>  hw/i386/pc.c         | 9 ---------
>  2 files changed, 12 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 319ec82f709..db02cbc0d65 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -286,9 +286,6 @@ extern const size_t pc_compat_2_10_len;
>  extern GlobalProperty pc_compat_2_9[];
>  extern const size_t pc_compat_2_9_len;
> =20
> -extern GlobalProperty pc_compat_2_8[];
> -extern const size_t pc_compat_2_8_len;
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                   const void *data) \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ee7095c89a8..5f07a44d447 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -232,15 +232,6 @@ GlobalProperty pc_compat_2_9[] =3D {
>  };
>  const size_t pc_compat_2_9_len =3D G_N_ELEMENTS(pc_compat_2_9);
> =20
> -GlobalProperty pc_compat_2_8[] =3D {
> -    { TYPE_X86_CPU, "tcg-cpuid", "off" },
> -    { "kvmclock", "x-mach-use-reliable-get-clock", "off" },
> -    { "ICH9-LPC", "x-smi-broadcast", "off" },
> -    { TYPE_X86_CPU, "vmware-cpuid-freq", "off" },
> -    { "Haswell-" TYPE_X86_CPU, "stepping", "1" },
> -};
> -const size_t pc_compat_2_8_len =3D G_N_ELEMENTS(pc_compat_2_8);
> -
>  /*
>   * @PC_FW_DATA:
>   * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables


