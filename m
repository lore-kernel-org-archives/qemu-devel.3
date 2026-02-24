Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66572E9B249
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 10:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vupxp-0005Mr-7M; Tue, 24 Feb 2026 05:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vupxi-0005KA-Lg
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vupxf-00044p-4M
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 05:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771930093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI0+FKAuy64qy7I8iClE651uCbkhETRDAcOhEnpyQ6o=;
 b=ZU8xrCmfJG3hhXbgELfgbgARESF4LStCHwZ5DmKDr5xbYFkVLBYcNlsifb4TlIPtXheZp0
 +boqOXAwhiN19qjZQi02XsDf+9ZCjpJeOUUrAKQGs8vbvtMeT2MIFyLQ0M7953pGy4U/5h
 9nsLPjW0S2sfqCFWGSYYfrLpaYO1YNk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-W-s-or2FOmu1NruL_bHDeg-1; Tue, 24 Feb 2026 05:48:11 -0500
X-MC-Unique: W-s-or2FOmu1NruL_bHDeg-1
X-Mimecast-MFC-AGG-ID: W-s-or2FOmu1NruL_bHDeg_1771930091
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso40345665e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 02:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771930090; x=1772534890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fI0+FKAuy64qy7I8iClE651uCbkhETRDAcOhEnpyQ6o=;
 b=F+H5BtTS5nW3tYvjsULl45in7uwi90eQiqAf6eNSzL6MvmJTi6gHI47ZdWcJJQH9TF
 Cn80uKa5ejvbt+wKs+IxQsbRnWt6h9U0fwfJK6kbIcb9NTmrx4GUXNhEdvG7I+rXN+5v
 aMQbZwHisEu08dE3jGVmAczbqok65vLe/JcN2aOdeQEphEpFsw60Q9s5HMX8gaVkxhyk
 gY3kku2nSqmCh6BXB0WMsRRZkYXyO8nHzEroiB05xmg84G8Or0l62IZg/ry/JoSa+qIf
 X2chcTthkebSh18btBN6+Z/FusYL4ZF2MfkyK5G9+A5Z4ZGnSxAY1VEviPe6fl4XDno9
 e0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771930090; x=1772534890;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fI0+FKAuy64qy7I8iClE651uCbkhETRDAcOhEnpyQ6o=;
 b=XbtK1ii51jVjgEYfb7y88XyuUvSgAHtEEKHYILvPaC/wbrGxhA+IE7NSJRD3hdQ78R
 aKnFsUmmrsLNhtgCBqhytdJBS9CrHbZpAF6SMSLRMn2Vv8T/KJL4MYSkuvP+KSemuulO
 4FI//TI7ovG1gcwCUQ4duqu23cgPtyfGnXH1f7I1XzZBMmzgEd4tqVWdCYSfjdHyhjIs
 9bY0fHcctTDXLAF+LCM6yUgXFEyui4x10NWORfmglRDocsr+iMIxl05vuYKgTxL/t1dH
 pbVBwfK8P0hPZSLFy2VGiLGWulUiaN5MD3LbBNONU2EipzzUoQ04PqddyZCRdQuTWRQD
 fgUw==
X-Gm-Message-State: AOJu0YzJOjkgVtPVXN0DsmQUtyv2KFX/9JnvanExb4Z5lhAUIA9sI0uX
 RrgS/h0lR7nvOeHb7IWTbKWtP73HWdN8mAd3wUtgiEZb9d7867KMZtn+iz8e+Dxvk+iGdwn49GJ
 O13MBLAbGabd+Ybxa2DHexIhXpZSRajiWWsryA8tDtbxvrSE3qdDdyXCa
