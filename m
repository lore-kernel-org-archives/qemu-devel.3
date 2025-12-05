Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C11D2F7DD
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 11:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRTys-0002Vd-PS; Fri, 05 Dec 2025 06:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRTyl-0002V6-M6
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 06:28:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRTyj-0005FP-Sp
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 06:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764934080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3elSILCrnUUvEOvxtQ+/2L+9hNstJFqtaNLm9nLBghs=;
 b=VmskSINAMA31op46IhZ+ACvNAoUbxex126HEWVyZNikZ/JLFazEV9TmLeTHdmPB67cLhq5
 isldzUQPONTphciy/Eu5bSySIL6sZfyJ+nPxOYFTqVYGJNHfhmQMFGOtvowUFypIhab2uP
 98iVpGladRXttbvXJmDBUfB/rs81i6k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-hTShhdIKMaqYVTLvc4jRMA-1; Fri, 05 Dec 2025 06:27:59 -0500
X-MC-Unique: hTShhdIKMaqYVTLvc4jRMA-1
X-Mimecast-MFC-AGG-ID: hTShhdIKMaqYVTLvc4jRMA_1764934078
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42e2973a812so1222677f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 03:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764934077; x=1765538877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3elSILCrnUUvEOvxtQ+/2L+9hNstJFqtaNLm9nLBghs=;
 b=bjO1c33os+O0q6fwA3JBT55sPLLTqdUmPnXH5vgf/NfQ+l8OnoiiMwaAE1jpThm0Nc
 r3RG3lRwtcBwBwbqmtmFxGQ7bE3VtkhSFRq1pHC4GO22OGrukbvA901BZwhfoOYnxkQ6
 ggGT1OFtne+F+Uqpr8Tgl5YysYnaIS4rOQTRvwxchsXLGX45MATNciZ/mTflPksmwMbr
 Arm7vATO+27CqgQCdZpJ68uSKXwgNZTz1aEE63JYKJWGiji9yKHZKcH+lV5FWwgv3Ll2
 /k9u+0Rvrxq3nnPeS3iJqAtk1FvgmsdjDmsp1bEU5LG/EwbMSDsogtZS8ysVTvmtw0p+
 fETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764934078; x=1765538878;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3elSILCrnUUvEOvxtQ+/2L+9hNstJFqtaNLm9nLBghs=;
 b=nrr1QHjn4VTs2/kWRWK/b84SOVe8rc2FGrgAbJNXy+yzdmHY9T2d+ga63VSOm+t/EU
 5qAi2PzUsyvBfNO9mS/4X9wkzrEbIQmkjAdOhO5uZ16T6a/pv1di2lwyXNU9HBkRnKaO
 zERVgVDH5rpxDvauLpX/IndHPoaPO1OpUtLI6qfu2YH9kFHm8yIrxs9150kUWmAkFdnj
 BrJCgja/vsqNJ7sWHRfjlOQ+EFxWaeKE3y71dPZxGkN3Ju6JboyE2QAR7jJRAWnTyIs3
 V+rjnUGjzaESfj34Hhk4yL9zyDkZV/Netym/+GKvOi655V3X3vaSTgB2PosKtEEE2R4q
 7i/g==
X-Gm-Message-State: AOJu0YxNZsFNZGyDOuvENkznj0AHvvtzzGZkRqoGQWvAamse9kD+OrGv
 G7GRPfDt8J7UIYcGfrxb0T32EbBvF4YmyjMO/+n6ooQpYo47BFkYDgyXoVRRM2QSMgED+K4PmwR
 XhfIWkSgBmIOWpZi9Ixa9FW+tLCwUiSwSy4zIeubF3AEd1FPVKP98HLsLXvi3+tkI
