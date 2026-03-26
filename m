Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22E3106F30F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5h6z-0004PC-1D; Thu, 26 Mar 2026 05:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w5h6x-0004Oa-8q
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w5h6v-00040h-8a
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774517679;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sTxqyaYuYdV3frBSTNAf2RcSXd7tvvecuidW4I5LE9c=;
 b=W0MvoZtPSQTWstDxPXVSwNlsie7RpSWHB/soGRgoh+B7xdUB+hWXX9Wmx8B4oD0wkGcqNI
 Hlpy9HrpHNcP/Cw/jjR0IlmsOh0GxrfnKYOEa59YZrn17d6lG86gtpTtbPyoNKjCV7J7Er
 chmIFkMPj6xFYfayJwbmSC4pRs5aRVQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-gbOqzx6tPIScVhp9BpPauw-1; Thu,
 26 Mar 2026 05:34:37 -0400
X-MC-Unique: gbOqzx6tPIScVhp9BpPauw-1
X-Mimecast-MFC-AGG-ID: gbOqzx6tPIScVhp9BpPauw_1774517677
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E76618005B4; Thu, 26 Mar 2026 09:34:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.233])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C17331800761; Thu, 26 Mar 2026 09:34:33 +0000 (UTC)
Date: Thu, 26 Mar 2026 09:34:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Silvan Kaiser <silvan@quobyte.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, pierrick.bouvier@linaro.org, eblake@redhat.com,
 armbru@redhat.com
Subject: Re: [PATCH v1 0/3] block: Add 'posix' option for file locking
Message-ID: <acT9pOs5-9D8OqSm@redhat.com>
References: <20260326091948.194529-1-silvan@quobyte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326091948.194529-1-silvan@quobyte.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 26, 2026 at 10:19:45AM +0100, Silvan Kaiser wrote:
> QEMU currently supports three values for the 'locking' property of
> file-based block devices: 'auto' (the default), 'on', and 'off'.
> When OFD (Open File Descriptor) locks are available, 'auto' and 'on'
> use them; when they are not, 'on' falls back to POSIX locks with a
> warning.
> 
> This series adds a fourth value, 'posix', which explicitly forces the
> use of traditional POSIX locks (F_SETLK/F_GETLK) regardless of OFD
> availability.  The motivation is that some userspace filesystem
> implementations (e.g. FUSE) handle POSIX locks correctly but do not
> fully support OFD lock semantics.  Issues with OFD support detection
> on underlying file systems and some OFD guarantees not being fully
> supported can prohibit users from using the default OFD locking.
> Previously, users in this situation had no way to force POSIX locking
> without disabling locking entirely.

Don't the OFD locks silently degrade into POSIX lock semantics
when used over FUSE ? If not, what is the behaviour problem
you're seeing ? 


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


