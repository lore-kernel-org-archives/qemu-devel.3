Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EDEE65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmg39-0008BD-5d; Sun, 01 Feb 2026 17:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmg37-0008AD-VR
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:36:09 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmg36-00017H-Eq
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:36:09 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso32121185e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 14:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769985367; x=1770590167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sZCyTFYJKZANSahEQCJ/7qHpG+80EEP4gqA8iJAJZ1c=;
 b=SaICWB00Pa1xEwYvK5klcNiHy4fUVXKeQCsAaKqHhC3nztLFtM/2K8jlVUC9pKZi+3
 4tuRrEVjY95X93TQr2gUulUxLKRgcn34Wk2zNGta7BmARWwT+y2xlCx+X0HTUcfimN4D
 OWDG+haB56feVi2S3Y10cv8JQtRnGZB6acNZtBZSWkVfaYEAD+PMwqzpaOomQDiNJ+aD
 Dqj6zVb2CHm8acQo1J6jaXoAG6kNWUkZdooDpvoDoKvaO9WfsyDINxeQen9ePKVnE7TX
 U+IivgfPZ5DeScBzu0CG7MocyFknPSCBXj/ZZWB2ghd6pXswcnO0gOpj2Cofyl2GgeB2
 +UFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769985367; x=1770590167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sZCyTFYJKZANSahEQCJ/7qHpG+80EEP4gqA8iJAJZ1c=;
 b=s+gjzrTf5cB8lAxR0xCjCeELVYQmICcDN6l4UTurdat1jFfu0Cmb5UlFGNqZqrA2ku
 GJPNHAJ5OYkgIn/PT9e6vJ+nLgnHaGF4toLcFDv+eXwHz7CxYkzmgSel4P1wPzr5YacC
 D6ac9fcIMWG25MOX/XYayQ1kR0pgIA6HpQAecz8N+h1ff5jYv5IjF5R4KTiU26TEDQ+b
 mar2elojeX1vjNjHuhgZ6OxlL/A6hJaTZ2OJXoWE9GV4vcz4xaWfUycIAn6su+21TSmy
 /dX0p5RNpBbyyhouZHyaKn0ocZa1nGgSe5eGL4FY7zhaTKcBwnG51BDtMjYlcFumz8/Y
 dszA==
X-Gm-Message-State: AOJu0YyiYspyUjkeUNyoWBXeD2wtECig5iafWhxPo7CtIUuSeMxmcAgQ
 GNEVIfq0cuOJsdvua48bHG0NgmESmkARG219oiwEngrv54061sAlt1qhKWcXIhWz3zU=
X-Gm-Gg: AZuq6aKwKykkt5p6ZKDr2I8z7OvpE+ttZ024hC1qvoAJ/VJ8en0yBcIhSw16h/33lsC
 bs32HeEtVFzZaxrBPwJQAScWeRwDFBr1WVMJ7FTDNHdfzKQD1X31dEQSKuwnLEO0LkBBfvlf+q8
 fPg4sanhQFUnm+rsu9kczBbXQMdf6mlwdhLqFozY38qN9zGNhptERzaAiIuuI+b+ucOaPorYlYp
 GXGpYkOxAhQN1deWsSzDhqdK32gahTdIS9hWq2fsIkGPkroK8NNIZzfEyDymWLBgm4bWQ8FWSAM
 wGNByb5X2VlAe6yyx+5BVX+XyZgnlHxuaSU40nFb3npUnbESubqfZxRDZObgEm5iXlmosefk/OE
 nWlD96ksadUbF8DSv9ikOdycLG75vsy++Fc0kGyDWu1wL3orhVCxJ8P2DPnvdVcoAdsZsbPLr2s
 Ju/8S4XZNiVyJuNY/NPJ7xAiq2RES6sKdbkuI0CvqtNwvNgEpnDiK5WA==
X-Received: by 2002:a05:600c:474f:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-482db452587mr123358635e9.9.1769985366800; 
 Sun, 01 Feb 2026 14:36:06 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbd3953esm92250955e9.4.2026.02.01.14.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 14:36:06 -0800 (PST)
Message-ID: <299f59f7-62c3-42f4-99c4-b7c7cfb111c2@linaro.org>
Date: Sun, 1 Feb 2026 23:36:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
 <20260131124842-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260131124842-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 31/1/26 18:48, Michael S. Tsirkin wrote:
> On Fri, Jan 30, 2026 at 06:00:56PM -0800, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Performance impact?
> 
> the reason we have these is for performance ...

If this is a worry, we can declare the virtio LD/ST helpers in
VirtIODevice and set them in virtio_reset(); the call chain will
be even simpler than doing that check on every calls.


