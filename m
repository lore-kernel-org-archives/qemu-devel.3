Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D5BC52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 15:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbMUl-0006G4-I1; Tue, 06 Aug 2024 11:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbMUk-0006E1-OM
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbMUf-0000xN-Rw
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 11:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722959580;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qEHp2W5QQn8DE8globFe/hgSSgkSD/3gt/u+fJ4Ohks=;
 b=G5lmxL/frR/Gpy/v8lKO207oRMCvMpKH7JneoTOhxnf8TuUskrJe8U/ikGSgeWSOPenfoE
 ie9KMqznGoJqJyYe6zC9NrscdGb/oaMaYkTKP1NWTCY24kmw2+TP/d3AGN63k4jgSE3aXD
 LKutMMmXXviLMGA2RXyOBmMM4EXa510=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-ZdVkTfDlPQKQOcHwIt9cXg-1; Tue,
 06 Aug 2024 11:52:56 -0400
X-MC-Unique: ZdVkTfDlPQKQOcHwIt9cXg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63EAC1955D45; Tue,  6 Aug 2024 15:52:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 630AA1955D42; Tue,  6 Aug 2024 15:52:51 +0000 (UTC)
Date: Tue, 6 Aug 2024 16:52:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alejandro Zeise <alejandro.zeise@seagate.com>
Cc: qemu-arm@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/12] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
Message-ID: <ZrJGzxtvzJ49aGln@redhat.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 05, 2024 at 03:50:35PM +0000, Alejandro Zeise wrote:
> The goal of this patch series is to fix accumulative hashing support in the 
> Aspeed HACE module. The issue that stemmed this patch was a failure to boot an
> OpenBMC image using the "ast2600-evb" machine. The U-boot
> 2019.04 loader failed to verify image hashes.
> 
> These incorrect image hashes given by the HACE to the U-boot guest are due to 
> an oversight in the HACE module. Previously when operating in 
> scatter-gather accumulative mode, the HACE would cache the address provided by 
> the guest which contained the source data. However, there was no deep copy, 
> so when HACE generated the digest upon the reception of the final accumulative chunk 
> the digest was incorrect, as the addresses provided had their regions overwritten
> by that time.
> 
> This fix consists of two main steps:
> * Add an accumulative hashing function to the qcrypto library
> * Modify the HACE module to use the accumulative hashing functions
> 
> All the crypto library backends (nettle, gnutls, etc.) support accumulative hashing,
> so it was trivial to create wrappers for those functions.
> 
> Changes in V3:
> * Reworked crypto hash API with comments from Daniel
>   * Creation/Deletion of contexts, updating, and finalizing
>   * Modified existing API functions to use the new 4 main core functions
>   * Added test for accumulative hashing
>   * Added afalg driver implementation
> * Fixed bug in HACE module where hash context fails to allocate,
>   causing the HACE internal state to be incorrect and segfault.
> 
> Changes in V2:
> * Fixed error checking bug in libgcrypt crypto backend of
>   accumulate_bytesv
> 
> Alejandro Zeise (12):
>   crypto: accumulative hashing API
>   crypto/hash-glib: Remove old hash API implementation
>   crypto/hash-glib: Implement new hash API
>   crypto/hash-gcrypt: Remove old hash API implementation
>   crypto/hash-gcrypt: Implement new hash API
>   crypto/hash-gnutls: Remove old hash API
>   crypto/hash-gnutls: Implement new hash API
>   crypto/hash-nettle: Remove old hash API
>   crypto/hash-nettle: Implement new hash API
>   crypto/hash-afalg: Update to new API
>   tests/unit/test-crypto-hash: accumulative hashing
>   hw/misc/aspeed_hace: Fix SG Accumulative hashing

To allow 'make check' to succeed at every individual patch, you'll need to
re-order these, and split a couple of patches, to be more or less like this:

   crypto: accumulative hashing API   (only define new driver APIs & new public APIs here)
   crypto/hash-glib: Implement new hash API
   crypto/hash-gcrypt: Implement new hash API
   crypto/hash-gnutls: Implement new hash API
   crypto/hash-nettle: Implement new hash API
   crypto/hash-afalg: Update to new API  (only add new APIs here )
   < convert old public APIs to call the new driver APIs here>
   tests/unit/test-crypto-hash: accumulative hashing
   crypto/hash-glib: Remove old hash API implementation
   crypto/hash-gcrypt: Remove old hash API implementation
   crypto/hash-gnutls: Remove old hash API
   crypto/hash-nettle: Remove old hash API
   < remove old afalg support here >
   < remove old driver APIs here >
   hw/misc/aspeed_hace: Fix SG Accumulative hashing


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


