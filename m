Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6047C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 03:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnUaB-0000kZ-21; Wed, 26 Feb 2025 22:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUa7-0000dY-Gx; Wed, 26 Feb 2025 22:29:03 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUa5-0005oK-Pn; Wed, 26 Feb 2025 22:29:03 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2234bec7192so11412315ad.2; 
 Wed, 26 Feb 2025 19:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740626939; x=1741231739; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlvQSyw3lhTKi/QCMs6UB0ZZlrkLyHNRXnk/S/LWf9I=;
 b=Dfr96LxpauRJYWuGC25hnDsexlkbH7nU3XsQPSuJn7oWy/KIbEDbqYj4JjsHObebaC
 xNOJbKDmecR6Ro7voCp+/QoHssaTgxqlur5/XjUCkqDM+eFV9hj0msWSNehxNVrYkhEB
 v3Nvw/OHSY2WimKdG/J+mQ6eTRHhaADB6A6YVhD47pjgs+0GkF+c+XxidQc9lys+BBCX
 vE+jeAp71XJKILSuZ6+o2BVQppsH4KR28yJ4eGxsVQ2R30cGsakPC4tByjX4DIDE1zkf
 Fc5u+UieSuyAi7vSsGy1Hisv9VXvBNaDc89DuULDZ768yMP+E5Wq8LbBNGbpSow3L+Gh
 oKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740626939; x=1741231739;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FlvQSyw3lhTKi/QCMs6UB0ZZlrkLyHNRXnk/S/LWf9I=;
 b=tLBok1C4y06OlsG0U13qb/LtWA4Fp5ZW95IO+ZQjAG0M4wYnS0VOl8BAT7yAeEqALa
 UYiRh/SeLE4dqBePJRkWwfhNNYrSF37OoNp1z4OAM7PIp9oKs/WeEYEnjO/AMoa1Dg9x
 K03xIT8BBeXTuEnvwvZ2gVLbJes50I54hwMln+W11ZbTK7hPXHQkBwygV+Ox6KZf4Jvk
 p+/gxKRTzBT+WPm5fMoiEcHf/1eEqUAhm9KypAY5t6Oq3Wqf//GvgC7q1uwoqiU734yW
 Ode6nZBbgMcmDj6dpFUq6Rn99OfDf13XKJ8QxmJmKdniyTUpPgKeb9qzCAs2TZw9p8ri
 JHeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRePVoIKP0ylKjrtl3WKfammKan5kVoKgpckNf7WLzb4Ll6ZUea2NLxBDeEOfIxXZvbYYEuzcy/9Sf@nongnu.org
X-Gm-Message-State: AOJu0YyzLJB9TOh0QZ1t9tezQA8tSNHEZSzU65rj30yV4kZNvM8Xzm9C
 k7WBGWVte7kXSlF9wIODLLtbQzkulpVjallpAq7V9GuWez8B1kuj
X-Gm-Gg: ASbGncvPAsCz6jDVq0U4X2HItVVq1GGqRga5ao2P3WzJRwFBCOCoN4yha3nD4dCro/J
 qWBco4cl86/0X6Kg/zXLNJuwLsR6e8i0/MWlqRPlQ5oaycoPojKDWXZjNSjKApWnD7bwJ8kPRSP
 9YYNRz/pvfdET/+FmpZSn/1smeMHCBy2Z92+PayPU3w/V/P1agXbqvwkaNd4RtKpWKSNMhixDHV
 VeiI3/9m2oSzU1B0qPBDUQZNm4Xsc1UDQB4gu1pYnY8ZqDvWB5tBFJ0PN7RkQh/V7n7c2fC6ZhV
 xeCTNllvN9V5lKNkRA==
X-Google-Smtp-Source: AGHT+IEGkuFE89rxeBHj521pmQbSz4RHUevmqse34cQuCx1cCjLY5Qz2ILr24E58DNfNdlHYyQGmXQ==
X-Received: by 2002:a05:6a21:328d:b0:1f0:ea9e:bd6b with SMTP id
 adf61e73a8af0-1f10ad762e3mr8307328637.20.1740626939110; 
 Wed, 26 Feb 2025 19:28:59 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a0024bf9sm392154b3a.112.2025.02.26.19.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 19:28:58 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 13:28:53 +1000
