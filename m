Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C7CC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Pys-0000dH-IX; Tue, 15 Sep 2026 06:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6Pyl-0000bw-Fg
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6Pyj-0006HZ-8j
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789466487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sr3m6jvafB4TKzh+XEL6+EJfmxYz3zHLXwHUK9v/tAg=;
 b=B86bEncnhTXhy18AfgYryCUHmhuoEo6O9xxXuN0GA7yhfpgL9OD0E3ikB+1UIMky1bg264
 1s6yrr7cqTbwg39/ZnnTSAvcPL4kPn7+pUSDYWnd7Hy1BtqcdDDpcFBNpihB3Lxds1pvZb
 JA1lRM00Z/amXkxTBZbswp0Nk1qkwx4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-b1_IF_cNPV-M_R62NQpcmw-1; Tue, 15 Sep 2026 06:01:25 -0400
X-MC-Unique: b1_IF_cNPV-M_R62NQpcmw-1
X-Mimecast-MFC-AGG-ID: b1_IF_cNPV-M_R62NQpcmw_1789466483
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c294c2dcdf5so396686766b.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789466483; x=1790071283; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sr3m6jvafB4TKzh+XEL6+EJfmxYz3zHLXwHUK9v/tAg=;
 b=rx4X/L0MmXvHhF5irzsj05QvReKZRz0JHd3tmwzCqw5i7Lyzhyz//3o34F7NyERSP0
 +IzzYXJ3DxPy/xUMhmQ2hdtzeEIXyvkGv+HiA2pBqf0gEYTlwDnF5P0+mzbEy2P/K5DM
 jiROo35DqQnrSdgEFxWxMJt/n6Ll0TVOWIuSkBs6Fc42aRK1Onj4CZ0vECD4aVOoRvDc
 TeEqlR2+iNxkkc5tERtYTgwOVWhKm3O5E81cmXmUCrrkX8uorZdInwuflAXvsAYCssM3
 v4kxis399yINbWCkpioSaam3Peqi9GEU0I8OP2mX97STh3oKRveUifrl3/P1Wboa5kXq
 M1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789466483; x=1790071283;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sr3m6jvafB4TKzh+XEL6+EJfmxYz3zHLXwHUK9v/tAg=;
 b=Pq8m/+iPkTefOuMJluG2EIp3MX3CCLFjztaiHyDzIa4zIjI45n7fp44JNgaDJx3NbM
 YI2PGkKkWHTYEYtFcjL+M0c50OsCaDc82DLc6GCy3a4ThVjPsi48ZoS4iu/19gVlEU2D
 jvHNT6K73YtgRG6iObASIsx9/71VXMlPxyBA80smGkii7Y5kp19bgo3DhhDeewMqyrAX
 hplVIIagaEoxzkXZMGSgTvekDWvVpKwKTAefQABvEKZ25n+xuokh74H/BnRqI46F+Jqj
 nU8+7xhYuyU4Vpg8v0agEfRbO5WVgdrQRlBsAFsxENfWu10oT24RjiqJeO6jmpt9OnHJ
 dMPQ==
X-Gm-Message-State: AFuF++kdhHNIL9TUnypPjcL8RiOsl7sKVsRwug9MsgdsQUGPPaxRwF6P
 3ox+5yx4CUVXVDV0tOHqyOhu3Ju29Tj2KIPO5MzTsKyj4GO4II7VTEdKbKOU+vb7uT5tfGqxXzd
 BFC168HRKdfVeDm5+dxraxb5MGwUgYQou+sDN8dmRu2K9f7TUPEotZuwmp7CEPNhf
X-Gm-Gg: AYBFou0ZBxhVZFGDmySCYwlxGspJP4ZViDmZhk4QeYhPrK5XpPIBQdaZgtRGYpkSvt5
 TOMLn0Qx+Skp1vJwNoV3x65h/ONCGWIAePqLCA2MUOnzftWh9vCQ9m8juCNEQBdF+pajdjpIP3F
 DtkzWmvEpV/6m0ZE5O5+Py/Lkx8vlnhRqmDbvRN15Uq3Jj7AQsQ1OgMwLeOyY5Dee+ujKcFkfu/
 V09QKIRn5CAfn3Pd76C1CyZY4mNO2PuXUHgYl3T98XpBLYeGiNhu5etq+7DELLmJl+SEdv3zNRQ
 oAftI/tRjsYOqXbPu4mTwl1Py0ZXASFrKxgYzdIOYdk0uHZ3ZLZhuqtAY2nhUQc9FpE5H4/h6dm
 wW9OtgES04Nkqgs3In4cZuSo=
X-Received: by 2002:a17:907:9410:b0:c25:9102:ed with SMTP id
 a640c23a62f3a-c29d773fc59mr36550066b.5.1789466483258; 
 Tue, 15 Sep 2026 03:01:23 -0700 (PDT)
X-Received: by 2002:a17:907:9410:b0:c25:9102:ed with SMTP id
 a640c23a62f3a-c29d773fc59mr36545866b.5.1789466482729; 
 Tue, 15 Sep 2026 03:01:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966026fb1sm570772866b.11.2026.09.15.03.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:01:22 -0700 (PDT)
Date: Tue, 15 Sep 2026 06:01:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/2] hw/pci-bridge: Add x-speed and x-width properties to
 xio3130 ports
Message-ID: <20260915060015-mutt-send-email-mst@kernel.org>
References: <20260915072507.1230187-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915072507.1230187-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 15, 2026 at 09:25:05AM +0200, Cédric Le Goater wrote:
> Hello,
> 
> The xio3130-downstream and x3130-upstream devices lacks x-speed and
> x-width device properties, making it impossible to configure PCIe link
> speed/width when building PIX switch topologies for GPU/NIC passthrough.
> 
> Fix that and preserve migration compatibility with a 2.5GT/s x1 default.
> 
> Thanks,
> 
> C. 

Given they are clearly intended for users, time to rename to width/speed
everywhere?

> Cédric Le Goater (2):
>   hw/pci-bridge: Add x-speed and x-width properties to
>     xio3130-downstream
>   hw/pci-bridge: Add x-speed and x-width properties to x3130-upstream
> 
>  hw/core/machine.c                  |  4 ++++
>  hw/pci-bridge/xio3130_downstream.c |  5 +++++
>  hw/pci-bridge/xio3130_upstream.c   | 28 +++++++++++++++++++++++++++-
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 
> -- 
> 2.55.0


