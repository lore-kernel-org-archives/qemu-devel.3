Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C6CCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 16:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v15xb-00056r-On; Tue, 23 Sep 2025 12:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v15xZ-00056a-W2
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v15xY-0007Es-2a
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758645221;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWvs1zChogqa5ScIxLPRYijj5CPMK7gb7+rkynFfTLI=;
 b=MDdEmoJPp76fLIqJFwqDOSqxtV2FIQ4kRkA9WhVGqWM0QfuTTuhx9b+pldE4ZGmBKmf5Rr
 5H9afeB+FH9gk8+Nx8n1c/Mq8Tz1gZaaTyNCcQdHDvmQfEHBWrPEh7qjEnBwqUSgYLQqF3
 M898jYmbHeTfp3GWn56Lv04goqBVot4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-gAjWu4w_NNSh4HIaRNaH2A-1; Tue,
 23 Sep 2025 12:33:37 -0400
X-MC-Unique: gAjWu4w_NNSh4HIaRNaH2A-1
X-Mimecast-MFC-AGG-ID: gAjWu4w_NNSh4HIaRNaH2A_1758645217
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D695319560AE; Tue, 23 Sep 2025 16:33:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C95C319560BB; Tue, 23 Sep 2025 16:33:34 +0000 (UTC)
Date: Tue, 23 Sep 2025 17:33:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nikolai Barybin <nikolai.barybin@virtuozzo.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V . Lunev" <den@virtuozzo.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 0/2] dump: enhance win_dump_available to report properly
Message-ID: <aNLL24Fjt8XAwLgf@redhat.com>
References: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

Marc-André, are these patches good with you ? From my POV they're
ready to be queued.

On Thu, Sep 11, 2025 at 03:36:54PM +0300, Nikolai Barybin wrote:
> Changes since last revision:
> - Split in 2 patches
> 
> Nikolai Barybin (2):
>   dump: enhance dump_state_prepare fd initialization
>   dump: enhance win_dump_available to report properly
> 
>  dump/dump.c     | 138 ++++++++++++++++++++++++++++--------------------
>  dump/win_dump.c |  23 ++++++--
>  dump/win_dump.h |   2 +-
>  3 files changed, 101 insertions(+), 62 deletions(-)
> 
> -- 
> 2.43.5
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


