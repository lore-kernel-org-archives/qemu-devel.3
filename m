Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9993FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 21:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1tPE-0005Fc-Pk; Thu, 25 Sep 2025 17:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v1tP6-0005Ez-In
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 17:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v1tOw-0006cs-7F
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 17:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758835272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36PrxwJPUHqeHMPULMMX/KKN0+r7rH+NalNJdAqYenI=;
 b=UofpLYLm9TA2wUNOVfcC4wIGtgtuyeKsrnkPRs00aV7EyDPOZECQAfO+7us05iIMeztAFb
 8qYn7ZKusShB37twKykgPL+pdsG0KXYZ9fq1QHalkzXrg4a7PjfcFYbxTYQ5QZu/4XoMFJ
 jw3/0UFDYVfxPMaPkYg8exBtLEdmtY0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-1bqEZgw1MoCRe5eNHQnVbQ-1; Thu,
 25 Sep 2025 17:21:03 -0400
X-MC-Unique: 1bqEZgw1MoCRe5eNHQnVbQ-1
X-Mimecast-MFC-AGG-ID: 1bqEZgw1MoCRe5eNHQnVbQ_1758835261
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7843C18002D7; Thu, 25 Sep 2025 21:21:01 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.89])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61459180044F; Thu, 25 Sep 2025 21:20:56 +0000 (UTC)
Date: Thu, 25 Sep 2025 16:20:53 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 13/23] monitor: move error_vprintf back to
 error-report.c
Message-ID: <rk3vugjp4um6esd3q57wbybmiefb3jvi2ievnxawo4nuxw7ywd@7g7hc4o5fmmu>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-14-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925094441.1651372-14-berrange@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 25, 2025 at 10:44:31AM +0100, Daniel P. Berrangé wrote:
> The current unit tests rely on monitor.o not being linked, such
> that the monitor stubs get linked instead. Since error_vprintf
> is in monitor.o this allows a stub error_vprintf impl to be used
> that calls g_test_message.
> 
> This takes a different approach, with error_vprintf moving
> back to error-report.c such that it is always linked into the
> tests. The monitor_vprintf() stub is then changed to use
> g_test_message if QTEST_SLENT_ERROS is set, otherwise it will

Double typo; should be QTEST_SILENT_ERRORS...

> return -1 and trigger error_vprintf to call vfprintf.
> 
> The end result is functionally equivalent for the purposes of
> the unit tests.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

> +++ b/stubs/monitor-core.c
> @@ -18,5 +18,17 @@ void qapi_event_emit(QAPIEvent event, QDict *qdict)
>  
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
>  {
> -    abort();
> +    /*
> +     * Pretend 'g_test_message' is our monitor console to
> +     * stop the caller sending messages to stderr
> +     */
> +    if (g_test_initialized() && !g_test_subprocess() &&
> +        getenv("QTEST_SILENT_ERRORS")) {

...to match the code.

With that fixed,

Reviewed-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


