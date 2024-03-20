Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94309C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmx22-0006p9-Sa; Wed, 20 Mar 2024 10:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmx1y-0006go-MH
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmx1r-0001GK-Ux
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710945293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cN38NBjlMF0uWVQcOgyeHitgcC5dBjzc+vYk+jt6mE=;
 b=HanJaAdQXHTIoE/i9a6+MmQop2q1+85V5/s1A4SWT6rv7iEoFePM901iRRkyGedh1hbFLF
 74y+BPYixeFDuEY3k62B6xA+z6VHNFE3EbeLE/w+bTY/oCJfBKh5Gf4MM0egJ8oJkqiWoX
 j41iRei5WGl8O8Ub5jxveYOB0qpF8TU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-glULwTDbM026Ofcr-ajTlA-1; Wed, 20 Mar 2024 10:34:48 -0400
X-MC-Unique: glULwTDbM026Ofcr-ajTlA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A72C8007A4;
 Wed, 20 Mar 2024 14:34:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34054492BDA;
 Wed, 20 Mar 2024 14:34:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 30A9521E6A28; Wed, 20 Mar 2024 15:34:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Tao Su
 <tao1.su@linux.intel.com>,  qemu-devel@nongnu.org,  pbonzini@redhat.com,
 xiaoyao.li@intel.com,  alex.bennee@linaro.org,  armbru@redhat.com,
 philmd@linaro.org
Subject: Re: [PATCH v2] target/i386: Revert monitor_puts() in
 do_inject_x86_mce()
In-Reply-To: <CAFEAcA8t8C8QCeQS-fxvRKNST80g+84Ggh4B_cZAc6vzHL-wmA@mail.gmail.com>
 (Peter Maydell's message of "Wed, 20 Mar 2024 14:04:42 +0000")
References: <20240320083640.523287-1-tao1.su@linux.intel.com>
 <Zfreb8-swnvSOMhx@redhat.com>
 <CAFEAcA8t8C8QCeQS-fxvRKNST80g+84Ggh4B_cZAc6vzHL-wmA@mail.gmail.com>
Date: Wed, 20 Mar 2024 15:34:43 +0100
Message-ID: <87y1adm0os.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 20 Mar 2024 at 13:03, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>>
>> On Wed, Mar 20, 2024 at 04:36:40PM +0800, Tao Su wrote:
>> > monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mc=
e()
>> > may have a parameter with NULL monitor pointer. Revert monitor_puts() =
in
>> > do_inject_x86_mce() to fix, then the fact that we send the same messag=
e to
>> > monitor and log is again more obvious.
>>
>> Yikes, why do we have such a horrible trap-door in our
>> monitor output APIs.
>>
>> Isn't the right fix here to make 'monitor_puts' check for
>> NULL & be a no-op, in the same way 'monitor_printf' does,
>> so the APIs have consistent behaviour.
>
> The other difference between monitor_puts(mon, s) and
> monitor_printf(mon, "%s", s)
> is that the latter will return an error if the monitor is QMP, whereas
> the former will go ahead and print the message anyway. That one is
> awkward to resolve, because the mechanism the QMP monitor uses to
> print the JSON in qmp_send_response() is to call monitor_puts()...

We need a low-level function to send to a monitor, be it HMP or QMP:
monitor_puts().

We need a high-level function to format JSON and send it to QMP:
qmp_send_response().

We need a high-level functions to format text and send it to HMP:
monitor_printf(), ...

Trouble is the first and the last one are deceptively named.  The names
suggest monitor_printf() is to monitor_puts() what printf() is to
puts().  Not true.

Naming the functions that expect an HMP monitor hmp_FOO() would make
more sense.  Renaming them now would be quite some churn, though.


