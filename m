Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607F0C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1c1-0001DL-Mr; Tue, 11 Mar 2025 11:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ts1bv-00017m-QH
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ts1bt-0000uV-6j
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741707214;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ECnhSlHGX+w+7ebbKOwA5lrSYRWd/pSMffA4IIRyikY=;
 b=WSrJAoUhGttYnkOjHvutem7UJDcYZl/udKwpCVqU0kX6BJdQm3i58sQAW69K++7ahzX0Ve
 le5uvBZ46k1lwTLXo+EWkAn2sH/8CcFwAXYTW6mJCpfoRU1dUe/scknRSrBPhLqyMvxOr0
 XsFCmfL0ckP2PXWXxG8iaKBJMcq+CvA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-FWp9H_q6MZm3D7csnXYrcA-1; Tue,
 11 Mar 2025 11:33:29 -0400
X-MC-Unique: FWp9H_q6MZm3D7csnXYrcA-1
X-Mimecast-MFC-AGG-ID: FWp9H_q6MZm3D7csnXYrcA_1741707208
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 563BA1955DDF; Tue, 11 Mar 2025 15:33:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47D9E18001F6; Tue, 11 Mar 2025 15:33:25 +0000 (UTC)
Date: Tue, 11 Mar 2025 15:33:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org,
 leobras@redhat.com, farosas@suse.de, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue
 on ENOBUF failure for sendmsg
Message-ID: <Z9BXw6iZfi_UKx-t@redhat.com>
References: <20250310011500.240782-1-manish.mishra@nutanix.com>
 <Z885hS6QmGOZYj7N@x1.local> <Z89CALrwKnHdO4hx@redhat.com>
 <Z89FjreYuRjEeX1f@x1.local> <Z8_wnLIlfhM7bILZ@redhat.com>
 <Z9BU0gd3BLPhBss2@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9BU0gd3BLPhBss2@x1.local>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 11, 2025 at 11:20:50AM -0400, Peter Xu wrote:
> On Tue, Mar 11, 2025 at 08:13:16AM +0000, Daniel P. Berrangé wrote:
> > On Mon, Mar 10, 2025 at 04:03:26PM -0400, Peter Xu wrote:
> > > On Mon, Mar 10, 2025 at 07:48:16PM +0000, Daniel P. Berrangé wrote:
> > > > Given this is in public API, the data needs to remain reported accurately
> > > > for the whole deprecation period. IOW, the patch to qiochannel needs to
> > > > preserve this data too.
> > > 
> > > :-(
> > > 
> > > We could potentially mark MigrationStats to be experimental as a whole and
> > > declare that in deprecate.rst too, then after two releases, we can randomly
> > > add / remove fields as wish without always need to go through the
> > > deprecation process, am I right?
> > 
> > IMHO that would be an abuse of the process and harmful to applications
> > and users consuming stats.
> 
> Ah I just noticed that's the exact same one we included in
> query-migrate.. Then yes, the stable ABI is important here.
> 
> So for this specific case, maybe we shouldn't have exposed it in QMP from
> the start.
> 
> To me, it's a question on whether we could have something experimental and
> be exposed to QMP, where we don't need to guarantee a strict stable ABI, or
> a very loose ABI (e.g. we can guarantee the command exists, and with
> key-value string-integer pairs, nothing else).

QMP has the ability to tag commands/fields, etc as experimental.

libvirt will explicitly avoid consuming or exposing anything with
an experimental tag on it.

> Maybe what we need is a new MigrationInfoOptional, to be embeded into
> MigrationInfo (or not), marked experimental.  Then in the future whenever
> we want to add some new statistics, we could decide whether it should be
> part of stable ABI or not.

That is not required - individual struct fields can be marked
experimental.

The key question is what the intended usage of the fields/stats/etc
is to be. If you want it used by libvirt and mgmt apps it would need
to be formally supported. If it is just for adhoc QEMU developer
debugging and doesn't need libvirt / app support, then experimental
is fine.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


