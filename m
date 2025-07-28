Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A50C87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 09:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKUZ-0007iq-Gw; Mon, 28 Jul 2025 05:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKSg-0006Is-DL
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:48:13 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKSe-0005m1-Fn
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:48:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b7746135acso1873499f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753696078; x=1754300878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5kn0p6fHAoUUY+jp3ODMgBVDpgTfGx9LvXC+uPKBG/w=;
 b=Lajkx6kYJwVkNCGC5kVSxGDC7OhbjgQzu5ReoX2MUVfEEtgwY9r4lTQN5CX9Nx/iZ6
 2Zi+pZqhODpzx+7yWRDGEY9XF1fpmcmhpDjcstk2qPCSOxBvDc8OguI36hBZzZi1dyAg
 4ok0iWiYefrjTOCBrO+GLfkOTeif8XHWLD65bxXRgGAoVk8IMDo2m4z76mF5ZXU2zwkr
 kA9AQL0HenZ9BRl5okFOFpWcpmltsLR/RhD7iKhThQ8zCbQEGwgGSFr2xjjNLAnkF3t0
 /+cLbPR1Ms2AJBgymLRxF/hsNImoFwsVDmqCAbD3GqEI6JHs66ACdKiuoLQkCItRKkpq
 r6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753696078; x=1754300878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5kn0p6fHAoUUY+jp3ODMgBVDpgTfGx9LvXC+uPKBG/w=;
 b=Dyu8UGD0zbLcrCp/49BIKatfvSw/c4PLo/8YQuKK1BpZCPO0IJfyKPeNw+hZO1/HPa
 05hhAk8upNVLcgalaXNqxqwTc6w4qSqpeSimM91QaJqB2356vX/06iML/HuMPOvZa140
 OlbXen7lDgloiNCA4V+V6U+IO5bJFUMxk1Am6y966rqIE/7LbmFZmeHK3wAsAHFlOUKm
 bFHXDFfcu/XnZASGdWJZfoWfgTpUjE9Az7VFFMgrBqLxY8fzZ7UDIY0bEZn/LQaIyL+8
 qazfFO426y+GdwE1dWvmDUJ9vqnqHxj/Bo87ZIev5pgMgGP5YgjrKHcvf8PP4aO8CSGO
 4W3w==
X-Gm-Message-State: AOJu0YyHKkE9jGx/eovlk61z0E511SHwaCb66iebF5teJHT1shROwS5P
 e0mH9E9MK+8bDgqKyBDmQBOJrdx7WAYHZmADusoKakXTOyWL1GEtKK9ouhf2n1Povn4=
X-Gm-Gg: ASbGncsMB2ejBCehzo7VnGc1D2FowIjgcFYERDAaW3+Ntzo3yCRtgvC9F6Cnps07enA
 0IyfqS2h+gcz/K3HNWi+68FiqkGlmdxkyJUjBPuBEj1KDdTaoJ2+KDqJgi3avEiFcKCgYHvFFrr
 8AUrRbOO6xBq7058u+X3S8SU8k2CiNXfv5s4P8AhoD72t9B3eFjzi1i+F59vzn0BYmF2CiSspuM
 ihw1lQvbuR4fe7Oflj5DMyztm7gIU2LOxI50TcDMU6ZIrJ0Kvc8WTuMctmKjJgrdT6EPOLQEk09
 gLwGDIwWa7S01ndyK5XUOiIwYnXep0+XPGdFTTwPmk7yxmsWA0/SCQmqcx5aWWWealqB4QaxLKl
 aAgEp76UOZCeX+bsL7qzzi1sYJCXJzXTsYLeJ5GLe83L705qco+bxhzvYg+D79i0db9NfMPT+sd
 Fg
X-Google-Smtp-Source: AGHT+IFNoUtDVRpm2cEIkelSfzMQfDCRR1DPE0GglI5QVnYnvMSs/qK7Wj9pAzwj2O2xp76FhjuNpg==
X-Received: by 2002:a05:6000:4383:b0:3b7:635d:b119 with SMTP id
 ffacd0b85a97d-3b776671512mr8895952f8f.46.1753696077658; 
 Mon, 28 Jul 2025 02:47:57 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm149721385e9.29.2025.07.28.02.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 02:47:57 -0700 (PDT)
Message-ID: <44ca54d5-1292-4388-9436-dca2b6e7e97f@linaro.org>
Date: Mon, 28 Jul 2025 11:47:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yvugenfi@redhat.com>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250717145948.77870-1-kkostiuk@redhat.com>
 <87pldwbspt.fsf@pond.sub.org>
 <CAPMcbCp=PBMSxtTxCMkxigdovaY=MTNLRo6f3BBXNRT6vu4wmw@mail.gmail.com>
 <87seipkif5.fsf@pond.sub.org>
 <CAPMcbCrTTkr5sX11wn1WaXOLgqQTAD-1oxUuqOc+oEmUxcotkw@mail.gmail.com>
 <c3afe3f5-962d-40ba-a778-716ef9929053@linaro.org>
 <CAPMcbCp5BuLADQoDijw811G4-u-ssBJ+eFrzyiU8_G9Tr7uLHA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAPMcbCp5BuLADQoDijw811G4-u-ssBJ+eFrzyiU8_G9Tr7uLHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 25/7/25 11:59, Kostiantyn Kostiuk wrote:
> Issue reported to GLib https://gitlab.gnome.org/GNOME/glib/-/issues/3740 
> <https://gitlab.gnome.org/GNOME/glib/-/issues/3740>
> PR with fix https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4716 
> <https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4716>

Even already merged, thank you!


