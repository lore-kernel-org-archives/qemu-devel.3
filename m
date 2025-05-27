Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC68FC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 10:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJrBo-0005VU-VM; Tue, 27 May 2025 06:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uJrBm-0005SR-6X
 for qemu-devel@nongnu.org; Tue, 27 May 2025 06:05:43 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uJrBj-0006C4-Pi
 for qemu-devel@nongnu.org; Tue, 27 May 2025 06:05:41 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ad572ba1347so540397566b.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748340336; x=1748945136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lNELs6OMqCjWJuC9hCis0gVJZeKPx9DuvpLtLQxhFw=;
 b=yTD66A9m4ixxlxdfPg2CvyIXcDHkzQHmHhKn8+qk443PUCIl7L9b+2lV4EDv82KD4a
 A4OGmGIW13OnGDK7djPwBH5vQAB38OknUGSvrDz98gpAW9ihtTG6L/ihwI72eTWu2JaO
 9KmCXyTlBGhXyjEFhT9K3rJmDojwBnhb0UXEqs5CTnCSGR5DU7aNdEONt0yqcaGHmksT
 /Dm8SuKt8doInCXsl+56bE6nIUSSr0DjB7ZyF8NSB6PPxbvWm0rxdgFFhZgYK5g6djcq
 +EIjt8OT3uz8c35PdIdpLPrfqiVHjlG1LJ/K0bIYKxaLmDCYwT/a3FuC8oW5yzT2ZUJT
 QqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748340336; x=1748945136;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2lNELs6OMqCjWJuC9hCis0gVJZeKPx9DuvpLtLQxhFw=;
 b=O4+LDBQrjQ9J6b+w5w4GTlVeGEMTN25mCPynDeR032ZV+/EogUuNvX4ApvyXzKAMlV
 NJ9ZmDPEjfYdiMbhyx23tz5ElcUE6pefB/hSvgGi91kenF+2dDNuBGjsrQi2IxN7KOKR
 QUIiXMLKqGMKQEfToDTneWswlJtEOggov9OtN+TSjZdkdrLVsUWU2DNfadONA37ymYGM
 rU56AtnOUjBApOcWWbaQNhcYevu5Wl5s3+gWnSjQyYHra09mEm6Dd11RYYu9trt5S92j
 ovCBDDz1VoEy9rGL37iUhiFFSp3yLVoc3SE8wjyKVwX4yo2koaRTG1A+uhRr+jrP//G9
 YKLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx9CDj/LUTxUkbJLpq5k99Ps6IVXNz0xgenezNrxKzxEQI6b+bK/IpMFHBR6FHDl5PNVdQ1VlcZAwZ@nongnu.org
X-Gm-Message-State: AOJu0YyqzQkZAgaYq3+XMSbaQj0P3i2pTINeEl/a1k6vgYP+WrpqEsZr
 44sFDf2ggui7PjotOl2802Qe3mLiQfLFMJJv6XORgbdkCMVwHnzZVc9Is9gEFpLT3NcZlmZA//L
 ibatTJrM=
X-Gm-Gg: ASbGncu4RuR2Y0U25ZJUwvWXDHe64eKMxPJqhmeJAmyURn1dDMqaMHF9KglcJGOv21J
 FZV8WycrRoo2wyiTRlfMpksLHRhYcB0rdkEvaZaGziPHL4fD2/F8/9RVDr9EOrXQGisDyOdPZax
 vTNs/LGPi7Uq3lqVy7EWPm9StEI4Uo77u/MY8nY+zXD+PGa+GIetv7PE4vz9v1PuLUGOQ+9nxe9
 VjWN2kmrOswjf584DMd6R+Xpzr90Tb6LPxgq3OoXZnJw+FhOPtk1HtURUJLNNRc80Qn108iMSjK
 taqYqdPqOXQ9Jj7s+XeyeLZY+o118uRqHFym66tx465T474Y8Es2
X-Google-Smtp-Source: AGHT+IGLoSGJ3wkV0R0aHw+XDcYwpds2bqUBBIc7cKDxPep72NFiCAYsn3vhHYYr3blTR93TaQjmHA==
X-Received: by 2002:a17:907:1c10:b0:ad2:e683:a77e with SMTP id
 a640c23a62f3a-ad85b2122cdmr1048079766b.53.1748340335646; 
 Tue, 27 May 2025 03:05:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad88acd2576sm109698866b.79.2025.05.27.03.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 03:05:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4A3DD5F80B;
 Tue, 27 May 2025 11:05:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Peter Xu
 <peterx@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Markus Armbruster
 <armbru@redhat.com>,  David Hildenbrand <david@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3 12/20] virtio-gpu: fix hang under TCG when unmapping
 blob
