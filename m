Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46195C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA4wJ-0000jj-Ul; Wed, 30 Apr 2025 06:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uA4wI-0000jG-2Q
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uA4wG-0004gV-CV
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746009915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wZ2yWQ/fpyyGKT3JEdOeN2Kk9J8fi8NAV2x0riqcYg=;
 b=eWBYTuW7nnZPFreI1rmw9JF0xGCd+ztAFI2iKl124MUOkzMSekmMUuqARHvqP4Hu0O+Slc
 beIeYu7wbVUW9KdHmWV1oqOgr9OmZVipXJxee9/qXFv3SlEYLLBVqrjSUejrh5pm26RzsF
 ZGHlbMaoatYvaCgSGBJ75uIwfMtKsoQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-3QEVNaS9OJOBt5wrhKmSlQ-1; Wed,
 30 Apr 2025 06:45:13 -0400
X-MC-Unique: 3QEVNaS9OJOBt5wrhKmSlQ-1
X-Mimecast-MFC-AGG-ID: 3QEVNaS9OJOBt5wrhKmSlQ_1746009912
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71374180087F; Wed, 30 Apr 2025 10:45:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEFD1195608D; Wed, 30 Apr 2025 10:45:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DD4021E66C3; Wed, 30 Apr 2025 12:45:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,
 Daniel =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  Stefan
 Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] Drop support for Python 3.8
In-Reply-To: <5d0e0b69-cbbc-4fa4-a847-fdc8603a8122@redhat.com> (Thomas Huth's
 message of "Wed, 30 Apr 2025 09:57:24 +0200")
References: <20250425120710.879518-1-thuth@redhat.com>
 <57f21448-79c1-4d46-9a8e-f9109eb67dcd@linaro.org>
 <87jz78b7fh.fsf@pond.sub.org>
 <5d0e0b69-cbbc-4fa4-a847-fdc8603a8122@redhat.com>
Date: Wed, 30 Apr 2025 12:45:09 +0200
Message-ID: <875ximdj2i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

>  Hi!
>
> On 25/04/2025 17.13, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>> On 25/4/25 14:07, Thomas Huth wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>> Python 3.8 went "end of life" in October 2024 and Fedora 42 dropped
>>>> this version already, so the "python" CI job is currently failing.
>>>> Thus it's time to drop support for this Python version in QEMU, too.
> ...
>>>>    if test -z "${PYTHON}"; then
>>>>        # A bare 'python' is traditionally python 2.x, but some distros
>>>>        # have it as python 3.x, so check in both places.
>>>> -    for binary in python3 python python3.12 python3.11 \
>>>> -                          python3.10 python3.9 python3.8; do
>>>> +    for binary in python3 python python3.13 python3.12 python3.11 \
>>>
>>> The 3.13 test was missing in commit 45b14be9b63 ("python: enable testing
>>> for 3.13"). Preferably adding in a preliminary commit, otherwise mention
>>> in this patch description
>
> Yes, I'll add a sentence to the patch description!
>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Thanks!
>
>> Yes.  The patch looks good to me otherwise.  But John knows a lot more
>> about this stuff than I do; would be good to get his blessing.
>
> Seems like John is currently away from keyboard / busy with other stuff? =
I think we should go ahead and include this patch to get the CI green again=
, so I'll add it to my next pull request. If there is still anything that n=
eeds to be done on top, it can be done in another patch later.

Makes sense.  I assume you'll amend the commit message to address
Philippe's review.


