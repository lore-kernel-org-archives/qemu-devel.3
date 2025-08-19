Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FAECA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 10:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoK1X-0002a4-1i; Tue, 19 Aug 2025 06:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoK1U-0002YI-SQ
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoK1S-0002dv-1o
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755601017;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pa/mZyQ36RUnZf739fiP4tm/zJ6mhuWuzCCKqbNCNzY=;
 b=HjFyqon0CGXdjuHNnQjVQqRu49Mw8AOpKEN89vfb/CRa9ARWy5nFds6x4Y87rbfey17zBo
 TrMMLl0yB+agS5IXFkJoolOrX2bZitprqhCQzb8EHelgnypmUK3aiwpvvjrvotfXa5Tcv3
 L+T1hkDV3uK5Y3S8+fUiw9gMlTO4Eew=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-grD-L3YrO5u2GbN3Cix4mg-1; Tue,
 19 Aug 2025 06:56:54 -0400
X-MC-Unique: grD-L3YrO5u2GbN3Cix4mg-1
X-Mimecast-MFC-AGG-ID: grD-L3YrO5u2GbN3Cix4mg_1755601013
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B13E180036F; Tue, 19 Aug 2025 10:56:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A26921800447; Tue, 19 Aug 2025 10:56:50 +0000 (UTC)
Date: Tue, 19 Aug 2025 11:56:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 02/12] tcg: Fix error reporting on mprotect() failure in
 tcg_region_init()
Message-ID: <aKRYb2Ok_qRAiqRM@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808080823.2638861-3-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Fri, Aug 08, 2025 at 10:08:13AM +0200, Markus Armbruster wrote:
> tcg_region_init() calls one of qemu_mprotect_rwx(),
> qemu_mprotect_rw(), and mprotect(), then reports failure with
> error_setg_errno(&error_fatal, errno, ...).
> 
> The use of &error_fatal is undesirable.  qapi/error.h advises:
> 
>  * Please don't error_setg(&error_fatal, ...), use error_report() and
>  * exit(), because that's more obvious.
> 
> The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
> wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
> mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
> with error_report().  VirtualProtect() doesn't set errno.  mprotect()
> does, but error_report() may clobber it.
> 
> Fix tcg_region_init() to report errors only when it calls mprotect(),
> and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
> reporting otherwise.  Use error_report(), not error_setg().
> 
> Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protection)
> Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tcg/region.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


