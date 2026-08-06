Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9520BC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrvRW-0000yZ-12; Thu, 06 Aug 2026 06:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wrvRT-0000yD-Pl
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 06:35:15 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wrvRS-0005Ri-8h
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 06:35:15 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso1622395a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786012513; x=1786617313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gtKP719rwK5KbQt+8ScyZYMObMExUwEW6KeRKtBSm8c=;
 b=Hb5sCnuywjxmCUspGv8EIjKJpnfxhDyt1vv+Lm//LsOiIzb3tA639VdmOeGvcUe5F4
 RxgYijsh+LKfSH++nmlOaXfiuLKjuDKv7Q5OtV9lUHgelCTach4kiwmC7PhidoSbdoPO
 XD6wHD5ZJZB/ia43ATX5yle2DrFudDBFGHRa0eTwQosT2tRkhrvuSA8IAig4YnUAIgzj
 zd1xC2G2+mSdopQIVy+7EY5Cao4TLQ+Gzssvl7GIVl71rMS34DpOf/YXCp/PeSr01jCc
 6omXnrqpG4TdTlOTFTXGvSZvWwrEtoL4dfyU0IXjWketiSiVfFGPcuQbnEATgh1ta4PT
 qpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786012513; x=1786617313;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gtKP719rwK5KbQt+8ScyZYMObMExUwEW6KeRKtBSm8c=;
 b=pDKsK+ME6WXZLVanBDa+GIe2YVyDYidbV96h6Ejx0yDVExzywHwDOTbF/ee+S1xjub
 3/CnLEiyIPVhM95hlL36QXeD0oWR7qnPLPxNRC9FY1fejXYBsfngZgWIPgIaXn4GI70m
 30prjdABisa3ZYFnzdLSRh/yuLdrORps19NW7hWE2mEpvV84DLqw1P4WtiF6j+DEWyb8
 bSUzd+maDGsOJuPn27aJ1VZYsTYepuxBZXfWw5rpFSLUMZb6y3MWGosWHVEIt0ZOSr0O
 FkxzwLdyY4GxMdN0LrcERrUWj/CfAiYCiGxeNlSS1too3FcnFyLK2kji+n18m8FffUwr
 2GDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpR0I46jonFdMJcQ/3Vij4eKPVY/x2ZV3P8hfyTaGktGDly0vnliDRh9uhYGTCGhaS6eN9cNjQPDTQo@nongnu.org
X-Gm-Message-State: AOJu0YyzVUHxKMu6cb1SyxebYnmQYjH28lXxuCvF89CYstdz3KZ1qNGB
 YJg9IEcynknpRej8FxyRev2Bm0STGLqvkUMnQgarSX+Yx7WHZQZb+zjZ
X-Gm-Gg: AR+sD11u2x/uRhrChWSC+0xrSaxukHy0AIft+HJRoe5xceQfiF2ZoEVL4aNX05XtZIE
 g9gS5QI6o7DzpjJqnYSBdEbPjhv13KqMHF6/VpZSUOJHUOrnxT+OAsayVDfEsx2Zyo0pDJhGl4d
 XfKzl1UQ7QTCgdIV+MKyMg9Iur/3LoUam+XgIcfpa62kz/F9q7fBBhKgUpNYhAeszROTrNana08
 tj2BiXDo3YwUwn3/6gn3Df/YTpxnvP9hlN2zpJD1dm+kGLWj5R3dUiF0rT3Wk07eAKdXHkDL33d
 kx0weGrwrCQA+Sd+Uq2Aoe+Oa8jArqW/+9935GGBFiZQsaJivzJdrVpuxzEKOFrUDA+hsDkl0eF
 QXqHmJnfCNOmXkETizO1KxKMzBH8PfT/n+WPxKn1pfFW5O/GAZcmfLVm9t+YEVAVRRiWjkag7Vo
 4bSB3qigjroixol68CdZWuw0iwH3bYTPGEdEQe5qlErZrUHR49r0EB0Zd3z5pVXNemGbdDwSsJR
 Ga5qrRYYKPuZaHdE+GYZgWpwA==
X-Received: by 2002:a05:6a00:1f12:b0:848:4f04:87ed with SMTP id
 d2e1a72fcca58-84f2e0e1b58mr16420033b3a.34.1786012512765; 
 Thu, 06 Aug 2026 03:35:12 -0700 (PDT)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp. [133.11.54.183])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f454ccb18sm1117144b3a.25.2026.08.06.03.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 03:35:12 -0700 (PDT)
Message-ID: <7193c699-93ed-4c57-b7a7-7084a7e29294@gmail.com>
Date: Thu, 6 Aug 2026 19:35:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] runstate: set crash_occurred on guest crashloaded
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: philmd@qualcomm.com, pbonzini@redhat.com, viktor.prutyanov@phystech.edu
References: <178600606177.41696.3160576684819885412@linux.alibaba.com>
 <178600606177.41696.1952897016467970943@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <178600606177.41696.1952897016467970943@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/08/06 17:47, Zhengrong Li wrote:
> Windows pvpanic driver writes PVPANIC_CRASH_LOADED (bit 1) on
> bugcheck, not PVPANIC_PANICKED (bit 0). As a result,
> qemu_system_guest_panicked() is never called and crash_occurred
> stays false for Windows guests.

Windows emits CRASH_LOADED when crash dumping is enabled, but emits 
PANICKED when no dump is available:
https://github.com/virtio-win/kvm-guest-drivers-windows/blob/abb444cab4ea2284e844e78c0efe76355936a741/pvpanic/pvpanic/bugcheck.c#L41

Therefore, “qemu_system_guest_panicked() is never called” is too 
categorical.

Regards,
Akihiko Odaki

> 
> Set crash_occurred in qemu_system_guest_crashloaded() as well,
> so the faulting CPU can be identified in the guest dump.
> 
> Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>
> ---
>   system/runstate.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/system/runstate.c b/system/runstate.c
> index 08acf801b0..c7961cc1df 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -724,6 +724,11 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>   void qemu_system_guest_crashloaded(GuestPanicInformation *info)
>   {
>       qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
> +
> +    if (current_cpu) {
> +        current_cpu->crash_occurred = true;
> +    }
> +
>       qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN, info);
>       qapi_free_GuestPanicInformation(info);
>   }


