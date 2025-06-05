Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15025C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 19:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNG8d-0001bh-P1; Thu, 05 Jun 2025 15:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNG8c-0001bX-36
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNG8a-0006AK-16
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 15:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749151227;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHqxCczJk88hBwGi/fQ29fleTRlV0rHAZUfMIQnqqGE=;
 b=ZtythU78Rlv/IG9XV6NmqcTqCHBg4+qbpezasGlhVe/K7aF0OsNN2gpSg0P8rSP7MIVknK
 t64v13O7Caeupf1ol35goep3ZDVyguHhyVb6ZXP4/4Jl3dgu1Vsh3oVfPN0HuqgYu+X/k9
 allYff/hPfqiiTKX+TXJ7eu1HOZj1/8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-PjYyfjDJPkyvREZJm3yUhQ-1; Thu,
 05 Jun 2025 15:20:24 -0400
X-MC-Unique: PjYyfjDJPkyvREZJm3yUhQ-1
X-Mimecast-MFC-AGG-ID: PjYyfjDJPkyvREZJm3yUhQ_1749151223
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F8581800345; Thu,  5 Jun 2025 19:20:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12CE71954B33; Thu,  5 Jun 2025 19:20:20 +0000 (UTC)
Date: Thu, 5 Jun 2025 20:20:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>, qemu-devel@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 2/3] trace/ftrace: seperate cold paths of tracing functions
Message-ID: <aEHt8cL9EAtM3jBm@redhat.com>
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
 <20250601181231.3461-3-tanishdesai37@gmail.com>
 <20250602222434.GB320269@fedora>
 <7f4eefa2-9e00-4ba2-898f-c480c2123904@redhat.com>
 <CAJSP0QX=e3GkB5L0rpAf8YfkJDKOZYJcx553tut+7Hp2NK3XYg@mail.gmail.com>
 <03c067fc-2a47-4fc5-9204-1ac6ded4301b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03c067fc-2a47-4fc5-9204-1ac6ded4301b@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On Thu, Jun 05, 2025 at 08:49:36PM +0200, Paolo Bonzini wrote:
> On 6/5/25 20:37, Stefan Hajnoczi wrote:
> > On Thu, Jun 5, 2025 at 9:57 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > It's easier to understand the code generator and the generated code when
> > > > each trace event is implemented as a single function in the header file.
> > > > Splitting the trace event up adds complexity. I don't think this is a
> > > > step in the right direction.
> > > 
> > > I am not sure I agree on that; something like
> > > 
> > > static inline void trace_smmu_config_cache_inv(uint32_t sid)
> > > {
> > >       if (trace_event_get_state(TRACE_SMMU_CONFIG_CACHE_INV)) {
> > >           _simple__trace_smmu_config_cache_inv(sid);
> > >           _log__trace_smmu_config_cache_inv(sid);
> > >       }
> > >       QEMU_SMMU_CONFIG_CACHE_INV(sid);
> > >       tracepoint(qemu, smmu_config_cache_inv(sid));
> > > }
> > > 
> > > and one function per backend seems the most readable way to format the
> > > code in the headers.  I understand that most of the time you'll have
> > > only one backend enabled, but still the above seems pretty good and
> > > clarifies the difference between efficient backends like dtrace and UST
> > > and the others.
> > > 
> > > This series doesn't go all the way to something like the above, but it
> > > does go in that direction.
> > 
> > It's nice to share a single trace_event_get_state() conditional
> > between all backends that use it. There is no need to move the
> > generated code from .h into a .c file to achieve this though.
> 
> Ok, I see what you mean.  Personally I like that the backend code is
> completely out of sight and you only have a single line of code per backend;
> but it's a matter of taste I guess.
> 
> > In the absence of performance data this patch series seems like
> > premature optimization and code churn to me.
> > 
> > > Now, in all honesty the main reason to do this was to allow reusing the
> > > C code generator when it's Rust code that is using tracepoints; but I do
> > > believe that these changes make sense on their own, and I didn't want to
> > > make these a blocker for Rust enablement as well (Tanish has already
> > > looked into generating Rust code for the simple backend, for example).
> > 
> > How is this patch series related to Rust tracing? If generated code
> > needs to be restructured so Rust can call it, then that's a strong
> > justification.
> Well, moving code to the .c file would make it possible to call it in Rust
> without duplicating code generation for the various backends (other than the
> "if" and function calls, of course, but those are easy). However, this is
> only handy and not absolutely necessary for the Rust tracing project.

This might work for some trace backends, but certainly for dtrace/systemtap
I'd expect us to use a native rust impl to get the optimal low overhead.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


