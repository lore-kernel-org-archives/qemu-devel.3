Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C134E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYlq-0001Qh-6b; Tue, 17 Dec 2024 09:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNYlo-0001QW-5m
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:41:56 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNYll-0006kw-J8
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:41:54 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-29ff039dab2so2691826fac.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734446512; x=1735051312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a1f6mj+CriLweXpW8FUDViNsnaE5YI+2WCT7RVMvul0=;
 b=P2pMvnOJzIos7EJ7YqgLS7F+BMbn3ew+sgwqqubQZMx73F7CZPM0tzR+5S7BrzR+cc
 l8nkNBEiBiX1yYngA2xvWaZq8NyOhpMYqq/7n0SwnYZfQ18RYkFS4ol219fpHYQIzlPe
 UFwDAWx5zgMwAovjX51A3iljkxexH7NTNGJLvLL7IkDVOfjIJSXUyrvOpTLRltJDO55o
 7QXUDCK5W1B3iNmRlidnNOg8pLu0jvWGb4oykhCaU8GCny5QCs7yLmzAWYS/7FpqG5u7
 r46uPRQNJUKWWAtaF9hXg0lDXIIOfyeJjk/HfN0/mgPopz40QhOWNl3wIW2c6mAtxgiy
 BmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734446512; x=1735051312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a1f6mj+CriLweXpW8FUDViNsnaE5YI+2WCT7RVMvul0=;
 b=Vk+KpoQY7t+vXeBlHOaCcIb+sfBII2q05ZvEObe1pRbbIzoYZxDsh5hDyjVABPVflj
 P2Zkuibm7iB8vPnjjlYKS/Dm1F3lvk68JkZo+1bI7eHmmxERdME7w1t1QYWU1kBP7a6Y
 +cOeIPhlkCTgWOTqdZKuLiJLsXmwnvDWDc7lZkl7sl99dBl2MbBWggRpeIVN7VZ5+3Q4
 lq72ArBTezfhQ9HvZpAvcXjbfVL1eke9C09ffZUonks5byWCpmzvHljdFPPpc3q8Pe1Y
 OrOVi07GMhOm4jJpd2lSjOHzwrspyQQF6u55CURF8BeqiYoVbVrUCPmxOtK3PVBscILy
 STJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFsa+qEadkswAP3swZgxDDAI9S5I9ky+M50vKSOhA5AshGiFQ9bMvtB3lyCc409W5/mGuXYc54KSTC@nongnu.org
X-Gm-Message-State: AOJu0Yw4bQVguK53gzfVcHdj0W5jNXP29jsB9NnWX9NeJQhZFPkJES+3
 ZOL5kw7zBBRvHqvoHbnwj+FYcs+B8eVDqZ1OFc3cXZ30Z+bAbN43KJ1hRtHt9s0=
X-Gm-Gg: ASbGncv4VHyIHeOBgLnQKvUmvf+lqycebgdHUEnH1EJurqqKZXDQkxGecXfuNiajqmg
 nN9EJdYM78BoTa5t0sMrSOJ3bVkGnNGfdXo5ObuZZYDCM67gQBr0fK1QJNIveUlgbFIxHb+tkLZ
 GbRgnofpPIO0etBLObOsnlxxK+lGc0gx+o7D7rZINSIt8rQpz068/xcU6T8bt9zacxJgeLm3NTl
 TewFNfW0dxi01817Rq+PpGykJ+DsHhHJo2gacI9d6kns2hAoVvptmHYCiRV066a3/BdcJlgGHup
 ijyaIj9OP4AoU7aqFpc2VOoH2XKMg3VZy+8=
X-Google-Smtp-Source: AGHT+IHBTpILE6fjcRDvX6MkI1oPBq9sA0so1RoKrzKE9G0a5EIryQaLI57CijnFBTK4YjLgMN//2g==
X-Received: by 2002:a05:6870:3c15:b0:29e:491b:96db with SMTP id
 586e51a60fabf-2a3ac49fa7emr9833699fac.5.1734446511813; 
 Tue, 17 Dec 2024 06:41:51 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm2803644fac.39.2024.12.17.06.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 06:41:51 -0800 (PST)
Message-ID: <1eebfbf0-e26f-48ba-8e31-b9f908118270@linaro.org>
Date: Tue, 17 Dec 2024 08:41:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] plugins: change signature of qemu_plugin_insn_haddr
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217010707.2557258-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

On 12/16/24 19:06, Pierrick Bouvier wrote:
> It makes more sense to return the same type than qemu_plugin_insn_vaddr.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/qemu/qemu-plugin.h |  2 +-
>   plugins/api.c              | 12 ++++++------
>   2 files changed, 7 insertions(+), 7 deletions(-)

No, it does not.

qemu_plugin_insn_vaddr is returning a guest virtual address.
qemu_plugin_insn_haddr is returning a host address.

I'm not sure why we decided that returning a host pointer was a good idea.  Probably it 
was the easiest thing to retrieve from softmmu.

One could argue that we should be returning something else, the only question is what.

Perhaps guest physical address, which wasn't possible before, but which is now stored 
within CPUTLBEntryFull. Interpreting this requires you to know the physical address space 
to which it applies. In the case of Arm, the address space varies depending on Secure vs 
Non-Secure state.

Perhaps ram_addr_t, which is *not* a guest physical address because it is not associated 
with any address space. It is more of a globally unique token with which a RAMBlock may be 
found.  It's how we stitch together address spaces under the hood.  The plugin would have 
to treat it as an opaque unique identifier.

But if we're going to return a host address, then void* is the correct type.


r~

