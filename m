Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236C3CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCb3i-0001Yn-P8; Fri, 02 Oct 2026 07:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCb3f-0001YY-4b
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCb3c-00006R-Qt
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790939042;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yylDG5z4QfOedNZ/eaacpvMaBpTJF1ags0fXIpK314U=;
 b=ArviI1mAZOtYKlsGJButslCUXA91q9HCI2GX7P/C07PtD+EGv8Ctnnntit6OOLRx0cAbDu
 5MyU793X0NRWlXaSNMpqielUgJrtKLW514232dvyOO1/9/FaLqOTYQ+0hXhQHQ0lipaN7V
 sMTpeoJOXdEzciDjGaa8Ko/ouB7YnYc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-yZhkmdoAOOWli0nH47xukQ-1; Fri,
 02 Oct 2026 07:04:00 -0400
X-MC-Unique: yZhkmdoAOOWli0nH47xukQ-1
X-Mimecast-MFC-AGG-ID: yZhkmdoAOOWli0nH47xukQ_1790939039
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 496A51800BD0
 for <qemu-devel@nongnu.org>; Fri,  2 Oct 2026 11:03:59 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06D861800348; Fri,  2 Oct 2026 11:03:57 +0000 (UTC)
Date: Fri, 2 Oct 2026 12:03:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 16/20] trace: include qemu_loglevel_mask(LOG_TRACE) in
 guard
Message-ID: <ar-Pm3jf4q4gyj0W@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
 <20261001151228.3373747-17-berrange@redhat.com>
 <75ae2444-0ac9-4aee-8881-fb3431c639e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75ae2444-0ac9-4aee-8881-fb3431c639e8@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 02, 2026 at 12:45:49PM +0200, Paolo Bonzini wrote:
> On 10/1/26 17:12, Daniel P. Berrangé wrote:
> > If emitting a trace event requires computation for the parameters
> > passed to the probe, the callers should guard that computation
> > with trace_event_by_state_backends(), which is a macro expanding
> > to the a check of the "TRACE_...._DSTATE()" expression. For the
> > log backend this should include a check for LOG_TRACE being
> > present in the configured log level.
> This also needs something for Rust (apologies for the mailer damage):

Ok, I'll test that and include it in a future v3, since I already
sent out v2 before seeing this.

> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -16,7 +16,6 @@
> 
> 
>  PUBLIC = True
> -CHECK_TRACE_EVENT_GET_STATE = True
> 
> 
>  def generate_h_begin(events, group):
> @@ -52,3 +51,9 @@ def generate_rs(event, group):
>          '        }',
>          fmt=expand_format_string(event.fmt, event.name + " "),
>          args=event.args.rust_call_varargs())
> +
> +def generate_rs_backend_dstate(event, group):
> +    out('    unsafe { (bindings::qemu_loglevel & bindings::LOG_TRACE) != 0
> && '
> +        + 'trace_event_state_is_enabled(_%(event_id)s_DSTATE) } ||',
> +        event_id = 'TRACE_' + e.name.upper())
> +
> 
> Paolo
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


