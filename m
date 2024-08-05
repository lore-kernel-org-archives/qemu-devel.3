Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881CDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 08:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1satND-0002wf-UY; Mon, 05 Aug 2024 04:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1satNB-0002tu-JU
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 04:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1satN9-0004zf-Ru
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 04:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722847639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IhXyA6kTxfGcw/ADEWO7uSjk15D6VpbfbtQJR0MexUs=;
 b=V5XL3A5d3MAcvzxTN70/86YzRDux9weXwiuSJbU+NC1XtEFKa0wQ9xwuipRT800jyRHAK6
 VDy7iiaJ+TAXFTCzYg+eAmzZuC7+sCJMKHZ0y7ll6PK2hWb1eZ8wirKBNKC0MCVpQEs0eC
 pEhyRz1HvfH6FOi/1bK92Y+bl9UbbgE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-l8bAIHq2NCqXlXTR8mtqoA-1; Mon, 05 Aug 2024 04:47:12 -0400
X-MC-Unique: l8bAIHq2NCqXlXTR8mtqoA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7ab644746eso854329666b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 01:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722847632; x=1723452432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhXyA6kTxfGcw/ADEWO7uSjk15D6VpbfbtQJR0MexUs=;
 b=giDKCsISJDRfluqZqFF0qeqbG4o/xfsS/fSObeVBzLO0QGtgYYQxAZWHdvJrvUbLEs
 EGjR15suA7NlRKpKxp7A/IF2LQ8/KrqfCcJ8EUG6FqgY0peD0U9F5Yz3VksO97r4+Nlb
 rgNzqHLyzdmgylDIo8b6D20X278rdMU7RxzWcvPvAak39UbntSPujvJ0gw+HDwnJ40VS
 KnJSZh7yg/QPEvZaEO/5yfR6h4cMKLUR7zv/aAFulEkFxJczr68Gs5Hk8a+M5J+1fciY
 x2jrPVaYB+oEUhryGtS1+sFDxPc8CNtXp9XqXrxvANbHuJG1imbTgoyeSgY2MWf7t38l
 yXCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwWW6WFMxqAeQXRIyL0WAGCcfYHLZNLaze3L5HO8o4kCunwmQrY18eJ/POTZRGGKJ9dcVEDrMrX11nmOq9lVEVkdwRSVk=
X-Gm-Message-State: AOJu0YyTzuBGG2TsDtq/9ujrdY7SYyfSbu5pFnUJz1StGbrdn5gdEVJs
 7EOK1Vce9cuhjcddGIMrZmqHmv169pN5u/bgvpFd1yDHEx70riSQFw7iT1e+JECPhr1nniB6nYW
 qsScjRIRoi5PB6ErjEkD6IAI0bbOHD99fJ590NEO/c1xsDGQAxohu
X-Received: by 2002:a17:907:d8b:b0:a7a:9447:3e8b with SMTP id
 a640c23a62f3a-a7dc4eac568mr692790366b.25.1722847631677; 
 Mon, 05 Aug 2024 01:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFujEsSyAysf5dKCKkHnWg52wzyxZ+FFN8D1gxoP7zkxapDHMntEUa9zzGmzwN0eeAK6wsv7g==
X-Received: by 2002:a17:907:d8b:b0:a7a:9447:3e8b with SMTP id
 a640c23a62f3a-a7dc4eac568mr692786266b.25.1722847630792; 
 Mon, 05 Aug 2024 01:47:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:dd95:f049:da1a:7ecb:6d9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bcadbesm424707666b.21.2024.08.05.01.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 01:47:10 -0700 (PDT)
Date: Mon, 5 Aug 2024 04:47:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH for-9.2 v12 00/11] hw/pci: SR-IOV related fixes and
 improvements
Message-ID: <20240805042635-mutt-send-email-mst@kernel.org>
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
 <20240805023719-mutt-send-email-mst@kernel.org>
 <42a4ef02-a14a-41a2-b1a9-357511afa163@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a4ef02-a14a-41a2-b1a9-357511afa163@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Aug 05, 2024 at 04:10:02PM +0900, Akihiko Odaki wrote:
> On 2024/08/05 15:39, Michael S. Tsirkin wrote:
> > On Sun, Aug 04, 2024 at 06:01:36PM +0900, Akihiko Odaki wrote:
> > > Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
> > > ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> > > 
> > > I submitted a RFC series[1] to add support for SR-IOV emulation to
> > > virtio-net-pci. During the development of the series, I fixed some
> > > trivial bugs and made improvements that I think are independently
> > > useful. This series extracts those fixes and improvements from the RFC
> > > series.
> > > 
> > > [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > > Changes in v12:
> > > - Changed to ignore invalid PCI_SRIOV_NUM_VF writes as done for
> > >    PCI_SRIOV_CTRL_VFE.
> > > - Updated the message for patch "hw/pci: Use -1 as the default value for
> > >    rombar". (Markus Armbruster)
> > > - Link to v11: https://lore.kernel.org/r/20240802-reuse-v11-0-fb83bb8c19fb@daynix.com
> > 
> > The igb issue is still with us, is it not?
> 
> Yes, if you are talking about the problem with s390x/libvirt. That is why it
> has for-9.2 tag.
> 
> It is actually not specific to igb but also affects nvme. The upcoming
> virtio-net-pci's SR-IOV will not be affected, but it is not present yet.

How about we fix it then? There's time enough for 9.2.
Also breaking any configurations should be documented in a commit log
of the change that causes the breakage. Pls do that in the future.

I understand the fact that you are trying to prevent errors
since it is hard to report them to guest cleanly.
But I guess we can pretend device does not respond to config cycles?


-- 
MST


