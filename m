Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F74CC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to0GT-0001zi-At; Fri, 28 Feb 2025 08:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1to0GH-0001xi-Gp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:18:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1to0GC-0001NR-Py
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740748715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ryvEofnu9UGt76w+7NHrcN7JRSpkJ7YHfZ0DbUDLmis=;
 b=X0uVi3I4JPCSBSCF5K/YISLIsGe3brilHs19TeHFZ77GFf08jTvA9T6Bj6w72I9I9LZvy1
 m4i2zz04hb3pu+fJXdvjj7n2OtfFdFDnj+o8q9749rRHvTDmua8xy8cWmtldLX3FH3HddS
 6BS1nHH0tvbtkuFJO7G5mkZrGlNNYz8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-oKwq3Wj7OQiCW0hrgrpbbQ-1; Fri,
 28 Feb 2025 08:18:30 -0500
X-MC-Unique: oKwq3Wj7OQiCW0hrgrpbbQ-1
X-Mimecast-MFC-AGG-ID: oKwq3Wj7OQiCW0hrgrpbbQ_1740748709
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 885601801A1E; Fri, 28 Feb 2025 13:18:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.2.18.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29115180087F; Fri, 28 Feb 2025 13:18:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BE24F18000A3; Fri, 28 Feb 2025 14:18:25 +0100 (CET)
Date: Fri, 28 Feb 2025 14:18:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
 Ani Sinha <anisinha@redhat.com>, Joerg Roedel <jroedel@suse.com>
Subject: Re: [PATCH v7 00/16] Introduce support for IGVM files
Message-ID: <7juwfqfw3hsqe3obn5z7ojj3f3bj3hayajm4xgvxafalhxi37k@4pxncmaqs3pj>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Feb 27, 2025 at 01:38:08PM +0000, Roy Hopkins wrote:
> Here is v7 of the set of patches to add support for IGVM files to QEMU. This is
> based on commit 40efe733e10cc00e4fb4f9f5790a28e744e63c62 of qemu.
> 
> Firstly, apologies for the amount of time between the last version and this one.
> I moved roles to a different company and, although I always planned to see this
> patch series to completion, it took a while before I found time to setup a
> development environment and be in a position to send a new version. I will
> continue this series using a personal email address for now, hence the change
> to the author and signed-off-by emails.
> 
> The only changes in this version are to rebase on the current master branch and
> update commit metadata, including Signed-Off-By and Author emails for my
> replacement email address, and to include the final Reviewed-By that were added
> in the last review. There were no requested changes on the previous version [1]
> so I believe this series is ready to merge.
> 
> As always, thanks to those that have been following along, reviewing and testing
> this series. This v7 patch series is also available on github: [2]
> 
> For testing IGVM support in QEMU you need to generate an IGVM file that is
> configured for the platform you want to launch. You can use the `buildigvm`
> test tool [3] to allow generation of IGVM files for all currently supported
> platforms. Patch 11/17 contains information on how to generate an IGVM file
> using this tool.

Looks good to me overall, although I don't know SEV good enough to
review these changes in detail.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


