Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01ACE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 07:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsyNa-0006aP-UA; Thu, 19 Feb 2026 02:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsyNZ-0006ZS-Jp
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 02:23:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsyNW-0004E4-K6
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 02:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771485792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aCO6SzqtcvVu9BwZDiaN2YuO9vE34XPDwLDBt7dqaKY=;
 b=OVISq+LsUGokL1smAB6g0D38x6tpWS64JtJGsTIqAYQNx1NhFRRQwmcDvogYSHzYW6y175
 Wpf0DObHKm6zOqpys1mV0LUtazYRvmRmXSpONtwJQ20gVFBPO1dLPtZsrnneYyD7tTMFnR
 YDLj4YAMjRxeE7vvLYkp8kW8AGvzcFc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-ltMGqIzpO4WPdyUbEAFRPg-1; Thu,
 19 Feb 2026 02:23:10 -0500
X-MC-Unique: ltMGqIzpO4WPdyUbEAFRPg-1
X-Mimecast-MFC-AGG-ID: ltMGqIzpO4WPdyUbEAFRPg_1771485789
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BFF2195608A; Thu, 19 Feb 2026 07:23:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD3863000C26; Thu, 19 Feb 2026 07:23:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 58DD121E692D; Thu, 19 Feb 2026 08:23:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>,  qemu-devel@nongnu.org,  Juraj Marcin
 <jmarcin@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/2] migration: feature removals for 11.0
In-Reply-To: <aZYtQLZfhRr61Dvh@x1.local> (Peter Xu's message of "Wed, 18 Feb
 2026 16:21:04 -0500")
References: <20260115225503.3083355-1-peterx@redhat.com>
 <aZQ0q2r6w3OkSP2f@angien.pipo.sk> <87ms17lihr.fsf@pond.sub.org>
 <aZYtQLZfhRr61Dvh@x1.local>
Date: Thu, 19 Feb 2026 08:23:06 +0100
Message-ID: <87jyw96vtx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> On Tue, Feb 17, 2026 at 12:25:20PM +0100, Markus Armbruster wrote:
>> Peter Krempa <pkrempa@redhat.com> writes:
>> 
>> > On Thu, Jan 15, 2026 at 17:55:01 -0500, Peter Xu wrote:
>> >> v2:
>> >> - Added R-bs
>> >> - Updated description for removing zero-blocks [Markus]
>> >> - Squashed the "fd: to file" test removal into the 2nd patch
>> >> - I dropped the COLO patch, I have a local patch to remove colo migration
>> >>   completely, but looks like we won't do it..  Let's leave it for later but
>> >>   do the rest first
>> >> 
>> >> This series removes two deprecated features for 11.0.
>> >> 
>> >> Please review, thanks.
>> >> 
>> >> Peter Xu (2):
>> >>   migration: Remove zero-blocks capability
>> >>   migration: Remove fd: support on files
>> >> 
>> >>  docs/about/deprecated.rst             | 20 -------------
>> >
>> > Note that per the 'MAINTAINERS' file, changes to any deprecations ought
>> > to be CC'd to the libvirt list for visibility.
>> >
>> > In this case we've forgotten about the deprecation and didn't fix it
>> > before the qemu cahnge was pushed. I'll send out patches soon, but keep
>> > in mind to *always* CC the libvirt list with deprecations.
>> 
>> Review fail (mine).
>
> I confess I didn't notice this hard requirement when posting deprecation
> patches.  I definitely kept in mind of libvirt all the time, it's just that
> for this one since it used to be discussed well I didn't expect this to
> cause any surprise.
>
>> 
>> Should we try to make checkpatch.pl catch it?  So far, it doesn't check
>> cc: at all.
>
> I don't know if that'll work because logically we can also copy anyone or
> lists only when sending patches (e.g. with "git send-email --cc")..

For what it's worth, scripts/get_maintainer.pl would have told us to cc:
libvirt with this line:

    devel@lists.libvirt.org (open list:Incompatible changes)

> For now, I'll just remember to always copy libvirt list on touching
> deprecation file.  My apologize if it caused any unwanted surprise.

We cannot and do not expect a patch submitter to know and remember
everything.  We rely on tooling and review to catch misses in time.
Doesn't always work, because nothing and nobody's perfect.


