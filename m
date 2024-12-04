Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D3AE7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwRz-0000es-1k; Wed, 04 Dec 2024 15:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tIwRv-0000dn-SA
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:58:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tIwRq-0006b5-OI
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733345893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
 bh=f2rp+Jo0Oy14N5MKC3kM7l3N3vw+GE0eu8C2TQ/AJrY=;
 b=Z0XqOJqfDF+Xq1Tz5RHEKtAyQoancQka8ont3ZVY7oqi9o9w7mH4SIA90pv4Hnr4NGaLih
 pZTjf8zuFsJafkYgOfCqoKaLx2pufnhnS2SCKZBKfq+s+CANt3ODxq/dJsljMIylZWBqGH
 sGrVRrOv36LlW5v0ADDsIQMFBXHPooM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-YMXY0ob7OtW0AYRuDzHssQ-1; Wed, 04 Dec 2024 15:58:12 -0500
X-MC-Unique: YMXY0ob7OtW0AYRuDzHssQ-1
X-Mimecast-MFC-AGG-ID: YMXY0ob7OtW0AYRuDzHssQ
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d884e46548so4717786d6.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733345891; x=1733950691;
 h=to:autocrypt:subject:content-language:from:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f2rp+Jo0Oy14N5MKC3kM7l3N3vw+GE0eu8C2TQ/AJrY=;
 b=d86N85cFXNkp6BD1b96vFg7PoS/jCP4UszVn5RuBxGE1yzV88WZODOI3bLW6+fwiNN
 MqiHvDfUbAOBM+ce6b1FtxduyEuS7jjhYlAJcwjCs0S1o0oN6lhLh9nTOK9N9nrAHnDo
 7e1H79rj4Vf6NhL/UMJKMJnMaGxSpW5wr8FCps30kyTKouxThDzzMQwAHhXeJI27xAeT
 QccjSX5qjUMN13wsJkfD4EX71m9NC730h5Pm4WSH6j0DTMkV1Kngux9RYseudcxU5PEU
 swXAGKEC8rvy5MBYb6Ysa+vf01k6UGvy70nVNVtNsQuJhxfFGWgJ11KmlulBPUxneAra
 1H3g==
X-Gm-Message-State: AOJu0YwIYSnlKKBp2W5UbqtxYUT4/XHIP3xobt8cfi5hivFL1DLaOEq2
 bnmlOOA8RjKYEZzwWQk0Di3HhvOfY0IZ+5MAC5tkx/PTLmZa5LhwqUkKXbzqRSBWue20X18fIeJ
 HArIwr9iWRTr1Xh+ujrBhrelAOWetws13Md+OPcEhMqhBZ1RA8qBHSr+Xx4tqveqkBpN4rpw/J5
 4w/ojT83f08icuzsYHz1LhnJRHjb9cND3fLgKpmdM=
X-Gm-Gg: ASbGncv3l74PPv0unkqqipIVe7w0jPE0fKrPOo91j/9IRoksM/IZ1XiWzU2hy1IRjlq
 NDGgPWJrNfalNgLNCscKMtg9taJYYZCaS2ckkVwfL0hd1ckKFP21sJTKvRqeTm8dxrK4MCU2ChZ
 vxng0nlOOi460HlD9GEQNaX3dkVmW5QUykDH1/FeGjxabenzki5Emu50wqOdIs6Qy/4l+CUtHgH
 6BSbpRPTxPUQKvdkK7udxXaBK8+E5AGueqvoWsG9WSeU+hpD33DXtoKxQ==
X-Received: by 2002:ad4:5f85:0:b0:6d8:a0c8:e467 with SMTP id
 6a1803df08f44-6d8b733043dmr105820866d6.13.1733345890560; 
 Wed, 04 Dec 2024 12:58:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsmTMYOQqsKCGuXv2akTLA0hrjZG1dSKDgIT/KrxSw6s2OIw2lDPjNQzY6mAH3bv5IUTYwNA==
X-Received: by 2002:ad4:5f85:0:b0:6d8:a0c8:e467 with SMTP id
 6a1803df08f44-6d8b733043dmr105820176d6.13.1733345889804; 
 Wed, 04 Dec 2024 12:58:09 -0800 (PST)
Received: from [192.168.101.123] ([50.234.104.165])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6d875163a01sm77286196d6.23.2024.12.04.12.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 12:58:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------i8WbTltGQZO00KKd01N0GZIs"
Message-ID: <4331e9b5-2b83-4932-8f0a-2157ed41db8a@redhat.com>
Date: Wed, 4 Dec 2024 21:58:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Subject: A glimpse at PL011 emulation in safe Rust
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
To: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Daniel Berrange <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_HTML_ATTACH=0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------i8WbTltGQZO00KKd01N0GZIs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

this is finally a look at what the PL011 device model would look like
in Rust, without having to write unsafe so often.  The attached file is
a synopsis of the C code, the Rust code and my commentary (the C code is
partly rearranged to match the ordering of the Rust code).

The code compiles on my computer, but it needs some functionality that
is still untested or stubbed out.  Getting to here will take some time
and some reviews.  But in the meanwhile, this is already useful to show
what having Rust available in QEMU *actually* looks like for people who
have to write a device.

While preparing this I noticed some logic changes between the C and Rust
version, for which I will send patches in due course.  Otherwise, the
device logic was changed as little as possible and especially the naming
style.  So, while the coding style is mostly fixed to what rustfmt
produces, some adjustments to the names and how they are referred to
can be made (absolutely tell me if you prefer "registers::Data" or
"regs::Data" or "DataReg"!).

Please review and be as brutal as needed. :)  For your convenience I
copied the commentary after my signature, with line numbers; quoting it
is probably the easiest way to reply, though of course in some cases
you might prefer to quote code instead.

If we want to continue, please remember that people will need to step
in sooner rather than later (e.g. adding bindings to QAPI and DMA; but
also doing reviews to ensure that the code is not impenetrable to
anyone but me).  Or if we want to abort because there is not enough
benefit, this is also the time to decide it.

Paolo


10 These are the APIs that PL011 needs.  Note that "bindings" is not
11 imported, all that is necessary from C code has been wrapped.

14 "prelude" provides commonly used structs and traits from all over the place.

18 "qom_isa" is a macro that helps with defining QOM superclasses.

44 Rust only allows indexing arrays with usize indices.  Adding
45 the Index implementation here removes some casts elsewhere.

52 Equivalent code is generated automatically by the Rust compiler
53 (with "#[derive(Display)]" on the RegisterOffsets enum).

70 I am not very happy with the handling of bitmasks.  It is certainly
71 possible to do better.  The ".0" is because the code tries to use a
72 type wrapping the bitfields, but not hard enough (irq_level, irq_enable,
73 IRQMASK are all u32).

75 Rust supports operator overloading, but not yet in "const" context (which
76 includes "const" declarations of course, but also "static" declarations).
77 This is the main missing bit that I would like from the language.
78 Until it's in, we'll probably have to be creative.

85 Needed for migration to look at the struct.

88 These are effectively bitfields, but portable.  They are handled by an
89 external crate.  The ugly-ish part about it is that it doesn't support
90 const operation very well, so it is hard to define constants for recurring
91 values of the registers (e.g. DR_BE in the C code).

95 read_fifo could be a [registers::Data; PL011_FIFO_DEPTH] too.  Not sure
96 how that would work for vmstate, though.

98 Note how the mutable part of the device is in a separate struct.  This is
99 because all accesses check that the BQL is taken, and also that it is
100 not dropped in the middle of the access.

116 This [BqlRefCell] is what does the BQL checks.

118 Owned<> means that instance_init will add a reference to the Clock and
119 instance_finalize will drop it.

122 All superclasses have to be listed, at least for now.

124 I took a slightly different approach to the device_id, compared to the
125 C code, mostly to test whether the bindings to QOM could do subclasses
126 of classes that written themselves in Rust.

130 These "unsafe impl" are the only occurrence of unsafe in the whole device.
131 The ObjectType trait is marked unsafe because it tells the QOM C code
132 things about the layout of the PL011State struct that the user is promising.
133 Often, unsafe traits are generated by macros that can promise safety.

138 As will be visible later, implementing class_init for "standard" classes
139 is mostly automatic, but you do have to recurse up the class hierarchy.

142 This trait defines what goes in TypeInfo.

145 So for example this ends up in the TypeInfo's .instance_post_init field.

148 This "Builder" thing is a common idiom in Rust whenever not all fields
149 are always initialized.  Note that the MemoryRegionOps callbacks are
150 methods implemented by struct PL011State.

155 Rust code will have a stricter separation between instance_init and
156 instance_post_init.  The former only takes care of initializing the struct
157 (the compiler checks that all fields are initialized!), the latter does
158 other initialization such as sysbus_init_irq and sysbus_init_mmio.

172 This trait defines what goes in DeviceClass.

173 This can become a "const" with a newer version of Rust.

177 This one too.

180 Realize and reset cannot be functions in the DeviceImpl trait, because
181 the code also needs to express their *absence* (i.e. using the inherited
182 implementation).  It may be possible in the future to use procedural
183 macros to make things look a bit more natural.  But this is at the cost
184 of hidden magic, so it is a debatable benefit and for now I am leaving
185 everything visible.

189 Here I am taking a slightly different approach to callbacks;
190 they are all included in a trait instead of being methods
191 implemented by PL011State.  The reason for this is only to
192 figure out the advantages and disadvantages; this one seems
193 more "natural" but if one has more than one character device
194 backend things will get more complicated.  I am leaning
195 towards using methods for character device ops as well, which
196 is also more similar to the C API.  I started with this other
197 idea but only because I hadn't yet figured out methods

202 Due to the separation between registers and the rest, I
203 removed external interrupt update from put_fifo (and made
204 it #[must_use] to not forget).

221 The bulk of read and write is implemented on PL011Registers.  read must
222 also return whether to invoke qemu_chr_fe_accept_input() because it can
223 cause reentrancy in PL011Registers (which is an abort!).  "ControlFlow"
224 is how the code currently represents it, but it's probably easiest to
225 return a (bool, u32) pair.  Patches are welcome.

227 Here are bitfields in action.

240 Another case in which bitmasks need more work.

243 The RSR layout is the same as bits 8-15 of DR.  This is visible in
244 the types.  Including the "error clear" part in the name is probably
245 wrong because the register is only used for the reads part.  It's
246 not a "write 1 clears" registers, for example.  This brings another
247 question: what is the best way to note open improvements in the files?

297 Again some differences due to read and write being implemented on a
298 separate struct:
299
300 - read/write gets the register decoded into an enum
301
302 - write send back whether to look for interrupts
303
304 - write also needs to know the character backend.  Alternatively
305 PL011Registers could know its outer PL011State, or
306 "char_backend.write_all(&ch);" could be sent down as a
307 closure

381 This #[must_use] asks the caller to check the result (to call
382 update() or to pass it up).

428 The difference between bitfields here and ints below is a bit jarring.
429 I guess if one doesn't like it, they could use u32 like in C for both
430 registers and interrupts; nobody would complain to be honest.  Using the
431 language's features makes it clear where they leave something to be
432 desired, at least (and I don't feel like undoing the work that Manos
433 did in converting the registers to bitfields...).

463 This is still the implementation of PL011Registers.

476 And this as well.  This is *not* the reset method on DeviceState.

491 This line resets all FIFO flags, both transmit and receive.

523 Another #[must_use] here.

576 This is the callback for self.clock

582 This was the missing part of pl011_init.  BTW, vmstate is
583 the main missing part.

590 And here are also the remaining parts of read and write.
591
592 After borrow_mut(), "regs" provides a way to write to self.regs,
593 but only while the local variable regs is live.
594
595 Converting from hwaddr to enum returns Err(offset) if the offset is
596 not part of a known register.  This is one case where macros are good
597 at hiding code that "does the obvious thing".  Rust macros are more
598 powerful and generally do not have the same issues as C, but they can
599 make the code unreadable if done wrong.

602 Logging and tracing are the main missing pieces.

606 regs is dropped here.  Someone else can now write to self.regs.
607
608 Again, don't read too much in Break/Continue.  The intention of
609 the ControlFlow enum doesn't really match how QEMU uses it here.
610
611 accept_input is called after coming back; the character device
612 callbacks do their own borrow_mut().

638 PL011State needs a couple more forwarding methods to call into PL011Registers.
639 In fact, *this* is the implementation of the "reset" method in DeviceState.

667 The wrappers for qdev_prop_set_chr and sysbus_connect_irq take an
668 Owned<...> smart pointer.  This smart pointer automatically handles
669 object_ref() and object_unref().  The reason why they take Owned<...> and
670 not a normal reference is to signify that the object is heap allocated.
671 Since C gave a raw pointer, create the Owned by hand in unsafe blocks.
672 Also tell Rust not to drop it, i.e. not to call object_unref().
673
674 ... I lied, the functions take *a reference* to the pointer (that is, an
675 &Owned<...>).  This means that they *request* you to own a reference but
676 they don't steal it from you.  The functions take care of adding their own
677 reference: qemu_chr_fe_init() does it; or, if I'm not wrong, it should).
678
679 PL011State::new() gave us an Owned<PL011State>, converting it with into_raw
680 gives ownership of the reference to the C caller.

694 instance_init is mandatory in Rust; the case where you have no additional
695 fields to initialize (as is the case here) is rare enough.  This is why
696 it is an "fn" and not a "const" like REALIZE and RESET.  If needed, it
697 would be possible to write a separate wrapper for "this class only
698 differs from its superclass in its class_init method".

701 Again, the implementation is different so this is a class_init method.

715 The defaults are good. No need to override realize and reset, so the default of
716 None for the REALIZE and RESET constants are ok.

718 type_register_static is handled automagically by #[derive(Object)],
719 as an initial tasting of what macros could do.  The main things that
720 we could do with macros is implementing qdev properties in a type-safe
721 manner, and perhaps improve the bitmask situation.

--------------i8WbTltGQZO00KKd01N0GZIs
Content-Type: text/html; charset=UTF-8; name="pl011-2024-12-04.html"
Content-Disposition: attachment; filename="pl011-2024-12-04.html"
Content-Transfer-Encoding: base64

