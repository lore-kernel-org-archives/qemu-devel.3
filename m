Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AA2F9D0CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCcQ0-0007N8-MK; Tue, 14 Apr 2026 07:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wCcPy-0007Ma-RA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wCcPx-0002ot-Az
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776167936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7wXjoqNLqgmtKuIWm7qVMBaYg2lhPSlBx3hWi0f9lKg=;
 b=TAHQZZlUGie9uvZU3JVhZOOmpVgezlIQJfVEnako7cmOOOE+hVFot2k3kxl2xHmJeo4ynj
 gXEEuglQiK8ETHvUynVjp+9ZSPjavzdbO7ZzflW166KWjubmQDkvOpOutD/Fpy7zFsbhIG
 l1QLtHCyb1DQKZRyAez9ZriNddTg+98=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-HnwNQYh1OhGsmDEp60WyoA-1; Tue, 14 Apr 2026 07:57:42 -0400
X-MC-Unique: HnwNQYh1OhGsmDEp60WyoA-1
X-Mimecast-MFC-AGG-ID: HnwNQYh1OhGsmDEp60WyoA_1776167861
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3568090851aso12428319a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 04:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776167861; cv=none;
 d=google.com; s=arc-20240605;
 b=YhSsmUduFA0UdLhdKtFNi2oIGYUj/ABc/kJ7MauwafstnYni3Xxgx4CO0HW1KKpCpL
 S0pO2gwVOBmnv4CIFrqFz+5hrpuzFb3MuaLoKGSuGQL8HHnb7r4FUdyoROgJE/RjQQWc
 V6rM73Ra8EaTzMklqHIDvEfIlGn9KxTbzdEv1l2P57FQbFLAc1oUq0G568Uv0DVhGqWV
 cFTdZ0458RZHIe6IV4MXLPTHx6pq/f4W/4qLiurSWTSICscmtG+RyUXI+PnMCwfDNbO5
 zzB+orm8DMk1FzTFa8Yx0sAj3nBgbt+7BaIXlGHl0dp5wMMk0AUBeMMYwNn4T7AdxMFb
 U2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7wXjoqNLqgmtKuIWm7qVMBaYg2lhPSlBx3hWi0f9lKg=;
 fh=6wfRCG2K6ROGLsOmSJHDb77krC7aSm2FPM00yXrhoVo=;
 b=kkBXnhcBjQftxj/DskaYSCfGfgE8F+TUORpuTFmsPQJlLObfitQkVg65kZj5nSaUTQ
 iNshrc8XzEdO9KIuZqINAb8wN2rJk/tTKuK1/3tURXXAfzd47JCMwFoe6StB+wUZ1vU8
 c55vQdHMFhLnDKyBm8vOsdr78fJEIgZo2NZFeR4Xcy/OYo4wdfoARA1VI0MHwVY7PPaR
 t93jQOlbQ8v0kXF8H1xXTi1Db58vQb6xO2clWyxJh3xkA4G2LnUiB+Xu7uDXup9a/oqx
 XQ2phB+JIIVfgSvPpTgWl3JhtDa1WcRT9nM4m/aZmL9FhZYWAGmbXo5MxUCnMMMA7JNY
 h1ng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776167861; x=1776772661; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7wXjoqNLqgmtKuIWm7qVMBaYg2lhPSlBx3hWi0f9lKg=;
 b=OuXEJzA1sf9oj2jVpppuyaJoALcx56/y/4tOEBAl9xH+z+BdFb85Nhf8MiTOXBUbiH
 uUuRpH8QhpuI9UHgNtjcwtCm2Nl+KvDaL1CHAyKVaKTNWVcEcIOs6/94RVOJjleXGix0
 V+8xyNO+ZQ3dms1rnqsMghd5WeXcoo1b83nArej5z8/jbYlchQ0ZtBZ0yYpZn4ARpMbt
 Q2NRlxa1pCKa60kODzTsz+ipX4YDtxA12hzp0mvGendP0nfVSI0teGBqrOlRcoKsKqkT
 hYNEEx6hE0QxB0qQLTyTwd2jsuQETmjHI/21jnHg3HkIgFOL0/NFHsDq8GNK8aq/emkL
 tgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776167861; x=1776772661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wXjoqNLqgmtKuIWm7qVMBaYg2lhPSlBx3hWi0f9lKg=;
 b=iutLRi0sFsim89Tf/1JYnJsitUMgkPJgVugoUVtCNDTthcVetnTDuWLpU0XqMAon4q
 xCDf3EFToifNA/oSJuBas91lcERXrlBNv09eKloh+F015rc5e5WIezEE3ED61Quzv2Dh
 YSZM5VVBe/4LxLL2eHBAZn/Wni4iV8MTy6bzcs4jKpL7xAq8P7e1kCbZkYH9j7i91CQ4
 wq220ewX7Lnv9c6raTn2AHs1i8fKsWmOFe/+DQTH++D5a6vW94bHd/e3PxuIzjsffjCh
 GpBs0GtfLFSBUnxI2BH9K+z7mWUcehXZvIlA9mi8Y7QEV3rjol/Bis/h6zx83O+VSjCd
 Nj8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ96L22ZjgeKKE14hmSRwLydNqtBaJ6EWxEoJTNMSjYCKV2tBYQE8H/RrkxbUmOTLhBGKkZ3u4LzScU/@nongnu.org