X-Gm-Gg: ASbGnctAQJz7C6xw8qUmokDja98xemmx9AW1Q6dNQUmVttuW8aLot1yaifh9ocjQKC8
 oGTR9uPb7BO1xkpRb38oCYRyAtGv2T/CpmsBg/e3W+kcNXjmPGWJEx9Xz6g3S4VAWNA58+BZkzY
 Tnqi8dfL89vYSzxKiwIc70rNGv4gXVTQzIdpAT2ChkqS5lYwTftdHqeA5eRS/ffqpbOvHcyEt58
 875uxV2T0F+Q3soVUKG8fXYQJythG5F8J5vjG1G4PwKDHXxK7BymrR+vQOwtGvepQX362J6/47f
 cxQUvH47oxiZMdJ2GPdrCm4xqak+dUibfcemkleoulcmAgtfoFn4YglJz52Y2F/xRSn1K+di3jC
 /nBlN9oQJIIFLCdoP+kLyJ51WM4kFyHs6y//T1W/I+1R2N2yBS442BcavpIgjM4ECv73cpNly9D
 INJuLBa1x4EBMeJuY=
X-Received: by 2002:a05:6000:250f:b0:429:bfbb:5dae with SMTP id
 ffacd0b85a97d-42f7887666emr7875832f8f.17.1764934077469; 
 Fri, 05 Dec 2025 03:27:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSOh3Wxd/9Z+449LSH+xeSXpmA3c585g0tYMNVNAhE9zhX07/pvvygTYkpp1QspvqM8s0v8Q==
X-Received: by 2002:a05:6000:250f:b0:429:bfbb:5dae with SMTP id
 ffacd0b85a97d-42f7887666emr7875810f8f.17.1764934076990; 
 Fri, 05 Dec 2025 03:27:56 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331092sm8389468f8f.30.2025.12.05.03.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 03:27:56 -0800 (PST)
