Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D930C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMT1Q-0005Ne-R6; Tue, 03 Jun 2025 10:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMT1G-0005Hu-Gw
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMT1D-0003Xg-UW
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748962414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sFz2jTWXZh2Va4VOXmlA73YInZMR+DF0dzmpuVrYc5A=;
 b=a041sCEAB0U0io+jwdU1gvjO1NxDAs6BFr0Dfb7XTDpNAZe//DYimn53otIco/hW1y6lde
 lwfFsWbd6lfZeOS87rkIJZ+PmdQZ9q7yPuBt2nJvAWo6p4mOiqE7bgbmT1Cb7QPDlxXl66
 LsoJK2dwXk0O1Q4kWfjbYFqJeM5iRzM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-SgtgPhoYPOq0Z_ndCKznrA-1; Tue, 03 Jun 2025 10:53:33 -0400
X-MC-Unique: SgtgPhoYPOq0Z_ndCKznrA-1
X-Mimecast-MFC-AGG-ID: SgtgPhoYPOq0Z_ndCKznrA_1748962411
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f55ea44dso2518866f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 07:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962411; x=1749567211;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFz2jTWXZh2Va4VOXmlA73YInZMR+DF0dzmpuVrYc5A=;
 b=tWG2XrOlv2BdkYZqlN/8i6Ja0GXKT4hOV98zzintdWVn8Gyb5Xi1lJXDsN+ZlyXGhx
 EgVLm6pmvdRMShSiSn0UCPb+wrw/Ma0ONkANQfz+s3glJ9C5xSaYqqHH3lBZtWVSkHVP
 ds5URurnh8GsxS1yvGPtLmKcOV1u+f/BgwsEMRmbex4uSBCqpupa9p+EnhEzsytm6O2x
 3NrZYHGgftFYchrR2h2oCHz7aAX49nH5M2rAEq12wguUe08DTeZWXPqKIKL2BFlBuXiy
 9JskiRtYnzk/LwEk5vcHzl2hrUXkw3+FZiPuQLnip3Qn6uL7HPyPxbgFfMXn3tZnAxDF
 +i3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWba37uC/p6lrGCbDuCwSU0JPJ0IiSPtw+b1RMOw6VhGbNbA5gICLUIai7QianSHayorsyi57AG2QPr@nongnu.org
X-Gm-Message-State: AOJu0YxyTdYG9+m9ObS9m590yV4Zq646/WsXa3RWreAS9toybde+HLPG
 mT75/WSM586xfldo11DydNLlz0SAtRi4hs8XOgxp6V+R8xKp+TjovbhcNEyxN82lKIINROiuSpa
 GNlHRsQP6U/JRr0lPZKVh4UDEFRNYM0l2khC5cCUIE9wQGyshZpsWw1JL
X-Gm-Gg: ASbGnctmfetKCZLTDxial1sOy/ghkWD4BBxLYoViVpKG78S9jvcflpW8hIIH6ebFg/3
 7JipEmm6mj+VAyHc4b6+5dk0MdEhSRruwBgoJUAcmLHABWZFD2z3Rnn9374el8hOmdNcMHWa5dh
 1QgarUCYtBY0m1Ou6Fnxix6a+++iIRbN04CN3wYmhuehclJIj6S7w+RwXryCitMrF8EBZWoyjcm
 6ZnWt0SClo3aal2IRdvhelBavfXv8Q/e2cRX6/GCdpl5sEDOLtayyJ81Rz0Iey8fd1efM8sQqgh
 EoWFiV9fAO+G2A==
X-Received: by 2002:a05:6000:2891:b0:3a4:eef9:818a with SMTP id
 ffacd0b85a97d-3a4fe39483dmr10532569f8f.27.1748962411422; 
 Tue, 03 Jun 2025 07:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjZwI1WAXzTegegjzw5g6J1pzQ1H7at0rMSdwFaMIawGRougWlRDXe6/7YoPkwXUO3q5F4KQ==
X-Received: by 2002:a05:6000:2891:b0:3a4:eef9:818a with SMTP id
 ffacd0b85a97d-3a4fe39483dmr10532551f8f.27.1748962411083; 
 Tue, 03 Jun 2025 07:53:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-450d8000e9asm165726065e9.21.2025.06.03.07.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 07:53:30 -0700 (PDT)
Message-ID: <a838e7cc-968e-4ca4-ba60-bbf201d689aa@redhat.com>
Date: Tue, 3 Jun 2025 16:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/tdx: Fix build on 32-bit host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20250602173101.1052983-1-clg@redhat.com>
 <20250602173101.1052983-2-clg@redhat.com>
 <b30050b0-68d3-4b42-85f3-9aeca26fb830@intel.com>
 <06903e8d-d729-458d-8157-5a54d324a239@linaro.org>
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
In-Reply-To: <06903e8d-d729-458d-8157-5a54d324a239@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/3/25 13:26, Philippe Mathieu-Daudé wrote:
> On 3/6/25 05:04, Xiaoyao Li wrote:
>> On 6/3/2025 1:31 AM, Cédric Le Goater wrote:
>>> Use PRI formats where required and fix pointer cast.
>>
>> Maybe we can make 32-bit build exclusive with CONFIG_TDX? since TDX is 
>> not supported on 32-bit host.
> 
> Yes please!

No objections, but I'm still applying these first to fix the build.

Paolo


