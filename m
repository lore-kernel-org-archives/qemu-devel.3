Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B13C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXZJ-0000R6-Vt; Thu, 27 Feb 2025 01:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tnXZI-0000Qn-C3
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:40:24 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tnXZF-0002u2-Ud
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:40:24 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fcf3a69c3cso949480a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 22:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740638418; x=1741243218;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4J49TJHtoIqUyW2VBf87xVoOLkOwmOKkkh2ZwJAZyGU=;
 b=PyafF6qZ4j4nXZmT6N2s1z6Prh+UEAZ9SgyyNpjSYP94e81a0yh8pTeEAiqbw3Sf50
 S++DzFUdenYOXmCCmRQ1VmptwHTyJ0tYldG6Rw27nIlGPAFVdaJ76tO6T69MMrdWtjyS
 6xkLoOvIBspw1ex+t9639sKw6BwwG81y8d8sF++B7RmrQTFLm/IRcsqmQWQVj5p6RcyP
 /ay5/J8kLlrLBzdmqR7PrFl4AZiQ3q8pHk9/DhwtCDXPYUJzijR/EcbF2JPs7VPUgQu4
 n44qzuPhzQKcqLyzVMs1xlF+NNVT0k+vNcr2ubptE95KO09IxfkFgjRmUrCvKZLELOOj
 FXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740638418; x=1741243218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4J49TJHtoIqUyW2VBf87xVoOLkOwmOKkkh2ZwJAZyGU=;
 b=Uld8iKl5t9JNYtAHh+p6IeoVvC/7NqM3EbqR/YgKp7SMiL3C/NplX3BVdh53i4A5Ge
 5iqAiJknSY0S+22ri97InQn6RiER2MttPJN5E6I/kL9i4GuUeavZYNt/kfcM1H4a+0AK
 6R9Q54I0KVB+RQYi+QSaC5gOpEfItl8rWbnS3lsDa0EZpv0YlATRhupCVuD2QoIAZJ27
 /cLx9CrxyRYCQofRRtvOz68Mlc5rruaVs3kcoH/ArN4HIBCs+FYppGuyndoSD1UesP0u
 dC+lFHQT43tAIfvXDYBPZ+DZzhdzc/8uHpNtR/RFKitZVcYY3XKaj1YdU1N3Ei5wZ9i0
 qOYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUOFd17sb5GDj+83FAVxr0Xf7L1LlKZf+H4SSgkwpk+vufx1UhAw8f+ZzwIHgeu6TK1iI7FBBgxiMl@nongnu.org
X-Gm-Message-State: AOJu0YwyvsLeUtMg29xcXmN0Q8kdk/iQLJYSYy+SJX1HqdteX+f1gyU2
 M8cINJPGBeVQ6KVcWAKLp/SwVoXesoxRBFVLk2ErbPf1w8htPwsUM5a2gmcNmqE=
X-Gm-Gg: ASbGncsl+KgLiSiyq6yReerCsQbmPtYWBc6wKFP+iv/wqUTKwe57TpvqBUNAiKQcDpF
 KqFJS09/Sj9nmttqWcLXeaVsxDLFC46Zkb6SsNyjGAhj9icXpl1qzvytwx7AQCX53NlXEsbHKWl
 f+56mjUkGs/AwxOEGy6O9huMy7XToFqz73VldrstovwNpzeDIzC6Y75CubT82ZfkMvH3CnYGpVy
 sYSC/S3jeLUwy03MI6GjL9JIDZt1Ga9OdBg+1kQ6vG4AF+kmktoIVAjYC3Y6dvKFv4V6BDNYJz6
 maUvh0Uetve0njb1nd0nprd53dko0kXn/wh5EUc=
X-Google-Smtp-Source: AGHT+IGVoPFkP7uTfvhqLC1YyuPVp5FXXAJeluEVZAui4DT+YYOUy83UZmKzxUz9DUTQS/+OseTK0Q==
X-Received: by 2002:a17:90a:d44d:b0:2ee:7c65:ae8e with SMTP id
 98e67ed59e1d1-2fe7e2f745emr10296844a91.11.1740638417703; 
 Wed, 26 Feb 2025 22:40:17 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe8284f121sm2842282a91.47.2025.02.26.22.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 22:40:17 -0800 (PST)