In-Reply-To: <d5c429eb-d583-4b9d-85c1-b0636e789e9c@daynix.com> (Akihiko
 Odaki's message of "Thu, 22 May 2025 18:54:21 +0900")
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-13-alex.bennee@linaro.org>
 <4d300cca-3ac2-4072-a35c-0b6aef970b26@daynix.com>
 <87bjrl87p5.fsf@draig.linaro.org>
 <83945c43-bfb2-4469-90bd-e3a7c2ca5d89@daynix.com>
 <CAAjaMXZ8acKBSGHvcQOcOnzBDCjFU1SOjse7pHtHWxNeREc2gg@mail.gmail.com>
 <199e7486-7d05-459b-ad51-cb9b130f299f@daynix.com>
 <875xht805w.fsf@draig.linaro.org>
 <d5c429eb-d583-4b9d-85c1-b0636e789e9c@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 27 May 2025 11:05:34 +0100
Message-ID: <871psanzbl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2025/05/22 18:28, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2025/05/22 16:31, Manos Pitsidianakis wrote:
>>>> On Thu, May 22, 2025 at 10:03=E2=80=AFAM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
>>>>>
>>>>> On 2025/05/22 15:45, Alex Benn=C3=A9e wrote:
>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>
>>>>>>> On 2025/05/22 1:42, Alex Benn=C3=A9e wrote:
>>>>>>>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
<snip>
>>>>> In such a case, a bug should be fixed minimizing the regression and t=
he
>>>>> documentation of the regression should be left in the code.
>>>>>
>>>>> In particular, this patch can cause use-after-free whether TCG is used
>>>>> or not. Instead, I suggest to avoid freeing memory regions at all on
>>>>> TCG. It will surely leak memory, but won't result in use-after-free at
>>>>> least and the other accelerators will be unaffected.
>>>>>
>>>>> Regards,
>>>>> Akihiko Odaki
>>>> We tested this fix with ASAN and didn't see anything. Do you have a
>>>> test case in mind that can reproduce this use-after-free? It'd help
>>>> make a certain decision on whether to drop this patch or not. I'm not
>>>> doubting that this can cause a use-after-free by the way, it's just
>>>> that it is hypothetical only. If it causes a use-after-free for sure
>>>> we should definitely drop it.
>>>
>>> No, I don't have a test case and it should rarely occur. More
>>> concretely, a UAF occurs if the guest accesses the memory region while
>>> trying to unmap it. It is just a theory indeed, but the theory says
>>> the UAF is possible.
>> I have a test case this fixes which I think trumps a theoretical UAF
>> without a test case.
>> Why would the guest attempt to access after triggering the free
>> itself?
>> Wouldn't it be correct to fault the guest for violating its own memory
>> safety rules?
>
> docs/devel/secure-coding-practices.rst says "Unexpected accesses must
> not cause memory corruption or leaks in QEMU".

Agreed.

> I'm not completely sure whether it is safe without concurrent accesses
> either. In particular, KVM does not immediately update the guest
> memory mapping, so it may result in a time window where the guest
> memory is mapped to an unmapped host memory region, and I suspect that
> could cause a problem. That also motivates limiting the scope of the
> change to TCG.

Surely it does:

        memory_region_set_enabled(mr, false);
        memory_region_del_subregion(&b->hostmem, mr);

will trigger a rebuilding of the flatview - so after the memory region
is deleted any guest access should trigger a fault to the guest. Only
then do we unparent the memory region and finish the clean-up.

I don't think we want to have different paths for KVM and TCG here as it
will further complicate already complicated code.=20

>>>>> Instead, I suggest to avoid freeing memory regions at all on
>>>>> TCG. It will surely leak memory, but won't result in use-after-free at
>>>>> least and the other accelerators will be unaffected.
>>>> Leaking memory for blob objects is also not ideal, since they are
>>>> frequently allocated. It's memory-safe but the leak can accumulate
>>>> over time.
>>>>
>>>
>>> Memory safety and leak free cannot be compatible unless RCU is fixed.
>>> We need to choose either of them.
>> How can the guest access something that is now unmapped? The RCU
>> should
>> only run after the flatview has been updated.
>
> This patch bypasses RCU. That's why it solves the hang even though the
> RCU itself is not fixed.
>
> Let me summarize the theory and the actual behavior below:
>
> The theory is that RCU satisfies the common requirement of concurrent
> algorithms. More concretely:
> 1) It is race-free; for RCU, it means it prevents use-after-free.
> 2) It does not prevent forward progress.
>
> The patch message suggests 2) is not satisfied. A proper fix would be
> to change RCU to satisfy 2).

Its mutually incompatible with virglrenderer - we have to block all
commands until the virgl resource is freed and we can't do that until
the memory region is unplugged.

So yes we do bypass RCU for this but by explicitly un-parenting the
resource once the mapping has been removed.

> However, this patch workarounds the problem by circumventing RCU,
> which solves 2) but it regresses 1).

I'm still not seeing how this happens and without a test case to
demonstrate it happening I can't hold this patch in limbo forever.

> My suggestion is to document and to limit the impact of 1) by:
> a) Limiting the scope of the change to TCG.
> b) Not freeing memory regions, which will prevent use-after-free while
> leaking memory.
>
> Manos said b) can be problematic because mappings are frequently
> created. Whether b) makes sense or not depends on the probability and
> impact of UAF and memory leak

Not freeing memory regions would lead to a DoS attack instead. I don't
think we can just accumulate region like that.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

