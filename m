Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD91CFC52C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 09:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Hnb-00084I-NJ; Mon, 14 Oct 2024 05:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0HnZ-000844-GQ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0HnX-0000Ro-MV
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728899730;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3al+ba8Zb1dm6f8G7R3PWKY/z8L7mUTDtzJtYHIMF4w=;
 b=Z9coqCuxNefT3rjOmdcq8gh4L9tRXEFwW7dGwL/3RzKEVoNKT7/y+xeenawQpj9HReVWgv
 SegP7n/i9IPa3EWzvG1UZkCXHdw/N8/qy2wVXyPj61qGMj07K/vO37HqyRzOVXfxj1F0Em
 S1Uk+5N9R/Q620M6VwjDKD70ZuD0Xoo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316--RMqQ9K7MQu35fLonpLVRQ-1; Mon,
 14 Oct 2024 05:55:28 -0400
X-MC-Unique: -RMqQ9K7MQu35fLonpLVRQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 520241955EAB; Mon, 14 Oct 2024 09:55:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3D7C1955E8F; Mon, 14 Oct 2024 09:55:24 +0000 (UTC)
Date: Mon, 14 Oct 2024 10:55:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 1/4] sscanf return values are checked to ensure
 correct parsing.
Message-ID: <ZwzqiBlRvm9mw64h@redhat.com>
References: <20241011031937.92216-1-demeng@redhat.com>
 <20241011031937.92216-2-demeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011031937.92216-2-demeng@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Oct 11, 2024 at 11:19:34AM +0800, Dehan Meng wrote:
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-linux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 51d5e3d927..2c2b5f4ff2 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -2103,7 +2103,9 @@ static char *hexToIPAddress(const void *hexValue, int is_ipv6)
>          int i;
>  
>          for (i = 0; i < 16; i++) {
> -            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
> +            if (sscanf(&hex_str[i * 2], "%02hhx", &in6.s6_addr[i]) != 1) {
> +                return NULL;
> +            }
>          }
>          inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);

None of the callers of this function are expecting it to return NULL.

eg this code:

                networkroute->destination = hexToIPAddress(Destination, 1);
                networkroute->metric = Metric;
                networkroute->source = hexToIPAddress(Source, 1);
                networkroute->desprefixlen = g_strdup_printf(
                    "%d", DesPrefixlen
                );
                networkroute->srcprefixlen = g_strdup_printf(
                    "%d", SrcPrefixlen
                );
                networkroute->nexthop = hexToIPAddress(NextHop, 1);

The QAPI schema allows 'source' and 'nexthop' to be optional so those
two are fnie.

The 'destination' field is marked as mandatory thoug, so must not
be NULL.

IOW, in the calls we need to check for NULL, and skip adding the
entire route object if 'destniation' is NULL.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


