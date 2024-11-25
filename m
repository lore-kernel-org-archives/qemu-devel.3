Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A3CD58067
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFX87-0002xP-Pw; Mon, 25 Nov 2024 06:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tFX86-0002xE-J5
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tFX82-0001a5-Ad
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732533579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n5zUBtx3wbIoeVO9tZ0lg36jObfRDZldZrcTXuUWTmM=;
 b=iAA+SlavJs7yYNtPEiM4Gzdz5i/eUyuTMGWqy7DiYIr7EFUal+vggY7EqbA62s4+s7/qbR
 e8IB7brCeF1ogYRDrq+PbJwEWHcVDeGU7Bu0stwa4BZP5IoETe8t6XirF7QciaWcdhhAII
 UBetFDuNa2Ap6R/FjyyBXodRLPiG1ZY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-_vVNt38LMceqGVCapFzj1A-1; Mon, 25 Nov 2024 06:19:37 -0500
X-MC-Unique: _vVNt38LMceqGVCapFzj1A-1
X-Mimecast-MFC-AGG-ID: _vVNt38LMceqGVCapFzj1A
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38235e99a53so2462653f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 03:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732533576; x=1733138376;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5zUBtx3wbIoeVO9tZ0lg36jObfRDZldZrcTXuUWTmM=;
 b=RBox/zzzYcM7tSgKoitsAJ4NNP7e8Gx1Vz5qUlwEyxv9CQdkyCLAU+FlqoG9k7u3b3
 Qo2e3N+F2PG84d96Rz1XhSCHpO5ASYTn8Qh9f4Wqdev4/q6bU1SfcdmE/siy48CZcBWM
 BqATIhVxuo5JJHC10/N6cHtjWbTLvNRfK30KOCs2UnBfslBCDXNr85wbd+3Uxm+Yrmaq
 Zk7W7ty8p907oZ20m4tt4xa0ICMW9c/EbP3rR9pQaJY6nFQQ0nz1fH24w1Jks6bQSGs+
 aJURbxq/FZFg/T5lftd550u3rTtndZxzEYuqH09lK9jsJ4+b96jD3DFsLnMWK8nBhyUf
 IIkQ==
X-Gm-Message-State: AOJu0YziRWbXcGjzFs662C5HPOqJu2611xlkUb/K+OSGSxqFtp8V7eLj
 aR10IyEskepqL3dcnIa1AAAk/kee+KL016U1SkgjEqC1EnZ6jvL+Q9fCKlPn1cUEScO7GMyvMjv
 fvXhT9sjXcyt0AXMvPGSCinIU/FyAM1oJNLVZv1umhq1v7ufXAWnl
X-Gm-Gg: ASbGncukeSELL+3XcCXM+bleT3XsXb3l4jLUzwdW82MWdCSA54BkMvR6adsuDzZYzmL
 VGpAMYuMAWw0ih/u2uiFS656qpmW5BVdQDa1sH9Az/beXNtgr2m64NuzuXacSf966kMXUcvUYS+
 7GRfHFQDtYh8Fw3rsJjp5Ike68kskGIgYVK181TF3eLnFMKUZkR+IoFxiPUNIGCUq4wmTBvKQcJ
 fZ3dLEjFKkxQ26DLb94AGgEleaKpI9z53RnatcSoJJpneDaJ38ZZeirHGYuFMvz3SQtIulEpe3F
 NeM=
X-Received: by 2002:a05:6000:1f8b:b0:382:4a94:af0a with SMTP id
 ffacd0b85a97d-382606027femr7923502f8f.20.1732533576410; 
 Mon, 25 Nov 2024 03:19:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH50b660C+7mHcaMIWSuZ+X32wgwjNbQoFtMW6NeKRxBbqdNM4CCqU5SWHEssDrVo5nY5PNmw==
X-Received: by 2002:a05:6000:1f8b:b0:382:4a94:af0a with SMTP id
 ffacd0b85a97d-382606027femr7923485f8f.20.1732533576020; 
 Mon, 25 Nov 2024 03:19:36 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafeceesm10117740f8f.37.2024.11.25.03.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 03:19:35 -0800 (PST)
Message-ID: <05108195-009e-4d06-bc79-065b1e3432ed@redhat.com>
Date: Mon, 25 Nov 2024 12:19:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting clang on windows
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
 <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
 <Z0REl6xtaYuvP876@redhat.com>
 <CABgObfYeNW2WYVkPVGmaPKXHLC6bfHm8fFO+wuoQzZiOB5DPyA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CABgObfYeNW2WYVkPVGmaPKXHLC6bfHm8fFO+wuoQzZiOB5DPyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On 25/11/2024 10.39, Paolo Bonzini wrote:
> On Mon, Nov 25, 2024 at 10:34 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>> IMHO we need to have confidence not only in the current state of the code,
>> but also that we're not going to accidentally regresss it in the future.
>> This is what the gcc_struct attribute gives us confidence in.
> 
> Yes, as you say below the "solution" to that could be simply to avoid
> bitfields. They are problematic anyway for big-endian machines, see
> the commit that Thomas pointed out. Unfortunately it's a
> human-enforced solution, but then it is already human-enforced for
> endianness issues.
> 
>> As an alternative is it practical for us to eliminate all bitfields
>> from our structs ?
> 
> It is (at least for guest-visible structs), but it is a lot of work
> and I don't think it's reasonable for it to block clang enablement on
> Windows.
> 
> Of course it is possible for future contributions. Pierrick, would you
> like to contribute a patch to docs/devel/style.rst as well?

FWIW, I now did some compiling in the background, one time with GCC + 
"-mms-bitfields" + "#define QEMU_PACKED __attribute__((gcc_struct, packed))" 
and a second time with the same setting, but with "gcc_struct" removed from 
the #define. Then I ran "pahole" on all qemu-system-* binaries from both 
builds and compared the corresponding outputs. Seems like we are currently 
clean and that 642ba89672279fbdd14016a90da239c85e845d18 likely was the last 
problematic structure that we had.

So fine for me if we allow compiling with Clang on Windows now, but we 
should make sure to avoid that those problems are sneaking in again. So 
Pierrick, please provide a patch to docs/devel/style.rst to say that we 
disallow bitfields in packed structs in future contributions. Then I think 
it's ok to remove the gcc_struct from QEMU_PACKED. (Just my 2 cents, of course)

  Thomas


