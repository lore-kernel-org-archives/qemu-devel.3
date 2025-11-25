Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC31BD0E6C1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqHg-0002je-Ti; Tue, 25 Nov 2025 05:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqHY-0002ea-BV
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:28:24 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqHV-0005iU-1K
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:28:23 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64074f01a6eso9436809a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764066498; x=1764671298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wp5/syD0+o/LyjTyIR4uS8V1NpnQlWuYtR2o807A2NY=;
 b=ZyGNIV/64luhW+Jvw0ykbDagf59cmqbQURW3sYkniBuAkuVu0878MJOg5hUp8jE1GC
 BujaMB7WBWpVvHtNlV+ZiJG6Pd7b5zmP1vEfW1heIrWF2EIEiglNxROjDGFV4hO8F6VH
 hEK7S+FEbgq2wX5TUUjN25vX/wWCDTbIQ/+BBDfjYmCzyxB0WBcMEPA+P255DPz85JIW
 piP+ZHpZoIjOwfhhGjxPXCEXPJDyuplYiRvMFqLjJ0SMmA6lVzhJAYjTVC5Wkts2jE3G
 QjV0y0T/iXM/I6rcVA2TtX/49nB6pNZ/Ezi5cng5e1R8NENSh4GDkolytedtZnPe9BIj
 t8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764066499; x=1764671299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wp5/syD0+o/LyjTyIR4uS8V1NpnQlWuYtR2o807A2NY=;
 b=LBRLRgl2APJ5/myk6aDom9kLleFBBUcvFP5tusl/EZfNMIHq2ZT19T6gOUGQzmlsxA
 /MUzqE7FiG2a0KGuNONB0km8e4VwiFKBlxAOdeZJSlf+FWYJjL5QQqIG3oP7NAjSyQfw
 IQsuVg9WINQHUU4f7rx/ibBJemgdp8Rk1SckDiedTNNa0WWc0CDwT7AdtLrPq7/jTenx
 TNvx5ApBJAgriDwRRUJdB0xD7pD4fXr4CPHlFHsE2CGvVYApi4hESgaK9B42Nd9XIkWz
 Kzaa+aEUitnjmh95Gtk5VDisnlJeXr59Cc/4cZMUIjl/lm5noDjGSNf7MZm2TnhKFDva
 Rn2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiGIe2BHTv68BMGT00bcplk+k6JKBGh2gahPGVHWps3t3yoh8R1Ahh6OYnVTMmN1folHrvCnsi6Hlt@nongnu.org
X-Gm-Message-State: AOJu0YzSjInX3pmvUyeSP3jDJ3JiZBW0JGkLNT00zStu3RuoR8X1kdqV
 HsWyPfjDMFJTXVKt3QphzRZBuFN+AFA2En3cqsTy7bLi6WYGauVKkZRdVr/Era4SdZayxZrD2zN
 wyKmshExK2A==
X-Gm-Gg: ASbGncvZuULeRMqnlN7zmKaGxLWOSyz7SfxoroNd3h+qc7ctvz17oYk7tdvdv3S+A1o
 yC45yvwkzUwomtPVx0tEWujfNtyE7dYixkfaVHYiAmKycNU/qOuHBiHVehTd/thU/JBfLuDRXsO
 wPrXkx2tJ9IBnOruB/8LvKIOIzMd7LA/at4k5Gxv/n0p3uqAbvNrfB25u6MafVamNrZsuDK5aE5
 nel5Xsus1VkH6P9INwDPek0gSbp4NTgQKlBqmPrRthEviyTRsja+kq4qOf1RkNUGH1jwCyUA10v
 qUHtAYyBECnOB/hnUHY7PojijV6C9R+6WFInW38DCOqhcQCZNNC0VtrtS/9njggsTCsQXF2K8L9
 Tj+6OmD8nE1iX4nEwkd2LkH1/K4FC69DGgr+STsRtm9dI2ZUVpDu/ecC1PRxbV/VD3ucl+kPcOv
 zsY5lxoxvQImpakLk2OwIDkNWp9leVx83Id1b9KmFFmC2SHTSVi4vtSQ==
X-Google-Smtp-Source: AGHT+IE3PKjG7rNMmUMO0u0YPkOHg97YVfk6tokccVI/wtgGNpt9SgcH/ClnqkI9yxamQKVM5NvRXg==
X-Received: by 2002:a17:907:868f:b0:b72:5fac:d05a with SMTP id
 a640c23a62f3a-b7671a47ae8mr1360006666b.37.1764066498581; 
 Tue, 25 Nov 2025 02:28:18 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7654fd43b1sm1532571066b.38.2025.11.25.02.28.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 02:28:17 -0800 (PST)
Message-ID: <a5388c93-124f-42ac-8881-3cae4bb620c6@linaro.org>
Date: Tue, 25 Nov 2025 11:28:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] error: Use error_setg_file_open() for simplicity
 and consistency
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net, alex@shazbot.org,
 clg@redhat.com, peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 dave@treblig.org, jasowang@redhat.com, samuel.thibault@ens-lyon.org,
 michael.roth@amd.com, kkostiuk@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org
References: <20251121121438.1249498-1-armbru@redhat.com>
 <20251121121438.1249498-11-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-11-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 21/11/25 13:14, Markus Armbruster wrote:
> Replace
> 
>      error_setg_errno(errp, errno, MSG, FNAME);
> 
> by
> 
>      error_setg_file_open(errp, errno, FNAME);
> 
> where MSG is "Could not open '%s'" or similar.
> 
> Also replace equivalent uses of error_setg().
> 
> A few messages lose prefixes ("net dump: ", "SEV: ", __func__ ": ").
> We could put them back with error_prepend().  Not worth the bother.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/9pfs/9p-local.c        | 2 +-
>   hw/acpi/core.c            | 2 +-
>   hw/core/loader.c          | 2 +-
>   hw/pci-host/xen_igd_pt.c  | 2 +-
>   monitor/hmp-cmds-target.c | 2 +-
>   net/dump.c                | 2 +-
>   net/tap-bsd.c             | 6 +++---
>   net/tap-linux.c           | 2 +-
>   target/i386/sev.c         | 6 ++----
>   util/vfio-helpers.c       | 5 ++---
>   10 files changed, 14 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


