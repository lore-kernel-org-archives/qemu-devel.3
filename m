Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36154CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqVsV-0001zq-If; Mon, 25 Aug 2025 08:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uqVsI-0001rl-Kp
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uqVs7-00009m-PR
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756123221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PKqPtVVMp9XhCY50mkx4ez1lBWW3roA1ZWLAoiiwGLE=;
 b=TOKL8/azZo4pOus1ZoEIdj07ocMjr8SPMtMzqOJ7FptM7KopyxXtaYBkmMGyAAL12znAJe
 A/eOrzj0Sw9IgrCANB7r92LNh5UemvIADGylYEIimB6aQYIi0/SDdGXdxi37tIPbC2jtxs
 9M3t/ulGU996VwuFKJbrlM4nOPJjKKE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-yd6zZ6GENrS4PzbliJ4z9g-1; Mon,
 25 Aug 2025 08:00:17 -0400
X-MC-Unique: yd6zZ6GENrS4PzbliJ4z9g-1
X-Mimecast-MFC-AGG-ID: yd6zZ6GENrS4PzbliJ4z9g_1756123212
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD36518009F0; Mon, 25 Aug 2025 12:00:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33C521955E8C; Mon, 25 Aug 2025 12:00:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1DAED21E6A27; Mon, 25 Aug 2025 14:00:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Arun Menon
 <armenon@redhat.com>,  qemu-devel@nongnu.org,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,  Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,  Nicholas Piggin
 <npiggin@gmail.com>,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Hailiang Zhang
 <zhanghailiang@xfusion.com>,  Steve Sistare <steven.sistare@oracle.com>,
 qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Matthew Rosato
 <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v6 23/24] migration: Add error-parameterized function
 variants in VMSD struct
In-Reply-To: <e4325c6b-f543-4f1b-862a-290e51c80999@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Sun, 10 Aug 2025 13:59:47 +0900")
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-23-fef740e15e17@redhat.com>
 <3e9aa703-2805-4ac4-9f10-f4ba71c10c8a@rsg.ci.i.u-tokyo.ac.jp>
 <aH5AtUcjI3HYXdBe@redhat.com>
 <9c552525-72fa-4d1e-89a2-b5c0e446935a@rsg.ci.i.u-tokyo.ac.jp>
 <87fre0ucxu.fsf@pond.sub.org>
 <d3c6cac8-cbf6-4c27-afea-c49391262935@rsg.ci.i.u-tokyo.ac.jp>
 <87jz3csh3b.fsf@pond.sub.org>
 <e4325c6b-f543-4f1b-862a-290e51c80999@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 25 Aug 2025 14:00:03 +0200
Message-ID: <87v7mbsjb0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Please excuse the delayed response, I was on vacation.

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> On 2025/08/09 23:30, Markus Armbruster wrote:
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

[...]

>>> There were three options on the table: bool, int, and void.
>>>
>>> The previous discussion you referred explains why void should be avoided, and include/qapi/error.h also says void should be avoided.
>>>
>>> There is pre_load() that does not use Error returns int, but now we are adding pre_load_errp() that uses Error.
>>>
>>> Then what pre_load_errp() should return: bool or int?
>>
>> I like bool when it's all we need.
>>
>> When we need to return a non-negative int on success, use int and return
>> -1 or a negative error code on failure.
>>
>> Another reason to pick int is local consistency: related functions
>> already use int.
>>
>> Changing working code from int to bool doesn't seem worth the bother.
>>
>> Questions?
>
> I at least see what "[PATCH v9 26/27] migration: Add error-parameterized function variants in VMSD struct" says is undesirable. It says:
>
>> For the errp variants,
>> Returns: 0 on success,
>>          <0 on error where -value is an error number from errno.h

Does any caller use errno codes to discriminate between failures?

> There are already non-errp variant implementations that return -1 (e.g., dbus_vmstate_post_load). Adding errp variants that require to return errno is degradation.

However, the non-errp variants are intended to be removed.  Any
inconsistency with them would hopefully be temporary.  We can accept
that when other considerations call for it.

> I'm still not sure what conclusion will be drawn. I can make two opposite conclusions:
>
> - Non-errp variants return int, so errp variants should also return int
>   for local consistency.
>
> - bool is all we need, but changing non-errp variants doesn't seem worth
>   the bother, so only errp variants should return bool.

Here's my recommendation.

If any caller needs to use errno codes, use int and return -errno on
failure.  This is inconsistent with the old callbacks, but callers'
needs trump that.

Else if we want consistency with the old callbacks even though we intend
to remove them, use int and return -1 on failure.

Else use bool and return false on failure.


