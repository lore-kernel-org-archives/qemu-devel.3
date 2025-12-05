Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C99DD2F7DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 11:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRThQ-00067P-2u; Fri, 05 Dec 2025 06:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRThO-000678-WB
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 06:10:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRThN-0001vR-1C
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 06:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764933003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1am0pbqYS0wn/lu64bTHfuueJm9zC4a4Vc+ditm+a/s=;
 b=aifbru1qyiUkIILgZAuRTCRVe8A/WUwJEi8aWskUfCeDWupoUVqW+fBXT0RFrEaqYniOi3
 zh/WBAuWdRLPGVlJW6fycJFwrYmabAwMWkHF9M4jJiRV75PU75hWmhiUHU9DQRAtu9of9B
 uMibXAePe3Ks3r6GGQZqQ9iw1XoOxm8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-of-g0-NcMQyWOD5pAZpkWw-1; Fri, 05 Dec 2025 06:10:02 -0500
X-MC-Unique: of-g0-NcMQyWOD5pAZpkWw-1
X-Mimecast-MFC-AGG-ID: of-g0-NcMQyWOD5pAZpkWw_1764933001
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso12743945e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 03:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764933000; x=1765537800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1am0pbqYS0wn/lu64bTHfuueJm9zC4a4Vc+ditm+a/s=;
 b=qqmtoaW8gOxuFrD+8YNVPTp6S64BIKwfTR/vKRdIwHF6qZAoAbKNJbCeNH11asjM3f
 Y5xUMi4/MurT1zO2Eh9uSnV36DPm2UObyPa98CyD2YoRnNOuQdB0dyDTS4HpdHOLI/Ph
 Y1fhpnUz8w5jSgi3w28iUWJcWEV71vXvPPYbwyEtBNsH429CNPzudvV5AtRtfKBEV1XT
 h6MrYC4z1TpWm+VxAoTQt06kJsxv8bBpd2Ura3yhgPtTniI5ZakBDC2/27L7HPf4NFNt
 RPDaK2M1b6H4cMeQPYr+Emu+WS89b7hLh0SwUqXIJrH3dz3EvBDMpgd1oqY9rfN8ugJc
 LFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764933000; x=1765537800;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1am0pbqYS0wn/lu64bTHfuueJm9zC4a4Vc+ditm+a/s=;
 b=JQ6Dj3lU2C4zLnqrmTVd/h/HDcQ8YVDVT0K2zvTMTzAWZ2+M7uA9FWmmMRIf/7TP1L
 +Ony1GS0gkUkj1vqPayBGnICbPNfS8xPQxLYcUdVFhvnfgw9NBkVEbZBtJbmzTJ7ywBw
 /Khch2mpJzIF3uN8kOu7cWg9gnKFrW+Ej7vCLqzfSg8GOtOMmlr6os8JTYsK0Dm92XGB
 oVQzfmBSlL/Ym/GYer4b0wsHGYtfT8fgRA5GkE2QO/ORPgEvHzC6HC5YnxUzOJBRxWZX
 +wRRYMp+uKTZLHii84NzZlookq2AqfzbXWJGtO0y9CXQ5ExtNb14ycTt93/bJsnQ+++5
 gFFQ==
X-Gm-Message-State: AOJu0Yz/Rsmgm1t9qhEDZoxuchwyVNuBUAPWZGw/c+lTbFYG/XZbl0/E
 GEpr2Pm/3CLh4RLR83uc1PtVoyBqk0Xm8jacUdxr1nazo7GugczzX4pGTyjmmQufoGRKwHj7jZ8
 Zaa/iJfEu7fxdYN0UdkhDQIeknuHBGdRtFMINoGCVNPl1N/gCKQPTW8L7m4vFWbYE
X-Gm-Gg: ASbGncvTSX0Y1LNwDmPCY5K/9s2TFSctLoRqP0gOfI23kHXzJySxXle8br5xl7ihCq5
 dhMakkkWspJ1yvc48ebplLX1I7HFCs4fKb7QfeUp0eFQeU/gESZeetQra9pIBgvp4w5AsF1/nZY
 UnQAtqCyNFnSq/dYhdYg5KX8mF95d33yVPO2uUVTRo2LwbcCYwlOegBlHeeW0aCQET6L/sJdidR
 nSXLXhCR1uBzUucNlQtGWjvdLYFSkYJu+Usxy5VMhBdkW9AmWtpVjcPxKzXv9HGPxoRIqnVucF3
 m/RtWix51vDZ++qVndaI3ydgq/GeGHV82cF0snqsU1wxh9mx2viyP0TXMritn5nfaMWURjNTNsK
 S2VkOZzDNuHJylMNJlhz5OI2Cx9YvXyz9QyKXs0ZqK4kdkFCSYHC1588IhAbpMHZLd/lHxBmLrB
 +P/VCH4UMiwJjjdtY=
