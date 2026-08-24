Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D70C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVWF-0007AF-Cp; Mon, 24 Aug 2026 10:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyVWD-00078k-9S
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyVWB-0007QR-Bt
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787581154;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QsEQfv332ke1jIs+3Bm4bxWSbAq3Zp0SlFu88GW3Ks=;
 b=a6qgvh390vhpblOk4x8duqS3g9gVa4Jg1ElKcRqH4/ocFUlKY1M/6RIYFcYPYBfvRo6Vlf
 zVApb7z/UoYqS5159wj4WjYZQQBhh3JqfWP04g5mq7sUU32txc4rct7NHNqfNl1ezHbOhW
 xgBRY9eawI+14TybyRZ51TFCxjk1ADE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-xXra7fr2OnuGm5pkpx0Htg-1; Mon,
 24 Aug 2026 10:19:11 -0400
X-MC-Unique: xXra7fr2OnuGm5pkpx0Htg-1
X-Mimecast-MFC-AGG-ID: xXra7fr2OnuGm5pkpx0Htg_1787581150
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80577195DE66; Mon, 24 Aug 2026 14:19:10 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 126D130002E9; Mon, 24 Aug 2026 14:19:08 +0000 (UTC)
Date: Mon, 24 Aug 2026 15:19:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 35/49] error-report: switch to use monitor_cur_hmp()
Message-ID: <aoxS2YzUWsEEtUi3@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-35-e53fc35bc550@redhat.com>
 <aoxSYsbavuGtwCUO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aoxSYsbavuGtwCUO@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Mon, Aug 24, 2026 at 03:17:06PM +0100, Daniel P. Berrangé wrote:
> On Sun, Aug 16, 2026 at 11:13:02PM +0400, Marc-André Lureau wrote:
> > Instead of passing a Monitor pointer through error_vprintf_mon() and
> > error_printf_mon(), call monitor_cur_hmp() directly. This removes the
> > monitor parameter from the internal helpers and the manual
> > object_dynamic_cast() in vreport().
> > 
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >  util/error-report.c | 72 +++++++++++++++++++++++++----------------------------
> >  1 file changed, 34 insertions(+), 38 deletions(-)
> > 
> > diff --git a/util/error-report.c b/util/error-report.c
> > index aaa15bc79827..70cbd174ffae 100644
> > --- a/util/error-report.c
> > +++ b/util/error-report.c
> > @@ -30,34 +30,31 @@ bool error_with_guestname;
> >  const char *error_guest_name;
> >  
> >  /*
> > - * Print to the current human monitor if we have one, else to stderr.
> > + * Print to the current HMP monitor if we have one, else to stderr.
> >   */
> > -static int G_GNUC_PRINTF(2, 0)
> > -error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
> > +static int G_GNUC_PRINTF(1, 0)
> > +error_vprintf_mon(const char *fmt, va_list ap)
> 
> Please don't remove this 'cur_mon' parameter.
> 
> >  {
> > -    /*
> > -     * This will return -1 if 'cur_mon' is NULL, or is QMP.
> > -     * IOW this will only print if in HMP, otherwise we
> > -     * fallback to stderr for QMP / no-monitor scenarios.
> > -     */
> > -    int ret = monitor_vprintf(cur_mon, fmt, ap);
> > -    if (ret == -1) {
> > -        ret = vfprintf(stderr, fmt, ap);
> > +    MonitorHMP *hmp = monitor_cur_hmp();
> 
> This calls qemu_mutex_lock/unlock, which have trace points.
> As a result if you have 'log' tracing enabled, error messages
> will get trace point output splattered on top.
> 
> We must fetch monitor_cur_hmp once only at the top of
> vreport() and never query it again.

See my previous fix for this problem in:

  commit 2eb00abcfebc3fa0a7c2915d1d29fa8fe0b88379
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Wed Sep 10 17:32:37 2025 +0100

    util: fix interleaving of error & trace output


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


