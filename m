Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E21CA6007
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 08:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhkTy-0006MW-Gy; Mon, 19 Jan 2026 03:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vhkTq-0006JI-Nj
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:19:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vhkTo-0001Xz-Nf
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768810758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bf+t3wK6WQb1sILEjNbp9qQhYA94+qoMJ3aR91eVsyE=;
 b=Ag4d+HXfzD58iXmPSm0d6xdFOISXNOfxh27BBXgXN9XVws6lrSR+fJp6q52yUvdGbYHGJG
 FSk1keaFyUMdqRCXjKcSKVEtUhvBXamVj9CRNKfhn8GyDUjHgVvBI7SgBFp2eF5lERhdxZ
 fnGVoAaAeO58GNg3JHqMjuZ+K0T1t6s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-igoGtMv-PRifII89rZK2tg-1; Mon, 19 Jan 2026 03:19:17 -0500
X-MC-Unique: igoGtMv-PRifII89rZK2tg-1
X-Mimecast-MFC-AGG-ID: igoGtMv-PRifII89rZK2tg_1768810756
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fcf10287so3714677f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 00:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768810756; x=1769415556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bf+t3wK6WQb1sILEjNbp9qQhYA94+qoMJ3aR91eVsyE=;
 b=p3BoitBBLdVqJ7bP9HbmQqpg1MejC5GOKIsf0iAcfHJI9P7xkbqIX0MKwg6cmorUeJ
 fztuWcRsLto4mZHUqbseQFSa6thVIfNf9QQ3jdF80bZjHfIyvSRwIdea8O+LmZIGJwdR
 LbBMg3XVA4G2GEB0miZpH/Ei+wBZgPWs2o5PW7NqoOojKiKgz/Zj/H4c7hr7SrH4BIlE
 iJAjO7gacQa5+79whX+CMEbLgAU3R6/bAUtUfKI1gr38WInugNIy9FinMi9vE3yo0ZcS
 gqzpTcW9Mg/xBOEV2kSGn9m1gRj6pTQYg7naRf6oAERC3WZaj3smKKbK/girJnm20oDD
 HGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768810756; x=1769415556;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bf+t3wK6WQb1sILEjNbp9qQhYA94+qoMJ3aR91eVsyE=;
 b=U7Ff1EfciB1Zb4FBS7ySc/N2nubet6s0LoA+rbto9icTI3zRCF5thb67HNx1Glu13H
 M8ZHuZ5fEKSGj+p36lTAMSAuOxs6ZXqpyfPKRYOZ3lOkkWxKFP3/28DfDiSaWPTQp4ly
 PYOwHJ5pbbW+RZxDpRmtStCPBhxR6zTmzcj0uHETfZovVbYz2l7ABfSh9F/dKQLyaDqw
 sHEyrKWDVQF6YJZyRz2D7Q3YQ9Op2NAY2kYQnzSaYywjb7Ce9bVdeFfWvbet8yJM+5yc
 K7rwykp6dzn9V57+0CgwyTRVj3IT/iOwGXti/nS63pVIE0KA90PhoDysSgRhPO8qPnGv
 pSPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDl1R+31PjnA2jP0pk8JJCjDkYM3XineurrU8raqG/WnjRtc8+2g3aBlEtR2djPm2CtXXCivHZAZy3@nongnu.org
X-Gm-Message-State: AOJu0Ywf8BpnE1VNPuboKgOiQcD3+//3tinMYMyKD5xOiTQIxhAVjUUI
 PwMSDdqmXWHTgj6MNOBs+v51AmSIpT56SZyhDdYYrAmaoU7NaG/lcHrTSf8FP9W+y39KFOutv/g
 evZ076LhIbvhAj1PVSJML24TnrpBuDPjGDPhVH/8xT7Fu6yC81L2V+cbZ
X-Gm-Gg: AY/fxX6NkU+1UEs9lFWqkkOhOl6JYetWtrEvGG9iZtEcKEASHThUZijCZ8M04IodlNC
 8n+hChZBhK+mJqmDRDyeNdQbVkibDdxt695gQZhwZesf3x52Z7XHpqKpqJKE9DFPr9ob0CLbGRu
 clndQ96dFbvXX2t0CkVI51i1QEUsLgU31Heda2tvdoANj7XqH767Kf2UQHMV2PjcxFQf3GpOsQZ
 81WGtp8TlhOIHrEon+OKYS8h67/twsw0OxbbXruQAZ8QC73lL8Slbpivxf/yBrHmq55OBZWv5xv
 mq5IwZNYTd2uakStea1sO2HEYLPsCtKL2XAHjWvG+cadHBF9mIoo/xJDSyGdqxFgEg28hg1dVbI
 isHVhBy4=
