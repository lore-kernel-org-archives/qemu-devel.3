Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94905C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 04:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcHBv-00085j-Iv; Sun, 26 Jan 2025 23:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tcHBt-00085M-GR
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 23:57:41 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tcHBr-0008Ew-EH
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 23:57:41 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so5228803a91.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 20:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737953852; x=1738558652;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B7eCPwkV/tD9pw6bwhJgONzi6+4MQ9sNXJBSR1Owu48=;
 b=HvyVtQF+QotDaPXss80o9+c7Y4fl8b+ZyXoFaNJdwoxmd4c/761hCeZJg/y/37wwlu
 kkSAIoAYj9E2X7rvszh3Z06vpAo/YtPvFB0imgcfsId9owH1qxam3PmIGjw9obq2X6Bw
 6aZ4OLiM/X8Yk1b8GHtPe46nufeY1K6KkNEXX0ABSm9bU059c61EiZjQKKAw8cOl2CNJ
 5Yi6UXRfCN4alUFAwMZGVDPuEBXpf36+9JoBx+G8fuj/M5PZP3461jfrEE85b1gTBxwd
 dyPLP9ds9p/QW1GF77icf9h1bO+NCSLsEdu3rJfyJyjzFOsiW0SZc64DMhaJHPOVUnCS
 G1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737953852; x=1738558652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B7eCPwkV/tD9pw6bwhJgONzi6+4MQ9sNXJBSR1Owu48=;
 b=imMAinh3Bfidmldz9qO4iD5dx/wTlQ/x78chvjfhKGQ6MwamUOrvK5PvzSWhlO8/xM
 VUjdvYUg1/Pb+qPFuvhN1W/9S1GyMR0YmfFPwOl4A1oHgqMlDazizz65HALmCmqugWI7
 LqBCxc894w2//Q/1ttI2drJjMqD2wbRmjZnDIbXkZYDIpWrkMk1B8ZPhrPX9GWAzq6ND
 DuNTS7zdYRv+qEm/kKEgtQa6Etb0RzKaYY7STbsPOERk1AdtBn57rxJe1lm3dF11b8Tf
 NLypMtMSAHehHKObEnNot/y1evFkXL2CfXFG+SXFd3xsE6CSXFstqKPJrFO94VmT2LaW
 1DRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVAgyPe0nHvZf4Yl3xmcXwzcyWr5ntkyky4C8pPiPvvvBfMsvkLFqA5W7aLDcnLylX0pXrcIZKzUFb@nongnu.org
X-Gm-Message-State: AOJu0YyCfST/x6L1XN7XNTD7AG/yuzwx4mNCacDOJ2YqtWz7MYoGTLPR
 14+OITMAN5e6zI+M105j5d+Ta0WSPd+RE60lB1P2nnxsVe5aZ7qJnznShCQt9gQ=
X-Gm-Gg: ASbGnctbVUmcVfAhFA0kYM8nx3s6hLLmsHXppbfjJp/EDwhcRAlvrxcJsVNIA2l8biZ
 jpdN/EKDJ9tEno2WcKYt0W9L+wd+OtqONuWCm6593MDdv57afx2cv7PGlY0lNGb//onCOU7RxsU
 Lhi+Skj858odjuGzS1uqJQ411K7cI7QkqWAsCs/YQ5GVFS29lZR8A1wou5Wjrdl8IXLByIFld6M
 emOqqie2tnwf/Gu9nkGpn5ao+i93ndqfpqPIRB2b8wdobdRxcvTUHxcglE3qRagJdSWulQ6wfEJ
 EC0q5FMus0v+ViOE9NQ90BTLaw==
X-Google-Smtp-Source: AGHT+IHrLML0xvc5v9nxlYqpPoS72hTtqYj5NDJ2VoijOILYTRipdGVfyGNHSG962mIGSsi0DquK2g==
X-Received: by 2002:a17:90a:e18f:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-2f782c7a769mr65088194a91.12.1737953852093; 
 Sun, 26 Jan 2025 20:57:32 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb193e1sm6115139a91.42.2025.01.26.20.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 20:57:31 -0800 (PST)
Message-ID: <86dce86b-03bf-4abe-b825-1341e93eb88d@daynix.com>
Date: Mon, 27 Jan 2025 13:57:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] docs/system: Expand the virtio-gpu documentation
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <20250119220050.15167-9-dmitry.osipenko@collabora.com>
 <c2e1c362-5d02-488e-b849-d0b14781a60f@daynix.com>
 <87ikq9r7wj.fsf@draig.linaro.org>
 <171b1cd3-1077-438c-a27c-3b9b3ce25f0f@daynix.com>
 <ea866d19-90f6-4bb9-a3f6-f84b2ea2c457@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ea866d19-90f6-4bb9-a3f6-f84b2ea2c457@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2025/01/27 3:06, Dmitry Osipenko wrote:
> On 1/21/25 07:26, Akihiko Odaki wrote:
> ...
>>>> I feel the dependency information for virglrenderer and Mesa are more
>>>> suited for the Mesa documentation as they are not specific to QEMU and
>>>> potentially useful also for e.g., libkrun and crosvm.
>>>
>>> I think while everything is in so much flux it doesn't hurt to include
>>> in our docs. I don't know if mesa currently has a dedicated page for GPU
>>> virtualisation.
>>
>> Mesa has pages for VirGL and Venus, which can be linked from the
>> respective parts of this documentation. gfxstream is not documented but
>> I think most people will use it only for Android anyway. A documentation
>> for DRM native context will be a nice addition for Mesa. I will not
>> object if you put this information to QEMU documentation though.
> 
> Adding native context doc to Mesa indeed will be a good move, as well as
> adding links to the Mesa virgl/venus pages in QEMU.
> 
> RE requirements documentation, it's also a valid point that stuff like
> build flags should belong to the relevant projects. On the other hand,
> it's a common headache for a newcoming people to figure everything out
> from scratch and having more centralized documentation helps. The build
> requirements aren't cleanly documented anywhere AFAICT, and the
> requirements also differ based on VMM. I'll update and keep this patch
> in v6, the requirements info should stay actual for a next couple years
> IMO. Let's discuss it further in v6 if more objections will arise.
> 

I think it's fine to require one click to reach the relevant documentation.

How do the requirements described here vary with VMM?

I'm not entirely sure the documentation will stay as is for that long. 
The requirements of Intel native context refer to merge requests that 
can be merged sooner or later. Asahi may need more updates if you 
document it too because its DRM ABI is still unstable.

