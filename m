Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B063D16279
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0MJC-00030Z-20; Mon, 14 Oct 2024 10:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0MJA-000303-Jv
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0MJ8-000439-UN
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728917065;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+bw7SpKEocVmsOAFk05V187KWoXqbzo4/bjxGqP4qs=;
 b=M+pyvodxlzNbS286elCsv91KGnC9vvgHLKxgl+QOWh5Ukxwbx6OOBME8YMho4MNPF0xaYc
 HnISHXrTtayQcRH13hjOXymDJGsjHn8TyZReBAl/uBlpajscYnXlA/pE8Od3TVm2B2zVdk
 2NloF6ohVaqDg+ZSxDYcfgZ3sxW6Ods=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-6KcOJylUOCWFERi1eNAlNA-1; Mon,
 14 Oct 2024 10:44:22 -0400
X-MC-Unique: 6KcOJylUOCWFERi1eNAlNA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 146D81955F10; Mon, 14 Oct 2024 14:44:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.223])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 336FF19560A2; Mon, 14 Oct 2024 14:44:16 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:44:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Julia Suvorova <jusual@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>
Subject: Re: [PATCH] migration: Remove interface query-migrationthreads
Message-ID: <Zw0uPSldQrSYg6e9@redhat.com>
References: <20241011153417.516715-1-peterx@redhat.com>
 <Zwzv3gKV3UibdzTs@redhat.com> <87msj6rcgy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msj6rcgy.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 14, 2024 at 11:22:21AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Oct 11, 2024 at 11:34:17AM -0400, Peter Xu wrote:
> >> This reverts two commits:
> >> 
> >> 671326201dac8fe91222ba0045709f04a8ec3af4
> >> 1b1f4ab69c41279a45ccd0d3178e83471e6e4ec1
> >> 
> >> Meanwhile it adds an entry to removed-features.rst for the
> >> query-migrationthreads QMP command.
> >> 
> >> This patch originates from another patchset [1] that wanted to cleanup the
> >> interface and add corresponding HMP command, as lots of things are missing
> >> in the query report; so far it only reports the main thread and multifd
> >> sender threads; all the rest migration threads are not reported, including
> >> multifd recv threads.
> >> 
> >> As pointed out by Dan in the follow up discussions [1], the API is designed
> >> in an awkward way where CPU pinning may not cover the whole lifecycle of
> >> even the thread being reported.  When asked, we also didn't get chance to
> >> hear from the developer who introduced this feature to explain how this API
> >> can be properly used.
> >> 
> >> OTOH, this feature from debugging POV isn't very helpful either, as all
> >> these information can be easily obtained by GDB.  Esepcially, if with
> >> "-name $VM,debug-threads=on" we do already have names for each migration
> >> threads (which covers more than multifd sender threads).
> >> 
> >> So it looks like the API isn't helpful in any form as of now, besides it
> >> only adds maintenance burden to migration code, even if not much.
> >> 
> >> Considering that so far there's totally no justification on how to use this
> >> interface correctly, let's remove this interface instead of cleaning it up.
> >> 
> >> In this special case, we even go beyond normal deprecation procedure,
> >> because a deprecation process would only make sense when there are existing
> >> users. In this specific case, we expect zero serious users with this API.
> >
> > We have no way of knowing whether there are existing users of this, or
> > any other feature in QEMU. This is why we have a formal deprecation
> > period, rather than immediately deleting existing features.
> >
> > Yes, there are plenty of reasons why this feature is sub-optimal, but
> > it is not broken to the extent that it is *impossible* for people to
> > be using it.
> >
> > IOW, I don't see that there's anything special here to justify bypassing
> > our deprecation process here.
> 
> I have no dog in this race, but as a data point, I see that this was
> submitted to libvirt as a new migrationpin command:
> 
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/FVNAUEVIMLG6F2VCRKHZDUEOLBJCXQHO/#BVEGJVZMMLQMXE263GO5BSIWUDIYIFZU

And unforunately it seems we dropped the ball on reviewing the v2 of
their series and they never ping'd for a response, so this was not
merged. Possibly they're just running it as a local patch to libvirt...


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


