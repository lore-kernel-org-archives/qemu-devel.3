Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14738E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 11:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKcEN-0000j6-VX; Mon, 09 Dec 2024 06:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tKcEL-0000if-BY
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:47:13 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tKcEJ-0008RD-BD
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:47:13 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7258cf2975fso3585025b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 03:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1733744829; x=1734349629;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b1TB7xzwBnR1DZEmlX36NtTrUmNOLFWGGHwzZStXy00=;
 b=n55qLksv0Y2B3sedkBp2jrKzqD+zUPPsbJ/x9ZMkejZ7i8Gp74Ca3Tsa8TxXJJmNhQ
 kkPeIyIWo8ZFzOlOexswqn6c6DVHrshNWMMzn9NK9WzSQ18k7IjGKcC+nPWiwyFG+SPv
 fwiwIO6UERvWMNB7W6HY/iIRk626ydyD4EeqrncUP8e+LpjimKQf0oL3yd3xm3dXodBn
 ec7eGL+JMDyiooLgCF9fAeZjNfHeUiz+/l8a0By7S8f+PmrjmoNvqjV+HBXOi+/+Ql0B
 wISXFTI85+apG4zSlcnAgZjhqQil6KV8623PeMxZczSiq0kXLBsQsTseG3pIhL3pGAHF
 9kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733744829; x=1734349629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b1TB7xzwBnR1DZEmlX36NtTrUmNOLFWGGHwzZStXy00=;
 b=MNJAz9P5HvVHrC0uwOItdFCyp+Uw/O8uTns2dIYc+JtskBqgliFANX+FoZ5ZRRvhPf
 65ByBBBUNFqr8ZkyfSN3olR4vcjaji7SUo4DYh+56hElKjVyjbxNbjGGX/snGoL9Kvn5
 YBVzPA05lXG4yLRX8SyUtvxTiY5KnJXoXjOWPuMetqiQh9um5Y0bmyh/W4HJiFu/d2br
 TVdh2RurjMtsZnO8JFzy9HBZM02/c9NGOK/zpnejQ46loeRSNVZKumqiZGZ6FXp3OH6Z
 eSlkFywSiTqiWRmCneR+FcGys9krxq1FbTuDA9MH9nYxWEfI26ULQ8fabKODQfODT4U0
 fdgw==
X-Gm-Message-State: AOJu0YxJc7wU/NCKbHNj642Kj6lLmo4v0gxNcPC9KvNL4exyIFnRQl2m
 314RXnL5EQ/ZrBcAvN3RL/fJRIOnY6fXHAx1LPp0eIcFE3D3WTP+Yfeuh0O02I4DCqE649Kcvit
 K
X-Gm-Gg: ASbGnctc2iTkQoIyAEgHQ5jn/fjYG3+l55t0qxzqXjF3ow/QTR4/VFXE3z90SdeRg51
 6CWHQ9MjYUJXvUVObQzBHkYKs10li7ohu790i/vjYniEikwBrXLw6F0auzTei8ALpKudfIq7i0v
 6fZxKkaXHVHUjEZxyfKN7az72uje1qWUpYte+S8X96wi56naGHMiBa0LMjE4VtvFrmNC+VVhdC+
 nPUKcNvuqbgyH5flzkPR/Q1i7WV62w1ASooKli3z9WdfuN7Pnj8pv9HEvu7
X-Google-Smtp-Source: AGHT+IELGLjg5FPXqNNlc8yfDCXQMw4ARGkYnsRapoJPi8GKUAM8K2ihxiYVA2F+dk8pDMGCHxkO1Q==
X-Received: by 2002:a05:6a00:4601:b0:726:8366:40c5 with SMTP id
 d2e1a72fcca58-7273c913efemr154435b3a.6.1733744828400; 
 Mon, 09 Dec 2024 03:47:08 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725cf238777sm4000485b3a.47.2024.12.09.03.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 03:47:07 -0800 (PST)
Message-ID: <77c34e50-6e71-46b3-b13e-d1711b51fadb@daynix.com>
Date: Mon, 9 Dec 2024 20:47:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] hw/vmapple: XHCI controller's interrupt mapping
 workaround for macOS
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 thuth@redhat.com, zhao1.liu@intel.com, imammedo@redhat.com
References: <20241208191646.64857-1-phil@philjordan.eu>
 <20241208191646.64857-7-phil@philjordan.eu>
 <df6847f5-11d0-4c69-bfac-ec2281279841@daynix.com>
 <CAAibmn1sRa409YCPr6WQ1XmVBntkjh3EokKU1S6ywTwHMcV8xQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn1sRa409YCPr6WQ1XmVBntkjh3EokKU1S6ywTwHMcV8xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/12/09 20:14, Phil Dennis-Jordan wrote:
> 
> 
> On Mon, 9 Dec 2024 at 07:26, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2024/12/09 4:16, Phil Dennis-Jordan wrote:
>      > This change enables the new conditional interrupt mapping support
>      > property on the vmapple machine type's integrated XHCI controller.
>      > The macOS guest driver attempts to use event rings 1 and 2 on the
>     XHCI
>      > controller, despite there being only one (PCI pin) interrupt channel
>      > available. With conditional interrupt mapping enabled, the XHCI
>      > controller will only schedule events on interrupter 0 in PCI pin mode
>      > or when only a single MSI vector is active.
> 
>     I think docs/system/arm/vmapple.rst also needs to be updated.
> 
> 
> Can you be more specific about what you think I should include? That 
> file currently does not mention USB in any way, and if we set the new 
> property in the machine type, there shouldn't be any need for manual 
> configuration on the command line, should there?

I mistook the patch message for the documentation. The documentation 
file is fine so there is no need for change here.

