Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E3BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 08:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0bwf-0006GH-Is; Mon, 22 Sep 2025 04:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0bwX-0006An-N4
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0bwN-0003hq-I3
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758529822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+j2xkHVn2CLJUgmPAUWV1GvLJiN63Yql1H8LPxFV96o=;
 b=UV3a1ErcISJhZiX5F5QaGuEDBMp1XbI3V5c2dMGQoGuSB+eaERq6HWIjCTXEKtuiLNswEt
 jWsfRhbZpDNovrTgvoYcDh/t9MVLie7zAbXXZEw7y4GfmbIDSZ/Xpe4wWoToKwP3OcVQ+j
 VPNQ0vPSCwbN26spkGHGjr3R0qhYaxU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-ul_QjIRSOV-99xXYNsa-Tw-1; Mon, 22 Sep 2025 04:30:21 -0400
X-MC-Unique: ul_QjIRSOV-99xXYNsa-Tw-1
X-Mimecast-MFC-AGG-ID: ul_QjIRSOV-99xXYNsa-Tw_1758529820
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e198ddbc1so1659105e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 01:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758529820; x=1759134620;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+j2xkHVn2CLJUgmPAUWV1GvLJiN63Yql1H8LPxFV96o=;
 b=J2XoNK0QEOoeg7/CW8k2fcmK7Ea5CveM7XfirFZ6aDasepujjSWJ0YtBilhHXJFjgd
 7e2RSfvbi/64OM+qgJ94S7BHkM/Yr2qiN8caQOzIDAx97siCZ+3tSoWzMIM/1kezL7L/
 g39ebV9wxwrhK7+S2xb0opjGb+iv7DCUyMD1U63093s1jVKkS9y/BbwIL94yyb96Y8y6
 0tquh0y0fKsn4JVMX5J825iZrQNJiqiSeFogK/cAQJk2flzzJ5ZbSScuxBb3+Bqv6sd4
 dhn6FTA7jyyu2gpbtm6ehOVz/ExEKR2eLxix+RjTSEtMSaMgnD0Cii41xNL1Unoya/s+
 hhHA==
X-Gm-Message-State: AOJu0YyZQvyWAmn2HieA6u9Eafgl/imwyohAJ7O5wT0dE1tUd+e4SOjR
 J99yBDntklERMNcVC7EhMxgXTMXdDc2HlIhnzCIA6qcOoTIgWC1wMU/2IITv3Ok1mLmshXQS7hl
 zdtXvIvQqhNJKxMsL8vrvUeQiURKmgv4KnK8Pd/zmsdODZIg2NMvVQop4
X-Gm-Gg: ASbGncu1NZMEJOVgb99djTgeuVSl8sT7GA56T2HBtCfW1Tyaof7YnX3lyzgLni6+/1v
 +n4WS7rmQEb5Ig/3guoQ1tBBZ73krnpFLluFYfKCDUw2TQR5/Mp8FE0CZ8fOIc1NGwbSXi/npmB
 4GkV62EQUN/zp1G8hrkrvYIjc/4UqvfuqMSCBCM7erAAXElXGeuTmIndbW2njN7VPzAr5gS/VWJ
 AFgj3PtV+ZCkJnt7Mq+X+TEQD1cH9SkoAnj4N6wss826Wi6dLiZLI7w7S1b5fn0V22h9LPXHEAA
 HPkB6plHG7tDkQuaQ7Vca2r43lEdCOgpY18wHT7n0OrwNeu5UHPhZ39Gg+vAq/Vq8auf6UFRN/0
 F/OVEzFapWw6CJbdwA8uL6VTQk+rSU76od6RuMrjFOlA=
X-Received: by 2002:a05:6000:178e:b0:401:2cbf:ccad with SMTP id
 ffacd0b85a97d-4012cbfceadmr907608f8f.17.1758529819707; 
 Mon, 22 Sep 2025 01:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+k6N6HcHYIv6QxO45WNTdmLxsXLzaDKDIJBiXplFTWbhaDpOr8mttDJSAcyt7GjBo9enC3A==
X-Received: by 2002:a05:6000:178e:b0:401:2cbf:ccad with SMTP id
 ffacd0b85a97d-4012cbfceadmr907571f8f.17.1758529819239; 
 Mon, 22 Sep 2025 01:30:19 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.47.123])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-46e0d08996csm9117515e9.11.2025.09.22.01.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 01:30:18 -0700 (PDT)
Message-ID: <cd953b2c-e487-42ba-99af-d54c506acb99@redhat.com>
Date: Mon, 22 Sep 2025 10:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] scripts/archive-source: speed up downloading
 subprojects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Kyle Evans <kevans@freebsd.org>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-3-marcandre.lureau@redhat.com>
 <aM1fjf1tuzuBXudQ@redhat.com>
 <CAMxuvawKG1h2mv3sHvm-e1n2M8N_DOpLxJROxCi4QkN-RHqkgQ@mail.gmail.com>
 <aNEEFJYDh4qzQVbX@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aNEEFJYDh4qzQVbX@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/22/25 10:08, Daniel P. Berrangé wrote:
> On Mon, Sep 22, 2025 at 10:59:11AM +0400, Marc-André Lureau wrote:
>> Hi
>>
>> On Fri, Sep 19, 2025 at 5:50 PM Daniel P. Berrangé <berrange@redhat.com>
>> wrote:
>>
>>> On Fri, Sep 19, 2025 at 05:32:56PM +0400, marcandre.lureau@redhat.com
>>> wrote:
>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>
>>>> Running meson on each subproject is quite slow.
>>>
>>> Why is this faster ?  Does it make meson do parallel downloads
>>> if you list then all at once ?
>>>
>>
>> It doesn't look like it does it in paralllel, yet it is x times faster...
>>
>> time sh -c 'for s in keycodemapdb libvfio-user berkeley-softfloat-3
>> berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
>> bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs libc-0.2-rs
>> proc-macro2-1-rs proc-macro-error-1-rs proc-macro-error-attr-1-rs
>> quote-1-rs syn-2-rs unicode-ident-1-rs; do
>>    meson subprojects download $s >/dev/null
>> done'
>> sh -c   5.27s user 0.33s system 99% cpu 5.613 total
>>
>> time sh -c 'meson subprojects download keycodemapdb libvfio-user
>> berkeley-softfloat-3 berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs
>> bilge-0.2-rs bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
>> libc-0.2-rs proc-macro2-1-rs proc-macro-error-1-rs
>> proc-macro-error-attr-1-rs quote-1-rs syn-2-rs unicode-ident-1-rs'
>> sh -c   0.32s user 0.01s system 99% cpu 0.339 total
> 
> Oh I bet that 0.32secs is the overhead of python importing all modules
> that meson uses. Running python 18 times, gives the 5 second overhead.
Oh, it actually is parallel!

     loop = asyncio.new_event_loop()
     asyncio.set_event_loop(loop)
     executor = ThreadPoolExecutor(options.num_processes)
     ...
     for wrap in wraps:
         dirname = Path(source_dir, subproject_dir, 
wrap.directory).as_posix()
         runner = Runner(logger, r, wrap, dirname, options)
         task = loop.run_in_executor(executor, runner.run)
         tasks.append(task)
         task_names.append(wrap.name)
     results = loop.run_until_complete(asyncio.gather(*tasks))

and then Runner.run -> Runner.run_method -> Runner.download


