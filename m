Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA6FC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 17:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugS2k-0002i0-AW; Mon, 28 Jul 2025 13:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugS2c-0002Gs-CV
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugS2a-0008NE-BG
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753725213;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=w57JmvmQP2/RZPjlX2mxphCn3/8jZ09I2g7jCEZgZaY=;
 b=IB8yWpch3Iq1NbVg5FpxehH6+WgpHhFjGgLpyQX+kVdRCvOrif3t7CH/IQLtYyrt62/8xc
 yK4uZj4oGmlxpDcvpToV/7ocBUhJEO3erAGCoul8nik5KuIc4O3vDlfPGrnJuUxHKJze2U
 GoR7xNYVqp8POonhrqZMkx41O/iw364=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-DZV3lka1O8SAawwiqboi0A-1; Mon,
 28 Jul 2025 13:53:29 -0400
X-MC-Unique: DZV3lka1O8SAawwiqboi0A-1
X-Mimecast-MFC-AGG-ID: DZV3lka1O8SAawwiqboi0A_1753725208
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCE8D1800366; Mon, 28 Jul 2025 17:53:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC4B819560A2; Mon, 28 Jul 2025 17:53:26 +0000 (UTC)
Date: Mon, 28 Jul 2025 18:53:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] qga: Fix ubsan warning
Message-ID: <aIe5E5NaMCGhoiLZ@redhat.com>
References: <20250728173016.314460-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250728173016.314460-1-thuth@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jul 28, 2025 at 07:30:16PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When compiling QEMU with --enable-ubsan there is a undefined behavior
> warning when running "make check":
> 
>  .../qga/commands-linux.c:452:15: runtime error: applying non-zero offset 5 to null pointer
>  #0 0x55ea7b89450c in build_guest_fsinfo_for_pci_dev ..../qga/commands-linux.c:452:15
> 
> Add a check to avoid incrementing the NULL pointer here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qga/commands-linux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 9e8a934b9a6..caf7c3ca22b 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -449,7 +449,9 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
>          has_ata = true;
>      } else {
>          p = strstr(syspath, "/host");
> -        q = p + 5;
> +        if (p) {
> +            q = p + 5;
> +        }
>      }
>      if (p && sscanf(q, "%u", &host) == 1) {

q is always non-NULL if p is non-NULL, so this is safe, but I would be more
happy with this changing to 'q && sscanf' to eliminate the indirection.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


