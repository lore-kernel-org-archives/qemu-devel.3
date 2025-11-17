Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F35CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKw0D-0002QR-Lk; Mon, 17 Nov 2025 04:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKw0A-0002Q5-9C
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:58:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKw08-0000Pv-2h
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763373502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mv+ABs1/aqXKwYa9fnN8KDfkMvmLi7ermffaowrPFDI=;
 b=Kvs/geW6neyyctLel50jBmYmqVFOdQVlfBMX0VIIL8hsxpUcIX2HBQwHpNHD33KUA9yw0u
 ZXkrCVoyGseezKnu/OApUavD8dj/H9FkRTsiaBuRik3F7Z5ibyY4TJBqso8AAtTSSn1YrZ
 0za0RQAiHY/OODvPzdg9wOFDk5gBsuQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-BEoFJXW7McupWZgGYhlRBw-1; Mon, 17 Nov 2025 04:58:20 -0500
X-MC-Unique: BEoFJXW7McupWZgGYhlRBw-1
X-Mimecast-MFC-AGG-ID: BEoFJXW7McupWZgGYhlRBw_1763373499
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b2fb13b79so1917384f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763373499; x=1763978299; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mv+ABs1/aqXKwYa9fnN8KDfkMvmLi7ermffaowrPFDI=;
 b=QRnUwKax7Buih/0PoD26aJJ8lW+wdM1dmobrUCrXpwkI9nIBi+5JwtAhSZ7au7sJch
 fqCg8VcrAgM00aBxOZMZ/MOChyFSzdHnjj+pd7YgScvJ96INL6zV9cwHt4rXhQD1Kyvb
 u2vU9AGn14jasPqJvzxc9FxdHP6ewWWkpxqva43EvEll3aiPFtijqvw0SaHF/rKueyO1
 iVMPCl5Uk1gm2WHtqeS5MxmTx42kLf0VzHHmyWhj45I9TqiA2317diPjnyH7Znj0lHFL
 Cnn1qAtnTJA+0THkNeAa1dcTUptv050mR+qqKURMqV7dF0rlWlwfMs1A7JTX6n8w8rlA
 cx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763373499; x=1763978299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mv+ABs1/aqXKwYa9fnN8KDfkMvmLi7ermffaowrPFDI=;
 b=Oju/u4/ayCVWkorszWezN96YI1o+4drauU1e8XeGf6pVb8AKjzKtATsGLeicq6OfuV
 BI5Xn9a3g4j7W5s+VC8gW+2X56uzG8kJSqXD4z3s0pzNWP9IdEuQ9bbzoVK5M0JAeIAT
 urJU30YB5KgT8sqqNnsMZfEreDlZ3J0iN4fPptmDOF448S8A3WvyApQ1x0d/DP3kFBaA
 av0QaDaTN0m5Qqyt1Cb85OWF6nAQErA3Xa8ckphy3SrUaxVrJXJXGgi3RgY/95Mhcpnu
 duEvv2x7vx8H6291kxAzw2RNJ2MhfiSo0+jm01mU2CvCg7v/gbTsjUXC/meogwSaEKg5
 O1Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdzj4mF4l/936lha/ukxCtIpbbUfYHDyIKBAUu+MZd8iSb/TsTzv3dFJyP4UMUZ3/hjITHM3MTu/Vu@nongnu.org
X-Gm-Message-State: AOJu0YwUNpq3SW+fZESPC/yjd14bOYsxiI6I6xTC9LTZWGwOUZWtPEet
 uipqpVpVOBCR0V47ZnTcn5UU4DP/9hxX1YLdNsr3zdyEa/pazWLLzXvVuLlfHTMMJX7tbPt5e/E
 4V6sLocKMfLQQ1qfmFKUS24YaY00V+ivm2pZi3aLo8Re7XHXBJjqcTYIkEMY1K8L9
X-Gm-Gg: ASbGncvzRL7BZqDcVBWyV9V9LAlwI1PcOUyvUHJlHhv7Fo8lTBGchSVWbIIZfBUBRfN
 HUDfFpbYYV0S5chrleljQ7fr/tXqsQ8tkuWOMT0Kbr5mw80yFoSrHu6lkiROXF06He241PNCjQm
 GvA0m7z7+98TTKq6LQjfY3ULA5qktwmRKxZwjHWHF1RsAfszutFjaU458JzWPAHX/IhyT8GEcxI
 g4WbXc/hXIQJbOIw25eoNcmtBDL/FWfsNnFJi9vYO6yaBy1E1EsQEDFIKFudx396HtMA9TDrh0M
 qlPqa9sexPMHFV1adf7FRfBw0hp+rZw/9IiwmV+RoWwXFJewKjMSZ4gFBm1JZiLeMu8NxR8Ip8G
 6dGfT7f842ZiVH+yuikM=
