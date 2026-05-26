Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29B4CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtOC-00086G-FJ; Tue, 26 May 2026 11:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wRtO8-00084i-5H
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wRtO6-0002XG-ND
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779808088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nTzMQSKdxFipCdF2ry9Ey+MwrneHn3RX2NvYnEq5DPA=;
 b=XW4VPDfocYNzPoK8LSYQq5zAaMtJHqrZ768iK3jU0n5RRmJN8p3t3zr7O8OZNlw22K9fAL
 Ue4E3ZVKzJADilVvcImBqy/T71d211PRU4nNtALG+g+Z6KA//CZtc+yIyqGSScku0E73sG
 s9KT6l8EAydN5+3ymZSQiz1HMUipHnA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-VezNOO5FMCGaj0wv3hFDjg-1; Tue, 26 May 2026 11:08:03 -0400
X-MC-Unique: VezNOO5FMCGaj0wv3hFDjg-1
X-Mimecast-MFC-AGG-ID: VezNOO5FMCGaj0wv3hFDjg_1779808083
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45e55c44ac1so8476539f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779808082; x=1780412882; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=nTzMQSKdxFipCdF2ry9Ey+MwrneHn3RX2NvYnEq5DPA=;
 b=Kg3o9LLxOMkQ2q+GjGXn0CDFNqjFhvHblXWM2f8F3naHgU9MG2gugjaI0wtOMNuPyh
 KVRtjXOJtw2cvJuqUYg5RNcH6b0kJSInWsH1wsiyQCaz/tM5bGpV39m+RaoAhr/W+fZy
 iFUK2X+UKy2EgaRXJq9wMC1eMOY+0PNFzTyyBqfnhfEJmvkyJi4zoE9HFoed0EoFtbPr
 qTxI1SrxcGPcE7GTH3EP809kF1QW74yH1SAwgfeFPoC42/uSaZ84TycVyRXZ5+K/xjEx
 g0weZejmH6M8Yi5qwNeTj/hUMvraAyu5iL3OLmmIhe50NdbqdYBWL84o92csDwQexDm5
 4pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779808082; x=1780412882;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nTzMQSKdxFipCdF2ry9Ey+MwrneHn3RX2NvYnEq5DPA=;
 b=Hq3l5jvW7e6tiMfT+gG0pytixbrTt4f/+4HjqwiyVLLL7R30bjpcEAdS6HEhcvez+V
 So45Adx2Hh02INM6z9GMZe1j3eYUMj3jGBB82KBvUlPz9+1OTJO8qT5dwYVN40pZUU9e
 VVkvy3/Hh1g63D+1b442rHxPHiI6YEWEfIsfzwfmbZc+jsdQ8mzbnlj6WnQHwVer1HNt
 qVKAyrp9gKSGlMEHpts5rG/LxN5Vc5YVgxG5E555dAQu60jlb08MRFpjXv8fiQk2NFJL
 c25aOlhz7VB5DE9bvP5u+ijg9YOcLclM0Aw6+N0gRAkRxy4dPPZWgALChMRE1F8WlKYa
 SUWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eD4dZTp/VSmkZmYRyLL9aWhALovCyANEttd8LPLNazdYK7x5kiNj3nsatoPnZwmXjkWTnKbwdZRJT@nongnu.org
X-Gm-Message-State: AOJu0Yzr7PzLh/a3v8ylp3TIWFzZ01D5gMd6rUP/itD4bhMCu3LlQjIX
 MYTsaWSUXJPiC6McSp0ThWHxQiz9Cnq+amUuZZTL++9rlQ8DG34+B/7JdB5O+HD/D5xds22Lp/j
 +aIPGX4wPOEYT8gFa4yWzW0KwXnhI4Ig20ROb2EgSt4kAR5jkahuGbE4G
X-Gm-Gg: Acq92OH0QnvsSY8shuB86+4bEyN3kCiS9IhFapL3rE6J9U6uhMIqiTwh325V9S9u2E4
 bNlyv+xj6tEAB8ecOcn6VHMpoimac/C/fCbjKctgBi2ZQUAj9TyebMzK1Bg0z5EgAWvxfv5Atoy
 IUrfKlHLdsu7z6eaOtJUtmxH2PHUpDgfcs2fTBEcOPz4cU8EDu633Q4AFAsX+k6cQbutQaDbxc9
 jfZ825ytLC08wwAvtZIrPnwRIuSzuxD5ohO2gWTB32D/LAbUPm9+20eihwJ9ewFRWX/kW0SnHHt
 iwy+bNQvf5EGe4G8/Nb6vUytqw6PDopUyhK25W7DocNiicrO500RxxjYbJhn9OJvWgoXxJxblZw
 xwfVbObMlkxdrWmRDawXxNdTXYsGzBLawMW02qpmn/nkDj1VmIWqp4gkx2zWBiIV0DCnZvdk=
X-Received: by 2002:a05:6000:4a10:b0:441:1fa5:457c with SMTP id
 ffacd0b85a97d-45eb367f9f6mr33776486f8f.5.1779808082594; 
 Tue, 26 May 2026 08:08:02 -0700 (PDT)
X-Received: by 2002:a05:6000:4a10:b0:441:1fa5:457c with SMTP id
 ffacd0b85a97d-45eb367f9f6mr33776417f8f.5.1779808082068; 
 Tue, 26 May 2026 08:08:02 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5cb9asm39251687f8f.27.2026.05.26.08.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:08:01 -0700 (PDT)
Date: Tue, 26 May 2026 17:08:00 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 skolothumtho@nvidia.com, philmd@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Subject: Re: [PATCH v5 14/18] target/arm/kvm: Special case REVIDR_EL1 and
 AIDR_EL1
In-Reply-To: <20260519132905.145643-15-eric.auger@redhat.com>
Message-ID: <5f6c1d59-f2d1-e21b-5d83-c5d64ab8a484@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-15-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Special case REVIDR_EL1 and AIDR_EL1 which are writable but
> does not expose named fields. They will need to be handled
> separately
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
> target/arm/kvm.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 960052e67e..6373a66bbd 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -472,7 +472,15 @@ void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs)
>                 warn_report("%s: reg %d writable, but not in list of idregs?",
>                             __func__, i);
>             } else {
> -                decode_idreg_writemap(obj, i, mask, &regs[idx]);
> +                /*
> +                 * special case REVIDR_EL1 and AIDR_EL1 which are writable but
> +                 * does not expose named fields. They will need to be handled
> +                 * separately
> +                 */

"Special case REVIDR_EL1 and AIDR_EL1 which are writable but
do not expose named fields. They will need to be handled
separately."

Reviewed-by: Sebastian Ott <sebott@redhat.com>


