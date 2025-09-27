Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C44CAC5B9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 06:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Nyq-0007WK-3F; Sat, 27 Sep 2025 02:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v2Nym-0007T2-Nk
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 02:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v2Nyb-0001B9-RC
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 02:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758952803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXERD5Kjo8qaQv+P+hPIgtJ2qVzXFBt+poMR804nPfg=;
 b=GlrNXbMFni0U2lJDH1+4zqweqWEuf83jhqdx8FTTLdjJboCw1/p0IPk6C7J+rNUeFiWLhL
 W9RyWUnGeY5uiI6CPGb8CSNgJ6NTlebBKkuDvEK+CvkHDmT32jqME72LrgvPMorciD1OEm
 j1ggg+8KA4b2poTFok/ir92qFPwcYMY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-6mlYjAebMkOabC2-KxvcOQ-1; Sat,
 27 Sep 2025 02:00:01 -0400
X-MC-Unique: 6mlYjAebMkOabC2-KxvcOQ-1
X-Mimecast-MFC-AGG-ID: 6mlYjAebMkOabC2-KxvcOQ_1758952800
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A67E81956086; Sat, 27 Sep 2025 05:59:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF5A51800115; Sat, 27 Sep 2025 05:59:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 297CF21E6A27; Sat, 27 Sep 2025 07:59:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  mjrosato@linux.ibm.com,
 thuth@redhat.com,  alex.williamson@redhat.com,  clg@redhat.com
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
In-Reply-To: <90de0c70-9309-4fd0-a5d7-3bd9e7088a0e@linux.ibm.com> (Farhan
 Ali's message of "Fri, 26 Sep 2025 10:53:52 -0700")
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com>
 <87qzvtstd7.fsf@pond.sub.org>
 <90de0c70-9309-4fd0-a5d7-3bd9e7088a0e@linux.ibm.com>
Date: Sat, 27 Sep 2025 07:59:56 +0200
Message-ID: <87ms6gmo4j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Farhan Ali <alifm@linux.ibm.com> writes:

> On 9/25/2025 9:57 PM, Markus Armbruster wrote:
>> Farhan Ali <alifm@linux.ibm.com> writes:
>>
>>> Provide a vfio error handling callback, that can be used by devices to
>>> handle PCI errors for passthrough devices.
>>>
>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>   hw/vfio/pci.c | 8 ++++++++
>>>   hw/vfio/pci.h | 1 +
>>>   2 files changed, 9 insertions(+)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index bc0b4c4d56..b02a974954 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3063,11 +3063,19 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>>  static void vfio_err_notifier_handler(void *opaque)
>>>  {
>>>      VFIOPCIDevice *vdev =3D opaque;
>>> +    Error *err =3D NULL;
>>>
>>>      if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>>          return;
>>>      }
>>>
>>> +    if (vdev->err_handler) {
>>> +        if (vdev->err_handler(vdev, &err)) {
>>> +            return;
>>> +        }
>>> +        error_report_err(err);
>>> +    }
>>
>> This is unusual.
>>
>> Functions taking an Error ** argument usually do so to report errors.
>> The rules spelled out in qapi/error.h apply.  In particular:
>>
>>   * - On success, the function should not touch *errp.  On failure, it
>>   *   should set a new error, e.g. with error_setg(errp, ...), or
>>   *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>   *
>>   * - Whenever practical, also return a value that indicates success /
>>   *   failure.  This can make the error checking more concise, and can
>>   *   avoid useless error object creation and destruction.  Note that
>>   *   we still have many functions returning void.  We recommend
>>   *   =E2=80=A2 bool-valued functions return true on success / false on =
failure,
>>
>> If ->err_handler() behaved that way, it @err would be null after it
>> returns false.  We'd call error_report_err(NULL), and crash.
>>
>> Functions with unusual behavior need a contract: a comment spelling out
>> their behavior.
>>
>> What is the intended behavior of the err_handler() callback?
>
> Hi Markus,
>
> Thanks for reviewing! The intended behavior for err_handler() is to set e=
rrp and report the error on false/failure. With the above code, I also inte=
nded fall through to vm_stop() when err_handler() fails.
>
> I think I misunderstood the errp error handling, it seems like the correc=
t way to do what I intended would be
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b02a974954..630de46c90 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3070,10 +3070,11 @@ static void vfio_err_notifier_handler(void *opaqu=
e)
> =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0if (vdev->err_handler) {
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vdev->err_handler(vdev, &err)) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vdev->err_handler(vdev, &err)) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(err);
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(err);
> =C2=A0 =C2=A0 =C2=A0}
>
> Please correct me if I missed anything.

Resulting function:

   static void vfio_err_notifier_handler(void *opaque)
   {
       VFIOPCIDevice *vdev =3D opaque;
       Error *err =3D NULL;

       if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
           return;
       }

       if (vdev->err_handler) {
           if (!vdev->err_handler(vdev, &err)) {
               error_report_err(err);
           } else {
               return;
           }
       }

       /*
        * TBD. Retrieve the error details and decide what action
        * needs to be taken. One of the actions could be to pass
        * the error to the guest and have the guest driver recover
        * from the error. This requires that PCIe capabilities be
        * exposed to the guest. For now, we just terminate the
        * guest to contain the error.
        */

       error_report("%s(%s) Unrecoverable error detected. Please collect an=
y data possible and then kill the guest", __func__, vdev->vbasedev.name);

       vm_stop(RUN_STATE_INTERNAL_ERROR);
   }

Slighly rearranged for clearer control flow:

   static void vfio_err_notifier_handler(void *opaque)
   {
       VFIOPCIDevice *vdev =3D opaque;
       Error *err =3D NULL;

       if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
           return;
       }

       if (vdev->err_handler) {
           if (vdev->err_handler(vdev, &err)) {
               /* Error successfully handled */
               return;
           }
           error_report_err(err);
       }

       /*
        * TBD. Retrieve the error details and decide what action
        * needs to be taken. One of the actions could be to pass
        * the error to the guest and have the guest driver recover
        * from the error. This requires that PCIe capabilities be
        * exposed to the guest. For now, we just terminate the
        * guest to contain the error.
        */

       error_report("%s(%s) Unrecoverable error detected. Please collect an=
y data possible and then kill the guest", __func__, vdev->vbasedev.name);

       vm_stop(RUN_STATE_INTERNAL_ERROR);
   }

Questions / issues:

* Is the comment still accurate?

* When ->err_handler() fails, we report the error twice.  Would it make
  sense to combine the two error reports into one?

* Preexisting: the second error message is ugly.

  Error messages should be short and to the point: single phrase, with
  no newline or trailing punctuation.  The "please collect ..." part
  does not belong to the error message proper, it's advice on what to
  do.  Better: report the error, then print advice:

       error_report("%s(%s) Unrecoverable error detected",
                    __func__, vdev->vbasedev.name);
       error_printf("Please collect any data possible and then kill the gue=
st.");

  Including __func__ in an error message is an anti-pattern.  Look at

    vfio_err_notifier_handler(fred) Unrecoverable error detected

  with a user's eyes: "vfio_err_notifier_handler" is programmer
  gobbledygook, the device name "fred" is useful once you realize what
  it is, "Unrecoverable error detected" lacks detail.

[...]


