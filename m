Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93E4C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 15:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTi5-0004Qw-OX; Tue, 03 Jun 2025 11:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMThp-0004On-8L
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMThi-0000rc-Rr
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748965049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ORDKkRLt5CXYKAw38kXIYLObiqPZ4wLvJo6OY1BWUGQ=;
 b=aToXkJWrQkaBydIeVIv/ShD4Mn78/ofwhQBXYgtSgHOHhYZB0OscSbCfgqH3dYwelP3i4h
 NwecodzZgoOrpbbXeGRPOe1N15cCqzn9PfwSLQqOYQh+5agroNn7OsAWiblG9DXNgwYujD
 a6IXzDEXBCVaLqFrZEIIfv5RJMgfjbo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-KFhRROAoMYqhwkI-dP-ubw-1; Tue, 03 Jun 2025 11:37:26 -0400
X-MC-Unique: KFhRROAoMYqhwkI-dP-ubw-1
X-Mimecast-MFC-AGG-ID: KFhRROAoMYqhwkI-dP-ubw_1748965046
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4ee113461so1889219f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 08:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748965045; x=1749569845;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ORDKkRLt5CXYKAw38kXIYLObiqPZ4wLvJo6OY1BWUGQ=;
 b=oOWU5XATMsMYs0ucn1CTOCsYVhkB8/Py6VYbnhzPnFFqccxYy3f0htOc17CsjHWXgp
 UYP93EMGU4CaS4n/Hg43gsNAmmjjRCOHwaCAywx/IoYUkqNA7PDhL86f9QM/FO1xa4EF
 WquHiTDBEiA1zlU8GyWO6s+vr0Vs6AiIxFEwkvAA8coKuGxGOHuyJ6Rph/FUCVNA5Om1
 ps430dQKpE2BIqaADnjm9Hc902ZGu43oNy60Zl/nJ/UQVnUkFd9Y363Omvt/ErQ09XX5
 sC9RWwL0TwzqbBrZ17m5Eiu17JdYfnvax7Sy5qOGfUAEcZ04OA4JzqXOtrR1mY4Q1/Lv
 upBA==
X-Gm-Message-State: AOJu0YxOwn/DFawiJTJg1KHF2oyhY6QMwbqUEggwFjHQ1r5X4aD4DYlh
 g6BR/K2NaqJhwACAz2K/9Ph2RXOjsVpGbu/qtR38TqES6KuLYZC/UvxE0c4tiWmKVdlFV5tc1jD
 pKtUv2nDpArZz4HjduVsLL4JCcnnsCKIlXFpqitIWAYZ22iw50EO1l/q7
X-Gm-Gg: ASbGncsegiKMw6JIMyGUaZp0aDJtXas7DzvdyrSrKU3Sz1SBSiOlDQKkPvr757D5dkA
 W3iVoDhn4RSEPuOLy6DqPBn+rRb2TPKzQ+8be8j1Jduxr9HeS3L03eX05F2Su/w8Rn8gqYHbojW
 I7C8TFx7vu/OKk/TCbQYyrlsEHwHBDGOzTsdHl/hr/gYsiBDTnaFIr6qcYpp4aOrMcPg0YDntsU
 4yU9XnVfP8kpVFAH6RrZ4TMwzl8loBlMUN0gjLgicaYw9fFic5YgXJn+5QcaXlMNv90P6rQ80tH
 KO/blM/885H/GWjJHKP05mH+
X-Received: by 2002:a05:6000:381:b0:3a4:eb0c:4087 with SMTP id
 ffacd0b85a97d-3a4f89c006dmr13626255f8f.25.1748965045423; 
 Tue, 03 Jun 2025 08:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs1SLQ4Hvy/PvqhV7UqJ02Pw75SKke3J7AbV1AKR414oYaPQszxykUQZMQl7LrDF50TfDS8A==
X-Received: by 2002:a05:6000:381:b0:3a4:eb0c:4087 with SMTP id
 ffacd0b85a97d-3a4f89c006dmr13626227f8f.25.1748965044995; 
 Tue, 03 Jun 2025 08:37:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c4f2sm18405413f8f.22.2025.06.03.08.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 08:37:24 -0700 (PDT)
