Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629E2C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 21:08:10 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMDBM-0001N8-3D; Tue, 25 Jun 2024 16:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMDB1-0001Ld-Aq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 16:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMDAJ-0003Ww-Pu
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 16:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719348732;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FnEow6ItVCsHy3Wj8fYlpWX03DfWKKdSG2Ud1N0AXcs=;
 b=Z/OE3OvAa0nQJg6wZU8zERsbzQbn3YTnM9sJcKBd8eVBL8LKae0j6gxqTwRdgLdabtjoxa
 bOD32Ub9olt06ejYzwhT4IWiLXORHrbfkDKANbYvHPH7Jmd6xWlQ89qTbnmqAtqhiiFz8O
 8yFuMyZId4olXJfWItdO6CRqhWEUDc8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-jYAau6XdMRmHZp7zFd2L-w-1; Tue,
 25 Jun 2024 14:37:51 -0400
X-MC-Unique: jYAau6XdMRmHZp7zFd2L-w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA52B1955BDB; Tue, 25 Jun 2024 18:37:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED0431956050; Tue, 25 Jun 2024 18:37:45 +0000 (UTC)
Date: Tue, 25 Jun 2024 19:37:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-devel@nongnu.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
Message-ID: <ZnsOdiHACtL90f3J@redhat.com>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com>
 <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com>
 <ZnrZ9W6WpvmDBpgv@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnrZ9W6WpvmDBpgv@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 25, 2024 at 10:53:41AM -0400, Peter Xu wrote:
> Then the question is how should we suggest the user to specify these two
> parameters.
> 
> The cover letter used:
> 
>   migrate_set_parameter downtime-limit 300
>   migrate_set_parameter switchover-limit 10

What this means is that in practice the total downtime limit
is 310 ms, however, expressing this as two parameters is
incredibly inflexible.

If the actual RAM transfer downtime only took 50 ms, then why
should the switchover downtime still be limited to 10ms, when
we've still got a budget of 250 ms that was unused.

IOW, if my VM tolerates a downtime of 310ms, then I want that
310ms spread across the RAM transfer downtime and switchover
downtime in *any* ratio. ALl that matters is the overall
completion time.

IMHO exposing 2 distinct parameters is horrible from a
usability POV.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


