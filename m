Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5D6C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 10:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Lgy-0005Qv-SW; Mon, 28 Apr 2025 06:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1u9Lgh-0005H6-Jv
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1u9Lgb-0003DO-UJ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745835964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8L/Vl7KLYcbc8m1amlTRX99KHG6o8GH3Fy/XlwhZc9s=;
 b=I/bmKX2IavMdfsmbZxy5wtPTqcRTHIVL8ar6v72+dr4Qt5H4r7lLJJmtxsMgqDOFo5jPpc
 dOmdt/DWn5tI5DfeX0FO8TvAIxxh6MIMYg4umAEPS8Iv7bknhKt1c/lXQZEzfah6nvfGrg
 WaKpvpFPMqJ0P2mnDqTwN2i8aEUBpPo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-NpjqbdA8PimjALTxtqNlGQ-1; Mon,
 28 Apr 2025 06:26:02 -0400
X-MC-Unique: NpjqbdA8PimjALTxtqNlGQ-1
X-Mimecast-MFC-AGG-ID: NpjqbdA8PimjALTxtqNlGQ_1745835961
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CC871800874; Mon, 28 Apr 2025 10:26:01 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.14])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9663C1956094; Mon, 28 Apr 2025 10:25:56 +0000 (UTC)
Date: Mon, 28 Apr 2025 12:25:53 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Message-ID: <aA9XsYFIxw-XIcix@angien.pipo.sk>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 25, 2025 at 14:07:34 -0700, Pierrick Bouvier wrote:
> On 4/25/25 08:38, Markus Armbruster wrote:
> > Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> > 
> > > Note: This RFC was posted to trigger a discussion around this topic, and it's
> > > not expected to merge it as it is.
> > > 
> > > Context
> > > =======
> > > 
> > > Linaro is working towards heterogeneous emulation, mixing several architectures
> > > in a single QEMU process. The first prerequisite is to be able to build such a
> > > binary, which we commonly name "single-binary" in our various series.
> > > An (incomplete) list of series is available here:
> > > https://patchew.org/search?q=project%3AQEMU+single-binary
> > > 
> > > We don't expect to change existing command line interface or any observable
> > > behaviour, it should be identical to existing binaries. If anyone notices a
> > > difference, it will be a bug.
> > 
> > Define "notice a difference" :)  More on that below.
> > 
> 
> Given a single-binary *named* exactly like an existing qemu-system-X binary,
> any user or QEMU management layer should not be able to distinguish it from
> the real qemu-system-X binary.
> 
> The new potential things will be:
> - introduction of an (optional) -target option, which allows to
> override/disambiguate default target detected.
> - potentially more boards/cpus/devices visible, once we start developing
> heterogeneous emulation. See it as a new CONFIG_{new_board} present.
> 
> Out of that, once the current target is identified, based on argv[0], there
> should be absolutely no difference, whether in the behaviour, UI, command
> line, or the monitor interfaces.

Okay, so assuming that the correctly named binaries will apply whatever
necessary magic to have them behave identically as they did.

I'll also ignore the distros that rename them assuming they do it in a
way that stays compatible.

The question is how the new unified binary will behave when being
introspected:

 - Can the unified binary be introspected without selecting an
   architecture?
   (by introspection I mean starting with -M none and querying stuff via
   QMP)

   if no: libvirt will have a chicken&egg problem deciding what to do

 - What will be the answer for the platform-specific stuff such as CPU
   definitions?

   e.g. does/can an architecture need to be instantiated later via QMP?
   can it be changed dynamically?


