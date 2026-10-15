Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152F3CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGLp-0002xk-0K; Thu, 15 Oct 2026 03:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHGLn-0002xR-6i
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHGLl-0004q6-Gx
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792051084;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=P8JNlaNVSEMqUf6BfnRIwwS6CaYRk6K9FlgyB1LqpWk=;
 b=AchWsps1IV1Ci51tC5bop7l5X/5GNrIcHFA/2S4ADPEjG/o3p0FeeeWOBNaERRko4GAhhH
 aX3giu1JIobpaV7/v+4LRDU8FSLhhSf6BTvL27kAULwiEcmo2wRnkc1Pr41OzByxwMBdGs
 QRLBNCJib/Zn3xcmRrUMStXTR7h0Rlg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-cJRRpcs4MMCbTm1kzVY13g-1; Thu,
 15 Oct 2026 07:57:56 +0000
X-MC-Unique: cJRRpcs4MMCbTm1kzVY13g-1
X-Mimecast-MFC-AGG-ID: cJRRpcs4MMCbTm1kzVY13g_1792051075
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0081019560BD; Thu, 15 Oct 2026 07:57:55 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19564195608A; Thu, 15 Oct 2026 07:57:52 +0000 (UTC)
Date: Thu, 15 Oct 2026 08:57:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions
 duplication
Message-ID: <atCHfQ0g-FGMjlBN@redhat.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
 <87bj8vbj3u.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bj8vbj3u.fsf@pond.sub.org>
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

On Thu, Oct 15, 2026 at 07:58:29AM +0200, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
> > This series allows to link multiple targets that define
> > qmp_query_cpu_definitions. It simply replaces the duplicated definitions with
> > target-specific ones and a single dispatcher. We didn't use yet the dispatcher
> > pattern, and it's the first situation where it appears to be a good fit.
> >
> > A possible alternative would be to introduce this callback directly at
> > target-info level, which I think is a less desirable solution, since it would
> > ties this API to monitor.
> 
> I'm curious... why would such a tie be undesirable?

I don't think target-info should be involved at all, it is a problem
to solve in the CPU type system. The CPU definitions are introspecting
sub-classes of TYPE_CPU.

IMHO the right way to solve this is for CPUClass to gain a callback for
introspection, and for each target to provide an impl of that callback.

There should only be a single qmp_query_cpu_definitions method that
introspects all registered TYPE_CPU subclasses. That way in a
multi-target binary, the introspection will return info for all
CPUs for all compiled in targets.

That would need refactoring of the current qmp_query_cpu_definitions
methods which is a bigger job. This series as is, is a reasonable
small initial stepping stone to make it possible to link the binaries,
before a later followup patch to do the full refactoring to get the
desirable API semantics.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


