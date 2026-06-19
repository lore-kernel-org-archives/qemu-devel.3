Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8F7CD98F8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waTke-0005mS-EP; Fri, 19 Jun 2026 03:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1waTkd-0005mG-Dl
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1waTkb-0001ab-7t
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781854491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2L2eBJBzX9l63aJaDnbTlqkL9dQbt0gTedHcVbPgIs=;
 b=gMudhkbRGLRFcMWNHeSHMa0155H+uG780DL2mk6hve023pD4ewkJhA7KyLiuX/FbleLDBr
 Lw83u1f0L24tR5KL7hsWf3UWd9CFaQfnIWtkZPki4OIrTHzTtRQCK9zFviY1nsp/s6PvIp
 wGVdUY0TC5LX6XnQzwaMMEeoDQ75gHM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-azCzhBXVNoSa_osfzWvm8Q-1; Fri, 19 Jun 2026 03:34:50 -0400
X-MC-Unique: azCzhBXVNoSa_osfzWvm8Q-1
X-Mimecast-MFC-AGG-ID: azCzhBXVNoSa_osfzWvm8Q_1781854489
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490ab3f6e55so9416185e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 00:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781854489; x=1782459289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2L2eBJBzX9l63aJaDnbTlqkL9dQbt0gTedHcVbPgIs=;
 b=Nn0CDwfqXkl2WRRzHGoynqo3y1++UKJPBJPjm44UmoPBnXaiNVgzCVMJLqi+GwVaIQ
 uuut+MGRu9Vihbki2vrxqArfiiUJ6PGQi/bmneH01PuRbDJR1srKQZqCF/Jk0fmVrQ0g
 hOcyVl/QE7U9Y2P28+RGxmX/sanBfY6mvJ4BJylsjOIxx2XP7VoyuvTxwLhsd3jdpkKQ
 WqvlSMoae20Mu1TcGNCI8skT6qmfUfKbbXm7KgNwuBUHhynW/Suj+94GzyUQG37zoXvI
 hV5ib9qMf/QNPZolJbGbeGqL2EykwLqzLHBF8k7Mu2736VAaa2+31LbTpcKXJLxK0RKC
 /fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781854489; x=1782459289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x2L2eBJBzX9l63aJaDnbTlqkL9dQbt0gTedHcVbPgIs=;
 b=lbMn9IM+niygTLRKlGdXEaPM7Qk6603cUaQSSqH9EwqhLYVbEdVzn+eUASQ0vYmRMg
 0ZGx1xbI9w5WRlSnXCT+Cl2ZF03MmRsxYa4XfNDGRUlFlAu8mfe5n4J6o8O1lnE9GtA4
 P09ZWDmBcj/kKhQpWIliqDrWDFo58tFEXZK9xfyO9VlvLGPAvm37QJkXBTwkMfezjdkL
 boOm+zdldIjFYk3JEKVtyDjjgZHxJBcr/6z+qasNBX1z6PbHP6YS5Ln4/Wp1dODjfUaC
 saPRAkQlaf7DQriF3o6qOwb0jTNlCZnSo+zvxgOuOvi4O9+q3W7jHW1YJPkLTT6KX7VX
 D7VQ==
X-Gm-Message-State: AOJu0Yyny+6T0oHV7s9N0E6sizVW9BO293LDPWxcEa+9usF6ri1am/Im
 tWwvB7Kys7exmHsPvaFyzi/GUtfyagCIP/H1XmEEuN8E1BoHkZZbjLXOzj8XN7PN6AajjQbBn0B
 zWJ+4DN7BB9AjlA2aQO2Y7NapTQqdJ14DbXaE9U+90pp97Rf6m6yOc//u
X-Gm-Gg: AfdE7cmAEP1LrD+4Cyvmt4W8ws/uEX4M4kApLZ7QaxKOiO7F4faDb/9Y92y9gVc/P3s
 Sx310xz+ZjPmqJL/SV6iORD0nzfdF2rBllS42niIaB+k399laLluDvwGfVVYNJS+39y1IXug8H2
 +OFsFjKFTjqHueJrdxbUxcdpnS2qeg/0U4mtPtL/bgFKnBgAInWeM1rprYuuXVm/Jr4x3s7BaI1
 StbU/DL/ukvqFYLkq1NN/asRqBR+vgEZw/KyB1GS7aEYYCylO5BvFQgAQEupBVDTB9Tg+fclHJt
 V7IEtjqHwiHo03Wp4SjDbr1P1R5Tp2QHpuTH88g8GUw+vrAEr38IhMyRJZEAk01I0myE6xk=
X-Received: by 2002:a05:600c:8a8:b0:492:3dce:f6ef with SMTP id
 5b1f17b1804b1-49240e9cca0mr24374285e9.28.1781854488839; 
 Fri, 19 Jun 2026 00:34:48 -0700 (PDT)
X-Received: by 2002:a05:600c:8a8:b0:492:3dce:f6ef with SMTP id
 5b1f17b1804b1-49240e9cca0mr24374005e9.28.1781854488420; 
 Fri, 19 Jun 2026 00:34:48 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650b67a34asm6507850f8f.22.2026.06.19.00.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 00:34:47 -0700 (PDT)
Date: Fri, 19 Jun 2026 09:34:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2 07/21] arm: sbsa_gwdt: fixup default "clock-frequency"
Message-ID: <20260619093445.3d9572fb@imammedo>
In-Reply-To: <CAFEAcA_KjOEBduVcop_T6-aH_DKy_4=QwTKa04kvKR51S79UQw@mail.gmail.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-8-imammedo@redhat.com>
 <CAFEAcA_KjOEBduVcop_T6-aH_DKy_4=QwTKa04kvKR51S79UQw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 18 Jun 2026 15:58:38 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 3 Mar 2026 at 09:26, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > Comment about keeping legacy freq, is wrong to begin with
> > (should be 62.5MHz), but that value also doesn't make
> > sense anymore as the watchdog is used only by un-versioned
> > SBSA board and the later has hard-coded it to 1GHz.
> >
> > Other potential user (arm/virt) also has system clock at 1GHz.  
> 
> It's not quite that simple. We use the back-compat 62.5MHz:
> 
>    *  - for QEMU CPU types added before we standardized on 1GHz
>    *  - for versioned machine types with a version of 9.0 or earlier
> 
> sbsa-ref sets the same 1GHz frequency on both the wdt device
> and also on the CPU objects it creates (because it doesn't have
> to care about back-compat, so we were able to update it).
> The virt board doesn't set the cpu cntfrq property, so it gets
> 62.5MHz in the above situations.
> 
> Changing the default value here is fine, though.
> 
> (I haven't checked whether the subsequent patches in this
> set make sure that when the virt board creates a watchdog
> that it sets the clock-frequency here to match what the
> CPU is is using.)

Current patches don't set it explicitly as it matches current arm/virt.
So for clock to match CPUs, it will need either to be explicitly set
like sbsa does or we reuse compat props to fix it up to 62.5MHz on older
machine types.

> 
> -- PMM
> 


