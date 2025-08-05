Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD11C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 06:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujBZc-0004Wl-Ea; Tue, 05 Aug 2025 02:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujBZa-0004S3-Aw
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 02:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujBZX-0000Yk-Da
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 02:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754376892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrccdEJGg0dLg6ObfqNLYvSxLb9F1G0U3LrzvohsQJc=;
 b=PUFUX3fepj3mb46i1jdKQ+rZRIrHnI9LoENQ5JEH7F4dP1IBqu2UBh+HDhcW5nZZfegUIk
 9Mvo9JoOUHiVYUMi/JWQO7TRTx86EUT5nTKBzxxAYKFvKeAWKN6askbERMfvad/PZicFUT
 adaZeKseY4LA+94u6FVZyh4kOYj0CeE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-lgo40TnFPWCUfUZQUyT71A-1; Tue,
 05 Aug 2025 02:54:49 -0400
X-MC-Unique: lgo40TnFPWCUfUZQUyT71A-1
X-Mimecast-MFC-AGG-ID: lgo40TnFPWCUfUZQUyT71A_1754376888
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECD021936D80; Tue,  5 Aug 2025 06:54:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85FA71800B71; Tue,  5 Aug 2025 06:54:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC64C21E6A27; Tue, 05 Aug 2025 08:54:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net
Subject: Re: [PATCH 1/5] qtest/qom-test: Plug memory leak with -p
In-Reply-To: <a7a3ba56-680a-4256-b6e1-ff78f131fdf0@oracle.com> (Steven
 Sistare's message of "Mon, 4 Aug 2025 13:11:04 -0400")
References: <20250725135034.2280477-1-armbru@redhat.com>
 <20250725135034.2280477-2-armbru@redhat.com>
 <a7a3ba56-680a-4256-b6e1-ff78f131fdf0@oracle.com>
Date: Tue, 05 Aug 2025 08:54:44 +0200
Message-ID: <87h5ymdzrf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 7/25/2025 9:50 AM, Markus Armbruster wrote:
>> The machine name g_strdup()ed by add_machine_test_case() is freed by
>> test_machine().  Since the former runs for all machines, whereas the
>> latter runs only for the selected test case's machines, this leaks the
>> names of machines not selected, if any.  Harmless, but fix it anyway:
>> there is no need to dup in the first place, so don't.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/qtest/qom-test.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
>> index 4ade1c728c..cb5dbfe329 100644
>> --- a/tests/qtest/qom-test.c
>> +++ b/tests/qtest/qom-test.c
>> @@ -220,7 +220,6 @@ static void test_machine(gconstpointer data)
>>      qobject_unref(response);
>>      qtest_quit(qts);
>> -    g_free((void *)machine);
>>  }
>>  
>>  static void add_machine_test_case(const char *mname)
>> @@ -228,7 +227,7 @@ static void add_machine_test_case(const char *mname)
>>      char *path;
>>      path = g_strdup_printf("qom/%s", mname);
>> -    qtest_add_data_func(path, g_strdup(mname), test_machine);
>> +    qtest_add_data_func(path, mname, test_machine);
>>      g_free(path);
>>  }
>
> This will break if qtest_cb_for_every_machine ever composes a machine name on the
> stack and passes that to add_machine_test_case.  Unlikely, but the strdup makes it
> future proof.

Hmm.

qtest obtains machine names via QMP on demand.  This is
qtest_get_machines().  Once gotten, they live forever.

Used to live forever, actually: commit 41b2eba4e5c (tests/qtest: Allow
qtest_get_machines to use an alternate QEMU binary) throws them away
when qtest_get_machines() is asked for another QEMU's machine names.
migrate_start() does that.  It appears get each one's machine names
twice, because it switches back and forth.  Wasteful.

Anyway, you have a point: more stupid shit happens below the hood than I
expected, and even more may be added in the future.

Moreover, at least test-hmp has the same leak.  Plugging it here and not
there makes no sense.  I'm dropping this patch for now.

> Also, mname is not the only leak.  path is also leaked when only a subset of
> tests are run:
>
>   qtest_add_data_func(path, ...)
>     gchar *path = g_strdup_printf(...)
>     g_test_add_data_func(path, ...)
>
> Leaking seems to be par for this course.  Maybe not worth fixing.

valgrind shows the machine name leak my patch plugs.  It does not show
@path leaking.

Let's have a closer look:

    static void add_machine_test_case(const char *mname)
    {
        char *path;

        path = g_strdup_printf("qom/%s", mname);
        qtest_add_data_func(path, mname, test_machine);
        g_free(path);
    }

Always frees @path.

    void qtest_add_data_func(const char *str, const void *data,
                             void (*fn)(const void *))
    {
        gchar *path = g_strdup_printf("/%s/%s", qtest_get_arch(), str);
        g_test_add_data_func(path, data, fn);
        g_free(path);
    }

Always frees @path.

g_test_add_data_func()'s contract[*] on its first argument: "The data is
owned by the caller of the function."

I can't see a leak.


[*] https://docs.gtk.org/glib/func.test_add_data_func.html


