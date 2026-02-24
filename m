Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2EDE9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 10:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuplf-0002Sz-5Q; Tue, 24 Feb 2026 05:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vuplY-0002Rt-CH
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vuplW-0001SA-Ov
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771929336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqFJfQHPbulPlJYBrN55uvOiR5BILMKoAp+8A07i238=;
 b=UAK6x+sRpuKzzz+WJc3mi/kiVzaIiWnHk5odGxshbqbCUSNowosBPVccmO96AWtSduCdhr
 RMcnA3AY2PIcjl7SYRjUInJjEwCAv7sD4Rlqj0XRSDwgvWlnRzbNBqp3vEq1E87OY+A6cL
 66zRmDl/GNEh5mkk50gzZxFXrlSdiAY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-gWpRJFK0NeqRcWvbFog1sQ-1; Tue, 24 Feb 2026 05:35:34 -0500
X-MC-Unique: gWpRJFK0NeqRcWvbFog1sQ-1
X-Mimecast-MFC-AGG-ID: gWpRJFK0NeqRcWvbFog1sQ_1771929334
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-65bf3ab6e7eso5287016a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 02:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771929333; x=1772534133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xqFJfQHPbulPlJYBrN55uvOiR5BILMKoAp+8A07i238=;
 b=ZPdWfBL/ynIz1EYvm69Qt3529tFOsCmwYgBpnEdC00bAnIm913U1DVtaCu13mFRkR1
 EWVjj/2SQacFcmzv+5MmocG52Tfh4fHztlqKHFxfhUMOWkhjXnc6uTjD3Mx+BsjLt+aC
 GnYJqAAtrJHj0TXlqmZTfq+/JPOeOwCyb4l65TqBpvJ8i8tkztLk4G/FtJedb08ojcRy
 FvOfV5awo43xA//2V7Jx7+zQ52aG7YjThC8k8QaPenWBxdCcYTxt1ZPnbqHlv7uEjbw3
 BQsgE0qqg3/PjC+8om/dECsVmoy6QeZ8t2tmzmN6+soTWZxkO5VSeuczn5e1xIV9SunW
 hrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771929333; x=1772534133;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xqFJfQHPbulPlJYBrN55uvOiR5BILMKoAp+8A07i238=;
 b=YEUDLA6Th0kvU/V0auO+uKpaBKoJHX4tfARqw+eRVJlV47WOxGfRO0UDrYcneEOQ+o
 RzK2zCSi4gvDAFAKolMp/jpUKIi9nqOQ1Cl+HGLa/q2ppk+tvU1ldmn+BahpvbPxx2wc
 cOvIwNNOFxgCPc6gWdS91RZ4dZ0vKXWbibkRJ/keR3qC+81c/rjecSKDrDhG032jX5vH
 BhbxZ6Wfewt3TQ2V3GtG3lfBZanpYhL1qQPFSQU5d25GYzrw6hrQOp+30njWSlm1pJ2a
 QW+0bNItki/eJJpYJ3YN0Fjpb6DVdzpkNS+3IKFDDa2EvAPzJDSXY/8eSdrw/9D1MSVC
 9exg==
X-Gm-Message-State: AOJu0YxyGosUnvcrIEnf7lJT3Wov49Kn8PDC+zF6YuxauYSulxelvDXC
 6KIxfI6eHjArDEpE+bD+FApx8XnQeBCikXrmhJ/k7kCg5Jb/oKv+o3boI8ZzTNMLYGf7t500aDW
 Ok0YHz8WW2jOyCEmSE2l+ZQ0+nlJauV6Kz5ktKzi7czNnkTbPv9COzC3P
X-Gm-Gg: ATEYQzxJ9FmMEJSzmLcYbVagJpV2vuhy8RJtiAr+9ECzdPjm6qZYuYAHvbqCJpwtCvh
 5+s2UvaNFb8pEG/mVBLHdbG5C9Cye+PERl8b/B/75l0IoERU5lGvfsLyKfmStEFYEpIwRe1wI/E
 uh1ZGPZZAfiLpvwF/BSNFYLp2keCDmSHyZLIMIFEayk3fI0A5klu51RIgfhpvv095EXbT85xmEc
 XUK9YBC+jYXlbDWFoDXc7uB7nmlfUl8uqfSzRjZjHYMuO7KOmYL1hjmiKVn7pkFX238kLWVVd9N
 VMB76TQwAG3h4ul7OJLuP6TnRCzB9qenQ6k1yAXVJU+1C4+L2dz0XsDIlMbpMdhYJbbHVNbJNn1
 /VE/jJUK71bTmyqJdfA0tmCUF5Q41I8Ng+Cjv5o+Vcrxv4T+PLKPhiWZk29QfFKOjb6go6WZPL8
 VwU5Zb48rt3tHO64h9n3X3tJ7xtM0=
X-Received: by 2002:a05:6402:3645:b0:659:405b:547c with SMTP id
 4fb4d7f45d1cf-65ea4ef7b1dmr4804844a12.19.1771929333588; 
 Tue, 24 Feb 2026 02:35:33 -0800 (PST)
X-Received: by 2002:a05:6402:3645:b0:659:405b:547c with SMTP id
 4fb4d7f45d1cf-65ea4ef7b1dmr4804831a12.19.1771929333122; 
 Tue, 24 Feb 2026 02:35:33 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-65eab9a08edsm3327454a12.5.2026.02.24.02.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 02:35:32 -0800 (PST)
Message-ID: <58720d10-5613-4235-b47f-939e9a8d3096@redhat.com>
Date: Tue, 24 Feb 2026 11:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] rust/qobject: add basic bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-2-pbonzini@redhat.com> <87jyw24fw5.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87jyw24fw5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/24/26 11:03, Markus Armbruster wrote:
>> diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
>> index b9ed68a01d8..0907dd59142 100644
>> --- a/rust/util/wrapper.h
>> +++ b/rust/util/wrapper.h
>> @@ -30,3 +30,10 @@ typedef enum memory_order {
>>   #include "qemu/log.h"
>>   #include "qemu/module.h"
>>   #include "qemu/timer.h"
>> +#include "qobject/qnull.h"
>> +#include "qobject/qbool.h"
>> +#include "qobject/qnum.h"
>> +#include "qobject/qstring.h"
>> +#include "qobject/qobject.h"
>> +#include "qobject/qlist.h"
>> +#include "qobject/qdict.h"
> 
> Is this file just for bindgen, and never actually fed to the C compiler?

Yes.

>> +impl From<()> for QObject {
>> +    fn from(_null: ()) -> Self {
>> +        // Conversion of the C inline `qnull` function
>> +        unsafe { QObject::cloned_from_base(addr_of!(bindings::qnull_.base)) }
>> +    }
>> +}
> 
> Could we call C qnull() instead of using qnull_.base?

See v1 review - no, because qnull() is inline.  I can make it not 
inline, of course.

Paolo


