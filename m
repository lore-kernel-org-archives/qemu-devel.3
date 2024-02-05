Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2B8C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWwHM-0006cC-6K; Mon, 05 Feb 2024 05:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rWwHK-0006bx-DU
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:32:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rWwHI-0005w6-Q4
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707129160;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRcN3IQhhXp+o6SmZxXbDJdiHWjY3cCmRN08jogxgVQ=;
 b=Bagyzz7kPZP6MPhWM7avo9iPCBhDJF5X/6invE9Z3YZnNR44PuUD8pMEmRHfIbd0I2Bfdf
 ieOdUQjC+Bv8S8IWuB4LxwuCM9NwafWlhazX7BJQuMBnfUXu6uK/Rh7dxjLJpqJkYNqyN+
 rxpotFgolPDbUZMhmchXt+BppVjEddU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-GhLSQENyPqiXyumwBG_itQ-1; Mon, 05 Feb 2024 05:32:36 -0500
X-MC-Unique: GhLSQENyPqiXyumwBG_itQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C004101A526;
 Mon,  5 Feb 2024 10:32:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 863222166B31;
 Mon,  5 Feb 2024 10:32:35 +0000 (UTC)
Date: Mon, 5 Feb 2024 10:32:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/2] migration: Fix return-path thread exit
Message-ID: <ZcC5QTO3tmt9gaCf@redhat.com>
References: <20240201184853.890471-1-clg@redhat.com>
 <Zby7o1O5Ox2NNbbP@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zby7o1O5Ox2NNbbP@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 02, 2024 at 05:53:39PM +0800, Peter Xu wrote:
> On Thu, Feb 01, 2024 at 07:48:51PM +0100, Cédric Le Goater wrote:
> > Hello,
> 
> Hi, Cédric,
> 
> Thanks for the patches.
> 
> > 
> > Today, close_return_path_on_source() can perform a shutdown to exit
> > the return-path thread if an error occured. However, migrate_fd_cleanup()
> > does cleanups too early and the shutdown in close_return_path_on_source()
> > fails, leaving the source and destination waiting for an event to occur.
> > 
> > This little series tries to fix that. Comments welcome !  
> 
> One thing I do agree is that relying on qemu_file_get_error(to_dst_file) in
> close_return_path_on_source() is weird: IMHO we have better way to detect
> "whether the migration has error" now, which is migrate_has_error().
> 
> For this specific issue, I think one long standing issue that might be
> relevant is we have two QEMUFile (from_dst_file, to_dst_file) that share
> the same QIOChannel now.  Logically the two QEMUFile should be able to be
> managed separately, say, close() of to_dst_file shouldn't affect the other.
> 
> However I don't think it's the case now, as qemu_fclose(to_dst_file) will
> do qio_channel_close() already, which means there will be a side effect to
> the other QEMUFile that its backing IOC is already closed.
> 
> Is this the issue we're facing?  IOW, the close() of to_dst_file will not
> properly kick the other thread who is blocked at reading from_dst_file,
> while the shutdown() will kick it out?
> 
> If so, not sure whether we can somehow relay the real qio_channel_close()
> to until the last user releases it? IOW, conditionally close() the channel
> in qio_channel_finalize(), if the channel is still open?  Would that make
> sense?

IMHO the problem described above is a result of the design mistake of
having 2 separate QEMUFile instances for what is ultimately the same
channel. This was a convenient approach to take originally, but it has
likely outlived its purpose.

In the ideal world IMHO, QEMUFile would not exist at all, and we would
have a QIOChannelCached that adds the read/write buffering above the
base QIOChannel.

That's doable, but bigger than a quick fix. A natural stepping stone
to get there though is to move from 2 QEMUFile objs down to 1 QEMUFile,
which might be more practical as a quick fix.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


