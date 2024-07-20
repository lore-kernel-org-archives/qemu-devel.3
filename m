Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490C0C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 06:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV3jB-0000Z1-U4; Sat, 20 Jul 2024 02:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sV3j8-0000VG-5s
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 02:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sV3j4-0001IS-9N
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 02:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721457468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J5Qv7Mi5xuxSpBJ6ZFkgnA68t4MriTbgmPYFIVpBlG0=;
 b=B4bnu0csoGZxBWp68MHVFn5OUrswGR2oKHUEYsQSG/qokNWvZJCqJFUsiXBmTAWpwBTOlt
 bajallOkbe9sVeXRFUqxqyyKdck1L+pa2wsarxTRXjYPFdtcp5QHbo5penpr9/RNGykKUZ
 Ag0Dkg+65LjILfVSTPoVt4CUkEyyy5c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-_WwOcT-HNUa2YDLpWqJYXQ-1; Sat,
 20 Jul 2024 02:37:44 -0400
X-MC-Unique: _WwOcT-HNUa2YDLpWqJYXQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2581195608B; Sat, 20 Jul 2024 06:37:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15810195605A; Sat, 20 Jul 2024 06:37:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 041C321E668E; Sat, 20 Jul 2024 08:37:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qapi/qom: make some QOM properties depend on the build
 settings
In-Reply-To: <20240604135931.311709-1-sgarzare@redhat.com> (Stefano
 Garzarella's message of "Tue, 4 Jun 2024 15:59:31 +0200")
References: <20240604135931.311709-1-sgarzare@redhat.com>
Date: Sat, 20 Jul 2024 08:37:40 +0200
Message-ID: <87cyn86023.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I dropped this on the floor.  Sorry for the delay!

Stefano Garzarella <sgarzare@redhat.com> writes:

> Some QOM properties are associated with ObjectTypes that already
> depend on CONFIG_* switches. So to avoid generating dead code,
> let's also make the definition of those properties dependent on
> the corresponding CONFIG_*.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  qapi/qom.json | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 38dde6d785..ae93313a60 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -222,7 +222,8 @@
>  ##
>  { 'struct': 'CanHostSocketcanProperties',
>    'data': { 'if': 'str',
> -            'canbus': 'str' } }
> +            'canbus': 'str' },
> +  'if': 'CONFIG_LINUX' }
>  
>  ##
>  # @ColoCompareProperties:
> @@ -305,7 +306,8 @@
>  ##
>  { 'struct': 'CryptodevVhostUserProperties',
>    'base': 'CryptodevBackendProperties',
> -  'data': { 'chardev': 'str' } }
> +  'data': { 'chardev': 'str' },
> +  'if': 'CONFIG_VHOST_CRYPTO' }
>  
>  ##
>  # @DBusVMStateProperties:
> @@ -514,7 +516,8 @@
>    'data': { 'evdev': 'str',
>              '*grab_all': 'bool',
>              '*repeat': 'bool',
> -            '*grab-toggle': 'GrabToggleKeys' } }
> +            '*grab-toggle': 'GrabToggleKeys' },
> +  'if': 'CONFIG_LINUX' }
>  
>  ##
>  # @EventLoopBaseProperties:
> @@ -719,7 +722,8 @@
>    'base': 'MemoryBackendProperties',
>    'data': { '*hugetlb': 'bool',
>              '*hugetlbsize': 'size',
> -            '*seal': 'bool' } }
> +            '*seal': 'bool' },
> +  'if': 'CONFIG_LINUX' }
>  
>  ##
>  # @MemoryBackendEpcProperties:
> @@ -736,7 +740,8 @@
>  ##
>  { 'struct': 'MemoryBackendEpcProperties',
>    'base': 'MemoryBackendProperties',
> -  'data': {} }
> +  'data': {},
> +  'if': 'CONFIG_LINUX' }
>  
>  ##
>  # @PrManagerHelperProperties:
> @@ -749,7 +754,8 @@
>  # Since: 2.11
>  ##
>  { 'struct': 'PrManagerHelperProperties',
> -  'data': { 'path': 'str' } }
> +  'data': { 'path': 'str' },
> +  'if': 'CONFIG_LINUX' }
>  
>  ##
>  # @QtestProperties:
> @@ -872,7 +878,8 @@
>  ##
>  { 'struct': 'RngRandomProperties',
>    'base': 'RngProperties',
> -  'data': { '*filename': 'str' } }
> +  'data': { '*filename': 'str' },
> +  'if': 'CONFIG_POSIX' }
>  
>  ##
>  # @SevGuestProperties:

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Squashing in

diff --git a/qapi/crypto.json b/qapi/crypto.json
index e102be337b..9b216cee8e 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -488,7 +488,8 @@
 ##
 { 'struct': 'SecretKeyringProperties',
   'base': 'SecretCommonProperties',
-  'data': { 'serial': 'int32' } }
+  'data': { 'serial': 'int32' },
+  'if': 'CONFIG_SECRET_KEYRING' }
 
 ##
 # @TlsCredsProperties:

Queued, thanks!


