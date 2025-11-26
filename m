Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6634D1039D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 10:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOCjI-0002G3-Pi; Wed, 26 Nov 2025 05:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOCjH-0002FU-7f
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 05:26:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOCjF-0007qT-91
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 05:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764152788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XZP8xUW1n+GNi5Y6J8oCNv4ZQFBP1ZcD++Gc4NVUlPo=;
 b=QXbtC7W0gE1vdp+rBDWLCLWiOo+cAItml9jS7CD0hq2Mh6LdLsRn4c1tjdHYwXtQJ9zp0e
 peqpLr0VMy8wEocn6jC6n6cWN9Vr+xRTmUyAB8XQJEZUpRvRUqjIOxcduafZJxm0AeXYWv
 VvXRb27j/Xv1Qfl60k3xe7BKBAVm2vc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-rU6Iz9RwO-2CZp9vyEHf5g-1; Wed, 26 Nov 2025 05:26:23 -0500
X-MC-Unique: rU6Iz9RwO-2CZp9vyEHf5g-1
X-Mimecast-MFC-AGG-ID: rU6Iz9RwO-2CZp9vyEHf5g_1764152782
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b352355a1so292646f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 02:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764152782; x=1764757582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XZP8xUW1n+GNi5Y6J8oCNv4ZQFBP1ZcD++Gc4NVUlPo=;
 b=tJ4RGgV5rYu6x5nwWTZj91KYacU+c+LjP5iLyROhaTdVfVCGiebTd4suqA9nyDWcZW
 N/nCQH8+AG6Fyugj7bb+4ZQacO5Vc2FYOZDY6Z1GCaUuaCErGDfgmrXYONhhV+NvuC9+
 nERzGNqhDspL3OjhF5Hw4GIrSriHEK83JdP8sfUpHHzWPe4clQBoDVnGgPlq6aPzBbN3
 1/qtN7mew4ZZ19cNBYhkYNf+SIMvIGw7WKRHQ9FHKFedEWNS24GDLTpeEjbcDQ0zGj5w
 QGc2K1jcyiLSWyWiaJJLnDj9Bp/VYbv+ZmRDogKW1KGJFHm9nCv9wtSNk9fKj1gjiEJZ
 XsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764152782; x=1764757582;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZP8xUW1n+GNi5Y6J8oCNv4ZQFBP1ZcD++Gc4NVUlPo=;
 b=ZeYNvI3nCxzKFPLmq0h+/S/Q3VasB7Wgs+O1CUsLp4WpoKXuzwY7MdAEEZxYcQeD9y
 M7R6JuKhyReKpJQiGrCWq9eMgK8qd9vuBmtYzSF5TNYlm6V7ki68H0mvKxL7gDwtS6xA
 fWYXq6Ix5wk+2kMjhQ+d0t970I2W0kOge+RJ7QflUvsygrCAwpx+g2+Nhnxr/awdVmo+
 g68AJR9aTROgQ38QQJM44dIffcdKXeGTBPDeCCG/Pi8SZIpMZz/4IIRN0GfZg5X8rk8n
 4gsPMwyQwEkZKT+fyq+cR0YMkgz7TEdzNNnCWPZ3bgR8t9t7dnVFocJrurIo1vzpFU/7
 dq/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUc40kEVMAQQInn2dlcaicMflt21ImgRcJConTMcPq4/0mqadQNWMR2EHZNoZuyPTk2Z4y6oiZNoXP@nongnu.org
X-Gm-Message-State: AOJu0YzpFi8iwBOc3oU9O6ZkeWz8J5A+nT+aDHxa8u5y1lJgONobYnTx
 TtbPYmivdWxePss1TT1toEJKrkCkMpqFs4COIVi3qNDPOUvCEhlgggydPvuySKg6amIRRU9XNao
 bECtWoSSFl7gQOlG/CkF5oSsiP53XThWgaXLiLpYGSJO3jWbwNqkze++D
X-Gm-Gg: ASbGncs4klYxqWF8QlB4+dU8yZPaNK011qlP16EeprPape43LAefrZWpZpmy8I7rcIE
 deYm3nmRuo3eWUxB0QbPx6uVSeb3krGcHkMLt+3HzvPNMSnMEj9tM8N/Cb//8pQYqU6KFcXZDlX
 ja9MylNVpwViXi3Snf6YXFQ8ewI9vPM+bVtoYWjZcQRa/ddtREO2YaVtRMSSL5EU7nsNFn+21A2
 UEFS+KBpM/HwBcwVRqPxdi8/uzYz8UUjmmyqhhvQoUuco2CZXCkxRm4mFeJ62ZqpjwrPE46XfEG
 5VlYrm/ruyfydjNgN/EER/dTpN79kZKYvNK2YABB8J+319Pm9/7+1AvCbVCA6uhfMKuzjlEKzz/
 Y5XnE6l9Pp2+2odG4+yIm83Sr19LU4+YDFB8vOkA7d7VQqJS+
X-Received: by 2002:a05:600c:3ba7:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-477c05139c2mr247437925e9.11.1764152782427; 
 Wed, 26 Nov 2025 02:26:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs7p+PFzDqfU6Pg2nRDXlSr3Bjmq6GqGp7g+6wCKbIw3S6B89CRDdJieLYv7g5QbD10T4I1A==
