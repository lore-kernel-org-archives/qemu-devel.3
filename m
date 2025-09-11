Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A00CCAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 13:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwhXJ-0002BI-T3; Thu, 11 Sep 2025 09:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uwhXH-0002Aq-1H
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uwhXC-0003GR-31
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757598016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1Wkjd9k+z5/SuQF/+I7GtZwK1F9Mjjh+jzyzZ9tGQ2c=;
 b=LGIQIk4grIHxJNJUCfI7LzrQjsR9WdJ6e5Ib92pGwWSem9qHUYIphTjJ/JP+7MjzGvBaVE
 oBtk4pKrmU6MQ5qbeJHwBtZskeZEn9uHO+5kkpMN9RW3IUPYiZMBPXMNtiXwPvtnMN+Arc
 EebGS4pjEYkSbI/0IIfBfZaUoeYS15Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-m5y5dcGlMYONCVD3Yvn0Hw-1; Thu, 11 Sep 2025 09:40:14 -0400
X-MC-Unique: m5y5dcGlMYONCVD3Yvn0Hw-1
X-Mimecast-MFC-AGG-ID: m5y5dcGlMYONCVD3Yvn0Hw_1757598013
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3d3d2472b92so486402f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 06:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757598013; x=1758202813;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Wkjd9k+z5/SuQF/+I7GtZwK1F9Mjjh+jzyzZ9tGQ2c=;
 b=MzKQio1Sa+b4yNjUyrMqq59if5P8a1Cjo4yUHozxTPiSv2UcwpM/7jGFsDtUbFFRve
 hydVqL/UKg+56/x7uZ1qinNXc3oeuhkr3/pv3pydhVrvq/NF4ZUKoCAyaMWcjpOObDTe
 GzX4UyQvtI7XaghH73prhBvEgHNj9Ei+0m2MmnkepvE+p+UwY1CazoZE/W3ojnfMx1aW
 n3y80ER9QL1ZhPhRVlqKgs3pFa9CkkyQnJbEZPN7QYhwgClJtq375NZlIXKMsyTGvdz9
 gSxyoV5fZCD/NmDHsWrCIOp7ElQBbPiJI4oL+wMNmVKzMsTQd0L3Md0dg9d80m9FOGeF
 J0oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHdXWiyq1g/Nnz+VP+cxcNs9vHsczt0D1WcuvYpiH8LghPMl5emAuhJ5QYrupQLYHQij3tycnvBI5h@nongnu.org
X-Gm-Message-State: AOJu0YyrouNq3mkQ67EwtXguc40nlw2l3vO2As2LxBXsE9CZHfDMATxx
 8Qvge2/FcofpAM+KYgij94bPBbqrOLacLGETpGNbBpR/RcwM4ELLmoxjpRd88oHeb1kraDi+p6A
 fySOREAu6FWlSQuhNKHntUt1+805QnSWbbXGvIWZ+/ipi00xD9V3ZDUn7
X-Gm-Gg: ASbGncuAUzNwqFa6mkWvyBfcEPg19LV4mZbZssfg4J99Aa6zSZai7yayN7qFqDQ9gbW
 m5MMsdq1hzzj4LTIkJuwJsfDZ4LW9JMdNjIAStjcWn9IqKsJtgk3HDxZYf0wH/t05bZ6cT4VuhU
 jKRBAX5OrHe+ezvLr1IHqM3Q05/VYNFR23iVhsvaSqzvfZ13IzM59oZiyqFkypcPZTcLoYFiT/v
 dlomuJj9rHyf7Sx9D9XNlGktm/3zdaJ4FTGVozPz7svotHhPycIgbrOq0jxs9mw+PAAYrl9KtOF
 V+/HzQ5u3cbGbCx6HIDh21sCr7t0wDo5FuLsdqXw7afxMZDK0hs1RQ/tlNVWOWm2nZdSkVIXBIc
 gdqczUj/o95tgkBjSCt4ZqB634HblAjGk0rn+vX1SJFU=
X-Received: by 2002:a05:6000:430d:b0:3e7:4b1d:74e8 with SMTP id
 ffacd0b85a97d-3e74b1d750emr13663099f8f.26.1757598011384; 
 Thu, 11 Sep 2025 06:40:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy5YcFEvCgWHnvYA2CS0i/GVzCi6nkvSyRCO0Ot9zIMY1SZj9hEEJ47ZbDwq0R7VWjDIV9tg==
