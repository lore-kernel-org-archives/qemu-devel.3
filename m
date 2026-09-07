Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2A4C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3W0W-0008Ne-5X; Mon, 07 Sep 2026 05:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3W0U-0008MV-PG
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3W0S-0005tk-LP
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 05:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788774676;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yP06WkixExfVKgOlDFVEvkXrO0xLPs9obVvyFK9bel4=;
 b=HKBpM+bP0ES1B3urdPkbmxt9FL7r74H9xapUbZGDc5plBbhnm+H7lZWIFjONFH0pvITujq
 jsU+fDR+kkkMz5fxV92dRl0orjiceMrcYvzQ+Cfgm5z7m6sfhTtRZgsB09MIfh5WY2Tbna
 1/wvhANreZfXgmzQRKmGnnKjCha+auw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-XSrQ0G3SMse9EZxpt1hvpw-1; Mon,
 07 Sep 2026 05:51:10 -0400
X-MC-Unique: XSrQ0G3SMse9EZxpt1hvpw-1
X-Mimecast-MFC-AGG-ID: XSrQ0G3SMse9EZxpt1hvpw_1788774668
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F26F195422C; Mon,  7 Sep 2026 09:51:08 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD9D930002F0; Mon,  7 Sep 2026 09:51:02 +0000 (UTC)
Date: Mon, 7 Sep 2026 10:50:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 4/9] tests/qtest: add qtest_qmp_job_wait()
Message-ID: <ap6JAy9jaHzDakvw@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
 <20260906-nohmp-v1-4-daee96491c43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260906-nohmp-v1-4-daee96491c43@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Sep 06, 2026 at 12:42:35PM +0400, Marc-André Lureau wrote:
> Add a helper to wait for job conclusion, used in next changes.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/libqtest.c | 37 +++++++++++++++++++++++++++++++++++++
>  tests/qtest/libqtest.h | 11 +++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 28bb72bfaecf..370f79a3b6fb 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -984,6 +984,43 @@ void qtest_qmp_eventwait(QTestState *s, const char *event)
>      qobject_unref(response);
>  }
>  
> +void qtest_qmp_job_wait(QTestState *s, const char *job_id)
> +{
> +    QDict *response, *data, *error;
> +    QList *jobs;
> +    const QListEntry *entry;
> +
> +    for (;;) {
> +        response = qtest_qmp_eventwait_ref(s, "JOB_STATUS_CHANGE");
> +        data = qdict_get_qdict(response, "data");
> +        if (!strcmp(qdict_get_str(data, "id"), job_id) &&
> +            !strcmp(qdict_get_str(data, "status"), "concluded")) {



> +            qobject_unref(response);
> +            break;
> +        }
> +        qobject_unref(response);
> +    }
> +
> +    response = qtest_qmp(s, "{ 'execute': 'query-jobs' }");
> +    g_assert(qdict_haskey(response, "return"));
> +    jobs = qobject_to(QList, qdict_get(response, "return"));
> +    g_assert(jobs);
> +    QLIST_FOREACH_ENTRY(jobs, entry) {
> +        QDict *job = qobject_to(QDict, qlist_entry_obj(entry));
> +        if (!strcmp(qdict_get_str(job, "id"), job_id)) {
> +            g_assert_null(qdict_get_try_str(job, "error"));

If "job" did contain "error", then wouldn't we have hit
a SEGV in the qdict_get_str() call due to missing 'id'
field.

IOW, we should likely validate this is NOT an error
response first.


> +            break;
> +        }
> +    }
> +    qobject_unref(response);
> +
> +    response = qtest_qmp(s,
> +        "{ 'execute': 'job-dismiss', 'arguments': { 'id': %s } }", job_id);
> +    error = qdict_get_qdict(response, "error");
> +    g_assert_null(error);
> +    qobject_unref(response);
> +}
> +

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


