Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BC2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiLF-0003US-3u; Tue, 16 Jul 2024 09:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTiLA-00034o-2e
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:35:37 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTiL5-0005Gi-FL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:35:35 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso4488705a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721136929; x=1721741729;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2mq8RtitsDMPiZWqQs5u2akmjdCXnOT9QkK7cEixIyc=;
 b=GjhekbLWW7pwA+RoD6Y6dL2RTFtNx+4SdObt6CgqEPNQuGkYZ0nlW9uTuWcI7fuE8i
 7Mq9HJ4TCK8xe5Js6SG2rkVTYwODY9Fw1mnkPY9P+UnYetCZGy1UiRj5db1k/p4cFwgH
 lJ+P29dSo5DS0idvXphTcVW2kFzJ5PKYIPxxqXNILR/Pe2JJ4SW/rF9lkEFKOc49YB/e
 P0AVGfOHrzO9/BbwjzJgs2uwSdeuCJBsshQH6tPh/teSUO9Krrda06cHISFpGLUkZMJY
 AJ3kG/dHOqk6ggu+q7b8a7bryFIi4OusJ3eIKGc3TfEWOvwdhep4Q1MQFKDfiXs1smjA
 rVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721136929; x=1721741729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2mq8RtitsDMPiZWqQs5u2akmjdCXnOT9QkK7cEixIyc=;
 b=rer+neSmks5/jYYdhgEjWGwuz422WMRmnzXWhYyG1CvYDC7OuPrvXuMIrW0NodE1Pp
 tJQI21fO42t5I2II6sWytcBMOh0yTwVAke/qBvrFK3dmASjDa2mbKGarC8GaMs0WCHfu
 IQG1rD6YiRrsW+y8ZyqdO6FDwbLMhVzSxbnKqAC0gpBf0r9BkiP9HFsp8RMLguKFT4jD
 YI7qVwKhuChtEmMNLDH6/vCe7rcQ+c8j4jSIH2wAlAEDGcZNdxWAZ2sHvDwAXSjP50tG
 vIV+iNx7XMdq5aNbKYrGaYkMrXkCJICGShaPzC3qtJ7C69YB0GlxEHrBEEs5Hl0QFY4X
 kI5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmGi1USRol5aY78PZDpgyepGBQGOYn1oW26G6vFxgVMIzqjYVEeyhWXxB0MBzC2FxBK6X2hDaWaj/I/kPzqT18Q57siEI=
X-Gm-Message-State: AOJu0YwJwqbG+hsoO6TUmuib+SgC4oXWzhIKsgYwbJ9gTxRMWkNLOOI6
 DZ4O3yPZcfQb/hDmZWUQR+VK4K3MR44pirTsrWJYavL4tWmR4d8gFjGYxgY6BKo=
X-Google-Smtp-Source: AGHT+IH4fLvbL+i91yr8UWjaLlUKbV8xVkZY5RGofO/CPzk2WVp+za6m6v7iJcT6ixLd6bjpHhQlwg==
X-Received: by 2002:a05:6a21:339f:b0:1c2:9554:fd07 with SMTP id
 adf61e73a8af0-1c3f120316dmr2874844637.1.1721136929130; 
 Tue, 16 Jul 2024 06:35:29 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc516dasm58248845ad.288.2024.07.16.06.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:35:28 -0700 (PDT)
Message-ID: <fe1f7bb0-b235-4f57-ab56-8da1ef0ce18e@daynix.com>
Date: Tue, 16 Jul 2024 22:35:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] util: Introduce qemu_get_runtime_dir()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
 <bca5bd94-d6af-450b-a023-0bbe57fdba3f@tls.msk.ru>
 <ZpZDseDnUD39cBzE@redhat.com>
 <CABgObfasdAS443K6+2hHE1chWXei_1ytyRTOi7tX+ma8hZEC6A@mail.gmail.com>
 <3a74c242-2510-4ae0-8ac7-02b6cf7dde69@daynix.com>
 <CABgObfab1xUc8bz7Sr4zs+tiKwLBmPK-App+iULE2AHhz2-rbw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CABgObfab1xUc8bz7Sr4zs+tiKwLBmPK-App+iULE2AHhz2-rbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/16 22:29, Paolo Bonzini wrote:
> On Tue, Jul 16, 2024 at 2:46 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/07/16 19:43, Paolo Bonzini wrote:
>>> On Tue, Jul 16, 2024 at 11:56 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> On Tue, Jul 16, 2024 at 11:06:57AM +0300, Michael Tokarev wrote:
>>>>> 16.07.2024 10:27, Akihiko Odaki wrote:
>>>>>> qemu_get_runtime_dir() returns a dynamically allocated directory path
>>>>>> that is appropriate for storing runtime files. It corresponds to "run"
>>>>>> directory in Unix.
>>>>>
>>>>> Since runtime dir is always used with a filename within, how about
>>>>>
>>>>>     char *qemu_get_runtime_path(const char *filename)
>>>>>
>>>>> which return RUNTIME_DIR/filename instead of just RUNTIME_DIR ?
>>>>
>>>> Yeah, I agree, every single caller of the function goes on to call
>>>> g_build_filename with the result. The helper should just be building
>>>> the filename itself.
>>>
>>> That would mean using variable arguments and g_build_filename_valist().
>>
>> We can't prepend an element to va_list.
> 
> You could do it in two steps, with g_build_filename(runtime_dir,
> first) followed by g_build_filename_valist(result, ap); doing these
> steps only if if first != NULL of course.

It unfortunately involves an extra effort to free the result of the 
first call of g_build_filename().

Regards,
Akihiko Odaki

