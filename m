Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B006C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 05:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCtgH-00045v-5p; Thu, 08 May 2025 01:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCtgG-00045K-1G
 for qemu-devel@nongnu.org; Thu, 08 May 2025 01:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCtgE-00025U-Gi
 for qemu-devel@nongnu.org; Thu, 08 May 2025 01:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746681621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jr3NJCU53AwGoYjfRqX+83IhR18S1oPkNFu225Q4L4c=;
 b=eoOdGZ8o41vvBfKC4fIrGLk4T9D+lWVgunAIHowDm0UNKjZv+PJ9iKBw7gKd3MaW7oR0JH
 kQYvqLNHI7v4tJyDohfS5ZjWytivzRkceBeKrtoN9WwwBh06EvRVXVF/XrS+gBfIHGBJ4e
 8CROy5IH9UyFjXj2szFIKR/RznMwAdU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-UttzWJRsPV-OAlRc_spRkA-1; Thu,
 08 May 2025 01:20:17 -0400
X-MC-Unique: UttzWJRsPV-OAlRc_spRkA-1
X-Mimecast-MFC-AGG-ID: UttzWJRsPV-OAlRc_spRkA_1746681616
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D7C1180034A; Thu,  8 May 2025 05:20:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDC0D180049D; Thu,  8 May 2025 05:20:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07CD421E66C3; Thu, 08 May 2025 07:20:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 1/2] block/null: Report DATA if not reading zeroes
In-Reply-To: <87wmarelsh.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 08 May 2025 07:03:42 +0200")
References: <20250430203717.16359-1-nirsof@gmail.com>
 <20250430203717.16359-2-nirsof@gmail.com>
 <87plgjg1kh.fsf@pond.sub.org> <87wmarelsh.fsf@pond.sub.org>
Date: Thu, 08 May 2025 07:20:13 +0200
Message-ID: <87ikmbel0y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Nir Soffer <nirsof@gmail.com> writes:

[...]

>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index b1937780e1..7c95c9e36a 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -3293,8 +3293,9 @@
     ##
     # @BlockdevOptionsNull:
     #
     # Driver specific block device options for the null backend.
     #
     # @size: size of the device in bytes.

Missing: default value.

     #
     # @latency-ns: emulated latency (in nanoseconds) in processing
>>>  #     requests.  Default to zero which completes requests immediately.
>>>  #     (Since 2.4)
>>>  #
>>> -# @read-zeroes: if true, reads from the device produce zeroes; if
>>> -#     false, the buffer is left unchanged.
>>> +# @read-zeroes: if true, emulate a sparse image, and reads from the
>>> +#     device produce zeroes; if false, emulate an allocated image but
>>> +#     reads from the device leave the buffer unchanged.
>>>  #     (default: false; since: 4.1)
>>>  #
>>>  # Since: 2.9
>>
>> Possibly dumb question: how is this doc change related to the code fix?
>>
>> Suggest to split the sentence for easier reading:
>>
>>    # @read-zeroes: If true, emulate a sparse image, and reads from the
>>    #     device produce zeroes.  If false, emulate an allocated image,
>>    #     but reads from the device leave the buffer unchanged.
>
> false is a security hazard, as secure-coding-practices.rst points out.
> I think it should be pointed out right here as well.  Especially since
> "security hazard" is the default!
>
> I'd do it in a separate patch, but I'm a compulsive patch splitter.


