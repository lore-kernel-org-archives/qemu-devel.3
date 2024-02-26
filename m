Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9112CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1recQR-0007TM-Gm; Mon, 26 Feb 2024 09:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1recQN-0007Sc-CX
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:57:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1recQL-0002PQ-RI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708959465;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cad2Fi7d0VCpu9vku6SNbVAjeFyxl6fhLmvZ7FHrCww=;
 b=Tl9iCR3xG2wrm0hC8UDo05MBMzwzns+jK0vHENR6RsOCN2J4rDd3d7J8gXAZ7T75IauhT6
 1Zzl4KDGbBkh+Oqk+zfK9n1QPuTy3p1KC/lCbExiFTgS0exWB7kAB2SN1Ljz0B7shQZj+n
 10dv8GgUj49XITlD7v+lk8zjcXwjOqA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-0nYqL3dHMsWVmRo_apQ4Ag-1; Mon,
 26 Feb 2024 09:57:41 -0500
X-MC-Unique: 0nYqL3dHMsWVmRo_apQ4Ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 865F71C0BB42;
 Mon, 26 Feb 2024 14:57:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06AF240C1430;
 Mon, 26 Feb 2024 14:57:40 +0000 (UTC)
Date: Mon, 26 Feb 2024 14:57:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 28/28] qemu-img: extend cvtnum() and use it in more places
Message-ID: <Zdym4zkJIkzSUDWt@redhat.com>
References: <cover.1708544927.git.mjt@tls.msk.ru>
 <20240221211622.2335170-28-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221211622.2335170-28-mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 22, 2024 at 12:16:09AM +0300, Michael Tokarev wrote:
> cvtnum() expects input string to specify some sort of size
> (optionally with KMG... suffix).  However, there are a lot
> of other number conversions in there (using qemu_strtol &Co),
> also, not all conversions which use cvtnum, actually expects
> size, - like dd count=nn.
> 
> Add bool issize argument to cvtnum() to specify if it should
> treat the argument as a size or something else, - this changes
> conversion routine in use and error text.
> 
> Use the new cvtnum() in more places (like where strtol were used),
> since it never return negative number in successful conversion.
> When it makes sense, also specify upper or lower bounds at the
> same time.  This simplifies option processing in multiple places,
> removing the need of local temporary variables and longer error
> reporting code.
> 
> While at it, fix errors, like depth in measure must be >= 1,
> while the previous code allowed it to be 0.
> 
> In a few places, change unsigned variables (like of type size_t)
> to be signed instead, - to avoid the need of temporary conversion
> variable.  All these variables are okay to be signed, we never
> assign <0 value to them except of the cases of conversion error,
> where we return immediately.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 118 ++++++++++++++++++++---------------------------------
>  1 file changed, 44 insertions(+), 74 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


