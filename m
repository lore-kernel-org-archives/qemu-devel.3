Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FBBCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRt81-0000AH-7s; Tue, 26 May 2026 10:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wRt7z-00008o-9v
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wRt7w-0002jK-L6
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779807087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vNB5dRuBQUkYWcL2tTZPtjic1AfVAuz4/Sce5KoR+pE=;
 b=ZtTMNOgVL3yfAaV0klqlfZRkf+upGATLc6xdPrClHXpo5mnIpgFtLTJ3ywBJ9VFn2K/Sgi
 ihZ7lKDs3PORV6CgiWph6mhD8DEZBtJtpv7q3EQ/WkndbZGm3XDS/iA1wpz7cMx2Y1fOYV
 RDsbZN/okXvp73ZnMNEBdPabLDNi+Ps=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-rph0N0yaOx2rNUNgihGemw-1; Tue, 26 May 2026 10:51:25 -0400
X-MC-Unique: rph0N0yaOx2rNUNgihGemw-1
X-Mimecast-MFC-AGG-ID: rph0N0yaOx2rNUNgihGemw_1779807084
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48eb0da933fso73881785e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779807084; x=1780411884; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=vNB5dRuBQUkYWcL2tTZPtjic1AfVAuz4/Sce5KoR+pE=;
 b=gX4dZfTPDnh3sXF0ZvombeO9qfEDbiCIA0xCIvzc3f2w9YW/0g/b7aPtFRPEvBaH5z
 LDbQvR2jdYv2ewcR2iRUWoa++zQkRqvFHq/3gh1I17mJGFrD6m9LjJqKy0nEYbiS9YYq
 YND+JrLRwucdmCPvHbojb+jar/JmFSXluJzESDlQbegCNOY5EUcRgl4337AI5Hjm/W6M
 WTWP910p8jaZ0WpQR5iult2w44mHOSf1MW1anowJ/as9iN2y1xmuTNieRKlrOOX53Dxe
 K2ew1PUARKM/Vx6wExDWlVSdOoqULrvANJJnekhWET6oSeYTGHz9KP25kaBoOlqg4bBf
 JwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807084; x=1780411884;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vNB5dRuBQUkYWcL2tTZPtjic1AfVAuz4/Sce5KoR+pE=;
 b=Vq8sqCeOfWGmTQtXfCY8kVVqr0YcxekbLB7EeGarMyRVThdPQmxPfsQI6SfzKE9eGg
 bTbAHVOOSgAZ2n5OgIxdC4RTMeDvfB+fTC0itXwB+DaWUdCv898YUYB4l1fwKfxR+n8s
 C7fGDq3Z3zvwClP8VmcvZuJNabFwqS0mwFnS04HC4lLDYkMq6cbWvPnx0XcmX6ocxr8S
 le/epWlKQqbbqHi3XbgPsuBbIERpye5e7NIEMDOcxFZckQjU6ihGwfpgliKIk4Ox0cH1
 l+wiqZ+OE+DiD2kZiWj0d5nlN422yRGvvhOzmH4vJAGmuxv+ilQ7y/XvMKy2ZRARlms3
 E0zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8U2NBjyRV6nOOd5x4kB9Et4KFa7fvlQD/mOopE5paD8+HjoY7GaL8ePkGLcwGlN+HELkcqrwb8h7vj@nongnu.org
X-Gm-Message-State: AOJu0YzQtWiSbVY8HnLcOvKDYixY81HfshGHl38kOWayflarHvBZIhAG
 YVbcUSWZCXZ5zg3Gd9DkdT5qti/KbQ39s+GWHp3M5YQRuXgEwjyOyZmcARlyMx1rvVb25UKlzOc
 3ycIIYue8ZSv+aoOei8kQyETHD53R47d4Z9aCT9cL9LxAb4LewI5GSfHS
X-Gm-Gg: Acq92OGJICDsKQz7aJcOg7RJvnQG5gpWMUFP3id3Q7WDeoMvsRx8KGJMOLLv3cW+ik7
 7UFwvST8RA+HR7eztBMKPmzEX2zQoH196vEySSRHliT+kV5V8tB+EOKIsNEJbrAmUviSDcHwnmA
 Lzz3rubTGB/BAJNW7jROV8TqW6wjoQmfnQ21VTaexY9v0FdcNOqHgYUVcG6Kni86fM5R8Ga7STV
 Xm5uwh2gb1/1y1F75CrfGSeUg6Ct78WMHgMaQgV99F96aYBlT+Z+9c2UMsfbQ4M8j0xmQznzqGX
 sHgoyvp0sClJrDrR2fGavAPNfM/YTLz5hc02dv+wG3OyEwVzh9JzhThMdYbO5merjIBL21ZTNdb
 vQYg2G6PlU05J6PeHdoJi0AXnQoAGuHoPY914ba1TjGBbzeYi7VBpiuo6HLhdpsYeHv6R6mw=
X-Received: by 2002:a05:600c:628f:b0:490:5057:f602 with SMTP id
 5b1f17b1804b1-49050580d79mr260088645e9.17.1779807083792; 
 Tue, 26 May 2026 07:51:23 -0700 (PDT)
X-Received: by 2002:a05:600c:628f:b0:490:5057:f602 with SMTP id
 5b1f17b1804b1-49050580d79mr260087825e9.17.1779807083231; 
 Tue, 26 May 2026 07:51:23 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0cd5sm406863615e9.10.2026.05.26.07.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:51:22 -0700 (PDT)
Date: Tue, 26 May 2026 16:51:21 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 skolothumtho@nvidia.com, philmd@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Subject: Re: [PATCH v5 16/18] target/arm/cpu: Expose writable ID reg field
 properties on the kvm host vcpu model
In-Reply-To: <20260519132905.145643-17-eric.auger@redhat.com>
Message-ID: <26485473-c1bb-4dee-ff9c-429d9ecc7305@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-17-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> If the host supports KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES and
> KVM_ARM_GET_REG_WRITABLE_MASKS ioctl successfully retrieved the mask
> of writable fields for all ID regs, expose uint64 SYSREG properties
> for all the writable ID reg fields exposed by the host kernel which
> can be matched in target/arm/cpu-idregs.h.inc.
>
> Properties are named  SYSREG_<REG>_<FIELD> with REG and FIELD
> being those used ARCHMRS Registers.json.
>
> When such properties are set, they override the default field value
> retrieved from the host and reinjected into KVM. Then the actual value
> being applied at KVM depends on the register, ie. it can be sanitized.
> In case the field value is rejected by KVM, the vpcu init fails.
>
> Anyway there is a first attempt to write back this value into KVM.
>
> Then legacy CPU options (virtualization, secure, ...) can still
> override the previous value. So low level IDREG field properties
> apply before the legacy ones.
>
> An example of invocation is:
> -cpu host,SYSREG_ID_AA64MMFR0_EL1_ECV=0x0
> which sets ECV field of ID_AA64MMFR0_EL1 to 0 (enhanced counter
> virtualization).
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


