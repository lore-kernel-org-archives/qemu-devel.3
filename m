Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B182CC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8xEr-0005nC-Av; Tue, 22 Sep 2026 05:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x8xEp-0005mo-UL
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 05:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x8xEn-0007r5-Hr
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 05:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790070991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0DS7F0nuYDd88ee94mxG72j3QEYc+hj8SUXr2AOpk28=;
 b=OYuTC1zjzDWzRYKrSGDAHk4On6jXEOak60N54HoOLhGJ0L/V7xqW40ZWdNFF6fX7Rf9Wlc
 xMmblfldYsES9mGop00eSnTl4kUjNGv4iepc6PxbrMixtV0pOHCWZ/aj34rSvS/XhSWjtg
 Yb6DvjsWeh0rBl2c8lke1mWH7H+kDco=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-bNWEaz_AMl-X1QAFF6WktQ-1; Tue, 22 Sep 2026 05:56:29 -0400
X-MC-Unique: bNWEaz_AMl-X1QAFF6WktQ-1
X-Mimecast-MFC-AGG-ID: bNWEaz_AMl-X1QAFF6WktQ_1790070988
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e823c4868so32019665e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 02:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790070988; x=1790675788; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0DS7F0nuYDd88ee94mxG72j3QEYc+hj8SUXr2AOpk28=;
 b=O7iduHd62m0F30DO95d/roqojvI1IIDXXUE2Rz86L7ajG/Cqmbl2ebals4hWE2vH9T
 2oDW8dBIjeIdwbIn9jQmlip5lrU+/wLybvUUDniE4exHnAMQwTkDN9Ykw6LSXfzwHGTE
 VfqwtAV9Ux8X49iOXPWtP3MHAFzKWWuNwfbAuKtN+qH0vIeki3AvO6sC038UrcmDs3XZ
 CpGia68ATYFse2V4h4h+pViNzGMLEKTkS7+ld7eA2vKXG+6DujZ2+vE48p7eu/CGZ/eG
 pgXA0RQ6iyhlncgj6RkYBti+x7lpdvsdEkyGlWlcgRyovKtanWQ9mPnlUll7kwVfP8j+
 QMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790070988; x=1790675788;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0DS7F0nuYDd88ee94mxG72j3QEYc+hj8SUXr2AOpk28=;
 b=LAunbokM+EUBO9SEJW1aE1pZ3r0+TRfkK3TOLpAD+GApg63ov3W5JbEV7cxLZ918GW
 vLuy95FLDQPGhEMWobuOAEu+o+F2T1UQbNjqL3ZFn9Ge50etr7B81vdS8RgW8HFiSW61
 JRF277z/pZtKCXLrw2jYUUoai6r3piewgfEz5wGibK2lttIxcXAv/bN3YamwOO9dCYKs
 EvH59pXR5snM+cXamQWtarztXSdpeYpFXt25dG7Ef3Eub1cmwQK7+7+vLE9jKu7ON58B
 X3WCVvAgte/T33BgfafvLWV64BczEHaC6vLjmxod0EBoYP87YPRGns/ZtyBB/KyMB21m
 HhpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzt2xQqGed+dMmO89gpjHREKXzmChSWg8DYvwsHNMTvV2bshuB497gy1pTLre/Xp2F9FD3d6y/oO2Q@nongnu.org
X-Gm-Message-State: AFuF++mFRy4M6MoMb5zwM1++0ZOT8Svl3/tKBjvPOu5Kkv4vP3mTGv1A
 QF9c5T4hif3+0F6Rxc8K/viEprKfkTW7Hq3d0zlxfc4WnBc9+iU5G0Qd/reeRPqNQFfk3FKw9Nd
 sqVfGzTHT1sAQ9U+UY2AZYvQ9pwbh8PZIUA1mpnrXJMM2+eBU3femtx07
