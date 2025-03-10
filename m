Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CC7C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZAy-0002NK-Vm; Mon, 10 Mar 2025 05:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trZAr-0002Lu-EQ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trZAp-0004o0-3L
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741597904;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcPTOuqF9BfkHpmpmgo+IcFc+83Twl423OmKTcgLbYY=;
 b=G9YnAekpy8J2DjiFSNJC36TBgqmPEx86XE+Fbe1NQXtItv9ijoMUOixmQ5ejDoHTlFOHfa
 yDOW/nixha8yJNWorkEK/2NvYWVyPf1Z7ogbQqHIWohJx++DzfFB8nBCXVwSPxTzATANOC
 Jp/OAoBU+G7Iw4HeXFotrC1pxthCWTQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-_kIn-PmmNou8-rKW2Pf9qw-1; Mon,
 10 Mar 2025 05:11:40 -0400
X-MC-Unique: _kIn-PmmNou8-rKW2Pf9qw-1
X-Mimecast-MFC-AGG-ID: _kIn-PmmNou8-rKW2Pf9qw_1741597897
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A6471800266; Mon, 10 Mar 2025 09:11:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47AC819560AB; Mon, 10 Mar 2025 09:11:24 +0000 (UTC)
Date: Mon, 10 Mar 2025 09:11:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 David Hildenbrand <david@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
Message-ID: <Z86suUJsscIwh2sP@redhat.com>
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <Zl20rAjHLJlZkwxE@redhat.com>
 <fda186da-2e31-42d6-8dd6-0ea3141a73e6@linaro.org>
 <d74d3ff3-3830-4682-87e3-a42ed57068d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d74d3ff3-3830-4682-87e3-a42ed57068d9@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Mar 10, 2025 at 07:50:57AM +0100, Thomas Huth wrote:
> On 09/03/2025 19.55, Pierrick Bouvier wrote:
> > On 6/3/24 05:18, Daniel P. Berrangé wrote:
> > > On Fri, May 31, 2024 at 06:47:45AM +0200, Thomas Huth wrote:
> > > > On 30/05/2024 09.45, Philippe Mathieu-Daudé wrote:
> > > > > We are trying to unify all qemu-system-FOO to a single binary.
> > > > > In order to do that we need to remove QAPI target specific code.
> > > > > 
> > > > > @dump-skeys is only available on qemu-system-s390x. This series
> > > > > rename it as @dump-s390-skey, making it available on other
> > > > > binaries. We take care of backward compatibility via deprecation.
> > > > > 
> > > > > Philippe Mathieu-Daudé (4):
> > > > >     hw/s390x: Introduce the @dump-s390-skeys QMP command
> > > > >     hw/s390x: Introduce the 'dump_s390_skeys' HMP command
> > > > >     hw/s390x: Deprecate the HMP 'dump_skeys' command
> > > > >     hw/s390x: Deprecate the QMP @dump-skeys command
> > > > 
> > > > Why do we have to rename the command? Just for the sake of it? I think
> > > > renaming HMP commands is maybe ok, but breaking the API in QMP is something
> > > > you should consider twice.
> > > 
> > > That was going to be my question too. Seems like its possible to simply
> > > stub out the existing command for other targets.
> > > 
> > > The renaming is just window dressing.
> > > 
> > 
> > Working on single-binary topic means specificities from every qemu
> > binary/ architecture has to be merged together. Despite appearing has a
> > bad thing now, it's definitely a step forward for QEMU, and will allow
> > to enable new usages.
> > 
> > The hard way is to trigger a deep refactoring, involving lengthy
> > conversations where compromises have to be found ("let's implement this
> > for all arch"). The pragmatic way is to eliminate obvious stuff.
> > 
> > This command is specific to an arch, so renaming is a good and obvious
> > strategy. For the backward compatible anxious developer, another
> > strategy would be to simply declare this command if the running target
> > is s390x. But then, you create a precedent to do something that should
> > not have existed in the first place.
> > 
> > +1 for the renaming, and hope that users of this command are able to
> > change a line in their script to adapt to the new command.
> 
> Sorry, but no: We've got plenty of other target specific commands...
> rtc-reset-reinjection , query-sev, query-gic-capabilities, just to name some
> few. So unless you provide a patch series to rename *all* of them and
> deprecate the previous names, I don't see the point why changing just one
> single s390x command is necessary.

Agreed, I don't see a need to special case s390 and rename this command,
nor extend it to all the others you mention.

The QAPI docs will show users that it is s390x specific if they didn't
already work it out for themselves.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


