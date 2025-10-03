Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D93CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hJU-0001zm-0W; Fri, 03 Oct 2025 11:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4hJS-0001zB-Df
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v4hJI-0006EV-On
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759503775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=py4sVm1HCu3FKSBcbbrwuLexg8MAzuGWhTCknLHeLiQ=;
 b=OH2/e3/St8JhNQ+PW5EhNUp6/iXVPVr9DZhVssaI8Nuktv4Hy518gCtcG/1PgrfcBTE2ej
 LtcdK5AUKqGuPLvOnY02iEjpLNjwHNsQEg0fDIJo/D4WciG7MdYrTsZs9d7Re37NXILOxN
 OqG0poQeB2wrDpwVUAeGp5hIC1npDko=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-eeg4IZXmNbu4el_Ekh-HwA-1; Fri, 03 Oct 2025 11:02:54 -0400
X-MC-Unique: eeg4IZXmNbu4el_Ekh-HwA-1
X-Mimecast-MFC-AGG-ID: eeg4IZXmNbu4el_Ekh-HwA_1759503773
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso9262435e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759503773; x=1760108573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=py4sVm1HCu3FKSBcbbrwuLexg8MAzuGWhTCknLHeLiQ=;
 b=aXJMQ6Hh7WvTr7YrBtSsm5DrbcDD6SkLiUAt6QkcBUMLnkKIPZ7eRwG/bqto7B04Qu
 +GosJ1Wu6w4KbtjNYpB4IjyO7mT26TZ8E4yVybskDKC6q31USTfr1a4btQrZrParYafF
 pc/jF1vW/TOOCawlDc+m0hkSV0N18Ml+KRtj4rq/f7eUHlpIN2BUDj+wj2KVrTAzQcNr
 V2mpSn0eFR5ahVTHb7X/AcYayeef9oql+FZQvcQxp3+79UuJ+q3fDFasRPwNh5ZSftFT
 OP7MBW0GarcScYiaRTEqwBTodGmALUKA1rCTEZz2sDI3PuRJ0UovSZniQUVF5PjptuAS
 A2JQ==
X-Gm-Message-State: AOJu0YzW8HQuFnxr50Gg+xpKRuozmzMTALw1fm5rzLe6GKw76AnVIF0J
 5SMx8IrYBGrtuEiac2YMBSVMP9RP9avV42dCFBgwQ7nYdRFqzkZJeRtjPT19b+BE94tLbWtiHlZ
 SVO16VpgC/BNKrUsxPOm0pORB1mNXcDtpa0wGn759TA9un0EZ4T2vIgj2
X-Gm-Gg: ASbGncvQT+RHy6FDJjSuRrJAXxK7XTHynEkXcL4AW9o7KlL1jl5JVIwl+QJI9v9tnG9
 r89cGc5+DWTvdQJJVwpRGt+p5Qtq4oKu5v+g3JVncnCX0NllYL87/LQ8VNG85nKNDyHAnNtQ48W
 93HIxS/+8GoIPbAGf4vQV9ptsMgVySBHghZSMC09u2DfZOmablGmJNVcskgFJTFvexwB+S33/wd
 N32AWiidkM3mQXJ6Vpn2HxE6+bj7CkvEw4mpy0gZSqRLaCtOnf8m8IykQWUSzSNmUCZhDan6mnd
 TQr0IQNPUUmr1BPUzfyOtJfZZc4rUsunAONI
X-Received: by 2002:a05:600c:4f08:b0:46d:d949:daba with SMTP id
 5b1f17b1804b1-46e7608b683mr10560035e9.4.1759503771198; 
 Fri, 03 Oct 2025 08:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLD9+JbG9S/yKzQRS/YEGM+6BAJi98kzIZZLi8drv4IZ2r9FHhzIkjd36jpkDM0JLRzk5Omg==
