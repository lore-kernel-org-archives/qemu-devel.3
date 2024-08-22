Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64738C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 05:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh0cq-0001IC-5q; Thu, 22 Aug 2024 01:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sgvGK-00004r-4p
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 20:01:13 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sgvGD-0007eH-PK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 20:01:11 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39d3872e542so1095685ab.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724284864; x=1724889664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rniunWcptbIXXKNuJm7p8500w/SrEx/HWbj0BosbAcs=;
 b=f0isbYF/k1yZndhnqcZRiNWewafNhmC9A2t5KVaXAgZafd51yfBKr3yPILoWka6zzD
 hIDiaa+wJzPpIZzEORZ5ftl8t7Euj7BuU6zZ+pb54ZRzmU10rNniNiCpe+30he12cRF2
 BOYJ9LiOiJZms4up2SuEhurT9KC/4Qkg1Lp/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724284864; x=1724889664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rniunWcptbIXXKNuJm7p8500w/SrEx/HWbj0BosbAcs=;
 b=toW5HsqRjShY6roLLDi0IgnUeFc94WbiVOsqeUYpJ9rNQ2tWYy9U/YtPYRGhPo+qsA
 /cbxAeRCdXPIdbCMx5JcrGi0EJwg1465spUW9JMwT2d9z/MDuj9sDIsw/MYd6gDO8SJE
 hPIVkRmD533wLOt3jkqjl7R361/9Sk/v7aDTL8kzTIU3xSiMtsvSuiGkwXxIMqnwtoq2
 QiuyK7afN0I0JYLt55yikXUGPSruKKk+c6NMMmt1ANpqum6szxKREKLKltH0G1qf/gqo
 HKh/TAJLqp7p5QKzc3uzosvh/j4mwQk8+hTVirDAaJxaKyy7aB3bnU7rUb61oTQ3nH4S
 ogRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIfJ3A+dSJ2NUp7YirqtxGCKXct1TxHMbXyHRfjfXEUP6BkzbV7qWXD+rYk6Ds0B5IG2L6Jj08K5Bg@nongnu.org
X-Gm-Message-State: AOJu0YwuUtFZo6A5jLXOvpJy8anKUvaH5UGe4ncgoRHgq9io8SDazQls
 RU7jiw/RLwtvAvjGZDAT0cBmv+kN9j8YJbiKzmfVzdaMQ5F42ufIk29NQydAFD4=
X-Google-Smtp-Source: AGHT+IG/kLRWv3KV7VTc4yGrqCaDbrIx4SE7Rw+CThIVIJh/V6LmyQnIpjSHVU8pDwOLI9S5XY7rFw==
X-Received: by 2002:a05:6e02:1807:b0:39d:2ced:e3ee with SMTP id
 e9e14a558f8ab-39d6c378e0emr52754365ab.8.1724284862979; 
 Wed, 21 Aug 2024 17:01:02 -0700 (PDT)
Received: from [192.168.1.33] ([50.37.200.153])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-7cd9ad6e8e9sm143665a12.86.2024.08.21.17.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 17:01:02 -0700 (PDT)
Message-ID: <fdce5258-59f7-486c-bfd1-a4befdf72e3e@schmorgal.com>
Date: Wed, 21 Aug 2024 17:01:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20240816163504.789393-1-doug@schmorgal.com>
 <20240816163504.789393-3-doug@schmorgal.com>
 <202408210857.20254.pisa@fel.cvut.cz>
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
In-Reply-To: <202408210857.20254.pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=doug@schmorgal.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 Aug 2024 01:44:43 -0400
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

Hi Pavel,

(Dropping Vikram from the email chain; I received "recipient not found"
errors from AMD's mail servers in response to all of my patches)

On 8/20/2024 11:57 PM, Pavel Pisa wrote:
> Hello Doug Brown,
> 
> On Friday 16 of August 2024 18:35:02 Doug Brown wrote:
>> -        if (frame->flags == QEMU_CAN_FRMF_TYPE_FD) {
>> +        if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
> 
> Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> That is a great catch, I have overlooked this in previous
> review of the Xilinx code.

Thank you for reviewing!

> When I look into hw/net/can/xlnx-versal-canfd.c functions
> regs2frame and store_rx_sequential then I see missing
> handling of flags QEMU_CAN_FRMF_ESI and QEMU_CAN_FRMF_BRS.

Nice find. It looks like it would be pretty straightforward to add
support for those flags. As far as I can tell they map directly to
register bits.

> In the function regs2frame is missing even initialization
> of frame->flags = 0 at the start, which I expect should be there.
> The
>   frame->flags = QEMU_CAN_FRMF_TYPE_FD;
> should be then
>   frame->flags |= QEMU_CAN_FRMF_TYPE_FD;

You're absolutely right. It looks like frame->flags isn't being
initialized at all when it's a non-FD frame. I can also take care of
this. I'll wait and see how the review goes for the other patches, and I
can add another patch to fix these flag issues in the next version of
the series.

> As for the DLC conversion, there are functions
> 
>   frame->can_dlc = can_dlc2len(xxxx)
>   XXX = can_len2dlc(frame->can_dlc);
> 
> provided by net/can/can_core.c

Nice! It seems like using these functions could simplify this code quite
a bit, by eliminating the need for canfd_dlc_array. I can add this as
another patch for the next version.

> I am not sure how much competent I am for the rest of the patches,
> because I do not know XilinX IP core so well. Review by Vikram Garhwal
> or somebody else from AMD/XilinX is more valueable there.
> But I can add my ACK there based on rough overview.
Thanks! I also see that Francisco reviewed a couple of the patches --
thanks Francisco! I will wait and see how review goes on the others.

For what it's worth, I was stress testing this in QEMU today and found
another issue with the FIFO read_index and store_index calculations and
the logic that wraps them around to 0. I will submit the fix for this
problem as another patch in the next version of the series (or a new
series if that's more convenient).

Doug

