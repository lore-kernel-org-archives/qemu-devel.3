Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE79C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 16:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVCbt-0000o0-GG; Sat, 20 Jul 2024 12:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sVCbr-0000mt-Fi
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 12:06:59 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sVCbp-0007XE-Mz
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 12:06:59 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70af0684c2bso1299599b3a.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721491616; x=1722096416;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bk8iSvFX9ZWiZWGI3qfTWaFiYglfod65GFFQilcEzaU=;
 b=sStt/XdVxI/N2qT822aGmSgrirZzlINO56EljDXtCaODPk66zzHZjD/VTXzAF0/eUv
 wevIpsWT+RP7QqXd+Vuv6b0YiMwmF6VRMlHqg36B53DBgKvE4u4PIApFlVy9KzGSLlv+
 3PW8gpE9mnF0LTvypOrQy7WtZwlDLA8X/EQVqGI2AJuBbzSHvfyblu5XGCrdA+ueLZsY
 Rimaq2FfoJWcOJ/mUHhOZjlruoKrIT/gddybH43CqrGSBbHCXZIK8BoOpP2qGoVY9CwN
 dNphs8QsjKArolngER1TZtLXF43HhHqs0aHlme30206vFfmMvRCuL1oxkT7aVPDKPMZH
 yKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721491616; x=1722096416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bk8iSvFX9ZWiZWGI3qfTWaFiYglfod65GFFQilcEzaU=;
 b=VqoS1Z7idxOiZinamJaFELFOupiAP1ums6Lh0XRaoR14N7slsH9UTxzRrRAuVYqQ2z
 0hJMpVYZnzk0bBJUvC1k4BuDxh19x4znMsLe2bqZbe0pxieP8pkwU2Qbizs4XjpgGdXO
 IrThtc8/rHbAy7GnDKks/ahL/k+4zOzXKdWkh5FeEHxBPcvX1bGMVLRDaqYXuDyyM0PK
 XxMoWnax1t+kM7i6pdMPkbqOdUtzLsl37EyWW6Gn+tbujh62an7dyR05uGANvRtwPsfM
 yhlhQ4qUdwUcTlR4UcN2iOX7XP6qkHAq7lZqNlo7rAoBj/zRORymmRDqzlUqG9R/FUlQ
 aORg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXab46Bqj199iRJPLyWSa+xJu20yz0zTqLVbZbL7ZxwYBldGxRzKKbC6Al1gwR5LY6i64nf6S7SZPAoRr0n2FmBIIIAs5o=
X-Gm-Message-State: AOJu0YxfIVPPaYY9cAqG8NKsfEkcUYE4n5/X7sUJ+6oOaBhwQy8GSFl1
 qpKH+izwUlsxbpYfLTaGRIecv+y4ELny7nSyqgVn+/+HbjFycbRxPUYOo5ck3y8=
X-Google-Smtp-Source: AGHT+IHWL9eXsrCz1K7/XI+nWeTodf0BgGwmoHEhim7wFzeRojUMxlzKE/1D0Krlo95ASTZCRYiF+w==
X-Received: by 2002:a05:6a20:4304:b0:1c2:956a:a930 with SMTP id
 adf61e73a8af0-1c4228963b8mr3355862637.17.1721491616138; 
 Sat, 20 Jul 2024 09:06:56 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf7c723c6sm3734877a91.25.2024.07.20.09.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 09:06:55 -0700 (PDT)
Message-ID: <c23f4e58-00b2-421a-8248-c5937c06d196@daynix.com>
Date: Sun, 21 Jul 2024 01:06:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] hw/display/apple-gfx: New macOS PV Graphics device
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: agraf@csgraf.de, berrange@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, thuth@redhat.com
References: <20240717110326.45230-1-phil@philjordan.eu>
 <7c545db7-1899-49a9-82ba-967f9e0a9000@daynix.com>
 <CAAibmn2NuXWkqVVR6-gZLGr6dNRY3YmR5AQ3v9i8pifOkdL_BA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn2NuXWkqVVR6-gZLGr6dNRY3YmR5AQ3v9i8pifOkdL_BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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

On 2024/07/21 0:16, Phil Dennis-Jordan wrote:
> 
> 
> On Sat 20. Jul 2024 at 16:42, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
> 
>      > It also became clear in out-of-band communication that Alexander
>     would
>      > probably not end up having the time to see the patch through to
>     inclusion,
>      > and was happy for me to start making changes and to integrate my
>     PCI code.
> 
>     I think you also need to take over the base vmapple change because PVG
>     cannot be tested without it; Only macOS can use PVG, and macOS requires
>     vmapple in my understanding.
> 
> 
> The PCI device variant works fine with x86-64 macOS as the guest system. 
> (Or technically any UEFI based guest as the bootrom comes with a UEFI 
> frame buffer driver; it just won’t have any acceleration features unless 
> you boot macOS.)

I tried apple-gfx-pci with AArch64 and x86-64 EDK firmware on M2 MacBook 
Air, but it didn't work. I guess the bootrom does not work with Apple 
Silicon.

> 
> If preferable I can leave out the vmapple/MMIO device variant (the 
> -vmapple.m file) until the rest of the vmapple machine type 
> modifications are ready. There still appears to be some kind of 
> interrupt delivery issue with some devices on vmapple, so USB HID events 
> are very slow. Or I can submit it as is if that’s not a dealbreaker.

The vmapple variant should be omitted for now. It is fine for me to 
submit the vmapple variant with the other vmapple changes as long as 
that behavior is documented.

> (How do I handle Alex’ unmodified patches though, as git send-email 
> tries to send them from the patch author’s email address, which means 
> the email rapidly gets shot down by DKIM mismatch or whatever?)

I think you can set sendemail.from configuration or specify --from option.

Regards,
Akihiko Odaki

