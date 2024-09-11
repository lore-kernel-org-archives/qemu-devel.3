Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6871EE020D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soGOP-0007hR-JO; Wed, 11 Sep 2024 01:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1soGON-0007eP-Av; Wed, 11 Sep 2024 01:59:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1soGOL-0006zM-KZ; Wed, 11 Sep 2024 01:59:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 126548DCAF;
 Wed, 11 Sep 2024 08:59:31 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C791C139141;
 Wed, 11 Sep 2024 08:59:35 +0300 (MSK)
Message-ID: <2d6b25ff-0147-4026-b00c-3043a92a1a9d@tls.msk.ru>
Date: Wed, 11 Sep 2024 08:59:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] Crypto fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20240909141635.1459701-1-berrange@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20240909141635.1459701-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

On 9/9/24 17:16, Daniel P. Berrangé wrote:

> Various crypto fixes
> 
>   * Support sha384 with glib crypto backend
>   * Improve error reporting for unsupported cipher modes
>   * Avoid memory leak when bad cipher mode is given
>   * Run pbkdf tests on macOS
>   * Runtime check for pbkdf hash impls with gnutls & gcrypt
>   * Avoid hangs counter pbkdf iterations on some Linux kernels
>     by using a throwaway thread for benchmarking performance
>   * Fix iotests expected output from gnutls errors

Hm.  Are you sure *all* of it should go to qemu-stable? :)

> Daniel P. Berrangé (6):
>    iotests: fix expected output from gnutls
>    crypto: check gnutls & gcrypt support the requested pbkdf hash
>    tests/unit: always build the pbkdf crypto unit test
>    tests/unit: build pbkdf test on macOS
>    crypto: avoid leak of ctx when bad cipher mode is given
>    crypto: use consistent error reporting pattern for unsupported cipher
>      modes
> 
> Dorjoy Chowdhury (3):
>    crypto: Define macros for hash algorithm digest lengths
>    crypto: Support SHA384 hash when using glib
>    crypto: Introduce x509 utils
> 
> Tiago Pasqualini (1):
>    crypto: run qcrypto_pbkdf2_count_iters in a new thread

Thanks,

/mjt


