Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4028DCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkCY-0008Sq-Ua; Tue, 28 Oct 2025 09:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDkCW-0008SS-T5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:57:28 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDkCN-0007Jj-8F
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:57:28 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-592fcf7a1ceso5340220e87.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761659834; x=1762264634; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ywkWcUB/bHBOlXnCDPOpcuQpF9M08DR5u7xlF4oebkU=;
 b=VkAe6+lUwhsePmZ+Un0eRQ01irG+LF1YKPJwiX+/H0JZGG9HZi5ekuSbDzq2oNH3GG
 bX8yI4xr9UGdnvIvVsxM6wrBFU39VfnmYXTxekwxy1K+cME+cePAYGSFMLwn3UhBR/wo
 JEYth3rdEOXTr6+MVLEUOfcQ1oYRMEm9jod6evQuu3ZKp6T3OZCwDbaFvopSvEdUpBZj
 Rrqk5MOvI0FbGy62w/+cZuzkuTxICB/9XGrGE85b6QMQ90+dYEeKCHAJ6XF3AdqXuPLM
 4WQHFWHnldq6E0ATScrbCNo5n4lSxF64EHiXQlF8F9Z74rNI2rL3wMiJhApZKOnUt/Ci
 32Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761659834; x=1762264634;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ywkWcUB/bHBOlXnCDPOpcuQpF9M08DR5u7xlF4oebkU=;
 b=LdEIMBWDx3dYpSuDrIYZkLKbipuvyluD5MpzjRUINHqRbnsK8y0kSftdJyUTvlFvQc
 NuQWsmP9XDD5ml6VG/wThL6/ZkYKdNisFdqE7N2egs8fdleceRWcF19SNY6N4kdVNcyu
 uFhPUE3FiOqFsUm6Hq69MwB8h4YyTvHya+RL+M5hUWNfpxaQGpGf9ScAAP9HCw6MN4e/
 zH3WYtryP4pn1GOLFAkDyUEqCwpA01sfg7Ytpxata7a9WuExteIcWsh17bHfW//0ZxAT
 F0VGWbXHui0a3VMy1rdk0jrIPHDFIiQ1j5WzsKidhHJS1e2s664eWAtQns4MnV4XsjEp
 EqUQ==
X-Gm-Message-State: AOJu0Yx//l8uC/d7uwYBDf3eFzKlw+ua4tSyIztk6473pWT7UzPFtsKF
 5u9emQ2eaSiXCYHhmplMiXrDyfKsqWEND7cro4WVCcJMS6RC7sKKcYWM
X-Gm-Gg: ASbGncsTnkChj+sKAIgI7+LbTolaNafCuP06KhBIPzLeEsnj4IDPmPHixOGzfb5RSsi
 F2CvEDHfMO2yc7CgQFrMt7UiFWo10wbnzCqFwyOwG2/iP5nRwfVBFGc/0oBBkPpipN84K5P4aN6
 HSwO92Qbp61siQvLL9Zk+fbCTYOcL6IMwolMFGn5NURPjx8BZaP05MPJLbhPivPLwj50pcy0Vtx
 NvVFxcA7HC1fpkcCV537FYLfq9ez/HqkQXW2f3/Yj0QQhqYmUtVmois7xAzCBVt5HRcB36/xNWg
 fniQXiLFLg7eSWNX5Ej4wZOabLKb7bIIxQRq0Hv5b/xDKYOl41f3pq0Ra5MB4UOOtPAqAGPJVwb
 GfZsD+TUrFFL3Azk/MamZLmMwU1hcI1GqRHM9BVMMz/NiGf312DMcEUPIfRBXE/6V9uJhOSr1yP
 ISK3GacZikPpQlx6RaxRUjum7cYpJ1twP+c9ao
X-Google-Smtp-Source: AGHT+IHhlEhCXWG4JnGYnZ9PlIkPfPss+qjJNDrSomU1aZUyUCzyg6jNNad5EKiHbRdmXz1yu4/PQQ==
X-Received: by 2002:ac2:4f03:0:b0:591:ebc3:a688 with SMTP id
 2adb3069b0e04-5930e9f7af6mr1094572e87.56.1761659833877; 
 Tue, 28 Oct 2025 06:57:13 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-593027d858bsm3005590e87.47.2025.10.28.06.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 06:57:12 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:57:11 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>,
 xen-devel@lists.xenproject.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH 3/3] hw/xen: Build only once
Message-ID: <aQDLt44edkDsfTAU@zapote>
References: <20251022140114.72372-1-philmd@linaro.org>
 <20251022140114.72372-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022140114.72372-4-philmd@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x132.google.com
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

On Wed, Oct 22, 2025 at 04:01:13PM +0200, Philippe Mathieu-Daudé wrote:
> Now than hw/xen/ files don't use any target-specific code,
> we can build all file units once, removing the need for the
> xen_specific_ss[] source set.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/xen/meson.build | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/xen/meson.build b/hw/xen/meson.build
> index a1850e76988..dcd2b7e1df3 100644
> --- a/hw/xen/meson.build
> +++ b/hw/xen/meson.build
> @@ -7,21 +7,16 @@ system_ss.add(when: ['CONFIG_XEN_BUS'], if_true: files(
>    'xen_pvdev.c',
>  ))
>  
> -system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
> -  'xen-operations.c',
> -),
> -if_false: files(
> -  'xen_stubs.c',
> -))
> -
> -xen_specific_ss = ss.source_set()
> -xen_specific_ss.add(files(
> -  'xen-mapcache.c',
> +xen_common_ss = ss.source_set()
> +xen_common_ss.add(files(
>    'xen-hvm-common.c',
> +  'xen-mapcache.c',
> +  'xen-operations.c',
>    'xen-pvh-common.c',
>  ))
> +
>  if have_xen_pci_passthrough
> -  xen_specific_ss.add(files(
> +  xen_common_ss.add(files(
>      'xen-host-pci-device.c',
>      'xen_pt.c',
>      'xen_pt_config_init.c',
> @@ -30,7 +25,8 @@ if have_xen_pci_passthrough
>      'xen_pt_msi.c',
>    ))
>  else
> -  xen_specific_ss.add(files('xen_pt_stub.c'))
> +  xen_common_ss.add(files('xen_pt_stub.c'))
>  endif
>  
> -specific_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_specific_ss)
> +system_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_common_ss)
> +system_ss.add(when: ['CONFIG_XEN', xen], if_false: files('xen_stubs.c'))
> -- 
> 2.51.0
> 

