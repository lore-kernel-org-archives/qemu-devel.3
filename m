Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA4AC5B555
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSzR-0003mB-9c; Tue, 03 Jun 2025 10:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMSzA-0003kP-Nm
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMSz3-0003NU-RT
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748962279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntdFLFZF5SEAw0Dev+kJyJ08B/i+fYq32MMu452nJkI=;
 b=PzNgPh0k1Gdf1MwQuIO9rzcw2Kq4S3UghEl2dXxgKzPx9IZIkx/JXzIjwWXBvI6P63AgnZ
 NhVu7zL3jTevkXzuGHWzoSK+93Lg+xgwu6IQyHKguy8XLvpCzz5r4EFnLPP4EYczVkRIbL
 VI1Ix5AxMNu/drm+gVO1NN9Sb9kG3rU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-WUOQhSXOPB6eFNg_bJ2UHQ-1; Tue, 03 Jun 2025 10:51:16 -0400
X-MC-Unique: WUOQhSXOPB6eFNg_bJ2UHQ-1
X-Mimecast-MFC-AGG-ID: WUOQhSXOPB6eFNg_bJ2UHQ_1748962276
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450cb8ff0c6so27809905e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 07:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962275; x=1749567075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ntdFLFZF5SEAw0Dev+kJyJ08B/i+fYq32MMu452nJkI=;
 b=McjjKNGpNrbZiizLxAcg0CKbY7DMKWWv8WdKY/tvbQG/uWADINUku73FJ/tYSR3gSk
 0tQyWCP1OldOHjcBe+raNb8PmLipvEipcGvC8+4XpnKYfgMzkBWpvWM/poQxVTFstvgC
 vVN+9gUkS195Fe2PuBhaZnGv+87TYvdnivDQydVc35+4L9aImzckXnZbe1DVjy77SEuI
 /OgiNkTWc1RNbz6mmpgaa6mVz/mpGTKPLzxqPoOracMCnc3U5/r2+d8OoAhc03vzAPwS
 o/wYulv/WywdH/vy8djO5z4KidkPmCl6aVA+KHHMNto5eDShzxWhhGPJ+FoHfRFuL8E0
 nx6w==
X-Gm-Message-State: AOJu0YyFRb+shFXLihmFm8wLs5LIhw9mYyKpPtpEvlGqTubdi/UtzQO2
 GMwCZLkP92XLixBr4gKS29I02TOl7SJK4ezASdJzAPDXvGY5lDHSOSZpjEjuqQLrsSZ1fsOMJ7B
 1WP2RoJ8jYAAeUPusw5pM4ZJJ8PvIRnz18b5Ju89uC5PrupgaNfzMdjuQ
X-Gm-Gg: ASbGncsHBQemn98OuypNk1+kOCsYDCW6brgmkwjlTW7sOR53LHYc6ZIvMw/fiBzU9pB
 2laa+TajwnYW6iQBS8Vedi+V6Z1D0YWq8Y4YKUByb/hb7oQ/1Gb9jxl6YkJIP0tbXHAMAIH34+t
 THHd03GvSJA2F5OMvFNHe1cJ3WCalrSzAEsN9HMnsMlOeoWSIkFAUg9T9+gQHS2o1gcqGW4pR1/
 yuWeSrzkaBHTkloBRPbK29z/0pqLGUCYMuUUa+u5c1rH3tWzLe5qUFDzjkzSH2GIGa3TCbeh/Li
 CZHNXUn6CXffJcodRXnicyN6otXXyJUE
X-Received: by 2002:a05:600c:46cb:b0:442:f44f:655 with SMTP id
 5b1f17b1804b1-450d8871453mr129615295e9.32.1748962275572; 
 Tue, 03 Jun 2025 07:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ3/YHkT1MXLcjj6AynQsVX8wWu9qpeooWRlByT79JbL0Bmhj6QhG4tygiTGgX5me68erGAQ==
X-Received: by 2002:a05:600c:46cb:b0:442:f44f:655 with SMTP id
 5b1f17b1804b1-450d8871453mr129614945e9.32.1748962275097; 
 Tue, 03 Jun 2025 07:51:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8edc0sm162966105e9.5.2025.06.03.07.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:51:14 -0700 (PDT)
Date: Tue, 3 Jun 2025 16:51:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf
 <kwolf@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>, Jason Wang
 <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v4 03/19] hw/i386/pc: Remove pc_compat_2_4[] array
Message-ID: <20250603165113.5bb27c2e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250512083948.39294-4-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-4-philmd@linaro.org>
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
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 12 May 2025 10:39:32 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The pc_compat_2_4[] array was only used by the pc-q35-2.4
> and pc-i440fx-2.4 machines, which got removed. Remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h |  3 ---
>  hw/i386/pc.c         | 19 -------------------
>  2 files changed, 22 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index f4a874b17fc..b34aa25fdce 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -301,9 +301,6 @@ extern const size_t pc_compat_2_6_len;
>  extern GlobalProperty pc_compat_2_5[];
>  extern const size_t pc_compat_2_5_len;
> =20
> -extern GlobalProperty pc_compat_2_4[];
> -extern const size_t pc_compat_2_4_len;
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                   const void *data) \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c8bb4a3ee47..2b46714a5ac 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -262,25 +262,6 @@ const size_t pc_compat_2_6_len =3D G_N_ELEMENTS(pc_c=
ompat_2_6);
>  GlobalProperty pc_compat_2_5[] =3D {};
>  const size_t pc_compat_2_5_len =3D G_N_ELEMENTS(pc_compat_2_5);
> =20
> -GlobalProperty pc_compat_2_4[] =3D {
> -    PC_CPU_MODEL_IDS("2.4.0")
> -    { "Haswell-" TYPE_X86_CPU, "abm", "off" },
> -    { "Haswell-noTSX-" TYPE_X86_CPU, "abm", "off" },
> -    { "Broadwell-" TYPE_X86_CPU, "abm", "off" },
> -    { "Broadwell-noTSX-" TYPE_X86_CPU, "abm", "off" },
> -    { "host" "-" TYPE_X86_CPU, "host-cache-info", "on" },
> -    { TYPE_X86_CPU, "check", "off" },
> -    { "qemu64" "-" TYPE_X86_CPU, "sse4a", "on" },
> -    { "qemu64" "-" TYPE_X86_CPU, "abm", "on" },
> -    { "qemu64" "-" TYPE_X86_CPU, "popcnt", "on" },
> -    { "qemu32" "-" TYPE_X86_CPU, "popcnt", "on" },
> -    { "Opteron_G2" "-" TYPE_X86_CPU, "rdtscp", "on" },
> -    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "on" },
> -    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "on" },
> -    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "on", }
> -};
> -const size_t pc_compat_2_4_len =3D G_N_ELEMENTS(pc_compat_2_4);
> -
>  /*
>   * @PC_FW_DATA:
>   * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables


