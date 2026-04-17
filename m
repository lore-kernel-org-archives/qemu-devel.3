Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ECFF43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfmg-0007FK-Ek; Fri, 17 Apr 2026 05:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDfme-0007Em-QZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDfmd-0007Di-8B
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776419202;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVWHvbQfpqT8Ta8XDjLOgUxH0fEcDBlVswTAb9XYtKs=;
 b=gcmXj95PiENRBOJ9OvAtdfDLFAYIxTSto/Ocn6HWFlL1Zsv0ofO26Ibh9ibTcm32j9HG9S
 RHfYYkvZ68tTdTCWiaLOEFFSDkaC/yFVLzuws+iCktUPSGSEOU8gCgmVtM9PwiHxxJQ2J9
 Y/fcLY9qf4XtkO9K0SNc6Xbq1OSelAU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-aT0NTVB9PDi-CLT2HyM9FA-1; Fri,
 17 Apr 2026 05:46:39 -0400
X-MC-Unique: aT0NTVB9PDi-CLT2HyM9FA-1
X-Mimecast-MFC-AGG-ID: aT0NTVB9PDi-CLT2HyM9FA_1776419198
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9855C180034D; Fri, 17 Apr 2026 09:46:37 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B51D19560B1; Fri, 17 Apr 2026 09:46:35 +0000 (UTC)
Date: Fri, 17 Apr 2026 10:46:33 +0100
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de
Subject: Re: [PATCH v3 2/4] io/channel: introduce qio_channel_pwrite{v, }_all()
Message-ID: <aeIBeQ-DZsQah7-O@redhat.com>
References: <20260413214549.926435-1-junjie.cao@intel.com>
 <20260413214549.926435-3-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413214549.926435-3-junjie.cao@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
X-ACL-Warn: ,  Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
From:  Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 14, 2026 at 05:45:47AM +0800, Junjie Cao wrote:
> Add positioned write helpers that retry on short writes, matching
> the pread_all family from the previous patch.
> 
>   qio_channel_pwritev_all()  -- retry loop; returns 0 on success,
>                                  -1 on error.
>   qio_channel_pwrite_all()   -- single-buffer convenience wrapper.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  include/io/channel.h | 41 +++++++++++++++++++++++++++++++++++++
>  io/channel.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


