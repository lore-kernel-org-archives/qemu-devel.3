Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9A4E73159
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 11:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmriI-0001oQ-F6; Mon, 02 Feb 2026 06:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmriD-0001nn-TO
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:03:22 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmriA-0005xu-LW
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:03:21 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so3483658f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 03:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770030197; x=1770634997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=61gX/YNU5twM4llr/nuqeNbAvrW89PukQmH5iqd9uY4=;
 b=Nhlc5AMc8wV7DRKJF+YgwLtnit3Pw4ttSXBNofaUW9djv94Pb9+W+Jqm6kA2LU9VWU
 kvqT1x8SmZlJq3QBOJA5NvuMTI1i96WzkyFhP5xatch0syUaRzL3r7MXJH9p7NZuw300
 VqEOPtabLoPLbsnSU8705zqGx8ZMUTMwfDsirhTDwEZudamN11CuIyh40lZWwALrzq2D
 YoVQJSSNJx1Sm5dmsaaHtdVfGqo7f1iXGyFlSKD4gqIllJ191U3AjkcCUtEJP8SCk53r
 y8hXPiFjHUqVocWPMrb/yFCf84vS6Ppu4wki3KmZ9yIW1cqrz1JXqmgVi3fKzjbzYtPG
 Uk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770030197; x=1770634997;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=61gX/YNU5twM4llr/nuqeNbAvrW89PukQmH5iqd9uY4=;
 b=FwYjzuiPOrL3LINOtZIF9sJ40PcnuqiQlr442pq43AR7KPIdYHAY4OdRyH+PyAVkbf
 ev21HKCzuJ9/XT+2D0P5itT2W8RBsZdjD41QoHORfhnYs0d/9J/MQv//y1beu/VEXW6b
 5aTyao2m1+i59WPDIU75GbfX8Jm38PhZymIcUe80NkNkCcJJhRYl/7l4bBcnVv5VaVhh
 pFOk69+1hHlrovqpvridED98V3aDvK5XTZHSAPZBu6pCIvRoXUjnRcrwV1HLwgbr2MHl
 5EuH7+ASAd78m18ek6gz0CW3+NTLCrwkxsh2W+n7837m6NmbacUox6ttBpH71ZH1S8lX
 Cpiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSin6K5keYuJ9WUN+CqGlJs5dZl0Qz5QQb9X00n5pgMhwjBmyg3U69aiqDNyImOeu0jRxyjCsgxr5B@nongnu.org
X-Gm-Message-State: AOJu0YwwBPDBkPGwBx1MUmVPiVckp5/rtjWT9Vir1zhgfKoOj71Fse9p
 S6CrEiVbgQicXihLaSKUf4ZtWVCtfMhPpwKV6VY8J9Rqldy8YzcA4lGENoxdc2rSzbA9khNhAwI
 pAEso5SU=
X-Gm-Gg: AZuq6aISPR20OxUm8IOzBjhH8Fqm3QTc/WC9Ln29GcVqPUI7CIRerdepvHKLqIAIE3d
 MWgGDNJdTC7qPhVKkFNYKhJqpPYcL7KrwzhF4NA7/k0AGl75qo136uStVFHWdSGbqklpzxIo5Lj
 u3l0X7T0DE64zBxN9MxPecrL3ZL9svrdjiTCE5EPx5c3/q9BzjdogXrMNrNEuAAw1gtLPln5G2J
 eIJIODc8BxqTX7hF44zGorWjLPmjOhMfPSzMQyCZZBYECvy1VSwdYe/VxDqYaRW+vcQNM7H9Vo0
 3RkFbWp9ATYg4L1CYw4l/YQXx8e3r0ZGp8Pn33fe5gS9V7VmOR33T3Qy97lHsQzd4O/ks6mEGaQ
 HijluUxfPpqi6Zkym6spwh/0clWh0I755i5JF5GyPrX6v/huoIH84dWPJgIESutJ2VulDPv50Lr
 WNQz247PgofCqo2oq/PPXL3zhRbHcB6IUDhQbGDVDWq+fZ3wpicEiucg==
X-Received: by 2002:a05:6000:659:10b0:436:d9b:cd02 with SMTP id
 ffacd0b85a97d-4360d9bce02mr1302863f8f.0.1770030196837; 
 Mon, 02 Feb 2026 03:03:16 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4360ef9e804sm1996343f8f.41.2026.02.02.03.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 03:03:16 -0800 (PST)
Message-ID: <b40614d3-ef55-49b2-a1b9-3ecee3d406c6@linaro.org>
Date: Mon, 2 Feb 2026 12:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
 <20260131124842-mutt-send-email-mst@kernel.org>
 <299f59f7-62c3-42f4-99c4-b7c7cfb111c2@linaro.org>
 <20260202023914-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202023914-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/2/26 08:40, Michael S. Tsirkin wrote:
> On Sun, Feb 01, 2026 at 11:36:04PM +0100, Philippe Mathieu-Daudé wrote:
>> On 31/1/26 18:48, Michael S. Tsirkin wrote:
>>> On Fri, Jan 30, 2026 at 06:00:56PM -0800, Pierrick Bouvier wrote:
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Performance impact?
>>>
>>> the reason we have these is for performance ...
>>
>> If this is a worry, we can declare the virtio LD/ST helpers in
>> VirtIODevice and set them in virtio_reset(); the call chain will
>> be even simpler than doing that check on every calls.
> 
> Would make them indirect calls though, no?

Currently I count 3 indirect calls; such approach would have only 1.

Anyway I posted a v3 which should be even better.

> 
> So I suspect the performance of this needs to be tested, anyway.
> 


