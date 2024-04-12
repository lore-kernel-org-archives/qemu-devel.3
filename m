Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F749C04FF8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKKF-0000UC-P1; Fri, 12 Apr 2024 13:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rvKKE-0000TZ-9N
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rvKKC-0006mO-Jt
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712941466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7iayZMH+i0HEjbIbzcAtJYCtz2S9Jbu7EYLsvSXoZrg=;
 b=Fit4u9pcenjQecza75PUDXOqbdnbkjhaMM2UyIxm+uospezr9gdjJRhWTUcR6ImLKPjj1a
 nVeW+mkq+Aitc73XJOApIVDjbmW03QMs7RbwQvIdJ5I+24JBIPzSp/vuWkU8OjTRYF5qxF
 FDG4lB4wGw05BQ1kft3PcI5CZnqRk3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-fJDkFOF5OcKX-7hBv98wjA-1; Fri, 12 Apr 2024 13:04:20 -0400
X-MC-Unique: fJDkFOF5OcKX-7hBv98wjA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5C41802E4D;
 Fri, 12 Apr 2024 17:04:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B8E62166B31;
 Fri, 12 Apr 2024 17:04:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7FBB021E6811; Fri, 12 Apr 2024 19:04:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Vladimir
 Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Peter Lieven <pl@kamp.de>,  "Richard W.M.
 Jones" <rjones@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH v2 12/13] block/ssh: Use URI parsing code from glib
In-Reply-To: <fxncshsyb5bnknswy2wkpr6l32adiy5hz6smd42o5eyomezz2k@twgbjztfubps>
 (Eric Blake's message of "Fri, 12 Apr 2024 09:56:40 -0500")
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-13-thuth@redhat.com>
 <fxncshsyb5bnknswy2wkpr6l32adiy5hz6smd42o5eyomezz2k@twgbjztfubps>
Date: Fri, 12 Apr 2024 19:04:14 +0200
Message-ID: <878r1i8qcx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> On Fri, Apr 12, 2024 at 03:24:14PM +0200, Thomas Huth wrote:
>> Since version 2.66, glib has useful URI parsing functions, too.
>> Use those instead of the QEMU-internal ones to be finally able
>> to get rid of the latter.
>> 
>> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  block/ssh.c | 75 ++++++++++++++++++++++++++++-------------------------
>>  1 file changed, 40 insertions(+), 35 deletions(-)
>> 
>
>>  
>> -    if (g_strcmp0(uri->scheme, "ssh") != 0) {
>> +    if (g_strcmp0(g_uri_get_scheme(uri), "ssh") != 0) {
>
> Yet another case-sensitive spot to consider.
>
>>  
>> -    qdict_put_str(options, "path", uri->path);
>> -
>> -    /* Pick out any query parameters that we understand, and ignore
>> -     * the rest.
>> -     */
>> -    for (i = 0; i < qp->n; ++i) {
>> -        if (strcmp(qp->p[i].name, "host_key_check") == 0) {
>> -            qdict_put_str(options, "host_key_check", qp->p[i].value);
>> +    qdict_put_str(options, "path", uri_path);
>> +
>> +    uri_query = g_uri_get_query(uri);
>> +    if (uri_query) {
>> +        g_uri_params_iter_init(&qp, uri_query, -1, "&", G_URI_PARAMS_NONE);
>> +        while (g_uri_params_iter_next(&qp, &qp_name, &qp_value, &gerror)) {
>> +            if (!qp_name || !qp_value || gerror) {
>> +                warn_report("Failed to parse SSH URI parameters '%s'.",
>> +                            uri_query);
>> +                break;
>> +            }
>> +            /*
>> +             * Pick out the query parameters that we understand, and ignore
>> +             * (or rather warn about) the rest.
>> +             */
>> +            if (g_str_equal(qp_name, "host_key_check")) {
>> +                qdict_put_str(options, "host_key_check", qp_value);
>> +            } else {
>> +                warn_report("Unsupported parameter '%s' in URI.", qp_name);
>
> Do we want the trailing '.' in warn_report?

We do not.

> The warning is new; it was not in the old code, nor mentioned in the
> commit message.  It seems like a good idea, but we should be more
> intentional if we intend to make that change.


