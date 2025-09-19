Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D102CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYiZ-0001mi-Pp; Fri, 19 Sep 2025 06:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzYiY-0001mW-Qz
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzYiX-0007L2-1o
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758279110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aOd3H3wVyzzvG8PflK7HM6CIalL5qe95eFGmZPrwEuU=;
 b=XujspDcIBvwik1jwCqCELnu83P9a5lqM2QyeVLHUFdTe092AieHd3cku5hgDKlo2u6M1yD
 OE2ZkvGFpL9Fr8HU5rsSlgTGiaf7oZ24AxOYsB2xbo5jp/Ff+8VN2DQ3T2w/TygHZLQ/Wr
 BvHQZc07rlGI2fWJjEUex39Jt+d2RqE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-IsfOhcu0OeG1ntbe_Xq1mA-1; Fri, 19 Sep 2025 06:51:49 -0400
X-MC-Unique: IsfOhcu0OeG1ntbe_Xq1mA-1
X-Mimecast-MFC-AGG-ID: IsfOhcu0OeG1ntbe_Xq1mA_1758279108
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b2358a0bd08so116926266b.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 03:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758279106; x=1758883906;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aOd3H3wVyzzvG8PflK7HM6CIalL5qe95eFGmZPrwEuU=;
 b=b9UcWF/w5QAihR6Gx1ZQcPjVdvisWYUBr4qQVixhXTSKM3xlqdcOFjG/XNudWma+b5
 qTjh1p2NkfECfpCEQ1KlO1fYPD8ozKB7aQ0SGSOcP8IVfAqhbW4mQNfYJmjdSBmchlR1
 BSmZOkB+zWp4ngpmqE00L7B6UeWWZg53ypDcjhRmqFkB36JQv5cQs+QGZM1Gi0AU57Tp
 MDoM7G33tT+vpavtV1XDO42RUPwD44C7MYDtjCtQ02QlW0eZllAfDnZvvqy5C//X9zoe
 PAH+E7+VP/FVnDn49JOzM9Q1gbTCWn2wwiG80yXPVaglLfjlmvqJt/M9v82nja/ynUY9
 Hg5Q==
X-Gm-Message-State: AOJu0YyLwQEu3nt3JUfg6hNRaCpjq5la4LiLA6LeQFMcRT+Lel2M+upg
 TUPKrtQA5apbacAZWGNXHmR20UAA+T4K39KMH7UmWN78lAFxKOQnTfA/RHBlXZGlc8imLxxx5Bx
 azZis1Jd+2GKJDMu13SNrcz6uBS9p7yD8/X0m2x4W9EHE4bEPeobQRrDB
X-Gm-Gg: ASbGncvGZqrxnvQJmv74GhnKUXkBVo0ZJ+aaqczCatyUlhWdOkRVgTPkcjzB2RoLJwo
 s/wfq/WEJgw2Pei+z0lIad8a9rX93UXYSuFlod9x7ByuQi7RV92MFVQb+zQj7cMjasiv0UHM5yK
 /G7BeVUBCaiOCInYvGCZEzHXJoHKBtd5cPj72hdIRpgopTgFJoHi4Gzrek1iw3gPPnNvnbWTa78
 jSxXlOF8DIe2W3gq6MoLZhVU4gZ5Xbehe2cN3vB6TEwRTVgWZdlJjRMIAJq251ZJaIbPomoziqr
 DydWEl71Yf9v9h7LZ7kBWcBevQm7F420+qJZZYVUphH65OY1RX1slmcwXVH+m9ZyHIMUm082SzV
 /YD2V7MeRN6CUqE3pMowPTdQuQ12jd+VjYVyi+iGmWJb9g14OVuB5Xltv53VxpUQ0XjsMVqFvCL
 7GV8pC
X-Received: by 2002:a17:907:97d4:b0:b07:b782:51cc with SMTP id
 a640c23a62f3a-b24f66e5a01mr243351466b.64.1758279106365; 
 Fri, 19 Sep 2025 03:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaS24qxOI6YRtIR3lDRiuRteExeXUqVEswsPkI8wJtjfKGsjRVFkkxzRxVQfqTUWZr/cX+fQ==
X-Received: by 2002:a17:907:97d4:b0:b07:b782:51cc with SMTP id
 a640c23a62f3a-b24f66e5a01mr243349666b.64.1758279105916; 
 Fri, 19 Sep 2025 03:51:45 -0700 (PDT)
Received: from [10.108.146.123] (93-45-222-212.ip104.fastwebnet.it.
 [93.45.222.212]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b2636394e32sm86134366b.16.2025.09.19.03.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 03:51:45 -0700 (PDT)
Message-ID: <3b63b2de-20ff-4107-8a85-eaa26f6f5ea5@redhat.com>
Date: Fri, 19 Sep 2025 12:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] tracetool/simple: add Rust support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 mads@ynddal.dk
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-11-pbonzini@redhat.com> <aK2gTWBwHpOY4iwm@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aK2gTWBwHpOY4iwm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/26/25 13:53, Daniel P. Berrangé wrote:
> On Fri, Aug 22, 2025 at 02:26:51PM +0200, Paolo Bonzini wrote:
>> From: Tanish Desai <tanishdesai37@gmail.com>
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   scripts/tracetool/__init__.py       |  2 +-
>>   scripts/tracetool/backend/simple.py |  7 +++++
>>   tests/tracetool/simple.rs           | 41 +++++++++++++++++++++++++++++
>>   tests/tracetool/tracetool-test.py   |  2 ++
>>   4 files changed, 51 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/tracetool/simple.rs
>>
>> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
>> index 0b8ec707332..7542757799e 100644
>> --- a/scripts/tracetool/__init__.py
>> +++ b/scripts/tracetool/__init__.py
>> @@ -336,7 +336,7 @@ def rust_call_extern(self):
>>           def rust_cast(name, type_):
>>               if type_ == "const char *":
>>                   return f"_{name}.as_ptr()"
>> -            return "_{name}"
>> +            return f"_{name}"
>>   
>>           return ", ".join((rust_cast(name, type_) for type_, name in self._args))
>>
> 
> This should be squashed into the earlier patch that introduced the mistake
> 
>> diff --git a/tests/tracetool/simple.rs b/tests/tracetool/simple.rs
>> new file mode 100644
>> index 00000000000..895096088dc
>> --- /dev/null
>> +++ b/tests/tracetool/simple.rs
>> @@ -0,0 +1,41 @@
>> +// This file is autogenerated by tracetool, do not edit.
>> +
>> +#[allow(unused_imports)]
>> +use std::ffi::c_char;
>> +#[allow(unused_imports)]
>> +use qemu_api::bindings;
>> +
>> +#[inline(always)]
>> +fn trace_event_get_state_dynamic_by_id(_id: u16) -> bool {
>> +    unsafe { (trace_events_enabled_count != 0) && (_id != 0) }
>> +}
>> +
>> +extern "C" {
>> +    static mut trace_events_enabled_count: u32;
>> +}
>> +extern "C" {
>> +    static mut _TRACE_TEST_BLAH_DSTATE: u16;
>> +    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
>> +}
>> +const _TRACE_TEST_BLAH_ENABLED: bool = true;
>> +const _TRACE_TEST_WIBBLE_ENABLED: bool = true;
> 
> Does rust have any policy reserving use of leading underscore in
> identifiers  ?
The leading underscore suppresses warnings on unused symbols.  Which 
indeed these two are, so I'll drop them.

Paolo


