Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7532C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYiky-0008SL-5W; Tue, 30 Jul 2024 05:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYiku-0008BA-25
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYikq-0001kE-4b
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722330167;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBwOk2rybr4Cx13x5qids7FEyTGoF/M1u/fGVdH5wmk=;
 b=TzT48PHI8PM2ygnn/5tQD5bg6Jn3Jk5dAWHIBI3boh8wZsQDQigMAITzej36cQLrFxt/n2
 lC0+BFA7d+kIewTeHTUniUKalYH4eQdzSdpZ1xykGkkOx7V8N6yWxfr3M174oOfD/ncHYE
 A2mnPnspWQ+meSKTdiiSTTDlT4Hagto=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-Ff90LyE-P3Gck4jquHwqnQ-1; Tue,
 30 Jul 2024 05:02:42 -0400
X-MC-Unique: Ff90LyE-P3Gck4jquHwqnQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F0401955D4A; Tue, 30 Jul 2024 09:02:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16B26300019B; Tue, 30 Jul 2024 09:02:20 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:02:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com,
 andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com,
 den@openvz.org, eblake@redhat.com, eduardo@habkost.net,
 farman@linux.ibm.com, farosas@suse.de, hreitz@redhat.com,
 idryomov@gmail.com, iii@linux.ibm.com, jamin_lin@aspeedtech.com,
 jasowang@redhat.com, joel@jms.id.au, jsnow@redhat.com,
 kwolf@redhat.com, leetroy@gmail.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 mtosatti@redhat.com, nsg@linux.ibm.com, pasic@linux.ibm.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, pl@dlhnet.de,
 richard.henderson@linaro.org, stefanha@redhat.com,
 steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH 12/18] qapi/crypto: Rename QCryptoCipherAlgorithm to
 *Algo, and drop prefix
Message-ID: <ZqisGQF2fz6Qpvmi@redhat.com>
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-13-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240730081032.1246748-13-armbru@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 10:10:26AM +0200, Markus Armbruster wrote:
> QAPI's 'prefix' feature can make the connection between enumeration
> type and its constants less than obvious.  It's best used with
> restraint.
> 
> QCryptoCipherAlgorithm has a 'prefix' that overrides the generated
> enumeration constants' prefix to QCRYPTO_CIPHER_ALG.
> 
> We could simply drop 'prefix', but then the prefix becomes
> QCRYPTO_CIPHER_ALGORITHM, which is rather long.
> 
> We could additionally rename the type to QCryptoCipherAlg, but I think
> the abbreviation "alg" is less than clear.
> 
> Rename the type to QCryptoCipherAlgo instead.  The prefix becomes
> QCRYPTO_CIPHER_ALGO.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json                  |  2 +-
>  qapi/crypto.json                      |  9 ++-
>  crypto/blockpriv.h                    |  4 +-
>  crypto/cipherpriv.h                   |  2 +-
>  crypto/ivgenpriv.h                    |  2 +-
>  include/crypto/cipher.h               | 18 +++---
>  include/crypto/ivgen.h                | 10 +--
>  include/crypto/pbkdf.h                |  4 +-
>  backends/cryptodev-builtin.c          | 16 ++---
>  block/rbd.c                           |  4 +-
>  crypto/block-luks.c                   | 92 +++++++++++++--------------
>  crypto/block-qcow.c                   |  4 +-
>  crypto/block.c                        |  2 +-
>  crypto/cipher-afalg.c                 | 24 +++----
>  crypto/cipher.c                       | 72 ++++++++++-----------
>  crypto/ivgen.c                        |  4 +-
>  crypto/secret_common.c                |  2 +-
>  tests/bench/benchmark-crypto-cipher.c | 22 +++----
>  tests/unit/test-crypto-block.c        | 14 ++--
>  tests/unit/test-crypto-cipher.c       | 66 +++++++++----------
>  tests/unit/test-crypto-ivgen.c        |  8 +--
>  ui/vnc.c                              |  4 +-
>  crypto/cipher-builtin.c.inc           | 18 +++---
>  crypto/cipher-gcrypt.c.inc            | 56 ++++++++--------
>  crypto/cipher-gnutls.c.inc            | 38 +++++------
>  crypto/cipher-nettle.c.inc            | 58 ++++++++---------
>  26 files changed, 277 insertions(+), 278 deletions(-)

Acked-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


