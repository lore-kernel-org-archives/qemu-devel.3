Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42008C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRUI-0001Rp-FT; Mon, 29 Jul 2024 10:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYRUG-0001Px-SI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYRUF-00079e-HE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722263790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/jY559H9vS6cKA++BRJ3mq/D6lSrfhqH/1UYiQk1pzU=;
 b=KMRyF9wyFY/fEjPcmjBs2Q9coKN8w+tfKrZUGbgE9Jb2zy0nVWwg6kawCAMJNy/s2KrCgF
 gDI6x7kW9GOOc8ZqPfM0687eLkUn/jsKOvFOJbRu4vyCIfOgRo9q9UbT0G89LW2B3MMWL4
 /zQwYKzjGIvfORc8P2ZiFJLlXPhDOlM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-aeXrgS9_PxueyL8psSvsjA-1; Mon,
 29 Jul 2024 10:36:22 -0400
X-MC-Unique: aeXrgS9_PxueyL8psSvsjA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F1A61955BEF; Mon, 29 Jul 2024 14:36:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1D211955D42; Mon, 29 Jul 2024 14:36:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8FDE421E6693; Mon, 29 Jul 2024 16:36:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>,  qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org,  thuth@redhat.com,  wangyanan55@huawei.com,
 philmd@linaro.org,  marcel.apfelbaum@gmail.com,  eduardo@habkost.net
Subject: Re: [PATCH v1] target/s390x: move @deprecated-props to
 CpuModelExpansion Info
In-Reply-To: <f42a8801-f49d-48b6-84a4-467c89e78657@redhat.com> (David
 Hildenbrand's message of "Mon, 29 Jul 2024 16:22:16 +0200")
References: <20240726203646.20279-1-walling@linux.ibm.com>
 <877cd7qsnj.fsf@pond.sub.org>
 <00bc2317-dbba-43b3-b355-ddce45b5dfc6@redhat.com>
 <87a5i0cmht.fsf@pond.sub.org>
 <f42a8801-f49d-48b6-84a4-467c89e78657@redhat.com>
Date: Mon, 29 Jul 2024 16:36:16 +0200
Message-ID: <87msm0b6zj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

David Hildenbrand <david@redhat.com> writes:

>>>> The simplest way to address 4 is to tack 'if': 'TARGET_S390X' to
>>>> @deprecated-props.
>>>>
>>>
>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>> index 09dec2b9bb..0be95d559c 100644
>>> --- a/qapi/machine-target.json
>>> +++ b/qapi/machine-target.json
>>> @@ -253,7 +253,7 @@
>>>    ##
>>>    { 'struct': 'CpuModelExpansionInfo',
>>>      'data': { 'model': 'CpuModelInfo',
>>> -            '*deprecated-props': ['str'] },
>>> +            '*deprecated-props' : { 'type': ['str'], 'if': 'TARGET_S390X' } },
>>>      'if': { 'any': [ 'TARGET_S390X',
>>>                       'TARGET_I386',
>>>                       'TARGET_ARM',
>>>
>>>
>>> Should do the trick, right?
>> 
>> Yes.  Break the line before 'if', please.
>
> Ack
>
> [...]
>
>> 
>> Questions?
>
> As clear as it can get, thanks! :)
>
> That would leave us with:

Looks good to me!


