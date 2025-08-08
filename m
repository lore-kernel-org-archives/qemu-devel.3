Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A204C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 06:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukGaS-0004Oj-LI; Fri, 08 Aug 2025 02:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukGaR-0004O2-PA
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukGaP-0008Ve-7X
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754634494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvO5V+sDEbFSlwDDPt0J8/g4+21TywkJvCe+D9VV4tk=;
 b=KTY8PBqy3b7CfNtiq+5sd3oed/gWSBohRVhL4knEEDnsE6cWiOu5Qm0aUxiRgalwQLdQsl
 aseR1fBO7Aq4mCppHKo7w78JqRy8aZv/byp7tD7jt1+ZZWvAOVvzFiqjzPGi/aXMfJDUai
 bl+UfDnyoKx0ELIZNvmoZFTlf/npbrI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-lans37pNNBmlju48AUqM2A-1; Fri,
 08 Aug 2025 02:28:13 -0400
X-MC-Unique: lans37pNNBmlju48AUqM2A-1
X-Mimecast-MFC-AGG-ID: lans37pNNBmlju48AUqM2A_1754634492
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 975DA195608E; Fri,  8 Aug 2025 06:28:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA7D619560AD; Fri,  8 Aug 2025 06:28:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F157621E6A27; Fri, 08 Aug 2025 08:28:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Cleber Rosa <crosa@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
Subject: Re: [PATCH V4 2/3] python: use qom-list-get
In-Reply-To: <CAFn=p-biuic_12kWEj==NmNp54MW6X4wf=2hu0edvqJF+deyaw@mail.gmail.com>
 (John Snow's message of "Thu, 7 Aug 2025 18:04:14 -0400")
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-3-git-send-email-steven.sistare@oracle.com>
 <871pqmwzqr.fsf@pond.sub.org>
 <CAFn=p-YhYqG5oyWt=zpPCic=2npUkxNJuvuGBuxwthqfMAxL1g@mail.gmail.com>
 <87zfd4v8m5.fsf@pond.sub.org>
 <CAFn=p-biuic_12kWEj==NmNp54MW6X4wf=2hu0edvqJF+deyaw@mail.gmail.com>
Date: Fri, 08 Aug 2025 08:28:07 +0200
Message-ID: <87o6sqmio8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> On Wed, Jul 16, 2025 at 4:32=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Fri, Jul 11, 2025, 10:47=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
>>
>> [...]
>>
>> >> Exception ignored in: <function QEMUMonitorProtocol.__del__ at 0x7fcf=
cd080d60>
>> >> Traceback (most recent call last):
>> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py=
", line 310, in __del__
>> >>     self.close()
>> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py=
", line 281, in close
>> >>     self._sync(
>> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py=
", line 102, in _sync
>> >>     return self._aloop.run_until_complete(
>> >>   File "/usr/lib64/python3.13/asyncio/base_events.py", line 719, in r=
un_until_complete
>> >>     return future.result()
>> >>   File "/usr/lib64/python3.13/asyncio/tasks.py", line 507, in wait_for
>> >>     return await fut
>> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.=
py", line 399, in disconnect
>> >>     await self._wait_disconnect()
>> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.=
py", line 719, in _wait_disconnect
>> >>     await all_defined_tasks  # Raise Exceptions from the bottom half.
>> >>   File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.=
py", line 870, in _bh_loop_forever
>> >>     await async_fn()
>> >> RuntimeError: cannot reuse already awaited coroutine
>> >
>> > Curious about this backtrace. It looks like something has gone
>> > fundamentally wrong in the internals and the error is being raised by =
the
>> > garbage collector which is not ideal.
>> >
>> > Can you help me reproduce this? Even if it's old/bad code, I don't want
>> > python-qemu-qmp faulting like this.
>>
>> Reproducer for Fedora 41, current master c079d3a31e4:
>>
>> Run
>>
>>     $ qemu-system-x86_64 -S -display none -chardev socket,id=3Dmon1,path=
=3Dtest-qmp,server=3Don,wait=3Doff -mon mode=3Dcontrol,id=3Dqmp,chardev=3Dm=
on1
>>
>> and
>>
>>     $ scripts/qmp/qom-tree -s test-qmp >/dev/null
>>
>> Questions?
>>
>
> Doesn't seem to trigger for me on Fedora 42 from the c079d3a31e4
> build. Is this a Python version difference thing rearing its head?

I have no idea.

Is there anything else I can do to help you?


