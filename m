Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C774C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 10:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZdT-0007HP-8j; Wed, 24 Jul 2024 06:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWZdR-0007BX-NX
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWZdQ-0006MP-0V
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 06:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721818455;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LDM/6+3+mrngKGk9k71H+QyNC58BB+lJ2gTXEPTb+7M=;
 b=VyWpDTmK8fAWV3mzX7LJmXvzO660tgfLangCiIo91DQx6hWKarJJlxs0Py85W255m/YT+4
 MLzA5RGX5Nts3uz3cdUMRHWNcM3xPmnsdScNfT7cCLbKMu+mzh9vJ6f/yQm/T5/If4IWow
 5IPbsrt6t6xFMc5Oph4UcMGlDNOjHAg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-xwaDt9ocMUuI2iO4gIhhOQ-1; Wed,
 24 Jul 2024 06:52:50 -0400
X-MC-Unique: xwaDt9ocMUuI2iO4gIhhOQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25D801955D4A; Wed, 24 Jul 2024 10:52:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.141])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80FFE19560AA; Wed, 24 Jul 2024 10:52:46 +0000 (UTC)
Date: Wed, 24 Jul 2024 11:52:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org
Subject: Re: [PATCH] gitlab-ci: Use -fno-sanitize=function in the clang-user
 job
Message-ID: <ZqDc-i9ej90GoavQ@redhat.com>
References: <20240723232543.18093-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240723232543.18093-1-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 24, 2024 at 09:25:42AM +1000, Richard Henderson wrote:
> With -fsanitize=undefined, which implies -fsanitize=function,
> clang will add a "type signature" before functions.
> It accesses funcptr-8 and funcptr-4 to do so.
> 
> The generated TCG prologue is directly on a page boundary,
> so these accesses segfault.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Does anyone know why we're using --extra-cflags for the clang-user
> and clang-system jobs, as opposed to --enable-sanitizers?  It
> certainly seems like regular users who use the normal configure
> flag are going to run into this as well.
> 
> Anyway, this is why the clang-user job is failing at the momemnt.
> I can only assume that changes to our docker file, or upstream
> distro updates have pulled in a new compiler version, because this
> wasn't failing in this way last week.

Logs show the clang version didn't change, but it is possible the
libubsan.so package changed, but we can't see package versions.

I've sent a series that will make it easier to compare pacakge
versions between new & historical jobs in future situations like
this:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg05749.html


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


