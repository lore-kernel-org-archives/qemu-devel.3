Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED14C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIVP-0004Fe-J1; Mon, 01 Jul 2024 10:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIVM-00045Y-Hx
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIVH-0005Td-Sx
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4256f102e89so21247965e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719845978; x=1720450778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M50FB3NLEFti9qLfiHvrL21QsVqbQ33it1JlOscvyhk=;
 b=MMIB04tiUWWJHeQYxeFFeFegRc/nFosyyuFd3A3vxZ0ttM49bxFrpufB+aTruYne9T
 c//W8/NYpkKqQ0FSGP+Ku6MPTYLE85SlD55Lk4odCQOBldbsACvP/+bO6Htc7RqufH3I
 PRdxBHMWp4RfwzvAMiBvxJKB0Hb5lGvSQW77bFcMKz9TH91CANoGbgmnacwVcY4qk84T
 Yjng0WU/mJb/EO6dIZ370AjlN2223q1coM+H45dKttX/XsxSSCaWLHPl1Bj//HrY6web
 VFg4cJKN1kvR2oFVAzLFeGXi9O/MiTeyQ6Fgf/2DQfE0cMe4GmY0gzbsUrw/G74Ovc1F
 ObRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845978; x=1720450778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M50FB3NLEFti9qLfiHvrL21QsVqbQ33it1JlOscvyhk=;
 b=idu5E5wBAj1qwBIJVPbjyd48oaLZ19meeoWA7JJH1A4zbjMxeMWgpvbHX8S9JMxmTR
 buDXzkY8upV6AgMmnXdLsJ9GRuJsw6RilNznWxLeT9LCjVBpcfPHNuLr3DLkR6kTxlvQ
 TmJ0O26Ve0C7TxI0ryDSugzQ05+YwRzOZkPemYZt9Ju/87simLaXry6UxeYCFDBVcOb9
 qJe1jsZkOtZpBcH5uPIfAAh+plklM4x+HHnFBFfig6eS7zgVgmQpWm81Gb9Jn1ndKIq/
 sOsT9/2cmLXBoEyc+OGE2ob0t4FMNsf2nnZolDkec8bPPJG54SWNLY8x4QIrjMNuW2n7
 ZP1g==
X-Gm-Message-State: AOJu0YyHfAYOoJi4H5BrH6eYfvmbhwbtlep49ryUGbs2hlNV/ZdDCn3z
 LHteK/zAPxJlIQxUNvzexeAIvfNewA+Ffv1dLhMBnOIzbae7xkJOiYpdqTS7nEc=
X-Google-Smtp-Source: AGHT+IHX60a4qR7ntMLnsy2W148ViUVqv5eBdnjy/PMHWg+CDvtsTUCOFCIC0z6Cuycxd0YjZ26V0A==
X-Received: by 2002:a5d:5702:0:b0:35f:1c34:adfc with SMTP id
 ffacd0b85a97d-36775729a52mr3318587f8f.67.1719845978095; 
 Mon, 01 Jul 2024 07:59:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1046f2sm10202397f8f.112.2024.07.01.07.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 07:59:37 -0700 (PDT)
Message-ID: <3b1d88c7-6d9b-48f4-b887-06f0c401285e@linaro.org>
Date: Mon, 1 Jul 2024 16:59:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Fix reference to dump-guest-core
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240628-dump-v1-1-c581d10f3646@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240628-dump-v1-1-c581d10f3646@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 28/6/24 06:05, Akihiko Odaki wrote:
> dump_guest_core is exposed as dump-guest-core with QOM.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   system/physmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued.


