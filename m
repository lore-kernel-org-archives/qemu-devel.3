Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2230AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi93D-0003TO-0z; Fri, 10 Jul 2026 07:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wi93A-0003T9-7v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wi937-0002s8-UM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783681540;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0yTjkjmHyOekB06liACgpc43Lxkc+nnWfCxz7gCoEjw=;
 b=hzqaPEu70mvRFOgupYI48GaggLgWPBKs8949lCz+W0zVTOOcXpgKq/xaDS9JF6TgzsThB9
 6FIxisV3bY2ObPTsUAVlX32nXv84KzG8nA0LyqagKzQ/Sg+t90hFbVAT20Co9AFEFmkbAm
 k0/LcEGlUoheIttC1TumKvSCuGFHSUY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-cyfgPlc8Mqyqc48dWxRcGA-1; Fri,
 10 Jul 2026 07:05:36 -0400
X-MC-Unique: cyfgPlc8Mqyqc48dWxRcGA-1
X-Mimecast-MFC-AGG-ID: cyfgPlc8Mqyqc48dWxRcGA_1783681535
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B40F180266C; Fri, 10 Jul 2026 11:05:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.77])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DCC1195419E; Fri, 10 Jul 2026 11:05:33 +0000 (UTC)
Date: Fri, 10 Jul 2026 12:05:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] test-util-filemonitor: Adapt to FreeBSD 15's native
 inotify semantics
Message-ID: <alDR-urdJC6n0GSH@redhat.com>
References: <20260709184229.21628-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709184229.21628-1-jrtc27@jrtc27.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 09, 2026 at 07:42:27PM +0100, Jessica Clarke wrote:
> FreeBSD 15 introduces a native inotify implementation rather than
> requiring use of the kqueue-based libinotify package. This native
> implementation does not generate the extra deleted events, so don't
> expect them. However, the original implementation did have a bug that
> caused IN_IGNORED to never be generated if you did not also watch for
> IN_DELETE_SELF, which affects 15.0 and 15.1, but has been fixed and will
> no longer apply in 15.2 / 16.0.
> 
> Note that the deleted event check is for the userspace version, since
> that governs whether libinotify is being used or not, whereas the
> ignored event check is both for the userspace version (to check if we're
> using the native syscall) and the kernel version (to check if the kernel
> has the bug or not).
> 
> All __FreeBSD_version values used here correspond to the value in-tree
> at the time of the relevant commits. Since neither commit bumped the
> value there will be a window of development snapshots between each
> commit and the previous bump that will be incorrectly identified here,
> but this is the best we can do, and something users of snapshots should
> be prepared to deal with.
> 
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
>  tests/unit/test-util-filemonitor.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>

and queued.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


