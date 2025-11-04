Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8A5CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 12:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGFzb-00017s-Cj; Tue, 04 Nov 2025 07:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGFzZ-00017R-6u
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 07:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGFzW-0005ud-T9
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 07:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762258705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XW6AoeCc0tA2lUHElnC/IOwbdbsyLS2iPla2MgiGwZc=;
 b=Q6yD0X2TxsKLjwuL8Xotx7t2nJtA3NUpLV/EPoERf7mGUQX2eOwpwZyQUWBa4vl7S6/yDa
 88/6RKK3ZgNnuQmVg5ffz7KTSY6m2KEPsMrjMB83nHhKOGKknXExiZpMibUICzOQfn5u5S
 GMsb3z8thXnXf7u3Mw+wo3bH8PWBBoQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-PAHw_ibVPVWDpCR3KyrXcg-1; Tue, 04 Nov 2025 07:18:23 -0500
X-MC-Unique: PAHw_ibVPVWDpCR3KyrXcg-1
X-Mimecast-MFC-AGG-ID: PAHw_ibVPVWDpCR3KyrXcg_1762258702
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b6d7405e6a8so704541166b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 04:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762258702; x=1762863502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XW6AoeCc0tA2lUHElnC/IOwbdbsyLS2iPla2MgiGwZc=;
 b=HvXfSOmjo9ovsc7bdBaFHWdMWq0QZSbT2MKWEJfHI5VkvLkJ0g5kwD1CpIRzW3PC/n
 Iauqc3Jgw9VbFw5QrYFX2ztLtkODs0r+5fnMZHETPIXFKKmdAAccUDkiGvC6sqymSNxF
 AvWLkwDgd246OZdDMxR6gyoahtv2UlkALFyjDLIWpvurngLuOggCeeK1AW5ufibjedgr
 ejChbqL6TvyqHvNR728RJqaMk2awT7GWvNYR6zZNAtCmhqVY3c6gbJE+q5IhTVeKxB2z
 zdTTsSrkpgq84wmIxl8ETwCBYUG4LZlmHYYLJQaUWksB3MCwf1Q+xWVyENksbJrDadh9
 7Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762258702; x=1762863502;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XW6AoeCc0tA2lUHElnC/IOwbdbsyLS2iPla2MgiGwZc=;
 b=oDp4HhPo4FRfhYvtPba1xF7O8RjYDSKsCh/0VjVd+iBvt3FVB84B+tpFN7ZZWArNY/
 FnSmJBpHVPhKpo5PqzPObS2hGM/lT/QM6EQ1kSCsj9MjXADU0EplDeIL96dyQnk+hvyK
 JutAHSoWkWEpThAqZQGCvtNzjZODe7LZZ3IOSpMzCeHHB/HXUrgz3P5fHu64BsXYp5e+
 EWDKlUFrpqcI5/tIox3zI5OOwXEJHYnTEApSblO2TmbeNnsZBo3+VWn2msFolG9h6Ekr
 E4uE7ybJwlUmFatILxO/+1Soijr+yFwiEFLADdaiAt66AamodE1VV/U36/5CK/TsQABM
 /Zfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1pkBMhjsxFF/EvIvQ7PryzcqpdPEn/XEi39qxaBLjUaXF9HdcqJdn+1r9wCigrXAAeHhOXqn9coR0@nongnu.org
X-Gm-Message-State: AOJu0Yy2UtQ/MS3Eh1y9HGOqYXNQh9YicByPxwQDBaFQqfxFcSndUd/U
 31yG6p2vN7wkJRQZ/D7xITDpZMn8o7RqaxqDcdFD7EsFDuUr7s6fPA46NcvjOnFhvb83BwrTWUU
 plicG91RwLsEj2noDNonqcIjfQe0/aZGfDYHwfhcV0sYEm7bqs9oJht0S
X-Gm-Gg: ASbGncsU82Iu9v4tSabFxpfamSqzpR89BYWQUqsykOmczJnz2mQBzspE2GwrMm+d4EJ
 m2MYlKjSOxGfCoch0q0Nx6U/I/SgKjYkYAcM6++tc2CvsBBYdAo1kj6188PIKKaXd41ToZrxWjb
 wBB8a+pK9bmWVLpCZQoMpcgqEWq7V8BgP6KUP9EDi9Tw+nhK8DamYrLEPME6oawfaB7+BOYl9gF
 oQ0zNzk9SECZ/DXm125A4BCIQiLA9XZFMu+TO47UlXH3ZghK2f4+PYnyOQkB44Hvbm0DvaCAQrb
 Eu6mBoPEN8BLpZPXmpFf4HMuyI3Td5yElqDznguByg8v3E+2zpurAlxoYrt3umXZ6LQIkC77MHz
 OkvzK54Xdqftnv6NweRgCrE79subegpxTdYFU2REBv2he6cydtSGZzdQdXMpnTsndm66r7kruX3
 fWTh1K
