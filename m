Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C344D33998
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 17:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRZLX-0003rt-IH; Fri, 05 Dec 2025 12:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vRZLV-0003rC-Gy
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 12:11:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vRZLT-00031Y-VK
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 12:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764954710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNytRVLMJ9bmiuY7ZutC5lrzp9SQA28eX61wZwI6znY=;
 b=Gx/j815zkQwyBkXJ5rBNM6Fj1pws04TjDD7kYy8ysqf8idubIrwZ5xgle//N8I7X49/Qty
 V/j33nXLGHMzbDp90htOm1du7o9k+kLN/htIKN7zK2oPsOX3l1JpwUIi71QhSDaUavMhGV
 QX8/r+uD4hpdDUtNDgE+V5fciQ6gol8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-GPcuHMU-MnanoqP5gzNCow-1; Fri,
 05 Dec 2025 12:11:48 -0500
X-MC-Unique: GPcuHMU-MnanoqP5gzNCow-1
X-Mimecast-MFC-AGG-ID: GPcuHMU-MnanoqP5gzNCow_1764954707
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BF8D180A21F; Fri,  5 Dec 2025 17:11:47 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.174])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16017180029A; Fri,  5 Dec 2025 17:11:44 +0000 (UTC)
Date: Fri, 5 Dec 2025 18:11:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, akihiko.odaki@daynix.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] pcie_sriov: Fix PCI_SRIOV_* accesses in
 pcie_sriov_pf_exit()
Message-ID: <aTMSTjDMRRtT0Rxr@redhat.com>
References: <20251205145718.55136-1-kwolf@redhat.com>
 <20251205100242-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205100242-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 05.12.2025 um 16:03 hat Michael S. Tsirkin geschrieben:
> On Fri, Dec 05, 2025 at 03:57:18PM +0100, Kevin Wolf wrote:
> > PCI_SRIOV_* are offsets into the SR-IOV capability, not into the PCI
> > config space. pcie_sriov_pf_exit() erroneously takes them as the latter,
> > which makes it read PCI_HEADER_TYPE and PCI_BIST when it tries to read
> > PCI_SRIOV_TOTAL_VF.
> > 
> > In many cases we're lucky enough that the PCI config space will be 0
> > there, so we just skip the whole for loop, but this isn't guaranteed.
> > For example, setting the multifunction bit on the PF and then doing a
> > 'device_del' on it will get a larger number and cause a segfault.
> > 
> > Fix this and access the real PCI_SRIOV_* fields in the capability.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: 19e55471d4e8 ('pcie_sriov: Allow user to create SR-IOV device')
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> Thanks for the patch! something small to improve:
> 
> > ---
> >  hw/pci/pcie_sriov.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> > index c4f88f09757..d467284cbda 100644
> > --- a/hw/pci/pcie_sriov.c
> > +++ b/hw/pci/pcie_sriov.c
> > @@ -195,14 +195,17 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
> >  
> >  void pcie_sriov_pf_exit(PCIDevice *dev)
> >  {
> > +    uint8_t *cfg;
> > +
> >      if (dev->exp.sriov_cap == 0) {
> >          return;
> >      }
> > +    cfg = dev->config + dev->exp.sriov_cap;
> 
> initialize cfg at the point of declaration maybe? I think it would
> be clearer.

That's what I had first, then changed it to make it clearer that the
pointer is only guaranteed to be valid after the dev->exp.sriov_cap
check. But either way works for me. Let me know if I should send a v2
that puts it back on the top.

Kevin


