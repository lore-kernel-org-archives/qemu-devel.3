Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F541C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXILO-0005wS-2l; Tue, 06 Feb 2024 05:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXILL-0005wF-12
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXILJ-00087l-Iq
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707213976;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvYZH6FoKZhuUjGEgS8Bql+VBnQt/qTxmLVZdMt66aY=;
 b=Qf+oTTFBoRpziZXdP6++7nES8aLRekq2avQM1pbRt8/XRcUXyqTMih+V0SxL70lunlayF6
 5HE/gvq9Xxis1pIDLnOKphoaNDJ0WvHBmfNuRUHOzIzvzUQw0tQbpPMsgvpXrrRGjmnWUU
 vIaLkjlLlwWR8YY7O7wy32yU6DizLLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-oLrz8YeEMJqaqq6xB7Msdg-1; Tue, 06 Feb 2024 05:06:13 -0500
X-MC-Unique: oLrz8YeEMJqaqq6xB7Msdg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 066B5101FA37;
 Tue,  6 Feb 2024 10:06:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C0D5492BF0;
 Tue,  6 Feb 2024 10:06:12 +0000 (UTC)
Date: Tue, 6 Feb 2024 10:06:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Avihai Horon <avihaih@nvidia.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 1/6] migration/multifd: Join the TLS thread
Message-ID: <ZcIEkUre5AE7C9DN@redhat.com>
References: <20240205194929.28963-1-farosas@suse.de>
 <20240205194929.28963-2-farosas@suse.de>
 <ZcHzmb6gVJtS_flp@redhat.com> <ZcH4m3hLkYQxwt1S@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcH4m3hLkYQxwt1S@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 06, 2024 at 05:15:07PM +0800, Peter Xu wrote:
> On Tue, Feb 06, 2024 at 08:53:45AM +0000, Daniel P. Berrangé wrote:
> > AFAICS, it is not ovewriting 'p->thread' because at the time when the
> > TLS thread is created, the main 'send thread' has not yet been
> > created. The TLS thread and send thread execution times are mutually
> > exclusive.
> 
> IIUC it'll be overwritten after the tls handshake, where in the tls thread
> uses multifd_channel_connect() to create the ultimate multifd thread with
> the same p->thread variable:
> 
>     qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
>                        QEMU_THREAD_JOINABLE);
> 
> There it'll overwrite the old value setup by p->thread, hence the tls
> thread resource should be leaked until QEMU quits when created with
> JOINABLE in both contexts.

Ah yes, missed that, you're right.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


