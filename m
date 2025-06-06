Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3593BC5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNX8t-0007u8-92; Fri, 06 Jun 2025 09:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNX8r-0007tg-6o
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNX8n-0003bv-Vr
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749216588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0WnbWhmX4dFTLqSk681gIAO8XsMnSCU3ptODEOWE3ZM=;
 b=LR9KSdCZsuh5EDQ7IZtbDyGTEjIs1nUlrk1SkDxhnlG7JkLrqXuG2ZwkSAyucQhDaVSkDn
 0VYXpa1+BPU23eSVFYghgSbY9jKE2rNNtStAeobQavlhRyUh4wHl57z6Z4XpQlcBeLdP77
 5qXaAC0qUmszWfL/aKMg+SUpRvs4BaE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-CDkUR3EeN7SSA5-Gsd23EA-1; Fri, 06 Jun 2025 09:29:40 -0400
X-MC-Unique: CDkUR3EeN7SSA5-Gsd23EA-1
X-Mimecast-MFC-AGG-ID: CDkUR3EeN7SSA5-Gsd23EA_1749216579
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-445135eb689so11581925e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749216579; x=1749821379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WnbWhmX4dFTLqSk681gIAO8XsMnSCU3ptODEOWE3ZM=;
 b=LDTowsA06dpvOHU6GpC4mRJlflnjMbv0bctocUs1PDpNsFSt9nm2PbpD+isG7L4KHN
 k6QILszfA5rGzcvo9ak5h9ZZL1v4eQXDbe5pfnA2NdlCiPaoG2JPsO/EXTbZRDPalCCE
 qDhGnzQx5ficJZqYV3FmST8oB/zR8E8Y9lS5e5uWYFV8+vjE6Nngvw4kErXX21zfG2fg
 xcYZ4BzhsqKlZTzS+INgzoGwmT6rDxMqDjnqKKC2pXnQSFBmgMfoaP/eJC5W0v7bRJlH
 L4DVCT7Q1hcF6NOGKe9hZ3LjkKbav3nyiur5RRSjxF7MCGQPq1/Hp/XPwp3yyb6oHxPo
 71Cg==
X-Gm-Message-State: AOJu0YwUZJPH/8yhSCg55l1SHYCWIKUlyinHzhiRNTolLQs4H1BKH7fz
 DCc2l/I6oD0wKBTkgXTxrV05/tawBYygqSP0TtcibKlmbowSj/eZAU2Wzerl4rWGQOl+LCB0X55
 ZpQbvYozhbapCBIjuPB6pHWAMREpSTO3jHQpIh+X4k7k5ri+dx/iRMSc1
X-Gm-Gg: ASbGncsksgjJLlCXlFdCioqvpu+pyvoM7bRNFwxXt6s1OVxPNqy0IBhXEgzpoFjlzMz
 zXd+mtjFgH4HVAFLtHpaRVgzDxIjf/IsBLvcW49iFCHfqzYdztyUDxjP/Kc0U1nNpY0AmKzVL7e
 v0Wz//WGNOFrINe+JJjYiqaRVkVQ8nS+5ZwyDtJA+Ty0nyV+3QzY9BFqU+EiWz2VD/3rWPlv0hL
 cQmh24soO2vTQLSi5VN1BieF2Bdom6XN1fThfJXEwf1Pf/1CQ7qAjXtpqQ9GHeXC91q7Y1dUf+R
 gVG75UvjRRkQ2BUZj+L5gzj8gpAUqH5a
X-Received: by 2002:a05:600c:c177:b0:450:cac5:45e7 with SMTP id
 5b1f17b1804b1-45201417bfbmr33156155e9.1.1749216579180; 
 Fri, 06 Jun 2025 06:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG0E1cVhzdD6/eEywneyoqDGT/OiChjjGR6ykC2TuOE+2enHpRvv2rBLq9SS6mJ4YyEXE5ZA==
