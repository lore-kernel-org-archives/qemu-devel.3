Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3292C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHLmG-0001wk-8p; Wed, 12 Jun 2024 07:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHLmE-0001wb-Qz
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHLmC-0002Wa-TL
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718190263;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AQyVqN7iSD/pR2CqV7F/XSQBanFKWHkrFzJ5noQtfvY=;
 b=D1vQv12E+CCo6V47CKVfkT/Ez9L1CaufLPCu+vjBn03nDX4F3WYLGbcmrY1kbVMrR/v4cS
 IMP6M9gIgxnIFP3erzOBEGyiV71lVrGKy8IF6GolCNQADlwrcoj6FLDKwsJ8k0KzAKSgc/
 zARzSgzsW/aiMOBHn/O1QcumkUk8hM4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-gjl-Xfz7MKCUOCEizMFGzg-1; Wed,
 12 Jun 2024 07:04:20 -0400
X-MC-Unique: gjl-Xfz7MKCUOCEizMFGzg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9507419560BC; Wed, 12 Jun 2024 11:04:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 749EC30000C4; Wed, 12 Jun 2024 11:04:15 +0000 (UTC)
Date: Wed, 12 Jun 2024 12:04:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
Message-ID: <ZmmAq8fbJLuaX4Qg@redhat.com>
References: <20240612105525.8795-1-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240612105525.8795-1-amonakov@ispras.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 12, 2024 at 01:55:20PM +0300, Alexander Monakov wrote:
> Hello,
> 
> I'm sending straightforward reverts to recent patches that bumped minimum
> required x86 instruction set to SSE4.2. The older chips did not stop working,
> and people still test and use new software on older hardware:
> https://sourceware.org/bugzilla/show_bug.cgi?id=31867
> 
> Considering the very minor gains from the baseline raise, I'm honestly not
> sure why it happened. It seems better to let distributions handle that.

Indeed distros are opinionated about the x86_64 baseline they want
to target.

While RHEL-9 switched to a x86_64-v2 baseline, Fedora has repeatedly
rejected the idea of moving to an x86_64-v2 baseline, wanting to retain
full backwards compat. So this assumption in QEMU is preventing the
distros from satisfying their chosen build target goals.

> Alexander Monakov (5):
>   Revert "host/i386: assume presence of POPCNT"
>   Revert "host/i386: assume presence of SSSE3"
>   Revert "host/i386: assume presence of SSE2"
>   Revert "host/i386: assume presence of CMOV"
>   Revert "meson: assume x86-64-v2 baseline ISA"
> 
>  host/include/i386/host/cpuinfo.h |  3 +++
>  meson.build                      | 10 +++-------
>  tcg/i386/tcg-target.c.inc        | 15 ++++++++++++++-
>  tcg/i386/tcg-target.h            |  5 +++--
>  util/bufferiszero.c              |  4 ++--
>  util/cpuinfo-i386.c              |  7 +++++--
>  6 files changed, 30 insertions(+), 14 deletions(-)
> 
> -- 
> 2.32.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