X-Received: by 2002:a05:600c:4e8a:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-4792f395ac9mr62402415e9.26.1764933000607; 
 Fri, 05 Dec 2025 03:10:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6tqYZ2pxlpF71XpVdcdiacYfGxB79aPZ15tEYIYrtZ4ZJuhCCt9Fbv2r8srbiB0X243zZgw==
X-Received: by 2002:a05:600c:4e8a:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-4792f395ac9mr62402175e9.26.1764933000229; 
 Fri, 05 Dec 2025 03:10:00 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm21910995e9.0.2025.12.05.03.09.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 03:09:59 -0800 (PST)
Message-ID: <21a2d5fb-0181-4ce8-8bea-a214c8eac2d7@redhat.com>
Date: Fri, 5 Dec 2025 12:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/19] rust/qobject: add from/to JSON bindings for QObject
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-12-pbonzini@redhat.com> <875xal5jnv.fsf@pond.sub.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <875xal5jnv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 12/5/25 11:04, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> These are used by tests.  However it could even be an idea to use
>> serde_json + transcoding and get rid of the C version...
> 
> Tell me more!

QEMU's JSON parser produces a QObject.  To obtain the same effect, we 
can take JSON-string-to-serde deserialization (implemented by 
serde_json) and attach it to serde-to-QObject serialization (the thing 
in patch 5).  That results in a JSON-string-to-QObject function.

Doing it in the other direction (QObject deserializer + JSON-string 
serializer) produces a QObject-to-JSON-string function.

For a little more information see https://serde.rs/transcode.html.

Note however that there is no support for push parsing, therefore this 
would not replace the balanced-parentheses machinery in 
qobject/json-streamer.c, and therefore QMP would still need a minimal lexer.

Grr... I just remembered about interpolation :/ so no, we still need a 
parser for libqmp.c.

Paolo

>> Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   rust/util/wrapper.h          |  1 +
>>   rust/util/src/qobject/mod.rs | 17 +++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
>> index 0907dd59142..c88820a5e5b 100644
>> --- a/rust/util/wrapper.h
>> +++ b/rust/util/wrapper.h
>> @@ -37,3 +37,4 @@ typedef enum memory_order {
>>   #include "qobject/qobject.h"
>>   #include "qobject/qlist.h"
>>   #include "qobject/qdict.h"
>> +#include "qobject/qjson.h"
>> diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
>> index e896aba5f3a..292a3c9c238 100644
>> --- a/rust/util/src/qobject/mod.rs
>> +++ b/rust/util/src/qobject/mod.rs
>> @@ -23,6 +23,7 @@
>>   use common::assert_field_type;
>>   pub use deserializer::from_qobject;
>>   pub use error::{Error, Result};
>> +use foreign::prelude::*;
>>   pub use serializer::to_qobject;
>>   
>>   use crate::bindings;
>> @@ -111,6 +112,22 @@ fn refcnt(&self) -> &AtomicUsize {
>>           let qobj = self.0.get();
>>           unsafe { AtomicUsize::from_ptr(addr_of_mut!((*qobj).base.refcnt)) }
>>       }
>> +
>> +    pub fn to_json(&self) -> String {
>> +        let qobj = self.0.get();
>> +        unsafe {
>> +            let json = bindings::qobject_to_json(qobj);
>> +            glib_sys::g_string_free(json, glib_sys::GFALSE).into_native()
>> +        }
>> +    }
>> +
>> +    pub fn from_json(json: &str) -> std::result::Result<Self, crate::Error> {
>> +        let c_json = std::ffi::CString::new(json)?;
>> +        unsafe {
>> +            crate::Error::with_errp(|errp| bindings::qobject_from_json(c_json.as_ptr(), errp))
>> +                .map(|qobj| QObject::from_raw(qobj))
>> +        }
>> +    }
>>   }
>>   
>>   impl From<()> for QObject {
> 
> 
> 


