Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB96FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdz7-0003Va-1D; Tue, 28 Apr 2026 04:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wHdz2-0003DG-Ho
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wHdyz-0006cZ-M2
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777365591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U6sNButkxY1M0yTI4HRvW0XQjBJICxH363Wl8Rpn5KI=;
 b=UwbWXPRnF6VEXnE2X2iGAzdT/yGQ2qnxOho/u+aKor/pMMRTM+JidvofXAY0DlOD7iQsq8
 tscSiFlh2KFvfo2yGpav3mt9ptlZP0JhonxQYxveOp9q+VE2PGXtntJ4K3ZeVXmP+gjdSa
 3urtJ4x5BbNQzcr5BlRNxxk+MVoN/Xg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-iN5-YVwLMbaGfiiEBpSyQg-1; Tue,
 28 Apr 2026 04:39:47 -0400
X-MC-Unique: iN5-YVwLMbaGfiiEBpSyQg-1
X-Mimecast-MFC-AGG-ID: iN5-YVwLMbaGfiiEBpSyQg_1777365586
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85869195608B; Tue, 28 Apr 2026 08:39:46 +0000 (UTC)
Received: from [10.32.181.22] (unknown [10.32.181.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D45B1180047F; Tue, 28 Apr 2026 08:39:44 +0000 (UTC)
Message-ID: <de48c866-6018-4a5f-9129-2c1d184f4495@redhat.com>
Date: Tue, 28 Apr 2026 10:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/18] migration: VMStateInfo: introduce new handlers
 with errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-13-vsementsov@yandex-team.ru>
 <d80e91c1-2cbb-4081-a923-7b0c1da3b7cc@redhat.com>
 <f7525a89-7878-43e8-b791-69829589666f@yandex-team.ru>
 <CABgObfbz98A0P4_FAqeKVk_fS+o_3=79agYz=qwnMdmg-h2L-Q@mail.gmail.com>
 <b47b83aa-c574-4a38-bad2-4f42d6a7c597@yandex-team.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <b47b83aa-c574-4a38-bad2-4f42d6a7c597@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/28/26 10:17, Vladimir Sementsov-Ogievskiy wrote:
> [add Markus]
> 
> On 27.04.26 22:11, Paolo Bonzini wrote:
>>
>>
>> Il lun 27 apr 2026, 15:19 Vladimir Sementsov-Ogievskiy 
>> <vsementsov@yandex-team.ru <mailto:vsementsov@yandex-team.ru>> ha 
>> scritto:
>>
>>     On 26.04.26 11:33, Paolo Bonzini wrote:
>>      > On 3/4/26 21:22, Vladimir Sementsov-Ogievskiy wrote:
>>      >> +    bool coroutine_mixed_fn (*load)(QEMUFile *f, void *pv, 
>> size_t size,
>>      >> +                                    const VMStateField *field,
>>      >> +                                    Error **errp);
>>      >> +    bool coroutine_mixed_fn (*save)(QEMUFile *f, void *pv, 
>> size_t size,
>>      >> +                                    const VMStateField *field,
>>      >> +                                    JSONWriter *vmdesc,
>>      >> +                                    Error **errp);
>>      > Use void functions for callbacks, with a wrapper adding the 
>> bool type. While bool/errp is preferred in general, for callbacks it 
>> provides N opportunities to get it wrong instead of just one.
>>      >
>>
>>     Hmm, for now, the series is already merged.
>>
>>     Next, I'm unsure, how callbacks are different from other functions 
>> around errors?
>>
>>
>> As I wrote above, confusing the *error == NULL and bool return value 
>> is avoided without much extra effort for callbacks (or other kinds of 
>> virtual functions) l, because there is a single caller. So the balance 
>> between "avoiding the possibility of getting the return value wrong" 
>> and "convenience of having a return value" tilts more towards the former.
> 
> Understand. Hm.
> 
> An alternative for this single-caller case, is just add an assertion 
> into this caller:
> 
> bool wrapper(..., errp) {
>     ERRP_GUARD();
>     bool ok = x->foo(..., errp);
>     assert(ok == !(*errp));
>     return ok;
> }

I don't think this makes sense, the assertion moves a compile-time 
guarantee to a run-time guarantee which is strictly worse.

There are many more examples of void+errp callbacks than bool+errp, the 
most important one being .realize for devices.  A quick grep, which is 
certainly not fully accurate, shows 63 vs. 27:

$ git grep -w 'void.*(\*.*errp' | wc -l
63
$ git grep -w 'bool.*(\*.*errp' | wc -l
27

In many cases there are just two or three implementation so I wouldn't 
go to great lengths to change it even if I disagree.  But for vmstate 
(e.g. pre_load_errp and friends) this is not going to be the case in the 
long run, and it's more similar to the device case.

Paolo


