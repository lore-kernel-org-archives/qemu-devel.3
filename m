Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CD6C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9Eo-0004Jr-8i; Wed, 15 Jan 2025 14:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <somlo@andrew.cmu.edu>)
 id 1tY9Ef-0004JH-5E
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:39:29 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <somlo@andrew.cmu.edu>)
 id 1tY9Ed-0002O6-7p
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:39:28 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7bcf32a6582so6402085a.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 11:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmu.edu; s=google-2021; t=1736969965; x=1737574765; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=get4de+uPTAxdb+Tpx9fkFPkWi0H6NHzrboHxxxBysQ=;
 b=XV1l6ZByyxlE4nvLZpoHlWA1KNHBf37/3/giH1anX5FyBkDsPn+hkHFBovfPFzXiMi
 hIOwY+DdBY2XGrctVVGUTlxufyn7N2IkrKD9F21IW/NqdVW4tNqSuiafVskT2CuDOZMB
 ZANyr8UANQhnND3SJN8lYghNEGQBssn5xVd2I5GGe98KHWNVGztFFNSu0JIw4EXULhyi
 2+FES7nDMaCnufrFyYeJqWD0b6eiRmkLs0Du+Q25VIeisSzr/XXbLPx1ykd8bpzuxpqN
 bWQoXFM7ZePRcsV4KYX0zK3iUma9/uW03JHbKMLPPoT/uRsEccJne0AY4FwmyLq3A6cB
 nsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736969965; x=1737574765;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=get4de+uPTAxdb+Tpx9fkFPkWi0H6NHzrboHxxxBysQ=;
 b=m0wAvnwaBxe4/TZFll/8goVpa7Ugo4n3Eul2+fk7+WcTKG35oI196k+nGwODVfhW7d
 t8H6oSrMLjckSFn97RYhe6Gm2heRid2nL9ZrqAXiWPEbEmgIdb/T2G+36aDTwe0pHe9L
 OzVqFbFleSPasGMbj2Gl+mMoQYnx6oTkTPc4dJWV+ZqPRMmCRXxK3JM2T/TgN70pUVLz
 ieRIgGl8G+HPmmgI2Tsts9+KYM2IF15ptBCl64Hub4MRrv8myY5j4CfxJjN84vA62FOX
 Ec/lAQqslVdaU+a1heizyZFGe1bm769Q89AyrS8SREQ11k6NrKUqDsPb5wj3/yCLPt90
 tpQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4LvnSQxQhLdgWmP/3ddJIfTr4l31BXNZeiFNn7H53MpEtWdqy29vY00teWxZNUVRqqJCW43WEFaNA@nongnu.org
X-Gm-Message-State: AOJu0Yytu82jRwvTOk8WCRz6N3V7ZT1r8MLBKKHIytzrPIAd9koda2/E
 0PiWUqZW7xHQrAOiFBEHlXZJACZSBVuGGYSDUlkTydlAW0bM18dld6KXce/ikg==
X-Gm-Gg: ASbGncsxldKfx3VvAUbgxVsOTVgMeTJ8sKav6Kk+AqqFW+IN0B3lj4QBJYzPDsWPWHv
 khuKQ4rATFqvmDPsflAfNBgfCAUNlPGf5zWWDX3UwjKogOuhTim2AX7GLxqKu4n9T2BK1LeqGcV
 NIj8cPrl5+DZae5R1N9+BEfrGAK/IrOzKlrqEljcolaT1CGE+QtM+BqGb2dWRXfcy8eoti7dkEr
 j3/U0sGWlU7lfZe79k6KpqPlFRPJR5xWT9TqGl83cC8RR/mmW9RQfov843z9mVN7LnkkHIo98c5
 vu5WON1JO2GC
X-Google-Smtp-Source: AGHT+IH63zRB2cdFw6V/85DU3mhEk2WaJkqMz4exd8TKlqrjPFIRl/hw/tMrGiNm2EiFQY5Kq2sUFQ==
X-Received: by 2002:a05:620a:2954:b0:7b6:91a4:845b with SMTP id
 af79cd13be357-7bcd9746116mr4097903585a.15.1736969965295; 
 Wed, 15 Jan 2025 11:39:25 -0800 (PST)
Received: from glsmbp.wifi.local.cmu.edu (cmu-device2.nat.cmu.net.
 [128.2.149.252]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade73212sm67764926d6.80.2025.01.15.11.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 11:39:24 -0800 (PST)
Date: Wed, 15 Jan 2025 14:39:23 -0500
From: "Gabriel L. Somlo" <somlo@cmu.edu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qemu_fw_cfg: constify 'struct bin_attribute'
Message-ID: <Z4gO6-WLpIwBTqhn@glsmbp.wifi.local.cmu.edu>
References: <20250114-sysfs-const-bin_attr-qemu_fw_cfg-v1-1-76f525a3ee72@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114-sysfs-const-bin_attr-qemu_fw_cfg-v1-1-76f525a3ee72@weissschuh.net>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=somlo@andrew.cmu.edu; helo=mail-qk1-x72c.google.com
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

On Tue, Jan 14, 2025 at 10:50:20PM +0100, Thomas Weiﬂschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Gabriel Somlo <somlo@cmu.edu>

Thanks,
--Gabriel

> ---
>  drivers/firmware/qemu_fw_cfg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index d58da3e4500a5e230b7da9a75e4d70df7c38c542..2615fb780e3c4500db36d4746880455f05479f1f 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -460,7 +460,7 @@ static const struct kobj_type fw_cfg_sysfs_entry_ktype = {
>  
>  /* raw-read method and attribute */
>  static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
> -				     struct bin_attribute *bin_attr,
> +				     const struct bin_attribute *bin_attr,
>  				     char *buf, loff_t pos, size_t count)
>  {
>  	struct fw_cfg_sysfs_entry *entry = to_entry(kobj);
> @@ -474,9 +474,9 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
>  	return fw_cfg_read_blob(entry->select, buf, pos, count);
>  }
>  
> -static struct bin_attribute fw_cfg_sysfs_attr_raw = {
> +static const struct bin_attribute fw_cfg_sysfs_attr_raw = {
>  	.attr = { .name = "raw", .mode = S_IRUSR },
> -	.read = fw_cfg_sysfs_read_raw,
> +	.read_new = fw_cfg_sysfs_read_raw,
>  };
>  
>  /*
> 
> ---
> base-commit: 7f5b6a8ec18e3add4c74682f60b90c31bdf849f2
> change-id: 20250114-sysfs-const-bin_attr-qemu_fw_cfg-fa4a95934904
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

