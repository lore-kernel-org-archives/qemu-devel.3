Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ACFCAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 14:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwicU-0001EN-Vd; Thu, 11 Sep 2025 10:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uwicQ-0001Dt-S7
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uwicO-0004Jw-VK
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757602188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l050lDCOLQ/wOSA407yGOTa67xvo+Idgp5iq5AxsBJg=;
 b=UNJsaHqcCvu4Rdr2O31z9l/WJgqdVFViUcvsTlfAeS9p2JIj4fgLCN1bA12uoy2WHOaTp+
 Qx+syG3i/yGZOVQiWF13i4bguSpuglAV8qfenGpCsmFZUjQ7Ld51x/OK7d+YZg6VBY3lQu
 Ax+v8vHDp9p1X0rptmd5IV2CZFeH9r0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-fyy_Ta0oPLiq0LrFgDlVHQ-1; Thu, 11 Sep 2025 10:49:47 -0400
X-MC-Unique: fyy_Ta0oPLiq0LrFgDlVHQ-1
X-Mimecast-MFC-AGG-ID: fyy_Ta0oPLiq0LrFgDlVHQ_1757602186
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3df2f4aedd1so654144f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 07:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757602186; x=1758206986;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l050lDCOLQ/wOSA407yGOTa67xvo+Idgp5iq5AxsBJg=;
 b=NWLDrFYMHzolG60iM8lsNlBuTh56syb6Et/DMQpPbZPWcKAVo08YddgwQNafvR9463
 juMHN+frapUtrRgDPbanCNMwzbp2QlHPCBHjYy22J+x88R+mmhpGO8Yzzf6ByTr0Q5ES
 9EtCKYlOwF+Fzqm7yDTPOtaIm5mQ1OcfkZ7if9hsOS9gwnZ0TvTRuGGSMJI87bvk6tAC
 3zFp/5+2XPZ7as7+i0nG5KV+ZEUzfQVi8lOYxO1iIKLAtKQO/IAApmSDiZcZ/SuEtSR8
 zd+amL7kenmIF1E7HJVCg+f3blc2KvcGzIlHNftTBsb/DaQbhlmNGtYsymRIeX9zsMgW
 xyPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa9RiiFwHqOYB3HhMfAJS7o9SwlGOQpvXefQ+OpztCUJZKECxf5lwvfiV9MBXoK7yf65LERR8blAaN@nongnu.org
X-Gm-Message-State: AOJu0YyfnM2/bPB2PO6rrlnGm/iuIsCIQglgkAJsrXh8TjIEivId8R/6
 W2TBam9Q9EEulz98poVbZ9MbCFRb+LI/o3Jd5SXZJJrx9H45qg2FK7Ys5mwQv9g74gIAa5N9iti
 pJ1If16GeqKOCXGT3dl0XR0T0ka0GXStbK6QIdvbrwlSkAyft5P4VgPUy
X-Gm-Gg: ASbGncsPNQm5qfyqc1D0/M8NdPrPkjy93NsIGuzgtfdGlL1ql90UvD1V1Ala1Tu6aB+
 0n2KeCV7rg/u3ES2QEDHA1LHI8McdZkXA99KInxqdMSf++8ah0gx1zZDGEd0wBz3eC9EWl46DqK
 37A3VmhLQooqvwyhtAG2dRDj5/Yo0kjgBmbWsquA7zs5PpEdAg+6ZZuVptAxri2stUvZdPOUNvE
 ReUBAoRgH2Tr66vIMKjHiloJ9ofGh2kMN0rOVueF1W6S6ye+SU3hexfy48HmS5SxmYArvciZCFq
 aAr0zNpzllEtTDVpq8Z/N2qO8CmOv2qN6o4uE+mWXeoXZ/TIEEVSp3Q+rdjF9TkLa38FdprZGPz
 wBUarPEBYzoYCO2DuaLUXS6rrTMpmsz8g0fvm+nBPFpI=
