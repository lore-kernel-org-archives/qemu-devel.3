Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5827C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 11:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpRfS-0000G9-8h; Wed, 27 Mar 2024 07:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpRfO-0000Fs-8b
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rpRfK-00034X-TA
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711539717;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fKtWsIWKTf7VHEbTygs+THyUm7xWxCPCaawYAOWer8=;
 b=DwLodTj+kbJq3sYJIZ8oZqsVQS58LHctNvcNCsZl/g4QK1oJkIrAc6IhLYsJfOIRVobCzm
 cdnAo+sDNG0k9VcUvm+CtgfkqTCI4mpCvZ+Z3kyQQrr23EFobrr3JuimdUFgvD6Q1UTEgN
 jaMazzC3xnF6FMIQWA9wVTyDG51RW3E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-aiUP275HM9ylgcsGT_AANw-1; Wed,
 27 Mar 2024 07:41:55 -0400
X-MC-Unique: aiUP275HM9ylgcsGT_AANw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F064E2824095;
 Wed, 27 Mar 2024 11:41:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 611B32166B4F;
 Wed, 27 Mar 2024 11:41:54 +0000 (UTC)
Date: Wed, 27 Mar 2024 11:41:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>
Subject: Re: Compiling QEMU with different optimization levels &
 -Werror=maybe-uninitialized
Message-ID: <ZgQF_IeINhl2ulLT@redhat.com>
References: <CAJ+F1CLrKKv=Kv_Aagii4B5eATmXoKGz0ka5-m82+Eeq0uknvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLrKKv=Kv_Aagii4B5eATmXoKGz0ka5-m82+Eeq0uknvA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 27, 2024 at 03:28:08PM +0400, Marc-André Lureau wrote:
> Hi,
> 
> Depending -Doptimization=<value>, I get different results (GCC 13.2.1)
> - g: produces -Werror=maybe-uninitialized errors
> - 0: clean build
> - 1: produces -Werror=maybe-uninitialized errors
> - 2: clean build
> - 3: produces few -Werror=maybe-uninitialized errors
> - s: produces -Werror=maybe-uninitialized errors
> 
> They are about 20, probably false-positives, although it's
> understandable the compiler is confused as I am too sometime!

If any of those maybe-uninitialized warnings are genuine bugs, our
use of use of -ftrivial-auto-var-init provides a safety net that
protects us....

> 
> Is it a known issue? Are we willing to help the compiler in all those
> optimization levels? I can send a patch series for review in this
> case.

...none the less, IMHO, it is good practice to initialize all local stack
allocated variables at time of declaration no matter what. So if you have
patches to clear those false positives, I'd suggest  we just do it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


