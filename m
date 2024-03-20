Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEC3C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 19:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn1Fb-0000Ps-V1; Wed, 20 Mar 2024 15:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rn1Fa-0000PV-4D
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 15:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rn1FX-0002EJ-Uf
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 15:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710961517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJQkGCtHGAB6D52gKNJuTOLamnCmeWvUXoOBkBGcsOM=;
 b=B6gIv5cJUqoSruOKlHkQFPrJVlaehkikHznMbpgtT8bJC7lG3CI893PGmgdl5sGEQcGH+u
 Q1fNBFWupEVF7oepcEX9n/Wl1Fy7FnvmUWEW0GghHNU79RFUtKt6Wq9NISmofG0+SU12E2
 CIGnqCZVpQWTVo07dW1dGYEXjR0seQ0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-FhPeRLDSOH2KxVsWXZ0VPw-1; Wed,
 20 Mar 2024 15:05:13 -0400
X-MC-Unique: FhPeRLDSOH2KxVsWXZ0VPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DD5F3815EE7;
 Wed, 20 Mar 2024 19:05:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A96CA2166B34;
 Wed, 20 Mar 2024 19:05:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D44321E6A28; Wed, 20 Mar 2024 20:05:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,  qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,  Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Helge Deller
 <deller@gmx.de>,  "Michael S. Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Laurent Vivier
 <laurent@vivier.eu>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Nicholas Piggin
 <npiggin@gmail.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,  Daniel
 Henrique Barboza
 <danielhb413@gmail.com>,  David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,  Halil Pasic
 <pasic@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  David
 Hildenbrand <david@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 3/4] hw/nmi: Remove @cpu_index argument from
 NMIClass::nmi_handler()
In-Reply-To: <52f35af0-4b18-48c8-8e18-aa7b01f53848@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 20 Mar 2024 17:47:14
 +0100")
References: <20240220150833.13674-1-philmd@linaro.org>
 <20240220150833.13674-4-philmd@linaro.org>
 <CAFEAcA9kVkM16paZQfH1voNNjWRT3DmchepiMs045w+YA61Fzw@mail.gmail.com>
 <52f35af0-4b18-48c8-8e18-aa7b01f53848@linaro.org>
Date: Wed, 20 Mar 2024 20:05:06 +0100
Message-ID: <87y1aclo65.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 20/3/24 14:23, Peter Maydell wrote:
>> On Tue, 20 Feb 2024 at 15:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
.org> wrote:
>>>
>>> Only s390x was using the 'cpu_index' argument, but since the
>>> previous commit it isn't anymore (it use the first cpu).
>>> Since this argument is now completely unused, remove it. Have
>>> the callback return a boolean indicating failure.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>>   include/hw/nmi.h           | 11 ++++++++++-
>>>   hw/core/nmi.c              |  3 +--
>>>   hw/hppa/machine.c          |  8 +++++---
>>>   hw/i386/x86.c              |  7 ++++---
>>>   hw/intc/m68k_irqc.c        |  6 ++++--
>>>   hw/m68k/q800-glue.c        |  6 ++++--
>>>   hw/misc/macio/gpio.c       |  6 ++++--
>>>   hw/ppc/pnv.c               |  6 ++++--
>>>   hw/ppc/spapr.c             |  6 ++++--
>>>   hw/s390x/s390-virtio-ccw.c |  6 ++++--
>>>   10 files changed, 44 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/include/hw/nmi.h b/include/hw/nmi.h
>>> index fff41bebc6..c70db941c9 100644
>>> --- a/include/hw/nmi.h
>>> +++ b/include/hw/nmi.h
>>> @@ -37,7 +37,16 @@ typedef struct NMIState NMIState;
>>>   struct NMIClass {
>>>       InterfaceClass parent_class;
>>>
>>> -    void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **er=
rp);
>>> +    /**
>>> +     * nmi_handler: Callback to handle NMI notifications.
>>> +     *
>>> +     * @n: Class #NMIState state
>>> +     * @errp: pointer to error object
>>> +     *
>>> +     * On success, return %true.
>>> +     * On failure, store an error through @errp and return %false.
>>> +     */
>>> +    bool (*nmi_handler)(NMIState *n, Error **errp);
>> Any particular reason to change the method name here?
>> Do we really need to indicate failure both through the bool return
>> and the Error** ?
>
> No, but this is the style *recommended* by the Error API since
> commit e3fe3988d7 ("error: Document Error API usage rules"):
>
>     error: Document Error API usage rules
>
>     This merely codifies existing practice, with one exception: the rule
>     advising against returning void, where existing practice is mixed.
>
>     When the Error API was created, we adopted the (unwritten) rule to
>     return void when the function returns no useful value on success,
>     unlike GError, which recommends to return true on success and false
>     on error then.
>
>     [...]
>
>     Make the rule advising against returning void official by putting it
>     in writing.  This will hopefully reduce confusion.
>
>   * - Whenever practical, also return a value that indicates success /
>   *   failure.  This can make the error checking more concise, and can
>   *   avoid useless error object creation and destruction.  Note that

It's the difference between

    if (!frobnicate(arg, errp)) {
        return;
    }

and

    frobnicate(arg, &err);
    if (err) {
        error_propagate(errp, err);
        return;
    }

Readabilty dies by a thousand cuts.

GError got this right.  We deviated from it for Error, until we
understood why it's right.

Another win: &error_abort gives you a backtrace into frobnicate() with
the former, and into error_propagate() with the latter.

>   *   we still have many functions returning void.  We recommend
>   *   =E2=80=A2 bool-valued functions return true on success / false on f=
ailure,
>   *   =E2=80=A2 pointer-valued functions return non-null / null pointer, =
and
>   *   =E2=80=A2 integer-valued functions return non-negative / negative.
>
> Anyway I'll respin removing @cpu_index as a single change :)


