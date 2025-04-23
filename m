Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5854C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 15:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7c8m-0004hV-L3; Wed, 23 Apr 2025 11:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7c8l-0004hK-4J
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7c8j-0003vY-Cg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745422553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jQNvuHCScjFaZqJ/QfkLgsR4mPSgirHD/vypW1G2NWA=;
 b=V8cKOU3XjO5bTTiC2GWiqjhvoom0pzZ5TzD7Mt5B4ogYQ39TSKujPujPGAChLNKpsmE/lZ
 cqKX4M/t0PrPtqtvSe58HXc9g8A/xZ11wiiMAiX/4eyvvIdVHy9HZx6SD2+Qwi4tvDJ2lv
 /0PzSeBRho+sLvHqsqFwW/LIp20o+HQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-O77d_oY1Pr2DBtY__6cKWw-1; Wed, 23 Apr 2025 11:35:52 -0400
X-MC-Unique: O77d_oY1Pr2DBtY__6cKWw-1
X-Mimecast-MFC-AGG-ID: O77d_oY1Pr2DBtY__6cKWw_1745422551
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391315098b2so2013837f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 08:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745422551; x=1746027351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQNvuHCScjFaZqJ/QfkLgsR4mPSgirHD/vypW1G2NWA=;
 b=tvwI3/GSBP5mEgHz+F4BI2An3Z263p8cmd2pkf5jTQQDftPai+SOfQ1ygJrBEpAV0g
 0HED/bs2XM7CmSqyWcde+mZAalr69iOxQaKVkXV0CnllKQg131tbhVhg9cm0g3Ql3i5l
 8yJliauhuZr5cH25+jP4Y56oogzuO3kkBGT0p9fkOuCv+Lj/v9HjZN12HJ/rKtrNG+l5
 XDLxsQHFvjAoS/EIkq1OuLR4bjs3INOfcO2ljYcLzmxsGejv6HhPAPun5XzFYFLo7eLz
 vzQDLGEoCmDEbvv0knwwx+AEV4HA5k5DIKqo8fpxuujyjlSN9KxDPo2yMRtCO3rKJV6s
 brbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW97Yq+vQBu3ETgjOlhY6tfWNylh2r3o7VS5NwjU3EHDxbf6rt0l8WdyIVA8GsAaH0Ts+XuM6VmV2hb@nongnu.org
X-Gm-Message-State: AOJu0Yz2JE7Qz4hLw9vhMzRAsSP6HPVojDf041H7+3EIkDtA7r7eLi0x
 lhDLh+B00SgxcTwzENs04n9fR1omiQuoPcYjmNRy0189TzAacpzjMj0GLG3nDOQMvAZCUks1YRO
 UNE2cY6sP3oFWeHw33vQqMQe/TtgG6q0pn7sFxokusYLzN8BwzOkZ
X-Gm-Gg: ASbGncsqCi/pUpELSSmzsM7saGXTpWilSrSPsq4/p5W8d1ok7TBfbIp1rpI8a/x0dAH
 +C3J4TimwQ+stWeUdqiD5xaMyIL7/GIKOjx3CmDH6W4zC8LTuj7O94Thw8K1PJy6lMapkxf1PKw
 EylDsdn3I2HrIGBC3424Cl9RDC/0EZW7rjhTE2q4v9Ecdhpy+KhGSsuRmIu+j9qwgUh/FK4JRxs
 PZZW9CgDmFHUzlZ+0JH0BxuVeuzc9pbBsiOgSGDotrZ7/gCe+r8HckN0fvVSZrWimu41wkTpqtt
 zdZeBA==
X-Received: by 2002:a5d:64a5:0:b0:391:253b:4046 with SMTP id
 ffacd0b85a97d-39efba45fedmr15233287f8f.16.1745422550996; 
 Wed, 23 Apr 2025 08:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbGtniVEZls4OvAnRwRhE9SRTBoDcSY+dE4gRzcFTp9HpJojtfPVOiSUMny5JZmF62KT9Ucg==
X-Received: by 2002:a5d:64a5:0:b0:391:253b:4046 with SMTP id
 ffacd0b85a97d-39efba45fedmr15233260f8f.16.1745422550612; 
 Wed, 23 Apr 2025 08:35:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4930e4sm19210895f8f.73.2025.04.23.08.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 08:35:49 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:35:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: Alireza Sanaee <alireza.sanaee@huawei.com>, yangyicong@hisilicon.com,
 qemu-devel@nongnu.org, anisinha@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com,
 peter.maydell@linaro.org, prime.zeng@hisilicon.com,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com
Subject: Re: [PATCH v3 4/5] hw/acpi/aml-build: Update the revision of PPTT
 table
Message-ID: <20250423113447-mutt-send-email-mst@kernel.org>
References: <20250423114130.902-1-alireza.sanaee@huawei.com>
 <20250423114130.902-5-alireza.sanaee@huawei.com>
 <20250423083909-mutt-send-email-mst@kernel.org>
 <6b783651-e952-ffe9-6c49-7ee9459741c8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b783651-e952-ffe9-6c49-7ee9459741c8@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 23, 2025 at 10:15:42PM +0800, Yicong Yang wrote:
> On 2025/4/23 20:39, Michael S. Tsirkin wrote:
> > On Wed, Apr 23, 2025 at 12:41:29PM +0100, Alireza Sanaee wrote:
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> The lastest ACPI spec 6.5 support PPTT revision 3. Update it
> >> by handy. This is compatible with previous revision.
> >>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > 
> > 
> > I don't get it. Why are you updating it? Which features
> > from the new one are you using?
> > 
> 
> no new features for this patchset. considered updating it to the latest ACPI
> spec since we're going to touch the PPTT table and tested data.

it's best to wait until there are actual features you need.
don't make changes for the sake of changes, there's always
some risk.

> >> ---
> >>  hw/acpi/aml-build.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> >> index 3010325ca423..e5401dfdb1a8 100644
> >> --- a/hw/acpi/aml-build.c
> >> +++ b/hw/acpi/aml-build.c
> >> @@ -2155,7 +2155,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> >>      uint32_t pptt_start = table_data->len;
> >>      uint32_t root_offset;
> >>      int n;
> >> -    AcpiTable table = { .sig = "PPTT", .rev = 2,
> >> +    AcpiTable table = { .sig = "PPTT", .rev = 3,
> >>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> >>  
> >>      acpi_table_begin(&table, table_data);
> >> -- 
> >> 2.34.1
> > 
> > 
> > .
> > 


