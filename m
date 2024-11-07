Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB963D5AE7C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 09:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zC8-0006E1-TT; Thu, 07 Nov 2024 04:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8zC7-0006Dk-Oc
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:52:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8zC6-0004iE-0t
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730973169;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6kRZ4/k5A0pLIxSQCq9pXjSIUv4a91bGgs1PcXZ/D58=;
 b=TCorTFtCjeIy3GAfQMNqNFG4sduvCZcy3pmcmxQshyzyGYJ3z1lMW1O5GXCCZsT/2xQeSY
 vV3yi36pzo0O1xeNM0NgNQlhfFJyjuXWB5BA4pQd3MUlpbXsNgt6VP0lQHv+/XxKKOTlW8
 eE+FHPBCsET++/E4OLmuKgFXQGcacpY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-bH2HtxZAMGOEwZXWxVoFxQ-1; Thu,
 07 Nov 2024 04:52:45 -0500
X-MC-Unique: bH2HtxZAMGOEwZXWxVoFxQ-1
X-Mimecast-MFC-AGG-ID: bH2HtxZAMGOEwZXWxVoFxQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEFFD19560AE; Thu,  7 Nov 2024 09:52:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02CD5195E481; Thu,  7 Nov 2024 09:52:40 +0000 (UTC)
Date: Thu, 7 Nov 2024 09:52:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, devel@daynix.com
Subject: Re: [PATCH] tap-win32: Ignore keys too long
Message-ID: <ZyyN5UySgCv348KC@redhat.com>
References: <20241107-win32-v1-1-952d508e2546@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107-win32-v1-1-952d508e2546@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 07, 2024 at 06:48:44PM +0900, Akihiko Odaki wrote:
> Registry keys get truncated and trigger -Wformat-truncation. Ignore
> such truncated keys as they are invalid.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  net/tap-win32.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)

These problems were already fixed by changing to g_strdup_printf

 commit 75fe36b4e8a994cdf9fd6eb601f49e96b1bc791d
 Author: Bernhard Beschow <shentey@gmail.com>
 Date:   Tue Oct 8 22:28:42 2024 +0200

    net/tap-win32: Fix gcc 14 format truncation errors


> 
> diff --git a/net/tap-win32.c b/net/tap-win32.c
> index 7edbd7163370..4081ba87991f 100644
> --- a/net/tap-win32.c
> +++ b/net/tap-win32.c
> @@ -239,8 +239,12 @@ static int is_tap_win32_dev(const char *guid)
>              return FALSE;
>          }
>  
> -        snprintf (unit_string, sizeof(unit_string), "%s\\%s",
> -                  ADAPTER_KEY, enum_name);
> +        len = snprintf(unit_string, sizeof(unit_string), "%s\\%s",
> +                       ADAPTER_KEY, enum_name);
> +        if (len >= sizeof(unit_string)) {
> +            ++i;
> +            continue;
> +        }
>  
>          status = RegOpenKeyEx(
>              HKEY_LOCAL_MACHINE,
> @@ -338,10 +342,13 @@ static int get_device_guid(
>              return -1;
>          }
>  
> -        snprintf(connection_string,
> -             sizeof(connection_string),
> -             "%s\\%s\\Connection",
> -             NETWORK_CONNECTIONS_KEY, enum_name);
> +        len = snprintf(connection_string, sizeof(connection_string),
> +                       "%s\\%s\\Connection",
> +                       NETWORK_CONNECTIONS_KEY, enum_name);
> +        if (len >= sizeof(connection_string)) {
> +            ++i;
> +            continue;
> +        }
>  
>          status = RegOpenKeyEx(
>              HKEY_LOCAL_MACHINE,
> @@ -617,10 +624,11 @@ static int tap_win32_open(tap_win32_overlapped_t **phandle,
>      if (rc)
>          return -1;
>  
> -    snprintf (device_path, sizeof(device_path), "%s%s%s",
> -              USERMODEDEVICEDIR,
> -              device_guid,
> -              TAPSUFFIX);
> +    rc = snprintf(device_path, sizeof(device_path), "%s%s%s",
> +                  USERMODEDEVICEDIR, device_guid, TAPSUFFIX);
> +    if (rc >= sizeof(device_path)) {
> +        return -1;
> +    }
>  
>      handle = CreateFile (
>          device_path,
> 
> ---
> base-commit: 7e3b6d8063f245d27eecce5aabe624b5785f2a77
> change-id: 20241107-win32-b8f0d15c9122
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


