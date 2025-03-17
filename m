Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C34C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 20:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGpj-0005Ye-Oc; Mon, 17 Mar 2025 16:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGpd-0005Xe-8y
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:13:07 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGpb-00011T-2l
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 16:13:04 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6df83fd01cbso20241856d6.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742242381; x=1742847181; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RYlKK4TVUaNiK4526sdI7MFM49mXZ5BcBHKzJhx2g1s=;
 b=Y6DJcjRjoVLo6UkzOR0Tcc6UqyfH664+BdnptygH/2OwkL4XptouYe+DMSbZDm6ZqT
 Gj1nHBhnkXK4Km05rU1soc6QCKwXgEyq0bV0xLuzPZomzkTUnemgH9/BjwXcSfUvdxH5
 +n311QtO7n0Sm0oODRqhLwKk5mVAzFZlqts0pmPRW74OrB2Pr/ss9av0vtvBd1M22DSC
 D0RjshiPnVoJYRl4flNT9FRT/94NOKvvjdVlXPUDrb54ubCRocaaj40e0J3X0fgoyrUs
 1oGYw1qHsB0UBbglZwoXelllqiODK2+n0Z41c/gbire2BbU4Z3WZktcc+9/owIHje5y3
 JgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742242381; x=1742847181;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RYlKK4TVUaNiK4526sdI7MFM49mXZ5BcBHKzJhx2g1s=;
 b=rhjqYkLamPbcjTxg3TH/b1ubN2Hd8n/TdoRlyws0WEM3ic78YTC/Zau6PHU8EL6Dlb
 U9qTft5IVQ4ojCussutUId4DyT0XZ949IhG5k7xybYVnOeVoQ3FWDJ1wl2CZ6fSfjdrX
 7fyNfOJaoxRYgOq/LKZUBcnI27U5MrF+b9KkfxaKAJuEsk/R2QYWyPLQzp24gBkfzOpX
 um1bzjin69rvCYpT3zlDaeBSqjlWFNfpe9c73XXNIUbcDYRTpGeFPTgNZZQKJo+x5jNp
 oaOVQqe7hLofhiUKY5NL21d86Tuls0nds2EB7PMhKjzar/r0krtT8VA1AtkwmPplR8rQ
 cKYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW78s4z3XkQhuvKC8iDoJIZHyyLhNzlsGXaMv2po2ZJngB8mbBwS34YT7ug3AKPPyZlVq628BpASyIG@nongnu.org
X-Gm-Message-State: AOJu0Yx0bUvYqDNqaBI/li3FMyDUHPOTg39zdX+CyYM5kwrwiIhnRm6t
 YKVbwHwXU6eC/JbnutpaDER0qHHZGzU5Sb4tOf51VazaKGPKvSL8nJwQyuqiHkc=
X-Gm-Gg: ASbGnctxZGMlyFxcP7jwrDZsXR6VXqpWbMuHbdr9U3CnlBkBiQuIaQSg1J+eCXh3tz0
 0EUCPlsJ/60/rMd51VFE9sSztwgFaTlUQc7uAI/yWyxrlgOHkAJO24xHjYVOGzZJXKu3xlMOtES
 KZ0n1ui3YDVDgUKv/q8E/OfkK2OudUTjOsLDOquSqHWP99r8kpfL6QbTSXZ6q5luAGN2VieWNI9
 rEcHo8KNymn6DvOfpB3tzQhEvwK00BSP82307LvVuf/DpifrxUSctXGPuCSGqyof495pKlAnQ5/
 U1bt+ZUHYiX/VTOtuPkMebk9gXZsg7zxXUY3vZVbM8TLI0JYk8uS/VBDm/5nXYY=
X-Google-Smtp-Source: AGHT+IFNbLbXHBz3ulLq446mRQ/SjLJz4Opv+73wo2c+G74I+BPQ8cvU++SooaAE/1YZQJbuvcYyow==
X-Received: by 2002:a05:6214:21ab:b0:6e8:98c0:e546 with SMTP id
 6a1803df08f44-6eaeaaaa50emr153916196d6.29.1742242381581; 
 Mon, 17 Mar 2025 13:13:01 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade24e94csm58813806d6.60.2025.03.17.13.13.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 13:13:01 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-29-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-29-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 28/39] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Mon, 17 Mar 2025 15:12:59 -0500
Message-ID: <018a01db9778$fb8f64f0$f2ae2ed0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQHahjMqsvN3x8A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2c.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 28/39] target/hexagon: Implement modify_ssr, resched,
> pending_interrupt
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


