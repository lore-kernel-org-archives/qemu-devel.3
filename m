Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67540CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3AJ-0001cs-U2; Mon, 01 Sep 2025 07:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ut3AD-0001Yq-AB
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ut3A3-0003Sq-JL
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756727839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TTT8kRIsMSZH3fcysF8UhiZnE2FdZ4+bj/E+H1QmuVk=;
 b=TYBqY8q9az8s0Zf5swvAa6QwDu0OPrzFb5pywv5lZ1szdv73z808PYmleKREjZq1pEMqzt
 U1UUDRjThPExnrrw2UfxXEH66C666E+ChfnnRXZ1yWfdRKGQfiNbW88rXZjTWvHokLksTS
 sgfX5M/Zi+sgwS4ZOG+dBhq3rl5E3hw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-C4_I_qvkOo-XAr9Y_sZZaQ-1; Mon, 01 Sep 2025 07:57:15 -0400
X-MC-Unique: C4_I_qvkOo-XAr9Y_sZZaQ-1
X-Mimecast-MFC-AGG-ID: C4_I_qvkOo-XAr9Y_sZZaQ_1756727833
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3cf48eca078so2494992f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727833; x=1757332633;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTT8kRIsMSZH3fcysF8UhiZnE2FdZ4+bj/E+H1QmuVk=;
 b=Zv5cXIk03+1kJpVKwH2fzHyX1QniPhYy10XpBKOHJtwGyXeuiilowTAMGX+6JIBn5/
 PkA8Ud9N+Jgi4MnwriKPvBSiZjgy5Fj1E64t6t7udUhvlxxo4o7i304iy90cykV3NKpY
 i6ZUeKhrYyGSbMQ2r04oW58tBoURBBL3T6+DBrWY23ZWTnD9YcZ4n/3NsoEnC//hKyC0
 SDE3D4erDlX5LNxzvXt6JFvvspnxJCefzd6lx/taQUxa2kSE2Qj7cFmPhuLN8EXMIJJy
 fUnjHJ2AUSmIff+/bJQ43cbthpOqs3J4nnDV1Iy8AXcbqbmqESoo7cdfFwzVMfhJUyam
 ycNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2jVa8DJrnx7vbt/hL7wIzH3J2TsDpRlIPWnK+bfuq5ZOOjR4Jm+Izn+9pSm+rzFm0EvUOqPt3ivxB@nongnu.org
X-Gm-Message-State: AOJu0YyQifRudcgbBD/PBCF9+rbh5JlD3Q8T67wA7bnYVAI86KKI+nIw
 Hic2fWx3e8PPVCmganF2Fz+Q3TMf41OVOOhf8E43YGO48tVg5X/P3PaXXeB+lnmHcT/rTkzJ9Ki
 jEr6uJpaYYyS6noMrT976N0vEQ189bMAb80NxCf44ZOx2Tww83F6b4Vvq3yghqkAs
X-Gm-Gg: ASbGncsQTsSa/CmRllwHFdNP6YY8mvJJKvd5L9xNpUn27M7c8jm+bZbk6mXwoWJIHhH
 21rWaQ09SprL1yLOw7+UJBX+OAogA6d3ryaAx72lmno+QacmwDhdluccMcCMmtpGtPhT2bo0W3G
 zEhccU9cxbmhvRnXPjseNjrgNvBTssLQt4IRxiJta/TsGOA9HXwdHS+1B9HT584zZd9an/Ov2lk
 sNcwBiwtNyLFQSCR6TKIh9N8BuEairXeo7VfD0YUmMjMVhNE6pYm5zfmjXjQdpqaasfrpljvFqL
 oN2mZIud1nCXuKxIdGrqr0VchHbsrHrKJcvpWgmoD/5Hw+XbA8njPaaEK5bLzGCRRIHrzVz1QMq
 DpQA=
X-Received: by 2002:a05:6000:2403:b0:3d7:2cf7:9361 with SMTP id
 ffacd0b85a97d-3d72cf796c4mr1614403f8f.21.1756727832949; 
 Mon, 01 Sep 2025 04:57:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLuG33RbubXfxVrtraVRqagd4Z1xpppkIGlNsyz5uTF2H0hBKGmPQ+q82FnDDHbScbE85YTw==
X-Received: by 2002:a05:6000:2403:b0:3d7:2cf7:9361 with SMTP id
 ffacd0b85a97d-3d72cf796c4mr1614385f8f.21.1756727832507; 
 Mon, 01 Sep 2025 04:57:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6fe5sm234654995e9.5.2025.09.01.04.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:57:12 -0700 (PDT)
Message-ID: <52f9eaaa-cf33-4558-b869-f4f66844f92e@redhat.com>
Date: Mon, 1 Sep 2025 13:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] e1000e: Prevent crash from legacy interrupt firing
 after MSI-X enable
To: Jason Wang <jasowang@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250807110806.409065-1-lvivier@redhat.com>
 <CACGkMEsYDPjPBNmAd=AmZQ2AY46weFC_u8PK=+CSCuUD6W9zYg@mail.gmail.com>
 <20250818140313.GA7391@fedora>
 <CACGkMEvUq4ugS6PQ=mRH5Kx+rnDda5Wq3K8hSVrehv3=n5xk4Q@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CACGkMEvUq4ugS6PQ=mRH5Kx+rnDda5Wq3K8hSVrehv3=n5xk4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Jason,

On 19/08/2025 04:46, Jason Wang wrote:
> On Mon, Aug 18, 2025 at 10:03 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> On Mon, Aug 18, 2025 at 10:08:18AM +0800, Jason Wang wrote:
>>> On Thu, Aug 7, 2025 at 7:08 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>>>
>>>> A race condition between guest driver actions and QEMU timers can lead
>>>> to an assertion failure when the guest switches the e1000e from legacy
>>>> interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
>>>> RDTR) is active, but the guest enables MSI-X before the timer fires,
>>>> the pending interrupt cause can trigger an assert in
>>>> e1000e_intmgr_collect_delayed_causes().
>>>>
>>>> This patch removes the assertion and executes the code that clears the
>>>> pending legacy causes. This change is safe and introduces no unintended
>>>> behavioral side effects, as it only alters a state that previously led
>>>> to termination.
>>>>
>>>> - when core->delayed_causes == 0 the function was already a no-op and
>>>>    remains so.
>>>>
>>>> - when core->delayed_causes != 0 the function would previously
>>>>    crash due to the assertion failure. The patch now defines a safe
>>>>    outcome by clearing the cause and returning. Since behavior after
>>>>    the assertion never existed, this simply corrects the crash.
>>>>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1863
>>>> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> ---
>>>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>
>>> Consider rc3 is out. Can this be applied directly by maintainers or a
>>> PULL request is expected?
>>
>> The commit description doesn't mention whether this fixes a regression
>> introduced since QEMU 10.0, whether there is a security impact, etc.
>> In the absence of more information, this looks like a regular bug fix
>> that does not need to be merged for -rc4.
>>
>> Only release blockers will be merged for -rc4 (Tue 19 Aug). Please
>> provide a justification if this commit is a release blocker. Reasoning:
>> - From -rc3 onwards the goal is to make the final release and adding
>>    additional patches risks introducing new issues that will delay the
>>    release further.
>> - Commits should include enough information to make the decision to
>>    merge easy and documented in git-log(1). Don't rely on me to judge the
>>    severity in areas of the codebase I'm not an expert in.
> 
> I see, I think it's not a release blocker so we can defer this to the
> next release.

just a reminder not to forget to pull it now...

Thanks,
Laurent


