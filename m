Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD092C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNR1-000230-Oa; Tue, 20 May 2025 09:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNQz-000218-Fg
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNQv-0004ji-Mp
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747749303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nteL1DlYy1uhnN7fqD4LlWsP8+tPI5rvQMc3Uo8f4m8=;
 b=bFivVaks8ZbdvvLL7hWZQCj1HLI2mA8LLF+Ltz4t5Wn3ouZyUJrXYTM7YhCJtUkFMpM4Cp
 30ZP1SfLs2r/PxzT03Bi8F1Cz2cA0JGr8W7U6Jbo+9S3F+5IhGNBsFeZLzFgm3nx6+5lkt
 u9q8SETwX/SfavXB3J6uT/WWe9DQoG0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-rAehukb_PmWBniAsVIeIkQ-1; Tue, 20 May 2025 09:55:00 -0400
X-MC-Unique: rAehukb_PmWBniAsVIeIkQ-1
X-Mimecast-MFC-AGG-ID: rAehukb_PmWBniAsVIeIkQ_1747749299
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a37a0d1005so498122f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 06:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749299; x=1748354099;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nteL1DlYy1uhnN7fqD4LlWsP8+tPI5rvQMc3Uo8f4m8=;
 b=othq7Wi6ERDWBzcdNYZ48dBrOsAk5O68XHlw27K0I6qB7Et8A1yBXFjsgx5XixGHKX
 dUeffQoZQGH5C8Gz+jgwguJoESY36KXEpKCYeRSCh46NV5W2rtAMLd/4QzlnyD+AF19u
 NkoCveJdqTNuLfrWN3pk4XB0FmGF7TjfbX4JSgpzs1OwFBmD0jaG8MWCWL4y6jWS8UkY
 kSkH+oKPxE9wkvrdnKBbkgKSkeAQvhAUaIu8VTiGiNW0x//LYMT6DJTye/VOvy7YDlEi
 ofQ6KtKjvTw8vh2piBEgXNqDRCDlNIBEs+fGbHG0nFbxEMg6OwAeFnrCfS0zzQVwVYjH
 zZbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc8+ejAqK3PM9Pt6DzPDU1fsb7mZgy0xHmmk7g/JhGkRLtl/iFLPZb0km+kFsj67pn6VrQeCCSXZIQ@nongnu.org
X-Gm-Message-State: AOJu0Yx/8FGO7v5oaoSBVFdwQB7hiE0sSUyG2x4bLemOou+UxbFthIew
 CfZJEyLdw41XIzhW5q337kpT2cK0tykccPIKTkMR4mvBnVmwYUwG9iGXdNm1IPqlYBZBdBxqK7j
 +GHTm3zOgyxHqxAKZImoJxJqKcEiPQgYVStp66PEtx7Dg5JrvjzeZrte3
X-Gm-Gg: ASbGncsuv6+hM+q1iNrjIbxNy9S5kGYc1VrqT6ZuAIFD1cRl3V/iviYCJTkN2YlXPtX
 8pfgn+2hho8FL8zBs8ZS/1K3XOwGz8m3iGdM2gX34q/13axT6b9hmNPHOsDRGNkzHrWN/FDYKvx
 QnaZMQhS/6GG1jANE+d4e8n1CnUyTY+P9PLrbHJCg90FE8dLBW/UiYlJRnrKxHJ9WC/xo9J8NcV
 BWBdMd2rwe5jfrn9ohMgAWMi/YIjmVSy3sfmER5HLADwiHad7z7B5aTe03Y8v49OQQfDqNZjbFq
 3WZW2AE3ckw3Yg==
X-Received: by 2002:a05:6000:2385:b0:39c:13f5:dba0 with SMTP id
 ffacd0b85a97d-3a35c821f75mr11885693f8f.13.1747749298817; 
 Tue, 20 May 2025 06:54:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGIGTM3n/ALKQ4EcgB4Yh1sgHJlfnqImUaTZYKH45VnMiXR++QAiA+sx4x8pC5Af90sasG2g==
X-Received: by 2002:a05:6000:2385:b0:39c:13f5:dba0 with SMTP id
 ffacd0b85a97d-3a35c821f75mr11885677f8f.13.1747749298491; 
 Tue, 20 May 2025 06:54:58 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm2124248f8f.100.2025.05.20.06.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 06:54:57 -0700 (PDT)
Message-ID: <12460861-2be5-4522-9ba7-009f16a61a59@redhat.com>
Date: Tue, 20 May 2025 15:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/25] accel/mshv: Add vCPU creation and execution loop
From: Paolo Bonzini <pbonzini@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-13-magnuskulke@linux.microsoft.com>
 <8b65b12c-ca3e-4528-9544-65784c862763@redhat.com>
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
In-Reply-To: <8b65b12c-ca3e-4528-9544-65784c862763@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On 5/20/25 15:50, Paolo Bonzini wrote:
> You need support in the hypervisor for this: KVM and HVF both have it.
> 
> There are two ways to do it

Sorry - I left out the other way which is to pass something *into* 
MSHV_RUN_VP since only half of it is currently used (I think).  But 
that's more complicated; the advantage would be to avoid the ioctl in 
the signal handler but it's not a fast path.  I would just do it the 
easy way.

Paolo


