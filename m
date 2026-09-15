Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE451C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WDJ-0005OB-FC; Tue, 15 Sep 2026 12:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WDI-0005O2-0N
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WDF-0005jf-Jd
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789490451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLCvY19BbPPZXaakk/6ZB8ATI+SegfXFV/ABlT/FgYA=;
 b=gaYJIq3cB2JMpNJkF1+iVlsM7p6ChfxibOWAoOjD1Tj63oZY0VqO/pvExW/0CUvxyv9vfa
 wJP0QjVSWxmEk0wR/IJ1be4hkbs2fMPlok+DzBZgs4BenER1JDm65r9GCL9dwASmsVFzxz
 py5PP4LgnhARbgyccsPHKMZSEnzOJdo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-JJ9er4waMpG0v8enX4_Fgg-1; Tue, 15 Sep 2026 12:40:48 -0400
X-MC-Unique: JJ9er4waMpG0v8enX4_Fgg-1
X-Mimecast-MFC-AGG-ID: JJ9er4waMpG0v8enX4_Fgg_1789490447
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cd55ee2f7so40582085e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789490447; x=1790095247; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mLCvY19BbPPZXaakk/6ZB8ATI+SegfXFV/ABlT/FgYA=;
 b=KmoFM6oyTHBI+xtI0Tq+yzrrbPToe2TmDTwnS5UUPxKLRam5GIsR/5gLbC0LAUgJA1
 OQ/BfzkU7XbWmrqciWDKyICjBkeFBUUpM5wWfybFOTS3snin2jg9d3R5nv73qabbNJP4
 wElaL81utS5s+jaFqv84IzTmhtnQ16p5b9G3zdSrikRAF6vKtRr9lzPp1hbhG8ynR00Z
 0XpFIJNx7VI8ntfhwmTllfkdhfWxf6dnhNeXg7qfJkhsw3aDAOXqyjHE/n23Mx3pzB8p
 QoeOLeRHU51IulWQc2CRrICcYiU4YF0hstE3njWrlX/aeXRuYpxbm217GWZ62Bio4X/K
 Ogww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789490447; x=1790095247;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mLCvY19BbPPZXaakk/6ZB8ATI+SegfXFV/ABlT/FgYA=;
 b=V65roiTooqqFfX8xS6faLcC+pvWo2UOnBVPWTLhMmOP1kYcvNHPjI4LtVWDQkkR5MC
 FW+j6f/+adxAxyxNA3avSeFe86eXo8ZjY6+/YpaGUZfGaoTjS8kl90j727NXGocOgIgd
 SUbykLT83wfOXuqs9jGTw+hWP6Tz/XCvupdJLov81Th94Ak3pCHpCZTpEcwWWps6Imv2
 rqead2pkLHEa62FJzKkw0b/tFKbh55vWukEdjSVcAzW4PXwyEoyNXuB/zGuGMpyVD/go
 E/iMHfuKShw3DUzLl7QdGABHontCsRJQSh4VNBdx9k9LR9oEd4G+gBTTspeTXNiEDJK4
 khWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXOE+UweiEJ4rtbs8OMxCO/tV8ztLhfOhRNkA5XmdanK6vAPqOlK/3u1+mQEyMiAlUBADbg8rSd4ir@nongnu.org
X-Gm-Message-State: AFuF++lSz4wKnGcABy+pDRlAkam5640qNOXtKQzn4LXrzYVyHyxHcBYw
 QLbTdZwj2luSoSJvNRfygzCO/Vi0c7F40OUk9fnvM9thxbOEVuLp1RjDx8eRtLVC5cUUmSCg/Gb
 VZVk5hpUekXGEKy+BDk8dnCSrOvQXcCvE1IwSuveLk9EEuhJ09YIwTbAL
X-Gm-Gg: AYBFou26v8WuPvUpGDHBYK65BIEc5N7jX/f1wXnFyC9GC0ig0YauKaQiPgYhvZ4Nm5L
 8UUP6UorqRPDwR/Wfg8oOdrDk7NAzJKGquD/wFxmKyM/CV43KEEboN1Zo4hS476dAdRwLlkc2Ot
 9MN4nCh3Tly2v+7Jn5oMHNb02VQgIyB45NapNWZNMP8dS15XJG10MJME+tK56B6zxhdaxGEInBm
 d5rHqQLf/Pb4ek29end2VtYYNo+TI0pWWfP7hpfgW88Gn1bP+k0hfXaXlpLXu9VyhX5A67xu7od
 qN+tSJtjXx3l/w8j7iy8IrjiWyH6iB1lAn/UDb3qjMf6EfJ0otaO1PN2BmSPeveZt+eHJ5/Pl7S
 7sR2YPUq3V/YIBiJSKveh30g=
