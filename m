Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78541C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVJV-0008M0-TI; Fri, 08 Mar 2024 03:10:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1riVJL-00084P-Ua
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1riVJK-0005U7-3g
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709885432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ee6qCi3cVt7FPH9uo7Ug7ws8QTq3Nq6TyfHToQY9eiE=;
 b=f1lBTFf0Qti9dF0OAz+OYNp6yRY+XmMrxdwJ6OcEeNHmInE9uDTBgUtewbygyKpKyNbIDI
 gwP3sq80LW3SRCtSKma77bpgwI8Ge8N1ZuUBoClbUENcqCyv5qU6bRfdGUb60Uj3UUf3Mi
 3jVZJAlQfPng3eeq7y6nUlpVCUxX4o4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-TMP7tOr6Mh-2wqVB365UVA-1; Fri, 08 Mar 2024 03:10:28 -0500
X-MC-Unique: TMP7tOr6Mh-2wqVB365UVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2319E8007A6;
 Fri,  8 Mar 2024 08:10:28 +0000 (UTC)
Received: from [10.39.192.88] (unknown [10.39.192.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2717A1C067FA;
 Fri,  8 Mar 2024 08:10:25 +0000 (UTC)
Message-ID: <7212177d-e4d2-5875-b6f0-77991e0e38af@redhat.com>
Date: Fri, 8 Mar 2024 09:10:24 +0100
MIME-Version: 1.0
Subject: Re: [RFC PATCH 4/5] hw/i386/q35: Wire virtual SMI# lines to ICH9
 chipset
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20240226164913.94077-1-philmd@linaro.org>
 <20240226164913.94077-5-philmd@linaro.org> <Zd9iz9aIwM3cOqwt@intel.com>
 <5a42a295-bb1e-49f6-ae1d-94aec1efb61c@redhat.com>
 <6be774d0-6277-4d50-b97b-a0177cad8fd8@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <6be774d0-6277-4d50-b97b-a0177cad8fd8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/8/24 09:08, Philippe Mathieu-Daudé wrote:
> On 7/3/24 20:43, Thomas Huth wrote:
>> On 28/02/2024 17.43, Zhao Liu wrote:
>>> Hi Philippe,
>>>
>>>> +/*
>>>> + * Real ICH9 contains a single SMI output line and doesn't
>>>> broadcast CPUs.
>>>> + * Virtualized ICH9 allows broadcasting upon negatiation with
>>>> guest, see
>>>> + * commit 5ce45c7a2b.
>>>> + */
>>>> +enum {
>>>> +    ICH9_VIRT_SMI_BROADCAST,
>>>> +    ICH9_VIRT_SMI_CURRENT,
>>>> +#define ICH9_VIRT_SMI_COUNT 2
>>>> +};
>>>> +
>>>
>>> Just quick look here. Shouldn't ICH9_VIRT_SMI_COUNT be defined
>>> outside of
>>> enum {}?
>>
>> Or even better, do it without a #define:
>>
>> enum {
>>      ICH9_VIRT_SMI_BROADCAST,
>>      ICH9_VIRT_SMI_CURRENT,
>>      ICH9_VIRT_SMI_COUNT
> 
> This form isn't recommended as it confuses static analyzers,
> considering ICH9_VIRT_SMI_COUNT as part of the enum.

Side comment: I didn't know about this (so thanks for the info), but
that's really a shame for those static analyzers. It's an ancient and
valid pattern. :/

> 
>> };
>>
>>   Thomas
>>
> 


