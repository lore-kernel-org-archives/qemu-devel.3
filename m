Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A4BC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMI3D-0003KV-Sh; Tue, 25 Jun 2024 22:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMI2i-0003Em-18
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 22:06:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMI1y-0003AS-Iz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 22:05:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-421b9068274so53406115e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 19:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719367413; x=1719972213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xCFabv2nohWkThTwXlKe6p51NtMl+EbSJxir215ZsD8=;
 b=TNlNiFaHMGV7uF/LiwHQkQaKR1+A81UaagNqhiHKAHqPo4Jf8R2gytldhoXUM537H3
 lsp+x6riRyg4LObNnCMAnu01mO4+wh6PNCt6fGPmUxT/qrszBnKyF9JevnFH9voZiqfD
 839ibimePXxpHuTYbHcrpc3xRwHQLYQsbq1nep8vbZkafDOrvz1d1B3P+SwicljlCrrA
 MHQc8lK0Ns3enIMyRB/c/Cd6TqZp0coFNymXZR+2+VnQKXydZTabzwYOPmip4n796Vgm
 YwcDhgxw+XZx8/qvrWa+acKa/DyOxo/ydZd4x994nZYMi6Lg5Phce5ssitULfkFRjQGO
 9F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719367413; x=1719972213;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xCFabv2nohWkThTwXlKe6p51NtMl+EbSJxir215ZsD8=;
 b=Gc2dN28gAU3jjdQ6DajvMO+PTzYd1/Z5wJ21qmO9GHAgqPCL1vzrODTEIsWBs1mYTp
 2K2SPa+IFq/85oJd7Wbq849++OwzsHYYhx07aR4iOz4tt03wXx7IUuWf2nFL61Smh84k
 zUttfA116iewB11EDNYhWn454U0Hw7iWDbLv+SH8C+KpgrEOPRGixrIs5zBUalzcvacg
 ouAYTvofv4zwIqmnbm08vIpP+NY8KCYut3ipFejg5XMorpUgxo7Jbahgwp482FpLNnO7
 qlNeQ7hUZN1PtrG720JlIDcNQheA+sgUzOShhrwO1REjTwKNcjiIXF29Z08LBdrM0rL1
 4r6g==
X-Gm-Message-State: AOJu0Yzr/FwBcdVsa4rLQ4qi9N1DLQsfQxtZt9pSuKSusVIOyCyuc++i
 VYJzLxr2+G8KQCpiGKjqZhUiI2Ijm7QAeQwvUMGkHVbck/+u+Ex3p8lwhWcAL9YiB0n/dYULywm
 /JH0=
X-Google-Smtp-Source: AGHT+IFZW/NLW8GfAHqDK2xt6sQX+9n5HxZ4aE3cvaweed+T4za4yMtN9jUuATR/Cm8+VOzcy9+QwA==
X-Received: by 2002:ac2:54b3:0:b0:52c:c6a0:575c with SMTP id
 2adb3069b0e04-52ce064e939mr5073330e87.33.1719340490465; 
 Tue, 25 Jun 2024 11:34:50 -0700 (PDT)
Received: from meli-email.org (adsl-73.109.242.224.tellas.gr. [109.242.224.73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366383f675esm13676151f8f.22.2024.06.25.11.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:34:50 -0700 (PDT)
Date: Tue, 25 Jun 2024 21:23:11 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [RFC PATCH v3 5/5] DO NOT MERGE: replace TYPE_PL011 with
 x-pl011-rust in arm virt machine
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <229703c7f4394691f254b02c012ee0d7dcf57afb.1718827153.git.manos.pitsidianakis@linaro.org>
 <Znrt77XOc2YBNZyM@intel.com>
In-Reply-To: <Znrt77XOc2YBNZyM@intel.com>
Message-ID: <fnfm0.vm34jtk3isk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, 25 Jun 2024 19:18, Zhao Liu <zhao1.liu@intel.com> wrote:
>Hi Manos,
>
>On Wed, Jun 19, 2024 at 11:14:02PM +0300, Manos Pitsidianakis wrote:
>> Date: Wed, 19 Jun 2024 23:14:02 +0300
>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Subject: [RFC PATCH v3 5/5] DO NOT MERGE: replace TYPE_PL011 with
>>  x-pl011-rust in arm virt machine
>> X-Mailer: git-send-email 2.44.0
>> 
>> Convenience patch for testing the rust device.
>> 
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>  hw/arm/virt.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 3c93c0c0a6..f33b58ae0d 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -912,7 +912,11 @@ static void create_uart(const VirtMachineState *vms, int uart,
>>      int irq = vms->irqmap[uart];
>>      const char compat[] = "arm,pl011\0arm,primecell";
>>      const char clocknames[] = "uartclk\0apb_pclk";
>> +#ifdef CONFIG_WITH_RUST
>> +    DeviceState *dev = qdev_new("x-pl011-rust");
>> +#else
>>      DeviceState *dev = qdev_new(TYPE_PL011);
>> +#endif
>>      SysBusDevice *s = SYS_BUS_DEVICE(dev);
>>      MachineState *ms = MACHINE(vms);
>>
>
>I realized that if we want to merge the rust pl011 device, then this
>patch or similar enablement support is necessary, otherwise, the rust
>code is only used for compilation and cannot actually be run...
>
>This is also an open for the devices that are rewrite in Rust.
>
>I think there should be an option for the user to choose whether to
>enable pl011 in C or pl011 in Rust. What do you think?
>
>Perhaps the easiest way to enable rust pl011 is to add an option for
>virt machine... But that's certainly not a long-term approach. I think
>the ideal way would be to allow rust pl011 to be specified in the
>command line via -device, but this approach would mean allowing the
>user to create pl011 and would require changes to the current buildin
>pl011's creation logic.
>
>-Zhao
>

We should definitely refer to ARM maintainers. The peculiarity of it 
being a chardev seems to make it not straightforward... I think it might 
have to become a machine property like discussed here:

https://lore.kernel.org/qemu-devel/CAFEAcA94twaBSx--NVXQcRBQ7v9TuK9iTq9kTWP4FYpRzgPbBA@mail.gmail.com/

And that'd be a bigger change not related just to Rust.


