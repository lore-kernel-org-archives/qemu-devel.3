Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8AACD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Qo-0006b8-Ma; Thu, 21 May 2026 09:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wQ3Qm-0006Zs-Pw
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wQ3Ql-0003Pr-7T
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779370038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=taoyeZO92Lo+Y2zM4lue4L7ITuLtAyqN4pStN57kKx4=;
 b=d3zpIWY+4VYn2MujFBza0us809D6BJs62e+EkcKNmTSX9ajnAyHeoWZKsd37bOEMlQdKAS
 3GAWDDxfO2sUH7tR180GSKLUpztLLTf/NHDx3KtFN7cEa6gY35sXWq0Pi9Wo09Hpx6ae27
 AdAj6tstztvOOVVjf5N8lnB/5PuJG6M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-rQ8vm98cO4CUEcCcj6m3Yg-1; Thu, 21 May 2026 09:27:05 -0400
X-MC-Unique: rQ8vm98cO4CUEcCcj6m3Yg-1
X-Mimecast-MFC-AGG-ID: rQ8vm98cO4CUEcCcj6m3Yg_1779370024
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48d127eb013so28258425e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779370024; x=1779974824; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=taoyeZO92Lo+Y2zM4lue4L7ITuLtAyqN4pStN57kKx4=;
 b=p79rMSRHo7mEpsMV/obZcMwRnVS0awdvSalEPkDE9W1WvS+Bthf3wNWJL0C4X/mVwx
 WOZ1pwSbTca6PkuNYN7kCKyf+h7c9QgImORz5F069VsUrTd7zBIahf0nIOUQgaNfEX07
 lMP3F6+NgIF0TKutGMpp/M8Mht4T4i7UKjd+/lIDWDHAxHDUGlTLWGu95Dlrny5m1MFU
 9E6BR6rwYG4L/K3ukwW7aUt9KIXKIybAZtTEyECgYdhPNuAmmO6VgtgKipep363ZE/0n
 TCUPEl0rZNN52ntogYQOU7bGxxZ3N2iQVrKU8a6h1+XuXUBRMauIbCYiO4NxT8K63FiI
 k7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370024; x=1779974824;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=taoyeZO92Lo+Y2zM4lue4L7ITuLtAyqN4pStN57kKx4=;
 b=O5z10B+NKsT9mvn/dg5jQkxASeg5uJRVdINM55PBgyZYTbnXcOytxbGiWbENLrLZ9+
 ja0qqsAukXHiQuK8ov2viRluRKQ504Dh6eZCYyP5FhgLt8unPpFQI0T0OKLHxqE0bV+g
 j0sE9Znawd2uAdyZmy75rLGruOkjdUXR9d5fSr7/0dylKuVba4JKpdH7VKedP6fiJkQd
 GqHRn8Yk+pEI7r7/43bIJF0mms3EkinIU2YsUz/S56ETy8Ah1MF2cJMBC1G+pO2pqq0N
 d0TVBSbRQx6W5rOuSB5h6NgMEh/awLpdYDv2MkpPTrEpiNwn+r4/Pg/81Czxyy1elJxc
 HWJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ukrFPpqvjm85oLFZa3vxuDfojJcuczrcCx1Z4HylwhA0FK9npeMpasqWK7HH0W9RODifErKOrfE18@nongnu.org
X-Gm-Message-State: AOJu0YznDZRJxewC4md7HFTkuwFndvgtxyYEaZeWbTOaNCgK1/xSTM8f
 LAO+pQe5c9GcD8igt5JaEzTNMiX6koswwWT5Ly6v90DPuiJ8jv7LZSL1WbTiit7KTQLurP4Nrf0
 B9+Uba25dKNDtGNQJVeLOxQTew+Muqtl3gYufd6/l9z/WdJIEuXWVb4H2VBEp9lDJ
X-Gm-Gg: Acq92OGyehgZp3enCetjnEGOct1IjFFL8w2lU+9/jRDdkZHMIVTbegJewr82l/iIArG
 /jJVlNlpM+hq4m4fkiLFHrYu/oQH1hIEkETdz9Bzn17f1+BPfLtNncAoVltcbjoiLpzGWBndCep
 4O9QRZS7kXZXvfkLA5GO9m9NnaqVzgP8gOlKaxr8ikajlIzISpwt7ro6mAbYR59whL23mtgUFAp
 nGX/tv+JhefTNya3tgKynmO5I8uMKfaJNKrCKqe6dadzvu7P6/own5Pmpg8iyQHqK/MrwAH8+eq
 jmQSYya3cQH3ShJewG11foyxcPAj0rRVwASDrwO4WHk3iUcEHdzDtinZLwaTb2OUBjooAJTPMfS
 +/pA4Cjgx0C1KnTLZ67JEaW1IcOQzW7CzU+1sHawaTQXp61Dj9A3xewdgKasjrESCXyFfYjM=
X-Received: by 2002:a05:600c:6c8:b0:48f:f199:79f7 with SMTP id
 5b1f17b1804b1-490360c4820mr25083235e9.27.1779370023737; 
 Thu, 21 May 2026 06:27:03 -0700 (PDT)
X-Received: by 2002:a05:600c:6c8:b0:48f:f199:79f7 with SMTP id
 5b1f17b1804b1-490360c4820mr25082805e9.27.1779370023291; 
 Thu, 21 May 2026 06:27:03 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903cae778asm24857635e9.13.2026.05.21.06.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:27:02 -0700 (PDT)
Date: Thu, 21 May 2026 15:27:01 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, Cornelia Huck <cohuck@redhat.com>, 
 richard.henderson@linaro.org, skolothumtho@nvidia.com, philmd@linaro.org, 
 maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com
Subject: Re: [PATCH v5 08/18] target/arm/cpu_idregs: generate tables for
 Arm64 ID registers and fields
In-Reply-To: <20260519132905.145643-9-eric.auger@redhat.com>
Message-ID: <b6b3f600-220c-0b3c-25a1-5a253ba1d7e2@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-9-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 19 May 2026, Eric Auger wrote:
> From: Shaju Abraham <shaju.abraham@nutanix.com>
>
> Include cpu-idregs.h.inc multiple times with different definitions for the
> X-macros. This will generate tables for all Arm64 ID registers and their
> fields. Additionally, initialize the tables with all architecturally defined
> values. These tables will be consumed by the property layer in future
> patches.
>
> Co-authored-by: Khushit Shah <khushit.shah@nutanix.com>
> Signed-off-by: Shaju Abraham <shaju.abraham@nutanix.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
> target/arm/cpu-idregs.c | 50 +++++++++++++++++++++++++++++++++++++++++
> target/arm/meson.build  |  1 +
> 2 files changed, 51 insertions(+)
> create mode 100644 target/arm/cpu-idregs.c
>
> diff --git a/target/arm/cpu-idregs.c b/target/arm/cpu-idregs.c
> new file mode 100644
> index 0000000000..f79b22680c
> --- /dev/null
> +++ b/target/arm/cpu-idregs.c
> @@ -0,0 +1,50 @@
> +/*
> + *   ARM ID register field table.
> + *
> + *   Builds the per-id-register field descriptor arrays and the global
> + *   arm_idregs[] table.

arm64_id_regs[]

Reviewed-by: Sebastian Ott <sebott@redhat.com>