X-Received: by 2002:a05:600d:864c:10b0:49e:69ff:c6b1 with SMTP id
 5b1f17b1804b1-49e7a69c2b2mr71535335e9.31.1789490446665; 
 Tue, 15 Sep 2026 09:40:46 -0700 (PDT)
X-Received: by 2002:a05:600d:864c:10b0:49e:69ff:c6b1 with SMTP id
 5b1f17b1804b1-49e7a69c2b2mr71534915e9.31.1789490446173; 
 Tue, 15 Sep 2026 09:40:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf34440sm249850f8f.25.2026.09.15.09.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:40:45 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:40:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: David Vrabel <david.vrabel@nutanix.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex@shazbot.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/2] hw/pci-bridge: Add x-speed and x-width properties to
 xio3130 ports
Message-ID: <20260915121404-mutt-send-email-mst@kernel.org>
References: <20260915072507.1230187-1-clg@redhat.com>
 <20260915060015-mutt-send-email-mst@kernel.org>
 <81c899d9-a9fb-4eb2-ad85-7dde2f626646@nutanix.com>
 <20260915102221-mutt-send-email-mst@kernel.org>
 <1ef3b146-88b6-4c34-96f1-a272cf9b52d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ef3b146-88b6-4c34-96f1-a272cf9b52d9@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Sep 15, 2026 at 05:36:16PM +0200, Cédric Le Goater wrote:
> On 9/15/26 16:22, Michael S. Tsirkin wrote:
> > On Tue, Sep 15, 2026 at 12:17:31PM +0100, David Vrabel wrote:
> > > On 15/09/2026 11:01, Michael S. Tsirkin wrote:
> > > > 
> > > > On Tue, Sep 15, 2026 at 09:25:05AM +0200, Cédric Le Goater wrote:
> > > > > Hello,
> > > > > 
> > > > > The xio3130-downstream and x3130-upstream devices lacks x-speed and
> > > > > x-width device properties, making it impossible to configure PCIe link
> > > > > speed/width when building PIX switch topologies for GPU/NIC passthrough.
> > > > > 
> > > > > Fix that and preserve migration compatibility with a 2.5GT/s x1 default.
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > C.
> > > > 
> > > > Given they are clearly intended for users, time to rename to width/speed
> > > > everywhere?
> > > 
> > > A more comprehensive series (hw/pci-bridge: Configurable apparent bandwidth
> > > for the PCIe topology) is here:
> > > 
> > > https://patchew.org/QEMU/20260908155223.164787-1-david.vrabel@nutanix.com/
> > > 
> > > This adds new upstream and switch port devices with configurable speed/width
> > > and renames the options so they are non-experimental (but do not the open
> > > question about the usability of the speed option with the need to set 2.5
> > > GT/s as the string "2_5").
> > > 
> > > I did consider adding options to the XIO3130 device but since the real
> > > hardware is Gen 1 only and does not support speeds/widths other 2.5GT/s/1x I
> > > didn't consider it appropriate to claim these emulated ports are more
> > > capable than the real hardware.
> > > 
> > > David
> > 
> > Right that makes more sense to me.  Cédric what do you think?
> 
> I didn't know about it.
> 
> Regarding HW accuracy, I agree XIO3130 being Gen 1, the new speed
> and link are inaccurate and this could confuse some tools checking
> vendor/device ID.
> 
> Regarding the code size, user facing changes, existing topology,
> migration, etc, boosting XIO3130 capabilities is safer. What is
> worrisome is the downstream impact. backports will be a problem.
> That said I didn't check.
> 
> David's proposal is preferable, as the device doesn't pretend
> to be real HW and should be pursued for upstream. Mine would be
> more a fallback solution for downstream. Hopefully not,
> 
> Cheers,
> 
> C.

I don't know what the big deal is. new hardware is easy to add to
libvirt. I just coded it up quickly it's like 30LOC, excluding tests.
Pls check that option.

-- 
MST