X-Gm-Message-State: AOJu0YzZL8faCLzCY5M+kf2+eQW/0YKv42TCvIC9z2xGX2OpDM91ZGtO
 z1fm7KRVjb0raXq+aoGgPyOSRGb9Q4AvZW0mrEQ2v6jVe6JmQYeTgMp1yi/3aN9zBYKQsvBXOF7
 mIuZb5y8Lv2RdB7OtO8K6zlEeKNd7AyhVdku/o6XLK134bKp1vyBQGBjs1n1FFyf1FWWYVkKCIJ
 hVzYyeUdYNq/75D+hjbmEVCMekxfiAZTE=
X-Gm-Gg: AeBDietmi4zJnsfV8LPealXFB0T9Qtp35rKaBU5vVXe/vK0VlrARdXkXqrYZWBDAjAz
 xqu23knWLp7bmunkaaM6OZ781xO4mH65EY0kKfCLEySjMjVMWUunGXm+xe4P3389aG0L6S9cpsi
 vfkvzmhrMtxGc6+T0RGWEWx7gdnMpx06xWhvN/5iX7Nu44sImttQk36KaiApdYC5LMS2kCtAddV
 FEv
X-Received: by 2002:a17:90b:3c0c:b0:35f:b9ea:8f9f with SMTP id
 98e67ed59e1d1-35fb9ea912dmr6476539a91.16.1776167861187; 
 Tue, 14 Apr 2026 04:57:41 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0c:b0:35f:b9ea:8f9f with SMTP id
 98e67ed59e1d1-35fb9ea912dmr6476364a91.16.1776167860237; Tue, 14 Apr 2026
 04:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260304165223.2166175-1-aesteve@redhat.com>
 <aak5QkV_RxUEnV_f@sgarzare-redhat>
 <20260305032601-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260305032601-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 14 Apr 2026 13:57:28 +0200
X-Gm-Features: AQROBzC24dTjigQr66Zm_BIEQ2Oq8FhH9yGz9R6hGWcJLKNtByf4Vde_N7f5-3c
Message-ID: <CAGxU2F6sEwLZXLy1TrH-s9At0YiCc9AQMC5FWdyiHCXk-dE3vA@mail.gmail.com>
Subject: Re: [PATCH v14 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org, 
 manos.pitsidianakis@linaro.org, slp@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, stefanha@redhat.com, 
 stevensd@chromium.org, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com,
 Peter Xu <peterx@redhat.com>, hi@alyssa.is, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, dbassey@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 5 Mar 2026 at 09:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Mar 05, 2026 at 09:06:20AM +0100, Stefano Garzarella wrote:
> > On Wed, Mar 04, 2026 at 05:52:16PM +0100, Albert Esteve wrote:
> > > Hi all,
> >
> > Thanks!
> >
> > This is now fully reviewed, Michael can we queue it?
> >
> > Thanks,
> > Stefano
>
>
> yes, I tagged it already.

Michael, I think we missed this series for v11.0 :-(

Can we use this for the next cycle, or Albert should repost it?

Thanks,
Stefano


