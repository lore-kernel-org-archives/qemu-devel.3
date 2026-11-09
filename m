Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D6606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGs0pgwV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQNz4-0002c4-6s; Mon, 09 Nov 2026 06:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQNz1-0002bM-NB
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:56:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQNz0-0002H7-2x
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794225377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKT5ydUXWkPMuONvThUADkphGTgoUMBtY3xtNddXppE=;
 b=KGs0pgwVun6e0/d/3YnmAZFpZHBxIhT2c+5wOZaXXga487WDn1sTz0CWmcafv+QTZ3Xo2s
 54vNPaOa4lXX29awWQeHuejJCXFODGxyFeZZejDsiLMSBM4cbmNl4E8+lsCrJ8+55CRPz0
 IFteb+GTR/4aSGB5rA6earQsRAQqA4g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-F5QIMySMNs6a4IuZnXuJDg-1; Mon,
 09 Nov 2026 06:56:12 -0500
X-MC-Unique: F5QIMySMNs6a4IuZnXuJDg-1
X-Mimecast-MFC-AGG-ID: F5QIMySMNs6a4IuZnXuJDg_1794225371
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D136A180034E; Mon,  9 Nov 2026 11:56:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31E541684; Mon,  9 Nov 2026 11:56:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E20A221E6A04; Mon, 09 Nov 2026 12:56:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 milesg@linux.ibm.com,  qemu-ppc@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 4/8] hw/gpio/pca9554: New abstract base "pca9554-base"
In-Reply-To: <aaba798c-591b-4956-be34-e6c9653398c8@nutanix.com> (Mark
 Cave-Ayland's message of "Mon, 9 Nov 2026 10:17:29 +0000")
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-5-armbru@redhat.com>
 <463635be-2321-49e6-852d-080aa00ce40d@nutanix.com>
 <aaba798c-591b-4956-be34-e6c9653398c8@nutanix.com>
Date: Mon, 09 Nov 2026 12:56:07 +0100
Message-ID: <87qzgu43s8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> On 09/11/2026 09:02, Mark Cave-Ayland wrote:
>
>> On 06/11/2026 11:04, Markus Armbruster wrote:
>>=20
>>> Commit 5eceb48bbe86 (hw/gpio: pca9554: add PCA9536 support) made type
>>> "pca9535" a child of concrete type "pca9555".=C2=A0 This is inconvenient
>>> for the next commit.=C2=A0 Make them both children of new abstract type
>>> "pca9554-base".
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  include/hw/gpio/pca9554.h |  1 +
>>>  hw/gpio/pca9554.c         | 55 +++++++++++++++++++++++----------------
>>>  2 files changed, 33 insertions(+), 23 deletions(-)
>>>=20
>>> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
>>> index 1b33a8a752..0d841ff017 100644
>>> --- a/include/hw/gpio/pca9554.h
>>> +++ b/include/hw/gpio/pca9554.h
>>> @@ -8,6 +8,7 @@
>>>  #ifndef PCA9554_H
>>>  #define PCA9554_H
>>>=20=20
>>> +#define TYPE_PCA9554_BASE "pca9554-base"
>>>  #define TYPE_PCA9554 "pca9554"
>>>  #define TYPE_PCA9536 "pca9536"
>>>=20=20
>>> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
>>> index caa73f63c9..1362b605c2 100644
>>> --- a/hw/gpio/pca9554.c
>>> +++ b/hw/gpio/pca9554.c
>>> @@ -26,7 +26,7 @@
>>>  #define PCA9554_PIN_COUNT 8
>>>  #define PCA9536_PIN_COUNT 4
>>>=20=20
>>> -OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554)
>>> +OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554_BASE)
>>>=20=20
>>>  struct PCA9554State {
>>>      /*< private >*/

[...]

>> The basic change looks good to me, however I found it tricky to follow g=
iven that PCA9554Class is now related to PCA9554_BASE_CLASS() and PCA9554St=
ate is now related to PCA9554_BASE().
>> Would it make sense to rename PCA9554Class to PCA9554BaseClass and PCA95=
54State to PCA9554BaseState here? I think it would help make the hierarchy =
easier to follow.
> Another follow-up question: how is PCA9554BaseState related to PCA955xSta=
te? The naming suggests that the latter is already assuming this role.

There is no PCA9554BaseState.

Have a look at the OBJECT_DECLARE_TYPE(), and its definition in
qom/object.h.  It does the following:

* typedef struct PCA9554State PCA9554State

* typedef struct PCA9554Class PCA9554Class

* Make g_autoptr(PCA9554State) work

* Define PCA9554_BASE(), PCA9554_BASE_CLASS(), PCA9554_GET_BASE_CLASS()

Or let's approach this from another angle.

Initially, we had just one type ("pca9554").  It had its own class and
instance struct (PCA9554Class and PCA9554State), which came with the
usual macros PCI9554(), PCA9554_CLASS(), PCA9554_GET_CLASS().

Then we added a second type ("pca9536") as a subtype of the first.
Instead of giving it its own class and instance struct, we reused the
existing ones, and we didn't define any macros.

This patch adds a third type ("pca9554-base").  It is abstract.  It
again reuses the existing class and instance struct.  However, because
this third type is the supertype of the existing two, we can't cleanly
reuse the existing macros.  So we *replace* them by PCA9554_BASE(),
PCA9554_BASE_CLASS(), PCA9554_BASE_GET_CLASS().  Except this is actually
a *rename*, because we still use them same class and instance struct.

Summary:

* "pca9536" ceases to be a subtype of "pca9554"

* "pca9554" and "pca9536" become subtypes of "pca9554-base"

* Their class and instance structs remain the same: PCA9554Class and
  PCA9554State.  There are no new C types.

* Macros PCA9554(), PCA9554_CLASS(), PCA9554_GET_CLASS() are renamed to
  PCA9554_BASE(), PCA9554_BASE_CLASS(), PCA9554_BASE_GET_CLASS().

Questions?


