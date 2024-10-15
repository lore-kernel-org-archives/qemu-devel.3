Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFFDD2169D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jLh-0008M9-KZ; Tue, 15 Oct 2024 11:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0jLd-0008LY-Lj
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0jLc-0003pq-3w
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729005630;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mpcg8gnbV8AN09mf5ompV7tyb4M8YE+MHMTHD9to0SU=;
 b=gG8WZtmdyR+3lwwfpg+xGXRmm7KgteltyttnZ2vjpSimlzGAbndwkd746bTlZgNnwltcDe
 ahNLvuPObQLhOaEkmUPwW4+wRdw/twdUnemtPqsTMDw6B8GJIu0mVI3MCC6nshjqNFzbHq
 J46+O33q4iwATxzbTT4wbwOQsuppOzM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-qcbLC4TsOUqMUXg3E_r-0g-1; Tue,
 15 Oct 2024 11:20:26 -0400
X-MC-Unique: qcbLC4TsOUqMUXg3E_r-0g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 853051955F3D; Tue, 15 Oct 2024 15:20:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.118])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E036A1956086; Tue, 15 Oct 2024 15:20:20 +0000 (UTC)
Date: Tue, 15 Oct 2024 16:20:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jan Luebbe <jlu@pengutronix.de>, qemu-devel@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: Re: [PATCH] hw/sd/sdcard: Allow user creation of eMMCs
Message-ID: <Zw6IMVkNbNPXmloN@redhat.com>
References: <20241015135649.4189256-1-jlu@pengutronix.de>
 <5fb5f318-6fd0-4390-9314-528acc5d8901@linaro.org>
 <f34082e5-fb7e-47c8-b149-6557b02f81d4@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f34082e5-fb7e-47c8-b149-6557b02f81d4@kaod.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 15, 2024 at 05:17:26PM +0200, Cédric Le Goater wrote:
> On 10/15/24 17:00, Philippe Mathieu-Daudé wrote:
> > On 15/10/24 10:56, Jan Luebbe wrote:
> > > For testing eMMC-specific functionality (such as handling boot
> > > partitions), it would be very useful to attach them to generic VMs such
> > > as x86_64 via the sdhci-pci device:
> > >   ...
> > >   -drive if=none,id=emmc-drive,file=emmc.img,format=raw \
> > >   -device sdhci-pci \
> > >   -device emmc,id=emmc0,drive=emmc-drive,boot-partition-size=1048576 \
> > >   ...
> > > 
> > > While most eMMCs are soldered to boards, they can also be connected to
> > > SD controllers with just a passive adapter, such as:
> > >   https://docs.radxa.com/en/accessories/emmc-to-usd
> > >   https://github.com/voltlog/emmc-wfbga153-microsd
> > > 
> > > The only change necessary to make the options above work is to avoid
> > > disabling user_creatable, so do that. The SDHCI-PCI driver in the Linux
> > > kernel already supports this just fine.
> > > 
> > > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> 
> Nice !
> 
> Would it be possible to add an avocado test ?

NB, no new avocado tests please. Only use the recently introduced
'functional' tests framework for new tests.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