X-Received: by 2002:a05:600c:4f08:b0:46d:d949:daba with SMTP id
 5b1f17b1804b1-46e7608b683mr10558715e9.4.1759503769147; 
 Fri, 03 Oct 2025 08:02:49 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723431d0sm39581195e9.5.2025.10.03.08.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:02:48 -0700 (PDT)
Date: Fri, 3 Oct 2025 17:02:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: salil.mehta@opnsrc.net
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
 eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
 wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 shahuang@redhat.com, zhao1.liu@intel.com
Subject: Re: [PATCH RFC V6 10/24] arm/virt: Init PMU at host for all present
 vCPUs
Message-ID: <20251003170245.75ad2405@fedora>
In-Reply-To: <20251001010127.3092631-11-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-11-salil.mehta@opnsrc.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
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

On Wed,  1 Oct 2025 01:01:13 +0000
salil.mehta@opnsrc.net wrote:

> From: Salil Mehta <salil.mehta@huawei.com>
>=20

...

> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5eaf41a566..2ee202a8a5 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -602,6 +602,63 @@ extern CPUTailQ cpus_queue;
>  #define CPU_FOREACH_SAFE(cpu, next_cpu) \
>      QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus_queue, node, next_cpu)
> =20
> +
> +/**
> + * CPU_FOREACH_POSSIBLE(cpu_, archid_list_)
> + *
> + * Iterate over all entries in a CPUArchIdList, assigning each entry=E2=
=80=99s
> + * CPUState* to @cpu_. This hides the loop index and reads like a normal
> + * C for-loop.
> + *
> + * A CPUArchIdList represents the set of *possible* CPUs for a machine.
> + * Each entry contains:
> + *   - @cpu:        CPUState pointer, or NULL if not realized yet
> + *   - @arch_id:    architecture-specific identifier (e.g. MPIDR)
> + *   - @vcpus_count: number of vCPUs represented (usually 1)
> + *
> + * The list models *possible* CPUs: it includes (a) currently plugged vC=
PUs
> + * made available through hotplug, (b) present (and perhaps visible to O=
SPM)
> + * but kept ACPI-disabled vCPUs, and (c) reserved slots for CPUs that ma=
y be
> + * created in the future. This supports co-existence of hotpluggable and
> + * admin-disabled vCPUs if architectures permit.
> + *
> + * Example:
> + *
> + *   CPUArchIdList *alist =3D machine_possible_cpus(ms);
> + *   CPUState *cpu;
> + *
> + *   CPU_FOREACH_POSSIBLE(cpu, alist) {
> + *       if (!cpu) {
> + *           continue; // reserved slot for hotplug case
> + *       }
> + *
> + *       < Do Something >
> + *   }
> + *
> + * Expanded equivalent:
> + *
> + *   for (int __cpu_idx =3D 0; alist && __cpu_idx < alist->len; __cpu_id=
x++) {
> + *       if ((cpu =3D alist->cpus[__cpu_idx].cpu, 1)) {
> + *           if (!cpu) {
> + *               continue;
> + *           }
> + *
> + *           < Do Something >
> + *       }
> + *   }
> + *
> + * Notes:
> + *   - Callers must check @cpu for NULL when filtering unplugged CPUs.
> + *   - Mirrors the style of CPU_FOREACH(), but iterates all *possible* C=
PUs
> + *     (plugged, ACPI-disabled, and reserved slots) rather than only pre=
sent
> + *     and enabled vCPUs.
> + */
> +#define CPU_FOREACH_POSSIBLE(cpu_, archid_list_) \
> +    for (int __cpu_idx =3D 0; \
> +         (archid_list_) && __cpu_idx < (archid_list_)->len; \
> +         __cpu_idx++) \
> +        if (((cpu_) =3D (archid_list_)->cpus[__cpu_idx].cpu, 1))
> +
>  extern __thread CPUState *current_cpu;

make it a separate patch and refactor existing loops to use it.

> =20
>  /**


