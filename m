Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AB3CFC534
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Hrs-0001Ua-1v; Mon, 14 Oct 2024 06:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0Hrq-0001UI-D3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0Hro-0000fF-OV
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 05:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728899995;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=EIa4puTucLsLUozQVYiSJpXTuD1Nsr9Ec/GV4iGdDPk=;
 b=WFZFhug7nTSTi0TKXJ/nHJUpLzcWHMBdnsu1XuHb3jFvvf1bZRtUFjd0cqQ3CDX+tuzO+M
 zw/D03PmjHHAbeBdVrTOg+K2WyIK8wIWaBK+DR9QqKLDKlEn+35S6pBord5cSq1arJ86mP
 F+0QX2y1Oh0+HT6y7OEnqjzD0JskGmg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-4zSBiXJkMdq7CIzNPqJg7w-1; Mon,
 14 Oct 2024 05:59:53 -0400
X-MC-Unique: 4zSBiXJkMdq7CIzNPqJg7w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 988A71955F2B; Mon, 14 Oct 2024 09:59:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66CBA19560AA; Mon, 14 Oct 2024 09:59:48 +0000 (UTC)
Date: Mon, 14 Oct 2024 10:59:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 3/4] Avoiding freeing line prematurely. It's now only
 freed at the end of the function.
Message-ID: <ZwzrkLRttuoGTSnQ@redhat.com>
References: <20241011031937.92216-1-demeng@redhat.com>
 <20241011031937.92216-4-demeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011031937.92216-4-demeng@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

The subject line is too long - put the second sentance on a line of
its own in the commit message, separated from the 1st line by a blank
line.

On Fri, Oct 11, 2024 at 11:19:36AM +0800, Dehan Meng wrote:
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-linux.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

> 
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index b905f33a57..4f0e38be81 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -2137,8 +2137,7 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>          is_ipv6 = (i == 1);
>          fp = fopen(routeFiles[i], "r");
>          if (fp == NULL) {
> -            error_setg_errno(errp, errno, "open(\"%s\")", routeFiles[i]);
> -            free(line);
> +            error_setg_errno(errp, errno, "open(\"%s\")", route_files[i]);
>              continue;
>          }
>  
> @@ -2218,9 +2217,8 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
>              QAPI_LIST_APPEND(tail, route);
>          }
>  
> -        free(line);
>          fclose(fp);
>      }
> -
> +    free(line);
>      return head;
>  }
> -- 
> 2.40.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


