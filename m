Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531B3C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 09:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbckN-0006iT-4k; Wed, 07 Aug 2024 05:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbckK-0006hr-FO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbckF-0006B5-Om
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723022043;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpPs+Qraro6qJyFlSrAezDqzsv4t4lyIAex+TwE4sjs=;
 b=LbKR8tHooAfHAyfhVvxxrOh1lXBPDnn4lsWKE5Zd2M47TWFRsTfQf0EDzErLVzEf/h/ciE
 xDRlo/FjYjqjvkyGTdbWwIDWBtz7z8QZ7yFKzdYmKNH7dRrEyIfk1gLiXjr/y/7Dv1fA2v
 Fm5kPYduh8Ic5WBbnEakqXRHIveAqhg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-SzWL4GfhMry2eNOBJKT8jA-1; Wed,
 07 Aug 2024 05:13:59 -0400
X-MC-Unique: SzWL4GfhMry2eNOBJKT8jA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88C441944B2B; Wed,  7 Aug 2024 09:13:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9DBA1953BB7; Wed,  7 Aug 2024 09:13:54 +0000 (UTC)
Date: Wed, 7 Aug 2024 10:13:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 3/5] ebpf: add formal error reporting to all APIs
Message-ID: <ZrM6z0sO-ZNLf3Fw@redhat.com>
References: <20240806145653.1632478-1-berrange@redhat.com>
 <20240806145653.1632478-4-berrange@redhat.com>
 <208ede45-0866-4dce-b6ef-e8390c1c56c1@linaro.org>
 <ZrI_IsxXceEJewFO@redhat.com>
 <5403fa28-bc81-4208-9b16-7912a3b190c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5403fa28-bc81-4208-9b16-7912a3b190c5@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 07, 2024 at 09:37:00AM +0200, Philippe Mathieu-Daudé wrote:
> On 6/8/24 17:20, Daniel P. Berrangé wrote:
> > On Tue, Aug 06, 2024 at 05:11:55PM +0200, Philippe Mathieu-Daudé wrote:
> > > On 6/8/24 16:56, Daniel P. Berrangé wrote:
> > > > The eBPF code is currently reporting error messages through trace
> > > > events. Trace events are fine for debugging, but they are not to be
> > > > considered the primary error reporting mechanism, as their output
> > > > is inaccessible to callers.
> > > > 
> > > > This adds an "Error **errp" parameter to all methods which have
> > > > important error scenarios to report to the caller.
> > > > 
> > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > ---
> > > >    ebpf/ebpf_rss.c     | 59 ++++++++++++++++++++++++++++++++++++---------
> > > >    ebpf/ebpf_rss.h     | 10 +++++---
> > > >    hw/net/virtio-net.c |  7 +++---
> > > >    3 files changed, 59 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> > > > index aa7170d997..59854c8b51 100644
> > > > --- a/ebpf/ebpf_rss.c
> > > > +++ b/ebpf/ebpf_rss.c
> > > > @@ -47,13 +47,14 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
> > > >        return ctx != NULL && (ctx->obj != NULL || ctx->program_fd != -1);
> > > >    }
> > > > -static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> > > > +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx, Error **errp)
> > > >    {
> > > >        ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
> > > >                                       PROT_READ | PROT_WRITE, MAP_SHARED,
> > > >                                       ctx->map_configuration, 0);
> > > >        if (ctx->mmap_configuration == MAP_FAILED) {
> > > >            trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
> > > > +        error_setg(errp, "Unable to map eBPF configuration array");
> > > >            return false;
> > > >        }
> > > >        ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
> > > > @@ -61,6 +62,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> > > >                                       ctx->map_toeplitz_key, 0);
> > > >        if (ctx->mmap_toeplitz_key == MAP_FAILED) {
> > > >            trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
> > > > +        error_setg(errp, "Unable to map eBPF toeplitz array");
> > > >            goto toeplitz_fail;
> > > >        }
> > > >        ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
> > > > @@ -68,6 +70,7 @@ static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> > > >                                       ctx->map_indirections_table, 0);
> > > >        if (ctx->mmap_indirections_table == MAP_FAILED) {
> > > >            trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
> > > > +        error_setg(errp, "Unable to map eBPF indirection array");
> > > 
> > > Aren't these trace_ebpf_error() calls redundant now?
> > 
> > Yes & no. Errors propagated up the call stack don't get included in
> > any trace output, and so if a caller doesn't log them anywhere they
> > can thus be invisible to someone just looking at trace output.
> > 
> > I could remove them all from the eBPF code though, and put a single
> > trace event in the hw/net/virtio-net.c file instead ? Bit of a bike
> > shed colouring exercise to decide which is best though.
> 
> No problem, I'm fine with this patch.
> 
> Note from experience (although pre-existing in this patch), trace
> events can be very verbose, and a what makes them powerful is we
> can filter particular ones. The following pattern isn't practical
> to filter:
> 
>   trace_foo_error(const char *error_msg);
> 
> While a bit tedious to add, having a single trace event per error
> is way more useful.

Yeah, I agree with you on that. I should look at changing it to add
distinct error probes.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