X-Received: by 2002:a05:600c:c177:b0:450:cac5:45e7 with SMTP id
 5b1f17b1804b1-45201417bfbmr33156005e9.1.1749216578772; 
 Fri, 06 Jun 2025 06:29:38 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532131df6sm1884454f8f.0.2025.06.06.06.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:29:38 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:29:35 +0200
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
Subject: Re: [PATCH 12/18] hw/nvram/fw_cfg: Inline fw_cfg_file_slots()
Message-ID: <20250606152935.1ba8114f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-13-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-13-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  1 May 2025 23:04:50 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Now than fw_cfg_file_slots() only returns
> FW_CFG_FILE_SLOTS_DFLT, we can inline it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

does this even compile?
I see more usages of fw_cfg_file_slots(), then being removed here.

git grep "fw_cfg_file_slots("
hw/nvram/fw_cfg.c:static inline uint16_t fw_cfg_file_slots(const FWCfgState=
 *s)
hw/nvram/fw_cfg.c:    return FW_CFG_FILE_FIRST + fw_cfg_file_slots(s);
hw/nvram/fw_cfg.c:        dsize =3D sizeof(uint32_t) + sizeof(FWCfgFile) * =
fw_cfg_file_slots(s);
hw/nvram/fw_cfg.c:    assert(count < fw_cfg_file_slots(s));
hw/nvram/fw_cfg.c:    assert(index < fw_cfg_file_slots(s));
hw/nvram/fw_cfg.c:    if (fw_cfg_file_slots(s) < FW_CFG_FILE_SLOTS_MIN) {
hw/nvram/fw_cfg.c:     * configuration is (FW_CFG_FILE_FIRST + fw_cfg_file_=
slots(s)). */
hw/nvram/fw_cfg.c:    if (fw_cfg_file_slots(s) > file_slots_max) {

if we decide to remove x-file-slots, this patch probably needs some fixing
> ---
>  hw/nvram/fw_cfg.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 71c41c979d7..de65ee8342e 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -255,15 +255,10 @@ static void fw_cfg_write(FWCfgState *s, uint8_t val=
ue)
>      /* nothing, write support removed in QEMU v2.4+ */
>  }
> =20
> -static inline uint16_t fw_cfg_file_slots(const FWCfgState *s)
> -{
> -    return FW_CFG_FILE_SLOTS_DFLT;
> -}
> -
>  /* Note: this function returns an exclusive limit. */
>  static inline uint32_t fw_cfg_max_entry(const FWCfgState *s)
>  {
> -    return FW_CFG_FILE_FIRST + fw_cfg_file_slots(s);
> +    return FW_CFG_FILE_FIRST + FW_CFG_FILE_SLOTS_DFLT;
>  }
> =20
>  static int fw_cfg_select(FWCfgState *s, uint16_t key)
> @@ -845,13 +840,13 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const=
 char *filename,
>      int order =3D 0;
> =20
>      if (!s->files) {
> -        dsize =3D sizeof(uint32_t) + sizeof(FWCfgFile) * fw_cfg_file_slo=
ts(s);
> +        dsize =3D sizeof(uint32_t) + sizeof(FWCfgFile) * FW_CFG_FILE_SLO=
TS_DFLT;
>          s->files =3D g_malloc0(dsize);
>          fw_cfg_add_bytes(s, FW_CFG_FILE_DIR, s->files, dsize);
>      }
> =20
>      count =3D be32_to_cpu(s->files->count);
> -    assert(count < fw_cfg_file_slots(s));
> +    assert(count < FW_CFG_FILE_SLOTS_DFLT);
> =20
>      /* Find the insertion point, sorting by file name. */
>      for (index =3D count;
> @@ -926,7 +921,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *f=
ilename,
>          }
>      }
> =20
> -    assert(index < fw_cfg_file_slots(s));
> +    assert(index < FW_CFG_FILE_SLOTS_DFLT);
> =20
>      /* add new one */
>      fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, t=
rue);


