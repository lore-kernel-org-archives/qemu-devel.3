Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97968C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 06:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u37pI-0002i8-I5; Fri, 11 Apr 2025 02:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u37pG-0002hS-LZ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 02:25:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u37pF-0003Qd-0F
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 02:25:18 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227914acd20so22667315ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744352715; x=1744957515; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhLyNiR/8622TsR7oFs3Rr8+ELyjFah8S9Q+ttfQkAM=;
 b=EEmKcETFlBK6ilNtiR4B4U1/vl/tKbF3YhSSDxVr+Q/1bY7LKmNT2C2AEXWm0839hF
 Stc5p3vE7gE9GxlZlM/gyqYf40wOISGy5xhpPN7RA3IRsq+DaA69m5c5YlL8p/eyP39g
 sl/mt2RNPRzP9CiN0m9xBH6toOL2gKxtEZ51pJoEV5QCXGtF05KGdL1Rq/pwKW16yg3L
 UAx3SWImdfDZ92IUqvmwTQNbyjHNJps3nz7wiI8c2IlO40oj1gy6wfN34EWl1ch0VJSP
 LwGtFWb2NykdNeEgZcRRMUkR6lnfwWW9sWYD4PDTMXeNN5xBLGxBqa6cEG5iUK6Ommy7
 /4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744352715; x=1744957515;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DhLyNiR/8622TsR7oFs3Rr8+ELyjFah8S9Q+ttfQkAM=;
 b=dY6zxAzbA095RNAcplRyKji1GfeeAisB8LQ37p6WnwQDqmN2ollep3Ne3oARfxB48B
 6jEnIhwIXg9Zwt1xGJYBIvKNJECz0y3lrbb7AFR53LKpla/HPZDt8TNuxESThkhQmo0X
 aI0sYTbFsh4LfKHTlRboYk6dqqyJm0P4EcuA8rwkCMvx1+Cu1D9baTrS8FzufgMhy1oM
 8K+CdLRBJ8k2FSMxpJmPgqlZfLY+1FlOkYeGRMdde5MLSOkSJzLdoOQN6qJ2Ui5UiEIc
 k+EqLgZx2L16lJS46BobbE2+g6kNimWX9rYpVOeIvKZVE/1g3RkzZrlw8yHnbMZt4tky
 GysQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAHQcAbMAf9jC5CV8SVGhayqL9NTPbdBqXfqJBaSPfE413BzhsAAranPLj2K1uVjvtidiiEH/4hkRg@nongnu.org
X-Gm-Message-State: AOJu0Yy4ilEhYrgf9Wjpy5JesW7sVU6oz2RsWj8AWm8NTLVpB8APh4hM
 90Y68hFWU0usawv3yX2rdA7YLwFhT0FQXdzbFepNO+TzBJ8qaiJx
X-Gm-Gg: ASbGncvkCUM8K7aU4MBv5Q7EL1qulQmiQfn9dZ7UYUN6sc4pMKmiGXCk65o3RhcycdJ
 efwRcs0fCAajcwO99TCQOG1H607hN/BwMV89YKdQqU/skTUuT+3yS7WgXYcaL8T/IRqE158GZwg
 cNVu5xCnZ/EyziEvZ+ZGPemXTpRrKETKgGo+wKygxy2A+MOL4D0xVf+Cfm2iI3v3JWAZB2Fiae3
 JLvRqcxhE2NaKHhcKE8RN2EYXb6RaIGMwcGkQv9b8QHlHsAJlswO7RREDpRA5WAMVlje/lxmMxl
 0B0AyAVkJlOOscywwN7fo/Z+fdEzNNh0FA==
X-Google-Smtp-Source: AGHT+IEHMRI0KJW5Mq2EGFHVqttLqXMUU7Q469gx7vh4RhzfnY3pgL8HI8IxEyblT42DLJNDmgKflA==
X-Received: by 2002:a17:902:f54c:b0:215:ba2b:cd55 with SMTP id
 d9443c01a7336-22bea025382mr22850495ad.2.1744352715278; 
 Thu, 10 Apr 2025 23:25:15 -0700 (PDT)
Received: from localhost ([220.253.99.94]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm41151705ad.150.2025.04.10.23.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 23:25:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Apr 2025 16:25:10 +1000
Message-Id: <D93LFGHCQANR.1TFR56ESHUY1H@gmail.com>
Cc: "Corey Minyard" <minyard@acm.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 0/5] ipmi: bmc-sim improvements
From: "Nicholas Piggin" <npiggin@gmail.com>
To: <corey@minyard.net>
X-Mailer: aerc 0.19.0
References: <20250401140153.685523-1-npiggin@gmail.com>
 <Z-w75P6iav82W5Qr@mail.minyard.net>
In-Reply-To: <Z-w75P6iav82W5Qr@mail.minyard.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Wed Apr 2, 2025 at 5:17 AM AEST, Corey Minyard wrote:
> On Wed, Apr 02, 2025 at 12:01:47AM +1000, Nicholas Piggin wrote:
>> These little things came up when looking at behaviour of IPMI with
>> the bmc-sim implementation running the ppc powernv machine, and
>> trying to clean up error messages and missing features.
>
> This all looks good to me.  Thanks to Philippe for reviewing, too.
>
> I can give you an
>
> Acked-by: Corey Minyard <cminyard@mvista.com>
>
> if you are working on this for your own tree, or I can take it into
> mine.

Hey Corey,

Thanks for all the review, and sorry I missed your question...

I don't have anything further in my tree, I don't have an
immediate need for it, it was just tidying up a few errors
and warnings I noticed.

I'd be happy for you to take it in your tree and send it up
when it suits you.

Thanks,
Nick

