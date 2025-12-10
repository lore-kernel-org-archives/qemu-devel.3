Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C9DD3C53F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 12:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTJgz-0007ZS-Lb; Wed, 10 Dec 2025 07:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vTJgy-0007Ya-KK
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 07:53:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vTJgw-0004rP-Do
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 07:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765371193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSQ/0b5ZS1zhjjfKyGz5j7uGa36FBDvcEwSGC9RfcTY=;
 b=KK5TsfVdfQNy9wYWPZIdI/2RXLjgFgfrdXEv4hMwRd68omwY+85uAObdRieQbcGtWkSPPP
 Qc1Naq0s87Vt1A8LKkba8EpJyhiXNnEZAdTaWzC/0v6PV5Qualovq0S76C8C2T+Hq5OghX
 NFDVlARo4L6zrJEZMsws+KeJhvfjPa0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-wuqCa_ImOHG_R9B8MP4Fkw-1; Wed, 10 Dec 2025 07:53:07 -0500
X-MC-Unique: wuqCa_ImOHG_R9B8MP4Fkw-1
X-Mimecast-MFC-AGG-ID: wuqCa_ImOHG_R9B8MP4Fkw_1765371186
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42e2d6d13d1so3249780f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 04:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765371186; x=1765975986; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KSQ/0b5ZS1zhjjfKyGz5j7uGa36FBDvcEwSGC9RfcTY=;
 b=bhZpDZ9lg/2jIq0BvCRIMGEYqqzigHxggN+o75sGXOru9a5epj+GiRI9BhWqSfY2jF
 yB1SYlhBBwZb+HhR5YTPpElO6PMBZ+lQA3+2GbR3nUmLuZ8zQRoDRg1FCEE2tIPXcIlb
 9HP9cICojXcHHYpAil0K3VCtm7byfhZgfZnp7LxksnOPbyqQU4G+zoGPr7J3M5XgOjhH
 3xSTpkS+aKLuIgUn/+mz0HE6m4d39wrXl8wtlX3ah1prMbtyT+qQjNYmsqFG+F7XEiNR
 GVO6UnvwKNNbF4ysITxee2lhOiSTbbBeaJH8UI8E5mtHjmKLAd4Eg+Po+qPBKN4NjV0X
 0QeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765371186; x=1765975986;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSQ/0b5ZS1zhjjfKyGz5j7uGa36FBDvcEwSGC9RfcTY=;
 b=LzANQQX7a+DaqaD6A11DUhwmyioLHFYR7oqb3gQxp8DyncGFatto/4G/YXJkW7NE/u
 YSn/RtkzK+YdQHMr+2OmrBPSfSYos2zJA8sBXdq5QkDcNnKj6pfWGjSKP+WDPaBy01hN
 c0yTy9grKOtozxgVTJEW0F4aGm8z8ME9/aTY7sHxwv4RshVOyeT8UQGoQqUlAZMhVR4v
 Q2iwFwXxPO8OUZfVn5Q/0nD02kchEAYV50AJla/G61QTgPA9XweEUovK5GblrVE3tF9G
 xFpkhw0vxpnvaN2qdc6P5BmvK2KpepAUpB0fQUlpIJMoPYiQ7GanFFBCEabuJUzARHxu
 n77g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLl2LfMOLUBY68D0u9Z9BSn/1WRjAkL1e3R+Qs/3Qnri3doYqudMsgE3SetztNuDgtLjuBCwrfCVt8@nongnu.org
X-Gm-Message-State: AOJu0YxRKrXCLR7cccuOATjtjyqDer3ZHC4wDxKoZJKw1O/6YLNZZzK+
 UeFOLJytuVjxGJ82rpWPrH5Gxpk0oE4qKa1WhwKIySMRo9KWyXhjW3/3NVLoKeHg30oCZj7dtsA
 NmKDMQ2tstvCYU2qbOZ8qtP7D1cHq6kMRKx5nBVVmVePyooX7fjNrATV2