X-Gm-Gg: AYBFou2mc0UGxwEyLyZ0VZY6uz+aaplIlygNXEto4LYZu+0rIQeJmH9F1+bRxy10/Pg
 85x53Lm5fqTveOjEphvs8dwnfT01XwJjhhu3k+VGOt0EtyOkzyWILFjoYUAnObVFKo+3206nMAT
 sj4ACI2DhvWPqI0cG0tHRt2L1ExzWBkLc4tdURKpCH6i7SguC8/1RmZBzlScmjSFPLg5lkWD1eY
 5nKpm3N7gxzDHUDNSvTyweMSgkL3+c6w6en65BlNQGOc2UpLROHD1YH0t9wzhF6oenM7abiByaL
 L+gLH627dwgcFwBOkbzgSXYsNtafxpdt5jIcqENmHRlr6i0eMRSpOOWxnkydBcZ+jQYiVIwFigQ
 Xk0PEJG2+/w6CnTc5gLyC9w/7y0hhaJ6zA+gEEblJ
X-Received: by 2002:a05:600c:46c5:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-49fc573e80fmr212788635e9.15.1790070987914; 
 Tue, 22 Sep 2026 02:56:27 -0700 (PDT)
X-Received: by 2002:a05:600c:46c5:b0:49e:6050:9fbe with SMTP id
 5b1f17b1804b1-49fc573e80fmr212788395e9.15.1790070987491; 
 Tue, 22 Sep 2026 02:56:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdab3070asm19707975e9.4.2026.09.22.02.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 02:56:26 -0700 (PDT)
Message-ID: <9e8167d0-3072-49b5-b4c3-7f56c2121424@redhat.com>
Date: Tue, 22 Sep 2026 11:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vfio/igd: Make MTL/ARL guests fall back to BAR-based
 framebuffer access
To: Yuan Wang <yuan1.wang@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, tomitamoeko@gmail.com, bosheng.xue@intel.com,
 junjie.cao@intel.com
References: <20260922053658.2758332-1-yuan1.wang@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260922053658.2758332-1-yuan1.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Yuan

On 9/22/26 07:36, Yuan Wang wrote:
> Meteor Lake and Arrow Lake GOP can read BAR0 MMIO offset 0x138914 to
> detect whether direct framebuffer access via DSM is available.
> 
> In a VFIO passthrough VM, the guest cannot access the host DSM memory
> region via such a pointer. If the guest GOP enables that path, it may
> hand off a DSM-based framebuffer address that the guest cannot actually
> use.
> 
> Intercept reads from the detection register and return 0 so the guest
> does not enable the DSM-based path and instead keeps using the standard
> BAR-based framebuffer address.
> 
> Suggested-by: Tomita Moeko <tomitamoeko@gmail.com>
> Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>
> Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
> ---
> Changes:
> v4:
> - Address review comments from Tomita Moeko (update macro/variable
>    names and comments).
> - Pick up Reviewed-by tags from Tomita Moeko and Cédric Le Goater.
> 
> v3:
> - Emulated register 0x138914 to return 0x0, which signals the guest
>    GOP driver to fall back to BAR-based mapping since DSM is
>    unavailable in the VM.
> 
> v2:
> - Resending because the v1 patch was sent with an incorrect future
>    system timestamp due to an unsynchronized local clock. No code
>    changes.
> 
> Notes:
> MTL/ARL device IDs remain in igd_gen().
> This is required because vfio_probe_igd_bar0_quirk() checks the
> generation before installing BAR0 quirks, and the 0x138914 quirk
> is added afterward.
> Meanwhile, we also plan to remove the bdsm-size check in the OVMF
> offline patches.
> ---
>   hw/vfio/igd.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 46 insertions(+), 3 deletions(-)


This change does not apply cleanly on :

     https://github.com/legoater/qemu vfio-next

because of :

   https://lore.kernel.org/qemu-devel/20260724102959.1043264-1-mike.malyshev@gmail.com/

Could you please resend on top ?

Thanks,

C.


