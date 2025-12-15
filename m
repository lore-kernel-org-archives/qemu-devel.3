Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F7BD5B170
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCSb-0004SJ-Lm; Mon, 15 Dec 2025 12:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVCRe-0004D4-TB
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:33:22 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVCRc-0001XG-Rt
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:33:14 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so42546235e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 09:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765819990; x=1766424790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hdkqHWSQoIB6A9wzwsDWUJvd0/FbziOQd0nBqRN7giU=;
 b=eQbU5IK8vwn2ssjbDPypzqN6pUp6dyhvxxK/wls4ebRqOLuEfsMypa35TBEHXUHOMC
 qHcG60QoRk2Km36uW5Q0ofHz4kv+3h0vPRZuseIMP08OD8eeeASPEXCzcPKX+yUsR0JT
 8aou2Obi06+odJDD28kybQ2uiFwKMB0uAX7oAC7ckJFnQuVMSY9MB6Vs16yJxC4sWTOp
 hRqQr1vZQ+1TthduJjNYteEc1VhlO6ITxqgD01Ui9BVk0Srk45JHJhoXQoDcbAdkJfCQ
 1arDF9Y4/2XqIzcM0cUgjCIOzoo3JNU9/6Hfmzfxm56pW67ZTjEfCm/+/qQx4No7aqIy
 97uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765819990; x=1766424790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdkqHWSQoIB6A9wzwsDWUJvd0/FbziOQd0nBqRN7giU=;
 b=pL1ZV46EHAnsK0XkothyVYgU+HKPzkj4tPbA03XaxErKEIS4pU01B87wdR4SMqvF+A
 n0VBtAoNxi9KYQj/hRXkbWezp604HilH03mCkHagmZ7mhcR1jqFac5hkyE/tx7ZUGlJQ
 02EE4uN09vJe/+qJzxTTTLFkmGOi9bZg8SVOnCSIK7seL8R3U4rn1gN9BGbHF09FN4sg
 YU0gmrOrkc8vjM/Nx9ciLu3ZJg1JzoIsKoI77a0yzkRjirVoU+jJVEURScOCHwDZXI/6
 bnCm2Eb7Uo/g1TtOJBVXnPgrzp48oYHtBn7TMgPNvFpUx+SwPe5NkUxVfNjt4NK4fIZC
 XIIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgqQZJ+/DkFjAiiU+Ixu+IzNrBO6+h0WzzLgUCWPPjasnyct3U1rmtHisMijudzdk/3bKWuALecyIO@nongnu.org
X-Gm-Message-State: AOJu0Ywlr8i7kasAnsJhC+qnV/uxVArASfC6Oph+HI3A9VyDUzyxo16W
 oBb2PlGPfA2acsYpEhMOHWBMQ7rd9vHIAIzMTRZkZRPcQ6xe9DrU8CafvUbihzJK23e1kkpspKC
 LhhM/9sE=
X-Gm-Gg: AY/fxX7YFaHqBnh+FiFwH7+3JTUUUwk3QxoAsC78Sunlktk3vZnrc41sHzmHoYw396r
 v79T+poxn/VG4gO5pTYvb1+ftA0+fbjSYlCTKzIHWAKblO79Wi2MOreqhGbfPS+a9AaTBf7ZTEO
 dZLyiF7oL8R0qf2Ey+KfsIPAoqH8aamvevFlsllEHYuqS3HObIUaaE0gF33JfNWVOoQjk4aPGLL
 y+OSOaU7m9lk2bb2PdARI9D+gNX2WCCGOV3UrvbF1XSRNORhplzCq5c1B64BXOG+alSySKC98sS
 7p7SR9kMjpw54+APUlpdODh/NF9qbMPRzhh8PSKGHCn8+MrRkei9TxjsNtmcLcwngrap+T86wWy
 sR81Sxrt+z2chxSuOG6G4NKTfg+VEkJcKxSdnxYyvHWBkxZgcpaJcs/W/jAHHm+yxXDBj41I65t
 j+bRJyLAplTR3a0ISmYLDHeflVeoH7MCVcpw79V6cF75+KYenRzu4XCu6DnyK2wZ7s
X-Google-Smtp-Source: AGHT+IE8rc2Kgj3Xng/28vnTCzW+Pqz6y4F6UK2bFOhZES/v6OB0NcqMQEk0Y2ESPimB9FBQgwLrMg==
X-Received: by 2002:a05:600c:6208:b0:477:aed0:f40a with SMTP id
 5b1f17b1804b1-47a8f90392dmr107864265e9.19.1765819990266; 
 Mon, 15 Dec 2025 09:33:10 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430fc36c83fsm9218829f8f.19.2025.12.15.09.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 09:33:09 -0800 (PST)
Message-ID: <334a8388-d275-4e08-a2a3-fcf0ead81674@linaro.org>
Date: Mon, 15 Dec 2025 18:33:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] util: Move qemu_ftruncate64 from block/file-win32.c
 to oslib-win32.c
Content-Language: en-US
To: phind.uet@gmail.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20251215164512.322786-1-phind.uet@gmail.com>
 <20251215164512.322786-3-phind.uet@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251215164512.322786-3-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/12/25 17:45, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> qemu_ftruncate64() is utility function that may be used outside of the block
> layer. Move it to util/oslib-win32.c where other Windows-specific utility
> functions reside.
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>   block/file-win32.c | 32 --------------------------------
>   util/oslib-win32.c | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


