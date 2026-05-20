Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39C5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgeA-00044I-9C; Wed, 20 May 2026 09:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wPge8-0003zI-1H
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wPge6-0000q6-Ln
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779282453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0qONi2b5od3B1XF03QbJSVKbR3gZRZzbNR/k9BVOeY=;
 b=YyyCBo4e8XE4fb5AL7HadcWAW4rKw7kW0Aq5CqH9AIMDJdir7hV+NYPR0CiOZF0+aArCE/
 n7ip9nzQugLLSJWvxz/UJ03caBdLMbyfgymWgAF5VdMt7yI8AP6HACi+Ve3s0opXfRXn4Q
 12emcpa4GVRCNimjB4ZYptrI6A/golg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-DS7KItlMNq-ucuTD4GpJSw-1; Wed, 20 May 2026 09:07:31 -0400
X-MC-Unique: DS7KItlMNq-ucuTD4GpJSw-1
X-Mimecast-MFC-AGG-ID: DS7KItlMNq-ucuTD4GpJSw_1779282450
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48ff0eb77b5so46985175e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 06:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779282450; x=1779887250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0qONi2b5od3B1XF03QbJSVKbR3gZRZzbNR/k9BVOeY=;
 b=l4ym1jCJCkgt6oJDDVmfS5zM5lEv5BgCASwXMkot5R8vx4EhhczbWJ59SumNEtB/6k
 vQwY5hgZaZkgnMI/n+PATXhABk1BKjor2fVsbg+yvVgqyY0KUZoR7Zq6P1ZgSJP1Oror
 411Uo7sRp45FK1jdUAs0FiDtRh3DCXeOZypPKV6GDopYFExGjZBSCtVgLvrkkefp0Sk+
 XCiIVgpVFNJwPaivD1eGVHAuDQmZUKOWxM25g0aG7rAJR47zhxNUWcHLDvbR4GIyNdSz
 jeFvJ2IiLi/0nDXmCoYoHgRq+lQ2sQAaD7VxUJVNCxOQ0mYs4oj83zyTu8+YdXP65ZvW
 ArYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282450; x=1779887250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M0qONi2b5od3B1XF03QbJSVKbR3gZRZzbNR/k9BVOeY=;
 b=V7Oz4AeXaRo//Hd3zipYv+s//s0zK/MLBazqM/1hq1IpOS5hz90jKflxVkTKftj8nc
 vh0sugkQ3ozO4y5OmHx3kAih9Al+Obwjh2KSXfiqBXZUYwHUUrZ8Qy6Y4damcMCc8pmr
 zzG+QOhqhmiV0AdqyxHjlQ10+IyAgKwNbJiM7D4g+IrpJ2X5MnJrJVad7CLXGqiAV1UH
 UqQ5UhfX82LItxa27mMCVmmEtn4dNkqMUFLLExLNDrspF0M25uNaSEeeK7xOxA9dSLBm
 Bw6ioZCYY06q9Q/sT4TXyC8agjwd5phq5IbCZRKr1lcb9DBEC9sJTi4FHhK3w4iuyIug
 Vo4w==
X-Gm-Message-State: AOJu0YyFEjX6mfNhoHZVBEWC9qxiw9hEsI9TkbPN7nfczlPESbUCc123
 HzpLd2sDHgT2C/WTi2ZK5fiZg3JfFV7bLrdMBH3PG5+cq/U+xpxUBNtrFs/CEf0ysUctVvjFxiz
 1KcIx9BZBDaxXnaoFvAbvXXdIDhofcliM2702fL/yIb9t7CLh/MACRngQ
X-Gm-Gg: Acq92OHWQcgFMz67e0HvCz1KIss+VW3oksYur0bSeaFup0JP9ds8OoBjQTcGrPOu11d
 KByuXIJRuoEVzCEYaV8bezz3TNiDDoY8qKxihMGD8j0zOazv/+aPcLJdT1/XhuyYlD3NmtQJYN4
 EbhFnDUaMEMpnfv1iXvhQCTxHa+i95FhZieKe5b/HySMgW7iW8xii6Z1HMPAWx7MSnZnQqAhADh
 oI5l1BKlwsDdnv0UyJDiGHDJaL2501LIT2V55jqIjZVJiOkM/3J6ZNsQHJ3GdT0zJWK6KW/aF1m
 w5VOqri4X8iRZiF1KVDiewtqHFQDDKPsr5Dr4buZLKSGymoFrxnKl8PY1NKj3orai4f0DfBXyf9
 mFUnEiQ==
X-Received: by 2002:a05:600c:a406:b0:48a:97b6:7420 with SMTP id
 5b1f17b1804b1-48fe6329938mr291551515e9.24.1779282450423; 
 Wed, 20 May 2026 06:07:30 -0700 (PDT)
X-Received: by 2002:a05:600c:a406:b0:48a:97b6:7420 with SMTP id
 5b1f17b1804b1-48fe6329938mr291551215e9.24.1779282450077; 
 Wed, 20 May 2026 06:07:30 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a562dsm54912010f8f.33.2026.05.20.06.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:07:29 -0700 (PDT)
Date: Wed, 20 May 2026 15:07:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>, Andrew Jones
 <ajones@ventanamicro.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 2/4] test/acpi: aarch64/virt: Allow DSDT and MCFG
 changes
Message-ID: <20260520150728.1ed47623@imammedo>
In-Reply-To: <20260520-virt-v6-2-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
References: <20260520-virt-v6-0-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20260520-virt-v6-2-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 20 May 2026 18:56:31 +0900
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:

> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf4..efb00724d09f 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,12 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/DSDT",
> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> +"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
> +"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
> +"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
> +"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
> +"tests/data/acpi/aarch64/virt/DSDT.topology",
> +"tests/data/acpi/aarch64/virt/DSDT.viot",
> +"tests/data/acpi/aarch64/virt/MCFG",
> 


