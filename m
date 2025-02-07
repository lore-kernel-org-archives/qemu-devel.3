Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47370C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 17:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgSSb-0000sl-By; Fri, 07 Feb 2025 12:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSSZ-0000rz-1i
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:48:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSSS-0001qE-C2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738950483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cxfsx6u5R8uKJa8bY5IZuJYQ2qLA5Q3iOTNlVtOC1+0=;
 b=Ts2sNeaYAacUexQyg5D0ACt1oeO9eCLjmnzMAB0nDZ0EUheHUg5paDhF9JzOd/MPsafjiS
 2pWiQPYOUwW4QclGtak4fLwEgiLM4HvMBzxZlRx1pIhtFBJp8luoPrBBF4+Y63N4q6GfOr
 GavGpCw8sTPLYSGdXNQPATO5MMAK/s4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-baB0_-b9NyeRBEyoiI8N5Q-1; Fri, 07 Feb 2025 12:47:59 -0500
X-MC-Unique: baB0_-b9NyeRBEyoiI8N5Q-1
X-Mimecast-MFC-AGG-ID: baB0_-b9NyeRBEyoiI8N5Q
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e1c50ef1so364782385a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 09:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738950479; x=1739555279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxfsx6u5R8uKJa8bY5IZuJYQ2qLA5Q3iOTNlVtOC1+0=;
 b=TVcVMcJoQGMlhxmQxEtHKAUB/9Nxrn64WZQ2FEDGwXDM1VazryT3H9DvZMsMZnk9we
 O/oyC96qvJ2QnKXGqrzKU0XSVCxYt5snAPPXrRoyDZ083UPfkDXZMgV4KRWDCsSYXL1J
 9akTG8QGKmSS96BlbZLXpklX1HKd9kFiBnV5J2ZOrTirn4LuyT526gZVkMnPUs/2/rNS
 IvLI51w7jOFAia3S1cv6DtHYRTllAdYr1NPBldTbOOP73k2+FxBS3PVCRe/SXfFOeShb
 J91+ZUGjlRCI2R7YUwhH5Nn0sDW51eJyKXCPSLSpLIpbRZddX09PoMm0Gk7XJutgtl18
 GlMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNTQ+JqEIh8Jt7ci6qd4MTFBeYrRV7jByzcfWyViH8Wc/fcs9wA4lg9tnSbHFsUiKZKV+rcBerF7No@nongnu.org
X-Gm-Message-State: AOJu0YyypJ5/02Qvl1Zr6AgQaqGL1vGXFlRZr4OGlFIQRK1g10/E04P1
 GbJvbKusgcu7XcDj3eWisoc6CT6rui1Q/4v9bRRmdPp7NHVEdX+1IFU0kvG/dzhWNFdneny5UPO
 wm9PO9DWAGf36m3OgP3QGvOIcc0YYurkkwGMp8Rqbr2KcWveI5lts
X-Gm-Gg: ASbGncsCdodi45Deke35wqRhFhbB3wgxWEOIEzbY+rGuxj2ivJNz7c6Wu0RC1s50OPq
 UKbuItvDPCPM/1ljhzIAEFfSpx+b0nkBzUeqddrkDiJCnGZsPRfV+zncA3WQ9Tcn8GogXAWE410
 VfzOVrAOWfy2C3eGu+WELiDKTMJubL9ZrHVYtFzDxV2cmBVcL4nTnMfzCxmuA6+xGT7SX/Z0nWd
 8kBC9Zvr+woSiZSJsX+joaJfbiUBKQPjyNlSGHUeOC8EL7tDQr2VtT6hM5+vNRJDdt4g0wF83eB
 FbpIEjln9eUpMVsLbVR76Jspe8cdW2VDGRzmoeEfTTOhRTtz
X-Received: by 2002:a05:620a:454a:b0:7b6:66d0:5ac2 with SMTP id
 af79cd13be357-7c047c45d24mr756873785a.54.1738950479388; 
 Fri, 07 Feb 2025 09:47:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExw/AuxTxKc/a8iR8ELE+FYB5JYNgNtiaexRstbbP6xCSDGzlcxVODvrP5FKTloyYRstuLog==
X-Received: by 2002:a05:620a:454a:b0:7b6:66d0:5ac2 with SMTP id
 af79cd13be357-7c047c45d24mr756869685a.54.1738950479060; 
 Fri, 07 Feb 2025 09:47:59 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041eb776fsm214743485a.91.2025.02.07.09.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:47:58 -0800 (PST)
Date: Fri, 7 Feb 2025 12:47:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 imammedo@redhat.com, alex.williamson@redhat.com, clg@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Move reset to exit phase
Message-ID: <Z6ZHTStx_S9ALdxt@x1.local>
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-5-eric.auger@redhat.com>
 <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
 <7102d470-ac72-4c02-b8bc-20f1379a4843@redhat.com>
 <CAFEAcA-XK5GwT0b_Ff-8fYnWcDgzaE-0Ei-YqDoXv-aXFGNXUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-XK5GwT0b_Ff-8fYnWcDgzaE-0Ei-YqDoXv-aXFGNXUQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Feb 07, 2025 at 04:58:39PM +0000, Peter Maydell wrote:
> (I wonder if we ought to suggest quiescing outstanding
> DMA in the enter phase? But it's probably easier to fix
> the iommus like this series does than try to get every
> dma-capable pci device to do something different.)

I wonder if we should provide some generic helper to register vIOMMU reset
callbacks, so that we'll be sure any vIOMMU model impl that will register
at exit() phase only, and do nothing during the initial two phases.  Then
we can put some rich comment on that helper on why.

Looks like it means the qemu reset model in the future can be a combination
of device tree (which resets depth-first) and the three phases model.  We
will start to use different approach to solve different problems.

Maybe after we settle our mind, we should update the reset document,
e.g. for device emulation developers, we need to be clear on where to
quiesce the DMAs, and it must not happen at exit().  Both all devices and
all iommu impls need to follow the rules to make it work like the plan.

Thanks,

-- 
Peter Xu


