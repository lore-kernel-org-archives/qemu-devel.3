Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A126EE498A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soK9k-0000Of-3K; Wed, 11 Sep 2024 06:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soK9i-0000Nd-Cs
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soK9f-0008Nm-Q0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726048854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8vjdLqoeFTLpqU0+KvQcMLwZmmV/kJuMqfGyioSJAg=;
 b=OEtSOLmx5mNkTm6WYFlKYZ1pdfq4XMv2F0LYXQXQ+3LZv+z0QzW2OFH8+zcv/yu0Zw7H/S
 DTRqu2FBbHjehhXWaJLT6Uo2tCBwSa+FRF6/zKaPmKJOvNCqj6BEbgBp18lTdlwoNCRSpZ
 0HtZ0ngn+aGesFGMsLd/y+rfQxhlZJM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-EpqAhSM2Pui4FRaZglUWRQ-1; Wed, 11 Sep 2024 06:00:52 -0400
X-MC-Unique: EpqAhSM2Pui4FRaZglUWRQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a8d15eff783so252047366b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 03:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048851; x=1726653651;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b8vjdLqoeFTLpqU0+KvQcMLwZmmV/kJuMqfGyioSJAg=;
 b=rPUyBiGZaBHC+61nbO9jKc9QePZwlux5JFFpIxZCkgeNv2KTqqeYMimOn5vkJ7NsSV
 zel2middLG1DFapcPsXl/hFEtMPlXLARoUlqEJVDK47TUjXu4tAe4hT8OVN53bkoPETM
 7JKZ9uGew76c1spyVnnmTFAljgtf62RgWV2qMD83k2dsfK0Rr92SWtOtItjR/FY5t06M
 UboH+d13xpFwYk1oR5msXQBvEOZDQoFbe5unx5/MFlNci/fR+v+aCw4evKNM9E3HgmkH
 514dD0SFzmAh/1dE6+3FqRJIBFOf9u7efLemtulQ5mx2ZHxJrmALPNpCwdcqz3HP0ELl
 dyGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNU+MRIXFEtTxhHAOJ2XrzCnVMdenAym7psMLUlTJcfALg+RCgw2TxXJqt3ULf67Ds4sV/iOMcTRig@nongnu.org
X-Gm-Message-State: AOJu0YyZeGoXDwuGf9ifYVDAuQMslraiZ+dkLVJkfZk3wz/jHd2AeI6B
 K0NVyTZSD5eR2NvSKpDrRvCIVs/B6c9QKw65oUGWM0nDeEMz7cRPFqN5YdPTnQbNxGziAygO0Qf
 hGD1IGs7nYQ+M039p85LbC6Wair8yoarNPQzDuoAmA2Xkee4eqTV4
X-Received: by 2002:a17:907:7f8f:b0:a8d:2a46:6068 with SMTP id
 a640c23a62f3a-a8ffab8fe9fmr271577766b.39.1726048851424; 
 Wed, 11 Sep 2024 03:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6LkrnXJuTRljwY8HcYKhOOLqcd8JfY7mGV9b8p9EZwQVzIaKpApk70bHVuxSPA1htFiH+kg==
X-Received: by 2002:a17:907:7f8f:b0:a8d:2a46:6068 with SMTP id
 a640c23a62f3a-a8ffab8fe9fmr271570866b.39.1726048850209; 
 Wed, 11 Sep 2024 03:00:50 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a27a9fsm591467466b.91.2024.09.11.03.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 03:00:49 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:00:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH for-9.2 v15 00/11] hw/pci: SR-IOV related fixes and
 improvements
Message-ID: <20240911055558-mutt-send-email-mst@kernel.org>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240910052046-mutt-send-email-mst@kernel.org>
 <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
 <4adc32d0-02c1-4375-8618-2692a9b1da76@redhat.com>
 <20240910093440-mutt-send-email-mst@kernel.org>
 <6aeaa38c-22b9-4598-b07e-7adaee187562@redhat.com>
 <20240910112723-mutt-send-email-mst@kernel.org>
 <3f0e049e-8030-4901-98ea-be17369db59a@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f0e049e-8030-4901-98ea-be17369db59a@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 11, 2024 at 12:05:46PM +0900, Akihiko Odaki wrote:
