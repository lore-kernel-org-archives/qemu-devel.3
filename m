Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B07CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHdgx-00087U-O5; Fri, 16 Oct 2026 04:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHdgv-000871-LT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHdgt-0001ic-G3
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792140806;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttLE02GeJbMkyg6wtpfeN68MmqL9G8HpySuuQk6VK9Y=;
 b=dB7xMf8fbNyswZ0HlY2JamdpOadmBF/rhAE31681guE9nXbbiSxvVatK6cPEHb91mUvzE2
 YsiibwFM3RsoNrvd3b+PhZy1dGKpSyPmj7gdYw88x36sBI9/eiD3S+nYgAFAB8IdUE4tpX
 zwGRpAFa72OJCY4jAOHDhsKkDMhLyyY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-8mVHjD5ePoqp2tpkUw50NQ-1; Fri,
 16 Oct 2026 08:53:22 +0000
X-MC-Unique: 8mVHjD5ePoqp2tpkUw50NQ-1
X-Mimecast-MFC-AGG-ID: 8mVHjD5ePoqp2tpkUw50NQ_1792140802
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4C5C1954234; Fri, 16 Oct 2026 08:53:21 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5DF11956089; Fri, 16 Oct 2026 08:53:19 +0000 (UTC)
Date: Fri, 16 Oct 2026 09:53:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions
 duplication
Message-ID: <atHl_Dvx3N8r_IXV@redhat.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
 <87bj8vbj3u.fsf@pond.sub.org> <atCHfQ0g-FGMjlBN@redhat.com>
 <e9807140-5a65-413e-be58-c3e268125431@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9807140-5a65-413e-be58-c3e268125431@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Thu, Oct 15, 2026 at 10:57:50AM -0700, Pierrick Bouvier wrote:
> On 10/15/2026 12:57 AM, Daniel P. Berrangé wrote:
> > On Thu, Oct 15, 2026 at 07:58:29AM +0200, Markus Armbruster wrote:
> >> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> >>
> >>> This series allows to link multiple targets that define
> >>> qmp_query_cpu_definitions. It simply replaces the duplicated definitions with
> >>> target-specific ones and a single dispatcher. We didn't use yet the dispatcher
> >>> pattern, and it's the first situation where it appears to be a good fit.
> >>>
> >>> A possible alternative would be to introduce this callback directly at
> >>> target-info level, which I think is a less desirable solution, since it would
> >>> ties this API to monitor.
> >>
> >> I'm curious... why would such a tie be undesirable?
> > 
> > I don't think target-info should be involved at all, it is a problem
> > to solve in the CPU type system. The CPU definitions are introspecting
> > sub-classes of TYPE_CPU.
> > 
> > IMHO the right way to solve this is for CPUClass to gain a callback for
> > introspection, and for each target to provide an impl of that callback.
> > 
> > There should only be a single qmp_query_cpu_definitions method that
> > introspects all registered TYPE_CPU subclasses. That way in a
> > multi-target binary, the introspection will return info for all
> > CPUs for all compiled in targets.
> >
> 
> I was wondering if what we would like to expose is all targets, or only
> the ones that have a cpu active.

Introspection commands such as this one generally should report on
everything that is built-in to the binary.

> > That would need refactoring of the current qmp_query_cpu_definitions
> > methods which is a bigger job. This series as is, is a reasonable
> > small initial stepping stone to make it possible to link the binaries,
> > before a later followup patch to do the full refactoring to get the
> > desirable API semantics.
> >
> 
> That was the goal 👍.
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