PHRhYmxlPjx0ciB2YWxpZ249InRvcCI+PHRkIGFsaWduPSJyaWdodCI+PHByZSBzdHlsZT0i
Y29sb3I6Ymx1ZTsgZm9udC13ZWlnaHQ6IDcwMDsiPgoxCjIKMwo0CjUKNgo3CjgKOQoxMAox
MQoxMgoxMwoxNAoxNQoxNgoxNwoxOAoxOQoyMAoyMQoyMgoyMwoyNAoyNQoyNgoyNwoyOAoy
OQozMAozMQozMgozMwozNAozNQozNgozNwozOAozOQo0MAo0MQo0Mgo0Mwo0NAo0NQo0Ngo0
Nwo0OAo0OQo1MAo1MQo1Mgo1Mwo1NAo1NQo1Ngo1Nwo1OAo1OQo2MAo2MQo2Mgo2Mwo2NAo2
NQo2Ngo2Nwo2OAo2OQo3MAo3MQo3Mgo3Mwo3NAo3NQo3Ngo3Nwo3OAo3OQo4MAo4MQo4Mgo4
Mwo4NAo4NQo4Ngo4Nwo4OAo4OQo5MAo5MQo5Mgo5Mwo5NAo5NQo5Ngo5Nwo5OAo5OQoxMDAK
MTAxCjEwMgoxMDMKMTA0CjEwNQoxMDYKMTA3CjEwOAoxMDkKMTEwCjExMQoxMTIKMTEzCjEx
NAoxMTUKMTE2CjExNwoxMTgKMTE5CjEyMAoxMjEKMTIyCjEyMwoxMjQKMTI1CjEyNgoxMjcK
MTI4CjEyOQoxMzAKMTMxCjEzMgoxMzMKMTM0CjEzNQoxMzYKMTM3CjEzOAoxMzkKMTQwCjE0
MQoxNDIKMTQzCjE0NAoxNDUKMTQ2CjE0NwoxNDgKMTQ5CjE1MAoxNTEKMTUyCjE1MwoxNTQK
MTU1CjE1NgoxNTcKMTU4CjE1OQoxNjAKMTYxCjE2MgoxNjMKMTY0CjE2NQoxNjYKMTY3CjE2
OAoxNjkKMTcwCjE3MQoxNzIKMTczCjE3NAoxNzUKMTc2CjE3NwoxNzgKMTc5CjE4MAoxODEK
MTgyCjE4MwoxODQKMTg1CjE4NgoxODcKMTg4CjE4OQoxOTAKMTkxCjE5MgoxOTMKMTk0CjE5
NQoxOTYKMTk3CjE5OAoxOTkKMjAwCjIwMQoyMDIKMjAzCjIwNAoyMDUKMjA2CjIwNwoyMDgK
MjA5CjIxMAoyMTEKMjEyCjIxMwoyMTQKMjE1CjIxNgoyMTcKMjE4CjIxOQoyMjAKMjIxCjIy
MgoyMjMKMjI0CjIyNQoyMjYKMjI3CjIyOAoyMjkKMjMwCjIzMQoyMzIKMjMzCjIzNAoyMzUK
MjM2CjIzNwoyMzgKMjM5CjI0MAoyNDEKMjQyCjI0MwoyNDQKMjQ1CjI0NgoyNDcKMjQ4CjI0
OQoyNTAKMjUxCjI1MgoyNTMKMjU0CjI1NQoyNTYKMjU3CjI1OAoyNTkKMjYwCjI2MQoyNjIK
MjYzCjI2NAoyNjUKMjY2CjI2NwoyNjgKMjY5CjI3MAoyNzEKMjcyCjI3MwoyNzQKMjc1CjI3
NgoyNzcKMjc4CjI3OQoyODAKMjgxCjI4MgoyODMKMjg0CjI4NQoyODYKMjg3CjI4OAoyODkK
MjkwCjI5MQoyOTIKMjkzCjI5NAoyOTUKMjk2CjI5NwoyOTgKMjk5CjMwMAozMDEKMzAyCjMw
MwozMDQKMzA1CjMwNgozMDcKMzA4CjMwOQozMTAKMzExCjMxMgozMTMKMzE0CjMxNQozMTYK
MzE3CjMxOAozMTkKMzIwCjMyMQozMjIKMzIzCjMyNAozMjUKMzI2CjMyNwozMjgKMzI5CjMz
MAozMzEKMzMyCjMzMwozMzQKMzM1CjMzNgozMzcKMzM4CjMzOQozNDAKMzQxCjM0MgozNDMK
MzQ0CjM0NQozNDYKMzQ3CjM0OAozNDkKMzUwCjM1MQozNTIKMzUzCjM1NAozNTUKMzU2CjM1
NwozNTgKMzU5CjM2MAozNjEKMzYyCjM2MwozNjQKMzY1CjM2NgozNjcKMzY4CjM2OQozNzAK
MzcxCjM3MgozNzMKMzc0CjM3NQozNzYKMzc3CjM3OAozNzkKMzgwCjM4MQozODIKMzgzCjM4
NAozODUKMzg2CjM4NwozODgKMzg5CjM5MAozOTEKMzkyCjM5MwozOTQKMzk1CjM5NgozOTcK
Mzk4CjM5OQo0MDAKNDAxCjQwMgo0MDMKNDA0CjQwNQo0MDYKNDA3CjQwOAo0MDkKNDEwCjQx
MQo0MTIKNDEzCjQxNAo0MTUKNDE2CjQxNwo0MTgKNDE5CjQyMAo0MjEKNDIyCjQyMwo0MjQK
NDI1CjQyNgo0MjcKNDI4CjQyOQo0MzAKNDMxCjQzMgo0MzMKNDM0CjQzNQo0MzYKNDM3CjQz
OAo0MzkKNDQwCjQ0MQo0NDIKNDQzCjQ0NAo0NDUKNDQ2CjQ0Nwo0NDgKNDQ5CjQ1MAo0NTEK
NDUyCjQ1Mwo0NTQKNDU1CjQ1Ngo0NTcKNDU4CjQ1OQo0NjAKNDYxCjQ2Mgo0NjMKNDY0CjQ2
NQo0NjYKNDY3CjQ2OAo0NjkKNDcwCjQ3MQo0NzIKNDczCjQ3NAo0NzUKNDc2CjQ3Nwo0NzgK
NDc5CjQ4MAo0ODEKNDgyCjQ4Mwo0ODQKNDg1CjQ4Ngo0ODcKNDg4CjQ4OQo0OTAKNDkxCjQ5
Mgo0OTMKNDk0CjQ5NQo0OTYKNDk3CjQ5OAo0OTkKNTAwCjUwMQo1MDIKNTAzCjUwNAo1MDUK
NTA2CjUwNwo1MDgKNTA5CjUxMAo1MTEKNTEyCjUxMwo1MTQKNTE1CjUxNgo1MTcKNTE4CjUx
OQo1MjAKNTIxCjUyMgo1MjMKNTI0CjUyNQo1MjYKNTI3CjUyOAo1MjkKNTMwCjUzMQo1MzIK
NTMzCjUzNAo1MzUKNTM2CjUzNwo1MzgKNTM5CjU0MAo1NDEKNTQyCjU0Mwo1NDQKNTQ1CjU0
Ngo1NDcKNTQ4CjU0OQo1NTAKNTUxCjU1Mgo1NTMKNTU0CjU1NQo1NTYKNTU3CjU1OAo1NTkK
NTYwCjU2MQo1NjIKNTYzCjU2NAo1NjUKNTY2CjU2Nwo1NjgKNTY5CjU3MAo1NzEKNTcyCjU3
Mwo1NzQKNTc1CjU3Ngo1NzcKNTc4CjU3OQo1ODAKNTgxCjU4Mgo1ODMKNTg0CjU4NQo1ODYK
NTg3CjU4OAo1ODkKNTkwCjU5MQo1OTIKNTkzCjU5NAo1OTUKNTk2CjU5Nwo1OTgKNTk5CjYw
MAo2MDEKNjAyCjYwMwo2MDQKNjA1CjYwNgo2MDcKNjA4CjYwOQo2MTAKNjExCjYxMgo2MTMK
NjE0CjYxNQo2MTYKNjE3CjYxOAo2MTkKNjIwCjYyMQo2MjIKNjIzCjYyNAo2MjUKNjI2CjYy
Nwo2MjgKNjI5CjYzMAo2MzEKNjMyCjYzMwo2MzQKNjM1CjYzNgo2MzcKNjM4CjYzOQo2NDAK
NjQxCjY0Mgo2NDMKNjQ0CjY0NQo2NDYKNjQ3CjY0OAo2NDkKNjUwCjY1MQo2NTIKNjUzCjY1
NAo2NTUKNjU2CjY1Nwo2NTgKNjU5CjY2MAo2NjEKNjYyCjY2Mwo2NjQKNjY1CjY2Ngo2NjcK
NjY4CjY2OQo2NzAKNjcxCjY3Mgo2NzMKNjc0CjY3NQo2NzYKNjc3CjY3OAo2NzkKNjgwCjY4
MQo2ODIKNjgzCjY4NAo2ODUKNjg2CjY4Nwo2ODgKNjg5CjY5MAo2OTEKNjkyCjY5Mwo2OTQK
Njk1CjY5Ngo2OTcKNjk4CjY5OQo3MDAKNzAxCjcwMgo3MDMKNzA0CjcwNQo3MDYKNzA3Cjcw
OAo3MDkKNzEwCjcxMQo3MTIKNzEzCjcxNAo3MTUKNzE2CjcxNwo3MTgKNzE5CjcyMAo3MjEK
PC9wcmU+PC90ZD48dGQ+CjxwcmU+PGNvZGU+I2luY2x1ZGUgJnF1b3Q7cWVtdS9vc2RlcC5o
JnF1b3Q7CiNpbmNsdWRlICZxdW90O3FhcGkvZXJyb3IuaCZxdW90OwojaW5jbHVkZSAmcXVv
dDtody9jaGFyL3BsMDExLmgmcXVvdDsKI2luY2x1ZGUgJnF1b3Q7aHcvaXJxLmgmcXVvdDsK
I2luY2x1ZGUgJnF1b3Q7aHcvc3lzYnVzLmgmcXVvdDsKI2luY2x1ZGUgJnF1b3Q7aHcvcWRl
di1jbG9jay5oJnF1b3Q7CiNpbmNsdWRlICZxdW90O2h3L3FkZXYtcHJvcGVydGllcy5oJnF1
b3Q7CiNpbmNsdWRlICZxdW90O2h3L3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uaCZxdW90Owoj
aW5jbHVkZSAmcXVvdDttaWdyYXRpb24vdm1zdGF0ZS5oJnF1b3Q7CiNpbmNsdWRlICZxdW90
O2NoYXJkZXYvY2hhci1mZS5oJnF1b3Q7CiNpbmNsdWRlICZxdW90O2NoYXJkZXYvY2hhci1z
ZXJpYWwuaCZxdW90OwojaW5jbHVkZSAmcXVvdDtxZW11L2xvZy5oJnF1b3Q7CiNpbmNsdWRl
ICZxdW90O3FlbXUvbW9kdWxlLmgmcXVvdDsKI2luY2x1ZGUgJnF1b3Q7dHJhY2UuaCZxdW90
OwoKCjxlbT4uLi4gb21pdHRpbmcgcmVnaXN0ZXIgZGVmaW5pdGlvbnMgLi4uPC9lbT4KCgoK
CgoKCgoKLyogSW50ZWdlciBCYXVkIFJhdGUgRGl2aWRlciwgVUFSVElCUkQgKi8KI2RlZmlu
ZSBJQlJEX01BU0sgMHhmZmZmCgovKiBGcmFjdGlvbmFsIEJhdWQgUmF0ZSBEaXZpZGVyLCBV
QVJURkJSRCAqLwojZGVmaW5lIEZCUkRfTUFTSyAweDNmCgovKiBEZXB0aCBvZiBVQVJUIEZJ
Rk8gaW4gYnl0ZXMsIHdoZW4gRklGTyBtb2RlIGlzIGVuYWJsZWQgKGVsc2UgZGVwdGggPT0g
MSkgKi8KI2RlZmluZSBQTDAxMV9GSUZPX0RFUFRIIDE2CgpzdGF0aWMgY29uc3QgdW5zaWdu
ZWQgY2hhciBwbDAxMV9pZF9hcm1bOF0gPQogIHsgMHgxMSwgMHgxMCwgMHgxNCwgMHgwMCwg
MHgwZCwgMHhmMCwgMHgwNSwgMHhiMSB9OwpzdGF0aWMgY29uc3QgdW5zaWduZWQgY2hhciBw
bDAxMV9pZF9sdW1pbmFyeVs4XSA9CiAgeyAweDExLCAweDAwLCAweDE4LCAweDAxLCAweDBk
LCAweGYwLCAweDA1LCAweGIxIH07CgoKCgoKCgoKCgoKCnN0YXRpYyBjb25zdCBjaGFyICpw
bDAxMV9yZWduYW1lKGh3YWRkciBvZmZzZXQpCnsKICAgIHN0YXRpYyBjb25zdCBjaGFyICpj
b25zdCBybmFtZVtdID0gewogICAgICAgIFswXSA9ICZxdW90O0RSJnF1b3Q7LCBbMV0gPSAm
cXVvdDtSU1ImcXVvdDssIFs2XSA9ICZxdW90O0ZSJnF1b3Q7LCBbOF0gPSAmcXVvdDtJTFBS
JnF1b3Q7LCBbOV0gPSAmcXVvdDtJQlJEJnF1b3Q7LAogICAgICAgIFsxMF0gPSAmcXVvdDtG
QlJEJnF1b3Q7LCBbMTFdID0gJnF1b3Q7TENSSCZxdW90OywgWzEyXSA9ICZxdW90O0NSJnF1
b3Q7LCBbMTNdID0gJnF1b3Q7SUZMUyZxdW90OywgWzE0XSA9ICZxdW90O0lNU0MmcXVvdDss
CiAgICAgICAgWzE1XSA9ICZxdW90O1JJUyZxdW90OywgWzE2XSA9ICZxdW90O01JUyZxdW90
OywgWzE3XSA9ICZxdW90O0lDUiZxdW90OywgWzE4XSA9ICZxdW90O0RNQUNSJnF1b3Q7LAog
ICAgfTsKICAgIHVuc2lnbmVkIGlkeCA9IG9mZnNldCAmZ3Q7Jmd0OyAyOwoKICAgIGlmIChp
ZHggJmx0OyBBUlJBWV9TSVpFKHJuYW1lKSAmYW1wOyZhbXA7IHJuYW1lW2lkeF0pIHsKICAg
ICAgICByZXR1cm4gcm5hbWVbaWR4XTsKICAgIH0KICAgIGlmIChpZHggJmd0Oz0gMHgzZjgg
JmFtcDsmYW1wOyBpZHggJmx0Oz0gMHg0MDApIHsKICAgICAgICByZXR1cm4gJnF1b3Q7SUQm
cXVvdDs7CiAgICB9CiAgICByZXR1cm4gJnF1b3Q7VU5LTiZxdW90OzsKfQoKLyogV2hpY2gg
Yml0cyBpbiB0aGUgaW50ZXJydXB0IHN0YXR1cyBtYXR0ZXIgZm9yIGVhY2ggb3V0Ym91bmQg
SVJRIGxpbmUgPyAqLwpzdGF0aWMgY29uc3QgdWludDMyX3QgaXJxbWFza1tdID0gewogICAg
SU5UX0UgfCBJTlRfTVMgfCBJTlRfUlQgfCBJTlRfVFggfCBJTlRfUlgsIC8qIGNvbWJpbmVk
IElSUSAqLwogICAgSU5UX1JYLAogICAgSU5UX1RYLAogICAgSU5UX1JULAogICAgSU5UX01T
LAogICAgSU5UX0UsCn07CgoKCgoKCk9CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKFBMMDEx
U3RhdGUsIFBMMDExKQoKc3RydWN0IFBMMDExU3RhdGUgewogICAgU3lzQnVzRGV2aWNlIHBh
cmVudF9vYmo7CgogICAgTWVtb3J5UmVnaW9uIGlvbWVtOwogICAgdWludDMyX3QgZmxhZ3M7
CiAgICB1aW50MzJfdCBsY3I7CiAgICB1aW50MzJfdCByc3I7CiAgICB1aW50MzJfdCBjcjsK
ICAgIHVpbnQzMl90IGRtYWNyOwogICAgdWludDMyX3QgaW50X2VuYWJsZWQ7CiAgICB1aW50
MzJfdCBpbnRfbGV2ZWw7CiAgICB1aW50MzJfdCByZWFkX2ZpZm9bUEwwMTFfRklGT19ERVBU
SF07CiAgICB1aW50MzJfdCBpbHByOwogICAgdWludDMyX3QgaWJyZDsKICAgIHVpbnQzMl90
IGZicmQ7CiAgICB1aW50MzJfdCBpZmw7CiAgICBpbnQgcmVhZF9wb3M7CiAgICBpbnQgcmVh
ZF9jb3VudDsKICAgIGludCByZWFkX3RyaWdnZXI7CiAgICBDaGFyQmFja2VuZCBjaHI7CiAg
ICBxZW11X2lycSBpcnFbNl07CiAgICBDbG9jayAqY2xrOwogICAgYm9vbCBtaWdyYXRlX2Ns
azsKICAgIGNvbnN0IHVuc2lnbmVkIGNoYXIgKmlkOwp9OwoKCgoKCgoKCgoKCgoKCgoKCgpz
dGF0aWMgY29uc3QgVHlwZUluZm8gcGwwMTFfYXJtX2luZm8gPSB7CiAgICAubmFtZSAgICAg
ICAgICA9IFRZUEVfUEwwMTEsCiAgICAucGFyZW50ICAgICAgICA9IFRZUEVfU1lTX0JVU19E
RVZJQ0UsCiAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihQTDAxMVN0YXRlKSwKICAgIC5p
bnN0YW5jZV9pbml0ID0gcGwwMTFfaW5pdCwKICAgIC5jbGFzc19pbml0ICAgID0gcGwwMTFf
Y2xhc3NfaW5pdCwKfTsKCgoKCgoKCgoKCnN0YXRpYyBjb25zdCBNZW1vcnlSZWdpb25PcHMg
cGwwMTFfb3BzID0gewogICAgLnJlYWQgPSBwbDAxMV9yZWFkLAogICAgLndyaXRlID0gcGww
MTFfd3JpdGUsCiAgICAuZW5kaWFubmVzcyA9IERFVklDRV9OQVRJVkVfRU5ESUFOLAogICAg
LmltcGwubWluX2FjY2Vzc19zaXplID0gNCwKICAgIC5pbXBsLm1heF9hY2Nlc3Nfc2l6ZSA9
IDQsCn07CgpzdGF0aWMgdm9pZCBwbDAxMV9pbml0KE9iamVjdCAqb2JqKQp7CiAgICBTeXNC
dXNEZXZpY2UgKnNiZCA9IFNZU19CVVNfREVWSUNFKG9iaik7CiAgICBQTDAxMVN0YXRlICpz
ID0gUEwwMTEob2JqKTsKICAgIGludCBpOwoKICAgIG1lbW9yeV9yZWdpb25faW5pdF9pbygm
YW1wO3MtJmd0O2lvbWVtLCBPQkpFQ1QocyksICZhbXA7cGwwMTFfb3BzLCBzLCAmcXVvdDtw
bDAxMSZxdW90OywgMHgxMDAwKTsKICAgIHN5c2J1c19pbml0X21taW8oc2JkLCAmYW1wO3Mt
Jmd0O2lvbWVtKTsKICAgIGZvciAoaSA9IDA7IGkgJmx0OyBBUlJBWV9TSVpFKHMtJmd0O2ly
cSk7IGkrKykgewogICAgICAgIHN5c2J1c19pbml0X2lycShzYmQsICZhbXA7cy0mZ3Q7aXJx
W2ldKTsKICAgIH0KCiAgICBzLSZndDtjbGsgPSBxZGV2X2luaXRfY2xvY2tfaW4oREVWSUNF
KG9iaiksICZxdW90O2NsayZxdW90OywgcGwwMTFfY2xvY2tfdXBkYXRlLCBzLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIENsb2NrVXBkYXRlKTsKICAgIHMtJmd0O2lkID0g
cGwwMTFfaWRfYXJtOwp9CgpzdGF0aWMgdm9pZCBwbDAxMV9jbGFzc19pbml0KE9iamVjdENs
YXNzICpvYywgdm9pZCAqZGF0YSkKewogICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NM
QVNTKG9jKTsKCiAgICBkYy0mZ3Q7cmVhbGl6ZSA9IHBsMDExX3JlYWxpemU7CiAgICBkZXZp
Y2VfY2xhc3Nfc2V0X2xlZ2FjeV9yZXNldChkYywgcGwwMTFfcmVzZXQpOwogICAgZGMtJmd0
O3Ztc2QgPSAmYW1wO3Ztc3RhdGVfcGwwMTE7CiAgICBkZXZpY2VfY2xhc3Nfc2V0X3Byb3Bz
KGRjLCBwbDAxMV9wcm9wZXJ0aWVzKTsKfQoKCgoKCgoKc3RhdGljIGludCBwbDAxMV9jYW5f
cmVjZWl2ZSh2b2lkICpvcGFxdWUpCnsKICAgIFBMMDExU3RhdGUgKnMgPSAoUEwwMTFTdGF0
ZSAqKW9wYXF1ZTsKICAgIGludCByOwoKICAgIHIgPSBzLSZndDtyZWFkX2NvdW50ICZsdDsg
cGwwMTFfZ2V0X2ZpZm9fZGVwdGgocyk7CiAgICB0cmFjZV9wbDAxMV9jYW5fcmVjZWl2ZShz
LSZndDtsY3IsIHMtJmd0O3JlYWRfY291bnQsIHIpOwogICAgcmV0dXJuIHI7Cn0KCnN0YXRp
YyB2b2lkIHBsMDExX2V2ZW50KHZvaWQgKm9wYXF1ZSwgUUVNVUNockV2ZW50IGV2ZW50KQp7
CiAgICBpZiAoZXZlbnQgPT0gQ0hSX0VWRU5UX0JSRUFLICZhbXA7JmFtcDsgIXBsMDExX2xv
b3BiYWNrX2VuYWJsZWQob3BhcXVlKSkgewogICAgICAgIHBsMDExX3B1dF9maWZvKG9wYXF1
ZSwgRFJfQkUpOwogICAgfQp9CgoKCnN0YXRpYyB2b2lkIHBsMDExX3JlY2VpdmUodm9pZCAq
b3BhcXVlLCBjb25zdCB1aW50OF90ICpidWYsIGludCBzaXplKQp7CiAgICAvKgogICAgICog
SW4gbG9vcGJhY2sgbW9kZSwgdGhlIFJYIGlucHV0IHNpZ25hbCBpcyBpbnRlcm5hbGx5IGRp
c2Nvbm5lY3RlZAogICAgICogZnJvbSB0aGUgZW50aXJlIHJlY2VpdmluZyBsb2dpY3M7IHRo
dXMsIGFsbCBpbnB1dHMgYXJlIGlnbm9yZWQsCiAgICAgKiBhbmQgQlJFQUsgZGV0ZWN0aW9u
IG9uIFJYIGlucHV0IHNpZ25hbCBpcyBhbHNvIG5vdCBwZXJmb3JtZWQuCiAgICAgKi8KICAg
IGlmIChwbDAxMV9sb29wYmFja19lbmFibGVkKG9wYXF1ZSkpIHsKICAgICAgICByZXR1cm47
CiAgICB9CgogICAgcGwwMTFfcHV0X2ZpZm8ob3BhcXVlLCAqYnVmKTsKfQoKc3RhdGljIHVp
bnQ2NF90IHBsMDExX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LAogICAgICAg
ICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBzaXplKQp7CiAgICBQTDAxMVN0YXRlICpz
ID0gKFBMMDExU3RhdGUgKilvcGFxdWU7CiAgICB1aW50MzJfdCBjOwogICAgdWludDY0X3Qg
cjsKCiAgICBzd2l0Y2ggKG9mZnNldCAmZ3Q7Jmd0OyAyKSB7CiAgICBjYXNlIDA6IC8qIFVB
UlREUiAqLwogICAgICAgIHMtJmd0O2ZsYWdzICZhbXA7PSB+UEwwMTFfRkxBR19SWEZGOwog
ICAgICAgIGMgPSBzLSZndDtyZWFkX2ZpZm9bcy0mZ3Q7cmVhZF9wb3NdOwogICAgICAgIGlm
IChzLSZndDtyZWFkX2NvdW50ICZndDsgMCkgewogICAgICAgICAgICBzLSZndDtyZWFkX2Nv
dW50LS07CiAgICAgICAgICAgIHMtJmd0O3JlYWRfcG9zID0gKHMtJmd0O3JlYWRfcG9zICsg
MSkgJmFtcDsgKHBsMDExX2dldF9maWZvX2RlcHRoKHMpIC0gMSk7CiAgICAgICAgfQogICAg
ICAgIGlmIChzLSZndDtyZWFkX2NvdW50ID09IDApIHsKICAgICAgICAgICAgcy0mZ3Q7Zmxh
Z3MgfD0gUEwwMTFfRkxBR19SWEZFOwogICAgICAgIH0KICAgICAgICBpZiAocy0mZ3Q7cmVh
ZF9jb3VudCA9PSBzLSZndDtyZWFkX3RyaWdnZXIgLSAxKQogICAgICAgICAgICBzLSZndDtp
bnRfbGV2ZWwgJmFtcDs9IH4gSU5UX1JYOwogICAgICAgIHRyYWNlX3BsMDExX3JlYWRfZmlm
byhzLSZndDtyZWFkX2NvdW50KTsKICAgICAgICBzLSZndDtyc3IgPSBjICZndDsmZ3Q7IDg7
CiAgICAgICAgcGwwMTFfdXBkYXRlKHMpOwogICAgICAgIHFlbXVfY2hyX2ZlX2FjY2VwdF9p
bnB1dCgmYW1wO3MtJmd0O2Nocik7CiAgICAgICAgciA9IGM7CiAgICAgICAgYnJlYWs7CiAg
ICBjYXNlIDE6IC8qIFVBUlRSU1IgKi8KICAgICAgICByID0gcy0mZ3Q7cnNyOwogICAgICAg
IGJyZWFrOwogICAgY2FzZSA2OiAvKiBVQVJURlIgKi8KICAgICAgICByID0gcy0mZ3Q7Zmxh
Z3M7CiAgICAgICAgYnJlYWs7CiAgICBjYXNlIDg6IC8qIFVBUlRJTFBSICovCiAgICAgICAg
ciA9IHMtJmd0O2lscHI7CiAgICAgICAgYnJlYWs7CiAgICBjYXNlIDk6IC8qIFVBUlRJQlJE
ICovCiAgICAgICAgciA9IHMtJmd0O2licmQ7CiAgICAgICAgYnJlYWs7CiAgICBjYXNlIDEw
OiAvKiBVQVJURkJSRCAqLwogICAgICAgIHIgPSBzLSZndDtmYnJkOwogICAgICAgIGJyZWFr
OwogICAgY2FzZSAxMTogLyogVUFSVExDUl9IICovCiAgICAgICAgciA9IHMtJmd0O2xjcjsK
ICAgICAgICBicmVhazsKICAgIGNhc2UgMTI6IC8qIFVBUlRDUiAqLwogICAgICAgIHIgPSBz
LSZndDtjcjsKICAgICAgICBicmVhazsKICAgIGNhc2UgMTM6IC8qIFVBUlRJRkxTICovCiAg
ICAgICAgciA9IHMtJmd0O2lmbDsKICAgICAgICBicmVhazsKICAgIGNhc2UgMTQ6IC8qIFVB
UlRJTVNDICovCiAgICAgICAgciA9IHMtJmd0O2ludF9lbmFibGVkOwogICAgICAgIGJyZWFr
OwogICAgY2FzZSAxNTogLyogVUFSVFJJUyAqLwogICAgICAgIHIgPSBzLSZndDtpbnRfbGV2
ZWw7CiAgICAgICAgYnJlYWs7CiAgICBjYXNlIDE2OiAvKiBVQVJUTUlTICovCiAgICAgICAg
ciA9IHMtJmd0O2ludF9sZXZlbCAmYW1wOyBzLSZndDtpbnRfZW5hYmxlZDsKICAgICAgICBi
cmVhazsKICAgIGNhc2UgMTg6IC8qIFVBUlRETUFDUiAqLwogICAgICAgIHIgPSBzLSZndDtk
bWFjcjsKICAgICAgICBicmVhazsKICAgIGNhc2UgMHgzZjggLi4uIDB4NDAwOgogICAgICAg
IHIgPSBzLSZndDtpZFsob2Zmc2V0IC0gMHhmZTApICZndDsmZ3Q7IDJdOwogICAgICAgIGJy
ZWFrOwogICAgZGVmYXVsdDoKICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJP
UiwKICAgICAgICAgICAgICAgICAgICAgICZxdW90O3BsMDExX3JlYWQ6IEJhZCBvZmZzZXQg
MHgleFxuJnF1b3Q7LCAoaW50KW9mZnNldCk7CiAgICAgICAgciA9IDA7CiAgICAgICAgYnJl
YWs7CiAgICB9CgogICAgdHJhY2VfcGwwMTFfcmVhZChvZmZzZXQsIHIsIHBsMDExX3JlZ25h
bWUob2Zmc2V0KSk7CiAgICByZXR1cm4gcjsKfQoKc3RhdGljIHZvaWQgcGwwMTFfd3JpdGUo
dm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LAogICAgICAgICAgICAgICAgICAgICAgICB1
aW50NjRfdCB2YWx1ZSwgdW5zaWduZWQgc2l6ZSkKewogICAgUEwwMTFTdGF0ZSAqcyA9IChQ
TDAxMVN0YXRlICopb3BhcXVlOwogICAgdW5zaWduZWQgY2hhciBjaDsKCiAgICB0cmFjZV9w
bDAxMV93cml0ZShvZmZzZXQsIHZhbHVlLCBwbDAxMV9yZWduYW1lKG9mZnNldCkpOwoKICAg
IHN3aXRjaCAob2Zmc2V0ICZndDsmZ3Q7IDIpIHsKICAgIGNhc2UgMDogLyogVUFSVERSICov
CiAgICAgICAgLyogPz8/IENoZWNrIGlmIHRyYW5zbWl0dGVyIGlzIGVuYWJsZWQuICAqLwog
ICAgICAgIGNoID0gdmFsdWU7CiAgICAgICAgLyogWFhYIHRoaXMgYmxvY2tzIGVudGlyZSB0
aHJlYWQuIFJld3JpdGUgdG8gdXNlCiAgICAgICAgICogcWVtdV9jaHJfZmVfd3JpdGUgYW5k
IGJhY2tncm91bmQgSS9PIGNhbGxiYWNrcyAqLwogICAgICAgIHFlbXVfY2hyX2ZlX3dyaXRl
X2FsbCgmYW1wO3MtJmd0O2NociwgJmFtcDtjaCwgMSk7CiAgICAgICAgcGwwMTFfbG9vcGJh
Y2tfdHgocywgY2gpOwogICAgICAgIHMtJmd0O2ludF9sZXZlbCB8PSBJTlRfVFg7CiAgICAg
ICAgcGwwMTFfdXBkYXRlKHMpOwogICAgICAgIGJyZWFrOwogICAgY2FzZSAxOiAvKiBVQVJU
UlNSL1VBUlRFQ1IgKi8KICAgICAgICBzLSZndDtyc3IgPSAwOwogICAgICAgIGJyZWFrOwog
ICAgY2FzZSA2OiAvKiBVQVJURlIgKi8KICAgICAgICAvKiBXcml0ZXMgdG8gRmxhZyByZWdp
c3RlciBhcmUgaWdub3JlZC4gICovCiAgICAgICAgYnJlYWs7CiAgICBjYXNlIDg6IC8qIFVB
UlRJTFBSICovCiAgICAgICAgcy0mZ3Q7aWxwciA9IHZhbHVlOwogICAgICAgIGJyZWFrOwog
ICAgY2FzZSA5OiAvKiBVQVJUSUJSRCAqLwogICAgICAgIHMtJmd0O2licmQgPSB2YWx1ZSAm
YW1wOyBJQlJEX01BU0s7CiAgICAgICAgcGwwMTFfdHJhY2VfYmF1ZHJhdGVfY2hhbmdlKHMp
OwogICAgICAgIGJyZWFrOwogICAgY2FzZSAxMDogLyogVUFSVEZCUkQgKi8KICAgICAgICBz
LSZndDtmYnJkID0gdmFsdWUgJmFtcDsgRkJSRF9NQVNLOwogICAgICAgIHBsMDExX3RyYWNl
X2JhdWRyYXRlX2NoYW5nZShzKTsKICAgICAgICBicmVhazsKICAgIGNhc2UgMTE6IC8qIFVB
UlRMQ1JfSCAqLwogICAgICAgIC8qIFJlc2V0IHRoZSBGSUZPIHN0YXRlIG9uIEZJRk8gZW5h
YmxlIG9yIGRpc2FibGUgKi8KICAgICAgICBpZiAoKHMtJmd0O2xjciBeIHZhbHVlKSAmYW1w
OyBMQ1JfRkVOKSB7CiAgICAgICAgICAgIHBsMDExX3Jlc2V0X2ZpZm8ocyk7CiAgICAgICAg
fQogICAgICAgIGlmICgocy0mZ3Q7bGNyIF4gdmFsdWUpICZhbXA7IExDUl9CUkspIHsKICAg
ICAgICAgICAgaW50IGJyZWFrX2VuYWJsZSA9IHZhbHVlICZhbXA7IExDUl9CUks7CiAgICAg
ICAgICAgIHFlbXVfY2hyX2ZlX2lvY3RsKCZhbXA7cy0mZ3Q7Y2hyLCBDSFJfSU9DVExfU0VS
SUFMX1NFVF9CUkVBSywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmFtcDticmVh
a19lbmFibGUpOwogICAgICAgICAgICBwbDAxMV9sb29wYmFja19icmVhayhzLCBicmVha19l
bmFibGUpOwogICAgICAgIH0KICAgICAgICBzLSZndDtsY3IgPSB2YWx1ZTsKICAgICAgICBw
bDAxMV9zZXRfcmVhZF90cmlnZ2VyKHMpOwogICAgICAgIGJyZWFrOwogICAgY2FzZSAxMjog
LyogVUFSVENSICovCiAgICAgICAgLyogPz8/IE5lZWQgdG8gaW1wbGVtZW50IHRoZSBlbmFi
bGUgYml0LiAgKi8KICAgICAgICBzLSZndDtjciA9IHZhbHVlOwogICAgICAgIHBsMDExX2xv
b3BiYWNrX21kbWN0cmwocyk7CiAgICAgICAgYnJlYWs7CiAgICBjYXNlIDEzOiAvKiBVQVJU
SUZTICovCiAgICAgICAgcy0mZ3Q7aWZsID0gdmFsdWU7CiAgICAgICAgcGwwMTFfc2V0X3Jl
YWRfdHJpZ2dlcihzKTsKICAgICAgICBicmVhazsKICAgIGNhc2UgMTQ6IC8qIFVBUlRJTVND
ICovCiAgICAgICAgcy0mZ3Q7aW50X2VuYWJsZWQgPSB2YWx1ZTsKICAgICAgICBwbDAxMV91
cGRhdGUocyk7CiAgICAgICAgYnJlYWs7CiAgICBjYXNlIDE3OiAvKiBVQVJUSUNSICovCiAg
ICAgICAgcy0mZ3Q7aW50X2xldmVsICZhbXA7PSB+dmFsdWU7CiAgICAgICAgcGwwMTFfdXBk
YXRlKHMpOwogICAgICAgIGJyZWFrOwogICAgY2FzZSAxODogLyogVUFSVERNQUNSICovCiAg
ICAgICAgcy0mZ3Q7ZG1hY3IgPSB2YWx1ZTsKICAgICAgICBpZiAodmFsdWUgJmFtcDsgMykg
ewogICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgJnF1b3Q7cGwwMTE6IERN
QSBub3QgaW1wbGVtZW50ZWRcbiZxdW90Oyk7CiAgICAgICAgfQogICAgICAgIGJyZWFrOwog
ICAgZGVmYXVsdDoKICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwKICAg
ICAgICAgICAgICAgICAgICAgICZxdW90O3BsMDExX3dyaXRlOiBCYWQgb2Zmc2V0IDB4JXhc
biZxdW90OywgKGludClvZmZzZXQpOwogICAgfQp9CgoKCgoKCnN0YXRpYyB2b2lkIHBsMDEx
X2xvb3BiYWNrX3R4KFBMMDExU3RhdGUgKnMsIHVpbnQzMl90IHZhbHVlKQp7CiAgICBpZiAo
IXBsMDExX2xvb3BiYWNrX2VuYWJsZWQocykpIHsKICAgICAgICByZXR1cm47CiAgICB9Cgog
ICAgLyoKICAgICAqIENhdmVhdDoKICAgICAqCiAgICAgKiBJbiByZWFsIGhhcmR3YXJlLCBU
WCBsb29wYmFjayBoYXBwZW5zIGF0IHRoZSBzZXJpYWwtYml0IGxldmVsCiAgICAgKiBhbmQg
dGhlbiByZWFzc2VtYmxlZCBieSB0aGUgUlggbG9naWNzIGJhY2sgaW50byBieXRlcyBhbmQg
cGxhY2VkCiAgICAgKiBpbnRvIHRoZSBSWCBmaWZvLiBUaGF0IGlzLCBsb29wYmFjayBoYXBw
ZW5zIGFmdGVyIFRYIGZpZm8uCiAgICAgKgogICAgICogQmVjYXVzZSB0aGUgcmVhbCBoYXJk
d2FyZSBUWCBmaWZvIGlzIHRpbWUtZHJhaW5lZCBhdCB0aGUgZnJhbWUKICAgICAqIHJhdGUg
Z292ZXJuZWQgYnkgdGhlIGNvbmZpZ3VyZWQgc2VyaWFsIGZvcm1hdCwgc29tZSBsb29wYmFj
awogICAgICogYnl0ZXMgaW4gVFggZmlmbyBtYXkgc3RpbGwgYmUgYWJsZSB0byBnZXQgaW50
byB0aGUgUlggZmlmbwogICAgICogdGhhdCBjb3VsZCBiZSBmdWxsIGF0IHRpbWVzIHdoaWxl
IGJlaW5nIGRyYWluZWQgYXQgc29mdHdhcmUKICAgICAqIHBhY2UuCiAgICAgKgogICAgICog
SW4gc3VjaCBzY2VuYXJpbywgdGhlIFJYIGRyYWluaW5nIHBhY2UgaXMgdGhlIG1ham9yIGZh
Y3RvcgogICAgICogZGVjaWRpbmcgd2hpY2ggbG9vcGJhY2sgYnl0ZXMgZ2V0IGludG8gdGhl
IFJYIGZpZm8sIHVubGVzcwogICAgICogaGFyZHdhcmUgZmxvdy1jb250cm9sIGlzIGVuYWJs
ZWQuCiAgICAgKgogICAgICogRm9yIHNpbXBsaWNpdHksIHRoZSBhYm92ZSBkZXNjcmliZWQg
aXMgbm90IGVtdWxhdGVkLgogICAgICovCiAgICBwbDAxMV9wdXRfZmlmbyhzLCB2YWx1ZSk7
Cn0KCnN0YXRpYyB2b2lkIHBsMDExX2xvb3BiYWNrX21kbWN0cmwoUEwwMTFTdGF0ZSAqcykK
ewogICAgdWludDMyX3QgY3IsIGZyLCBpbDsKCiAgICBpZiAoIXBsMDExX2xvb3BiYWNrX2Vu
YWJsZWQocykpIHsKICAgICAgICByZXR1cm47CiAgICB9CgogICAgLyoKICAgICAqIExvb3Bi
YWNrIHNvZnR3YXJlLWRyaXZlbiBtb2RlbSBjb250cm9sIG91dHB1dHMgdG8gbW9kZW0gc3Rh
dHVzIGlucHV0czoKICAgICAqICAgRlIuUkkgICZsdDs9IENSLk91dDIKICAgICAqICAgRlIu
RENEICZsdDs9IENSLk91dDEKICAgICAqICAgRlIuQ1RTICZsdDs9IENSLlJUUwogICAgICog
ICBGUi5EU1IgJmx0Oz0gQ1IuRFRSCiAgICAgKgogICAgICogVGhlIGxvb3BiYWNrIGhhcHBl
bnMgaW1tZWRpYXRlbHkgZXZlbiBpZiB0aGlzIGNhbGwgaXMgdHJpZ2dlcmVkCiAgICAgKiBi
eSBzZXR0aW5nIG9ubHkgQ1IuTEJFLgogICAgICoKICAgICAqIENUUy9SVFMgdXBkYXRlcyBk
dWUgdG8gZW5hYmxlZCBoYXJkd2FyZSBmbG93IGNvbnRyb2xzIGFyZSBub3QKICAgICAqIGRl
YWx0IHdpdGggaGVyZS4KICAgICAqLwogICAgY3IgPSBzLSZndDtjcjsKICAgIGZyID0gcy0m
Z3Q7ZmxhZ3MgJmFtcDsgfihQTDAxMV9GTEFHX1JJIHwgUEwwMTFfRkxBR19EQ0QgfAogICAg
ICAgICAgICAgICAgICAgICAgUEwwMTFfRkxBR19EU1IgfCBQTDAxMV9GTEFHX0NUUyk7CiAg
ICBmciB8PSAoY3IgJmFtcDsgQ1JfT1VUMikgPyBQTDAxMV9GTEFHX1JJICA6IDA7CiAgICBm
ciB8PSAoY3IgJmFtcDsgQ1JfT1VUMSkgPyBQTDAxMV9GTEFHX0RDRCA6IDA7CiAgICBmciB8
PSAoY3IgJmFtcDsgQ1JfUlRTKSAgPyBQTDAxMV9GTEFHX0NUUyA6IDA7CiAgICBmciB8PSAo
Y3IgJmFtcDsgQ1JfRFRSKSAgPyBQTDAxMV9GTEFHX0RTUiA6IDA7CgogICAgLyogQ2hhbmdl
IGludGVycnVwdHMgYmFzZWQgb24gdXBkYXRlZCBGUiAqLwogICAgaWwgPSBzLSZndDtpbnRf
bGV2ZWwgJmFtcDsgfihJTlRfRFNSIHwgSU5UX0RDRCB8IElOVF9DVFMgfCBJTlRfUkkpOwog
ICAgaWwgfD0gKGZyICZhbXA7IFBMMDExX0ZMQUdfRFNSKSA/IElOVF9EU1IgOiAwOwogICAg
aWwgfD0gKGZyICZhbXA7IFBMMDExX0ZMQUdfRENEKSA/IElOVF9EQ0QgOiAwOwogICAgaWwg
fD0gKGZyICZhbXA7IFBMMDExX0ZMQUdfQ1RTKSA/IElOVF9DVFMgOiAwOwogICAgaWwgfD0g
KGZyICZhbXA7IFBMMDExX0ZMQUdfUkkpICA/IElOVF9SSSAgOiAwOwoKICAgIHMtJmd0O2Zs
YWdzID0gZnI7CiAgICBzLSZndDtpbnRfbGV2ZWwgPSBpbDsKICAgIHBsMDExX3VwZGF0ZShz
KTsKfQoKCgoKCgpzdGF0aWMgdm9pZCBwbDAxMV9sb29wYmFja19icmVhayhQTDAxMVN0YXRl
ICpzLCBpbnQgYnJrX2VuYWJsZSkKewogICAgaWYgKGJya19lbmFibGUpIHsKICAgICAgICBw
bDAxMV9sb29wYmFja190eChzLCBEUl9CRSk7CiAgICB9Cn0KCnN0YXRpYyB2b2lkIHBsMDEx
X3NldF9yZWFkX3RyaWdnZXIoUEwwMTFTdGF0ZSAqcykKewojaWYgMAogICAgLyogVGhlIGRv
Y3Mgc2F5IHRoZSBSWCBpbnRlcnJ1cHQgaXMgdHJpZ2dlcmVkIHdoZW4gdGhlIEZJRk8gZXhj
ZWVkcwogICAgICAgdGhlIHRocmVzaG9sZC4gIEhvd2V2ZXIgbGludXggb25seSByZWFkcyB0
aGUgRklGTyBpbiByZXNwb25zZSB0byBhbgogICAgICAgaW50ZXJydXB0LiAgVHJpZ2dlcmlu
ZyB0aGUgaW50ZXJydXB0IHdoZW4gdGhlIEZJRk8gaXMgbm9uLWVtcHR5IHNlZW1zCiAgICAg
ICB0byBtYWtlIHRoaW5ncyB3b3JrLiAgKi8KICAgIGlmIChzLSZndDtsY3IgJmFtcDsgTENS
X0ZFTikKICAgICAgICBzLSZndDtyZWFkX3RyaWdnZXIgPSAocy0mZ3Q7aWZsICZndDsmZ3Q7
IDEpICZhbXA7IDB4MWM7CiAgICBlbHNlCiNlbmRpZgogICAgICAgIHMtJmd0O3JlYWRfdHJp
Z2dlciA9IDE7Cn0KCnN0YXRpYyB2b2lkIHBsMDExX3Jlc2V0KERldmljZVN0YXRlICpkZXYp
CnsKICAgIFBMMDExU3RhdGUgKnMgPSBQTDAxMShkZXYpOwoKICAgIHMtJmd0O2xjciA9IDA7
CiAgICBzLSZndDtyc3IgPSAwOwogICAgcy0mZ3Q7ZG1hY3IgPSAwOwogICAgcy0mZ3Q7aW50
X2VuYWJsZWQgPSAwOwogICAgcy0mZ3Q7aW50X2xldmVsID0gMDsKICAgIHMtJmd0O2lscHIg
PSAwOwogICAgcy0mZ3Q7aWJyZCA9IDA7CiAgICBzLSZndDtmYnJkID0gMDsKICAgIHMtJmd0
O3JlYWRfdHJpZ2dlciA9IDE7CiAgICBzLSZndDtpZmwgPSAweDEyOwogICAgcy0mZ3Q7Y3Ig
PSAweDMwMDsKICAgIHMtJmd0O2ZsYWdzID0gMDsKICAgIHBsMDExX3Jlc2V0X2ZpZm8ocyk7
Cn0KCnN0YXRpYyBpbmxpbmUgdm9pZCBwbDAxMV9yZXNldF9maWZvKFBMMDExU3RhdGUgKnMp
CnsKICAgIHMtJmd0O3JlYWRfY291bnQgPSAwOwogICAgcy0mZ3Q7cmVhZF9wb3MgPSAwOwoK
ICAgIC8qIFJlc2V0IEZJRk8gZmxhZ3MgKi8KICAgIHMtJmd0O2ZsYWdzICZhbXA7PSB+KFBM
MDExX0ZMQUdfUlhGRiB8IFBMMDExX0ZMQUdfVFhGRik7CiAgICBzLSZndDtmbGFncyB8PSBQ
TDAxMV9GTEFHX1JYRkUgfCBQTDAxMV9GTEFHX1RYRkU7Cn0KCnN0YXRpYyBib29sIHBsMDEx
X2lzX2ZpZm9fZW5hYmxlZChQTDAxMVN0YXRlICpzKQp7CiAgICByZXR1cm4gKHMtJmd0O2xj
ciAmYW1wOyBMQ1JfRkVOKSAhPSAwOwp9CgpzdGF0aWMgYm9vbCBwbDAxMV9sb29wYmFja19l
bmFibGVkKFBMMDExU3RhdGUgKnMpCnsKICAgIHJldHVybiAhIShzLSZndDtjciAmYW1wOyBD
Ul9MQkUpOwp9CgpzdGF0aWMgaW5saW5lIHVuc2lnbmVkIHBsMDExX2dldF9maWZvX2RlcHRo
KFBMMDExU3RhdGUgKnMpCnsKICAgIC8qIE5vdGU6IEZJRk8gZGVwdGggaXMgZXhwZWN0ZWQg
dG8gYmUgcG93ZXItb2YtMiAqLwogICAgcmV0dXJuIHBsMDExX2lzX2ZpZm9fZW5hYmxlZChz
KSA/IFBMMDExX0ZJRk9fREVQVEggOiAxOwp9CgoKCgpzdGF0aWMgdm9pZCBwbDAxMV9wdXRf
Zmlmbyh2b2lkICpvcGFxdWUsIHVpbnQzMl90IHZhbHVlKQp7CiAgICBQTDAxMVN0YXRlICpz
ID0gKFBMMDExU3RhdGUgKilvcGFxdWU7CiAgICBpbnQgc2xvdDsKICAgIHVuc2lnbmVkIHBp
cGVfZGVwdGg7CgogICAgcGlwZV9kZXB0aCA9IHBsMDExX2dldF9maWZvX2RlcHRoKHMpOwog
ICAgc2xvdCA9IChzLSZndDtyZWFkX3BvcyArIHMtJmd0O3JlYWRfY291bnQpICZhbXA7IChw
aXBlX2RlcHRoIC0gMSk7CiAgICBzLSZndDtyZWFkX2ZpZm9bc2xvdF0gPSB2YWx1ZTsKICAg
IHMtJmd0O3JlYWRfY291bnQrKzsKICAgIHMtJmd0O2ZsYWdzICZhbXA7PSB+UEwwMTFfRkxB
R19SWEZFOwogICAgdHJhY2VfcGwwMTFfcHV0X2ZpZm8odmFsdWUsIHMtJmd0O3JlYWRfY291
bnQpOwogICAgaWYgKHMtJmd0O3JlYWRfY291bnQgPT0gcGlwZV9kZXB0aCkgewogICAgICAg
IHRyYWNlX3BsMDExX3B1dF9maWZvX2Z1bGwoKTsKICAgICAgICBzLSZndDtmbGFncyB8PSBQ
TDAxMV9GTEFHX1JYRkY7CiAgICB9CiAgICBpZiAocy0mZ3Q7cmVhZF9jb3VudCA9PSBzLSZn
dDtyZWFkX3RyaWdnZXIpIHsKICAgICAgICBzLSZndDtpbnRfbGV2ZWwgfD0gSU5UX1JYOwog
ICAgICAgIHBsMDExX3VwZGF0ZShzKTsKICAgIH0KfQoKc3RhdGljIGludCBwbDAxMV9wb3N0
X2xvYWQodm9pZCAqb3BhcXVlLCBpbnQgdmVyc2lvbl9pZCkKewogICAgUEwwMTFTdGF0ZSog
cyA9IG9wYXF1ZTsKCiAgICAvKiBTYW5pdHktY2hlY2sgaW5wdXQgc3RhdGUgKi8KICAgIGlm
IChzLSZndDtyZWFkX3BvcyAmZ3Q7PSBBUlJBWV9TSVpFKHMtJmd0O3JlYWRfZmlmbykgfHwK
ICAgICAgICBzLSZndDtyZWFkX2NvdW50ICZndDsgQVJSQVlfU0laRShzLSZndDtyZWFkX2Zp
Zm8pKSB7CiAgICAgICAgcmV0dXJuIC0xOwogICAgfQoKICAgIGlmICghcGwwMTFfaXNfZmlm
b19lbmFibGVkKHMpICZhbXA7JmFtcDsgcy0mZ3Q7cmVhZF9jb3VudCAmZ3Q7IDAgJmFtcDsm
YW1wOyBzLSZndDtyZWFkX3BvcyAmZ3Q7IDApIHsKICAgICAgICAvKgogICAgICAgICAqIE9s
ZGVyIHZlcnNpb25zIG9mIFBMMDExIGRpZG4mIzM5O3QgZW5zdXJlIHRoYXQgdGhlIHNpbmds
ZQogICAgICAgICAqIGNoYXJhY3RlciBpbiB0aGUgRklGTyBpbiBGSUZPLWRpc2FibGVkIG1v
ZGUgaXMgaW4KICAgICAgICAgKiBlbGVtZW50IDAgb2YgdGhlIGFycmF5OyBjb252ZXJ0IHRv
IGZvbGxvdyB0aGUgY3VycmVudAogICAgICAgICAqIGNvZGUmIzM5O3MgYXNzdW1wdGlvbnMu
CiAgICAgICAgICovCiAgICAgICAgcy0mZ3Q7cmVhZF9maWZvWzBdID0gcy0mZ3Q7cmVhZF9m
aWZvW3MtJmd0O3JlYWRfcG9zXTsKICAgICAgICBzLSZndDtyZWFkX3BvcyA9IDA7CiAgICB9
CgogICAgcy0mZ3Q7aWJyZCAmYW1wOz0gSUJSRF9NQVNLOwogICAgcy0mZ3Q7ZmJyZCAmYW1w
Oz0gRkJSRF9NQVNLOwoKICAgIHJldHVybiAwOwp9Cgo8ZW0+IC4uLiBvbWl0dGluZyB0cmFj
ZXBvaW50IHN1cHBvcnQgLi4uIDwvZW0+CgpzdGF0aWMgdm9pZCBwbDAxMV9jbG9ja191cGRh
dGUodm9pZCAqb3BhcXVlLCBDbG9ja0V2ZW50IGV2ZW50KQp7CiAgICBQTDAxMVN0YXRlICpz
ID0gUEwwMTEob3BhcXVlKTsKCiAgICBwbDAxMV90cmFjZV9iYXVkcmF0ZV9jaGFuZ2Uocyk7
Cn0KCjxlbT4gLi4uIG9taXR0aW5nIHZtc3RhdGUgZGVmaW5pdGlvbnMgKFJ1c3QgQVBJIG5v
dCBmaW5hbCkgLi4uIDwvZW0+CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoK
CgoKCgoKCgoKCgoKc3RhdGljIHZvaWQgcGwwMTFfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2
LCBFcnJvciAqKmVycnApCnsKICAgIFBMMDExU3RhdGUgKnMgPSBQTDAxMShkZXYpOwoKICAg
IHFlbXVfY2hyX2ZlX3NldF9oYW5kbGVycygmYW1wO3MtJmd0O2NociwgcGwwMTFfY2FuX3Jl
Y2VpdmUsIHBsMDExX3JlY2VpdmUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGww
MTFfZXZlbnQsIE5VTEwsIHMsIE5VTEwsIHRydWUpOwp9CgoKCgoKCgoKCgoKc3RhdGljIHZv
aWQgcGwwMTFfdXBkYXRlKFBMMDExU3RhdGUgKnMpCnsKICAgIHVpbnQzMl90IGZsYWdzOwog
ICAgaW50IGk7CgogICAgZmxhZ3MgPSBzLSZndDtpbnRfbGV2ZWwgJmFtcDsgcy0mZ3Q7aW50
X2VuYWJsZWQ7CiAgICB0cmFjZV9wbDAxMV9pcnFfc3RhdGUoZmxhZ3MgIT0gMCk7CiAgICBm
b3IgKGkgPSAwOyBpICZsdDsgQVJSQVlfU0laRShzLSZndDtpcnEpOyBpKyspIHsKICAgICAg
ICBxZW11X3NldF9pcnEocy0mZ3Q7aXJxW2ldLCAoZmxhZ3MgJmFtcDsgaXJxbWFza1tpXSkg
IT0gMCk7CiAgICB9Cn0KCgoKCkRldmljZVN0YXRlICpwbDAxMV9jcmVhdGUoaHdhZGRyIGFk
ZHIsIHFlbXVfaXJxIGlycSwgQ2hhcmRldiAqY2hyKQp7CiAgICBEZXZpY2VTdGF0ZSAqZGV2
OwogICAgU3lzQnVzRGV2aWNlICpzOwoKCgoKCgogICAgZGV2ID0gcWRldl9uZXcoJnF1b3Q7
cGwwMTEmcXVvdDspOwogICAgcyA9IFNZU19CVVNfREVWSUNFKGRldik7CiAgICBxZGV2X3By
b3Bfc2V0X2NocihkZXYsICZxdW90O2NoYXJkZXYmcXVvdDssIGNocik7CiAgICBzeXNidXNf
cmVhbGl6ZV9hbmRfdW5yZWYocywgJmFtcDtlcnJvcl9mYXRhbCk7CiAgICBzeXNidXNfbW1p
b19tYXAocywgMCwgYWRkcik7CiAgICBzeXNidXNfY29ubmVjdF9pcnEocywgMCwgaXJxKTsK
CiAgICByZXR1cm4gZGV2Owp9CgoKCgoKCgoKCgoKCgoKCgoKCgpzdGF0aWMgdm9pZCBwbDAx
MV9sdW1pbmFyeV9pbml0KE9iamVjdCAqb2JqKQp7CiAgICBQTDAxMVN0YXRlICpzID0gUEww
MTEob2JqKTsKCiAgICBzLSZndDtpZCA9IHBsMDExX2lkX2x1bWluYXJ5Owp9CgpzdGF0aWMg
Y29uc3QgVHlwZUluZm8gcGwwMTFfbHVtaW5hcnlfaW5mbyA9IHsKICAgIC5uYW1lICAgICAg
ICAgID0gVFlQRV9QTDAxMV9MVU1JTkFSWSwKICAgIC5wYXJlbnQgICAgICAgID0gVFlQRV9Q
TDAxMSwKICAgIC5pbnN0YW5jZV9pbml0ID0gcGwwMTFfbHVtaW5hcnlfaW5pdCwKfTsKCgoK
CgpzdGF0aWMgdm9pZCBwbDAxMV9yZWdpc3Rlcl90eXBlcyh2b2lkKQp7CiAgICB0eXBlX3Jl
Z2lzdGVyX3N0YXRpYygmYW1wO3BsMDExX2FybV9pbmZvKTsKICAgIHR5cGVfcmVnaXN0ZXJf
c3RhdGljKCZhbXA7cGwwMTFfbHVtaW5hcnlfaW5mbyk7Cn0KCnR5cGVfaW5pdChwbDAxMV9y
ZWdpc3Rlcl90eXBlcyk8L2NvZGU+PC9wcmU+CjwvdGQ+PHRkPgo8cHJlPjxjb2RlPnVzZSBz
dGQ6OnsKICAgIGZmaTo6Q1N0ciwKICAgIG1lbTo6TWFudWFsbHlEcm9wLAogICAgb3BzOjpD
b250cm9sRmxvdywKfTsKCnVzZSBwaW5uZWRfaW5pdDo6e3Bpbl9kYXRhLCBwaW5faW5pdCwg
UGluSW5pdH07Cgp1c2UgcWVtdV9hcGk6OnsKICAgIG1lbW9yeTo6e01lbW9yeVJlZ2lvbiwg
TWVtb3J5UmVnaW9uT3BzLCBNZW1vcnlSZWdpb25PcHNCdWlsZGVyLCBod2FkZHJ9LAogICAg
Y2VsbDo6QnFsUmVmQ2VsbCwKICAgIGNoYXJkZXY6OntDaGFyQmFja2VuZCwgQ2hhckJhY2tl
bmRPcHMsIENoYXJkZXYsIEV2ZW50fSwKICAgIGlycTo6e0ludGVycnVwdFNvdXJjZSwgSVJR
U3RhdGV9LAogICAgcHJlbHVkZTo6KiwKICAgIHFkZXY6OntDbG9jaywgQ2xvY2tFdmVudCwg
RGV2aWNlSW1wbCwgRGV2aWNlU3RhdGUsIFByb3BlcnR5fSwKICAgIHFvbTo6e0NsYXNzSW5p
dEltcGwsIE9iamVjdEltcGwsIE9iamVjdFR5cGUsIE93bmVkfSwKICAgIHN5c2J1czo6e1N5
c0J1c0RldmljZSwgU3lzQnVzRGV2aWNlQ2xhc3N9LAogICAgcW9tX2lzYSwKfTsKCnVzZSBj
cmF0ZTo6ewogICAgZGV2aWNlX2NsYXNzLAogICAgcmVnaXN0ZXJzOjp7c2VsZiwgSW50ZXJy
dXB0fSwKICAgIFJlZ2lzdGVyT2Zmc2V0LAp9OwoKLy8vIEludGVnZXIgQmF1ZCBSYXRlIERp
dmlkZXIsIGBVQVJUSUJSRGAKY29uc3QgSUJSRF9NQVNLOiB1MzIgPSAweGZmZmY7CgovLy8g
RnJhY3Rpb25hbCBCYXVkIFJhdGUgRGl2aWRlciwgYFVBUlRGQlJEYApjb25zdCBGQlJEX01B
U0s6IHUzMiA9IDB4M2Y7CgovLyBEZXB0aCBvZiBVQVJUIEZJRk8gaW4gYnl0ZXMsIHdoZW4g
RklGTyBtb2RlIGlzIGVuYWJsZWQgKGVsc2UgZGVwdGggPT0gMSkKY29uc3QgUEwwMTFfRklG
T19ERVBUSDogdXNpemUgPSAxNjsKCiNbZGVyaXZlKENsb25lLCBDb3B5KV0Kc3RydWN0IERl
dmljZUlkKCZhbXA7JiMzOTtzdGF0aWMgW3U4OyA4XSk7CgppbXBsIERldmljZUlkIHsKICAg
IGNvbnN0IEFSTTogU2VsZiA9IFNlbGYoJmFtcDtbMHgxMSwgMHgxMCwgMHgxNCwgMHgwMCwg
MHgwZCwgMHhmMCwgMHgwNSwgMHhiMV0pOwogICAgY29uc3QgTFVNSU5BUlk6IFNlbGYgPSBT
ZWxmKCZhbXA7WzB4MTEsIDB4MDAsIDB4MTgsIDB4MDEsIDB4MGQsIDB4ZjAsIDB4MDUsIDB4
YjFdKTsKfQoKaW1wbCBzdGQ6Om9wczo6SW5kZXgmbHQ7aHdhZGRyJmd0OyBmb3IgRGV2aWNl
SWQgewogICAgdHlwZSBPdXRwdXQgPSB1ODsKCiAgICBmbiBpbmRleCgmYW1wO3NlbGYsIGlk
eDogaHdhZGRyKSAtJmd0OyAmYW1wO1NlbGY6Ok91dHB1dCB7CiAgICAgICAgJmFtcDtzZWxm
LjBbaWR4IGFzIHVzaXplXQogICAgfQp9CgoKCgoKCgoKCgoKCgoKCgoKCgovLy8gV2hpY2gg
Yml0cyBpbiB0aGUgaW50ZXJydXB0IHN0YXR1cyBtYXR0ZXIgZm9yIGVhY2ggb3V0Ym91bmQg
SVJRIGxpbmUgPwpjb25zdCBJUlFNQVNLOiBbdTMyOyA2XSA9IFsKICAgIC8qIGNvbWJpbmVk
IElSUSAqLwogICAgSW50ZXJydXB0OjpFLjAKICAgICAgICB8IEludGVycnVwdDo6TVMuMAog
ICAgICAgIHwgSW50ZXJydXB0OjpSVC4wCiAgICAgICAgfCBJbnRlcnJ1cHQ6OlRYLjAKICAg
ICAgICB8IEludGVycnVwdDo6UlguMCwKICAgIEludGVycnVwdDo6UlguMCwKICAgIEludGVy
cnVwdDo6VFguMCwKICAgIEludGVycnVwdDo6UlQuMCwKICAgIEludGVycnVwdDo6TVMuMCwK
ICAgIEludGVycnVwdDo6RS4wLApdOwoKI1tyZXByKEMpXQojW2Rlcml2ZShEZWJ1ZywgRGVm
YXVsdCwgcWVtdV9hcGlfbWFjcm9zOjpvZmZzZXRzKV0Kc3RydWN0IFBMMDExUmVnaXN0ZXJz
IHsKICAgIHB1YiBmbGFnczogcmVnaXN0ZXJzOjpGbGFncywKICAgIHB1YiBsaW5lX2NvbnRy
b2w6IHJlZ2lzdGVyczo6TGluZUNvbnRyb2wsCiAgICBwdWIgcmVjZWl2ZV9zdGF0dXNfZXJy
b3JfY2xlYXI6IHJlZ2lzdGVyczo6UmVjZWl2ZVN0YXR1c0Vycm9yQ2xlYXIsCiAgICBwdWIg
Y29udHJvbDogcmVnaXN0ZXJzOjpDb250cm9sLAogICAgcHViIGRtYWNyOiB1MzIsCiAgICBw
dWIgaW50X2VuYWJsZWQ6IHUzMiwKICAgIHB1YiBpbnRfbGV2ZWw6IHUzMiwKICAgIHB1YiBy
ZWFkX2ZpZm86IFt1MzI7IFBMMDExX0ZJRk9fREVQVEhdLAogICAgcHViIGlscHI6IHUzMiwK
ICAgIHB1YiBpYnJkOiB1MzIsCiAgICBwdWIgZmJyZDogdTMyLAogICAgcHViIGlmbDogdTMy
LAogICAgcHViIHJlYWRfcG9zOiB1c2l6ZSwKICAgIHB1YiByZWFkX2NvdW50OiB1c2l6ZSwK
ICAgIHB1YiByZWFkX3RyaWdnZXI6IHVzaXplLAp9CgojW3JlcHIoQyldCiNbZGVyaXZlKHFl
bXVfYXBpX21hY3Jvczo6T2JqZWN0LCBxZW11X2FwaV9tYWNyb3M6Om9mZnNldHMpXQojW3Bp
bl9kYXRhXQovLy8gUEwwMTEgRGV2aWNlIE1vZGVsIGluIFFFTVUKcHViIHN0cnVjdCBQTDAx
MVN0YXRlIHsKICAgICNbcGluXQogICAgcHViIHBhcmVudF9vYmo6IFN5c0J1c0RldmljZSwK
ICAgICNbcGluXQogICAgcHViIGlvbWVtOiBNZW1vcnlSZWdpb24sCiAgICAjW3Bpbl0KICAg
IHB1YiBjaGFyX2JhY2tlbmQ6IENoYXJCYWNrZW5kLAogICAgcHViIHJlZ3M6IEJxbFJlZkNl
bGwmbHQ7UEwwMTFSZWdpc3RlcnMmZ3Q7LAogICAgcHViIGludGVycnVwdHM6IFtJbnRlcnJ1
cHRTb3VyY2U7IElSUU1BU0subGVuKCldLAogICAgcHViIGNsb2NrOiBPd25lZCZsdDtDbG9j
ayZndDssCiAgICBwdWIgbWlncmF0ZV9jbG9jazogYm9vbCwKfQoKcW9tX2lzYSEoUEwwMTFT
dGF0ZSA6IFN5c0J1c0RldmljZSwgRGV2aWNlU3RhdGUsIE9iamVjdCk7CgpwdWIgc3RydWN0
IFBMMDExQ2xhc3MgewogICAgcGFyZW50X2NsYXNzOiAmbHQ7U3lzQnVzRGV2aWNlIGFzIE9i
amVjdFR5cGUmZ3Q7OjpDbGFzcywKICAgIC8vLyBUaGUgYnl0ZSBzdHJpbmcgdGhhdCBpZGVu
dGlmaWVzIHRoZSBkZXZpY2UuCiAgICBkZXZpY2VfaWQ6IERldmljZUlkLAp9Cgp1bnNhZmUg
aW1wbCBPYmplY3RUeXBlIGZvciBQTDAxMVN0YXRlIHsKICAgIHR5cGUgQ2xhc3MgPSBQTDAx
MUNsYXNzOwogICAgY29uc3QgVFlQRV9OQU1FOiAmYW1wOyYjMzk7c3RhdGljIENTdHIgPSBj
cmF0ZTo6VFlQRV9QTDAxMTsKfQoKaW1wbCBDbGFzc0luaXRJbXBsJmx0O1BMMDExQ2xhc3Mm
Z3Q7IGZvciBQTDAxMVN0YXRlIHsKICAgIGZuIGNsYXNzX2luaXQoa2xhc3M6ICZhbXA7bXV0
IFBMMDExQ2xhc3MpIHsKICAgICAgICBrbGFzcy5kZXZpY2VfaWQgPSBEZXZpY2VJZDo6QVJN
OwogICAgICAgICZsdDtTZWxmIGFzIENsYXNzSW5pdEltcGwmbHQ7U3lzQnVzRGV2aWNlQ2xh
c3MmZ3Q7Jmd0Ozo6Y2xhc3NfaW5pdCgmYW1wO211dCBrbGFzcy5wYXJlbnRfY2xhc3MpOwog
ICAgfQp9CgppbXBsIE9iamVjdEltcGwgZm9yIFBMMDExU3RhdGUgewogICAgdHlwZSBQYXJl
bnRUeXBlID0gU3lzQnVzRGV2aWNlOwoKICAgIGNvbnN0IElOU1RBTkNFX1BPU1RfSU5JVDog
T3B0aW9uJmx0O2ZuKCZhbXA7U2VsZikmZ3Q7ID0gU29tZShTZWxmOjpwb3N0X2luaXQpOwoK
ICAgIGZuIGluc3RhbmNlX2luaXQocGFyZW50X2luaXQ6IGltcGwgUGluSW5pdCZsdDtTeXNC
dXNEZXZpY2UmZ3Q7KSAtJmd0OyBpbXBsIFBpbkluaXQmbHQ7U2VsZiZndDsgewogICAgICAg
ICBzdGF0aWMgUEwwMTFfT1BTOiBNZW1vcnlSZWdpb25PcHMgPSBNZW1vcnlSZWdpb25PcHNC
dWlsZGVyOjombHQ7UEwwMTFTdGF0ZSZndDs6Om5ldygpCiAgICAgICAgICAgICAucmVhZCgm
YW1wO1BMMDExU3RhdGU6OnJlYWQpCiAgICAgICAgICAgICAud3JpdGUoJmFtcDtQTDAxMVN0
YXRlOjp3cml0ZSkKICAgICAgICAgICAgIC5uYXRpdmVfZW5kaWFuKCkKICAgICAgICAgICAg
IC5pbXBsX3NpemVzKDQsIDQpCiAgICAgICAgICAgICAuYnVpbGQoKTsKCiAgICAgICAgcGlu
X2luaXQhKCZhbXA7dGhpcyBpbiBQTDAxMVN0YXRlIHsKICAgICAgICAgICAgcGFyZW50X29i
aiAmbHQ7LSBwYXJlbnRfaW5pdCwKICAgICAgICAgICAgaW9tZW0gJmx0Oy0gTWVtb3J5UmVn
aW9uOjppbml0X2lvKAogICAgICAgICAgICAgICAgdGhpcywgJmFtcDtQTDAxMV9PUFMsICZx
dW90O3BsMDExJnF1b3Q7LCAweDEwMDAsCiAgICAgICAgICAgICksCiAgICAgICAgICAgIGNo
YXJfYmFja2VuZCAmbHQ7LSBDaGFyQmFja2VuZDo6bmV3KCksCiAgICAgICAgICAgIHJlZ3M6
IERlZmF1bHQ6OmRlZmF1bHQoKSwKICAgICAgICAgICAgaW50ZXJydXB0czogRGVmYXVsdDo6
ZGVmYXVsdCgpLAogICAgICAgICAgICBjbG9jayAmbHQ7LSBTZWxmOjppbml0X2Nsb2NrX2lu
KHRoaXMsICZxdW90O2NsayZxdW90OywKCSAgICAgICAgJmFtcDtTZWxmOjpjbG9ja191cGRh
dGUsCgkJQ2xvY2tFdmVudDo6Q2xvY2tVcGRhdGUpLAogICAgICAgICAgICBtaWdyYXRlX2Ns
b2NrOiBmYWxzZSwKICAgICAgICB9KQogICAgfQp9CgoKaW1wbCBEZXZpY2VJbXBsIGZvciBQ
TDAxMVN0YXRlIHsKICAgIGZuIHByb3BlcnRpZXMoKSAtJmd0OyAmYW1wOyYjMzk7c3RhdGlj
IFtQcm9wZXJ0eV0gewogICAgICAgICZhbXA7ZGV2aWNlX2NsYXNzOjpQTDAxMV9QUk9QRVJU
SUVTCiAgICB9CgogICAgZm4gdm1zZCgpIC0mZ3Q7IE9wdGlvbiZsdDsmYW1wOyYjMzk7c3Rh
dGljIFZNU3RhdGVEZXNjcmlwdGlvbiZndDsgewogICAgICAgIFNvbWUoJmFtcDtkZXZpY2Vf
Y2xhc3M6OlZNU1RBVEVfUEwwMTEpCiAgICB9CiAgICBjb25zdCBSRUFMSVpFOiBPcHRpb24m
bHQ7Zm4oJmFtcDtTZWxmKSZndDsgPSBTb21lKFNlbGY6OnJlYWxpemUpOwogICAgY29uc3Qg
UkVTRVQ6IE9wdGlvbiZsdDtmbigmYW1wO1NlbGYpJmd0OyA9IFNvbWUoU2VsZjo6cmVzZXQp
Owp9CgoKCgoKCmltcGwgQ2hhckJhY2tlbmRPcHMmbHQ7JiMzOTtfJmd0OyBmb3IgUEwwMTFT
dGF0ZSB7CiAgICBmbiBjYW5fcmVjZWl2ZSgmYW1wO3NlbGYpIC0mZ3Q7IHUzMiB7CiAgICAg
ICAgbGV0IHJlZ3MgPSBzZWxmLnJlZ3MuYm9ycm93KCk7CiAgICAgICAgLy8gdHJhY2VfcGww
MTFfY2FuX3JlY2VpdmUocy0mZ3Q7bGNyLCBzLSZndDtyZWFkX2NvdW50LCByKTsKICAgICAg
ICB1MzI6OmZyb20ocmVncy5yZWFkX2NvdW50ICZsdDsgcmVncy5maWZvX2RlcHRoKCkpCiAg
ICB9CgoKCgogICAgZm4gZXZlbnQoJmFtcDtzZWxmLCBldmVudDogRXZlbnQpIHsKICAgICAg
ICBsZXQgbXV0IHJlZ3MgPSBzZWxmLnJlZ3MuYm9ycm93X211dCgpOwogICAgICAgIGlmIGV2
ZW50ID09IEV2ZW50OjpDSFJfRVZFTlRfQlJFQUsgJmFtcDsmYW1wOyAhcmVncy5sb29wYmFj
a19lbmFibGVkKCkgewogICAgICAgICAgICBpZiByZWdzLnB1dF9maWZvKHUzMjo6ZnJvbShy
ZWdpc3RlcnM6OkRhdGE6OkJSRUFLKSkgewogICAgICAgICAgICAgICAgc2VsZi51cGRhdGUo
KTsKICAgICAgICAgICAgfQogICAgICAgIH0KICAgIH0KCiAgICBmbiByZWNlaXZlKCZhbXA7
c2VsZiwgYnVmOiAmYW1wO1t1OF0pIHsKICAgICAgICBsZXQgbXV0IHJlZ3MgPSBzZWxmLnJl
Z3MuYm9ycm93X211dCgpOwogICAgICAgIGlmICFyZWdzLmxvb3BiYWNrX2VuYWJsZWQoKSAm
YW1wOyZhbXA7ICFidWYuaXNfZW1wdHkoKSAmYW1wOyZhbXA7IHJlZ3MucHV0X2ZpZm8oYnVm
WzBdLmludG8oKSkgewogICAgICAgICAgICBzZWxmLnVwZGF0ZSgpOwogICAgICAgIH0KICAg
IH0KfQoKCgoKCgppbXBsIFBMMDExUmVnaXN0ZXJzIHsKICAgIHB1YiBmbiByZWFkKCZhbXA7
bXV0IHNlbGYsIG9mZnNldDogUmVnaXN0ZXJPZmZzZXQpIC0mZ3Q7IENvbnRyb2xGbG93Jmx0
O3UzMiwgdTMyJmd0OyB7CiAgICAgICAgdXNlIFJlZ2lzdGVyT2Zmc2V0OjoqOwoKCgoKICAg
ICAgICBDb250cm9sRmxvdzo6QnJlYWsobWF0Y2ggb2Zmc2V0IHsKICAgICAgICAgICAgRFIg
PSZndDsgewogICAgICAgICAgICAgICAgc2VsZi5mbGFncy5zZXRfcmVjZWl2ZV9maWZvX2Z1
bGwoZmFsc2UpOwogICAgICAgICAgICAgICAgbGV0IGMgPSBzZWxmLnJlYWRfZmlmb1tzZWxm
LnJlYWRfcG9zXTsKICAgICAgICAgICAgICAgIGlmIHNlbGYucmVhZF9jb3VudCAmZ3Q7IDAg
ewogICAgICAgICAgICAgICAgICAgIHNlbGYucmVhZF9jb3VudCAtPSAxOwogICAgICAgICAg
ICAgICAgICAgIHNlbGYucmVhZF9wb3MgPSAoc2VsZi5yZWFkX3BvcyArIDEpICZhbXA7IChz
ZWxmLmZpZm9fZGVwdGgoKSAtIDEpOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAg
ICAgaWYgc2VsZi5yZWFkX2NvdW50ID09IDAgewogICAgICAgICAgICAgICAgICAgIHNlbGYu
ZmxhZ3Muc2V0X3JlY2VpdmVfZmlmb19lbXB0eSh0cnVlKTsKICAgICAgICAgICAgICAgIH0K
ICAgICAgICAgICAgICAgIGlmIHNlbGYucmVhZF9jb3VudCArIDEgPT0gc2VsZi5yZWFkX3Ry
aWdnZXIgewogICAgICAgICAgICAgICAgICAgIHNlbGYuaW50X2xldmVsICZhbXA7PSAhSW50
ZXJydXB0OjpSWC4wOwogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgLy8gVXBk
YXRlIGVycm9yIGJpdHMuCgkJc2VsZi5yZWNlaXZlX3N0YXR1c19lcnJvcl9jbGVhciA9IHJl
Z2lzdGVyczo6RGF0YTo6ZnJvbShjKS5lcnJvcnMoKTsKICAgICAgICAgICAgICAgIC8vIE11
c3QgY2FsbCBxZW11X2Nocl9mZV9hY2NlcHRfaW5wdXQsIHNvIHJldHVybiBDb250aW51ZToK
ICAgICAgICAgICAgICAgIHJldHVybiBDb250cm9sRmxvdzo6Q29udGludWUoYyk7CiAgICAg
ICAgICAgIH0KICAgICAgICAgICAgUlNSID0mZ3Q7IHU4Ojpmcm9tKHNlbGYucmVjZWl2ZV9z
dGF0dXNfZXJyb3JfY2xlYXIpLmludG8oKSwKICAgICAgICAgICAgRlIgPSZndDsgdTE2Ojpm
cm9tKHNlbGYuZmxhZ3MpLmludG8oKSwKICAgICAgICAgICAgRkJSRCA9Jmd0OyBzZWxmLmZi
cmQsCiAgICAgICAgICAgIElMUFIgPSZndDsgc2VsZi5pbHByLAogICAgICAgICAgICBJQlJE
ID0mZ3Q7IHNlbGYuaWJyZCwKICAgICAgICAgICAgTENSX0ggPSZndDsgdTE2Ojpmcm9tKHNl
bGYubGluZV9jb250cm9sKS5pbnRvKCksCiAgICAgICAgICAgIENSID0mZ3Q7IHUxNjo6ZnJv
bShzZWxmLmNvbnRyb2wpLmludG8oKSwKICAgICAgICAgICAgRkxTID0mZ3Q7IHNlbGYuaWZs
LAogICAgICAgICAgICBJTVNDID0mZ3Q7IHNlbGYuaW50X2VuYWJsZWQsCiAgICAgICAgICAg
IFJJUyA9Jmd0OyBzZWxmLmludF9sZXZlbCwKICAgICAgICAgICAgTUlTID0mZ3Q7IHNlbGYu
aW50X2xldmVsICZhbXA7IHNlbGYuaW50X2VuYWJsZWQsCiAgICAgICAgICAgIElDUiA9Jmd0
OyB7CiAgICAgICAgICAgICAgICAvLyAmcXVvdDtUaGUgVUFSVElDUiBSZWdpc3RlciBpcyB0
aGUgaW50ZXJydXB0IGNsZWFyIHJlZ2lzdGVyIGFuZCBpcyB3cml0ZS1vbmx5JnF1b3Q7CiAg
ICAgICAgICAgICAgICAvLyBTb3VyY2U6IEFSTSBEREkgMDE4M0cgMy4zLjEzIEludGVycnVw
dCBDbGVhciBSZWdpc3RlciwgVUFSVElDUgogICAgICAgICAgICAgICAgMAogICAgICAgICAg
ICB9CiAgICAgICAgICAgIERNQUNSID0mZ3Q7IHNlbGYuZG1hY3IsCiAgICAgICAgfSkKICAg
IH0KCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCiAgICBwdWIgZm4gd3JpdGUoCiAg
ICAgICAgJmFtcDttdXQgc2VsZiwKICAgICAgICBvZmZzZXQ6IFJlZ2lzdGVyT2Zmc2V0LAog
ICAgICAgIHZhbHVlOiB1MzIsCiAgICAgICAgY2hhcl9iYWNrZW5kOiAmYW1wO0NoYXJCYWNr
ZW5kLAogICAgKSAtJmd0OyBib29sIHsKICAgICAgICAvLyBlcHJpbnRsbiEoJnF1b3Q7d3Jp
dGUgb2Zmc2V0IHtvZmZzZXR9IHZhbHVlIHt2YWx1ZX0mcXVvdDspOwogICAgICAgIHVzZSBS
ZWdpc3Rlck9mZnNldDo6KjsKICAgICAgICBtYXRjaCBvZmZzZXQgewogICAgICAgICAgICBE
UiA9Jmd0OyB7CiAgICAgICAgICAgICAgICAvLyA/Pz8gQ2hlY2sgaWYgdHJhbnNtaXR0ZXIg
aXMgZW5hYmxlZC4KICAgICAgICAgICAgICAgIGxldCBjaDogW3U4OyAxXSA9IFt2YWx1ZSBh
cyB1OF07CiAgICAgICAgICAgICAgICAvLyBYWFggdGhpcyBibG9ja3MgZW50aXJlIHRocmVh
ZC4gUmV3cml0ZSB0byB1c2UKICAgICAgICAgICAgICAgIC8vIHFlbXVfY2hyX2ZlX3dyaXRl
IGFuZCBiYWNrZ3JvdW5kIEkvTyBjYWxsYmFja3MKICAgICAgICAgICAgICAgIGxldCBfID0g
Y2hhcl9iYWNrZW5kLndyaXRlX2FsbCgmYW1wO2NoKTsKICAgICAgICAgICAgICAgIC8vIGlu
dGVycnVwdHMgYWx3YXlzIGNoZWNrZWQKICAgICAgICAgICAgICAgIGxldCBfID0gc2VsZi5s
b29wYmFja190eCh2YWx1ZSk7CiAgICAgICAgICAgICAgICBzZWxmLmludF9sZXZlbCB8PSBJ
bnRlcnJ1cHQ6OlRYLjA7CiAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICAgICAg
ICAgfQogICAgICAgICAgICBSU1IgPSZndDsgewogICAgICAgICAgICAgICAgc2VsZi5yZWNl
aXZlX3N0YXR1c19lcnJvcl9jbGVhci5yZXNldCgpOwogICAgICAgICAgICB9CiAgICAgICAg
ICAgIEZSID0mZ3Q7IHsKICAgICAgICAgICAgICAgIC8vIGZsYWcgd3JpdGVzIGFyZSBpZ25v
cmVkCiAgICAgICAgICAgIH0KICAgICAgICAgICAgSUxQUiA9Jmd0OyB7CiAgICAgICAgICAg
ICAgICBzZWxmLmlscHIgPSB2YWx1ZTsKICAgICAgICAgICAgfQogICAgICAgICAgICBJQlJE
ID0mZ3Q7IHsKICAgICAgICAgICAgICAgIHNlbGYuaWJyZCA9IHZhbHVlOwogICAgICAgICAg
ICB9CiAgICAgICAgICAgIEZCUkQgPSZndDsgewogICAgICAgICAgICAgICAgc2VsZi5mYnJk
ID0gdmFsdWU7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgTENSX0ggPSZndDsgewogICAg
ICAgICAgICAgICAgbGV0IHZhbHVlID0gdmFsdWUgYXMgdTE2OwogICAgICAgICAgICAgICAg
bGV0IG5ld192YWw6IHJlZ2lzdGVyczo6TGluZUNvbnRyb2wgPSB2YWx1ZS5pbnRvKCk7CiAg
ICAgICAgICAgICAgICAvLyBSZXNldCB0aGUgRklGTyBzdGF0ZSBvbiBGSUZPIGVuYWJsZSBv
ciBkaXNhYmxlCgkJaWYgc2VsZi5saW5lX2NvbnRyb2wuZmlmb3NfZW5hYmxlZCgpICE9IG5l
d192YWwuZmlmb3NfZW5hYmxlZCgpIHsKICAgICAgICAgICAgICAgICAgICBzZWxmLnJlc2V0
X3J4X2ZpZm8oKTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIGxldCB1cGRh
dGUgPSAoc2VsZi5saW5lX2NvbnRyb2wuc2VuZF9icmVhaygpICE9IG5ld192YWwuc2VuZF9i
cmVhaygpKSAmYW1wOyZhbXA7IHsKICAgICAgICAgICAgICAgICAgICBsZXQgYnJlYWtfZW5h
YmxlID0gbmV3X3ZhbC5zZW5kX2JyZWFrKCk7CiAgICAgICAgICAgICAgICAgICAgbGV0IF8g
PSBjaGFyX2JhY2tlbmQuc2VuZF9icmVhayhicmVha19lbmFibGUpOwogICAgICAgICAgICAg
ICAgICAgIHNlbGYubG9vcGJhY2tfYnJlYWsoYnJlYWtfZW5hYmxlKQogICAgICAgICAgICAg
ICAgfTsKICAgICAgICAgICAgICAgIHNlbGYubGluZV9jb250cm9sID0gbmV3X3ZhbDsKICAg
ICAgICAgICAgICAgIHNlbGYuc2V0X3JlYWRfdHJpZ2dlcigpOwogICAgICAgICAgICAgICAg
cmV0dXJuIHVwZGF0ZTsKICAgICAgICAgICAgfQogICAgICAgICAgICBDUiA9Jmd0OyB7CiAg
ICAgICAgICAgICAgICAvLyA/Pz8gTmVlZCB0byBpbXBsZW1lbnQgdGhlIGVuYWJsZSBiaXQu
CiAgICAgICAgICAgICAgICBsZXQgdmFsdWUgPSB2YWx1ZSBhcyB1MTY7CiAgICAgICAgICAg
ICAgICBzZWxmLmNvbnRyb2wgPSB2YWx1ZS5pbnRvKCk7CiAgICAgICAgICAgICAgICByZXR1
cm4gc2VsZi5sb29wYmFja19tZG1jdHJsKCk7CiAgICAgICAgICAgIH0KICAgICAgICAgICAg
RkxTID0mZ3Q7IHsKICAgICAgICAgICAgICAgIHNlbGYuaWZsID0gdmFsdWU7CiAgICAgICAg
ICAgICAgICBzZWxmLnNldF9yZWFkX3RyaWdnZXIoKTsKICAgICAgICAgICAgfQogICAgICAg
ICAgICBJTVNDID0mZ3Q7IHsKICAgICAgICAgICAgICAgIHNlbGYuaW50X2VuYWJsZWQgPSB2
YWx1ZTsKICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOwogICAgICAgICAgICB9CiAgICAg
ICAgICAgIFJJUyA9Jmd0OyB7fQogICAgICAgICAgICBNSVMgPSZndDsge30KICAgICAgICAg
ICAgSUNSID0mZ3Q7IHsKICAgICAgICAgICAgICAgIHNlbGYuaW50X2xldmVsICZhbXA7PSAh
dmFsdWU7CiAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICAgICAgICAgfQogICAg
ICAgICAgICBETUFDUiA9Jmd0OyB7CiAgICAgICAgICAgICAgICBzZWxmLmRtYWNyID0gdmFs
dWU7CiAgICAgICAgICAgICAgICBpZiB2YWx1ZSAmYW1wOyAzICZndDsgMCB7CiAgICAgICAg
ICAgICAgICAgICAgLy8gcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAsICZxdW90O3BsMDExOiBE
TUEgbm90IGltcGxlbWVudGVkXG4mcXVvdDspOwogICAgICAgICAgICAgICAgICAgIGVwcmlu
dGxuISgmcXVvdDtwbDAxMTogRE1BIG5vdCBpbXBsZW1lbnRlZCZxdW90Oyk7CiAgICAgICAg
ICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICAgICAgZmFsc2UKICAgIH0K
CgoKICAgICNbaW5saW5lXQogICAgI1ttdXN0X3VzZV0KICAgIGZuIGxvb3BiYWNrX3R4KCZh
bXA7bXV0IHNlbGYsIHZhbHVlOiB1MzIpIC0mZ3Q7IGJvb2wgewogICAgICAgIC8vIENhdmVh
dDoKICAgICAgICAvLwogICAgICAgIC8vIEluIHJlYWwgaGFyZHdhcmUsIFRYIGxvb3BiYWNr
IGhhcHBlbnMgYXQgdGhlIHNlcmlhbC1iaXQgbGV2ZWwKICAgICAgICAvLyBhbmQgdGhlbiBy
ZWFzc2VtYmxlZCBieSB0aGUgUlggbG9naWNzIGJhY2sgaW50byBieXRlcyBhbmQgcGxhY2Vk
CiAgICAgICAgLy8gaW50byB0aGUgUlggZmlmby4gVGhhdCBpcywgbG9vcGJhY2sgaGFwcGVu
cyBhZnRlciBUWCBmaWZvLgogICAgICAgIC8vCiAgICAgICAgLy8gQmVjYXVzZSB0aGUgcmVh
bCBoYXJkd2FyZSBUWCBmaWZvIGlzIHRpbWUtZHJhaW5lZCBhdCB0aGUgZnJhbWUKICAgICAg
ICAvLyByYXRlIGdvdmVybmVkIGJ5IHRoZSBjb25maWd1cmVkIHNlcmlhbCBmb3JtYXQsIHNv
bWUgbG9vcGJhY2sKICAgICAgICAvLyBieXRlcyBpbiBUWCBmaWZvIG1heSBzdGlsbCBiZSBh
YmxlIHRvIGdldCBpbnRvIHRoZSBSWCBmaWZvCiAgICAgICAgLy8gdGhhdCBjb3VsZCBiZSBm
dWxsIGF0IHRpbWVzIHdoaWxlIGJlaW5nIGRyYWluZWQgYXQgc29mdHdhcmUKICAgICAgICAv
LyBwYWNlLgogICAgICAgIC8vCiAgICAgICAgLy8gSW4gc3VjaCBzY2VuYXJpbywgdGhlIFJY
IGRyYWluaW5nIHBhY2UgaXMgdGhlIG1ham9yIGZhY3RvcgogICAgICAgIC8vIGRlY2lkaW5n
IHdoaWNoIGxvb3BiYWNrIGJ5dGVzIGdldCBpbnRvIHRoZSBSWCBmaWZvLCB1bmxlc3MKICAg
ICAgICAvLyBoYXJkd2FyZSBmbG93LWNvbnRyb2wgaXMgZW5hYmxlZC4KICAgICAgICAvLwog
ICAgICAgIC8vIEZvciBzaW1wbGljaXR5LCB0aGUgYWJvdmUgZGVzY3JpYmVkIGlzIG5vdCBl
bXVsYXRlZC4KICAgICAgICBzZWxmLmxvb3BiYWNrX2VuYWJsZWQoKSAmYW1wOyZhbXA7IHNl
bGYucHV0X2ZpZm8odmFsdWUpCiAgICB9CgoKCgoKICAgICNbbXVzdF91c2VdCiAgICBmbiBs
b29wYmFja19tZG1jdHJsKCZhbXA7bXV0IHNlbGYpIC0mZ3Q7IGJvb2wgewogICAgICAgIGlm
ICFzZWxmLmxvb3BiYWNrX2VuYWJsZWQoKSB7CiAgICAgICAgICAgIHJldHVybiBmYWxzZTsK
ICAgICAgICB9CgogICAgICAgIC8qCiAgICAgICAgICogTG9vcGJhY2sgc29mdHdhcmUtZHJp
dmVuIG1vZGVtIGNvbnRyb2wgb3V0cHV0cyB0byBtb2RlbSBzdGF0dXMgaW5wdXRzOgogICAg
ICAgICAqICAgRlIuUkkgICZsdDs9IENSLk91dDIKICAgICAgICAgKiAgIEZSLkRDRCAmbHQ7
PSBDUi5PdXQxCiAgICAgICAgICogICBGUi5DVFMgJmx0Oz0gQ1IuUlRTCiAgICAgICAgICog
ICBGUi5EU1IgJmx0Oz0gQ1IuRFRSCiAgICAgICAgICoKICAgICAgICAgKiBUaGUgbG9vcGJh
Y2sgaGFwcGVucyBpbW1lZGlhdGVseSBldmVuIGlmIHRoaXMgY2FsbCBpcyB0cmlnZ2VyZWQK
ICAgICAgICAgKiBieSBzZXR0aW5nIG9ubHkgQ1IuTEJFLgogICAgICAgICAqCiAgICAgICAg
ICogQ1RTL1JUUyB1cGRhdGVzIGR1ZSB0byBlbmFibGVkIGhhcmR3YXJlIGZsb3cgY29udHJv
bHMgYXJlIG5vdAogICAgICAgICAqIGRlYWx0IHdpdGggaGVyZS4KICAgICAgICAgKi8KCiAg
ICAgICAgc2VsZi5mbGFncy5zZXRfcmluZ19pbmRpY2F0b3Ioc2VsZi5jb250cm9sLm91dF8y
KCkpOwogICAgICAgIHNlbGYuZmxhZ3Muc2V0X2RhdGFfY2Fycmllcl9kZXRlY3Qoc2VsZi5j
b250cm9sLm91dF8xKCkpOwogICAgICAgIHNlbGYuZmxhZ3Muc2V0X2NsZWFyX3RvX3NlbmQo
c2VsZi5jb250cm9sLnJlcXVlc3RfdG9fc2VuZCgpKTsKICAgICAgICBzZWxmLmZsYWdzCiAg
ICAgICAgICAgIC5zZXRfZGF0YV9zZXRfcmVhZHkoc2VsZi5jb250cm9sLmRhdGFfdHJhbnNt
aXRfcmVhZHkoKSk7CgogICAgICAgIC8vIENoYW5nZSBpbnRlcnJ1cHRzIGJhc2VkIG9uIHVw
ZGF0ZWQgRlIKICAgICAgICBsZXQgbXV0IGlsID0gc2VsZi5pbnRfbGV2ZWw7CgogICAgICAg
IGlsICZhbXA7PSAhSW50ZXJydXB0OjpNUy4wOwoKICAgICAgICBpZiBzZWxmLmZsYWdzLmRh
dGFfc2V0X3JlYWR5KCkgewogICAgICAgICAgICBpbCB8PSBJbnRlcnJ1cHQ6OkRTUi4wOwog
ICAgICAgIH0KICAgICAgICBpZiBzZWxmLmZsYWdzLmRhdGFfY2Fycmllcl9kZXRlY3QoKSB7
CiAgICAgICAgICAgIGlsIHw9IEludGVycnVwdDo6RENELjA7CiAgICAgICAgfQogICAgICAg
IGlmIHNlbGYuZmxhZ3MuY2xlYXJfdG9fc2VuZCgpIHsKICAgICAgICAgICAgaWwgfD0gSW50
ZXJydXB0OjpDVFMuMDsKICAgICAgICB9CiAgICAgICAgaWYgc2VsZi5mbGFncy5yaW5nX2lu
ZGljYXRvcigpIHsKICAgICAgICAgICAgaWwgfD0gSW50ZXJydXB0OjpSSS4wOwogICAgICAg
IH0KICAgICAgICBzZWxmLmludF9sZXZlbCA9IGlsOwogICAgICAgIHRydWUKICAgIH0KCiAg
ICBmbiBsb29wYmFja19icmVhaygmYW1wO211dCBzZWxmLCBlbmFibGU6IGJvb2wpIC0mZ3Q7
IGJvb2wgewogICAgICAgIGVuYWJsZSAmYW1wOyZhbXA7IHNlbGYubG9vcGJhY2tfdHgodTMy
Ojpmcm9tKHJlZ2lzdGVyczo6RGF0YTo6QlJFQUspKQogICAgfQoKCgoKICAgIGZuIHNldF9y
ZWFkX3RyaWdnZXIoJmFtcDttdXQgc2VsZikgewogICAgICAgIHNlbGYucmVhZF90cmlnZ2Vy
ID0gMTsKICAgIH0KCgoKCgoKCgoKCgogICAgcHViIGZuIHJlc2V0KCZhbXA7bXV0IHNlbGYp
IHsKCgoKICAgICAgICBzZWxmLmxpbmVfY29udHJvbC5yZXNldCgpOwogICAgICAgIHNlbGYu
cmVjZWl2ZV9zdGF0dXNfZXJyb3JfY2xlYXIucmVzZXQoKTsKICAgICAgICBzZWxmLmRtYWNy
ID0gMDsKICAgICAgICBzZWxmLmludF9lbmFibGVkID0gMDsKICAgICAgICBzZWxmLmludF9s
ZXZlbCA9IDA7CiAgICAgICAgc2VsZi5pbHByID0gMDsKICAgICAgICBzZWxmLmlicmQgPSAw
OwogICAgICAgIHNlbGYuZmJyZCA9IDA7CiAgICAgICAgc2VsZi5yZWFkX3RyaWdnZXIgPSAx
OwogICAgICAgIHNlbGYuaWZsID0gMHgxMjsKICAgICAgICBzZWxmLmNvbnRyb2wucmVzZXQo
KTsKICAgICAgICBzZWxmLmZsYWdzLnJlc2V0KCk7CiAgICAgICAgc2VsZi5yZXNldF9yeF9m
aWZvKCk7CiAgICB9CgogICAgcHViIGZuIHJlc2V0X3J4X2ZpZm8oJmFtcDttdXQgc2VsZikg
ewogICAgICAgIHNlbGYucmVhZF9jb3VudCA9IDA7CiAgICAgICAgc2VsZi5yZWFkX3BvcyA9
IDA7CgogICAgICAgIC8qIFJlc2V0IHJlY2VpdmUgRklGTyBmbGFncyAqLwogICAgICAgIHNl
bGYuZmxhZ3Muc2V0X3JlY2VpdmVfZmlmb19mdWxsKGZhbHNlKTsKICAgICAgICBzZWxmLmZs
YWdzLnNldF9yZWNlaXZlX2ZpZm9fZW1wdHkodHJ1ZSk7CiAgICB9CgogICAgI1tpbmxpbmVd
CiAgICBwdWIgZm4gZmlmb19lbmFibGVkKCZhbXA7c2VsZikgLSZndDsgYm9vbCB7CiAgICAg
ICAgc2VsZi5saW5lX2NvbnRyb2wuZmlmb3NfZW5hYmxlZCgpID09IHJlZ2lzdGVyczo6TW9k
ZTo6RklGTwogICAgfQoKICAgICNbaW5saW5lXQogICAgcHViIGZuIGxvb3BiYWNrX2VuYWJs
ZWQoJmFtcDtzZWxmKSAtJmd0OyBib29sIHsKICAgICAgICBzZWxmLmNvbnRyb2wuZW5hYmxl
X2xvb3BiYWNrKCkKICAgIH0KCiAgICAjW2lubGluZV0KICAgIHB1YiBmbiBmaWZvX2RlcHRo
KCZhbXA7c2VsZikgLSZndDsgdXNpemUgewogICAgICAgIC8vIE5vdGU6IEZJRk8gZGVwdGgg
aXMgZXhwZWN0ZWQgdG8gYmUgcG93ZXItb2YtMgogICAgICAgIGlmIHNlbGYuZmlmb19lbmFi
bGVkKCkgewogICAgICAgICAgICByZXR1cm4gUEwwMTFfRklGT19ERVBUSDsKICAgICAgICB9
CiAgICAgICAgMQogICAgfQoKICAgICNbbXVzdF91c2VdCiAgICBwdWIgZm4gcHV0X2ZpZm8o
JmFtcDttdXQgc2VsZiwgdmFsdWU6IHUzMikgLSZndDsgYm9vbCB7CgoKCgogICAgICAgIGxl
dCBkZXB0aCA9IHNlbGYuZmlmb19kZXB0aCgpOwogICAgICAgIGFzc2VydCEoZGVwdGggJmd0
OyAwKTsKICAgICAgICBsZXQgc2xvdCA9IChzZWxmLnJlYWRfcG9zICsgc2VsZi5yZWFkX2Nv
dW50KSAmYW1wOyAoZGVwdGggLSAxKTsKICAgICAgICBzZWxmLnJlYWRfZmlmb1tzbG90XSA9
IHZhbHVlOwogICAgICAgIHNlbGYucmVhZF9jb3VudCArPSAxOwogICAgICAgIHNlbGYuZmxh
Z3Muc2V0X3JlY2VpdmVfZmlmb19lbXB0eShmYWxzZSk7CiAgICAgICAgaWYgc2VsZi5yZWFk
X2NvdW50ID09IGRlcHRoIHsKICAgICAgICAgICAgc2VsZi5mbGFncy5zZXRfcmVjZWl2ZV9m
aWZvX2Z1bGwodHJ1ZSk7CiAgICAgICAgfQoKICAgICAgICBpZiBzZWxmLnJlYWRfY291bnQg
PT0gc2VsZi5yZWFkX3RyaWdnZXIgewogICAgICAgICAgICBzZWxmLmludF9sZXZlbCB8PSBJ
bnRlcnJ1cHQ6OlJYLjA7CiAgICAgICAgICAgIHJldHVybiB0cnVlOwogICAgICAgIH0KICAg
ICAgICBmYWxzZQogICAgfQoKICAgIHB1YiBmbiBwb3N0X2xvYWQoJmFtcDttdXQgc2VsZikg
LSZndDsgUmVzdWx0Jmx0OygpLCAoKSZndDsgewogICAgICAgIC8qIFNhbml0eS1jaGVjayBp
bnB1dCBzdGF0ZSAqLwogICAgICAgIGlmIHNlbGYucmVhZF9wb3MgJmd0Oz0gc2VsZi5yZWFk
X2ZpZm8ubGVuKCkgfHwgc2VsZi5yZWFkX2NvdW50ICZndDsgc2VsZi5yZWFkX2ZpZm8ubGVu
KCkgewogICAgICAgICAgICByZXR1cm4gRXJyKCgpKTsKICAgICAgICB9CgogICAgICAgIGlm
ICFzZWxmLmZpZm9fZW5hYmxlZCgpICZhbXA7JmFtcDsgc2VsZi5yZWFkX2NvdW50ICZndDsg
MCAmYW1wOyZhbXA7IHNlbGYucmVhZF9wb3MgJmd0OyAwIHsKICAgICAgICAgICAgLy8gT2xk
ZXIgdmVyc2lvbnMgb2YgUEwwMTEgZGlkbiYjMzk7dCBlbnN1cmUgdGhhdCB0aGUgc2luZ2xl
CiAgICAgICAgICAgIC8vIGNoYXJhY3RlciBpbiB0aGUgRklGTyBpbiBGSUZPLWRpc2FibGVk
IG1vZGUgaXMgaW4KICAgICAgICAgICAgLy8gZWxlbWVudCAwIG9mIHRoZSBhcnJheTsgY29u
dmVydCB0byBmb2xsb3cgdGhlIGN1cnJlbnQKICAgICAgICAgICAgLy8gY29kZSYjMzk7cyBh
c3N1bXB0aW9ucy4KICAgICAgICAgICAgc2VsZi5yZWFkX2ZpZm9bMF0gPSBzZWxmLnJlYWRf
Zmlmb1tzZWxmLnJlYWRfcG9zXTsKICAgICAgICAgICAgc2VsZi5yZWFkX3BvcyA9IDA7CiAg
ICAgICAgfQoKICAgICAgICBzZWxmLmlicmQgJmFtcDs9IElCUkRfTUFTSzsKICAgICAgICBz
ZWxmLmZicmQgJmFtcDs9IEZCUkRfTUFTSzsKCiAgICAgICAgT2soKCkpCiAgICB9Cn0KCgoK
CgoKCgppbXBsIFBMMDExU3RhdGUgewogICAgZm4gY2xvY2tfdXBkYXRlKCZhbXA7c2VsZiwg
X2V2ZW50OiBDbG9ja0V2ZW50KSB7CiAgICAgICAgLyogcGwwMTFfdHJhY2VfYmF1ZHJhdGVf
Y2hhbmdlKHMpOyAqLwogICAgfQoKCgogICAgPGVtPi8vIHBhcnQgb2YgcGwwMTFfaW5pdCBp
biBDOiA8L2VtPgogICAgZm4gcG9zdF9pbml0KCZhbXA7c2VsZikgewogICAgICAgIHNlbGYu
aW5pdF9tbWlvKCZhbXA7c2VsZi5pb21lbSk7CiAgICAgICAgZm9yIGlycSBpbiBzZWxmLmlu
dGVycnVwdHMuaXRlcigpIHsKICAgICAgICAgICAgc2VsZi5pbml0X2lycShpcnEpOwogICAg
ICAgIH0KICAgIH0KCiAgICA8ZW0+Ly8gcGFydCBvZiBwbDAxMV9yZWFkIGluIEM6IDwvZW0+
CiAgICBwdWIgZm4gcmVhZCgmYW1wO3NlbGYsIG9mZnNldDogaHdhZGRyLCBfc2l6ZTogdTMy
KSAtJmd0OyB1NjQgewogICAgICAgIGxldCBtdXQgcmVncyA9IHNlbGYucmVncy5ib3Jyb3df
bXV0KCk7CgoKICAgICAgICBsZXQgcmVzdWx0ID0gbWF0Y2ggUmVnaXN0ZXJPZmZzZXQ6OnRy
eV9mcm9tKG9mZnNldCkgewogICAgICAgICAgICBFcnIodikgaWYgKDB4M2Y4Li4weDQwMCku
Y29udGFpbnMoJmFtcDsodiAmZ3Q7Jmd0OyAyKSkgPSZndDsgewogICAgICAgICAgICAgICAg
bGV0IGRldmljZV9pZCA9IHNlbGYuZ2V0X2NsYXNzKCkuZGV2aWNlX2lkOwogICAgICAgICAg
ICAgICAgcmV0dXJuIHU2NDo6ZnJvbShkZXZpY2VfaWRbKG9mZnNldCAtIDB4ZmUwKSAmZ3Q7
Jmd0OyAyXSkKICAgICAgICAgICAgfQoKICAgICAgICAgICAgRXJyKF8pID0mZ3Q7IHsKICAg
ICAgICAgICAgICAgIC8vIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAmcXVvdDtw
bDAxMV9yZWFkOiBCYWQgb2Zmc2V0IDB4JXhcbiZxdW90OywgKGludClvZmZzZXQpOwogICAg
ICAgICAgICAgICAgcmV0dXJuIDAKICAgICAgICAgICAgfQogICAgICAgICAgICBPayhmaWVs
ZCkgPSZndDsgcmVncy5yZWFkKGZpZWxkKSwKICAgICAgICB9OwoKICAgICAgICBtYXRjaCBy
ZXN1bHQgewogICAgICAgICAgICBDb250cm9sRmxvdzo6QnJlYWsodmFsdWUpID0mZ3Q7IHZh
bHVlLmludG8oKSwKICAgICAgICAgICAgQ29udHJvbEZsb3c6OkNvbnRpbnVlKHZhbHVlKSA9
Jmd0OyB7CiAgICAgICAgICAgICAgICBzZWxmLnVwZGF0ZSgpOwogICAgICAgICAgICAgICAg
c2VsZi5jaGFyX2JhY2tlbmQuYWNjZXB0X2lucHV0KCk7CiAgICAgICAgICAgICAgICB2YWx1
ZS5pbnRvKCkKICAgICAgICAgICAgfSwKICAgICAgICB9CiAgICB9CgogICAgPGVtPi8vIHBh
cnQgb2YgcGwwMTFfd3JpdGUgaW4gQzogPC9lbT4KICAgIHB1YiBmbiB3cml0ZSgmYW1wO3Nl
bGYsIG9mZnNldDogaHdhZGRyLCB2YWx1ZTogdTY0LCBfc2l6ZTogdTMyKSB7CiAgICAgICAg
bGV0IG11dCByZWdzID0gc2VsZi5yZWdzLmJvcnJvd19tdXQoKTsKICAgICAgICBpZiBsZXQg
T2soZmllbGQpID0gUmVnaXN0ZXJPZmZzZXQ6OnRyeV9mcm9tKG9mZnNldCkgewogICAgICAg
ICAgICBpZiByZWdzLndyaXRlKGZpZWxkLCB2YWx1ZSBhcyB1MzIsICZhbXA7c2VsZi5jaGFy
X2JhY2tlbmQpIHsKICAgICAgICAgICAgICAgIHNlbGYudXBkYXRlKCk7CiAgICAgICAgICAg
IH0KICAgICAgICB9IGVsc2UgewogICAgICAgICAgICBlcHJpbnRsbiEoJnF1b3Q7d3JpdGUg
YmFkIG9mZnNldCB7b2Zmc2V0fSB2YWx1ZSB7dmFsdWV9JnF1b3Q7KTsKICAgICAgICB9CiAg
ICB9CgogICAgcHViIGZuIHJlYWxpemUoJmFtcDtzZWxmKSB7CiAgICAgICAgc2VsZi5jaGFy
X2JhY2tlbmQuZW5hYmxlX2hhbmRsZXJzKHNlbGYpOwogICAgfQoKCgoKCiAgICA8ZW0+Ly8g
cGFydCBvZiBwbDAxMV9yZXNldCBpbiBDOiA8L2VtPgogICAgcHViIGZuIHJlc2V0KCZhbXA7
c2VsZikgewogICAgICAgIHNlbGYucmVncy5ib3Jyb3dfbXV0KCkucmVzZXQoKTsKICAgIH0K
CiAgICA8ZW0+Ly8gcGFydCBvZiBwbDAxMV9wb3N0X2xvYWQgaW4gQzogPC9lbT4KICAgIHB1
YiBmbiBwb3N0X2xvYWQoJmFtcDtzZWxmLCBfdmVyc2lvbl9pZDogdTMyKSAtJmd0OyBSZXN1
bHQmbHQ7KCksICgpJmd0OyB7CiAgICAgICAgc2VsZi5yZWdzLmJvcnJvd19tdXQoKS5wb3N0
X2xvYWQoKQogICAgfQoKICAgIHB1YiBmbiB1cGRhdGUoJmFtcDtzZWxmKSB7CiAgICAgICAg
bGV0IHJlZ3MgPSBzZWxmLnJlZ3MuYm9ycm93KCk7CiAgICAgICAgbGV0IGZsYWdzID0gcmVn
cy5pbnRfbGV2ZWwgJmFtcDsgcmVncy5pbnRfZW5hYmxlZDsKICAgICAgICBmb3IgKGlycSwg
aSkgaW4gc2VsZi5pbnRlcnJ1cHRzLml0ZXIoKS56aXAoSVJRTUFTSykgewogICAgICAgICAg
ICBpcnEuc2V0KGZsYWdzICZhbXA7IGkgIT0gMCk7CiAgICAgICAgfQogICAgfQp9CgoKLy8v
ICMgU2FmZXR5Ci8vLwovLy8gV2UgZXhwZWN0IHRoZSBGRkkgdXNlciBvZiB0aGlzIGZ1bmN0
aW9uIHRvIHBhc3MgYSB2YWxpZCBwb2ludGVyIGZvciBgY2hyYAovLy8gYW5kIGBpcnFgLgoj
W25vX21hbmdsZV0KcHViIHVuc2FmZSBleHRlcm4gJnF1b3Q7QyZxdW90OyBmbiBwbDAxMV9j
cmVhdGUoCiAgICBhZGRyOiB1NjQsCiAgICBpcnE6ICptdXQgSVJRU3RhdGUsCiAgICBjaHI6
ICptdXQgQ2hhcmRldiwKKSAtJmd0OyAqbXV0IERldmljZVN0YXRlIHsKICAgIC8vIFNBRkVU
WTogVGhlIGNhbGxlcnMgcHJvbWlzZSB0aGF0IHRoZXkgaGF2ZSBvd25lZCByZWZlcmVuY2Vz
LgogICAgLy8gcGwwMTFfY3JlYXRlIGRvZXMgbm90IHJlbGVhc2UgdGhlbS4KICAgIGxldCBp
cnEgPSB1bnNhZmUgeyBNYW51YWxseURyb3A6Om5ldyhPd25lZDo6Jmx0O0lSUVN0YXRlJmd0
Ozo6ZnJvbV9yYXcoaXJxKSkgfTsKICAgIGxldCBjaHIgPSB1bnNhZmUgeyBNYW51YWxseURy
b3A6Om5ldyhPd25lZDo6Jmx0O0NoYXJkZXYmZ3Q7Ojpmcm9tX3JhdyhjaHIpKSB9OwoKICAg
IGxldCBkZXYgPSBQTDAxMVN0YXRlOjpuZXcoKTsKICAgIGRldi5wcm9wX3NldF9jaHIoJnF1
b3Q7Y2hhcmRldiZxdW90OywgJmFtcDtjaHIpOwogICAgZGV2LnJlYWxpemUoKTsKICAgIGRl
di5tbWlvX21hcCgwLCBhZGRyKTsKICAgIGRldi5jb25uZWN0X2lycSgwLCAmYW1wO2lycSk7
CgogICAgT3duZWQ6OmludG9fcmF3KGRldi51cGNhc3QoKSkKfQoKI1tyZXByKEMpXQojW2Rl
cml2ZShxZW11X2FwaV9tYWNyb3M6Ok9iamVjdCldCiNbcGluX2RhdGFdCi8vLyBQTDAxMSBM
dW1pbmFyeSBkZXZpY2UgbW9kZWwuCnB1YiBzdHJ1Y3QgUEwwMTFMdW1pbmFyeSB7CiAgICAj
W3Bpbl0KICAgIHBhcmVudF9vYmo6IFBMMDExU3RhdGUsCn0KCmltcGwgT2JqZWN0SW1wbCBm
b3IgUEwwMTFMdW1pbmFyeSB7CiAgICB0eXBlIFBhcmVudFR5cGUgPSBQTDAxMVN0YXRlOwoK
ICAgIGZuIGluc3RhbmNlX2luaXQocGFyZW50X2luaXQ6IGltcGwgUGluSW5pdCZsdDtQTDAx
MVN0YXRlJmd0OykgLSZndDsgaW1wbCBQaW5Jbml0Jmx0O1NlbGYmZ3Q7IHsKICAgICAgICBw
aW5faW5pdCEoUEwwMTFMdW1pbmFyeSB7CiAgICAgICAgICAgIHBhcmVudF9vYmogJmx0Oy0g
cGFyZW50X2luaXQKICAgICAgICB9KQogICAgfQp9CgppbXBsIENsYXNzSW5pdEltcGwmbHQ7
UEwwMTFDbGFzcyZndDsgZm9yIFBMMDExTHVtaW5hcnkgewogICAgZm4gY2xhc3NfaW5pdChr
bGFzczogJmFtcDttdXQgUEwwMTFDbGFzcykgewogICAgICAgIGtsYXNzLmRldmljZV9pZCA9
IERldmljZUlkOjpMVU1JTkFSWTsKICAgICAgICAmbHQ7U2VsZiBhcyBDbGFzc0luaXRJbXBs
Jmx0O1N5c0J1c0RldmljZUNsYXNzJmd0OyZndDs6OmNsYXNzX2luaXQoJmFtcDttdXQga2xh
c3MucGFyZW50X2NsYXNzKTsKICAgIH0KfQoKcW9tX2lzYSEoUEwwMTFMdW1pbmFyeSA6IFBM
MDExU3RhdGUsIFN5c0J1c0RldmljZSwgRGV2aWNlU3RhdGUsIE9iamVjdCk7Cgp1bnNhZmUg
aW1wbCBPYmplY3RUeXBlIGZvciBQTDAxMUx1bWluYXJ5IHsKICAgIHR5cGUgQ2xhc3MgPSAm
bHQ7UEwwMTFTdGF0ZSBhcyBPYmplY3RUeXBlJmd0Ozo6Q2xhc3M7CiAgICBjb25zdCBUWVBF
X05BTUU6ICZhbXA7JiMzOTtzdGF0aWMgQ1N0ciA9IGNyYXRlOjpUWVBFX1BMMDExX0xVTUlO
QVJZOwp9CgppbXBsIERldmljZUltcGwgZm9yIFBMMDExTHVtaW5hcnkge308L2NvZGU+PC9w
cmU+CjwvdGQ+PHRkPjxwcmUgc3R5bGU9ImNvbG9yOiBibHVlOyI+CgoKCgoKCgoKClRoZXNl
IGFyZSB0aGUgQVBJcyB0aGF0IFBMMDExIG5lZWRzLiAgTm90ZSB0aGF0ICJiaW5kaW5ncyIg
aXMgbm90CmltcG9ydGVkLCBhbGwgdGhhdCBpcyBuZWNlc3NhcnkgZnJvbSBDIGNvZGUgaGFz
IGJlZW4gd3JhcHBlZC4KCgoicHJlbHVkZSIgcHJvdmlkZXMgc29tZSBjb21tb25seSB1c2Vk
IHN0cnVjdHMgYW5kIHRyYWl0cyBmcm9tIGFsbCBvdmVyIHRoZSBwbGFjZS4KCgoKInFvbV9p
c2EiIGlzIGEgbWFjcm8gdGhhdCBoZWxwcyB3aXRoIGRlZmluaW5nIFFPTSBzdXBlcmNsYXNz
ZXMuCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgpSdXN0IG9ubHkgYWxsb3dzIGluZGV4aW5n
IGFycmF5cyB3aXRoIHVzaXplIGluZGljZXMuICBBZGRpbmcKdGhlIEluZGV4IGltcGxlbWVu
dGF0aW9uIGhlcmUgcmVtb3ZlcyBzb21lIGNhc3RzIGVsc2V3aGVyZS4KCgoKCgoKRXF1aXZh
bGVudCBjb2RlIGlzIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IHRoZSBSdXN0IGNvbXBp
bGVyCih3aXRoICIjW2Rlcml2ZShEaXNwbGF5KV0iIG9uIHRoZSBSZWdpc3Rlck9mZnNldHMg
ZW51bSkuCgoKCgoKCgoKCgoKCgoKCgpJIGFtIG5vdCB2ZXJ5IGhhcHB5IHdpdGggdGhlIGhh
bmRsaW5nIG9mIGJpdG1hc2tzLiAgSXQgaXMgY2VydGFpbmx5CnBvc3NpYmxlIHRvIGRvIGJl
dHRlci4gIFRoZSAiLjAiIGlzIGJlY2F1c2UgdGhlIGNvZGUgdHJpZXMgdG8gdXNlIGEKdHlw
ZSB3cmFwcGluZyB0aGUgYml0ZmllbGRzLCBidXQgbm90IGhhcmQgZW5vdWdoIChpcnFfbGV2
ZWwsIGlycV9lbmFibGUsCklSUU1BU0sgYXJlIGFsbCB1MzIpLgoKUnVzdCBzdXBwb3J0cyBv
cGVyYXRvciBvdmVybG9hZGluZywgYnV0IG5vdCB5ZXQgaW4gImNvbnN0IiBjb250ZXh0ICh3
aGljaAppbmNsdWRlcyAiY29uc3QiIGRlY2xhcmF0aW9ucyBvZiBjb3Vyc2UsIGJ1dCBhbHNv
ICJzdGF0aWMiIGRlY2xhcmF0aW9ucykuClRoaXMgaXMgdGhlIG1haW4gbWlzc2luZyBiaXQg
dGhhdCBJIHdvdWxkIGxpa2UgZnJvbSB0aGUgbGFuZ3VhZ2UuClVudGlsIGl0J3MgaW4sIHdl
J2xsIHByb2JhYmx5IGhhdmUgdG8gYmUgY3JlYXRpdmUuCgoKCgoKCk5lZWRlZCBmb3IgbWln
cmF0aW9uIHRvIGxvb2sgYXQgdGhlIHN0cnVjdC4KCgpUaGVzZSBhcmUgZWZmZWN0aXZlbHkg
Yml0ZmllbGRzLCBidXQgcG9ydGFibGUuICBUaGV5IGFyZSBoYW5kbGVkIGJ5IGFuCmV4dGVy
bmFsIGNyYXRlLiAgVGhlIHVnbHktaXNoIHBhcnQgYWJvdXQgaXQgaXMgdGhhdCBpdCBkb2Vz
bid0IHN1cHBvcnQKY29uc3Qgb3BlcmF0aW9uIHZlcnkgd2VsbCwgc28gaXQgaXMgaGFyZCB0
byBkZWZpbmUgY29uc3RhbnRzIGZvciByZWN1cnJpbmcKdmFsdWVzIG9mIHRoZSByZWdpc3Rl
cnMgKGUuZy4gRFJfQkUgaW4gdGhlIEMgY29kZSkuCgoKCnJlYWRfZmlmbyBjb3VsZCBiZSBh
IFtyZWdpc3RlcnM6OkRhdGE7IFBMMDExX0ZJRk9fREVQVEhdIHRvby4gIE5vdCBzdXJlCmhv
dyB0aGF0IHdvdWxkIHdvcmsgZm9yIHZtc3RhdGUsIHRob3VnaC4KCk5vdGUgaG93IHRoZSBt
dXRhYmxlIHBhcnQgb2YgdGhlIGRldmljZSBpcyBpbiBhIHNlcGFyYXRlIHN0cnVjdC4gIFRo
aXMgaXMKYmVjYXVzZSBhbGwgYWNjZXNzZXMgY2hlY2sgdGhhdCB0aGUgQlFMIGlzIHRha2Vu
LCBhbmQgYWxzbyB0aGF0IGl0IGlzCm5vdCBkcm9wcGVkIGluIHRoZSBtaWRkbGUgb2YgdGhl
IGFjY2Vzcy4KCgoKCgoKCgoKCgoKCgoKVGhpcyBpcyB3aGF0IGRvZXMgdGhlIEJRTCBjaGVj
a3MuCgpPd25lZDw+IG1lYW5zIHRoYXQgaW5zdGFuY2VfaW5pdCB3aWxsIGFkZCBhIHJlZmVy
ZW5jZSB0byB0aGUgQ2xvY2sgYW5kCmluc3RhbmNlX2ZpbmFsaXplIHdpbGwgZHJvcCBpdC4K
CgpBbGwgc3VwZXJjbGFzc2VzIGhhdmUgdG8gYmUgbGlzdGVkLCBhdCBsZWFzdCBmb3Igbm93
LgoKSSB0b29rIGEgc2xpZ2h0bHkgZGlmZmVyZW50IGFwcHJvYWNoIHRvIHRoZSBkZXZpY2Vf
aWQsIGNvbXBhcmVkIHRvIHRoZQpDIGNvZGUsIG1vc3RseSB0byB0ZXN0IHdoZXRoZXIgdGhl
IGJpbmRpbmdzIHRvIFFPTSBjb3VsZCBkbyBzdWJjbGFzc2VzCm9mIGNsYXNzZXMgdGhhdCB3
cml0dGVuIHRoZW1zZWx2ZXMgaW4gUnVzdC4KCgoKVGhlc2UgInVuc2FmZSBpbXBsIiBhcmUg
dGhlIG9ubHkgb2NjdXJyZW5jZSBvZiB1bnNhZmUgaW4gdGhlIHdob2xlIGRldmljZS4KVGhl
IE9iamVjdFR5cGUgdHJhaXQgaXMgbWFya2VkIHVuc2FmZSBiZWNhdXNlIGl0IHRlbGxzIHRo
ZSBRT00gQyBjb2RlCnRoaW5ncyBhYm91dCB0aGUgbGF5b3V0IG9mIHRoZSBQTDAxMVN0YXRl
IHN0cnVjdCB0aGF0IHRoZSB1c2VyIGlzIHByb21pc2luZy4KT2Z0ZW4sIHVuc2FmZSB0cmFp
dHMgYXJlIGdlbmVyYXRlZCBieSBtYWNyb3MgdGhhdCBjYW4gcHJvbWlzZSBzYWZldHkuCgoK
CgpBcyB3aWxsIGJlIHZpc2libGUgbGF0ZXIsIGltcGxlbWVudGluZyBjbGFzc19pbml0IGZv
ciAic3RhbmRhcmQiIGNsYXNzZXMKaXMgbW9zdGx5IGF1dG9tYXRpYywgYnV0IHlvdSBkbyBo
YXZlIHRvIHJlY3Vyc2UgdXAgdGhlIGNsYXNzIGhpZXJhcmNoeS4KCgpUaGlzIHRyYWl0IGRl
ZmluZXMgd2hhdCBnb2VzIGluIFR5cGVJbmZvLgoKClNvIGZvciBleGFtcGxlIHRoaXMgZW5k
cyB1cCBpbiB0aGUgVHlwZUluZm8ncyAuaW5zdGFuY2VfcG9zdF9pbml0IGZpZWxkLgoKClRo
aXMgIkJ1aWxkZXIiIHRoaW5nIGlzIGEgY29tbW9uIGlkaW9tIGluIFJ1c3Qgd2hlbmV2ZXIg
bm90IGFsbCBmaWVsZHMKYXJlIGFsd2F5cyBpbml0aWFsaXplZC4gIE5vdGUgdGhhdCB0aGUg
TWVtb3J5UmVnaW9uT3BzIGNhbGxiYWNrcyBhcmUKbWV0aG9kcyBpbXBsZW1lbnRlZCBieSBz
dHJ1Y3QgUEwwMTFTdGF0ZS4KCgoKClJ1c3QgY29kZSB3aWxsIGhhdmUgYSBzdHJpY3RlciBz
ZXBhcmF0aW9uIGJldHdlZW4gaW5zdGFuY2VfaW5pdCBhbmQKaW5zdGFuY2VfcG9zdF9pbml0
LiAgVGhlIGZvcm1lciBvbmx5IHRha2VzIGNhcmUgb2YgaW5pdGlhbGl6aW5nIHRoZSBzdHJ1
Y3QKKHRoZSBjb21waWxlciBjaGVja3MgdGhhdCBhbGwgZmllbGRzIGFyZSBpbml0aWFsaXpl
ZCEpLCB0aGUgbGF0dGVyIGRvZXMKb3RoZXIgaW5pdGlhbGl6YXRpb24gc3VjaCBhcyBzeXNi
dXNfaW5pdF9pcnEgYW5kIHN5c2J1c19pbml0X21taW8uCgoKCgoKCgoKCgoKCgpUaGlzIHRy
YWl0IGRlZmluZXMgd2hhdCBnb2VzIGluIERldmljZUNsYXNzLgpUaGlzIGNhbiBiZWNvbWUg
YSAiY29uc3QiIHdpdGggYSBuZXdlciB2ZXJzaW9uIG9mIFJ1c3QuCgoKClRoaXMgb25lIHRv
by4KCgpSZWFsaXplIGFuZCByZXNldCBjYW5ub3QgYmUgZnVuY3Rpb25zIGluIHRoZSBEZXZp
Y2VJbXBsIHRyYWl0LCBiZWNhdXNlCnRoZSBjb2RlIGFsc28gbmVlZHMgdG8gZXhwcmVzcyB0
aGVpciAqYWJzZW5jZSogKGkuZS4gdXNpbmcgdGhlIGluaGVyaXRlZAppbXBsZW1lbnRhdGlv
bikuICBJdCBtYXkgYmUgcG9zc2libGUgaW4gdGhlIGZ1dHVyZSB0byB1c2UgcHJvY2VkdXJh
bAptYWNyb3MgdG8gbWFrZSB0aGluZ3MgbG9vayBhIGJpdCBtb3JlIG5hdHVyYWwuICBCdXQg
dGhpcyBpcyBhdCB0aGUgY29zdApvZiBoaWRkZW4gbWFnaWMsIHNvIGl0IGlzIGEgZGViYXRh
YmxlIGJlbmVmaXQgYW5kIGZvciBub3cgSSBhbSBsZWF2aW5nCmV2ZXJ5dGhpbmcgdmlzaWJs
ZS4KCgoKSGVyZSBJIGFtIHRha2luZyBhIHNsaWdodGx5IGRpZmZlcmVudCBhcHByb2FjaCB0
byBjYWxsYmFja3M7CnRoZXkgYXJlIGFsbCBpbmNsdWRlZCBpbiBhIHRyYWl0IGluc3RlYWQg
b2YgYmVpbmcgbWV0aG9kcwppbXBsZW1lbnRlZCBieSBQTDAxMVN0YXRlLiAgVGhlIHJlYXNv
biBmb3IgdGhpcyBpcyBvbmx5IHRvCmZpZ3VyZSBvdXQgdGhlIGFkdmFudGFnZXMgYW5kIGRp
c2FkdmFudGFnZXM7IHRoaXMgb25lIHNlZW1zCm1vcmUgIm5hdHVyYWwiIGJ1dCBpZiBvbmUg
aGFzIG1vcmUgdGhhbiBvbmUgY2hhcmFjdGVyIGRldmljZQpiYWNrZW5kIHRoaW5ncyB3aWxs
IGdldCBtb3JlIGNvbXBsaWNhdGVkLiAgSSBhbSBsZWFuaW5nCnRvd2FyZHMgdXNpbmcgbWV0
aG9kcyBmb3IgY2hhcmFjdGVyIGRldmljZSBvcHMgYXMgd2VsbCwgd2hpY2gKaXMgYWxzbyBt
b3JlIHNpbWlsYXIgdG8gdGhlIEMgQVBJLiAgSSBzdGFydGVkIHdpdGggdGhpcyBvdGhlcgpp
ZGVhIGJ1dCBvbmx5IGJlY2F1c2UgSSBoYWRuJ3QgeWV0IGZpZ3VyZWQgb3V0IG1ldGhvZHMu
CgoKCgpEdWUgdG8gdGhlIHNlcGFyYXRpb24gYmV0d2VlbiByZWdpc3RlcnMgYW5kIHRoZSBy
ZXN0LCBJCnJlbW92ZWQgZXh0ZXJuYWwgaW50ZXJydXB0IHVwZGF0ZSBmcm9tIHB1dF9maWZv
IChhbmQgbWFkZQppdCAjW211c3RfdXNlXSB0byBub3QgZm9yZ2V0KS4KCgoKCgoKCgoKCgoK
CgoKClRoZSBidWxrIG9mIHJlYWQgYW5kIHdyaXRlIGlzIGltcGxlbWVudGVkIG9uIFBMMDEx
UmVnaXN0ZXJzLiAgcmVhZCBtdXN0CmFsc28gcmV0dXJuIHdoZXRoZXIgdG8gaW52b2tlIHFl
bXVfY2hyX2ZlX2FjY2VwdF9pbnB1dCgpIGJlY2F1c2UgaXQgY2FuCmNhdXNlIHJlZW50cmFu
Y3kgaW4gUEwwMTFSZWdpc3RlcnMgKHdoaWNoIGlzIGFuIGFib3J0ISkuICAiQ29udHJvbEZs
b3ciCmlzIGhvdyB0aGUgY29kZSBjdXJyZW50bHkgcmVwcmVzZW50cyBpdCwgYnV0IGl0J3Mg
cHJvYmFibHkgZWFzaWVzdCB0bwpyZXR1cm4gYSAoYm9vbCwgdTMyKSBwYWlyLiAgUGF0Y2hl
cyBhcmUgd2VsY29tZS4KCkhlcmUgYXJlIGJpdGZpZWxkcyBpbiBhY3Rpb24uCgoKCgoKCgoK
CgoKCkFub3RoZXIgY2FzZSBpbiB3aGljaCBiaXRtYXNrcyBuZWVkIG1vcmUgd29yay4KCgpU
aGUgUlNSIGxheW91dCBpcyB0aGUgc2FtZSBhcyBiaXRzIDgtMTUgb2YgRFIuICBUaGlzIGlz
IHZpc2libGUgaW4KdGhlIHR5cGVzLiAgSW5jbHVkaW5nIHRoZSAiZXJyb3IgY2xlYXIiIHBh
cnQgaW4gdGhlIG5hbWUgaXMgcHJvYmFibHkKd3JvbmcgYmVjYXVzZSB0aGUgcmVnaXN0ZXIg
aXMgb25seSB1c2VkIGZvciB0aGUgcmVhZHMgcGFydC4gIEl0J3MKbm90IGEgIndyaXRlIDEg
Y2xlYXJzIiByZWdpc3RlcnMsIGZvciBleGFtcGxlLiAgVGhpcyBicmluZ3MgYW5vdGhlcgpx
dWVzdGlvbjogd2hhdCBpcyB0aGUgYmVzdCB3YXkgdG8gbm90ZSBvcGVuIGltcHJvdmVtZW50
cyBpbiB0aGUgZmlsZXM/CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoK
CgoKCgoKCgoKCgpBZ2FpbiBzb21lIGRpZmZlcmVuY2VzIGR1ZSB0byByZWFkIGFuZCB3cml0
ZSBiZWluZyBpbXBsZW1lbnRlZCBvbiBhCnNlcGFyYXRlIHN0cnVjdDoKCi0gcmVhZC93cml0
ZSBnZXRzIHRoZSByZWdpc3RlciBkZWNvZGVkIGludG8gYW4gZW51bQoKLSB3cml0ZSBzZW5k
IGJhY2sgd2hldGhlciB0byBsb29rIGZvciBpbnRlcnJ1cHRzCgotIHdyaXRlIGFsc28gbmVl
ZHMgdG8ga25vdyB0aGUgY2hhcmFjdGVyIGJhY2tlbmQuICBBbHRlcm5hdGl2ZWx5CiAgUEww
MTFSZWdpc3RlcnMgY291bGQga25vdyBpdHMgb3V0ZXIgUEwwMTFTdGF0ZSwgb3IKICAiY2hh
cl9iYWNrZW5kLndyaXRlX2FsbCgmY2gpOyIgY291bGQgYmUgc2VudCBkb3duIGFzIGEKICBj
bG9zdXJlCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoK
CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgpUaGlzICNbbXVzdF91c2VdIGFza3MgdGhlIGNh
bGxlciB0byBjaGVjayB0aGUgcmVzdWx0ICh0byBjYWxsCnVwZGF0ZSgpIG9yIHRvIHBhc3Mg
aXQgdXApLgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgpU
aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIGJpdGZpZWxkcyBoZXJlIGFuZCBpbnRzIGJlbG93IGlz
IGEgYml0IGphcnJpbmcuCkkgZ3Vlc3MgaWYgb25lIGRvZXNuJ3QgbGlrZSBpdCwgdGhleSBj
b3VsZCB1c2UgdTMyIGxpa2UgaW4gQyBmb3IgYm90aApyZWdpc3RlcnMgYW5kIGludGVycnVw
dHM7IG5vYm9keSB3b3VsZCBjb21wbGFpbiB0byBiZSBob25lc3QuICBVc2luZyB0aGUKbGFu
Z3VhZ2UncyBmZWF0dXJlcyBtYWtlcyBpdCBjbGVhciB3aGVyZSB0aGV5IGxlYXZlIHNvbWV0
aGluZyB0byBiZQpkZXNpcmVkLCBhdCBsZWFzdCAoYW5kIEkgZG9uJ3QgZmVlbCBsaWtlIHVu
ZG9pbmcgdGhlIHdvcmsgdGhhdCBNYW5vcwpkaWQgaW4gY29udmVydGluZyB0aGUgcmVnaXN0
ZXJzIHRvIGJpdGZpZWxkcy4uLikuCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKVGhp
cyBpcyBzdGlsbCB0aGUgaW1wbGVtZW50YXRpb24gb2YgUEwwMTFSZWdpc3RlcnMuCgoKCgoK
CgoKCgoKCkFuZCB0aGlzIGFzIHdlbGwuICBUaGlzIGlzICpub3QqIHRoZSByZXNldCBtZXRo
b2Qgb24gRGV2aWNlU3RhdGUuCgoKCgoKCgoKCgoKCgoKVGhpcyBsaW5lIHJlc2V0cyBhbGwg
RklGTyBmbGFncywgYm90aCB0cmFuc21pdCBhbmQgcmVjZWl2ZS4KCgoKCgoKCgoKCgoKCgoK
CgoKCgoKCgoKCgoKCgoKCkFub3RoZXIgI1ttdXN0X3VzZV0gaGVyZS4KCgoKCgoKCgoKCgoK
CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKClRoaXMgaXMgdGhlIGNh
bGxiYWNrIGZvciBzZWxmLmNsb2NrCgoKCgoKVGhpcyB3YXMgdGhlIG1pc3NpbmcgcGFydCBv
ZiBwbDAxMV9pbml0LiAgQlRXLCB2bXN0YXRlIGlzCnRoZSBtYWluIG1pc3NpbmcgcGFydC4K
CgoKCgoKQW5kIGhlcmUgYXJlIGFsc28gdGhlIHJlbWFpbmluZyBwYXJ0cyBvZiByZWFkIGFu
ZCB3cml0ZS4KCkFmdGVyIGJvcnJvd19tdXQoKSwgInJlZ3MiIHByb3ZpZGVzIGEgd2F5IHRv
IHdyaXRlIHRvIHNlbGYucmVncywKYnV0IG9ubHkgd2hpbGUgdGhlIGxvY2FsIHZhcmlhYmxl
IHJlZ3MgaXMgbGl2ZS4KCkNvbnZlcnRpbmcgZnJvbSBod2FkZHIgdG8gZW51bSByZXR1cm5z
IEVycihvZmZzZXQpIGlmIHRoZSBvZmZzZXQgaXMKbm90IHBhcnQgb2YgYSBrbm93biByZWdp
c3Rlci4gIFRoaXMgaXMgb25lIGNhc2Ugd2hlcmUgbWFjcm9zIGFyZSBnb29kCmF0IGhpZGlu
ZyBjb2RlIHRoYXQgImRvZXMgdGhlIG9idmlvdXMgdGhpbmciLiAgUnVzdCBtYWNyb3MgYXJl
IG1vcmUKcG93ZXJmdWwgYW5kIGdlbmVyYWxseSBkbyBub3QgaGF2ZSB0aGUgc2FtZSBpc3N1
ZXMgYXMgQywgYnV0IHRoZXkgY2FuCm1ha2UgdGhlIGNvZGUgdW5yZWFkYWJsZSBpZiBkb25l
IHdyb25nLgoKCkxvZ2dpbmcgYW5kIHRyYWNpbmcgYXJlIHRoZSBtYWluIG1pc3NpbmcgcGll
Y2VzLgoKCgpyZWdzIGlzIGRyb3BwZWQgaGVyZS4gIFNvbWVvbmUgZWxzZSBjYW4gbm93IHdy
aXRlIHRvIHNlbGYucmVncy4KCkFnYWluLCBkb24ndCByZWFkIHRvbyBtdWNoIGluIEJyZWFr
L0NvbnRpbnVlLiAgVGhlIGludGVudGlvbiBvZgp0aGUgQ29udHJvbEZsb3cgZW51bSBkb2Vz
bid0IHJlYWxseSBtYXRjaCBob3cgUUVNVSB1c2VzIGl0IGhlcmUuCgphY2NlcHRfaW5wdXQg
aXMgY2FsbGVkIGFmdGVyIGNvbWluZyBiYWNrOyB0aGUgY2hhcmFjdGVyIGRldmljZQpjYWxs
YmFja3MgZG8gdGhlaXIgb3duIGJvcnJvd19tdXQoKS4KCgoKCgoKCgoKCgoKCgoKCgoKCgoK
CgoKClBMMDExU3RhdGUgbmVlZHMgYSBjb3VwbGUgbW9yZSBmb3J3YXJkaW5nIG1ldGhvZHMg
dG8gY2FsbCBpbnRvIFBMMDExUmVnaXN0ZXJzLgpJbiBmYWN0LCAqdGhpcyogaXMgdGhlIGlt
cGxlbWVudGF0aW9uIG9mIHRoZSAicmVzZXQiIG1ldGhvZCBpbiBEZXZpY2VTdGF0ZS4KCgoK
CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKVGhlIHdyYXBwZXJzIGZvciBxZGV2X3Byb3Bfc2V0
X2NociBhbmQgc3lzYnVzX2Nvbm5lY3RfaXJxIHRha2UgYW4KT3duZWQ8Li4uPiBzbWFydCBw
b2ludGVyLiAgVGhpcyBzbWFydCBwb2ludGVyIGF1dG9tYXRpY2FsbHkgaGFuZGxlcwpvYmpl
Y3RfcmVmKCkgYW5kIG9iamVjdF91bnJlZigpLiAgVGhlIHJlYXNvbiB3aHkgdGhleSB0YWtl
IE93bmVkPC4uLj4gYW5kCm5vdCBhIG5vcm1hbCByZWZlcmVuY2UgaXMgdG8gc2lnbmlmeSB0
aGF0IHRoZSBvYmplY3QgaXMgaGVhcCBhbGxvY2F0ZWQuClNpbmNlIEMgZ2F2ZSBhIHJhdyBw
b2ludGVyLCBjcmVhdGUgdGhlIE93bmVkIGJ5IGhhbmQgaW4gdW5zYWZlIGJsb2Nrcy4KQWxz
byB0ZWxsIFJ1c3Qgbm90IHRvIGRyb3AgaXQsIGkuZS4gbm90IHRvIGNhbGwgb2JqZWN0X3Vu
cmVmKCkuCgouLi4gSSBsaWVkLCB0aGUgZnVuY3Rpb25zIHRha2UgKmEgcmVmZXJlbmNlKiB0
byB0aGUgcG9pbnRlciAodGhhdCBpcywgYW4KJk93bmVkPC4uLj4pLiAgVGhpcyBtZWFucyB0
aGF0IHRoZXkgKnJlcXVlc3QqIHlvdSB0byBvd24gYSByZWZlcmVuY2UgYnV0CnRoZXkgZG9u
J3Qgc3RlYWwgaXQgZnJvbSB5b3UuICBUaGUgZnVuY3Rpb25zIHRha2UgY2FyZSBvZiBhZGRp
bmcgdGhlaXIgb3duCnJlZmVyZW5jZTogcWVtdV9jaHJfZmVfaW5pdCgpIGRvZXMgaXQ7IG9y
LCBpZiBJJ20gbm90IHdyb25nLCBpdCBzaG91bGQpLgoKUEwwMTFTdGF0ZTo6bmV3KCkgZ2F2
ZSB1cyBhbiBPd25lZDxQTDAxMVN0YXRlPiwgY29udmVydGluZyBpdCB3aXRoIGludG9fcmF3
CmdpdmVzIG93bmVyc2hpcCBvZiB0aGUgcmVmZXJlbmNlIHRvIHRoZSBDIGNhbGxlci4KCgoK
CgoKCgoKCgoKCmluc3RhbmNlX2luaXQgaXMgbWFuZGF0b3J5IGluIFJ1c3Q7IHRoZSBjYXNl
IHdoZXJlIHlvdSBoYXZlIG5vIGFkZGl0aW9uYWwKZmllbGRzIHRvIGluaXRpYWxpemUgKGFz
IGlzIHRoZSBjYXNlIGhlcmUpIGlzIHJhcmUgZW5vdWdoLiAgVGhpcyBpcyB3aHkKaXQgaXMg
YW4gImZuIiBhbmQgbm90IGEgImNvbnN0IiBsaWtlIFJFQUxJWkUgYW5kIFJFU0VULiAgSWYg
bmVlZGVkLCBpdAp3b3VsZCBiZSBwb3NzaWJsZSB0byB3cml0ZSBhIHNlcGFyYXRlIHdyYXBw
ZXIgZm9yICJ0aGlzIGNsYXNzIG9ubHkKZGlmZmVycyBmcm9tIGl0cyBzdXBlcmNsYXNzIGlu
IGl0cyBjbGFzc19pbml0IG1ldGhvZCIuCgoKQWdhaW4sIHRoZSBpbXBsZW1lbnRhdGlvbiBp
cyBkaWZmZXJlbnQgc28gdGhpcyBpcyBhIGNsYXNzX2luaXQgbWV0aG9kLgoKCgoKCgoKCgoK
CgoKVGhlIGRlZmF1bHRzIGFyZSBnb29kLiBObyBuZWVkIHRvIG92ZXJyaWRlIHJlYWxpemUg
YW5kIHJlc2V0LCBzbyB0aGUgZGVmYXVsdCBvZgpOb25lIGZvciB0aGUgUkVBTElaRSBhbmQg
UkVTRVQgY29uc3RhbnRzIGFyZSBvay4KCnR5cGVfcmVnaXN0ZXJfc3RhdGljIGlzIGhhbmRs
ZWQgYXV0b21hZ2ljYWxseSBieSAjW2Rlcml2ZShPYmplY3QpXSwKYXMgYW4gaW5pdGlhbCB0
YXN0aW5nIG9mIHdoYXQgbWFjcm9zIGNvdWxkIGRvLiAgVGhlIG1haW4gdGhpbmdzIHRoYXQK
d2UgY291bGQgZG8gd2l0aCBtYWNyb3MgaXMgaW1wbGVtZW50aW5nIHFkZXYgcHJvcGVydGll
cyBpbiBhIHR5cGUtc2FmZQptYW5uZXIsIGFuZCBwZXJoYXBzIGltcHJvdmUgdGhlIGJpdG1h
c2sgc2l0dWF0aW9uLgo8L3ByZT48L3RkPjwvdHI+PC90YWJsZT4K

--------------i8WbTltGQZO00KKd01N0GZIs--