X-Received: by 2002:a05:6000:430d:b0:3e7:4b1d:74e8 with SMTP id
 ffacd0b85a97d-3e74b1d750emr13662876f8f.26.1757598009386; 
 Thu, 11 Sep 2025 06:40:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3e760778915sm2576343f8f.12.2025.09.11.06.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 06:40:08 -0700 (PDT)
Message-ID: <ac058be3-274a-4896-b01d-f433d036b5d0@redhat.com>
Date: Thu, 11 Sep 2025 15:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hpet: guard IRQ handling with BQL
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <aL7oe3sis3bKJhLW@redhat.com>
 <20250910142506.86274-1-imammedo@redhat.com>
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
In-Reply-To: <20250910142506.86274-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/10/25 16:25, Igor Mammedov wrote:
> Commit [1] made qemu fail with abort:
>    xen_evtchn_set_gsi: Assertion `bql_locked()' failed.
> when running ./tests/functional/x86_64/test_kvm_xen.py tests.
> 
> To fix it make sure that BQL is held when manipulating IRQs.

Queued, but I think it's time to allow qemu_irq handlers to run outside 
the BQL.

The idea would be to add qemu_allocate_irq_unlocked and 
qemu_allocate_irqs_unlocked, and add a boolean to IRQState.  If the 
boolean is set (the default), qemu_set_irq would wrap the callback with 
bql_lock()/bql_unlock().

Together with the MMIO support that you introduced, this would allow 
making interrupt controllers BQL-free.

Easier thread-safety would also, but I digress, provide a good reason to 
write even the simple devices in Rust---that's in my opinion an even 
better reason than memory safety, for which we already have developed 
lots of abstractions in QEMU.

Paolo

> Fixes: 7defb58baf (hpet: switch to fine-grained device locking)
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/timer/hpet.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 789a31d0a0..1acba4fa9d 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -40,6 +40,7 @@
>   #include "qom/object.h"
>   #include "qemu/lockable.h"
>   #include "qemu/seqlock.h"
> +#include "qemu/main-loop.h"
>   #include "trace.h"
>   
>   struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
> @@ -222,12 +223,15 @@ static void update_irq(struct HPETTimer *timer, int set)
>                                    timer->fsb & 0xffffffff, MEMTXATTRS_UNSPECIFIED,
>                                    NULL);
>           } else if (timer->config & HPET_TN_TYPE_LEVEL) {
> +            BQL_LOCK_GUARD();
>               qemu_irq_raise(s->irqs[route]);
>           } else {
> +            BQL_LOCK_GUARD();
>               qemu_irq_pulse(s->irqs[route]);
>           }
>       } else {
>           if (!timer_fsb_route(timer)) {
> +            BQL_LOCK_GUARD();
>               qemu_irq_lower(s->irqs[route]);
>           }
>       }
> @@ -534,10 +538,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>               /* i8254 and RTC output pins are disabled
>                * when HPET is in legacy mode */
>               if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
> +                BQL_LOCK_GUARD();
>                   qemu_set_irq(s->pit_enabled, 0);
>                   qemu_irq_lower(s->irqs[0]);
>                   qemu_irq_lower(s->irqs[RTC_ISA_IRQ]);
>               } else if (deactivating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
> +                BQL_LOCK_GUARD();
>                   qemu_irq_lower(s->irqs[0]);
>                   qemu_set_irq(s->pit_enabled, 1);
>                   qemu_set_irq(s->irqs[RTC_ISA_IRQ], s->rtc_irq_level);
> @@ -683,11 +689,13 @@ static void hpet_handle_legacy_irq(void *opaque, int n, int level)
>   
>       if (n == HPET_LEGACY_PIT_INT) {
>           if (!hpet_in_legacy_mode(s)) {
> +            BQL_LOCK_GUARD();
>               qemu_set_irq(s->irqs[0], level);
>           }
>       } else {
>           s->rtc_irq_level = level;
>           if (!hpet_in_legacy_mode(s)) {
> +            BQL_LOCK_GUARD();
>               qemu_set_irq(s->irqs[RTC_ISA_IRQ], level);
>           }
>       }


