Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E4BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1P0T-0004gk-OU; Mon, 29 Apr 2024 07:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1P0Q-0004gB-9d
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1P0O-0002iT-6Y
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714389425;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ima4RcXtfmbLAzJnsROHOm5/Fy3kX/bkhd2W2hnEUtI=;
 b=E1Mr28u2KzDUmDzhec/VkQ+PxMagb1xSnSCvVua7MXxa9yWWQlSwoa3GkiKS1B+Y+QQftZ
 8Qw337cx5NQ6nhunsEHGczOEZAIUu24k08Ip1na4+6Ghi7b/slVXX6aAFzoELNeX25uFhL
 YNdJZbX3ZJ8Dq/5s6vXYvzBGcyvbOy4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-sBGAdNdGMpeZ-7K01_cMQw-1; Mon,
 29 Apr 2024 07:16:59 -0400
X-MC-Unique: sBGAdNdGMpeZ-7K01_cMQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 790A538000AA;
 Mon, 29 Apr 2024 11:16:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59B5D581C8;
 Mon, 29 Apr 2024 11:16:58 +0000 (UTC)
Date: Mon, 29 Apr 2024 12:16:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: Re: [PATCH v6 02/10] util/bufferiszero: Remove AVX512 variant
Message-ID: <Zi-BqBjND3Wcq3Eq@redhat.com>
References: <20240424225705.929812-1-richard.henderson@linaro.org>
 <20240424225705.929812-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424225705.929812-3-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 24, 2024 at 03:56:57PM -0700, Richard Henderson wrote:
> From: Alexander Monakov <amonakov@ispras.ru>
> 
> Thanks to early checks in the inline buffer_is_zero wrapper, the SIMD
> routines are invoked much more rarely in normal use when most buffers
> are non-zero. This makes use of AVX512 unprofitable, as it incurs extra
> frequency and voltage transition periods during which the CPU operates
> at reduced performance, as described in
> https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html

This is describing limitations of Intel's AVX512 implementation.

AMD's AVX512 implementation is said to not have the kind of
power / frequency limitations that Intel's does:

  https://www.mersenneforum.org/showthread.php?p=614191

  "Overall, AMD's AVX512 implementation beat my expectations.
   I was expecting something similar to Zen1's "double-pumping"
   of AVX with half the register file and cross-lane instructions
   being super slow. But this is not the case on Zen4. The lack
   of power or thermal issues combined with stellar shuffle support
   makes it completely worthwhile to use from a developer standpoint.
   If your code can vectorize without excessive wasted computation,
   then go all the way to 512-bit. AMD not only made this worthwhile,
   but *incentivizes* it with the power savings. And if in the future
   AMD decides to widen things up, you may get a 2x speedup for free."

IOW, it sounds like we could be sacrificing performance on modern
AMD Genoa generation CPUs by removing the AVX512 impl

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


