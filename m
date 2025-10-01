Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366E9CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 12:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3vwZ-0007jm-8S; Wed, 01 Oct 2025 08:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3vwO-0007im-Fg
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3vwC-0001BC-Sm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759321676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KgBdeKFJ04Up/E/61Ou21ytcUQxgxIg/Axg/mnceIxk=;
 b=SNzZJ4MgA3my89KkgG5DBdV0neaaPtenWAESsMqUt15C1GTqoyJtuQOjdiPcFlhRbOcLdi
 FUut8NlnJDkbylfEjq+elgWsg4mCh+eqV5WCvnuLs+xdw4jlZ7U++BO90iec55/MNRKU/B
 9cVXpcQlukeY+GbiWdOlxPv/0K5U+u4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-1Ljk0JzPM5qUL34kXb5MsQ-1; Wed, 01 Oct 2025 08:27:55 -0400
X-MC-Unique: 1Ljk0JzPM5qUL34kXb5MsQ-1
X-Mimecast-MFC-AGG-ID: 1Ljk0JzPM5qUL34kXb5MsQ_1759321674
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-425745467d1so99964545ab.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 05:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759321674; x=1759926474;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgBdeKFJ04Up/E/61Ou21ytcUQxgxIg/Axg/mnceIxk=;
 b=GD+0MgHcTqmjQgNguadEO8kLdCPA1YloiWG3oYreV4GS1k+aLijFfeIyf/UakGlMDx
 oJDKPE2N0jA3S74qj9X2akKuRYUd2ooZuLLf1Kn8EiLwlcRLm47oRqyk7g+RW3CXTG/b
 VKcmzdrmNCAcs00rj3Ms+QO4S35F94wtI8yJzlyXL5A7uVOYOmpKrZ82BEqjWmbL+We2
 KYq9rqU0kwhlgUbwO/ZCksCJxvD/qwzpg7x5l6CA2042Uc8WrNekBIRGzn//DFzZVFJb
 9wdRivn2pH6sySrs+qdpgjGpx6gu4ComARZ8ci37EmXulBU3zgCraO5fueM6jDd9JfFh
 dluA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYnpI9tWoc1wL69Byiw3n9wVps9Z+ILS9irD29AAgQsDTlkU4kMTkSnHk2w3i0XkAqmWdqbDtEu+Z1@nongnu.org
X-Gm-Message-State: AOJu0YxmHAD82TmAgZmtRmMdnCOy01aEnp6f7Tdm0Cj5aLy38CUh2rGB
 Ukw6BPYjtqBktLyq7rKdJR1SNQT/fyFVFcMK368r6F8GikQ3kl+fvwWElPePGFHEtyVesM7cdg/
 7uEneb2E9eGCMhVrdqZZB5JzJCfL1AoxhmT6f3/EWNVHe4vuV/nKOQDh0
X-Gm-Gg: ASbGnctzXUGzHSODA/i1CZtHf0bZYEg7Rh351mSVc4FqYF1k/NNa2tYryb4ItHaRre5
 WZTeNb6GQ010jrC83oJicOF6jZukjCbe4xGj7QLariPuemJuOGPSiGfr1xHe3Oz+iVVcPatbTd0
 fWrZFwK74gYZpIs6cOCTQ+Pvn+M9Ax2BOc0DPdRYK+oRx489rEdKqRsGU7IJ5zxHK4SlRCyVBjv
 Bb0RDgRcFHmL0IdAhppWBYVRdXBjKC49bKf2difAw3dGk43hVOAEDUoCXToL58gTf6sXtPXALxm
 EXfVcEOsoQ+jImLwDdJUldHngx2Zi54xxsnk+Cu3u4vYtk4eTagATM7CkD1drXqnGVaXndIbgGA
 XKdZTYhcX0rKgUxRUJPDqCzkp+r2lbdrSwMj1dZ0TURC9DP4C+uQ=
X-Received: by 2002:a05:6e02:12c5:b0:426:3ab1:74bd with SMTP id
 e9e14a558f8ab-42d81617608mr45205495ab.18.1759321674414; 
 Wed, 01 Oct 2025 05:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGPy/Im5FiTzB+dt7eDYxPhxMQ1DDv+zOfqDTqm1dN6x+SkYa4XF31VuU2S+/QZQcjA86pWg==
X-Received: by 2002:a05:6e02:12c5:b0:426:3ab1:74bd with SMTP id
 e9e14a558f8ab-42d81617608mr45205315ab.18.1759321673985; 
 Wed, 01 Oct 2025 05:27:53 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 e9e14a558f8ab-425bff82872sm78446355ab.35.2025.10.01.05.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 05:27:52 -0700 (PDT)
Message-ID: <05135d89-7071-4cb5-9e90-e366ef635767@redhat.com>
Date: Wed, 1 Oct 2025 14:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/27] accel/mshv: Initialize VM partition
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-10-magnuskulke@linux.microsoft.com>
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
In-Reply-To: <20250916164847.77883-10-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
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

On 9/16/25 18:48, Magnus Kulke wrote:
> -#ifdef MSHV_USE_KERNEL_GSI_IRQFD
>   #define mshv_msi_via_irqfd_enabled() mshv_enabled()
> -#else
> -#define mshv_msi_via_irqfd_enabled() false
> -#endif

Ah, nevermind, here's the answer. :)

Paolo


