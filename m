Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B88FC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMTe-0007xM-F8; Fri, 24 Jan 2025 11:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMTU-0007ub-8h
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:24:04 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMTS-0004pw-OV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:24:04 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so23875545e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737735840; x=1738340640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GUAB8KJvef72LimTXU1kyCn5E97m7qx6Tv9JQEXMfi8=;
 b=A1MRrNN4up7lNuGLxd1/4XbuAg0KV1hC9Il3ohCM934NarQYzAwGUaJxqb2EuxFPVo
 m9R+EIqYWBqcmcgoth3bvM4tzDM+ztNUxO5mQN1qqAePeT2joZ/5DLxAogGS4q4K3FW1
 9JMiorF9iDZPYK1zcz73wSJj3a2bI7vQrRmA4W+iXQIIJHl5hWxvU7AVL3KHNXajrKEk
 Yx2lSexne8n6AKtmiZJ0PEWKKMu2ApDsmxeqQCeXmd3eKQRQ5Pb149tv1oU9heIxfeYv
 c3Ks71KaEokx8IUQnDbdCh/yNBYML5wTyk4bTDe2mO8IDalkD/m1BBmLBJHiFGGLdY4y
 1suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737735840; x=1738340640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GUAB8KJvef72LimTXU1kyCn5E97m7qx6Tv9JQEXMfi8=;
 b=lohoyn2PqzdvHa4h0Q/wgGLvZoehdUxoG+U8D8w/lUsBtD5XSHXKU4HD/fF+ZY/Zs5
 Hp2u32PH+Px/iYQnwRFRHytai1lrbeI2mCDjmqqITbWEuce2g0SRR16ZFJJ9Bl7bIOYn
 WXvETxnX/3NAvTCgUddCyzLwqcnZhFi6Ts3xW53l3XUoIhkP8xR1oIC4vk5B8vLP6sWv
 bSJi+/GaaawptGRiYecUxWS4usG9YyWp3BBww2Va8UXFj7fRimUNnHgZrVCgPzdf5vJq
 FnXUlzx23bMxCrHrjeIsCFuREKjekZRc5l+dSj1wjK4ExAPFeln38yC7V9Gc/cAq4FNa
 qwJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwDkfRaiDDeSP/4MNfpv2klO1woKDs6+JAOyYZemP/kVG1NpToP3Bh+8cLZb3A4IJOaEm5pe9+nIIy@nongnu.org
X-Gm-Message-State: AOJu0YwgIwbc+SLcU5a610YqxBK9lQl7kdzGfs9IXquwMBwt3RwpEYWw
 ivF5VDkRRnNPhbn4ZHmwKy1VZoVqKEfaOXWadJDMwMaV0Bkk0tBCOs/IkoY4igY=
X-Gm-Gg: ASbGncsiulljOvqqySyZunwOgq67O8Tp0bBhNW5Ud6BONOwH/lKlfDPJYanwNO31SdX
 k+2pO7ff18JhiqFK9GqJzOwOHdcCXgnK/56dbTmHct9bR0yTxiMK69tG81x+yW1us1yueTwwlvS
 j1X25mw3pPnJeVbZwCkIbyWrdIFrF0aCgvPn24INImRjdZbWhUuICE4/3TuYdsL5NKZNFIJMk4R
 uubN3bONN2/WYQeZolG3TByoU8zxC5CERUAPNF9haf5lVb7tIU5TfRfEHEkYyPzTvSCEpfDaS11
 zyZ+CEYzi1gRaRmCELNCCfKnUFnknFFyGXGG7/W5vjsaAWSb
X-Google-Smtp-Source: AGHT+IH9B151Hho6P2y72c+thC/jbo2cuUqsJOABVeFDxiEwq+c1XgzAIK6IReqjXumoc4UkeKwoCQ==
X-Received: by 2002:a05:600c:3acd:b0:438:c18c:5ad8 with SMTP id
 5b1f17b1804b1-438c18c5b00mr10409135e9.31.1737735840626; 
 Fri, 24 Jan 2025 08:24:00 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507dc9sm32111745e9.19.2025.01.24.08.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:24:00 -0800 (PST)
Message-ID: <f6504464-f9c1-4ecc-a0de-8645e42046e7@linaro.org>
Date: Fri, 24 Jan 2025 17:23:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] memory: pass MemTxAttrs to
 memory_access_is_direct()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
References: <20250124154533.3534250-1-david@redhat.com>
 <20250124154533.3534250-6-david@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250124154533.3534250-6-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/1/25 16:45, David Hildenbrand wrote:
> We want to pass another flag that will be stored in MemTxAttrs. So pass
> MemTxAttrs directly.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/core/loader.c          |  2 +-
>   hw/remote/vfio-user-obj.c |  2 +-
>   include/exec/memory.h     |  5 +++--
>   system/memory_ldst.c.inc  | 18 +++++++++---------
>   system/physmem.c          | 12 ++++++------
>   5 files changed, 20 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


