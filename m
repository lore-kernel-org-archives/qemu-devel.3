Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10A8D3C928
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 17:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTNzB-0007QZ-Uv; Wed, 10 Dec 2025 12:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTNz8-0007Q5-2u
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:28:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTNz6-0000zF-0X
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765387694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=seOC9xRpd8BpHlM1BeEq/huCWh/CEHy2JsXLZ/0hH9w=;
 b=Gjwm1uF7VPJv3OK7R0oFSaLvm6poH/PXFu5y76KLGSf49fflaCGEyRSzdsoJiNCBFJBw/3
 PcRQLIPBraRcGPBwiBZEYnPOCZJxFoV24bV30gBlVWWA+FqRWTI7V2GjQF+4Rs+eS+dACn
 Fb9IfiCIWTW5vahZyErTR+/bLKTUT6o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-WFQTQuhpMnyLAK9HAgdtbQ-1; Wed, 10 Dec 2025 12:28:13 -0500
X-MC-Unique: WFQTQuhpMnyLAK9HAgdtbQ-1
X-Mimecast-MFC-AGG-ID: WFQTQuhpMnyLAK9HAgdtbQ_1765387692
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42e2e5ef669so4628f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 09:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765387691; x=1765992491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=seOC9xRpd8BpHlM1BeEq/huCWh/CEHy2JsXLZ/0hH9w=;
 b=ZI08+lhgc/UCXElXLLeLuKGcquw3roZ2YkQcqoBn1PlDSh3nUBJo7fh1yjmWsjodAp
 Z3CxtsKl/88ECBFDruyO1W1KcKjDRvII9qf6JNP1j8LcYt+oIcPWlmJxlDZcZiXGlHMy
 Byx56+EP5sk8V01oyOcGftrJK15dhEDzJmFrMg/dGNKa9WJu4e43BC+our8qTV56m2JM
 cNxiOOLe3wyVSNX9sinWYvdpOWNsBQnXqtLfNKg4vQq9JdVKcYRfW6BDHdIuWnM6/ov6
 tLkUaauaDXX794cYSMVPB2cgKy2vVG0CKBd7iLur4ZXWfThLKehpvVjnUWGXiPHDYSK7
 OOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765387691; x=1765992491;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seOC9xRpd8BpHlM1BeEq/huCWh/CEHy2JsXLZ/0hH9w=;
 b=ACaK6FfJ9kC6i1A5E31vbb8fXm/zsjL7XraQ9RYXH83c9iUc2GiVhzsdIli84fZ9lh
 EesTlYzi8o+iRwYMDGGIWQO6KWMMjlKM0r2EVvihcqItQ7KeYP59BUOw0rnMNbqSt2X4
 x8S99QZnamypbSP2Sw8dauAdruumxreV0JFh2+5qbBEVPsXxN0cKGakv+czanjSSvEgB
 6CKRy6tCt71Zkr/gZCyEBsd5wI1+V5oT0ikz6eoa5tFwlz0/TFARyA8D2rFxGA96YDIM
 jQBCEurSrSuuXIb/kIm5AnOre5ua4KTkGNxqfouZeZqys6/QCWkzVZP3h8pX/6J/kMk9
 uBkQ==
X-Gm-Message-State: AOJu0YydEgYC7HmotDsZW5XbYea5I106lbiViLa7jZD3pVQle8gDB/fj
 GZ4F+mMylmBW6CYbHJmkylPTKG+o12AkLOxoYOiGLGkqItsTfQmNC6r/WLxeww53srizWKY/6Kc
 m1pQzxOdHOK8hzFR4lawFlWGDNIMAte9CVyf7xPmw7dIqeKAtulAa++N1ozzY9tpr
