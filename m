Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0140DCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st4Lf-0001sf-B9; Tue, 24 Sep 2024 08:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1st4LX-0001s3-Ox
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1st4LV-0001c4-5h
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727179722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJzuYE6RemkKc2spXddfReglQUkW8HDLTU2uB5iuU6M=;
 b=ec4FUiu4QDmVoe2/OWTzk1873YPQNbCWyiJKHdkt/3Fxmj29BQW60vF+e8kdkBWkTcpIcQ
 mfPFuo+38LtME9jlO8MrEhtpUnysbZ1OPRuw6rLxA8xl/wpcS5f8OOPRCYM4SCl7KI5X5h
 71m1DtUSMdlsVA4nrSSwJZW0Cr8E2OM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-uc_aN5ccN1WZe4DCwh_Pwg-1; Tue,
 24 Sep 2024 08:08:38 -0400
X-MC-Unique: uc_aN5ccN1WZe4DCwh_Pwg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53B29196E09D; Tue, 24 Sep 2024 12:08:37 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.196])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83DA319560AA; Tue, 24 Sep 2024 12:08:32 +0000 (UTC)
Date: Tue, 24 Sep 2024 14:08:29 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] Add -build-info and -build-info-json CLI arguments
Message-ID: <ZvKrqCR5L21-6k54@redhat.com>
References: <20240923-feature-build-info-cli-v2-1-66b3462f16a1@linaro.org>
 <ZvGbRWSPPLJDx7BX@redhat.com> <ka5ia.wqlrej2ef9q@linaro.org>
 <ZvJ8JblXVH-kJGi1@redhat.com>
 <CAAjaMXZ8q0is2-7-kjyBs=YsBc03=0R2XcYiR-fp05=bcerD6Q@mail.gmail.com>
 <87setpcl9p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87setpcl9p.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 24, 2024 at 01:02:26PM +0100, Alex Bennée wrote:
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> 
> > Hello Daniel,
> >
> > On Tue, 24 Sept 2024 at 11:45, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >>
> >> On Mon, Sep 23, 2024 at 10:09:32PM +0300, Manos Pitsidianakis wrote:
> >> > Hello Daniel,
> >> >
> >> > On Mon, 23 Sep 2024 19:45, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
> >> > > On Mon, Sep 23, 2024 at 09:05:24AM +0300, Manos Pitsidianakis wrote:
> <snip>
> >> > > ie, look a query-audiodevs to discover what audio baxckends are
> >> > > built-in, don't look for CONFIG_XXX settings related to audio.
> >> > > If there are gaps in information we can query from QMP, we should
> >> > > aim to close those gaps.
> >> > >
> >> > > IOW, I don't think we should expose this build info info in either
> >> > > human readable or machine readable format.
> >> >
> >> > QAPI/QMP is not the perspective of this patch, this is for people who use
> >> > custom-built (i.e. not from a distro) binaries and want to be able to
> >> > identify how it was built. Launching a binary to query stuff is
> >> > unnecessarily complex for this task, and the info is not generally
> >> > interesting to the API consumers as you said.
> >>
> >> Launching QEMU to talk QMP is our defined public API for querying
> >> anything about the capabilities of QEMU. We're worked hard to get
> >> away from providing ad-hoc ways to query QEMU from the command
> >> line and going back to that is not desirable. It may be slightly
> >> more complicated, but not by very much.
> >
> > Again, this is not a "capabilities discovery" API. It lists the
> > build-time configuration of the binary. Perhaps we can expose it in a
> > different way so that people don't end up confused?
> 
> I think the problem is however much we might say it's not a capabilities
> discovery API it's very existence encourages users to use it as one.
> 
> What about a script:
> 
>   qemu-get-build-info </path/to/qemu>
> 
> which would launch the binary and query it over QMP? Would that work?

If this is purely a debugging aid, we could make use of ELF notes to
just stick the config-host.h content into the binary. This has precedent
in systemd package notes (https://github.com/systemd/package-notes) and
is more clearly *NOT* an end user CLI option, nor a public API in QMP.

Querying is then

    objdump -j .note.qemu-config-h -s /usrbin/qemu-system-x86_64


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


