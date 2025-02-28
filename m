Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137EAC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to02u-00006t-JH; Fri, 28 Feb 2025 08:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1to02r-0008VC-Bo
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:04:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1to02p-00070V-7s
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740747884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mu9FPPsmEvEks/3/xAxXVst93bcV5zsiog/7waQuz+E=;
 b=ga2k4XPZt44/JI0tWar35q9S9a+zWZiMaJ0Z8m8CxsFMt9lvtknEmXOHMgW/zpHOwds8du
 rlFkP4Ju3xGCPp0vwo0rDasV3PuV+vIz2WPYgWPG5xzEuAFeq0+W5VWRTNVq1bI844sxz8
 8A8jDVRcTkBtVa1K6hRFe0AH3eMY/Ws=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-_kr_GfVZPKGDKG0ZFmkYWg-1; Fri, 28 Feb 2025 08:04:43 -0500
X-MC-Unique: _kr_GfVZPKGDKG0ZFmkYWg-1
X-Mimecast-MFC-AGG-ID: _kr_GfVZPKGDKG0ZFmkYWg_1740747882
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4394c0a58e7so13584985e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 05:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740747882; x=1741352682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mu9FPPsmEvEks/3/xAxXVst93bcV5zsiog/7waQuz+E=;
 b=ADQZjyQWzNH7pVWddVxHT8huhSfy95GjNviYm2fPaCBZ04W4FbMa134fe/On04o74q
 4ttVMKQUYiQa3hj7d0JZcZCC4NFZzlEJ1GHau96oROX6v62D7NbBJVmPUJnxUrU3oVBj
 G2L7hMu5G10C/0oCE4ffECBH+1B4LLQWOXffXKVdVJ1ouKeE97s9apl967c3wmMwUvu8
 WuoAx2PyICTkI3y6dgQR0hdCOTteFQe/28Zu47SNiPy0A0HZcGZdGm9lgUIqNlxRjVXJ
 MLAeBetwbOb9n9cr690m3Ig5+dx3BHsqYLyInH4GvhfLNyuLZSzbGKowRdF6OtT9NhNC
 /u4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1tjbDtRNk/Il8kWbvKpIOjqtFXt6VyVU5FN/apbvweKZUmbrNw3Zo4EzBYBzM+MeFSIT+9LjBxdN2@nongnu.org
X-Gm-Message-State: AOJu0YwCQFymS+XcF/iWNDjr2Y+TD+2J4dGT3Ik8n3RNg3AObanigjVQ
 HGuUirRUjH7nKXTEQZiHkGLeZKqL2fdw+htwekplya6OzOmq0NIrXEvUp8W/jg4NOC4OYpnSUgQ
 pMjdNepgL6j/68Ga6PYv7+32HbRqLcCE+S4KWVasVZXrRicnr91JE
X-Gm-Gg: ASbGncsU04NZwfQJTgecWu3iU8pTGFI5mkJ49Ib81Fd8oA/dOtTOxvB658OxP0JHVxM
 H/hm9HjzXwkUh1lFv/elDAYfp3OHY/E+a8nfi9knWpzr5U6G5qRKwT6b/BWa//sA3Dz1eQ62034
 RsjLeMcOZ1oqzxAa+IO+M4ytT/ZFj8lcIylRYApeD2nOSinffFy5rgE5GNpFLerNR/ce5xSTMIG
 r53HIHdKeqqlOd2sEYqLQ7jjqsaeW0BldtG6FaUhnV3AEwyOa1ScX6jtHbpOZtXA1EUtJy8+FcG
 dN1giP5Xcp1NUM1Hsg0c7rYzli3Bu8VpfauPKyvvaDhYfl67PyUcXRMzTXoM92A=
X-Received: by 2002:a05:600c:1912:b0:439:a1b8:a246 with SMTP id
 5b1f17b1804b1-43ba66f9643mr29722525e9.8.1740747881722; 
 Fri, 28 Feb 2025 05:04:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBiKjFTEf6xyVhifkY1bhOUt08H/FdpNbBvHTlAFX/nNPPBfQlbA3XEVmZ4B4eeXi37peB0A==
X-Received: by 2002:a05:600c:1912:b0:439:a1b8:a246 with SMTP id
 5b1f17b1804b1-43ba66f9643mr29721915e9.8.1740747881242; 
 Fri, 28 Feb 2025 05:04:41 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5710f6sm91962555e9.29.2025.02.28.05.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 05:04:40 -0800 (PST)
Date: Fri, 28 Feb 2025 14:04:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Ani Sinha
 <anisinha@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 17/19] tests/acpi: virt: update HEST and DSDT tables
Message-ID: <20250228140439.450611bd@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250228104400.5ac2f7b1@foz.lan>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
 <7a6a1a1ba78f7dac2be6b7335280c1d0b380a175.1740671863.git.mchehab+huawei@kernel.org>
 <20250228173318.00000f9d@huawei.com>
 <20250228104400.5ac2f7b1@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 28 Feb 2025 10:44:22 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Fri, 28 Feb 2025 17:33:18 +0800
> Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
> 
> > On Thu, 27 Feb 2025 17:00:55 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > - The HEST table now accept two sources;
> > > - The DSDT tables now have a GED error device.
> > > 
> > > @@ -1,39 +1,39 @@
> > >  /*
> > >   * Intel ACPI Component Architecture
> > >   * AML/ASL+ Disassembler version 20240322 (64-bit version)
> > >   * Copyright (c) 2000 - 2023 Intel Corporation
> > >   *
> > > - * Disassembly of tests/data/acpi/aarch64/virt/HEST
> > > + * Disassembly of /tmp/aml-DMPE22    
> > This is an artifact of where you happened to get file
> > from so if we are being really fussy drop the change 
> > diff in the patch description for it.  I don't really care though.  
> > >   *    
> 
> True, but on the other hand, this is the only place at the diff
> saying what table the diff is against (HEST, in this case), as I had to
> remove the information before @@, as it was causing troubles when Igor
> were trying to apply the patch (plus on checkpatch).
> 
> That' why I opted to keep this hunk.

I'd drop this up to '* ACPI Data Table [HEST]' line.
But doesn't really matter, as long as reader can get what 's going on.
(there were precedents just putting snippets of diff)

Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
> Regards,
> Mauro
> 
> 
> Thanks,
> Mauro
> 


