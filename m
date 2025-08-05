Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F4C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 06:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujApJ-00084I-8K; Tue, 05 Aug 2025 02:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujApG-00081e-S9
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 02:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujApE-0001QC-Sk
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 02:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754374023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YQ/9Zv9mT+LMy0E/SqW+Ye4OAdoraXC3AI3O2YkKIbQ=;
 b=HR1ItqSg5ATez8XG2XPT+EcjsZfFlAS5I3mBm8cOoyAf6RFfZe7IXPUcO8EYuYnB+tCUcT
 FTxrkpCyRgiJL6yRXDXCnOVdyWHRfyfRiRqt7bNRLJ8Bx4VQ/5IeIyAbG7TngWZ6rGMr9Z
 8ctdbnZ5mDTiGq3QYZHRASl1xK7RNj0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-gRpCZ5q_Pr6-QWH5zNLvPw-1; Tue,
 05 Aug 2025 02:06:59 -0400
X-MC-Unique: gRpCZ5q_Pr6-QWH5zNLvPw-1
X-Mimecast-MFC-AGG-ID: gRpCZ5q_Pr6-QWH5zNLvPw_1754374018
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F03A9180044F; Tue,  5 Aug 2025 06:06:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BCFF1800B4F; Tue,  5 Aug 2025 06:06:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAB4F21E6A27; Tue, 05 Aug 2025 08:06:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net
Subject: Re: [PATCH 4/5] qtest/qom-test: Don't bother to execute QMP command
 quit
In-Reply-To: <6bb59bfa-8083-4823-9f15-92132e8d6783@oracle.com> (Steven
 Sistare's message of "Mon, 4 Aug 2025 13:10:53 -0400")
References: <20250725135034.2280477-1-armbru@redhat.com>
 <20250725135034.2280477-5-armbru@redhat.com>
 <6bb59bfa-8083-4823-9f15-92132e8d6783@oracle.com>
Date: Tue, 05 Aug 2025 08:06:54 +0200
Message-ID: <8734a6fgjl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Steven Sistare <steven.sistare@oracle.com> writes:

> On 7/25/2025 9:50 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/qtest/qom-test.c | 4 ----
>>   1 file changed, 4 deletions(-)
>> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
>> index d358b69c7e..6421f2d9d9 100644
>> --- a/tests/qtest/qom-test.c
>> +++ b/tests/qtest/qom-test.c
>> @@ -215,10 +215,6 @@ static void test_machine(gconstpointer data)
>>      test_list_get(qts, paths);
>>      test_list_get_value(qts);
>> -    response = qtest_qmp(qts, "{ 'execute': 'quit' }");
>> -    g_assert(qdict_haskey(response, "return"));
>> -    qobject_unref(response);
>> -
>>      qtest_quit(qts);
>>   }
>
> IMO the quit command improves test coverage, albeit by a small amount.
> It guarantees that qemu did not die after returning the qom result to
> the client.

What if it dies afte returning the quit response?

Detecting QEMU dying on us is the test harness's job.  Check out
qtest_check_status() called by qtest_wait_qemu() called by
qtest_kill_qemu() called by qtest_quit() called by the test.

For what it's worth, the only other qtest using the quit command is
machine-none-test.c.

In qtests, quit races with the test harness's termination of QEMU.  The
quit command requests immediate shutdown.  By the time the test receives
the response, the QEMU process may be alive (still shutting down) or
dead.  If dead, it's in zombie state.  qtest_quit() then kill()s it some
more (does nothing for zombies), and finally reaps it with waitpid().
Works, but the race between quit and kill give me a queasy feeling.

Can't say whether the Windows code handles this robustly.


