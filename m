Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803F2CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uveI6-0000W2-05; Mon, 08 Sep 2025 12:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uveHr-0000AH-K8
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uveHn-00009P-4M
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757347202;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAvIlEmKwGU0xObmHlms0radnasLH85BAf40RYIPArU=;
 b=LuWV20LwTXKO6Z1C8/GOdYDiH2AuLt8f9wlxeupgxs56CogvkpyOBG3sp/N3B8nFxZXdoD
 dpO/JkAjSB/rDDikTYtIoRPGQIfyKahsbkFzL/C+93Q+cu22G6Lg+MCQhMREJeerAlVeWr
 piOjx0nVChV/iMlq/pNSAQJdlkig7OA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-HEP1oRtXMcKoDq1eFcbuPg-1; Mon,
 08 Sep 2025 12:00:01 -0400
X-MC-Unique: HEP1oRtXMcKoDq1eFcbuPg-1
X-Mimecast-MFC-AGG-ID: HEP1oRtXMcKoDq1eFcbuPg_1757347200
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38FEF19560B8
 for <qemu-devel@nongnu.org>; Mon,  8 Sep 2025 16:00:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C745300018D; Mon,  8 Sep 2025 15:59:58 +0000 (UTC)
Date: Mon, 8 Sep 2025 16:59:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ui/spice: fix crash when disabling GL scanout on
Message-ID: <aL79ezQgX03csRiU@redhat.com>
References: <20250903193818.2460914-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903193818.2460914-1-marcandre.lureau@redhat.com>
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

On Wed, Sep 03, 2025 at 11:38:18PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When spice_qxl_gl_scanout2() isn't available, the fallback code
> incorrectly handles NULL arguments to disable the scanout, leading to:
> 
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  spice_server_gl_scanout (qxl=0x55a25ce57ae8, fd=0x0, width=0, height=0, offset=0x0, stride=0x0, num_planes=0, format=0, modifier=72057594037927935, y_0_top=0)
>     at ../ui/spice-display.c:983
> 983         if (num_planes <= 1) {
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2391334
> Fixes: 98a050ca93afd8 ("ui/spice: support multi plane dmabuf scanout")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/spice-display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


