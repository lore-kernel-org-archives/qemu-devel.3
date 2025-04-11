Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD975C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Box-0001z3-Ep; Fri, 11 Apr 2025 06:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3Boo-0001u6-T8
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3Bol-0008CE-UN
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744368062;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ovy9jKzNfMTa/lFNnT//ef5XxfBeAB3rYSr+VCVkcxo=;
 b=NcO0Sv0ZrX0jF0avdys+zDWIRE378KjuYr0qp+QtUol2GfBrH+GQrhEk+3kYMeSWaiV8td
 hzTECRfxfDle7f48w4x3lgdl2hP8cbxVX9r9xwboZaWkPn7XFxlG6MEm8M4xoirx+34aVB
 oAcZ84ySXrLaFQI/3D1cT/FcS16LzrQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-IecpwT9hOsydYeYE0ShbhQ-1; Fri,
 11 Apr 2025 06:40:59 -0400
X-MC-Unique: IecpwT9hOsydYeYE0ShbhQ-1
X-Mimecast-MFC-AGG-ID: IecpwT9hOsydYeYE0ShbhQ_1744368058
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DD0E180AB1C; Fri, 11 Apr 2025 10:40:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DEF719560AD; Fri, 11 Apr 2025 10:40:56 +0000 (UTC)
Date: Fri, 11 Apr 2025 11:40:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/5] util/qemu-sockets: Refactor setting client
 sockopts into a separate function
Message-ID: <Z_jxtTZgHBC5o47o@redhat.com>
References: <20250408112508.1638722-1-jmarcin@redhat.com>
 <20250408112508.1638722-3-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408112508.1638722-3-jmarcin@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 08, 2025 at 01:25:01PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> This is done in preparation for enabling the SO_KEEPALIVE support for
> server sockets and adding settings for more TCP keep-alive socket
> options.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  util/qemu-sockets.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 77477c1cd5..d15f6aa4b0 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -205,6 +205,22 @@ static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
>  #endif
>  }
>  
> +static int inet_set_sockopts(int sock, InetSocketAddress *saddr, Error **errp)
> +{
> +    if (saddr->keep_alive) {
> +        int keep_alive = 1;
> +        int ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
> +                             &keep_alive, sizeof(keep_alive));
> +
> +        if (ret < 0) {
> +            error_setg_errno(errp, errno,
> +                             "Unable to set keep-alive option on socket");
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
>  static int inet_listen_saddr(InetSocketAddress *saddr,
>                               int port_offset,
>                               int num,
> @@ -475,16 +491,9 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp)
>          return sock;
>      }
>  
> -    if (saddr->keep_alive) {
> -        int val = 1;
> -        int ret = setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
> -                             &val, sizeof(val));
> -
> -        if (ret < 0) {
> -            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
> -            close(sock);
> -            return -1;
> -        }
> +    if (inet_set_sockopts(sock, saddr, errp)) {

Since this returns -1 on error, by convention we check "< 0", reserving
positive return values for future non-error scenarios.

> +        close(sock);
> +        return -1;
>      }
>  
>      return sock;
> -- 
> 2.48.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


