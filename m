Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72DEC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 17:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rooLz-0000xc-N4; Mon, 25 Mar 2024 13:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rooLx-0000x2-1A
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rooLu-0007VG-Vg
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711388597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqfNH1OIQ/muhwiWBcb4ExuAyM6/Y6x0jZn/V2s7QsI=;
 b=MBA9QoLHAzby4f7LwHiIIEs6LOuDcPlyPuwoGa89hCxmVpFP7Fxmruc3KicV7DPTAk6ddx
 NWMpcI+aFns64H+Q6bmxfADjP/40f1e2y2K7sZr7ZL5y48joIClrbXiS6zjf5Nl3kA1+uR
 MfafepHQRef2wZDqTJL+Ws3/BdIfH0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-zkdtFWZIOASlFf7TqFIeJA-1; Mon, 25 Mar 2024 13:43:14 -0400
X-MC-Unique: zkdtFWZIOASlFf7TqFIeJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B271C88F72A;
 Mon, 25 Mar 2024 17:43:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 771331C060A4;
 Mon, 25 Mar 2024 17:43:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7486521E668C; Mon, 25 Mar 2024 18:43:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [PATCH v1] qapi: document parameters of query-cpu-model-* QAPI
 commands
In-Reply-To: <1e03601d-f55d-4527-8382-d884d226bd50@redhat.com> (David
 Hildenbrand's message of "Mon, 25 Mar 2024 17:27:28 +0100")
References: <20240325150141.342720-1-david@redhat.com>
 <87edbyjp0x.fsf@pond.sub.org>
 <1e03601d-f55d-4527-8382-d884d226bd50@redhat.com>
Date: Mon, 25 Mar 2024 18:43:08 +0100
Message-ID: <8734seyzpv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

David Hildenbrand <david@redhat.com> writes:

>>>   #
>>>   # Usually, a CPU model is compared against the maximum possible CPU
>>>   # model of a certain configuration (e.g. the "host" model for KVM).
>>> @@ -154,7 +155,14 @@
>>>   # Some architectures may not support comparing CPU models.  s390x
>>>   # supports comparing CPU models.
>>>   #
>>> -# Returns: a CpuModelBaselineInfo
>>> +# @modela: description of the first CPU model to compare, referred to as
>>> +#     "model A" in CpuModelCompareResult
>>> +#
>>> +# @modelb: description of the second CPU model to compare, referred to as
>>> +#     "model B" in CpuModelCompareResult
>>> +#
>>> +# Returns: a CpuModelCompareInfo, describing how both CPU models
>>
>> Scratch the comma?
>
> Agreed to both. Do you want to fixup when applying or do you prefer a v2?

Happy to fix it up myself, thanks!

> Thanks!
>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>


