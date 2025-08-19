Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D402CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 10:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoJyF-0001eZ-UL; Tue, 19 Aug 2025 06:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoJyE-0001e7-3r
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoJyA-0002IH-SX
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755600812;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=adCmW8vltBkQ681fOx6hqTbJ866dBkyFouXLp0PDGS8=;
 b=Yg9Hi5T+7Yq7j2uKXVhraiG0DaWXbTSHgwA9o6PC36f6FgrEB+hmAnhdleN1i6LMxon57+
 RQMG6dd0U/xMIhFR0X6hdraBb00+/8GErpG5jhfnL5l4WZgJB1GpWezE0iqLW3bizWXth+
 dXLRTaEsWyCE0d4CMKUPTxxSP+oy5Ws=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-QgcPDsqNMXixVMyv3mnUUA-1; Tue,
 19 Aug 2025 06:53:29 -0400
X-MC-Unique: QgcPDsqNMXixVMyv3mnUUA-1
X-Mimecast-MFC-AGG-ID: QgcPDsqNMXixVMyv3mnUUA_1755600808
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4C4A1956086; Tue, 19 Aug 2025 10:53:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EBDE1800447; Tue, 19 Aug 2025 10:53:25 +0000 (UTC)
Date: Tue, 19 Aug 2025 11:53:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 01/12] monitor: Clean up HMP gdbserver error reporting
Message-ID: <aKRXoaeXjwXzWdoe@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808080823.2638861-2-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Fri, Aug 08, 2025 at 10:08:12AM +0200, Markus Armbruster wrote:
> HMP command gdbserver used to emit two error messages for certain
> errors.  For instance, with -M none:
> 
>     (qemu) gdbserver
>     gdbstub: meaningless to attach gdb to a machine without any CPU.
>     Could not open gdbserver on device 'tcp::1234'
> 
> The first message is the specific error, and the second one a generic
> additional message that feels superfluous to me.
> 
> Commit c0e6b8b798b (system: propagate Error to gdbserver_start (and
> other device setups)) turned the first message into a warning:
> 
>     warning: gdbstub: meaningless to attach gdb to a machine without any CPU.
>     Could not open gdbserver on device 'tcp::1234'
> 
> This is arguably worse.
> 
> hmp_gdbserver() passes &error_warn to gdbserver_start(), so that
> failure gets reported as warning, and then additionally emits the
> generic error on failure.  This is a misuse of &error_warn.
> 
> Instead, receive the error in &err and report it, as usual.  With
> this, gdbserver reports just the error:
> 
>     gdbstub: meaningless to attach gdb to a machine without any CPU.

What do you think about an alternative of removing "gdbstub: "
from all the errors raised in  'gdbserver_start' & similar, and
then using

  error_prepend(err, "Could not open gdbserver on device '%s'", device);

in hmp_gdbserver ?

I don't feel too strongly, so in any case for the patch as is,

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/exec/gdbstub.h | 3 ---
>  monitor/hmp-cmds.c     | 7 ++++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index a16c0051ce..bd7182c4d3 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -55,9 +55,6 @@ void gdb_unregister_coprocessor_all(CPUState *cpu);
>   * system emulation you can use a full chardev spec for your gdbserver
>   * port.
>   *
> - * The error handle should be either &error_fatal (for start-up) or
> - * &error_warn (for QMP/HMP initiated sessions).
> - *
>   * Returns true when server successfully started.
>   */
>  bool gdbserver_start(const char *port_or_device, Error **errp);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 74a0f56566..33a88ce205 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -280,14 +280,15 @@ void hmp_log(Monitor *mon, const QDict *qdict)
>  
>  void hmp_gdbserver(Monitor *mon, const QDict *qdict)
>  {
> +    Error *err = NULL;
>      const char *device = qdict_get_try_str(qdict, "device");
> +
>      if (!device) {
>          device = "tcp::" DEFAULT_GDBSTUB_PORT;
>      }
>  
> -    if (!gdbserver_start(device, &error_warn)) {
> -        monitor_printf(mon, "Could not open gdbserver on device '%s'\n",
> -                       device);
> +    if (!gdbserver_start(device, &err)) {
> +        error_report_err(err);
>      } else if (strcmp(device, "none") == 0) {
>          monitor_printf(mon, "Disabled gdbserver\n");
>      } else {
> -- 
> 2.49.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


