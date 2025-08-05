Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1966C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 16:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujKHP-0003Jo-Mq; Tue, 05 Aug 2025 12:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujKHE-0003Fj-6j
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ujKHB-0001KK-1d
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754410350;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJb8/C8HQa1sDeRdVrCy/I5ZookJhgzbNewJ8AtSf8o=;
 b=dUhycWZREXF25yxeYjmMONwPUx8HWEIz6hlsOjZNuIydvxh0a+Ka6vrcbOiD97tWWHiAu8
 eCryOZYakyR0jCo5vlC+SdoUJujy2O+mHvrM/WOm4AIFcgprR4Cya0LasAQZ52aWa3DSlJ
 Ozgin+wSPNxmfPJy4UD+OGnLI2RlE4E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-GVQeaBFuMMCXiTzEgo63zA-1; Tue,
 05 Aug 2025 12:12:25 -0400
X-MC-Unique: GVQeaBFuMMCXiTzEgo63zA-1
X-Mimecast-MFC-AGG-ID: GVQeaBFuMMCXiTzEgo63zA_1754410340
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88BEA1800987; Tue,  5 Aug 2025 16:12:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7552B30002C5; Tue,  5 Aug 2025 16:12:18 +0000 (UTC)
Date: Tue, 5 Aug 2025 17:12:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>
Subject: Re: New capabilities for plugins
Message-ID: <aJItXiCESEAPDzec@redhat.com>
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
 <87tt2n5az1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tt2n5az1.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 04, 2025 at 05:05:06PM +0100, Alex Bennée wrote:
> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
> 
> > Hello,
> 
> (Added the *-user MAINTAINERS to the CC)
> > More specifically, the "vcpu_syscall_cb" and "vcpu_syscall_ret"
> > callbacks already allow me to instrument syscall translation entry and
> > exit points. While the register read/write APIs also allow me to
> > modify register contents in my syscall callback implementations, there
> > is currently no good way to emulate a syscall myself in the plugin or
> > explicitly set the syscall return value (as it will be overwritten
> > with the original syscall's return value again, even if I set the
> > corresponding guest register).
> >
> > I was wondering whether the QEMU community would be open to extending
> > the plugin API so that a plugin can fully emulate a syscall without
> > the original syscall being executed by QEMU.
> 
> I will defer to the *-user maintainers here. One thing we are keen to
> avoid is plugins being used as a mechanism to work around the GPL
> requirements of QEMU itself. It would be useful if you could outline the
> use case for a plugin doing the emulation itself?

Yeah, this sounds like it is potentially going a step too far in enabling
fully out of tree extension of core QEMU functionality.

If something conceptually is in scope of the core QEMU codebase, then
IMHO, our plugin system should aim to avoid enabling external
implementations as far as is practical.  That was easy when plugins
were limited to observability, but the more we enable in terms of
state modification the wider pandora's box is opened.

Where to draw the line is a hard problem.

Excluding some undesirable features, may well force us to exclude some
potentially desirable plugin use cases at the same time, which may make
it impossible to keep everyone satisfied.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


