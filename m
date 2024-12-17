Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF57EE7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNU5T-0005So-M3; Tue, 17 Dec 2024 04:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNU5Q-0005SZ-5m
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNU5O-0006op-At
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734428506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fXqH9um9w5h8Ggdovb54C2n4fbfuDUHfmKGXh4mGHQA=;
 b=KNbPo/tp0bmoic5RkZ1WrcbqeWAVrK6mv1U2xNBEQfgyN7V1gofId/M3lE6GN0yQrO5sLi
 mYbIcqXQPgkQ0EWObqr/GhtG7AkN9v3HT3SdX/gEKOfLERk3qDIAr/hoNUQf+6cYkWzgBo
 A7DD1ZTBHZVkH2B/J2aJt3vo9Tnz8Ac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-o7tgBhPyOSmZSNgM8dTPdw-1; Tue, 17 Dec 2024 04:41:45 -0500
X-MC-Unique: o7tgBhPyOSmZSNgM8dTPdw-1
X-Mimecast-MFC-AGG-ID: o7tgBhPyOSmZSNgM8dTPdw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3862e986d17so2109152f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 01:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734428504; x=1735033304;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fXqH9um9w5h8Ggdovb54C2n4fbfuDUHfmKGXh4mGHQA=;
 b=vw6UGXkBrRqNr0ZxlsPYebeUn1Mhqlw8r4GkQQC6IZzUILoUzJFz+t0qNH/kZtjFbs
 6n8H03VPaARyWwTnVV7kdqjbIGcwrMVRT62I+wzPx0HwCpVIKfG39k84AbKL7ab7j4ji
 ocU4GCnjti7uTunqmJVGNj1GCp8KqnWszvcTQ59wgZHd5X/TDf3z0G55ROwSiKD+n7Zz
 vOhasPRHwTAHBOhwy2opdRa9blG6xr4cHZmMsMonWA4VhMFVZ1GrY4mJ+vFr3+LcOakg
 JwktGmOKVYtt/J3EANjhhAooT2mFS2jlAWIEr9ZnDUg0ylkUt3oF5pixwhn9aFLIir4F
 PQKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh9ZxeU9SkyI9UlmA55BpMD2os08B7Vz8JIbipUzJOZhkRYPzRkmC8xXk10r2Iz0mQq+jI2k5eeR8L@nongnu.org
X-Gm-Message-State: AOJu0YyVxq7aF+ZNSHlWDcVeRpnSi5J2N7njFBpYLqwcZ4ysjfaD7W9M
 Rxkmb4Q5sbsfjXUpgyxSMHaFMQgcIltND6Xeqrvs0ko0M+PShOhHW6/oQ8Hqj3T1wR1f1kgRmDK
 zzPT6VJB1ZeRadE9L48o1FOLlKhh29m8sKb/UajFWiXIZjTCfksud
X-Gm-Gg: ASbGncsECxt2frYvCFr/zaJAblyhKWB6DiAiO1fM8r8rv1VhWVC45i4gDT+2lLxwHny
 rvmRmlSsfg3iSTIOyOk3AJkoihVUloOYxZBrYeA1hAGMBOK6LgRsmE/mk3sLgGzecBYvNhVkmwa
 LHvRLQLDhwtiTq5a4/ZYETgWPWz2lomcDcag9i2o/cCahAwkOx0oyPgyZjpVrRlgV7e/PN6lVdD
 Clc0BB8RjKZQ9m9hauZQaFPt9LH5XmHmrgSbtgUgJnZKQ52o3mEd0CpP+Ei
X-Received: by 2002:a5d:648a:0:b0:385:f677:8594 with SMTP id
 ffacd0b85a97d-3888e0f30ccmr11614375f8f.43.1734428503927; 
 Tue, 17 Dec 2024 01:41:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpe13aD2kSJpTmfKM9PKcTiCkzTDRM65j9w6bpOOqimB7xacV0EEtG4T0dXT4blDMOwOlxUg==
X-Received: by 2002:a5d:648a:0:b0:385:f677:8594 with SMTP id
 ffacd0b85a97d-3888e0f30ccmr11614339f8f.43.1734428503582; 
 Tue, 17 Dec 2024 01:41:43 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-388c801a8bbsm10648723f8f.56.2024.12.17.01.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 01:41:42 -0800 (PST)
Message-ID: <8011ba26-d0eb-4e18-be8d-b464235e89b8@redhat.com>
Date: Tue, 17 Dec 2024 10:41:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 43/60] i386/tdx: Only configure MSR_IA32_UCODE_REV in
 kvm_init_msrs() for TDs
To: Ira Weiny <ira.weiny@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-44-xiaoyao.li@intel.com>
 <Z1xHztTldnFDih8W@iweiny-mobl>
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
In-Reply-To: <Z1xHztTldnFDih8W@iweiny-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/13/24 15:42, Ira Weiny wrote:
> On Tue, Nov 05, 2024 at 01:23:51AM -0500, Xiaoyao Li wrote:
>> For TDs, only MSR_IA32_UCODE_REV in kvm_init_msrs() can be configured
>> by VMM, while the features enumerated/controlled by other MSRs except
>> MSR_IA32_UCODE_REV in kvm_init_msrs() are not under control of VMM.
> 
> I'm confused by this commit message.  If these features are not under VMM
> control with TDX who controls them?  I assume it is the TDX module.  But where
> are the qemu hooks to talk to the module?  Are they not needed in qemu at all?

The TDX module controls the values of the MSRs, and the values cannot be 
affected by QEMU so there is nothing that QEMU needs to (or can) do.

> Also, why are the has_msr_* flags true for a TDX TD in the first place?

KVM only provides a system ioctl for this purpose, not a VM ioctl; so 
there is currently no way to obtain the information for the VM.

Paolo