Message-Id: <D82WR22WF5C9.20VWJUD0Y5IPN@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Sourabh Jain" <sourabhjain@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Hari Bathini" <hbathini@linux.ibm.com>
Subject: Re: [PATCH 5/6] hw/ppc: Pass device tree properties for Fadump
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-6-adityag@linux.ibm.com>
In-Reply-To: <20250217071711.83735-6-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
> Platform (ie. QEMU) is expected to pass few device tree properties for
> details for fadump:
>
>   * "ibm,configure-kernel-dump": RTAS call for fadump
>   * "ibm,configure-kernel-dump-sizes": Space required to store dump data
>     for firmware provided dump sections (ie. CPU & HPTE regions)
>   * "ibm,configure-kernel-dump-version": Versions of fadump supported
>   * "ibm,kernel-dump": Contains the Fadump Memory Structure on a fadump
>     boot
>
> Implement passing configure-kernel-dump-sizes, and
> configure-kernel-dump-version device tree properties, irrespective of
> whether it's a fadump boot or not, so that kernel can reserve memory to
> store the firmware provided dump sections in case of a crash
>
> Also, in case of a fadump boot, pass the fadump memory structure to the
> kernel in "ibm,kernel-dump" device tree property.
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  hw/ppc/spapr.c         | 62 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  2 ++
>  2 files changed, 64 insertions(+)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f3a4b4235d43..3602e5b5d18d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -897,9 +897,27 @@ static int spapr_dt_rng(void *fdt)
>  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>  {

You might be able to add a spapr_dt_rtas_fadump() function
and do it there to help keep functions small?

Thanks,
Nick

>      MachineState *ms =3D MACHINE(spapr);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>      int rtas;
>      GString *hypertas =3D g_string_sized_new(256);
>      GString *qemu_hypertas =3D g_string_sized_new(256);
> +    uint32_t max_possible_cpus =3D mc->possible_cpu_arch_ids(ms)->len;
> +    uint64_t fadump_cpu_state_size =3D 0;
> +    uint16_t fadump_versions[2] =3D {
> +        FADUMP_VERSION /* min supported version */,
> +        FADUMP_VERSION /* max supported version */
> +    };
> +    uint32_t fadump_rgn_sizes[2][3] =3D {
> +        {
> +            cpu_to_be32(FADUMP_CPU_STATE_DATA),
> +            0, 0 /* Calculated later */
> +        },
> +        {
> +            cpu_to_be32(FADUMP_HPTE_REGION),
> +            0, 0 /* HPTE region not implemented */
> +        }
> +    };
> +
>      uint32_t lrdr_capacity[] =3D {
>          0,
>          0,
> @@ -1006,6 +1024,50 @@ static void spapr_dt_rtas(SpaprMachineState *spapr=
, void *fdt)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
>                       lrdr_capacity, sizeof(lrdr_capacity)));
> =20
> +    /*
> +     * CPU State Data contains multiple fields such as header, num_cpus =
and
> +     * register entries
> +     *
> +     * Calculate the maximum CPU State Data size, according to maximum
> +     * possible CPUs the QEMU VM can have
> +     */
> +    /* Reg save header */
> +    fadump_cpu_state_size +=3D sizeof(struct rtas_fadump_reg_save_area_h=
eader);
> +
> +    /* Num_cpus */
> +    fadump_cpu_state_size +=3D sizeof(__be32);
> +
> +    /* Register Entries */
> +    fadump_cpu_state_size +=3D max_possible_cpus   *
> +                             FADUMP_NUM_PER_CPU_REGS *
> +                             sizeof(struct rtas_fadump_reg_entry);
> +
> +    /* Set maximum size for CPU state data region */
> +    assert(fadump_rgn_sizes[0][0] =3D=3D cpu_to_be32(FADUMP_CPU_STATE_DA=
TA));
> +
> +    /* Upper 32 bits of size, usually 0 */
> +    fadump_rgn_sizes[0][1] =3D cpu_to_be32(fadump_cpu_state_size >> 32);
> +
> +    /* Lower 32 bits of size */
> +    fadump_rgn_sizes[0][2] =3D cpu_to_be32(fadump_cpu_state_size & 0xfff=
fffff);
> +
> +    /* Add device tree properties required from platform for fadump */
> +    _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-version",
> +                    fadump_versions, sizeof(fadump_versions))));
> +    _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-sizes",
> +                    fadump_rgn_sizes, sizeof(fadump_rgn_sizes))));
> +
> +    if (is_next_boot_fadump) {
> +        struct rtas_fadump_mem_struct *fdm =3D
> +            &fadump_metadata.registered_fdm;
> +
> +        uint64_t fdm_size =3D
> +            sizeof(struct rtas_fadump_section_header) +
> +            (be16_to_cpu(fdm->header.dump_num_sections) *
> +            sizeof(struct rtas_fadump_section));
> +
> +        _FDT((fdt_setprop(fdt, rtas, "ibm,kernel-dump", fdm, fdm_size)))=
;
> +    }
>      spapr_dt_rtas_tokens(fdt, rtas);
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 0e8002bad9e0..fa63008e57ec 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -928,6 +928,8 @@ static inline uint64_t fadump_gpr_id_to_u64(uint32_t =
gpr_id)
>      return val;
>  }
> =20
> +extern bool is_next_boot_fadump;
> +
>  struct fadump_metadata {
>      bool fadump_registered;
>      bool fadump_dump_active;


