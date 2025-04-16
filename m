Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CC1C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ym7-0007O6-9y; Wed, 16 Apr 2025 05:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4ym4-0007KU-4a
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:09:40 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4ym0-0006kK-Om
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:09:39 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e5c9662131so10037465a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744794575; x=1745399375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pz+DQYTjfrii7dXnD3OWK9QGb8Y5PQkHF7bbhyCcqSg=;
 b=FatkOwT3KAFZBYWS1zqEqXuY352Kn6Pg+5RkLQWsXBPiTq+l5hcwHrGc35dTxwRRVZ
 9uZ31ghecGOTSUYlI80H+TbuRoXOUpXWqxu7jwMmxrACryKbn7Qu6aYiiQe0dxd1/VzY
 1+FC0eXd88TbDnmVnb7tsLhwwo4PF9mq2PMRR7Sgp51wNepYCOX08kGVeCenfLDT71MD
 3+I20U13q0NJdH0k0oHQhoYKCyF1zR5SSzJ0CbCiSbp0GzaRbarJlFxTrz9BG8QQmTpF
 eC4wih1PdA6uH7AO+LjT3A+eFtLOj6lJKIr7lJ8lL12/UG3yQPTKv//gOcuB49P2J9QT
 vQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744794575; x=1745399375;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pz+DQYTjfrii7dXnD3OWK9QGb8Y5PQkHF7bbhyCcqSg=;
 b=o84cOz11JF8QLDZju53FjTkzcS6Kf0p3rVXIr7F62Qvh0hzKGAyg2RsXpZsuUrW5lt
 AYtYR4ON0vNXKb7wUf3OZDQnxVfQ7b3w1N4E2GhKtx/xkCgeZqW1jAeYzOM4WmWr1JkB
 s21vnKB5zUdNjtUlVt9FLR1+6Pbjkv9dPprYlne5sa08RqqYtPZq5MwDeLkkJyuA53+B
 1K1VuGSRwNbGLmlT0LTm8ZC06ALzTJ9sUSrlSR8RTH2SIzFFcylTCj2M9gQ+0qRJa3A5
 Nyt5DAQBU1Suvas6B0YQMHa6h/oODQDU5c6BcmRLwWvLEhe65j0rIemNgpLdOfujYPAD
 VzvQ==
X-Gm-Message-State: AOJu0YzOj2nS4lDmgnI3LSMWm805NMFIsddwN7KFwCYniWxewlhE3SlH
 8wnLBXj9UeZGEy4DsZ4sGX+ZdJXyP30+c19QWBYKFtS5oFxBtDinq+ETSncrjeo=
X-Gm-Gg: ASbGncsKy1veRgqvsfUIrAUvRd648F+ONKbHam+W5XOh21WlhNXauT9lNiy9l1XN9Pn
 lYxp8oQiTcbnZs4ulWnTI7ciPlNWh7bow5R8qlB7OZi1gijZawwBIHe/NRwoWrnOMcfOyNLlZpJ
 GDndlyIJV5/5q54l+O2A65n0iVLb8wdN2wY5pjkvwJR11icTtG0bBDjDlKf35XdfOD1U0HgJdeH
 qyU7eCxMqyyiPKz5gQl7r8x4P0fflYbzS6kHGSuke3f0X3cvBvM1fFkpuSDISAhW2CRdl091gt9
 fbA3ceaLleosaLI2vojNnq7ZN75UjxM7bnIlGy3AkwQ=
X-Google-Smtp-Source: AGHT+IE286dr+KewM/puFLZy4CoXN+x/si9DeXvKcG79SALrGKXdNyvo37SFoO45KD8N0Q8/gvURPw==
X-Received: by 2002:a05:6402:4301:b0:5f3:4665:bfa5 with SMTP id
 4fb4d7f45d1cf-5f4b770e8c4mr789602a12.33.1744794574928; 
 Wed, 16 Apr 2025 02:09:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36f5056c4sm8402555a12.62.2025.04.16.02.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 02:09:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 859DB5F846;
 Wed, 16 Apr 2025 10:09:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "jasowang@redhat.com"
 <jasowang@redhat.com>,  "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>,  "kevin.tian@intel.com"
 <kevin.tian@intel.com>,  "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,  "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH v2] intel_iommu: Take the bql before registering a new
 address space
In-Reply-To: <20250415153207.372427-1-clement.mathieu--drif@eviden.com>
 (CLEMENT MATHIEU--DRIF's message of "Tue, 15 Apr 2025 15:32:38 +0000")
References: <20250415153207.372427-1-clement.mathieu--drif@eviden.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 16 Apr 2025 10:09:33 +0100
Message-ID: <87plhccw1e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com> writes:

> Address space creation might end up being called without holding the
> bql as it is exposed through the IOMMU ops.
>
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>  hw/i386/intel_iommu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index dffd7ee885..3df7a7489b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s=
, PCIBus *bus,
>      vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, &key);
>      if (!vtd_dev_as) {
>          struct vtd_as_key *new_key =3D g_malloc(sizeof(*new_key));
> +        bool take_bql =3D !bql_locked();
>=20=20
>          new_key->bus =3D bus;
>          new_key->devfn =3D devfn;
> @@ -4238,6 +4239,14 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *=
s, PCIBus *bus,
>          vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
>          vtd_dev_as->iova_tree =3D iova_tree_new();
>=20=20
> +        /*
> +         * memory_region_add_subregion_overlap requires the bql,
> +         * make sure we own it.
> +         */
> +        if (take_bql) {
> +            bql_lock();
> +        }
> +

Using BQL_LOCK_GUARD(); here will auto clean-up as we exit and it
handles the nested BQL state as well.

>          memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MA=
X);
>          address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root=
");
>=20=20
> @@ -4305,6 +4314,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *=
s, PCIBus *bus,
>=20=20
>          vtd_switch_address_space(vtd_dev_as);
>=20=20
> +        if (take_bql) {
> +            bql_unlock();
> +        }
> +
>          g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
>      }
>      return vtd_dev_as;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