X-Gm-Gg: AY/fxX4oXIWomDIgQzhY0MASLaM2pFh409Tqa0KH1z79vV4pQhBb9RcLkOlNFmfvDcb
 aklnWNB/01SUBVHE8cmd2eYIrNgI3jQPP2gJUonrdNC9aotM+nIGI9ppXXEbIA1DPu/mQXKfm9e
 piVAK9sl7pheRoeOMvpxKVeHSUNF0deOvp0sgpiJbS6hLWStO+9r8SKhAAQ2eL7+V1FNo4W+KEK
 vjwuk9Lc29pRWqNw7plgNZFtsWa70IIhf7vuPNP6Kcv7ynwXnU1uowgaNz5M7ceBa0Ps7322Gz2
 1erWS34CTPCi0dguItirRAWX0clTCSR7x6YZxeofJ/IqtYUynhr2c9VT5u7ztVdDMg08rktlEWy
 X
X-Received: by 2002:a05:6000:2512:b0:429:c54d:8bd3 with SMTP id
 ffacd0b85a97d-42fa3b189ddmr2522291f8f.53.1765371185960; 
 Wed, 10 Dec 2025 04:53:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoslSpUrWPldH2vzLSwkzmvWv47ASfAbfYEB/LsBE9VmJTl8lwEjZaMBd5sdaiYRZWPpz8yw==
X-Received: by 2002:a05:6000:2512:b0:429:c54d:8bd3 with SMTP id
 ffacd0b85a97d-42fa3b189ddmr2522237f8f.53.1765371185456; 
 Wed, 10 Dec 2025 04:53:05 -0800 (PST)
Received: from redhat.com ([31.187.78.138]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d353f75sm37887639f8f.42.2025.12.10.04.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 04:53:04 -0800 (PST)
Date: Wed, 10 Dec 2025 07:53:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?=22Philippe_Mathieu-Daud=E9=22?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
Subject: Re: [PATCH REPOST v4 4/4] acpi/virt: suppress UART device & SPCR
 when guest has no serial hardware
Message-ID: <20251210075237-mutt-send-email-mst@kernel.org>
References: <20250528105404.457729-1-me@linux.beauty>
 <20250528105404.457729-5-me@linux.beauty>
 <20250714144303-mutt-send-email-mst@kernel.org>
 <1981309e2fa.31709fd32611761.5900055972026140740@linux.beauty>
 <20250716074207-mutt-send-email-mst@kernel.org>
 <198131a686b.18fb34702623779.7633947002456257034@linux.beauty>
 <1995f320053.73c58bde124269.3373604835167896043@linux.beauty>
 <19b0837500d.2713ffb3821327.2786629512090065997@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19b0837500d.2713ffb3821327.2786629512090065997@linux.beauty>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Dec 10, 2025 at 08:23:21PM +0800, Li Chen wrote:
> Hi Michael,
> 
>  ---- On Fri, 19 Sep 2025 07:38:56 +0800  Li Chen <me@linux.beauty> wrote --- 
>  > Hi Michael,
>  > 
>  >  ---- On Wed, 16 Jul 2025 19:59:14 +0800  Li Chen <me@linux.beauty> wrote --- 
>  >  > Hi Michael,
>  >  > 
>  >  >  ---- On Wed, 16 Jul 2025 19:42:42 +0800  Michael S. Tsirkin <mst@redhat.com> wrote --- 
>  >  >  > On Wed, Jul 16, 2025 at 07:41:11PM +0800, Li Chen wrote:
>  >  >  > > Hi Michael,
>  >  >  > > 
>  >  >  > > Thanks for your kind review! All issues below have been fixed in v5:
>  >  >  > > https://lore.kernel.org/qemu-devel/20250716111959.404917-5-me@linux.beauty/T/#m696cee9a95646add1b74b866c3d6761aa4c5c762
>  >  >  > 
>  >  >  > Past soft freeze now: I tagged this but pls remind me after the release
>  >  >  > to help make sure it's not lost.
>  >  
>  > Gentle reminder: This patch is still missing from the latest master branch, but can apply without
>  > any conflict. Can it be included in 10.2?
>  > 
>  > Regards,
>  > Li.
>  > 
>  > 
> 
> Sorry for bothering again. But I'm still unable to find this patch in the latest master branch, though it applies without conflicts now. 
> 
> Could it be merged now?
> 
> Regards,
> Li​

you still need to update loongarch, I think. otherwise these tests will
fail.

-- 
MST


