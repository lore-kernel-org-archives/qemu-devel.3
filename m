Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9B2C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTfwZ-0007T8-2X; Mon, 23 Jun 2025 08:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTfvp-0007KJ-J3
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:05:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTfvh-0006hR-Jn
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:05:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so3029150f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750680337; x=1751285137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LhVmC7Ptr86082iSVP3tCUv3mxHNuSnJ7XLqXn+lKmI=;
 b=rvtZ//nS7KVdXEBg2bBDstD3Fc6/HMuW70+dA+T3AdmM+qCCMR49nZmKkJ/Um+VINq
 GB5NErfvi7OF7szvajnslPWU6JLPJOm3YPqRhOvRpRrFGGA7ZNJahFWmA5MqMOOP+rBq
 6T2fuYT9FxO8CRwQ/5QdUicgJvGdvMYCqhvuZ6F0wMMYZyRPh1Gz5m61ch+Hjqn1EfX/
 2xITOaQ/QZmGsi5W2nVauztUcDtysnjOd7+h3LzPEQ9yChBSTbzljr+yQNr7FYkJCRh6
 Z02q5PlpB/fXSk4CjvfkeLPuB4JTNH/aYmqB9cG5SyqAfiAkW+AHvMiLFqbD/QpgxH9d
 u8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680337; x=1751285137;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LhVmC7Ptr86082iSVP3tCUv3mxHNuSnJ7XLqXn+lKmI=;
 b=H5O1D+y9bU/0GlZ/+yUhW9X7plpcH4Id72zeVe17EYQ/DGmvlaBkgCh9gc1N7dGOYv
 IZMqwiNnr6kQy7Htxlb4JxN4u+cZw5U84JhPXcWaC7PaXXUUsE6nsuBQe7P7BXzDMvkn
 eU4kblnRgYt9Ty2+DcdUnIqbmzv6AnbzueprjEO4YbwWYHebFU+nr4dZZqkriUw//rCB
 a+6OVKCeBdRKqLmMUTQUD4u2NfRprKjKKjs9oYenIBLX7LTo7717Z8byHdfeVF4ObP/S
 oCA0vRD0xQ46sTtkkrM9tuKgHjFS1J7DWmDHO/8W0GzAhMt6UyjSzKLlO7ocWm/Hr42J
 hgfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXIY512LTBkOqrp8IBJ5+SL/vsKdJlDRWSfGlF3jKc9adhd05/a74naAokYobL5HN4WjOYgRWMY/PG@nongnu.org
X-Gm-Message-State: AOJu0Yy5AtobUtlszrhnfStFk2bvYyYioluxxWG2Q0lJkx1SlcUY/hXV
 MDF9ouSuS+weoPVFYQeDU9xNl77ruAMEXXsFP0b9LWJak3+y3tsq9LZcrRubLFLiONQ=
X-Gm-Gg: ASbGncuSbVcQyIsThcYrrfOJIFy5Uny1Zi1EcGFTjUr38ygb+0NgbtbyCCStA9fk3VU
 N7aMdDV7dMrkq9BUWTNs1iQ3tumbrTm/Q7z0+rqIvcXrFb/vu8679Un8Ecjdy1YnUwLyJaFCxjM
 Iu0wCSrndjTAWxxPmqddlNV42Zyxn6xi4JqNpW5ZEq+zES8fAvTgiApS7/NZN9pL/itMmS/pRJp
 sdAepLRgxXfBSVi25uQRu1Oyzf6YEHTIf8TRPqU8HKyCb6/EGqcRBTkoxU04boIGrCif/Lxu1aE
 dMJxAKtcDsKhFHJ+ya4KMOCgUneH/WirFXZMm64IU98cI5ZNiQTYyZMSJ0ZHMf5Isf8GRSjKfLR
 76aFefqVkvmji9Y4xkBgjM7gqNAXmZQ==
X-Google-Smtp-Source: AGHT+IFqbtwF21H6pWk34kjB74g+vaQ792b2mQtfrzzfV/L7m1oPbaWH1vPXMofzQKaBoxU+8UO20g==
X-Received: by 2002:a5d:5f93:0:b0:3a4:e238:6496 with SMTP id
 ffacd0b85a97d-3a6d27e17c2mr9044838f8f.18.1750680336753; 
 Mon, 23 Jun 2025 05:05:36 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97a908sm142235035e9.4.2025.06.23.05.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 05:05:36 -0700 (PDT)
Message-ID: <424c91ee-f5cb-40a1-b1bd-3f0648ae83f5@linaro.org>
Date: Mon, 23 Jun 2025 14:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/26] tests/functional: Restrict nexted Aarch64 Xen
 test to TCG
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Bernhard Beschow <shentey@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, John Snow <jsnow@redhat.com>
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-24-philmd@linaro.org>
 <497fc7b1-dfd2-49ad-938c-47fca1153590@redhat.com>
 <be71c7cc-a5ba-4ba5-b697-60814b712eea@linaro.org>
Content-Language: en-US
In-Reply-To: <be71c7cc-a5ba-4ba5-b697-60814b712eea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/6/25 13:59, Philippe Mathieu-Daudé wrote:
> On 23/6/25 10:11, Thomas Huth wrote:
>> On 20/06/2025 15.07, Philippe Mathieu-Daudé wrote:
>>> On macOS this test fails:
>>>
>>>    qemu-system-aarch64: mach-virt: HVF does not support providing 
>>> Virtualization extensions to the guest CPU
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   tests/functional/test_aarch64_xen.py | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/ 
>>> test_aarch64_xen.py
>>> index 339904221b0..261d796540d 100755
>>> --- a/tests/functional/test_aarch64_xen.py
>>> +++ b/tests/functional/test_aarch64_xen.py
>>> @@ -33,6 +33,7 @@ def launch_xen(self, xen_path):
>>>           """
>>>           Launch Xen with a dom0 guest kernel
>>>           """
>>> +        self.require_accelerator("tcg") # virtualization=on
>>
>> What about kvm (or xen) as accelerator? Would that work?
> 
> IIUC this tests boots a nested Xen guest running at Aarch64 EL2,
> and at this point we can only run EL2/EL3 on TCG. HVF and KVM
> can not for now (we are working on it).

I'll update the description with:

   Currently QEMU only support accelerating EL0 and EL1, so features
   requiring EL2 (like virtualization) or EL3 must be emulated with TCG.

> I don't know if Xen can accelerate EL2, it would need support for
> such hardware (like the Apple Silicon M4). Cc'ing Xen folks to
> figure it out.


