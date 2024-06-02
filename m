Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877DAC27C44
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 13:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDlE8-0007DY-QE; Sun, 02 Jun 2024 09:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDlE6-0007D5-MB
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 09:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDlE5-0004A6-14
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 09:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717334778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fs2L4ZI3+Pq6uOEbo6ScE0OLrewvzJo/KQjvDzupUaE=;
 b=HL1QffpoUSSMgxeLe9IfZWZuAugaEpMuO59irSzDGkrgkAdRZp/rGT10JlMX3g1gC4yWuB
 73JJtfLk/ppuY/Rp2Vpjp5u+JtxfXvw1c0yB7TTIvoJIRMlqenwAXyBN3GJRkYzwRPL2IL
 /4HsQ0bBG4fsEBDiP/fzFIqr+TSXVcE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-PvdcuVh0OtyZRMU4BwIgIQ-1; Sun, 02 Jun 2024 09:26:16 -0400
X-MC-Unique: PvdcuVh0OtyZRMU4BwIgIQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35e0f8bcc3cso1113944f8f.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 06:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717334775; x=1717939575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fs2L4ZI3+Pq6uOEbo6ScE0OLrewvzJo/KQjvDzupUaE=;
 b=GLHb73Vd/wg7t12JxoRGinxCza5FM8ypQYAgCsR8k5Pdm9FUcCZvKLrSkqLa3EaHx8
 iGaZ0gIsTikN5aJKeFbR02gc1eXbHT0emh3M2cWmWm8OekzG/a27iNo5GdKc54PP5M7U
 UZeGbBOIqxUtfL2DLoogYplH5LPSCU7UCq+vpaSST0eInyQTYK5KpbFbenIXjb11pS43
 UN2P6gW/Tvkyyje0NGfhVMHdSkyJLtaMjVq15mzCfFxQ/Ki0nBg6oAAl5VnTLE822dKe
 58roXofOnBXFpR0QErcNZ9o4U1mIaTCphNhmdYX67m1zZES+9h5xR4szofypkaPRfpCc
 zb7g==
X-Gm-Message-State: AOJu0Yz4bmOHTIxl0tME6zfgQfv6l3nriI758lKvn4Rb2ukKRfoJqgmy
 YGlwJln4NWXf5rXTeYy6CoSpHL8y0F20GGk6E2kXwtBm8gIIbMUpzkwPTFODVBIy+kEpvtUxgWm
 myeWwbqQ961voVTzCMg177Ulph/QmmxnL9gCPUkHQmwznRkJrgeXT
X-Received: by 2002:a5d:64e6:0:b0:35e:4f37:45a0 with SMTP id
 ffacd0b85a97d-35e4f3746f9mr3822521f8f.20.1717334774780; 
 Sun, 02 Jun 2024 06:26:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGghlALuc9+RajHj1vx+rvwcU8f6jamlYoDwP2Nm1vFyY3IpFCphSjlgq2bfbfEEfouQYVbHQ==
X-Received: by 2002:a5d:64e6:0:b0:35e:4f37:45a0 with SMTP id
 ffacd0b85a97d-35e4f3746f9mr3822494f8f.20.1717334774207; 
 Sun, 02 Jun 2024 06:26:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064afe3sm6141257f8f.97.2024.06.02.06.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 06:26:13 -0700 (PDT)
Date: Sun, 2 Jun 2024 09:26:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 4/5] x86/loader: expose unpatched kernel
Message-ID: <20240602092541-mutt-send-email-mst@kernel.org>
References: <20240411094830.1337658-1-kraxel@redhat.com>
 <20240411094830.1337658-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411094830.1337658-5-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Apr 11, 2024 at 11:48:28AM +0200, Gerd Hoffmann wrote:
> Add a new "etc/boot/kernel" fw_cfg file, containing the kernel without
> the setup header patches.  Intended use is booting in UEFI with secure
> boot enabled, where the setup header patching breaks secure boot
> verification.
> 
> Needs OVMF changes too to be actually useful.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>


So given we have this, do we still need patch 2?


> ---
>  hw/i386/x86.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 6f75948b3021..6724e408e576 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -1125,6 +1125,9 @@ void x86_load_linux(X86MachineState *x86ms,
>      sev_load_ctx.setup_data = (char *)setup;
>      sev_load_ctx.setup_size = setup_size;
>  
> +    /* kernel without setup header patches */
> +    fw_cfg_add_file(fw_cfg, "etc/boot/kernel", kernel, kernel_size);
> +
>      if (sev_enabled()) {
>          sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
>      }
> -- 
> 2.44.0