X-Gm-Gg: AZuq6aKEoKzuIsLRIpDd/440Levt/8y/iYq9E5ZbVJOFia6NkxtzruVsNYa7lvrpmfT
 jGSnfr7Fn/nYuq8iOcVc5FzmySlKksF8qlEmdBkyPnuMKAQZARIoFeNuSCXrCBcg/n7agp8bQpI
 EqNYnRD86qZL1rkNf3rD+ZAOUTjYSHt0p1dOJQYxoalD44dSIAqsir/De2xJyOR2hGBfXNm8myd
 6Zb4SDbmw/cRXm4lK491TSKl0gKCbuoAc2m7MvI0sdQi3Pztb8D3t5kUs0++sdib2LaWnY1HnMB
 wO/7IqZvbRkSmnWqmG05516eNTpBKgBnHwcqWBwx8H94atvX/zeF7ry/Hj8uJrvhjA/qvpYJ8Ky
 /7iKukReHSOkTpE/p9rTeDMPyTRmfvtd1K11rEW6zWrpJzu1GWycc1NyyWhHI2/JPHuKvVyINMp
 Si9LYx99N/WNif+cc+KKAYbAx1dJo=
X-Received: by 2002:a05:600c:6298:b0:480:3bba:1cac with SMTP id
 5b1f17b1804b1-483a95eb81fmr179791005e9.6.1771930090558; 
 Tue, 24 Feb 2026 02:48:10 -0800 (PST)
X-Received: by 2002:a05:600c:6298:b0:480:3bba:1cac with SMTP id
 5b1f17b1804b1-483a95eb81fmr179790725e9.6.1771930090070; 
 Tue, 24 Feb 2026 02:48:10 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483a9b75b4dsm426146145e9.4.2026.02.24.02.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 02:48:09 -0800 (PST)
Message-ID: <a7521b49-432a-4e60-8446-93338c61caff@redhat.com>
Date: Tue, 24 Feb 2026 11:48:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] rust/qobject: add Serialize implementation
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-4-pbonzini@redhat.com> <87ecma4ep2.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87ecma4ep2.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/24/26 11:29, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> This allows QObject to be converted to other formats, for example
>> JSON via serde_json.
>>
>> This is not too useful, since QObjects are consumed by
>> C code or deserialized into structs, but it can be used for testing
>> and it is part of the full implementation of a serde format.
>>
>> Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> [...]
> 
>> diff --git a/rust/util/src/qobject/serialize.rs b/rust/util/src/qobject/serialize.rs
>> new file mode 100644
>> index 00000000000..34ec3847c1d
>> --- /dev/null
>> +++ b/rust/util/src/qobject/serialize.rs
>> @@ -0,0 +1,59 @@
>> +//! `QObject` serialization
>> +//!
>> +//! This module implements the [`Serialize`] trait for `QObject`,
>> +//! allowing it to be converted to other formats, for example
>> +//! JSON.
>> +
>> +use std::{ffi::CStr, mem::ManuallyDrop, ptr::addr_of};
>> +
>> +use serde::ser::{self, Serialize, SerializeMap, SerializeSeq};
>> +
>> +use super::{match_qobject, QObject};
>> +use crate::bindings;
>> +
>> +impl Serialize for QObject {
>> +    #[inline]
>> +    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
>> +    where
>> +        S: ::serde::Serializer,
>> +    {
>> +        match_qobject! { (self) =>
>> +            () => serializer.serialize_unit(),
>> +            bool(b) => serializer.serialize_bool(b),
>> +            i64(i) => serializer.serialize_i64(i),
>> +            u64(u) => serializer.serialize_u64(u),
>> +            f64(f) => serializer.serialize_f64(f),
>> +            CStr(cstr) => cstr.to_str().map_or_else(
>> +                |_| Err(ser::Error::custom("invalid UTF-8 in QString")),
> 
> .to_str() fails when its argument is invalid UTF-8.  It returns "an
> error with details of where UTF-8 validation failed."[1]
> 
> Why are we replacing this error with a custom one?  I guess we add the
> clue "in QString".  We also lose the details of where.  Feels like a
> questionable trade.

Changing the error is required in order to return an S::Error (that is, 
the serializer asks for a type of error that it understands).  I can 
also preserve the message with "|e| Err(ser::Error::custom(e))" or 
something like that.

While it is undoubtedly a programming error, I didn't like that the 
error (and thus the panic) happens in a different place than where the 
QString is constructed.  I like panicking for *my* programming errors, 
but not for someone else's :) especially if I can recover easily.

Paolo