X-Received: by 2002:a05:6000:310b:b0:427:526:16aa with SMTP id
 ffacd0b85a97d-43569bd6f4fmr13936998f8f.58.1768810755799; 
 Mon, 19 Jan 2026 00:19:15 -0800 (PST)
X-Received: by 2002:a05:6000:310b:b0:427:526:16aa with SMTP id
 ffacd0b85a97d-43569bd6f4fmr13936961f8f.58.1768810755314; 
 Mon, 19 Jan 2026 00:19:15 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435699982aasm22540327f8f.42.2026.01.19.00.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 00:19:14 -0800 (PST)
Message-ID: <dce4a763-d64a-4ef3-be05-9c24080c8003@redhat.com>
Date: Mon, 19 Jan 2026 09:19:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add maintainer for docs/
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
 <88cdd7fb-059b-4ce2-9db6-57700aad0571@redhat.com>
 <467c2bca-af39-4e00-b8ea-9e38c1f16e54@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <467c2bca-af39-4e00-b8ea-9e38c1f16e54@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 16/01/2026 19.31, Pierrick Bouvier wrote:
> On 1/15/26 11:17 PM, Thomas Huth wrote:
>> On 15/01/2026 21.35, Pierrick Bouvier wrote:
>>> I would like to help maintaining qemu documentation and I've been
>>> invited by Alex to apply as maintainer.
>>>
>>> Files in docs/ that are already maintained will continue to be under
>>> their respective maintainer. The goal here is to have someone that can
>>> help on all other files that don't have an official maintainer.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    MAINTAINERS | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 4ddbfba9f01..786f3b3a456 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4505,6 +4505,11 @@ Incompatible changes
>>>    R: devel@lists.libvirt.org
>>>    F: docs/about/deprecated.rst
>>> +General Documentation
>>> +M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> +S: Maintained
>>> +F: docs/
>>
>> You might trigger a lot of traffic to your inbox that way ... but if you
>> don't mind:
>>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>>
> 
> Reading about your answer, I was thinking it would be nice one day to 
> organize a BoF about everyone personal email workflow.
> I feel like every dev has a different way to deal with this, and even though 
> it seems basic ("Who would seriously ask advice about how to deal with 
> emails?"), it's much more complex than what you can expect in the beginning.
> 
> Hopefully, my workflow and my email client are ready to take it now.

Since you've asked for it, here are some of my thoughts:

I don't think it is e.g. hard to filter for e-mails that have "docs/" in the 
subject, so that's certainly not a problem. It's getting tricky for huge 
series that e.g. have just one little change to the docs folder in between. 
Some people will CC: the whole big series to you for that little change in 
one of the patches - how do you filter for such series?

Having maintained a generic subsystem with a catch-all entry in the past (I 
used to be the maintainer of the qtests, and we had a "F: tests/qtest/" 
entry in MAINTAINERS for this), I often got CC:-ed on big patch series that 
should rather go through the architecture maintainer's tree, and since only 
single patches affected the qtest subsystem, this was hard to filter, so I 
always got lots of unrelated patches in my Inbox in which I was not really 
interested in.

My mitigation was to add some "X:" lines to the qtest section in MAINTAINERS 
... but if someone has some better ideas how to deal with such situations 
(e.g. if there are some clever ways to filter such series out of your 
Inbox), I'd be grateful to hear about them!

FWIW, for the functional testing framework, I organized the entry in 
MAINTAINERS differently, there is no generic "F: tests/functional/" line in 
the section, but rather only coverage for the shared files of the framework 
... the tests themselves should be covered by the individual maintainers 
instead. This works much better for me there.

So I'm interested to know how the generic "F: docs/" entry will work out for 
you once this patch got merged and some weeks have passed. Having a BoF at 
the next KVM forum about this email workflow topic might be a good idea, indeed.

  Thomas


