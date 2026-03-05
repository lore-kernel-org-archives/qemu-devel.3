Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86350F33A8B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 15:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyAUB-00056H-DZ; Thu, 05 Mar 2026 10:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vyAUA-000569-0c
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:19:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vyAU8-0002M2-AE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772723971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2g+wy+hRXnB1EJaHBVaDT1VoQJ0dyS6ZsnAfbYiE9m8=;
 b=eSFV08mOBoxtBup3aXuuhdn3d8zc/AwWYJQ1G+wNm9nIgLqoLiLYLK6mmcLy0ClNCg4O/O
 xs+SVbJP3x8UTHH0nWZ0sxjQsFFsNI6K7nT9u3KSsQYIhABxZuP4q/Y1YEHAKOTbTmM/xV
 wpnGTBe7U4EmBuPd3gaBITuY6gQIR6w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-b5TAiMAyNWa8Btl7UJh9xw-1; Thu,
 05 Mar 2026 10:19:29 -0500
X-MC-Unique: b5TAiMAyNWa8Btl7UJh9xw-1
X-Mimecast-MFC-AGG-ID: b5TAiMAyNWa8Btl7UJh9xw_1772723968
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9336418002D6; Thu,  5 Mar 2026 15:19:28 +0000 (UTC)
Received: from [10.45.224.75] (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F3433003E9E; Thu,  5 Mar 2026 15:19:26 +0000 (UTC)
Message-ID: <e2240e03-e60e-4b8e-998a-5c61d9313045@redhat.com>
Date: Thu, 5 Mar 2026 16:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>
References: <20260305140512.1330691-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260305140512.1330691-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 05/03/2026 15.05, Peter Maydell wrote:
> If you compile QEMU with GCC with -fsanitize=address and
> -Wstringop-overflow, this causes GCC to produce a false-positive
> warning which it does not produce when the sanitizer is not enabled
> (and which makes compilation fail if you're using -Werror, as we do
> by default for builds from git):
> 
> ../../hw/net/rtl8139.c: In function ‘rtl8139_io_writeb’:
> ../../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   2264 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);
>        |                 ^
> In file included from ../../hw/net/rtl8139.c:62:
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> ../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
>        |                     ^
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> ../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
>        |                     ^
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> In file included from /home/pm215/qemu/include/system/memory.h:21,
>                   from /home/pm215/qemu/include/hw/pci/pci.h:4,
>                   from /home/pm215/qemu/include/hw/pci/pci_device.h:4,
>                   from ../../hw/net/rtl8139.c:54:
> In function ‘stl_he_p’,
>      inlined from ‘stl_be_p’ at /home/pm215/qemu/include/qemu/bswap.h:371:5,
>      inlined from ‘rtl8139_cplus_transmit_one’ at ../../hw/net/rtl8139.c:2244:21,
>      inlined from ‘rtl8139_cplus_transmit’ at ../../hw/net/rtl8139.c:2345:28,
>      inlined from ‘rtl8139_io_writeb’ at ../../hw/net/rtl8139.c:2728:17:
> /home/pm215/qemu/include/qemu/bswap.h:284:5: error: writing 4 bytes into a region of size 0 [-Werror=stringop-overflow=]
>    284 |     __builtin_memcpy(ptr, &v, sizeof(v));
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/pm215/qemu/include/net/eth.h: In function ‘rtl8139_io_writeb’:
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [24, 64] into destination object ‘ip_ver_len’ of size 1
>     50 |     uint8_t  ip_ver_len;     /* version and header length */
>        |              ^~~~~~~~~~
> 
> This has been triaged as a bug in GCC:
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
> (the sanitizer pass rewrites the IR in a way that conflicts with its
> use by the warning pass that runs afterwards).
> 
> Since this is the only place in our code where we hit this, work
> around it by disabling the -Wstringop-overflow in the part of
> the function that hits it. We do this only when using the
> address sanitizer on GCC, so that we still get the benefit
> of the warning in most compilation scenarios.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v2: disable the warning rather than using the incorrect attempt
> at a workaround that v1 had.
> 
> On the fence about whether this is worth backporting to stable.

It's easy enough, so I think it's a good idea to backport to stable.

Reviewed-by: Thomas Huth <thuth@redhat.com>


