Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D54CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 17:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uywMH-00055V-St; Wed, 17 Sep 2025 13:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uywMF-00052o-2b
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 13:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uywMC-0008VK-E2
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 13:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758131654;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDQ9k05RpkbCXfoXP76O46g1CgJB+T9FalfiI+pqPaU=;
 b=itLHS97Uh7VVWIDm3AU7qaSzcnnmvyhPio7jt5ANqsEX8axvheLQYazbzf3n36czoHGXnb
 RFetG3KL9zbQSWlkCfiZdbOVcHi3SNWGo7XvIKONvgRef+kCGJph9st0a/+cBd9Tcg9d93
 sSwy8matKwBgthDI9TJ74EUxBT4zFKM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-3VwHOk9jP-2MwSfG0Sq8Sw-1; Wed,
 17 Sep 2025 13:54:05 -0400
X-MC-Unique: 3VwHOk9jP-2MwSfG0Sq8Sw-1
X-Mimecast-MFC-AGG-ID: 3VwHOk9jP-2MwSfG0Sq8Sw_1758131643
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 414B719560B7; Wed, 17 Sep 2025 17:54:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACF51300018D; Wed, 17 Sep 2025 17:53:57 +0000 (UTC)
Date: Wed, 17 Sep 2025 18:53:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, amit@kernel.org,
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
Message-ID: <aMr1sn-LU2f-w49o@redhat.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
 <aMq4Ta4aPwRgDrxR@redhat.com>
 <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
 <aMrfGUfCSWnvkXzT@redhat.com>
 <e2f80c7ad10b8b6376144ba5d959a2ad4739f81c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2f80c7ad10b8b6376144ba5d959a2ad4739f81c.camel@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 17, 2025 at 07:11:03PM +0200, Filip Hejsek wrote:
> On Wed, 2025-09-17 at 17:17 +0100, Daniel P. Berrangé wrote:
> 
> > We shouldn't send any size info to the guest if the hsot backend
> > does not have it available.
> 
> Does that mean sending 0x0, or not sending anything at all? The later
> is tricky, because for non-multiport devices it's only really possible
> by not offering the feature bit, but we don't know upfront whether the
> size command will be used.

Nothing at all - is in no difference from current QEMU behaviour.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