X-Received: by 2002:a05:6000:22c2:b0:3d1:c2cf:da07 with SMTP id
 ffacd0b85a97d-3e641e3aba5mr15886142f8f.4.1757602185656; 
 Thu, 11 Sep 2025 07:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKLGzRLE8Y22A/l9PEEwTiPtJScpX3bWabGz72+Y4Ou/THecDb+XACZue+pTvyaruFCFImdQ==
X-Received: by 2002:a05:6000:22c2:b0:3d1:c2cf:da07 with SMTP id
 ffacd0b85a97d-3e641e3aba5mr15886121f8f.4.1757602185219; 
 Thu, 11 Sep 2025 07:49:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3e760775b13sm2831469f8f.10.2025.09.11.07.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 07:49:44 -0700 (PDT)
Message-ID: <2ae622b3-4210-494e-95a3-cc20219779a7@redhat.com>
Date: Thu, 11 Sep 2025 16:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The different ways QEMU logs stuff
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>
References: <87bjnhgpg8.fsf@pond.sub.org>
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
In-Reply-To: <87bjnhgpg8.fsf@pond.sub.org>
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

On 9/11/25 14:10, Markus Armbruster wrote:
> * Tracing
> 
>    - Control: off by default, enabled with -trace per trace point (and
>      also -d trace: --- I find that duplication bizarre)

The series adding both "-trace enable=..." and "-d trace:" justifies it 
like this 
(https://lists.nongnu.org/archive/html/qemu-devel/2015-10/msg05808.html):

---
add a "-d trace:foo" option that is a synonym for "-trace foo";
this makes the new functionality more discoverable to people used
to "-d", makes it available for user-mode emulation (which does
not have -trace), and is somewhat nice if you want to enable both
tracepoints and some other "-d" flag (patch 9).  When globbing
it is also less susceptible to unwanted shell expansion.

For example, you can trace block device I/O and save the result
to a file just by adding "-trace bdrv_aio_*,file=trace.txt", or
correlate it to guest PCs with "-d exec,nochain,trace:bdrv_aio_*".
---

These days, user-mode emulation does have -trace (commit 6533dd6e111, 
"trace: [linux-user] Commandline arguments to control tracing").

Also, "-trace file=..." is a synonym of -D if the log backend is 
enabled, so it made sense to have a synonym also for "trace enable=" 
within "-d".

>      · "log" wraps around util/log.c's always-on logging

(FWIW this used to be "stderr" and it was not enabled by default; this 
ensured that tracing was used a lot less even by developers :)).

> * Spreading logs over multiple destinations can make the order hard to
>    determine.
> 
>    -D splits util/log.c from util/error-report.c.
> 
>    -d tid further splits per thread.
> 
>    Splitting per thread feels fairly redundant once the prefix includes
>    the thread name.  Thread names is easier to make sense of than numeric
>    thread IDs in the split filenames.

https://lore.kernel.org/all/20220417183019.755276-1-richard.henderson@linaro.org/ 
says "this can be extremely helpful in debugging user-only threads".

> * In my view, util/log.c consists of three layers.  Form bottom to top:
> 
>    * Logging messages: qemu_log()
> 
>    * Control of what to log ("log items"): qemu_log_mask()
> 
>    * Address filtering: qemu_log_in_addr_range()
> 
>    The bottom layer is also used by trace backend "log".

Makes sense.

> * Tracing vs. "log items"
> 
>    Tracing and "log items" both provide opt-in logging.
> 
>    Why do we have two?  Feels like an accident to me.

One is structured and the other is not.  Structure is both a curse and a 
blessing: a blessing because it allows plugging in external tools, a 
curse because it limits what you can write.

>    Address range filtering is only used with "log items".  It could just
>    as easily be used with tracing.

Agreed that address range filtering could be added to tracetool and 
supported by tracepoints (though probably it does not make sense for all 
of them, and maybe only makes sense for very few due to TCG's preference 
for log items).

Paolo


