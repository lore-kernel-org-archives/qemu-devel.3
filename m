Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56410D609A8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 07:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGC8z-0003HG-EU; Wed, 27 Nov 2024 02:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tGC8x-0003H7-7H
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 02:07:23 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tGC8v-0006pp-Ci
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 02:07:22 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7251ce598adso1401814b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 23:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732691240; x=1733296040;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rhFqRXVkmeLfYzjLIl7KHgrAL3L2SlSZNpbKMyKYojI=;
 b=vhzFgtogEP7G55v5VYcgfO10g3KFQliiARHhm4W68/hP+q0+zlNTArSQiw2hWcfFJb
 zDLJsjY823Ggqc21KBtgWrXQcklEx5mZL0+SL7B/NKESfxJB+mDf0A6iFI22B8/RHUUu
 DyU9P7k1/0gtOUrEgWDZQeDMfliCWKhupSAUOWusYYUEvtO+b0ZE8jJXtBEPERBQUr/C
 BOiu39V01oApVxrh2oqt0dETGxu1pA5sJHGt3Z9PXk408fSKmiNdA3plXTMkP9uMY3ck
 UoOX3SLuB6bUD7vrodACl5T3wLpDBdkFYFptRqkpKXEoN4btZjkw10Tln/zCGDDLYmOz
 9y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732691240; x=1733296040;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rhFqRXVkmeLfYzjLIl7KHgrAL3L2SlSZNpbKMyKYojI=;
 b=b2hd+QFE+nmsgr05tOeh9YlMIWRwAPfhBoVWiC1hKNPEzMDlYTogq7aXIPxwILCK4w
 CrCAijBiDvtcKqghul0p7vVzYt1E9SONNrgBCWthcoKLtWSAu1/l2qZ3qhR73xge5MoY
 GZ8ZA4TQCXfpTPOFWKWfmQJI/+f2Lr09jUhH36dkdb4+nBw7XGaD3Q6ikIQKHV586db6
 D3fyNkTPRoeLuArXkbKkFj0qjcQQ8vjgw6H1UYcbtfcaLYDug5IwlFnm3OGtcsuDyPc3
 NzlGNKsLvuzRgvRTogOe0wWOWNzftcWFHFZVQgyzNeJuZCC2TFW3hFfU8bJFbOF/cxtS
 X/Ig==
X-Gm-Message-State: AOJu0Yzhp5edjy95QfZ04qTpQYLHm5i0MxstxqV16t7zaMkt5G7ugCbp
 gRnPIhuQpNfz8c7fhRiDOMSyMU57vXqqLUe49rc+58sBc+rZjgXirFPtJx6x30E=
X-Gm-Gg: ASbGnctehoGpNYB87xQsHK95SDpJZQ1q3dHvzPi4AWPf23qK2pFS41XGYuZ6Fvi6FOV
 wLt085dqcwxB64dVx6VIF1fkEo0HftWvhVW3I1uMRZPKBfHjKTkHSTxzNmTp6kiJPtsKiNMAH5K
 mmH9PMkheiG89dtpsl1sgNqg+adw5IhDDQVfFH4s0ceMIiUntICvNDezwya3KA7DfJb+xnDZa8Q
 9FYg1O4WMvlnxqLTuLUCK+h2jjHSEYXjHWABOij9hOdoil/QqLqsbtOZ6DHBaM=
X-Google-Smtp-Source: AGHT+IHMFMBgRb80y5HZFfv3qJZHHStqXxFXIv1BG951YRjxhllJcSkG5ep87/drlrnbip/MAev73Q==
X-Received: by 2002:a05:6a00:138c:b0:71e:41b3:a56b with SMTP id
 d2e1a72fcca58-7253015633bmr2913288b3a.24.1732691239883; 
 Tue, 26 Nov 2024 23:07:19 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de532da6sm9833616b3a.105.2024.11.26.23.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 23:07:19 -0800 (PST)
Message-ID: <0082edc1-e296-48d5-a44d-7a6531dfe211@daynix.com>
Date: Wed, 27 Nov 2024 16:07:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2] ui/cocoa: Temporarily ignore annoying deprecated
 declaration warnings
To: Phil Dennis-Jordan <lists@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20241121131954.98949-1-philmd@linaro.org>
 <CAGCz3vtkJS0Fgx_+1qJbUkYAxJ3WPvhEBxJ7P4T1a-g34KV1RA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAGCz3vtkJS0Fgx_+1qJbUkYAxJ3WPvhEBxJ7P4T1a-g34KV1RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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

On 2024/11/21 23:35, Phil Dennis-Jordan wrote:
> As we're talking about macOS-only code I'd perhaps have used '#pragma 
> clang diagnostic' rather than the GCC versions, but clang seems to 
> understand these just fine too. (Plus, we very much intend for these to 
> be genuinely temporary.)
> 
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu 
> <mailto:phil@philjordan.eu>>
> Tested-by: Phil Dennis-Jordan <phil@philjordan.eu 
> <mailto:phil@philjordan.eu>>
> 
> I'll try to find some spare cycles to come up with a clean solution to 
> the deprecation issue towards the end of the year. I need to research 
> the available alternative APIs for another project anyway.
> 
> I think part of the reason for the deprecation is that most modern Macs 
> (as with other modern laptop and desktop computers) actually use a 
> variable display frame rate, so the concept of a "native" frame rate is 
> no longer well-defined. In an ideal world the frame rate would be 
> something that's negotiable between the host UI and the virtual hardware.
> 
> For example, the macOS PV Graphics I've been working on integrating 
> would actually prefer a "push" arrangement where the guest/PV hardware 
> notify the host when the next frame is ready, rather than expecting a 
> fixed-rate frame refresh interrupt or similar. So when using that there 
> would actually not be any need for the display-linked timer at all if 
> the UI is happy with the hw calling dpy_gfx_update_full()/ 
> graphic_hw_update_done() proactively whenever it has a new frame 
> available. I'm not sure what the story is for other display adapters in 
> QEMU, but I can do a survey of that.

Regarding dpy_gfx_update_full()/graphic_hw_update_done(), it's probably 
better to stay the "pull" semantics. With the pull semantics, we can 
drop frames when the UI cannot update the output in timely manner 
because it's in the power-saving mode or it's just too busy. Adapting to 
variable refresh rate will be achieved by using a platform's mechanism 
that fires a refresh event at proper timing.

There is also another function we need to care: dpy_set_ui_info(). This 
function updates the "mode" of the emulated display to tell the refresh 
rate to the guest. A mode is expected to be somewhat stable so it cannot 
properly represent the variable refresh rate. A safe option is to expose 
the maximum refresh rate via the mode.

