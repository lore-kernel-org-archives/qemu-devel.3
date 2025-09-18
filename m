Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8E1CAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAok-00037N-0s; Thu, 18 Sep 2025 05:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uzAog-00036Y-R4
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uzAoe-00081Z-34
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758187227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/IJWWRGYEKMSuKPefTFLzs3Q1/IlkfVJiPPcjAvozt8=;
 b=UvmruXDhG9hWChQtNflg97hBgBrtTDsRpyGF82FBbEEkzmjwYncuQ5gc55/d3JMEvOSPhy
 Xcqp2HBXPvlcgAWXfIlmoSWbTWPlmbjHVvCH7SGDCgjiOKwqQ1acpK6yHGiM90CB0fWdJX
 uAcAX1e0e/73Of++yEiMxpyod8aLQIM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-JWrc0BDFM1uArhW2pRbLAQ-1; Thu,
 18 Sep 2025 05:20:26 -0400
X-MC-Unique: JWrc0BDFM1uArhW2pRbLAQ-1
X-Mimecast-MFC-AGG-ID: JWrc0BDFM1uArhW2pRbLAQ_1758187224
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE220180034C; Thu, 18 Sep 2025 09:20:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.55])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 593F319560B1; Thu, 18 Sep 2025 09:20:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0B11B1800399; Thu, 18 Sep 2025 11:20:21 +0200 (CEST)
Date: Thu, 18 Sep 2025 11:20:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PULL 30/63] q35: Introduce smm_ranges property for q35-pci-host
Message-ID: <7ehf4u23nzh6paso5lhhaceo7dugkktll7cbinx4faldmjvd5w@fd75vtl6wba5>
References: <20240423150951.41600-1-pbonzini@redhat.com>
 <20240423150951.41600-31-pbonzini@redhat.com>
 <3458e5b7-b53e-4057-baea-03a729452255@tls.msk.ru>
 <28a17da6-8cde-4248-9302-2a55b3125938@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a17da6-8cde-4248-9302-2a55b3125938@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 17, 2025 at 05:23:55PM +0300, Michael Tokarev wrote:
> Ping, also adding kraxel@.
> 
> Should I send formal patch moving one line of code up?

I'm wondering why this is needed in the first place?

We already have a smm machine property, and with smm
disabled all the smm-related memory regions should
stay disabled ...

take care,
  Gerd


