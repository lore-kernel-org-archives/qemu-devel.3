Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5694C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZA2i-0002Es-TF; Wed, 31 Jul 2024 10:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZA2h-0002AI-Lk
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZA2g-0004lM-1C
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722435059;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BRvORSIQgukT3HX62citwsPVtIu/9z1HbQalEpRu9rA=;
 b=OFvAJ9z5t/GzmdgvxFjLVxJl90SmR7TLU1OS3A60CryNpCtnTDadYEV9MoSRi5ee0z/Kk/
 izeA04k3m8C6gpisIW9D3cDPCy0OInr0I4GAxmw5a+9vdhIA89I/4IFhvDT8REMvi2t+bH
 hyNFt2k/fY24EKlmEapikoLgEd3gJZs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-BCLbsNelMayWEsO_CCMZRg-1; Wed,
 31 Jul 2024 10:10:57 -0400
X-MC-Unique: BCLbsNelMayWEsO_CCMZRg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C7DB19540F2; Wed, 31 Jul 2024 14:10:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D975F19560AE; Wed, 31 Jul 2024 14:10:52 +0000 (UTC)
Date: Wed, 31 Jul 2024 15:10:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] util: retry open() when it gets interrupted by a signal
Message-ID: <ZqpF6VoZgFsfhhl7@redhat.com>
References: <20240731132524.308273-1-philipp.reisner@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731132524.308273-1-philipp.reisner@linbit.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Wed, Jul 31, 2024 at 03:25:24PM +0200, Philipp Reisner wrote:
> As with many syscalls, open() might be interrupted by a signal.
> 
> The experienced logfile entry is:
> 
> qemu-system-x86_64: -device virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-format,id=virtio-disk0,bootindex=2,write-cache=on,serial=1b990c4d13b74a4e90ea: Could not open '/dev/drbd1003': Interrupted system call
> 
> Retry it until it is not interrupted by a signal.

As you say, many syscalls can be interruptted by signals, so
special casing open() isn't really a solution - its just
addressing one specific instance you happened to see.

If there are certain signals that we don't want to have a
fatal interruption for, it'd be better to set SA_RESTART
with sigaction, which will auto-restart a large set of
syscalls, while allowing other signals to be fatal.

> FYI, dd has the same kind of loop aroud open().
> https://github.com/coreutils/coreutils/blob/1ae98dbda7322427e8226356fd110d2553f5fac9/src/dd.c#L1294-L1299
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> ---
>  util/osdep.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/util/osdep.c b/util/osdep.c
> index 770369831b..a1269d9345 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -294,14 +294,17 @@ bool qemu_has_direct_io(void)
>  static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
>  {
>      int ret;
> +    do  {
>  #ifdef O_CLOEXEC
> -    ret = open(name, flags | O_CLOEXEC, mode);
> +        ret = open(name, flags | O_CLOEXEC, mode);
>  #else
> -    ret = open(name, flags, mode);
> -    if (ret >= 0) {
> -        qemu_set_cloexec(ret);
> -    }
> +        ret = open(name, flags, mode);
> +        if (ret >= 0) {
> +            qemu_set_cloexec(ret);
> +        }
>  #endif
> +    } while (ret == -1 && errno == EINTR);
> +
>      return ret;
>  }
>  
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