X-Received: by 2002:a05:600c:3ba7:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-477c05139c2mr247437515e9.11.1764152781968; 
 Wed, 26 Nov 2025 02:26:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adfb2edsm34356055e9.13.2025.11.26.02.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 02:26:21 -0800 (PST)
Message-ID: <c0aa79ad-d6f4-413f-ade6-43e7609e37ac@redhat.com>
Date: Wed, 26 Nov 2025 11:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: g_autoptr(Error)
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, farosas@suse.de, peter.maydell@linaro.org
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org> <aSWSLMi6ZhTCS_p2@redhat.com>
 <87jyzexrly.fsf@pond.sub.org> <aSXWKcjoIBK4LW59@x1.local>
 <769f5a57-7006-4cef-a5cb-12d53b7c30a5@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <769f5a57-7006-4cef-a5cb-12d53b7c30a5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/26/25 09:19, Cédric Le Goater wrote:
> On 11/25/25 17:15, Peter Xu wrote:
>> On Tue, Nov 25, 2025 at 12:46:01PM +0100, Markus Armbruster wrote:
>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>
>>>> On Tue, Nov 25, 2025 at 08:40:07AM +0100, Markus Armbruster wrote:
>>>>> g_autoptr(T) is quite useful when the object's extent matches the
>>>>> function's.
>>>>>
>>>>> This isn't the case for an Error object the function propagates to its
>>>>> caller.  It is the case for an Error object the function reports or
>>>>> handles itself.  However, the functions to report Error also free it.
>>
>> I'd confess I didn't pay enough attention on how the error API was designed
>> deliberately to always free the Error objects before almost whenever
>> possible.  But I see now, thanks for the write up.
>>
>>>>>
>>>>> Thus, g_autoptr(Error) is rarely applicable.  We have just three
>>>>> instances out of >1100 local Error variables, all in migration code.
>>>>>
>>>>> Two want to move the error to the MigrationState for later handling /
>>>>> reporting.  Since migrate_set_error() doesn't move, but stores a copy,
>>>>> the original needs to be freed, and g_autoptr() is correct there.  We
>>>>> have 17 more that instead manually free with error_free() or
>>>>> error_report_err() right after migrate_set_error().
>>>>>
>>>>> We recently discussed storing a copy vs. move the original:
>>>>>
>>>>>      From: Peter Xu <peterx@redhat.com>
>>>>>      Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
>>>>>      Date: Mon, 17 Nov 2025 11:03:37 -0500
>>>>>      Message-ID: <aRtHWbWcTh3OF2wY@x1.local>
>>>>>
>>>>> The two g_autoptr() gave me pause when I investigated this topic, simply
>>>>> because they deviate from the common pattern migrate_set_error(s, err)
>>>>> followed by error_free() or error_report_err().
>>>>>
>>>>> The third one became wrong when I cleaned up the reporting (missed in
>>>>> the cleanup patch, fixed in the patch I'm replying to).  I suspect my
>>>>> mistake escaped review for the same reason I made it: g_autoptr(Error)
>>>>> is unusual and not visible in the patch hunk.
>>>>>
>>>>> Would you like me to replace the two correct uses of g_autoptr(Error) by
>>>>> more common usage?
>>
>> Works for me.
>>
>> Now I also think it should be good migrate_set_error() follow QEMU's Error
>> API design if we decide to stick with it freeing errors in such APIs.
>>
>> Said that, I wonder if you think we could still consider passing Error**
>> into migrate_set_error(), though, which will be a merged solution of
>> current Error API and what Marc-Andre proposed on resetting pointers to
>> avoid any possible UAF, which I would still slightly prefer personally.
>>
>> If we rework migrate_set_error() to take ownership first, then we can
>> naturally drop the two use cases, and remove the cleanup function.
>>
>> Markus, please also let me know if you want me to do it.
>>
>>>>
>>>> I had previously proposed g_autoptr(Error) a year or two back and you
>>>> rejected it then, so I'm surprised to see that it got into the code,
>>>> because it requires explicit opt-in via a G_DEFINE_AUTOPTR_CLEANUP_FUNC.
>>>>
>>>> Unfortunately it appears exactly that was added earlier this year in
>>>>
>>>>    commit 18eb55546a54e443d94a4c49286348176ad4b00a
>>>>    Author: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>    Date:   Tue Mar 4 23:03:35 2025 +0100
>>>>
>>>>      error: define g_autoptr() cleanup function for the Error type
>>>>      Automatic memory management helps avoid memory safety issues.
>>>>      Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>      Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>      Link: https://lore.kernel.org/qemu-devel/a5843c5fa64d7e5239a4316092ec0ef0d10c2320.1741124640.git.maciej.szmigiero@oracle.com
>>>>      Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>
>>> I missed it.  Not he submitter's fault; it was cc'ed to me.
>>
>> If someone to blame, it's the reviewer.
> At end, I was the one who merged this stuff. My bad.
> 
> I felt confident at the time, as it was only a single-line change reviewed
> by a subsystem maintainer and the patch was large enough that this didn't

s/patch/series/ makes more sense.

Sorry for the noise.

C.


> raise my attention.
> 
> But it should have been treated with greater caution, global features must
> be introduced together with concrete usage proposals. I think this would
> have raised some unconscious red flags.
> 
> Thanks,
> 
> C.
> 
> 
> 
> 
> 
> 