X-Gm-Gg: AY/fxX7Oa6F1mMXS1OCMPkd1vaExRkO7+L+8l9tvvXDfzyZz2tJ59HEiQ4doIvFl7sk
 +vZwZpmCCgaY8vr0gdZdVS4KuW9evvEajnhaPe/P72mnj/a2HWSJGSNfIVSuP1x7LfLvf/2Axkx
 9ipP9ov3ksfRQ3NRznDWOBcNBkL1YbwaiJ9KvroW/qqcnWr1ztoPibqmkmo3j66qtdeBWsmBC2e
 ESBDB/shuQ9kKyE6lMysp1+H4i6BZw+TCqAyES6JFNRz+KQV2Hl5o7bktYzFOXGU9EIxxo2vRSR
 pNpDgtN+flILp+J9Yi9nUPN/LpnQYiEG98FjM5DriuAIIKp+1GiaEO/zFIEPSk3tU5hvAhzfriI
 WPsoxAilqXqlrHk+eRqpeoaqEcjjs/4NfmNDdUmmncBG9rA9YZtmJ0KGR341449gcUjJJjmlz5L
 OQR4EAH/UKsoS0G1o=
X-Received: by 2002:a5d:54d1:0:b0:42b:300f:7d8d with SMTP id
 ffacd0b85a97d-42fa3afe612mr2263737f8f.34.1765387691375; 
 Wed, 10 Dec 2025 09:28:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPxZmF/tQg9EWhcRSsJu5G7NLxSNy3ZzJzMz5UvsZwSNpc1YMwxDvZ8HoZBwyBbB1+Nop+Hw==
X-Received: by 2002:a5d:54d1:0:b0:42b:300f:7d8d with SMTP id
 ffacd0b85a97d-42fa3afe612mr2263721f8f.34.1765387690910; 
 Wed, 10 Dec 2025 09:28:10 -0800 (PST)
Received: from [192.168.10.81] ([151.95.145.106])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85fcesm149592f8f.25.2025.12.10.09.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 09:28:10 -0800 (PST)
Message-ID: <cf58760b-db53-4201-b75d-40f94ce2c543@redhat.com>
Date: Wed, 10 Dec 2025 18:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] scripts/qapi: strip trailing whitespaces
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-17-pbonzini@redhat.com> <87jyyw59dm.fsf@pond.sub.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87jyyw59dm.fsf@pond.sub.org>
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

On 12/9/25 09:48, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> This help workaround a rustfmt issue.
> 
> Which one?  Pointer suffices.
> 
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Link: https://lore.kernel.org/r/20210907121943.3498701-16-marcandre.lureau@redhat.com
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   scripts/qapi/gen.py | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>> index 0c9b8db3b02..c9721545ea7 100644
>> --- a/scripts/qapi/gen.py
>> +++ b/scripts/qapi/gen.py
>> @@ -58,7 +58,11 @@ def add(self, text: str) -> None:
>>           self._body += text
>>   
>>       def get_content(self) -> str:
>> -        return self._top() + self._preamble + self._body + self._bottom()
>> +        content = self._top() + self._preamble + self._body + self._bottom()
>> +        # delete trailing white-spaces (working around
>> +        # https://github.com/rust-lang/rustfmt/issues/4248)
>> +        content = re.sub(r'\s+$', '\n', content, 0, re.M)
>> +        return content
>>   
>>       def _top(self) -> str:
>>           # pylint: disable=no-self-use
> 
> This doesn't just delete trailing whitespace, it also collapses multiple
> blank lines into one: \s matches newlines.
> 
> We lose the ability to generate multiple blank lines for all generators
> based on QAPIGen: C (.c and .h), trace events, Rust.  Hmm.
> 
> Is collapsing blank lines necessary for working around the rustfmt
> issue?
> 
> The generators other than the Rust generator do not emit trailing
> whitespace.  Would that be practical for the Rust generator, too?

The main source is stuff like %(cfg)s and %(serde_skip_if)s.  Rust's 
syntax makes it more natural to write in this style, compared to C where 
you have "#ifdef"..."#endif", but it results in empty lines.  I'll see 
if there's another way to clean up the output.

Paolo