Message-ID: <c99be3c6-7301-4230-aacf-deeef4b99885@redhat.com>
Date: Fri, 5 Dec 2025 12:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] rust/qobject: add basic bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <20251010151006.791038-5-pbonzini@redhat.com> <875xalz2y6.fsf@pond.sub.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <875xalz2y6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 12/5/25 10:35, Markus Armbruster wrote:
>> +/// A wrapper for a C `QObject`.
>> +///
>> +/// Because `QObject` is not thread-safe, the safety of these bindings
>> +/// right now hinges on treating them as immutable.  It is part of the
>> +/// contract with the `QObject` constructors that the Rust struct is
>> +/// only built after the contents are stable.
>> +///
>> +/// Only a bare bones API is public; production and consumption of `QObject`
>> +/// generally goes through `serde`.
>> +pub struct QObject(&'static UnsafeCell<bindings::QObject>);
> 
> This defines the Rust QObject.  All it contains is a reference (wrapped
> in UnsafeCell) self.0 to the C QObject.  Correct?

Correct.

>> +
>> +// SAFETY: the QObject API are not thread-safe other than reference counting;
>> +// but the Rust struct is only created once the contents are stable, and
>> +// therefore it obeys the aliased XOR mutable invariant.
> 
> In other words, we promise never to change a QObject while Rust code
> holds a reference, except for the reference counts.  Correct?
> 
> The reference count is the mutable part of an otherwise immutable
> object.  Not mentioned here: it is atomic.  Therefore, concurrent
> updates cannot mess it up.  Nothing depends on its value except
> deallocation when the last reference drops.  I figure that's why the
> exception to "aliased XOR mutable" is fine.  Correct?

Yes, it's one of a few exceptions to "aliased XOR mutable" including:

- Mutex (because only one guy can access it at all anyway)

- RefCell (enforces aliased XOR mutable at run-time, enforces 
single-thread usage at compile-time)

- atomics (a mini mutex)

- Cell (Mutex:RefCell = atomics:Cell, in other words every access is 
independent but also single-thread usage is checked at compile time)

>> +unsafe impl Send for QObject {}
>> +unsafe impl Sync for QObject {}
>> +
>> +// Since a QObject can be a floating-point value, and potentially a NaN,
>> +// do not implement Eq
>> +impl PartialEq for QObject {
>> +    fn eq(&self, other: &Self) -> bool {
>> +        unsafe { bindings::qobject_is_equal(self.0.get(), other.0.get()) }
>> +    }
>> +}
>> +
>> +impl QObject {
>> +    /// Construct a [`QObject`] from a C `QObjectBase` pointer.
> 
> It's spelled QObjectBase_.  More of the same below, not flagging again.
> 
> Comment next to its definition:
> 
>      /* Not for use outside include/qobject/ */
> 
> We're using it outside now.  Do we really need to?

It's because we're defining equivalents of inline functions in 
include/qobject.

I can however replace uses of from_base with a macro similar to QOBJECT()
>> +    /// Obtain a raw C pointer from a reference. `self` is consumed
>> +    /// and the C `QObject` pointer is leaked.
> 
> What exactly do you mean by "leaked"?

s/and the.*/without decreasing the reference count, thus transferring 
the reference to the `*mut bindings::QOjbect`/

>> +    pub fn into_raw(self) -> *mut bindings::QObject {
>> +        let src = ManuallyDrop::new(self);
>> +        src.0.get()
>> +    }
>> +
>> +    /// Construct a [`QObject`] from a C `QObject` pointer.
> 
> Pasto?  Isn't it QObjectBase_ here?

Yes.

>> +impl From<()> for QObject {
>> +    fn from(_null: ()) -> Self {
>> +        unsafe { QObject::cloned_from_base(addr_of!(bindings::qnull_.base)) }
> 
> qnull_ is not meant for use outside qnull.[ch] and its unit test
> check-qnull.c.  Could we use qnull()?

Same as above---it's inline.  The above is a translation of

static inline QNull *qnull(void)
{
     return qobject_ref(&qnull_);
}

>> +macro_rules! from_double {
>> +    ($t:ty) => {
>> +        impl From<$t> for QObject {
>> +            fn from(n: $t) -> Self {
>> +                let qobj = unsafe { &*bindings::qnum_from_double(n.into()) };
>> +                unsafe { QObject::from_base(addr_of!(qobj.base)) }
>> +            }
>> +        }
>> +    };
>> +}
>> +
>> +from_double!(f32);
> 
> Uh, isn't the double in from_double misleading?

It's a reference to the function that it calls (qnum_from_double).  Can 
rename it to impl_from_returning_qnum_double.

>> +from_double!(f64);
> 
> Can you briefly explain why we need more than i64, u64, and double?

Because Rust doesn't do automatic casts.  So it's nicer (and also less 
error prone) if the subsequent patches do not have to always convert to 
u64 or i64.

> Skipping the remainder, it's too much macro magic for poor, ignorant me
> :)

It's not really hard.  The thing to the left of => effectively defines a 
parser. Each thing of the shape $IDENT:RULE matches a piece of Rust 
grammar; expr is expression an tt is token tree (either a single token 
or a parenthesized group).  To access $IDENT that appears within $(...)? 
on the left of => you must have a similar $(...)? on the right, and the 
whole $(...)? on the right will be skipped if the left-side wasn't there.

The macro is used like this:

         match_qobject! { (self) =>
             () => Unexpected::Unit,
             bool(b) => Unexpected::Bool(b),
             i64(n) => Unexpected::Signed(n),
             u64(n) => Unexpected::Unsigned(n),
             f64(n) => Unexpected::Float(n),
             CStr(s) => s.to_str().map_or_else(
                 |_| Unexpected::Other("string with invalid UTF-8"),
                 Unexpected::Str),
             QList(_) => Unexpected::Seq,
             QDict(_) => Unexpected::Map,
         }

And it produces a "switch" on QObject types, where each "case" extracts 
the datum, places it in the variable to the left of "=>" (such as "b" 
for bool), and returns the value on the right of "=>" (such as 
"Unexpected::Bool(b)"):


>> +    ) => {
>> +        loop {
>> +            let qobj_ = $qobj.0.get();
>> +            match unsafe { &* qobj_ }.base.type_ {
>> +                $($crate::bindings::QTYPE_QNULL => break $unit,)?
>> +                $($crate::bindings::QTYPE_QBOOL => break {
>> +                    let qbool__: *mut $crate::bindings::QBool = qobj_.cast();
>> +                    let $boolvar = unsafe { (&*qbool__).value };
>> +                    $bool
>> +                },)?

(The loop/break is just a syntactic convenience---the loop never rolls 
more than once).

Paolo


