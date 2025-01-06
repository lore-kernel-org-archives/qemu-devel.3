Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18576E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 09:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUjK6-0006rm-EN; Mon, 06 Jan 2025 04:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tUjK4-0006rX-Jf
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 04:22:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tUjK2-00076q-Et
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 04:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736155371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gPLFaXhte6iwXc4bklcAGHmXi0U8EdamDpyJhHvjQ24=;
 b=GJz7RqFb38AuAfzOCTmHTDeuysh7r1ZAJnsAtrVtaXR+1A+Yjzi1imOzhUwlVtu7PHNwe9
 OJxfZu5SY8pyy5Zkiru+5XN79qvKjd02raRxYw3xlrVRMMhxchIgNAYXklJaUyWlqiXZ7Z
 otAfrqcIFqBdHMu83lrlzzWU2kv4uR0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-CVocXEdpP1yKEkrsrB7-3w-1; Mon,
 06 Jan 2025 04:22:47 -0500
X-MC-Unique: CVocXEdpP1yKEkrsrB7-3w-1
X-Mimecast-MFC-AGG-ID: CVocXEdpP1yKEkrsrB7-3w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56DBC19560B1; Mon,  6 Jan 2025 09:22:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F5663000197; Mon,  6 Jan 2025 09:22:44 +0000 (UTC)
Date: Mon, 6 Jan 2025 09:22:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v2 1/2] glib-compat: Define g_spawn_check_wait_status()
Message-ID: <Z3ug4WRFoXufrBbj@redhat.com>
References: <20250104-glib-v2-0-12013f3e5782@daynix.com>
 <20250104-glib-v2-1-12013f3e5782@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250104-glib-v2-1-12013f3e5782@daynix.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Jan 04, 2025 at 05:04:07PM +0900, Akihiko Odaki wrote:
> g_spawn_check_exit_status() is renamed to g_spawn_check_wait_status()
> in 2.70.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/glib-compat.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index 86be439ba0ef..0bddb327bd5d 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -68,6 +68,8 @@
>   * without generating warnings.
>   */
>  
> +#define g_spawn_check_wait_status g_spawn_check_exit_status

This needs to be conditionalized on !GLIB_CHECK_VERSION(2, 70, 0)


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


