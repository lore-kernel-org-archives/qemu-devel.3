Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3268D65C60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 15:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVtBh-0002XI-5x; Wed, 17 Dec 2025 10:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVtBe-0002Wx-RT
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:11:34 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVtBb-0007ro-Ug
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:11:33 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42f9ece6387so2324016f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 07:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765984290; x=1766589090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zJyG32dsVPXCb+tI4oYwCRk+vs62OPQZGNDYxRdaVsg=;
 b=sJdT1Bv7echORNLAPIoz6Y35Ywc+4jUAMJCExHCgghWHeLGNAFCi590V2EPBAgMgPe
 i19sOwTp9lHVhRJKFEmae0RwfBQO7smafPRM0ZtJxZGCAMDDuCsseP5el6b2ylb5HO7P
 YIiSt0aZjdUpm9yOFtw0+z1Qzdv3B2HHh59F6uAEqdWsD3WPbKQYfUHmOAVgSjjFMRD4
 psh1OMe3Pmg2/ISLnaI7R9XkB1H4moYi5SHA81Y124voSHadOoKhLWOoUZESllE4COlE
 p8VNyid+OjQI/+gN6Jf+G8jmtog8TXbKjxIoAAGfOtppjU2EWPISHdDijBMA8OAxc5Gf
 nPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765984290; x=1766589090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJyG32dsVPXCb+tI4oYwCRk+vs62OPQZGNDYxRdaVsg=;
 b=lmDxQQbfIHh4beedfx8wxPBjhwTnq7g9zJwlkymsPvogGpvhhY413U67LSIfffNF3Z
 1OuKll733pZgmP6wTQyPtRivXz9aFDX/6WgUjXB2DcBKrx20Zxawml5bDQLhPbN6T1tU
 nex0tDQa5MqUpG54qnmNNSiAA3cY3WJG8Mx6vumJdxLlMNUmACCKC4Fq/w5REIpzrU9G
 E1w+YbjrCHmh3Eacy0FdoDTTQc4wxRT88ITcgJBO1u0/ApaaJ8Zs2bEcx6H8LBnG4l2l
 HzO5mbBe8VGDe1xo4XArmu8228L8JedO0VXKk/lU96kzXkxe9Xm/abfOhwKEQSGBpl/H
 OIjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTBiarlFm5uQ1BzmZE4j65eKitNM4QqfscyEHWOqwR5PahDQNHDoIJSyVHnIKPoxJbiPN5koOcC28a@nongnu.org
X-Gm-Message-State: AOJu0YyMczIuf5t46rvQY84R0K5Jxzq/lBIs+PMMcRAhggxH0DUvKa3H
 blIKj08N2UlYPjkCrBSYr+WUlMKHEBUFUdzJFFj+yTkshXSTzyiXPKFjl5Lb+StLQB0=
X-Gm-Gg: AY/fxX4M+ED6y5A3R1qFmt5RMkBHbMrm9f5hJgugvIHaKO1EDUS0u48XKH7vM1iG5sy
 Bg1kcWohHKXrnM/3/ihvdrIeeWeXEhHLY6QujKCIQCDnE4GdEth+52ljBGgXqbl8XM3RqF2Gxhj
 Mf3jAxtdWiOgEw+0lL4c9OfFY7Po98SKum9WuWpp7W87NJJLtKwMOo1FhP5WhTge+Arv4ZZ9LEC
 V3EoW5uYhiuQLEwn1cUy7o+F25TdvcA8ZWnqHbXrDdgleRomkT9rpHaaVU8fSemBJCsZxtpgqTG
 oMWuwcA/eLOpBsYefrN/gI/Pqy6c70+hbekNCzj73xcD34aeXWqOymgycUFXQkzx5KHEQVmECtl
 WL3e7ZdUj6jaF29ntGVe1eFteq09XrdgyKKDRY98ftcimn09/i8IhxKv23xZcikjV2JA6809H5d
 GpYLSvcf4K2Hc+Yt7b5kjJK/v9TgHYE1u9SWhPx5QVp0LadLDdSXRQrg==
X-Google-Smtp-Source: AGHT+IFzsPjBOdgcLApBxK9Euxjh8ckwqCpD0RzGMQ+CrJtOo3wu1C4t/nZ/p06mLDDL72Qsm5r6Lw==
X-Received: by 2002:a5d:5f54:0:b0:42f:8816:c01a with SMTP id
 ffacd0b85a97d-42fb48e7728mr21390769f8f.62.1765984289932; 
 Wed, 17 Dec 2025 07:11:29 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310ade81absm5151999f8f.21.2025.12.17.07.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 07:11:29 -0800 (PST)
Message-ID: <c647a8b8-fcec-4b09-939e-6620ec0e5815@linaro.org>
Date: Wed, 17 Dec 2025 16:11:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] target/riscv: Make pmu.h target-agnostic
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-11-d24a4048d3aa@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-11-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 17/12/25 00:51, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/pmu.h | 2 +-
>   target/riscv/pmu.c | 8 +++++---
>   2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


