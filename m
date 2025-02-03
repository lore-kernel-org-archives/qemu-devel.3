Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A17C02195
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teyyK-00050d-8j; Mon, 03 Feb 2025 11:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1teyyE-00050O-06
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:06:46 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1teyyC-0003P1-AQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:06:45 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436341f575fso54155715e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738598801; x=1739203601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=USJc+LtCJtXYRd9HImYVRsCPsYpW8PlLO42qaPArHQA=;
 b=qTahIm5fafmfIzzHYSsvQY3stzulGOqi8mAEtaW6rC66AgPYD6bGf1vAH15ru5Eb63
 31sPHQwSuII9REhRyln5R8HQ80DZQr+aRtGE0yVyyGbWvxcUSS+yaDxC4ydkuirnz4oB
 oG+QU/N//DQd86UGh/4wJToBq+IZkIcwlyALuj7tPocy8DkoK2Ddoe8DfiR67YFT2xrq
 r0HctaTzu7rHRKtrFmPLUq6nJOPAmDBaHwU4Vm++z/jcPA1lKzPo6osPuBptWm4KRcx0
 qugFsg7ueGT3xi9eF5v/xtd/czTbBdyZIGYQ24KgZOBsc0gRPLGfvXa62R12fqTVIdYB
 BxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738598801; x=1739203601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USJc+LtCJtXYRd9HImYVRsCPsYpW8PlLO42qaPArHQA=;
 b=O2ZgHlMHqbpcTzQScIVdIeN5E7sw2HTBdSTv5g2Lw0l8ujs2t/h3e//Pg26Zk0C2J9
 x3WU53mYMi/uPXEVr7iCdxA40/zAvLOlXy97GyzySnSbvqYZsZ1RGXEIpkOHsQnXRssD
 oyy6fmI+SjIQTsF/uzNV+UDy/2qgHXF1+D5RNNDuHZgTk94tSH5J180MegcPgztHxl/F
 rZP5bQML6O18Qupf+W4nzHWsQwSlC15Cg8L7P1PIpVyPL6TPWn7vtKOE7HVzj2/Q3pjU
 JnJ3q40kQQA0aDLBGnDAVFdYRigNx1gkeXJwBhYwOdv0a88SYjPswX/OsiGRRcJOgYJ7
 VGjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX55Zv86byLP3lImPnfWD/Z7nAUspBlG6XP+eee3TfjvSuoCLd8SU7iUcl+1hwHPFuBdnHzRbBsAERC@nongnu.org
X-Gm-Message-State: AOJu0Yw+K+USqUPebm0k0IkMjksJzvgZEGdy668wiqaLNhd0cLPZN1D/
 nM7FkBD8cnNobUaD6aXdzNN3WUCnbQmOULVFTnI/2kXw02ijT5s+R9qTVnfAe2g=
X-Gm-Gg: ASbGncvirCGWpXhL+owF07M8WK/EpjShrBX6qPiKehiINJ5RmminxGeFG3i9DIngQLR
 iCoq8v2XPVkXb1N0ssSBh5MzWIi0YeOaHzQa46ZJOYPewlJbUGw60INyoE3BslFv4wRsmNmCRsP
 xtC4eb4+Z9MaBnjkXoIEvcLTOGo4Ewk7/DZQ61DjSjtThJsI73IdE2BM8fLoeUmGVsi6tsjk5zo
 HTA6ljxhaUfeLRzNO6lE/YGIzCDAc4a4MzbHRVu5Bij89nEfMQYGpNUtZ3SvJ9GCd7Z893aSXlt
 7O4xsLjaOLwhRBK2aVxVHBiNb3xWztK3DLaIUqpilbkws78n2GELi/Z+E4k=
X-Google-Smtp-Source: AGHT+IG5Qxk0YT/D5p3l2p9G0dPoznJhx1dCZobq2CjIgsJ4/FKswHONPcs99DwMxnyZh59H6zeCew==
X-Received: by 2002:a05:6000:1548:b0:38c:3f12:64be with SMTP id
 ffacd0b85a97d-38c51f8a3camr24845302f8f.35.1738598801228; 
 Mon, 03 Feb 2025 08:06:41 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1d0bbfsm13395823f8f.98.2025.02.03.08.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 08:06:40 -0800 (PST)
Message-ID: <6b3a1206-3567-4c21-854b-d3e3ba16bdbf@linaro.org>
Date: Mon, 3 Feb 2025 17:06:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk, Liviu Ionescu <ilg@livius.net>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
 <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
 <9bf6d4b0-7a89-4110-a1e1-46bbdb2fc793@linaro.org>
 <c13e207e-06a5-4f40-b319-f4f2e59d919a@redhat.com>
 <CAFEAcA_CfVfypS5yUtT3V34CDxmAqx7wYnDoKPfHq-o=54GgAg@mail.gmail.com>
 <87cyfzfl6b.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87cyfzfl6b.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 3/2/25 10:10, Alex Bennée wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Wed, 29 Jan 2025 at 06:23, Thomas Huth <thuth@redhat.com> wrote:
>>> So unless someone complains immediately with a good reason, I'm also in
>>> favor of marking it as deprecated now. If then someone complains during the
>>> deprecation period, we still can reconsider and remove the deprecation note
>>> again.
>>
>> Well, I mean the reason would be that I suspect we do still have
>> users who are using QEMU for some purposes on 32-bit arm hosts.
>> That doesn't mean they're trying to run massively complex or
>> high memory guests or that they care that our whole test suite
>> doesn't run.
>>
>> I'm not really strongly opposed to dropping 32-bit host support,
>> but I don't think a thread on qemu-devel is exactly likely to
>> get the attention of the people who might be using this
>> functionality. (You could argue that functionality without
>> representation among the developer community is fair game
>> for being dumped even if it has users, of course.)
> 
> FWIW random internet poll:
> 
>    https://mastodon.org.uk/deck/@stsquad/113905257703721811
> 
> 26% 32 bit
> 74% 64 bit
> 
> with 41 respondents.

Note that some respondents who voted to maintain 32-bit support
mixed 32-bit host with 32-bit guests.