Message-ID: <c5e4b556-86de-4f25-b5d7-0b6cc751569e@daynix.com>
Date: Thu, 27 Feb 2025 15:40:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] docs/system: Expand the virtio-gpu documentation
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <20250119220050.15167-9-dmitry.osipenko@collabora.com>
 <c2e1c362-5d02-488e-b849-d0b14781a60f@daynix.com>
 <87ikq9r7wj.fsf@draig.linaro.org>
 <171b1cd3-1077-438c-a27c-3b9b3ce25f0f@daynix.com>
 <ea866d19-90f6-4bb9-a3f6-f84b2ea2c457@collabora.com>
 <86dce86b-03bf-4abe-b825-1341e93eb88d@daynix.com>
 <920043a8-9294-4b40-8d8e-3611727e4cd2@collabora.com>
 <0f88994f-1a93-4049-addc-a62e8ca49904@daynix.com>
 <d85f6669-8c46-4678-85d6-59240935d197@collabora.com>
 <fdd8b7ca-e4ad-405d-a58e-fbcb82183ec8@daynix.com>
 <59f70c1d-4c66-4440-a102-5f478749c8f3@collabora.com>
 <a8fc06f0-0197-4394-bac4-733f3fcef103@daynix.com>
 <6714cca4-7367-4d99-84b6-c83df80140e6@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <6714cca4-7367-4d99-84b6-c83df80140e6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/02/18 15:27, Dmitry Osipenko wrote:
> On 2/13/25 07:32, Akihiko Odaki wrote:
>> On 2025/02/10 6:03, Dmitry Osipenko wrote:
>>> On 2/6/25 08:41, Akihiko Odaki wrote:
>>>> On 2025/02/06 2:40, Dmitry Osipenko wrote:
>>>>> On 2/3/25 08:31, Akihiko Odaki wrote:
>>>>> ...
>>>>>>> Requirements don't vary much. For example virglrenderer minigbm
>>>>>>> support
>>>>>>> is mandatory for crosvm, while for QEMU it's not.
>>>>>>
>>>>>> Is that true? It seems that virglrenderer uses builds without minigbm
>>>>>> support to run tests on GitLab CI.
>>>>>
>>>>> CI is running in a headless mode using software renderer. For a
>>>>> full-featured crosvm support running on a baremetal, minigbm should be
>>>>> needed, along with other downstream features.
>>>>
>>>> That makes sense.
>>>>
>>>> Based on your input, for QEMU, I don't think we need a separate
>>>> documentation to describe libvirglrenderer's build flags though crosvm
>>>> should have some documentation saying it requires minigbm.
>>>>
>>>>>
>>>>>> Anyway, if there is any variance in the build procedure, that may
>>>>>> justify having a separate build instruction in QEMU tree to avoid
>>>>>> confusion. Otherwise, it's better to have a documentation shared with
>>>>>> other VMMs.
>>>>>>
>>>>>>>
>>>>>>>> I'm not entirely sure the documentation will stay as is for that
>>>>>>>> long.
>>>>>>>> The requirements of Intel native context refer to merge requests
>>>>>>>> that
>>>>>>>> can be merged sooner or later. Asahi may need more updates if you
>>>>>>>> document it too because its DRM ABI is still unstable.
>>>>>>>
>>>>>>> The unstable parts of course will need to be updated sooner, but the
>>>>>>> stable should be solid for years. I expect that about a year later
>>>>>>> requirements will need to be revisited.
>>>>>>>
>>>>>>
>>>>>> It will be some burden in the future. Now you are adding this
>>>>>> documentation just for QEMU, but crosvm and libkrun may gain similar
>>>>>> documentation. The DRM native context support for Intel and Asahi
>>>>>> is in
>>>>>> development, and I guess nvk will support it someday.
>>>>>>
>>>>>> So, a very rough estimation of future documentation updates will be:
>>>>>> (number of VMMs) * (number of DRM native contexts in development)
>>>>>> = 3 * 3
>>>>>> = 9
>>>>>>
>>>>>> That's manageable but suboptimal.
>>>>>
>>>>> I don't mind deferring the doc addition if that's preferred. Either way
>>>>> is fine with me. Yet it's better to have doc than not.
>>>>
>>>> My suggestion is not to defer the addition, but to add it to Mesa, which
>>>> does not require deferring.
>>>>
>>>>>
>>>>> In my view crosvm and libkrun exist separately from QEMU, they serve a
>>>>> different purpose. Majority of QEMU users likely never heard about
>>>>> those
>>>>> other VMMs. A unified doc won't be a worthwhile effort, IMO.
>>>>>
>>>>
>>>> When evaluating the utility of a unified documentation, Whether the
>>>> majority of Mesa/Virgl users care VMMs other than QEMU matters more. And
>>>> I think it is true; libkrun and crosvm are excellent options for
>>>> graphics-accelerated VMs.
>>>>
>>>> If we have a unified documentation, any VM can point to it for the build
>>>> instruction of Mesa and virglrenderer. Once that's done, QEMU users who
>>>> want graphics acceleration can take the following steps:
>>>> 1. See docs/system/devices/virtio-gpu.rst
>>>> 2. Figure out that they need Mesa and virglrenderer
>>>> 3. Click the link to the unified documentation
>>>> 4. Build Mesa and virglrenderer accordingly
>>>>
>>>> No other VMMs will bother them in this procedure.
>>>
>>> Will see. For the starter, adding example build flags to QEMU doesn't
>>> hurt, it's a very minimal information. Later on, if and when all
>>> relevant Mesa/virglrenderer doc pages will appear, it won't be a problem
>>> replace QEMU flags with the links. Please let's do it step-by-step, one
>>> step at a time :)
>>>
>>
>> To be honest, I'm concerned that you may be using QEMU as a staging tree
>> for Mesa/virglrenderer. Submitting a documentation to QEMU as a
>> preparation to submit one to Mesa is not OK.
>>
>> You shouldn't submit a documentation to QEMU if upstream
>> Mesa developers rejects it because it contains too little information.
>> It may not hurt QEMU, but still lacks a valid reasoning.
> 
> Don't understand what you're talking about here. I may remind that this
> is not my QEMU doc patch to begin with, hence it has nothing to do with
> Mesa nor with virglrenderer. Alex wants to help QEMU users by adding
> more QEMU documentation.

