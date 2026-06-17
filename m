Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA106CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZpNN-0004ft-Ch; Wed, 17 Jun 2026 08:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZpNL-0004fI-Lv
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZpNJ-0004ON-QJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781699288;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wkx7IKr2LZHevlID2SJLarBz4rC12MFYWjtRT76vzu0=;
 b=TYRTXcvyjGX6IUVIV+PlIpYYBUhKsBj0LgABYjxlw+NbWj54sC17+BcUPNosqUPZ4UjYXp
 Zh+UqEPXES7Y9ZpFG2UzXF3smgyDTxBaDvn0Kdry6qgXHyWzeIa5PcKgTXpvFNlWyYhTJk
 pPT3eJtIyGzInsPSFq8rPCFMuLR1hC0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-Y3d6oo6gNnC-b-K-mH6znQ-1; Wed,
 17 Jun 2026 08:28:05 -0400
X-MC-Unique: Y3d6oo6gNnC-b-K-mH6znQ-1
X-Mimecast-MFC-AGG-ID: Y3d6oo6gNnC-b-K-mH6znQ_1781699283
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3B8019560AD; Wed, 17 Jun 2026 12:28:02 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A5121955BC2; Wed, 17 Jun 2026 12:27:54 +0000 (UTC)
Date: Wed, 17 Jun 2026 13:27:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 05/10] qom: Create object-property-ptr.[ch]
Message-ID: <ajKSxy1sLHvK8wsW@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-6-peterx@redhat.com>
 <aimNv51iMZ_yEgDG@redhat.com> <aimvTYDsv_-Xsboy@x1.local>
 <aiq9g60bOnvsOQOy@redhat.com> <87h5n94001.fsf@suse.de>
 <airI3UKeVVRUdQHq@redhat.com> <ajG54jNEs4JDBRJP@x1.local>
 <87wlvx5p6w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wlvx5p6w.fsf@suse.de>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 17, 2026 at 09:25:27AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jun 11, 2026 at 03:40:29PM +0100, Daniel P. Berrangé wrote:
> >> There's nothing standard in QOM, but in patch 10 in this series
> >> Peter has a DEFINE_TLS_PROP_HELPERS() which macro-ized the
> >> repetitive getters/setters for the TLS string properties. The
> >> duplicate code still exists in the binary of course, just hidden
> >> from the source.
> >
> > I believe we have the standard, which is qdev-properties.. which is (1)
> > class properties, (2) allow variable bindings so no setter/getter needed,
> > remembering them with pointer offsets.
> >
> > It goes back to last version where the question becomes: whether we want to
> > make qdev-properties to be official QOM API, by removing qdev specific
> > changes and move them over to qom/.  Then make qdev only add its special
> > things on top.
> >
> > Said that, considering if we want to make all things qom-set-able to
> > migration in the future, another option is directly go with getter/setter
> > that will do the property checks one by one. One benefit of that is we can
> > then get rid of migrate_params_check() and migrate_caps_check() altogether.
> >
> > Maybe I should go with the latter, and forget qdev?
> 
> I think it's a good idea. For caps that depend on one another do you
> intend to check once in each setter? The _check functions exist is
> because we want to validate the total state of params/caps, not just a
> single param. Just pointing it out, it's not necessarily an issue.

The user-creatable interface has a "complete" method which is called
once all props have been set. So if there are semantics you can't
validate against individual props in isolation, you can leave that
validation until "complete".


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


