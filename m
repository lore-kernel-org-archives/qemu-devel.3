Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE625F30946
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 11:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6xU-0002cU-5z; Thu, 05 Mar 2026 06:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vy6xN-0002cA-Mv
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vy6xK-0002iv-Pq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 06:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772710404;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OyJHTp+SspCbNoB61zupLO3ycPZnX8Fjd5Oc+YVk+kw=;
 b=CwAt7vuomMbcOqndYSPkA6qjAjTsKj0MKGiC9+fJ4tDyv/BG2gQ5YN2GoIClbYDCQwFFmR
 lS4iM11c8rEdV5clGDr+ybUL91kSzkGW+xxc3sULrpo6VZVq0bdAh5XJYjOI/fPGrJKFnR
 n8XmrbOW1OwVAzVF/RmIQSLK2mbEtIY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-bHSUpULDPkenSJEgFz3CCg-1; Thu,
 05 Mar 2026 06:33:21 -0500
X-MC-Unique: bHSUpULDPkenSJEgFz3CCg-1
X-Mimecast-MFC-AGG-ID: bHSUpULDPkenSJEgFz3CCg_1772710400
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2EB11956048; Thu,  5 Mar 2026 11:33:19 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.61])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D7C91800576; Thu,  5 Mar 2026 11:33:17 +0000 (UTC)
Date: Thu, 5 Mar 2026 11:33:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: Re: [PATCH] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
Message-ID: <aalp-ZyIcGIQ6IxU@redhat.com>
References: <20260305111832.1068093-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305111832.1068093-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 05, 2026 at 11:18:32AM +0000, Peter Maydell wrote:
> If you compile QEMU with GCC with -fsanitize=address and
> -Wstringop-overflow, this causes GCC to produce a false-positive
> warning which it does not produce when the sanitizer is not enabled
> (and which makes compilation fail if you're using -Werror, as we do
> by default for builds from git):
> 
> ../../hw/net/rtl8139.c: In function ‘rtl8139_io_writeb’:
> ../../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>  2264 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);
>       |                 ^
> In file included from ../../hw/net/rtl8139.c:62:
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>    50 |     uint8_t  ip_ver_len;     /* version and header length */
>       |              ^~~~~~~~~~
> ../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>  2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
>       |                     ^
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>    50 |     uint8_t  ip_ver_len;     /* version and header length */
>       |              ^~~~~~~~~~
> ../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>  2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
>       |                     ^
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
>    50 |     uint8_t  ip_ver_len;     /* version and header length */
>       |              ^~~~~~~~~~
> In file included from /home/pm215/qemu/include/system/memory.h:21,
>                  from /home/pm215/qemu/include/hw/pci/pci.h:4,
>                  from /home/pm215/qemu/include/hw/pci/pci_device.h:4,
>                  from ../../hw/net/rtl8139.c:54:
> In function ‘stl_he_p’,
>     inlined from ‘stl_be_p’ at /home/pm215/qemu/include/qemu/bswap.h:371:5,
>     inlined from ‘rtl8139_cplus_transmit_one’ at ../../hw/net/rtl8139.c:2244:21,
>     inlined from ‘rtl8139_cplus_transmit’ at ../../hw/net/rtl8139.c:2345:28,
>     inlined from ‘rtl8139_io_writeb’ at ../../hw/net/rtl8139.c:2728:17:
> /home/pm215/qemu/include/qemu/bswap.h:284:5: error: writing 4 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   284 |     __builtin_memcpy(ptr, &v, sizeof(v));
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/pm215/qemu/include/net/eth.h: In function ‘rtl8139_io_writeb’:
> /home/pm215/qemu/include/net/eth.h:50:14: note: at offset [24, 64] into destination object ‘ip_ver_len’ of size 1
>    50 |     uint8_t  ip_ver_len;     /* version and header length */
>       |              ^~~~~~~~~~
> 
> This has been triaged as a bug in GCC:
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
> (the sanitizer pass rewrites the IR in a way that conflicts with its
> use by the warning pass that runs afterwards).
> 
> Since this is the only place in our code where we hit this, work
> around it by rewriting the relevant bit of code, and noting in a
> comment why we do so.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Here's a patch that takes the "just work around this one problem"
> approach to the gcc sanitizer compile failure.

The alternative is a "#pragma push" to temp disable the
-Wstringop-overflow warning, though that would need to be
done in the 2 code locations triggering the bogus warning,
instead of this which does the single code location that
first confuses GCC, leading to the later warnings. I don't
mind either way though so...


> 
> On the fence about whether this is worth backporting to stable.
> ---
>  hw/net/rtl8139.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