> On 2024/09/11 0:27, Michael S. Tsirkin wrote:
> > On Tue, Sep 10, 2024 at 04:13:14PM +0200, Cédric Le Goater wrote:
> > > On 9/10/24 15:34, Michael S. Tsirkin wrote:
> > > > On Tue, Sep 10, 2024 at 03:21:54PM +0200, Cédric Le Goater wrote:
> > > > > On 9/10/24 11:33, Akihiko Odaki wrote:
> > > > > > On 2024/09/10 18:21, Michael S. Tsirkin wrote:
> > > > > > > On Fri, Aug 23, 2024 at 02:00:37PM +0900, Akihiko Odaki wrote:
> > > > > > > > Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
> > > > > > > > ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> > > > > > > > 
> > > > > > > > I submitted a RFC series[1] to add support for SR-IOV emulation to
> > > > > > > > virtio-net-pci. During the development of the series, I fixed some
> > > > > > > > trivial bugs and made improvements that I think are independently
> > > > > > > > useful. This series extracts those fixes and improvements from the RFC
> > > > > > > > series.
> > > > > > > > 
> > > > > > > > [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
> > > > > > > > 
> > > > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > > > 
> > > > > > > I don't think Cédric's issues have been addressed, am I wrong?
> > > > > > > Cédric, what is your take?
> > > > > > 
> > > > > > I put the URI to Cédric's report here:
> > > > > > https://lore.kernel.org/r/75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com
> > > > > > 
> > > > > > This issue was dealt with patch "s390x/pci: Check for multifunction after device realization". I found that s390x on QEMU does not support multifunction and SR-IOV devices accidentally circumvent this restriction, which means igb was never supposed to work with s390x. The patch prevents adding SR-IOV devices to s390x to ensure the restriction is properly enforced.
> > > > > 
> > > > > yes, indeed and it seems to fix :
> > > > > 
> > > > >     6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")
> > > > > 
> > > > > I will update patch 4.
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > C.
> > > > > 
> > > > > 
> > > > > That said, the igb device worked perfectly fine under the s390x machine.
> > > > 
> > > > And it works for you after this patchset, yes?
> > > 
> > > ah no, IGB is not an available device for the s390x machine anymore :
> > > 
> > >    qemu-system-s390x: -device igb,netdev=net1,mac=C0:FF:EE:00:00:13: multifunction not supported in s390
> > 
> > 
> > So patch 4 didn't relly help.
> > 
> > 
> > > This is what commit 57da367b9ec4 ("s390x/pci: forbid multifunction
> > > pci device") initially required (and later broken by 6069bcdeacee).
> > > So I guess we are fine with the expected behavior.
> > > 
> > > Thanks,
> > > 
> > > C.
> > 
> > Better to fix than to guess if there are users, I think.
> 
> Yes, but it will require some knowledge of s390x, which I cannot provide.
> 
> Commit 57da367b9ec4 ("s390x/pci: forbid multifunction pci device") says
> having a multifunction device will make the guest spin forever. That is not
> what Cédric observed with igb so it may no longer be relevant, but I cannot
> be sure that the problem is resolved without understanding how multifunction
> devices are supposed to work with s390x.
> 
> Ideally someone with s390x expertise should check relevant hardware
> documentation and confirm QEMU properly implements mutlifunction devices.

The fact is, QEMU already does what most users want from it. So the
first rule whenever adding a new feature is not breaking old
functionality.  I know, it's annoying, as some of it is held together by
duct tape.  We have a friendly community so if you ask nicely, you
usually can get help. You'd probably have to be a bit more specific
with your questions.

> Let's keep the restriction until then.
> 
> Regards,
> Akihiko Odaki


Not introducing regressions is a hard rule, sorry.

-- 
MST


