Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0B4CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNaZ-0002pj-MC; Sat, 30 Aug 2025 11:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3VR-0005pg-L4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3VO-0006Yu-Oo
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756490837;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVYEfV3M2Ca9/tWwfDex5h4JxVijyGZSd4PlQCvlmxo=;
 b=TwoGZ6K4bdX0DzdpxviMmdlAjhNOxGT4RhOnpJBCPEUIpL+CUt5DvgfuXLU+KeDNesLhLx
 sGAGcSYRR19lqEjlhiGsqxhaYr6cfYpjKFhaotumQ6NLj1HkyDNxxNKWfYJGeny8JCvFrr
 I0Kk5n8Ey2WjRXvLgxEa5D2F98jCRes=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-7SWCtFQXNrS_4y0zJlYoeA-1; Fri,
 29 Aug 2025 14:07:15 -0400
X-MC-Unique: 7SWCtFQXNrS_4y0zJlYoeA-1
X-Mimecast-MFC-AGG-ID: 7SWCtFQXNrS_4y0zJlYoeA_1756490834
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 513FD1956089; Fri, 29 Aug 2025 18:07:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EB5E1800446; Fri, 29 Aug 2025 18:07:12 +0000 (UTC)
Date: Fri, 29 Aug 2025 19:07:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/12] util: convert error-report & log to message API
 for timestamp
Message-ID: <aLHsTToeZWkHIsSN@redhat.com>
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-9-berrange@redhat.com>
 <ac90c3c6-64ae-4abf-a850-59c862400b89@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac90c3c6-64ae-4abf-a850-59c862400b89@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Aug 20, 2025 at 08:02:14AM +1000, Richard Henderson wrote:
> On 8/20/25 06:27, Daniel P. Berrangé wrote:
> >   void qemu_log(const char *fmt, ...)
> >   {
> >       FILE *f;
> > -    g_autofree const char *timestr = NULL;
> > -
> >       /*
> > -     * Prepare the timestamp*outside* the logging
> > -     * lock so it better reflects when the message
> > -     * was emitted if we are delayed acquiring the
> > -     * mutex
> > +     * Prepare the context*outside* the logging
> > +     * lock so any timestamp better reflects when
> > +     * the message was emitted if we are delayed
> > +     * acquiring the mutex
> >        */
> > -    if (message_with_timestamp) {
> > -        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> > -        timestr = g_date_time_format_iso8601(dt);
> > -    }
> 
> Something that really ought to be handled better is that we currently use
> qemu_log to print pieces of a larger message.  E.g. looping over the general
> registers to print the whole cpu state.
> 
> (1) We don't want timestamps in the middle, and
> (2) we don't want unnecessary memory allocation in the middle.

This turned out to be surprisingly simple to fix - don't emit the
prefix if the previous qemu_log() call lacked a terminating newline
character.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


