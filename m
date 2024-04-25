Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06882C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 06:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzsdt-0007Bt-OH; Thu, 25 Apr 2024 02:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzsdq-0007BN-L4
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 02:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzsdo-0007B3-Jc
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 02:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714026691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sTn65/EdHbI2footvJWHPFv1s0rdbWwBE1lKwkZdG8g=;
 b=CTRR/d4TU7zlTzZeAdnHjtK8+RGXMjALBF9tEwCRl1kM6YlxkqrNzRaufl+YSIcIWS1Gn8
 BvbHvS7mnNXQlOB5jbn36c4N2eEm80VUdNCCMPQ3ga5qsWnZQ8Ouo+GCI1oKqoVaDcV0kV
 GB8UtMkWoDW6vmlX2W6aY7HhXz0kavs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-6royo9TgNFiR0o9msgrnPA-1; Thu, 25 Apr 2024 02:31:25 -0400
X-MC-Unique: 6royo9TgNFiR0o9msgrnPA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0B57830E76;
 Thu, 25 Apr 2024 06:31:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71D8D5C5CCA;
 Thu, 25 Apr 2024 06:31:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 90FAB21E66E5; Thu, 25 Apr 2024 08:31:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net
Subject: Re: [PATCH v2 1/3] cpu-models: add "disable-deprecated-feats"
 option to cpu model expansion
In-Reply-To: <809ee6ee-e66e-466f-bbf2-93ba7ec1afda@linux.ibm.com> (Collin
 Walling's message of "Wed, 24 Apr 2024 13:46:25 -0400")
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-2-walling@linux.ibm.com>
 <87bk5z5ll9.fsf@pond.sub.org>
 <809ee6ee-e66e-466f-bbf2-93ba7ec1afda@linux.ibm.com>
Date: Thu, 25 Apr 2024 08:31:23 +0200
Message-ID: <87jzkm9cn8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Collin Walling <walling@linux.ibm.com> writes:

> On 4/24/24 02:19, Markus Armbruster wrote:
>> Collin Walling <walling@linux.ibm.com> writes:
>> 
>>> This optional parameter for query-cpu-model-expansion enables CPU
>>> model features flagged as deprecated to appear in the resulting
>>> list of properties.
>>>
>>> This commit does not add support beyond adding a new argument
>>> to the query. All queries with this option present will result
>>> in an error claiming this option is not supported.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>  qapi/machine-target.json         | 7 ++++++-
>>>  target/arm/arm-qmp-cmds.c        | 7 +++++++
>>>  target/i386/cpu-sysemu.c         | 7 +++++++
>>>  target/s390x/cpu_models_sysemu.c | 7 +++++++
>>>  4 files changed, 27 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>> index 29e695aa06..b9da284d2d 100644
>>> --- a/qapi/machine-target.json
>>> +++ b/qapi/machine-target.json
>>> @@ -285,6 +285,10 @@
>>>  #
>>>  # @type: expansion type, specifying how to expand the CPU model
>>>  #
>>> +# @disable-deprecated-feats: include CPU model features that are
>>> +#     flagged as deprecated. If supported, these features will appear
>>> +#     in the properties list paired with false.
>> 
>> What's the default?
>> 
>> Which command result(s) does this affect?  Suggest to explain using
>> unabridged example QMP input and output before and after this series.
>
> Fair enough. Bool defaults to false but that's not apparent in the
> description. I will add more detail.

I didn't mean to ask for example QMP in the doc comment.  I need you to
explain the new member to me.  Once I understand what the thing does, I
may have suggestions on improving the doc comment.

[...]

> Thanks for your feedback!

You're welcome!