I understand Alex and you intend to help QEMU users, but sometimes a 
change to help QEMU users is better to be done in the upstream of its 
dependency.

For example, when I submitted a patch to suppress a sanitizer warning in 
the past, I was asked if it may be better to propose a change of the 
sanitizer behavior instead of changing QEMU code. We eventually 
concluded we should change our code at that time, but it could have 
turned out otherwise. It is no different from the normal review process; 
a submitter proposes a solution, a reviewer suggests alternatives, and 
both figure out the optimal one in the discussion.

> 
> Maybe you're also not very familiar with the Mesa development process.
> This is okay, no problems.
> 
>> Mesa should have more people who care virtio-gpu as there are people
>> using other VMMs and perhaps it may be difficult to convince them to add
>> a documentation like this. It is still not a good idea to workaround
>> that by adding one to QEMU. The documentation submitted to QEMU is
>> mostly reviewed only by me, who barely used Venus and DRM native
>> contexts, which is not a good sign. Getting reviewed by more people is
>> one of the advantage of open-source contribution after all so let's keep
>> it.
>>
>> I can help you add a documentation to Mesa by reviewing and supporting
>> one if you want, but I cannot support adding one to QEMU if it's done to
>> avoid a potential challenge to add it to Mesa.
> 
> Thanks a lot! More reviewers always good to have, will definitely ping
> you. Right now writing more Mesa documentation isn't a priority, hence
> will take time to get to it.
> 

I appreciate your contribution to the documentation too. Once there was 
no documentation, but Gurchetan Singh added one along with their 
Rutabaga patches. With your change, the documentation will be 
comprehensive also for virglrenderer.

Regards,
Akihiko Odaki

