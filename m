Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535BAC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGwq-0000vs-69; Mon, 01 Jul 2024 09:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sOGwn-0000oj-AJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sOGwk-0008EB-Ua
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719839990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QH5DdeCd/ggSgOpsMf2RhUVpQbpHpuI++A3kGMvouPM=;
 b=RpK2e5EpUJebKe1gJXwvYBISFBwpAxZLNDzn4j7PmJ704ZorLpHEu1WG7x1+gzQyaInYYz
 QZ2HhD2TPDOflsMaQETEuguv3fRDXUZXW/+tiy9xGram+0t3I/cKKP4w7wv2rrBcfkt3GA
 7XNWd68b8qsuH+0pOSs+I4k6pOlSnGk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-_Evi4VjmNt-lEOjcpZYYfw-1; Mon,
 01 Jul 2024 09:19:48 -0400
X-MC-Unique: _Evi4VjmNt-lEOjcpZYYfw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5C6B19560B3; Mon,  1 Jul 2024 13:19:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.156])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD3D43000223; Mon,  1 Jul 2024 13:19:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 965691803089; Mon,  1 Jul 2024 15:19:43 +0200 (CEST)
Date: Mon, 1 Jul 2024 15:19:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: Igor Mammedov <imammedo@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Subject: Re: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Message-ID: <b7fmdp5joww5plrwr3hfedv4zfoicxrzbtynaoui452y4zrtq2@hi236cyermam>
References: <20240625035224.13019-1-gaoshiyuan@baidu.com>
 <20240627154548.74a969c2@imammedo.users.ipa.redhat.com>
 <6d033738d79d4b9a83fe216679f8e587@baidu.com>
 <20240701104000.52df4854@imammedo.users.ipa.redhat.com>
 <02403c2f69574128a1700d8b3db37381@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02403c2f69574128a1700d8b3db37381@baidu.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  Hi,

> > for SHPC on PXB see,
> > commit d10dda2d60 hw/pci-bridge: disable SHPC in PXB
> >
> > it seems that enabling SHPC on PXB in QEMU is not enough,
> > UEFI needs to support that as well
> > (CCing Gerd to check whether it is possible at all)

Hmm, can't give a quick answer on that.  From the commit message it
doesn't look easy ...

> > > If I want to use ACPI PCI hotplug in the pxb bridge, what else need to be done?
> >
> > does it have to be hotplug directly into pxb or
> > would be it be sufficient to have hotplug support
> > on pci-bridge attached to a pxb?
> 
> It's sufficient to hotplug support on pci-bridge attached to a pxb.

... but I guess using this instead would be better anyway?

take care,
  Gerd


