Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC7BCC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEwT-0003S3-Tl; Thu, 15 Oct 2026 02:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHEwR-0003Rt-B1
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:27:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHEwP-0005go-Rt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:27:51 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso124653f8f.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792045667; x=1792650467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dv+KWXiTXUgQSaAhPU7+eAbFaYXoy7zEf1cl2dHQ+wI=;
 b=n/8svkCuLzPkp2wMLeYqvEfUWK7rvuOnuqZuRSTBS2YCCXLNPJt0ejzZA/xYmeJ9Pb
 qYrIlRcAQ1geJGVIt4ljKLtojTt0Mb7xAV9KiSb0amGchq4R3qZzrKc7aaw1csMY09zy
 6skT7a3hWSN2hPliP3OoRpyXMvMK9U+l8hfNjWAVu2pW4Dtw748w3hn4H1iiHgtrOlWs
 44v/CBdy8cc4kptNwYTdqm96fRd2lBX44HwhByBSjXGM9k+qUbZOz6xmKvo+/562s6ff
 kCx2GZaWumyp+YJm5P81qGhrtP0aKNkYfiOj8W5fwfgmGg1W96JdSta583JW7IBLvdrv
 W03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792045667; x=1792650467;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dv+KWXiTXUgQSaAhPU7+eAbFaYXoy7zEf1cl2dHQ+wI=;
 b=JGNPjWDyNM5QMtfPHsetNnOj5sBKTBCxMg6Wb39I+8WkHf3iWYaef0Vy5yi31aKywL
 9c0B2RuyG0ManaHiYeyg8s/szx3sBOZLKocCg9RV/ojltESVSANpoxm6khaB2QtC6s2w
 fVyVTFId3JJZuPM9MVYNWxXTPEa/y4bKy/eoYxFXVJjQbypEosGtGADH56+AXH5iTmr4
 pavzOeUUbzLDACA1TZDYd1SlmIbLzdBXyMYsoRIf2U0Q2FGzndEFEw6lmcw1XUWBHW+J
 h8K2vQK5+31VutT18hS0dtIryQfMO98Wu7fDRnHWweaxzax4EJqqQijLdjscUqRB26MM
 NuBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvfqLxFBM+iQZjGSmPQVw9no6HwLCw9hmAuwVC/JNdQZOcgZIyyqxDH/GzJhvxy9B5qdkfim3rbwox@nongnu.org
X-Gm-Message-State: AFq9FYLFab03UsuotBV64zlgYrof04o70oc+I9lnWrBbGfFZO8+xNjrR
 HvOzGP9X9D4ZOFoufdLVk06kLOQLFFZTjNcyzSCUzcFbVk9daM67Q+UvHsd3y6tjtlo=
X-Gm-Gg: AYBFou2zegGQUyFb7+rEQO7nH+DU8hIb4n+uH9FxOxhLIGe6ezRddWBOD2Atpwf42JO
 ZFVr0Nfbdzru5taQxpw4PVnCWjreod862R0pIPJfR+BRBjPoUPHz/D0maafkE4IB6WUjcjeKsZf
 1sw+hiXpZ0tE3XsCX/aN4/A743Uw/pMDBognoeybmJSYrs2LfttUEuorGRi9R7O5acTGF3u+Sh+
 S9/9K8un0KrRp6Gd5aqPeNSr9t4g5o7ELVfGkmkx4VbYpWx7sThY+s2S62RgDbVtOPiPoeZaQhE
 OQUyFzm0JOv7WYKNGc8zmJFc8i/HbvH2kAZaXY4m652uYDyPsu2lxNR4snmNfZ0mNe14ulYIo8R
 SnYFX3f6jWFcZ+jqHSGN//sh9zshUGdOZyLJRJAN4kjZk1CQXXhvKNcSwRl9QaAIimKbwvkTYqx
 6sM4EekgevYEgfrdTNoblIbXA0jij9cQuNGuhkzyVA0mPVRvYF7pIi8WKe9MrSkGPOI5IVLnZrF
 NJQc03EM9yGWrhLf0JhgJtnnccJsERXSTOaL02iGk1iABt6Cl9m7owjL1WPsfd2DTxaq3fEvfTb
 MVALFwv7ndBimDx/07wXFZBeaG6YodDQeW/UEYK9qtVKzINClN8=
X-Received: by 2002:a05:6000:4205:b0:48d:f470:6b3e with SMTP id
 ffacd0b85a97d-48df4706cd4mr1996618f8f.13.1792045667470; 
 Wed, 14 Oct 2026 23:27:47 -0700 (PDT)
Received: from ?IPV6:2003:ca:3f0f:8b00:a126:fdb7:f67:bb04?
 (p200300ca3f0f8b00a126fdb70f67bb04.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:a126:fdb7:f67:bb04])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac37acsm16571105f8f.34.2026.10.14.23.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 23:27:46 -0700 (PDT)
Message-ID: <a781daec-7b64-4ca5-b711-9c7cdf5ee9e9@linaro.org>
Date: Thu, 15 Oct 2026 08:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common-user: Skip the identity map when qemu is loaded low
To: Rick Richard <rick@sloservers.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 imp@bsdimp.com, kevans@freebsd.org
References: <605bc800-4263-40af-b8d9-18305d25f3cf@sloservers.com>
 <cfeb85d4-57af-4aa5-a265-a6ac46cf1f22@linaro.org>
 <094898a9-b3fe-43f8-b335-c149ed8b0a96@sloservers.com>
 <1f1af018-8720-467e-8c8b-b4c19a0b9c5b@linaro.org>
 <9dd7ae30-b1fd-4dae-9e62-594af39a77d2@sloservers.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <9dd7ae30-b1fd-4dae-9e62-594af39a77d2@sloservers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 10/15/26 07:04, Rick Richard wrote:
> It's not really safe though, it just moves qemu out of the way. A
> guest MAP_FIXED can still land on qemu's memory and crash it, even
> with a non-zero guest_base, since the heap and code buffer are still
> in reach. Maybe target_mmap should refuse that and give the guest an
> error instead?

The same is true for Linux PIE, just moving the binary into high memory.

We don't have a solution for keeping host and guest memory addresses 
separate.  Since we do not control allocation within the host address 
space (malloc, pthread stacks, TLS, etc), having target_mmap do anything 
at all would require repeated probing of the host address space on every 
such allocation, which would be ... well, not impossible, but slow and 
ungainly.

At some point I'd rather just have softmmu for user-only, which solves 
other emulation problems as well.  But that's a lot of work too, and a 
known overhead of 30-40%.  The overhead I'm willing to ignore if it gets 
us better correctness.


r~

