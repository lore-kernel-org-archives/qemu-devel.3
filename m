Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381E5C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 03:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwXP3-0002S5-73; Tue, 18 Aug 2026 23:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wwXP1-0002Ri-Nn
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 23:55:47 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wwXP0-0004W8-Be
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 23:55:47 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-381b831d535so970471a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 20:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787111745; x=1787716545; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=547OL5zxw5EEr4v8p7v+XJcyV8jxCqtALXnwjNtKIf8=;
 b=D7Uz61qnC1p9jE3jGSZY8hx2wlFtqDzwlwrqxPkJsEotspCGxRcnRJ6nNJcGoHrxyT
 QhjGDLWCn7iMK7FCXj9qovne7L3lQG8hvs98zaL7aK1W/k/R857pp2c7x7az7SuKjTiB
 oYzEmkboCLFCWB8g2smGQAXo5TH82OEKKr7j1F0cfw7QJ3t1JElJqWwHD5MJVkhx4T2A
 y2sBVkhV/DLTG6Nbp2tm1ydzNdlj2Z1E4/Ln1RePU1b1jhrtstbxu6t0nepVxENIBj/q
 5xXA2FpKNoAScxuD3FI38Lb8RIpuXFdz6BoGRzAq855dQhR7B5ks7BNJDC5vWnIv/Too
 2jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111745; x=1787716545;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=547OL5zxw5EEr4v8p7v+XJcyV8jxCqtALXnwjNtKIf8=;
 b=YgMYDgmZaB5U+QWAne4X5FyuXcyODlLMR0TsGPHp84RoReSnmrpFXpBmoP4t31YVI+
 F5jZfvQlgAxnITG/zJOnLTreQYj/7ueSBdF2n8aoM7FtjyuZjWbWxjVZdtQVlYSAxaok
 zgMjHwJPO34XrYvw2Nz2qHyAwLsCFBx228sf8TgKoKCP66hq7aEtE0l6F3xEfOznpFJI
 Gx89iTNlrD9vzU/7ofPubhcpkcKkueSlhFi6RHsg/Kn7toy+2vFjYrPysGunaM5zEo/l
 kylcKVFWYhfWjegnemkq61M6l+D124oa6jZJXQHewn8uB+9yZKElPq85lmz2h5FPhSVt
 OBCA==
X-Gm-Message-State: AOJu0Yx39KXDvwAG/KGMV9H84P4E+rvwtw6m18OecsKnr//fgg7FAtW/
 2giERVkswkdct/anYsDKF3aIGrDJaowT4dkSWsWgDUMMA+EWR1dUMduu
X-Gm-Gg: AR+sD11iu9aqdzzBo4U6xsT9hB1OSDP0/7GA3Lpz450+tSwukK30mw10p0021/piMWU
 n/3BmpMipkmR0/Lo3oJKhGZJo0783FH8cECFRuiAi6Mp3m3YIFiQjkYyMs9pyD/acAFtDN12yWm
 OYPTnChkPWfUtKwR9zQpwLM7e00AjOXCWYNxLdDYoJX32syhmX2en2TS26ZSsP4lRsyKRVmqshc
 PXR0gLdTPsgQUESLhzogr7igW1MfpE9+Zq/Yhi2GGzmreWzZrBqc1bD2f1Jnn13pbhd16MUlifn
 Z5w8v1Deyk36z9kCSoPevPVEUF1xGClJ5ewvE2ui0G6w3eQhzIQV7z6CIMxgjiNgm1KwVsM1INC
 j5vMKEQPkERXUnJIunEP8cy4bPbEh2juhHjhY2sSbpIiQQVe99Th/FvT7jFwieMG44ETkr+WlHc
 n0f0jskMHvioA8Txlk+ksjbx7LFIqFdfBy5HEfo/wnMnIcV8XMDR8yvN4Up/PSTJw1iIAt8gGjG
 MzkzLZ5HkEWYg==
X-Received: by 2002:a17:90b:3c07:b0:395:543a:cf3b with SMTP id
 98e67ed59e1d1-39580a533bfmr3339147a91.2.1787111744613; 
 Tue, 18 Aug 2026 20:55:44 -0700 (PDT)
Received: from [10.3.188.167] ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb17f48sm1079870a91.2.2026.08.18.20.55.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 20:55:43 -0700 (PDT)
Message-ID: <c1695bbf-3ce1-45c3-a73a-047ba0fdc433@gmail.com>
Date: Wed, 19 Aug 2026 11:55:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] migration/rdma: Remove unregister code
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-3-peterx@redhat.com>
 <4d0d08d3-ad6e-4de3-85b8-587b70286b04@gmail.com> <aoRXk0H1muF_gZJP@x1.local>
 <4a0b20e5-947c-45a4-8fcf-89c77e0a4cfb@gmail.com> <aoRvobhlj6-YJsqT@x1.local>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <aoRvobhlj6-YJsqT@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 2026/8/18 22:43, Peter Xu wrote:
> I actually don't know why RDMA_CONTROL_COMPRESS is only used in !pin_all,
> do you know?
my understanding is that with RDMA_CONTROL_COMPRESS, the corresponding MR
isn't registered, so the memset(0) in destination side can be guaranteed to
complete before the next RDMA write to the same chunk. Or it needs an
extra ack from destionation for the memset(0) complation.
>
> I can only guess RDMA WRITEs were fast and need no round-robin chats, so
> it's faster than RDMA_CONTROL_COMPRESS, but you seem to say it's not true.
if most of guest's pages are not being allocated yet or are zero page,
RDMA_CONTROL_COMPRESS works more efficient.
>
> Meanwhile, I would expect pin-all=off ultimately should meet the same perf
> over pin-all=on.. so I don't really know how needs pin-all=on...  maybe
> it's useful when one is looking for minimum total migration time when VMs
> are required to be evicted from one host?
>
> Feel free to share if you have more data points; I'm almost speaking from
> reading the code, so it could be wrong.

Hah, I am new to RDMA live migration, glad to discuss ^_^

Yanfei


