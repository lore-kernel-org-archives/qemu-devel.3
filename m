Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD2DC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8pf-0007pc-PX; Mon, 18 Mar 2024 04:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rm8pc-0007om-O4
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rm8pN-0002Q4-GU
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710752319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pd4hnMLTaIT6nx5wpBQqhWOIoVrwbzfHw8KZ+M3Mlho=;
 b=X3yQLg5XnocE08sDI3irO3dlRa24GsPxRJOdnJXVWzuISZGw2vDCEEtuOhbxsHIncThr71
 DrNLPBIpRWSjshi9bQgZgDYgqKrAL+2zV2jblnusuqAg7A2XStR6qyQnE5qv97HLFELHiS
 15cZoRKCistJ1SqQm/d810pucmOEJmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-j9m5RZVBMxWfJyWOMlSltg-1; Mon, 18 Mar 2024 04:58:37 -0400
X-MC-Unique: j9m5RZVBMxWfJyWOMlSltg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B5C0811E81;
 Mon, 18 Mar 2024 08:58:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A695C017A1;
 Mon, 18 Mar 2024 08:58:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 008BB21E6A28; Mon, 18 Mar 2024 09:58:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>,  qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,  qemu-block@nongnu.org,  Juan Quintela
 <quintela@redhat.com>
Subject: Re: [PATCH 08/10] qapi: Correct error message for
 'vcpu_dirty_limit' parameter
In-Reply-To: <4b17e2fa-3b6c-4c7e-a888-661d1bf1324b@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 12 Mar 2024 18:51:15
 +0100")
References: <20240312141343.3168265-1-armbru@redhat.com>
 <20240312141343.3168265-9-armbru@redhat.com>
 <ZfB0Oq7SSQgiqbz5@intel.com>
 <4b17e2fa-3b6c-4c7e-a888-661d1bf1324b@linaro.org>
Date: Mon, 18 Mar 2024 09:58:31 +0100
Message-ID: <87cyrr9ars.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> On 12/3/24 16:26, Zhao Liu wrote:
>> On Tue, Mar 12, 2024 at 03:13:41PM +0100, Markus Armbruster wrote:
>>> Date: Tue, 12 Mar 2024 15:13:41 +0100
>>> From: Markus Armbruster <armbru@redhat.com>
>>> Subject: [PATCH 08/10] qapi: Correct error message for 'vcpu_dirty_limi=
t'
>>>   parameter
>>>
>>> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>>
>>> QERR_INVALID_PARAMETER_VALUE is defined as:
>>>
>>>    #define QERR_INVALID_PARAMETER_VALUE \
>>>        "Parameter '%s' expects %s"
>>>
>>> The current error is formatted as:
>>>
>>>    "Parameter 'vcpu_dirty_limit' expects is invalid, it must greater th=
en 1 MB/s"
>>>
>>> Replace by:
>>>
>>>    "Parameter 'vcpu_dirty_limit' is invalid, it must greater than 1 MB/=
s"
>>
>> Is there a grammar error here? Maybe
>> s/it must greater/it must be greater/
>
> Oops indeed!

What about dropping "is invalid, "?  I.e. go with

    "Parameter 'vcpu_dirty_limit' must be greater than 1 MB/s"

>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   migration/options.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/migration/options.c b/migration/options.c
>>> index 40eb930940..c5115f1b5c 100644
>>> --- a/migration/options.c
>>> +++ b/migration/options.c
>>> @@ -1264,9 +1264,8 @@ bool migrate_params_check(MigrationParameters *pa=
rams, Error **errp)
>>>         if (params->has_vcpu_dirty_limit &&
>>>           (params->vcpu_dirty_limit < 1)) {
>>> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>>> -                   "vcpu_dirty_limit",
>>> -                   "is invalid, it must greater then 1 MB/s");
>>> +        error_setg(errp, "Parameter 'vcpu_dirty_limit' is invalid,"
>>> +                         " it must greater than 1 MB/s");
>
> So s/it must greater/it must be greater/ :)
>
>>>           return false;
>>>       }
>>>
>> Otherwise,
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>=20


