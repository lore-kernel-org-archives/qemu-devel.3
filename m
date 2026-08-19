Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6ECC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfwc-0001P6-Ga; Wed, 19 Aug 2026 09:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwfwa-0001Oo-Pe
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwfwV-0001fr-Ld
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787144574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9+0IFLBWxGj9Sd5nF/8JOZKM8gUz/+gGD0zkzKterY=;
 b=F67AGJL7B2m6yfrdusUhzNc10nMVrewfu7Gk1GJPjqD8Rsrv4tMESQw5VQSXbqsjtgjJva
 LDcny94PKdvj2rKW8dVNkg8vehIB9UwlxLTER2fLYwj7O8/vU0vr1v9a1LfjkVVBN2Nkz9
 8rxTpNDJ1YPl/ldw9xHfI3zDQrQALHk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-ubxxC0rROFu_3f4PeyVAPw-1; Wed,
 19 Aug 2026 09:02:50 -0400
X-MC-Unique: ubxxC0rROFu_3f4PeyVAPw-1
X-Mimecast-MFC-AGG-ID: ubxxC0rROFu_3f4PeyVAPw_1787144569
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F0F31800643; Wed, 19 Aug 2026 13:02:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 155451800346; Wed, 19 Aug 2026 13:02:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A21F21E6920; Wed, 19 Aug 2026 15:02:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  qemu-devel@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Corey Minyard
 <minyard@acm.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 4/4] hw/nmi: Remove @cpu_index argument from nmi_trigger()
In-Reply-To: <d0ad382b-9fe1-4ba2-a7f5-0bbb05daabe5@oss.qualcomm.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 11 Aug 2026
 12:17:19 +0200")
References: <20240220150833.13674-1-philmd@linaro.org>
 <20240220150833.13674-5-philmd@linaro.org>
 <CAFEAcA-yALySmCJLbitCmYpiZKUXJNOavGJG9RYeo8fKqz7gcw@mail.gmail.com>
 <d0ad382b-9fe1-4ba2-a7f5-0bbb05daabe5@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 15:02:45 +0200
Message-ID: <87tsoq5klm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 20/3/24 14:34, Peter Maydell wrote:
>> On Tue, 20 Feb 2024 at 15:09, Philippe Mathieu-Daud=3DC3=3DA9 <philmd@li=
naro.=3D
> org> wrote:
>>>
>>> nmi_monitor_handle() is not related to the monitor,
>>> rename it as nmi_trigger(). Return boolean value
>>> indicating success / failure. The 'cpu_index' argument
>>> is not used, remove it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=3DC3=3DA9 <philmd@linaro.org>

[...]

>>> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
>>> index c70db941c9..32b27067f2 100644
>>> --- a/include/hw/nmi.h
>>> +++ b/include/hw/nmi.h
>>> @@ -49,6 +49,17 @@ struct NMIClass {
>>>       bool (*nmi_handler)(NMIState *n, Error **errp);
>>>   };
>>>
>>> -void nmi_monitor_handle(int cpu_index, Error **errp);
>>> +/**
>>> + * nmi_trigger: Trigger a NMI.
>>> + *
>>> + * @errp: pointer to error object
>>> + *
>>> + * Iterate over all objects implementing the TYPE_NMI interface
>>> + * and deliver NMI to them.

[...]

>>> + *
>>> + * On success, return %true.
>>> + * On failure, store an error through @errp and return %false.
>>> + */
>>> +bool nmi_trigger(Error **errp);
>>
>> Why return a bool here? None of the callsites looks at the
>> return value.
>
> Indeed, but again this is the style *recommended* by the Error API
> since commit e3fe3988d7 ("error: Document Error API usage rules").

Correct:

 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.  Note that
 *   we still have many functions returning void.  We recommend
 *   =E2=80=A2 bool-valued functions return true on success / false on fail=
ure,
 *   =E2=80=A2 pointer-valued functions return non-null / null pointer, and
 *   =E2=80=A2 integer-valued functions return non-negative / negative.
>
> Callers providing a non-NULL errp should check the return value,
> but the QMP handlers generated by gen_command_decl() like
> qmp_inject_nmi() here don't return anything.

qmp_inject_nmi() passes the error to its caller.  That's fine.

ipmi_do_hw_op() and watchdog_perform_action() ignore the error.  Also
fine.

> Markus, what would be your preference?

I prefer sticking to the rule whenever practical.

Example for a defensible exception: a callback that's implemented many
more times than it's called.  There the effort of returning something
can exceed the benefit of making the calls more concise.

In a case like nmi_trigger(), what could possibly be gained by deviating
from the rule is dwarved many times over by having to consider the
tradeoffs and justifying them in review.  And if a caller shows up that
could use a return value, we'll waste some more time.  Not worth it.


