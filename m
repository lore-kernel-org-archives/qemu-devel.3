Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C860CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 11:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqUy7-0002eR-H9; Mon, 25 Aug 2025 07:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqUxs-0002WC-G6
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:02:16 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqUxm-0001e4-Jf
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:02:14 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-55f3dcb2b9fso1366352e87.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756119726; x=1756724526; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjdAeL7RTuKpBxor0GNtJ1RitBuids5FYyq5bPM94ys=;
 b=lhx2Aaqbwd7aqCf37L3+3GVXOa+slmfl/8B6UnzjRIIpPkeT1kIohaz7npDotOndd8
 yC5XefzO2uSIGkJSDTO8Ek+Srac3FcHqFxPiSGo03dor4D/KmKPD5kQ+B1NHUBrGgGk2
 wbplwftLZ2oAdXfDiae0wVeTN93ssb+DgskbSY+sjmliGvpPA4hLOgaYkJioTGR7Z9SV
 ZfVy88dvwn/7PKY8Z8agg1Uj+6isUF3dfe5L+GkCcOzTZIntH49E63vkhHupI9rTv3zf
 VEy2wTs7ggzFwfujyOi+KHbC1djK61B1DfjmL1VwJoaxYzZ68W9buO4DFbWrUQih6KHh
 bEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756119726; x=1756724526;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjdAeL7RTuKpBxor0GNtJ1RitBuids5FYyq5bPM94ys=;
 b=fs55MaYfhz4B0eXw7R2hD8QXB715otgOwV+yh3Vtm9vI7fnQgQuiSsKNOLia7MOy/5
 1NZN3TI4MwYy6jE7vt7QtKd0l6hs8/XIdxQO+MAo3Idr6+dX4J2R3ozbEAXhK8aiMn/A
 FnQ9JcgbT2iEr6MrrFCTLH2TSO/+oOKwjoJ5z67TxSUyAgBoxbqqmzhKOpndw3Wj2ARM
 RVX4Vjh78CKT3DmIxXlZi4zJF/A2W+MqzE1Xvi8CjL7ORhDcM/vjXTq2yLL/W6OOup6F
 tZTV4ki06VTjKFnWE2wvI9HSuWmpC0w+xDkCWlFMDtbLe+OXfVEvMfyDb8qSUAOK10PR
 zVQQ==
X-Gm-Message-State: AOJu0YwHUNrh9cMi8+4dCw9kt34co99rbYoU/mB9zcYwzuqOlUMG0zAS
 T8od08t5fxADKYIRVm8UQS4laepjUduniJcU/fVtyDhkPT303oe3iyza
X-Gm-Gg: ASbGncsURpgoQopJrMw31iHX89i1Zss/FTFBqBdWUDcl7uw9CZRBB2jUILvOMSNhBhl
 DNu7akegIi67Mux2JH8zjqwxqOwsQYxbv3W5ggEfehKUxZIjst7r+ULxwpCCU1418q7b3pfPOTB
 jZFAh9WpBdgHbhVnx/ZQdQsUNQQs72Foyp+i/6Hhd4ht3MH2aA3NpSlQfInInS8YPxsa6ogvCW2
 l6BEQZ5wmTx2zRUN5qrIvdfqaJM13+yjU6Jp2sY3GNCmvLvORU07AgMxZDOAZ84nB+OOow5ajyO
 NENgPoWiDZAmGQZ8OFovLppmF177NcDO41ADCxcHnhaLcPv84zutyG4z+RyZOsttBhZ5EfmtECA
 7USi+ZUXE1LmcFVJOo5v8mc+WRMGdz3yHlhsJC6KlqWjntykEuU0gmT2qfhDZDlmGVudASg==
X-Google-Smtp-Source: AGHT+IFpYYCqmjxnTQKr7DpdGO4/w693+lIN/lofxavaPwXAJ1rhMj6NF71dHEwyIXUjjav4gkea4g==
X-Received: by 2002:a05:6512:1412:b0:55f:4ac2:a59a with SMTP id
 2adb3069b0e04-55f4ac2bd3amr94529e87.22.1756119725613; 
 Mon, 25 Aug 2025 04:02:05 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35c8bce3sm1583819e87.95.2025.08.25.04.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 04:02:05 -0700 (PDT)
Date: Mon, 25 Aug 2025 13:02:04 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, edgar.iglesias@amd.com
Subject: Re: [PATCH v1 3/4] target/microblaze: Break out raise_divzero()
Message-ID: <aKxCrEWclYHaHYCI@zapote>
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
 <20250824222734.4151956-4-edgar.iglesias@gmail.com>
 <84378f52-2fc1-4079-ae80-d034defb1411@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84378f52-2fc1-4079-ae80-d034defb1411@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12e.google.com
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

On Mon, Aug 25, 2025 at 09:36:44AM +1000, Richard Henderson wrote:
> On 8/25/25 08:27, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > Break out raise_divzero(). No functional change.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >   target/microblaze/op_helper.c | 30 ++++++++++++++----------------
> >   1 file changed, 14 insertions(+), 16 deletions(-)
> 
> You could usefully squash this with the previous.  It obviates the b ->
> divisor rename, and it perhaps clarifies why you don't like using "ra" in
> two different contexts.

Yes, that was what prompted me to rename ra in the first place.

I'll squash this with the former patch and rename pc to unwind_pc,
keeping your RB tag. Let me know if that wasn't your intention.

Cheers,
Edgar


> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~

