Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAF0CF11CD
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 11:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syrF7-0004YC-7V; Thu, 10 Oct 2024 07:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syrF1-0004QF-8g
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syrEz-0005Q0-29
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728559315;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixfUsPV4qk2YULGiNyE6HscMIrTovvQekp1HbM7eq+I=;
 b=RfmQDT1KPZhgNJJQLXP1VUXhmj2g9bNlPQJPEw/qLLzFwMb1v20wJvf56gftC76SMhak3n
 VURaRNDhPNeUJLPK7cMNr17It282Pb5bh3ELwnViRw5ujI18qioUb4urPmevM4c4j9CbIx
 iluNMHLx75NUqfAgLmeNot1JJvzUXJU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-li0SJv-yMNmV8rK2R6GnNg-1; Thu,
 10 Oct 2024 07:21:50 -0400
X-MC-Unique: li0SJv-yMNmV8rK2R6GnNg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FBE919560AF; Thu, 10 Oct 2024 11:21:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A76AF19560A2; Thu, 10 Oct 2024 11:21:46 +0000 (UTC)
Date: Thu, 10 Oct 2024 12:21:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com,
 peter.maydell@linaro.org, Alejandro Zeise <alejandro.zeise@seagate.com>
Subject: Re: [PATCH v5 08/16] crypto/hash: Implement and use new hash API
Message-ID: <Zwe4xhgoJ_nK39Pm@redhat.com>
References: <20241008075724.2772149-1-clg@redhat.com>
 <20241008075724.2772149-9-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008075724.2772149-9-clg@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 08, 2024 at 09:57:15AM +0200, Cédric Le Goater wrote:
> From: Alejandro Zeise <alejandro.zeise@seagate.com>
> 
> Changes the public hash API implementation to support accumulative hashing.
> 
> Implementations for the public functions are added to call the new
> driver functions that implement context creation, updating,
> finalization, and destruction.
> 
> Additionally changes the "shortcut" functions to use these 4 new core
> functions.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> [ clg: - Reworked qcrypto_hash_bytesv() error handling
>        - Used hash->driver int qcrypto_hash_new(), qcrypto_hash_free()
>          qcrypto_hash_updatev()
>        - Introduced qcrypto_hash_supports() check in
>          qcrypto_hash_new()
>        - Introduced g_autofree variables in qcrypto_hash_finalize_digest()
>          and qcrypto_hash_finalize_base64()
>        - Re-arrranged code in qcrypto_hash_digestv() and
>          qcrypto_hash_digest()
>        - Checkpatch fixes ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  crypto/hash.c | 161 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 131 insertions(+), 30 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