X-Received: by 2002:a17:907:1c16:b0:b70:4f7d:24f8 with SMTP id
 a640c23a62f3a-b72169f503emr297588266b.22.1762258702285; 
 Tue, 04 Nov 2025 04:18:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfDSV9tVvxQXnVdrjmsw8trglOs3NpscnDnqdwxwhzv+2rXkRcHczMW1pq3K5s82FB/RoRAQ==
X-Received: by 2002:a17:907:1c16:b0:b70:4f7d:24f8 with SMTP id
 a640c23a62f3a-b72169f503emr297585766b.22.1762258701878; 
 Tue, 04 Nov 2025 04:18:21 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b723fa03d3esm202269366b.53.2025.11.04.04.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 04:18:21 -0800 (PST)
Message-ID: <d4921688-b3b3-45f2-a3c9-dee2977750cd@redhat.com>
Date: Tue, 4 Nov 2025 13:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with the "replay" test on target alpha
To: Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
 <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
 <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
 <30a9e854-e37b-4494-b372-f76ce6bdce25@redhat.com>
 <d9db8f08-f207-45b4-9637-9f13a04ab606@rsg.ci.i.u-tokyo.ac.jp>
 <81072e45-182f-419a-a44e-fca22ed54167@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
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
In-Reply-To: <81072e45-182f-419a-a44e-fca22ed54167@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/4/25 09:38, Thomas Huth wrote:
> Thread 4 (Thread 0x7f31bd1ff6c0 (LWP 89223) "qemu-system-alp"):
> #0  0x00007f31c47150cd in syscall () at /lib64/libc.so.6
> #1  0x00005593dd2b578d in qemu_futex_wait (f=0x5593ddad9e50 
> <rcu_call_ready_event>, val=4294967295) at /home/thuth/devel/qemu/ 
> include/qemu/futex.h:47
> #2  0x00005593dd2b59a1 in qemu_event_wait (ev=0x5593ddad9e50 
> <rcu_call_ready_event>) at ../../home/thuth/devel/qemu/util/event.c:162
> #3  0x00005593dd2c12e3 in call_rcu_thread (opaque=0x0) at ../../home/ 
> thuth/devel/qemu/util/rcu.c:304

The RCU thread is simply waiting.

> Thread 3 (Thread 0x7f31bc8fd6c0 (LWP 89224) "qemu-system-alp"):
> #0  0x00007f31c469c462 in __syscall_cancel_arch () at /lib64/libc.so.6
> #1  0x00007f31c469075c in __internal_syscall_cancel () at /lib64/libc.so.6
> #2  0x00007f31c46907a4 in __syscall_cancel () at /lib64/libc.so.6
> #3  0x00007f31c470a7c6 in ppoll () at /lib64/libc.so.6
> #4  0x00007f31c6916890 in g_main_context_iterate_unlocked.isra () at / 
> lib64/libglib-2.0.so.0
> #5  0x00007f31c6916a4f in g_main_loop_run () at /lib64/libglib-2.0.so.0
> #6  0x00005593dd0d1ab0 in iothread_run (opaque=0x559405a567a0) at ../../ 
> home/thuth/devel/qemu/iothread.c:70
> #7  0x00005593dd2b3311 in qemu_thread_start (args=0x559405a571a0) 
> at ../../home/thuth/devel/qemu/util/qemu-thread-posix.c:393
> #8  0x00007f31c4693f54 in start_thread () at /lib64/libc.so.6
> #9  0x00007f31c471732c in __clone3 () at /lib64/libc.so.6

This iothread is doing nothing.

> Thread 2 (Thread 0x7f3137fff6c0 (LWP 89225) "qemu-system-alp"):
> #0  0x00007f31c469c462 in __syscall_cancel_arch () at /lib64/libc.so.6
> #1  0x00007f31c469075c in __internal_syscall_cancel () at /lib64/libc.so.6
> #2  0x00007f31c46907a4 in __syscall_cancel () at /lib64/libc.so.6
> #3  0x00007f31c470b2be in write () at /lib64/libc.so.6
> #4  0x00005593dd2af441 in event_notifier_set (e=0x559405a56a54) 
> at ../../home/thuth/devel/qemu/util/event_notifier-posix.c:117
> #5  0x00005593dd2cdcde in aio_notify (ctx=0x559405a56980) at ../../home/ 
> thuth/devel/qemu/util/async.c:506
In this backtrace the CPU is waking up the main loop (thread 1), but the 
main loop is running so I don't think it's really a deadlock.  It's more 
likely that the replay is not matching the record, or there's a similar 
reason why the replay is not proceeding.

Paolo


