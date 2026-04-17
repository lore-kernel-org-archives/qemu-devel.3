Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F00F43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDflU-0006SP-6w; Fri, 17 Apr 2026 05:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDflM-0006Qs-Ug
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDflI-0006UX-VE
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776419119;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx9+xoBRDExEtYDBbeyH9pWjfATQ5L4fnruZmSOYmgU=;
 b=FCtNTex9iVsSt0ExWh4JiG2krBCO3VNTUrpWO+Q0sMDMXaLmpL3FhD7Ka6NJ5L1dIQVJx5
 ZaIeObEbAw24AXkASvIu2TkJM5edGaYtqh9rsKixu9jRgjaqZSC0wIPTWa0ENBJdkw2mUG
 fvTe21j2Q4QOBk039PXSPRHN8XKXEg8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-OGvyVOJyPumdZmmwJstFSg-1; Fri,
 17 Apr 2026 05:45:15 -0400
X-MC-Unique: OGvyVOJyPumdZmmwJstFSg-1
X-Mimecast-MFC-AGG-ID: OGvyVOJyPumdZmmwJstFSg_1776419114
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53D191800473; Fri, 17 Apr 2026 09:45:14 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B21A719560AB; Fri, 17 Apr 2026 09:45:12 +0000 (UTC)
Date: Fri, 17 Apr 2026 10:45:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de
Subject: Re: [PATCH v3 1/4] io/channel: introduce
 qio_channel_pread{v,}_all{,_eof}()
Message-ID: <aeIBJQQ9ZSjFEBX4@redhat.com>
References: <20260413214549.926435-1-junjie.cao@intel.com>
 <20260413214549.926435-2-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413214549.926435-2-junjie.cao@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 14, 2026 at 05:45:46AM +0800, Junjie Cao wrote:
> qio_channel_pread() and qio_channel_preadv() perform a single
> positioned read and may return a short result.  Callers that need all
> bytes currently have to open-code a retry loop or simply treat a short
> read as an error.
> 
> Introduce four new helpers following the existing read_all / readv_all
> pattern:
> 
>   qio_channel_preadv_all_eof()  -- retry loop; returns 1 on success,
>                                     0 on clean EOF, -1 on error.
>   qio_channel_preadv_all()      -- wraps _eof; treats early EOF as
>                                     error; returns 0 / -1.
>   qio_channel_pread_all_eof()   -- single-buffer convenience wrapper
>                                     around preadv_all_eof().
>   qio_channel_pread_all()       -- single-buffer convenience wrapper
>                                     around preadv_all().
> 
> These advance the file offset internally after each partial read.
> All four are marked coroutine_mixed_fn, consistent with the existing
> _all helpers.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  include/io/channel.h | 92 ++++++++++++++++++++++++++++++++++++++++++++
>  io/channel.c         | 91 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 183 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


