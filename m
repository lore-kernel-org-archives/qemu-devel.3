Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940F5D185C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdoM0-0004UL-L5; Thu, 08 Jan 2026 06:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdoLx-0004TE-JC
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:38:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdoLv-0007El-VJ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767872335;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71n84tYjwp6b+MPF+dHPSoWbfW088RjAnkxzXC1/+Rw=;
 b=QsdPN1gZHkl9D8xViMQ7fHvDitA5ZUpanfxHGAOh8nchySmd57N7vyvvrBhtzHQYD3Ojxf
 ePnUqpJGY/7dxfavOvFkzzXwhMeLxl7ZnBokWJZXUEi0OzPQzyIlC1sGIpARysjQ0QVhLQ
 clwYEUacqVOuCNm91cpjuCvNYMVjs4c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-5RbLwEfiOqO4eaGHwkvhrA-1; Thu,
 08 Jan 2026 06:38:54 -0500
X-MC-Unique: 5RbLwEfiOqO4eaGHwkvhrA-1
X-Mimecast-MFC-AGG-ID: 5RbLwEfiOqO4eaGHwkvhrA_1767872333
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 110C21956080; Thu,  8 Jan 2026 11:38:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0139C18007D2; Thu,  8 Jan 2026 11:38:49 +0000 (UTC)
Date: Thu, 8 Jan 2026 11:38:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@linaro.org
Subject: Re: [PATCH] monitor: disable "info kvm" if !KVM
Message-ID: <aV-XRNT-VwQCdGmv@redhat.com>
References: <aVuUXHT9dt9-ytkG@redhat.com>
 <20260107094020.21819-1-guobin@linux.alibaba.com>
 <87tswwbkoo.fsf@pond.sub.org> <aV983A6AMQz7MzAW@redhat.com>
 <87secg8hhw.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87secg8hhw.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 08, 2026 at 12:35:07PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Jan 08, 2026 at 08:57:59AM +0100, Markus Armbruster wrote:
> >> Bin Guo <guobin@linux.alibaba.com> writes:
> >> 
> >> > Daniel P. Berrangé wrote on Mon, 5 Jan 2026 10:37:16 +0000:
> >> >
> >> >> Missing commit message explaining why we should do this ?
> >> >
> >> > The reason for submitting this patch is that the newly supported 
> >> > 'info accelerators' command can provide a more comprehensive view
> >> > of the accelerator's status.
> >> 
> >> Should we deprecate "info kvm"?
> >
> > Conceptually it is certainly redundant, and for HMP we offer no long
> > term stability promise. Is the benefiting of deprecating and then
> > removing it, worth the inconvenience we'll cause ?
> >
> > Perhaps the more important Q first is whether we should deprecate
> > query-kvm in QMP ?
> 
> Yes.
> 
> "info kvm" is a thin wrapper around query-kvm.  We should either keep
> both or neither.
> 
> What should management applications use, query-kvm or
> query-accelerators?

Functionally it doesn't matter which they use if they care about KVM
state.

Conceptually we want them to prefer the latter since it means their
code is more portable to other accelerators QEMU has.

> 
> If our answer is query-accelerators, we should guide them by deprecating
> query-kvm now.  This doesn't mean we must delete it as soon as the
> deprecation grace period ends.
> 
> If our answer is "we don't care", we can keep query-kvm.
> 
> If our answer is query-kvm, adding query-accelerators was a mistake.
> But I don't think it is.

Yeah, feels like we want the query-kvm deprecation.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


