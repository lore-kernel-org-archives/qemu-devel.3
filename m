Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC00D2E02A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3X6f-0001KH-Es; Wed, 23 Oct 2024 04:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X6d-00018y-3Z
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3X6O-000877-QQ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729673544;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WxaZtbHPQyavOpKnO+WUomy9c05Zo0xqTPADtOJEKLU=;
 b=SpzEzQtTIn9tIIirJT095CEpV9RG2fUshoGBVsDpeWlzCZK27DuRQIQKJkojYVz6eOPq4O
 FUZDc97rwO5fJesvD3hDWogq8eC/Q7cAL5aA5kwDcrJOM6vQ7SVlJU2QpTXOZDYJnCsPwz
 abdiFSbSbIUx9uYA3sLtZ0qwIT/HF3w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-qyT_Ory5MgCd3CuEPMqMqA-1; Wed,
 23 Oct 2024 04:52:20 -0400
X-MC-Unique: qyT_Ory5MgCd3CuEPMqMqA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62297195608C; Wed, 23 Oct 2024 08:52:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 477B5300018D; Wed, 23 Oct 2024 08:52:17 +0000 (UTC)
Date: Wed, 23 Oct 2024 09:52:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v2 4/7] ebpf: add formal error reporting to all APIs
Message-ID: <Zxi5PeTIKh7RAh8v@redhat.com>
References: <20240905181330.3657590-1-berrange@redhat.com>
 <20240905181330.3657590-5-berrange@redhat.com>
 <CACGkMEv5DJ=6eH65UE9qjbUt9KWrMnqg1TJKU-d1SBodhLsbRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv5DJ=6eH65UE9qjbUt9KWrMnqg1TJKU-d1SBodhLsbRg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 23, 2024 at 11:55:42AM +0800, Jason Wang wrote:
> On Fri, Sep 6, 2024 at 2:13 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The eBPF code is currently reporting error messages through trace
> > events. Trace events are fine for debugging, but they are not to be
> > considered the primary error reporting mechanism, as their output
> > is inaccessible to callers.
> >
> > This adds an "Error **errp" parameter to all methods which have
> > important error scenarios to report to the caller.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> This doesn't compile:
> 
> [3/84] Compiling C object libcommon.a.p/ebpf_ebpf_rss-stub.c.o

Opps, I didn't update the stub for the new Error parameter.

I've sent a new series with the fix


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


