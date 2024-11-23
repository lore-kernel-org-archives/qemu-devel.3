Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF0AD75E5C
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 17:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEtfb-0004uV-SH; Sat, 23 Nov 2024 12:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tEtfa-0004uI-KS
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 12:11:42 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tEtfZ-0003az-8n
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 12:11:42 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38232cebb0cso2429232f8f.1
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 09:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732381899; x=1732986699; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wzpqO62uWZlCUePwlDZJYuyp2WHS5Oin/YQQaFhnDew=;
 b=Zke5yziY0pf/VKJkd8lgb2tqvIYD8u3pJdh8ArA5tYYOD9K3x+6r/IU48IxbVo5196
 VgWSw/+TIu8ek09OmjCH4tJayMRwZBYtuarjgGSD1G6wSzqTHG4hhVoTggCi+xMeV47Q
 EMOX6Bw7p14qy2NJxG9DAkrs0jrVJvEMWiZw2oemqnx9gIl4QDSx9AoRoXCvX9XvVDoY
 9dhBBd+2TovYe5FK0M/7hQmsn994t0zBj2+oh7iY7GHjR66wcYn7yyZDGYZ0Fai6JPi/
 Q90Gcpc+/8CSmaXLYNFdd7vPnef6/BZa9LGw7+0aT3XDg+WwyKhOSSVFa91sbcDu+UoG
 0gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732381899; x=1732986699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzpqO62uWZlCUePwlDZJYuyp2WHS5Oin/YQQaFhnDew=;
 b=pfM1BxatpDjHsNkyZvE0Gy6FpXBBhWhGeJJBeCq692Npr15z06lO57WQg7m+YyxLcz
 28PA9hcRfJp77kxtOwPJCeql9qhEdJnC4uYjeNY/kAzTEp4X8ClO/lvgpSo811dl8xk0
 0WAD3TBwrBco3uOFwa/Me0IOL0FZReXpUI5epwEUikVeqqd78j67hn5+rrcMuiNhJTzr
 oucnzrcgt3+88xKMWtp2mbOC0cWuAfIEbE7FcvvWD7mftSE5s11eRrV1IWEqAyADY+I8
 CrB1j3KsC5T6kKo71Lfk+RDIWwCfHx6fMrpiTI55rlAWzG2suMNnnxRQrEOZiQFn3CP3
 Hqmg==
X-Gm-Message-State: AOJu0Yxn75JdQNp1I5OGePznysnnM/a2sSS/ZHiawLw2zbL9+Xi79kKK
 ma41nxNYf7YohDaIzaMPQnF9XfWmMm0zT8aTNc0sTe2rm23MNgsUInGixQ==
X-Gm-Gg: ASbGncsf9h0qIIEAujFeyRt4RbFhy9MNkKoeqrMNVcS1NSA1vqe7GBxW+QyqHTXHrx3
 t5tcUp17HLb4q+1tJtmns4uF6NEs7ffkNXoMZE9yIyB5pAiq/b0ClI9dtZpgFgXzwilRlW78TT7
 8HGtg4RemqWPsPoTiFCnDv5kzXldg4x3HKB25vPd2oXqmS7oFQe1DHOiRhgY/mFygoU9i0XmvpL
 G/GXOL4C5J65hhu4cBgfasOKWUYt9C2aVH8glYetSrpuo3VucWt02zxldm2TjJrv9oKLGTKV15R
 t/38N2aAKl97/A==
X-Google-Smtp-Source: AGHT+IFwxG2JZc/N0+dMquV3c4ePMiNqmvP/wHSHL1mMWJKSDppxEwTodQoPfLwgbdlZm8NT9eddJg==
X-Received: by 2002:a05:6000:2807:b0:382:45c9:e34f with SMTP id
 ffacd0b85a97d-38260b59713mr4185605f8f.18.1732381899332; 
 Sat, 23 Nov 2024 09:11:39 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde070easm65926565e9.5.2024.11.23.09.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 09:11:38 -0800 (PST)
Date: Sat, 23 Nov 2024 17:11:37 +0000
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] hw/openrisc: Fixed undercounting of TTCR in
 continuous mode
Message-ID: <Z0IMyRB3O4Q9s5eG@antec>
References: <20241123103828.3157128-1-shorne@gmail.com>
 <20241123103828.3157128-3-shorne@gmail.com>
 <0105f2c1-9390-4557-bfad-668a328ce951@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0105f2c1-9390-4557-bfad-668a328ce951@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x433.google.com
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

On Sat, Nov 23, 2024 at 07:39:57AM -0600, Richard Henderson wrote:
> On 11/23/24 04:38, Stafford Horne wrote:
> > +    or1k_timer->ttcr = or1k_timer->ttcr_offset +
> > +        (now - or1k_timer->clk_offset + TIMER_PERIOD - 1) / TIMER_PERIOD;
> 
> Better using DIV_ROUND_UP.

Sure, I can change it to that.

> > +        /* Zero the count by applying a negative offset to the counter */
> > +        or1k_timer->ttcr_offset += UINT32_MAX - (cpu->env.ttmr & TTMR_TP);
> 
> Since UINT32_MAX is -1 in this context, this appears to be off-by-one.
> I think -(ttmr & mask) alone is correct.

Thanks, I did send a mail to Joel asking about this bit.  He didn't respond for 2
weeks to I just sent the patch as is as it appears to work.  As I understand,
yes UINT32_MAX is just -1.  But why the -1?  I guess it's because after
ttcr_offset is updated we call cpu_openrisc_timer_update() which calls
cpu_openrisc_count_update() to update ttcr.  Since a few _ns would have passed
and we are rounding up it will update ttcr to 0.

But maybe I am reading too much into it.

If you think that makes sense I could add a comment as such, also I would prefer
to change to UINT32_MAX to -1.

-Stafford

