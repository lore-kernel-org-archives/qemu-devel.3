Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC34F4181F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeEl-0001PG-UA; Mon, 09 Mar 2026 13:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzeEh-0001Gj-6y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzeEf-0005yK-Fl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773076660;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxI1A+UI0gTbKYSA6FHmtLhubKIPu82spxDacs+X7uU=;
 b=dwydxxswFnwkmVEv/wrJTNNPa7BzedotFVypoqJFIVgwAa9ZkNYwd/SS9s9lZ7E844H2tc
 hbnbFk1Hrczhhy75PSc5ulUnayNd9H4GUf3h4iIx2FZBP24fjGbHRcVqFKH6NlHlJVSgrs
 Z59U/4ev3Ee+8Nnmo8kW9Iy47RjLgL8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-pYWLrK1gO22m-oPNy7_Fqg-1; Mon,
 09 Mar 2026 13:17:35 -0400
X-MC-Unique: pYWLrK1gO22m-oPNy7_Fqg-1
X-Mimecast-MFC-AGG-ID: pYWLrK1gO22m-oPNy7_Fqg_1773076654
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3ADE18005B9; Mon,  9 Mar 2026 17:17:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 740951956095; Mon,  9 Mar 2026 17:17:32 +0000 (UTC)
Date: Mon, 9 Mar 2026 17:17:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Message-ID: <aa8AqKqOa8YhEiF9@redhat.com>
References: <20260309090907.956330-1-tejus.gk@nutanix.com>
 <aa755Yc6t_bBzM_u@redhat.com> <aa78gMsQrt1BeXt3@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa78gMsQrt1BeXt3@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, Mar 09, 2026 at 12:59:44PM -0400, Peter Xu wrote:
> On Mon, Mar 09, 2026 at 04:48:37PM +0000, Daniel P. Berrangé wrote:
> > > @@ -881,8 +881,8 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> > >          sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
> > >  
> > >          /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
> > > -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> > > -            sioc->new_zero_copy_sent_success = true;
> > > +        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
> > > +            sioc->zero_copy_fallback++;
> > 
> > ...this is counting the number of MSG_ERRQUEUE items, which is not
> > the same as the number of IO requests. That's why we only used it
> > as a boolean marker originally, rather than making it a counter.
> 
> Would the logic still work and better than before?  Say, it's a counter of
> "messages" rather than "IOs" then.

IIUC it is a counter of processing notifications which is not directly
correlated to any action by QEMU - neither bytes nor syscalls.

> The problem with the old code was we may report fallback=0 even if there
> can have fallback happened, as we mask that fact as long as one zerocopy
> happened in the whole batch between two flushes.  So it seems this (even if
> the counter is not per-IO) is still better.

Better for what purpose though ?

If we enabled zero-copy, it is useful to know if /something/ managed
to benefit from zero-copy. ie if /always/ fails to zero-copy then
we can diagnose that the NIC driver isn't capable of it, or there
is some other limitation.  If something manages to zero-copy, then
we know the feature is functionally working.

What will we do with a count of notificaitons ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


