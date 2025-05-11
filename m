Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE14C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 04:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDybc-00055E-Ox; Sun, 11 May 2025 00:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDybX-00054q-97
 for qemu-devel@nongnu.org; Sun, 11 May 2025 00:48:00 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDybV-0002pa-Kn
 for qemu-devel@nongnu.org; Sun, 11 May 2025 00:47:59 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7423fb98cb1so1575573b3a.3
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 21:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746938865; x=1747543665;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SrRtF81GH+qwnsWqM1CfEyu3ujI3f2cd1a7b3ZRta5Q=;
 b=Aq/YzP983wTnin+qn/jIoWNHW5zS6jSjXKGBD45kAD4UIc+WUQNNx7rLDltskIStyF
 5oyDDhyRWsqMOuSTYtabmh87UR7q23B1pES3KOXR40o+mlIW0Kv5jsb/5wmJzcZTau+2
 qKobS706+lL1ASNpo8l2y1BS8r2Wa6m7s0byICY2Neijt9YqSLB4cGbPeNkodswFJIEe
 wqHpGJ7K2K7u7F9WJBxsc3rEgYFBXA1ZqROI96gr23ioCM5m6ktum0gKBT+AfJjXBKUU
 XiHM2FYSjIO712P+ixxPF+Wup1rJw97Ceag5yeVWSuxFY2/2Re2gF5a/b7x8lp15DaMD
 4S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746938865; x=1747543665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SrRtF81GH+qwnsWqM1CfEyu3ujI3f2cd1a7b3ZRta5Q=;
 b=kI4FGiwkfj5YWQ6B34729pbfFFT+7xURQ/y3d43MCfpfo8ZCDmxHX68osYrYHW8ww7
 W8QZ1Ixlg6S3t3/bZyVS4CjACl5REpUVwtAJ8dpq8m3qSu7l4q3lfl/tY64Izd9mLAu2
 w0tZ4ugPgwda+MNjWzUcFjZcO8hxdfGLFXfTV41nKNR794CI6subEJ/3YJds2NQL3hn2
 Y1chFfbJ3/LMaiX3tntLkxyPFYQT59LK+Nho38b5C4Lo74b+1YCJYRXX9PRQC236eV4S
 W91aJmo9VZfUW+GDEuZSJnBYJkxqgCioAFnp2eOKQw3SPp6D/MxX3VkJcr2rtcn8rr+T
 dkVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbjM034bx2lrFmuXoPgxQ1e/RHhSypupW7serdOri1hJLVP5onaugImeVnHzrrxmSsRcUgqY+sbPap@nongnu.org
X-Gm-Message-State: AOJu0Yy7VnK/8TJ/SW9/RuCQUd4Pup+2ue60UxnXnd6e/lQrSLskcgG2
 N5ZIdBDaDY+x9tFVNhAWohJD+0C0tQA538rQnJKbH7DOjHU9L4MXyTFA7mexbPw=
X-Gm-Gg: ASbGncuPQYb6bkkh0dlM3wNpRUK8fKa/gt17+SlWrPN/rjnDzAKamDYmgml/VlwGYrq
 6IBwhMu+rnkXxGbYxMV6Y8nJbT6jKFwKRijCyYPNk8u5CAQ7V4J8/Ezt1Q+veDZm+/PfFa5HBpg
 9hU3658GCghIu0oEO2rmMLGrpWh6UJd4trDjg+dCMkBp3YxspUR66+2VZek3LBn1IPbEx8hKvKA
 pVGfWfVLNrEbUft5hJZng30PZajQVbj/+75XFbCSYXeRoUP2ECVQNc82pSXuVbwK604ke2bWXFd
 iKDvDao8gjHRBtwqOgQk5BE6tIk2aGXdMS+YLZAFY/56tF133+WW7pwFCCKgDgc6
X-Google-Smtp-Source: AGHT+IGOFC6UJsU6buYjnhgoT0/PLos+jBVFPbbBRktrvOZaJPyBBfGvddUn5CfkJfLeuw0zYftIeQ==
X-Received: by 2002:a05:6a20:72a2:b0:1f3:388b:3b4b with SMTP id
 adf61e73a8af0-215abb8f2a2mr13495228637.15.1746938865446; 
 Sat, 10 May 2025 21:47:45 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7546b48sm40933275ad.30.2025.05.10.21.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 21:47:45 -0700 (PDT)
Message-ID: <f7d65908-cd12-4c44-a80a-07e23ff27833@daynix.com>
Date: Sun, 11 May 2025 13:47:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] ui/gtk-gl-area: Remove extra draw call in refresh
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-13-alex.bennee@linaro.org>
 <d5a8cec1-f689-4d31-b6bb-b63eaa4ce2af@daynix.com>
 <d370ffec-f430-4377-80bc-323d5087834c@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <d370ffec-f430-4377-80bc-323d5087834c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
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

On 2025/05/10 21:12, Dmitry Osipenko wrote:
> On 5/10/25 07:52, Akihiko Odaki wrote:
>> On 2025/05/06 21:57, Alex Bennée wrote:
>>> From: Dongwon Kim <dongwon.kim@intel.com>
>>>
>>> This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
>>> which causes some guest display corruption when gtk-gl-area
>>> is used for GTK rendering (e.g. Wayland Compositor) possibly due to
>>> simulataneous accesses on the guest frame buffer by host compositor
>>> and the guest.
>>
>> Simply reverting the part of the commit may re-introduce the problem the
>> commit tried to solve, which will be a regression as the commit is
>> already included in releases.
>>
>> I guess the problem is that the gl_block callback of GraphicHwOps is not
>> properly implemented and it is what should be fixed.
> 
> The reverted commit made QEMU GTK GUI unusable under Wayland. It was
> fixing problem which requires very specific QEMU setup, while breaking
> generic setups. The offending change should be reverted as it introduced
> a bigger problem. A proper solution should be found, meanwhile QEMU GTK
> under Wayland should be restored, IMO.
> 
> For the reference see [1]. First bug reports about a mirrored display
> problem were made to me on IRC a year ago and the root of the problem
> was identified only couple months ago.
> 
> [1]
> https://lore.kernel.org/qemu-devel/5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com/

That describes the context well. It should also be described with an 
inline comment so that we will not lose track of the known problem.

> 
> As of today, the GTK problem isn't understood.
> 

If your guess about simultaneous accesses on the guest frame buffer is 
correct, it's a bug of the emulated device, not GTK.

Regards,
Akihiko Odaki