X-Received: by 2002:a05:600c:a49:b0:477:55c9:c3ea with SMTP id
 5b1f17b1804b1-4778feaa94amr95560595e9.35.1763373499203; 
 Mon, 17 Nov 2025 01:58:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUAGkKB3PJ0ez/r6G8ofkqaQVy8V1bxLdxogwN5gAPLflGK8si6AWTCXMhsuNoie48HG1+MA==
X-Received: by 2002:a05:600c:a49:b0:477:55c9:c3ea with SMTP id
 5b1f17b1804b1-4778feaa94amr95560255e9.35.1763373498459; 
 Mon, 17 Nov 2025 01:58:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779527235esm158593855e9.8.2025.11.17.01.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 01:58:17 -0800 (PST)
Date: Mon, 17 Nov 2025 04:58:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fabian Vogt <fvogt@suse.de>
Cc: Gabriel Somlo <somlo@cmu.edu>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2] firmware: qemu_fw_cfg: Do not hard depend on
 CONFIG_HAS_IOPORT_MAP
Message-ID: <20251117045307-mutt-send-email-mst@kernel.org>
References: <24142953.6Emhk5qWAg@fvogt-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24142953.6Emhk5qWAg@fvogt-thinkpad>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 03, 2025 at 03:11:05PM +0100, Fabian Vogt wrote:
> Some configs have CONFIG_NO_IOPORT_MAP=y but support qemu_fw_cfg over
> MMIO. Currently the qemu_fw_cfg module can't be built for those as it
> needs HAS_IOPORT_MAP=y for ioport remapping.
> 
> This patch allows to build qemu_fw_cfg in those cases. If
> CONFIG_HAS_IOPORT_MAP=n, qemu_fw_cfg is just built without support for
> ioport based access.
> 
> Signed-off-by: Fabian Vogt <fvogt@suse.de>


Thanks for the patch! yet something to improve:


> ---
> v2: Guard ioport_unmap as well, which makes it work on archs like arm64
> in the !PCI case. Unlike arm, arm64 has no stub for ioport_unmap.
> Reword description.
> 
>  drivers/firmware/Kconfig       | 1 -
>  drivers/firmware/qemu_fw_cfg.c | 7 +++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index bbd2155d8483..91442f85f0f0 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -122,7 +122,6 @@ config RASPBERRYPI_FIRMWARE
>  config FW_CFG_SYSFS
>  	tristate "QEMU fw_cfg device support in sysfs"
>  	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
> -	depends on HAS_IOPORT_MAP
>  	default n
>  	help
>  	  Say Y or M here to enable the exporting of the QEMU firmware
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index 0eebd572f9a5..fa4385339824 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -204,8 +204,10 @@ static void fw_cfg_io_cleanup(void)
>  		iounmap(fw_cfg_dev_base);
>  		release_mem_region(fw_cfg_p_base, fw_cfg_p_size);
>  	} else {
> +#ifdef CONFIG_HAS_IOPORT_MAP
>  		ioport_unmap(fw_cfg_dev_base);
>  		release_region(fw_cfg_p_base, fw_cfg_p_size);
> +#endif
>  	}
>  }
>  
> @@ -258,6 +260,7 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>  			return -EFAULT;
>  		}
>  	} else {
> +#ifdef CONFIG_HAS_IOPORT_MAP
>  		if (!request_region(fw_cfg_p_base,
>  				    fw_cfg_p_size, "fw_cfg_io"))
>  			return -EBUSY;
> @@ -266,6 +269,10 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>  			release_region(fw_cfg_p_base, fw_cfg_p_size);
>  			return -EFAULT;
>  		}
> +#else
> +		dev_err(&pdev->dev, "IO region given but CONFIG_HAS_IOPORT_MAP=n");
> +		return -EINVAL;
> +#endif



I do not like ifdefs spread all around the code.

Don't these arches provide stubs so fwcfg can just
have same code, with ioport stuff eliminated by compiler?


If not, stubs can be added to fwcfg as last resort.

-- 
MST


