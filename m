Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F72C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2V3c-0007iq-SA; Fri, 04 Sep 2026 10:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2V3b-0007iY-QQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2V3a-0000p6-2K
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788532696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2S2IGDbSTnytqN/odEptApJDQpbUyn6mWZpgMBv0s4=;
 b=Wn6HpHYeKxiw2TRv2OYRe2Nc2C+8gIhv2al3613mvmBbXuXD31FDTr8A3MIzB8SSudZuKW
 DoBZbrCR9jdSFYTpWr6WhNG0lgj9H+PffhCCqTErVUTmRpef17zWtllTO3aEHn3O+yA6Lm
 uCdFI2A3qvnCyLPYMHqlgQmetwp/HU4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-HXPvgIUyNPiVQ1qa6KQ7lg-1; Fri, 04 Sep 2026 10:38:14 -0400
X-MC-Unique: HXPvgIUyNPiVQ1qa6KQ7lg-1
X-Mimecast-MFC-AGG-ID: HXPvgIUyNPiVQ1qa6KQ7lg_1788532693
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4858e4b3e92so232214f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788532693; x=1789137493; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B2S2IGDbSTnytqN/odEptApJDQpbUyn6mWZpgMBv0s4=;
 b=CZQLzODoPwOd0RkZ7e+bzKasZXdyXkGqGeCH+WzBhpLkA5zvJyJXiUq3DJ4VHBybpi
 GPEh/EprVCgCz9s/LYL1U4oQvieiLFBuoFF0+mX8+qsn6Bq6aA7cl3Ta6t3Y3gKAyOfJ
 LBVdKKoZmWdkgumFSgVyJv9JgHCgk4cLOCmJfybCvPfzpAW80sCx4eGNw0teMRHmLihW
 DSS7Gzn/WH4ZllZM7Epv4UNSVXxgcK96lXwPe1vTmelnXI2cCg63bmu6qQf5RuHamjJ9
 FdwilB4qd4Mvph21SCaa9NuWmIsymvU1V9IdBeqhkinNZ5+CVevGFsprNZab6YT3++S6
 Llsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788532693; x=1789137493;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B2S2IGDbSTnytqN/odEptApJDQpbUyn6mWZpgMBv0s4=;
 b=CwOv4UN2tudcgRozPnaA3BHh4SkDTEucGJ2lt+PZiaNOrKjRwN4Td0rr9WjjIKpzZC
 vxaVNdV1uCiYn+/XLF5vDfYHwzAgd8YFzvnrspWAhzBDzsegUifmRaAyA3kXw7TIJvlW
 ++JdQ1SgsqLxQzAEHiZ0TpWpbaB6nkrZvdWd47g6YaBuGsev1BpeUy5WeVDtFOEz+Dey
 3QhYD+P6oZego02ARjEEcmT8HeGnwRvft9Y2RsR2QNJqpkBU4KwpyOvTjSlfkO7o1ISc
 md3br834peDCTh5jiBBWDDFu5I6HfMYo1LB6l7MSPyZQTObfyyU/UG9z9t10sxejjhQs
 sFMA==
X-Gm-Message-State: AFuF++nGcQQnkCLCgH6FuJ5dH9ks+hP7hoHH5GR5LXZqpRfKaRLxEz3R
 AJalBgJTzN41aVsHhTGLzq2ESHZjixP5fb6cI76J1O09Iw1SXVcu3EWa8J9xQhxye6JKMZnNaOF
 iB83iRxmaOGOBG6bU1Re4MB88Gum+XDNoHid5hCJ+xHLggN9BH+EXcN9V
X-Gm-Gg: AYBFou24ekgV68dCVwid1p+6vmPvmqNjYlhztU1RqrQ4U2NGaLl6SYdbVxMKSi9rnPk
 EgZ0O6NEyAvj/6ESRBSBbZljAvhJjbl9ncVal0QkOg1F90q4LQNK2C2/kVoR1dvPAUbsOdYRDw9
 HXiaaCJc3+K87bd/OQF9JkUbt3OtuHM9jpCT+2qhUv/Hxxxzp4wV8//Gr2jwlC+G6OqC3ytnUz7
 DNBbURo4U71O+P7VgeGOQBfQwVqvMzpLR1l3uqFlHHaoE0XO00MjCKGN6JqGlaOot0CP5YjkVcB
 FSP69WS8PrCDSLHkxBlwiAulcfEz6wwRyh9CXuNYZe8rDcVjgEvwRN5coiTjBOBWJyFP3VoQpo0
 paqBin6kA3+kHIgRFzEY/YEY=
X-Received: by 2002:a5d:5f47:0:b0:484:3a16:cc58 with SMTP id
 ffacd0b85a97d-4858707f11fmr7759054f8f.2.1788532692359; 
 Fri, 04 Sep 2026 07:38:12 -0700 (PDT)
X-Received: by 2002:a5d:5f47:0:b0:484:3a16:cc58 with SMTP id
 ffacd0b85a97d-4858707f11fmr7758935f8f.2.1788532691305; 
 Fri, 04 Sep 2026 07:38:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883953cfsm5770767f8f.13.2026.09.04.07.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:38:10 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:38:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, devel@lists.libvirt.org,
 Fabiano Rosas <farosas@suse.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 7/8] docs: deprecate virtio-crypto
Message-ID: <20260904103743-mutt-send-email-mst@kernel.org>
References: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
 <20260824-fixes-for-11-2-v2-7-352c6b890402@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824-fixes-for-11-2-v2-7-352c6b890402@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 24, 2026 at 04:24:54PM +0100, Alex Bennée wrote:
> We have outstanding guest exploitable bugs in the code which is fairly
> complex and needs some serious love to clean it up. As off-CPU
> cryptography acceleration seems to be waning in popularity lets just
> the deprecate the sub-system with a view to removing it in a couple of
> cycles.
> 
> We can also remove the backend code at that point as well.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3625
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I am assuming it will be merged with the rest of it?

> ---
> v2
>   - mention the backend bits (only used by virtio-crypto)
>   - use Gonglei's modified version of the text
> ---
>  docs/about/deprecated.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0c656a968fc..05e4ce8cf16 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -276,6 +276,24 @@ future release. Where no 'dh-params.pem' file is provided, the DH
>  parameters will be automatically negotiated in accordance with
>  RFC7919.
>  
> +Devices
> +-------
> +
> +``virtio-crypto`` and cryptodev backends (since 11.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``virtio-crypto`` device emulation is quite complex code with a
> +number of known flaws. It has never been migratable, so it is
> +unlikely to be used in any serious virtualization setting. Modern
> +ISAs provide on-CPU cryptography instructions (e.g. AES-NI/VAES,
> +armv8 crypto extensions), and the Linux kernel deprecated AF_ALG
> +and dropped its off-CPU accelerator support in Linux 7.2, removing
> +the primary userspace path for off-CPU crypto acceleration. The
> +time for this sort of off-load has passed.
> +
> +As this is the only device that uses the cryptodev backends these will
> +be removed at the same time the ``virtio-crypto`` device is.
> +
>  Device options
>  --------------
>  
> 
> -- 
> 2.47.3