Message-ID: <dcfbbfbf-84d9-4970-95db-86e27efc9477@redhat.com>
Date: Tue, 3 Jun 2025 17:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] rust: qemu-api: add bindings to Error
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-7-pbonzini@redhat.com> <877c1uffj3.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <877c1uffj3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/2/25 15:18, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Provide an implementation of std::error::Error that bridges the Rust
>> anyhow::Error and std::panic::Location types with QEMU's Error*.
>> It also has several utility methods, analogous to error_propagate(),
>> that convert a Result into a return value + Error** pair.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> [...]
> 
>> diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
>> new file mode 100644
>> index 00000000000..0bdd413a0a2
>> --- /dev/null
>> +++ b/rust/qemu-api/src/error.rs
>> @@ -0,0 +1,299 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +//! Error propagation for QEMU Rust code
>> +//!
>> +//! In QEMU, an `Error` usually consists of a message and an errno value.
> 
> Uh, it actually consists of a message and an ErrorClass value.  
> You completely ignore ErrorClass in your Rust interface.  I approve.
> There are convenience functions that accept an errno, but they don't
> store the errno in the Error struct, they append ": " and
> strerror(errno) to the message.  Same for Windows GetLastError() values.

Good point - bad wording choice on my part.

I was referring exactly to the construction: whereas C constructs an 
Error (for convenience) from a message and an errno, Rust replaces the 
errno with an anyhow::Error.  The function however is the same, namely 
to include the description of the error when it comes from code that 
doesn't speak Error*.

>> +//! In this wrapper, the errno value is replaced by an [`anyhow::Error`]
> 
> I'm not sure the anyhow::Error replaces anything.  It's simply the
> bridge to idiomatic Rust errors.

And errno is the bridge to "idiomatic" C errors. :)  But I agree that it 
should not be mentioned in the first sentence.

>> +//! Note that the backtrace that is provided by `anyhow` is not used yet,
>> +//! only the message ends up in the QEMU `Error*`.
>> +//!
>> +//! The message part can be used to clarify the inner error, similar to
>> +//! `error_prepend`, and of course to describe an erroneous condition that
> 
> Clarify you're talking about C error_prepend() here?

Yes.  But I'll rephrase to eliminate this reference.

>> +impl std::error::Error for Error {
>> +    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
>> +        self.cause.as_ref().map(AsRef::as_ref)
>> +    }
>> +
>> +    #[allow(deprecated)]
>> +    fn description(&self) -> &str {
>> +        self.msg
>> +            .as_deref()
>> +            .or_else(|| self.cause.as_deref().map(std::error::Error::description))
>> +            .unwrap_or("unknown error")
> 
> Can "unknown error" still happen now you dropped the Default trait?

No, but I prefer to limit undocumented unwrap() to the bare minimum. 
I'll use .expect() which also panics on the unexpected case, but 
includes an error.

>> +    }
>> +}
>> +
>> +impl Display for Error {
>> +    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
>> +        let mut prefix = "";
>> +        if let Some(ref msg) = self.msg {
>> +            write!(f, "{msg}")?;
>> +            prefix = ": ";
>> +        }
>> +        if let Some(ref cause) = self.cause {
>> +            write!(f, "{prefix}{cause}")?;
>> +        } else if prefix.is_empty() {
>> +            f.write_str("unknown error")?;
> 
> Can we still get here now you dropped the Default trait?

Same as above.

> Uh, is it?  Let's see...
> 
>> +    /// with the information container in `self` if `errp` is not NULL;
>> +    /// then consume it.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `errp` must be a valid argument to `error_propagate`;
> 
> Reminder for later: the valid @errp arguments for C error_propagate()
> are
> 
> * NULL
> 
> * &error_abort
> 
> * &error_fatal
> 
> * Address of some Error * variable containing NULL
> 
> * Address of some Error * variable containing non-NULL

I will add this note.

> What does errp.write(err) do?  I *guess* it simply stores @err in @errp.
> Matches neither behavior.
> 
> If that's true, then passing &error_abort or &error_fatal to Rust does
> not work, and neither does error accumulation.  Not equivalent of C
> error_propagate().
> 
> Is "propagate" semantics what you want here?
> 
> If not, use another name.

As replied elsewhere, yes.

Paolo


