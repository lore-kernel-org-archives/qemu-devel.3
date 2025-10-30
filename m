Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB6CCCF9EA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 06:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vELw3-0007cH-Vg; Thu, 30 Oct 2025 02:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vELw1-0007aF-D2
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 02:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vELvs-0003py-P5
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 02:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761804881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ugG4Xw2WPzimRf3Ms1Nqq5Eq+HR5EdyMmmq2lNnlQzI=;
 b=AmOL+Pu6m0sRpDmc2MqaZ8FaYjpy2FNMeAyD5Utbv6j1oYeSm3EeO1AyOwedtCDq3+Rm2l
 FFxipVJfdKI90zwDoZ1S66lNYquvuBHF3r+ld/pKjHfQRmGIljXreT1ekak8Tac0ppHe19
 z6umOPGoOYUhe35nX1J+6DgSxXpL+dc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ROxE9bQGOiqRpd-1UAuvxg-1; Thu, 30 Oct 2025 02:14:39 -0400
X-MC-Unique: ROxE9bQGOiqRpd-1UAuvxg-1
X-Mimecast-MFC-AGG-ID: ROxE9bQGOiqRpd-1UAuvxg_1761804878
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-428567f67c5so282277f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 23:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761804878; x=1762409678;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ugG4Xw2WPzimRf3Ms1Nqq5Eq+HR5EdyMmmq2lNnlQzI=;
 b=ll+W+8eBDsqpwHZKLcOqBHmPJ/FmGCWEws0FgwpxJV6RnsgLXqcAC9rzp+0G1+0R36
 Ragrs4z4F/0AmE6KrXAcNWtlvUdM8Jh6u1+Je0Ytu0y/R5WiPMkrgj8XaV9zaX8Z9W9M
 +zhyfdXGkd0n+nIBhS2efCI+aJ4fSoYYEM5d36qEM9p7TEBzqj0gnUcxxlmPzN+Frul7
 bAdKrEH9Yoo7CNgF+c6VQQmbZSfn/9gVPTz/fVslm0LLZSSAyrxP6+hUS0nwl7GWdnUD
 zC3Acfn/KgRV2au5JxhcAFZghnANhaOrCqjNJXU+b3u/Dpbh8lBWarE4cWU6gIM6V4kS
 Xdyg==
X-Gm-Message-State: AOJu0YyH2lkAWwC3D8MhhYJsImzjLC4zUNtaO4sNCqedzRkVDt09lVGt
 d6vhQqW92jqvjfexEiypBVShWV7j9UKLvmnR1VV3IkwJPwkzC5uBIu+L1mc0Ua6BB8oz2nnJZqK
 A1L0iN4JnO/DGs5Vc6e2fayP97jDopWt6cdMcNjJaHRteKS1Kk+xq4a+A
X-Gm-Gg: ASbGncsr0JqCsfrljtf+8Awb9a5JB3i8sWlFrqSieqF/FLo8MfrWZDB3AasXsNXfvnZ
 aYTAonns/Wi3P7yiH4MyJxMoWuhKO3VKMccGx3T3sRmo+DqXLuyd84zsXw8luucSAOt2BljYRKp
 UT4pI3QE1TdNYkQf+d9FOjbbnDejh2ESUIzsottpKbp2SDRz5YMotTfgOc8eNKjYkk8NJuTE0B7
 3jjpugg2rdPT56QYJGszU6RDO/vjNudFJX8le5yntAec60KTIJ0uvzygf8rBe4z6sAmMf/j6Wvs
 kLTOSWxsYOuoW+BcQiyVyR5gejdr3IchgJQdt3rbPlRGYiNQTk5kGYnB5hJx9YKiur4CJJM1cHL
 LUPPmO9wkfQSmWk7D3nL9pVMghzRc42g7kqBCkpHr/7/DkwcRWB2xI/qJ6CZfVVwEkvFBx/Ocmy
 g46F0=
X-Received: by 2002:a05:6000:4382:b0:425:8559:5d17 with SMTP id
 ffacd0b85a97d-429aefb9a30mr3551407f8f.30.1761804877812; 
 Wed, 29 Oct 2025 23:14:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEPxttRcuGF4tH1q4FBX6ei9tim2OM3szywx3N9/dBsYesu0BUo6ixm2+K2BU1iq0Jyx2KWA==
X-Received: by 2002:a05:6000:4382:b0:425:8559:5d17 with SMTP id
 ffacd0b85a97d-429aefb9a30mr3551392f8f.30.1761804877397; 
 Wed, 29 Oct 2025 23:14:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-429ba3574a2sm388829f8f.44.2025.10.29.23.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 23:14:36 -0700 (PDT)
Message-ID: <942911e5-0fab-4bf8-a41a-082de491d960@redhat.com>
Date: Thu, 30 Oct 2025 07:14:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pegasos2 patches for the freeze
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <bee2d3b0-1565-2c63-93a0-4e84ced610f0@eik.bme.hu>
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
In-Reply-To: <bee2d3b0-1565-2c63-93a0-4e84ced610f0@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/29/25 14:55, BALATON Zoltan wrote:
> To help tracking patches to be merged here's the list I have on my 
> pegasos2 branch that I hope can be merged for the next release:
> 
> f5c71e99b5 (HEAD -> pegasos2) hw/pci-host/articia: Add variable for 
> common type cast
> 159f8cec9c hw/ppc/pegasos: Update documentation for pegasos1
> 8835cce4ff hw/ppc/pegasos2: Rename to pegasos
> 356511cf3d hw/pci-host/articia: Map PCI memory windows in realize
> 7649f4c174 hw/ppc/pegasos2: Add /chosen/stdin node with VOF
> b1b9b6668d (master) hw/ppc/sam460ex: Update u-boot-sam460ex
> 41312cc017 ati-vga: Fix framebuffer mapping by using hardware-correct 
> aperture sizes
> 2d1444017d ati-vga: Separate default control bit for source
> 
> I hope somebody can take care of the ati-vga patches so you don't have 
> to care about them, you already have the sam460ex u-boot update then 
> only need the "Some more pegasos patches" series and the last articia 
> patch I've sent separately based on the series. No review yet on the 
> 7649f4c174 hw/ppc/pegasos2: Add /chosen/stdin node with VOF patch and 
> not sure if we can keep Philippe's R-b on 356511cf3d hw/pci-host/ 
> articia: Map PCI memory windows in realize based on previous discussion 
> but other's were R-b by Philippe already. I hope these can be in your 
> last pull request for the freeze.
> 
> Congrats for becoming ppc maintainer by default :-) but thank you very 
> much for helping out with this.

Not sure if this was referring to Harsh; if not, please prepare a branch 
on gitlab or github and I'll pull from there (no need to send a formal 
pull request to me with git-request-pull, just reply here).

Paolo


