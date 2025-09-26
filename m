Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7EFCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29QS-0006uw-VM; Fri, 26 Sep 2025 10:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v29QH-0006fX-IM
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v29Q6-0001Cs-3Y
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758896844;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6pQyUvrNrjrzeRj1keQqStCGHL4xYhMqsTwLiQdU2JI=;
 b=Yerq8DzD0iW+n9jYvh/5QOyR7/ItQsH1LMRW0GIw2YvrvJqjWxEAO489R3RzTXvOBbqa85
 Nhk2Mz/zuuOzIPngvm0NrlJSFdI48gtBGxeWgqKKEbK3fBXe6+x5wwOS+o2FV51udDUlLh
 va/z5I8QDkSS0gIW0e2XOqSvu12nP3Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-aCG73W28MQ-qK1knm81xtQ-1; Fri,
 26 Sep 2025 10:27:20 -0400
X-MC-Unique: aCG73W28MQ-qK1knm81xtQ-1
X-Mimecast-MFC-AGG-ID: aCG73W28MQ-qK1knm81xtQ_1758896839
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4716A180057B; Fri, 26 Sep 2025 14:27:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2527619560A2; Fri, 26 Sep 2025 14:27:17 +0000 (UTC)
Date: Fri, 26 Sep 2025 15:27:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 16/23] util: fix interleaving of error & trace output
Message-ID: <aNaiwglxvaX6Pz-4@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-17-berrange@redhat.com>
 <960eb1ad-7b12-45ea-ab40-1fb1d0d82914@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <960eb1ad-7b12-45ea-ab40-1fb1d0d82914@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 25, 2025 at 12:54:13PM -0700, Richard Henderson wrote:
> On 9/25/25 02:44, Daniel P. Berrangé wrote:
> > +    if (monitor_cur_is_hmp()) {
> > +        cur = monitor_cur();
> > +    }
> 
> Didn't your last patch set return Montor* from monitor_cur_is_hmp?
> Because this takes the locks in monitor_cur() twice.

Yes, however, the intent of both this & the previous version is to
optimize the scenario where the monitor is NULL or QMP. If we take
an extra lock in the HMP case that's acceptable and doesn't cause
ill effets.

> 
> > +    if (message_with_timestamp && !cur) {
> >          timestr = real_time_iso8601();
> > -        error_printf("%s ", timestr);
> > +        error_printf_mon(NULL, "%s ", timestr);
> 
> Passing NULL to error_printf_mon is fprintf to stderr.

True, I could have rewritten this to just fprintf. It goes away
later in the series when its all moved into the new qcontext API
call, which is given stderr directly. I guess making it clear it
is stderr at this point in the series, gives reassurance that the
later qcontext conversion hasn't changed the output target.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


