Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18648C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 11:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCd1A-0005Ev-6w; Wed, 07 May 2025 07:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCd16-0005B4-Tt
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCd14-0005wV-EL
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746617564;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pxM5jB3LLaPuxnFFo/7QBR6tBoc9D6uYDoaQGWOt/jI=;
 b=Jh86NP6mPh3iGUtyOb8DSMTZUDNjYZ67BdZ4psBdU1gBL0QEn4+cAEGBh1mWZXo5huoCLj
 Z8XVQj305ZGEuJQsj2w77IW9Laku+l6xq58WPozlq5Gg/RgqA1u3lv6+z1VRc1ZBHebyyq
 yoqF6XRgk7NsQV5/lmx1ZmutWV/joJg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-y2w1WCaIPS2D7P0vjoVJnw-1; Wed,
 07 May 2025 07:32:41 -0400
X-MC-Unique: y2w1WCaIPS2D7P0vjoVJnw-1
X-Mimecast-MFC-AGG-ID: y2w1WCaIPS2D7P0vjoVJnw_1746617560
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDE6918004A7; Wed,  7 May 2025 11:32:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 421F01953B80; Wed,  7 May 2025 11:32:34 +0000 (UTC)
Date: Wed, 7 May 2025 12:32:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org, Victor Toso <victortoso@redhat.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Message-ID: <aBtEz_yKswP-yECK@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <87a583789z.fsf@pond.sub.org>
 <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org>
 <8734drpg4j.fsf@pond.sub.org>
 <f2972cb4-4266-4835-9548-706983dc611f@linaro.org>
 <87msbokg7y.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msbokg7y.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 07, 2025 at 09:55:13AM +0200, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
> [...]
> 
> > I don't think we should think too much ahead for languages other than C, 
> > for one, two, and even three reasons :)
> 
> I agree that thinking ahead too much is a bad habit.  So is thinking
> ahead too little :)
> 
> > - First, it's already broken because we rely on ifdef that won't be 
> > there in Rust or Go.
> 
> I don't think it's broken.  QAPI 'if' translates straightforwardly to C
> #if, but that doesn't mean it cannot be translated to conditional
> compilation / metaprogramming in other languages.
> 
> In fact, the value of 'if' used to be C constant expressions suitable
> for use with #if, and we changed it to its current form specifically to
> enable Rust work, in merge commit c83fcfaf8a5.  Marc-André's was trying
> to develop Rust bindings back then, and if I remember correctly this
> change was enough to let him implement 'if' with Rust.

The usefulness of the conditions to non-C languages may well
vary depended on intended use case.

If I'm writing a mgmt app that can talk to QEMU, and I want
to be able to talk to both x86 and s390 system emulators,
I am unlikely to want the language bindings to omit features
based on TARGET_xxx conditions. I won't want a separate API
for each QEMU arch target, I'll want one API for all arches.

Expanding this further, if I'm writing a mgmt app to talk
to QEMU 9.2.0, I am also unlikely to want the language
bindings to omit features based on CONFIG_xxxx conditions,
because I likely want to talk to a QEMU 9.2.0 built by any
OS distro, each of which may have chosen a different set
of --enable flags for configure, and thus having different
CONFIG_xxx conditions.

TL;DR: in terms of code generation, the prime use case for
conditionally generated code is for QEMU's own internal usage.
For QMP bindings generated for 3rd party app usage, the use
of conditions in generation feels like a niche requirment at
best.

IMHO the code for any public facing API derived from QMP
schema should be invariant for any given QEMU release.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


