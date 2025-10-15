Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037E0CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 19:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96vg-0004on-4T; Wed, 15 Oct 2025 15:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v96vb-0004oM-Gg
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:12:51 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v96vQ-0007O7-Rd
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 15:12:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-29094f23f56so3655395ad.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 12:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760555548; x=1761160348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=73MYHVx+jfHoKjkMckgZ+fBsKFe5Mk96joQl5wCAOWk=;
 b=ucFj1Dvb+ElZCzoe14GUr1P2b6qp1eW2hmU37ixVACXCbTwRfkrMqLF8JdIKqSwTXx
 Wn2cjZD5G/rd4+a3dii1rbpnMiIPdn+Mj8AXabH587VMEhpL8J5kU9cBEioIXTtg43Qn
 ZV8rXMhLabgScWWS9R1bDaPFlnD3P9tuTj/HTJVv+o8OSEkN1hZ4vglHhZCQWusEMRwj
 bux1Or72xitPfguZ6i2Uh1AAcdz307dyaMFs1eCjAK799xk+CltHPcKXkhdrEokN/Itt
 USzCprbvfqnpPaVqnEtXzSl66kG2fh64OYLeZmB+H0kGh8SL2AH/U6F0deil5FzL9SQg
 +BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760555548; x=1761160348;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=73MYHVx+jfHoKjkMckgZ+fBsKFe5Mk96joQl5wCAOWk=;
 b=kvKMJZLpIt+Q+Atpq1d5BPesSMavtg2tJDWPUteTY6BK4isxfw5+mYSTs26K72fouS
 TdURvDAkpFbV7x08tdLmExzN25nxDCyEDDRKWRvqxWn74TpwIO68t6FyY0WpPjSoQpqb
 qkPf/JPvV6RWTTKGLmVKpswzlHOzPsnRVm7iw6WM1A443sDHTU61+R/MHbFPuco9z7FN
 7qY3EgLz87KNnvP6wB3ZAdTZ5ZWgJVar9qF6Vsh3w/ZGbqlFmNEq9q8TWNcaUwj3/leA
 toLGf2a2wuxXNu1nrnLlfGDmtHXllFPQrSOTxy4EOYv1s0XCatzDtFEFdVHmOo1+V9cc
 wGxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFTSirnLKqfCT0NXS5ZWM11Y6isOUpM/46HHQfJKxlkoSibyD5RvYtw0bvqX9nPvbOx3e/SGfppyF2@nongnu.org
X-Gm-Message-State: AOJu0Yz70Gp3tyY7N5lhSn3dKEsiklnzUJaEdfmIMRLE9kMF0MYnLx3a
 uFfqojSXS5YbSERtJG9eItMe3043JE+MQ80qewt5u7EKc3gBG0DGpc9TRNiy8xXoGQfycr8ackR
 4pylf
X-Gm-Gg: ASbGnctYdfe8uH0mf+z8KN0KTln1evcgY40vT9BaGVuc5oegGru5QdYhJhRJZfv/lVf
 S4f7fcqN1tX0YsTMd5vpbdFgtkc+L3V7cRp6VeWJoReymYQUTMm3ZEH4/h66hQ2WBF6+tBy3wkZ
 E67L+jby1m9LDZA8U8ZLfUuHDT5LbgwrWZlIJlbFr9sH/tz9rfMwuvhd7ZwTf7e/XW7oYi3dJkx
 KXOshvW0TuWsXiW/4an2JVyrgO2ixhwGuvqz+nD90Bf3cnSahqJZstNkod4ssYv/xqPvd3njL8F
 2Cte3K4hks8y+Pu2ZqB1VDQIVaSJr5hZpcGOhwaV0/d6Fow/OR9/6f1b00vo7P34e1YLSvC8FeM
 CtByS342/XnrCkws+SwV/CQyMQf8iC9ziqzxO2RwcslNkx2vG3Eo6v3XYyFnqemw/G1pjiSLAif
 A3UGCTxQZHyh4oVSoTMnKYKqN/StUWMiH0w46Tyg==
X-Google-Smtp-Source: AGHT+IFNuPB2qvAul42x6Q1tKnezuvS4mOWmd86tR7U7NhFumyLLBGV3nByGveaiiT8kJQ9ERi91yA==
X-Received: by 2002:a17:902:f64f:b0:28e:a70f:e882 with SMTP id
 d9443c01a7336-29027215bc9mr377581375ad.11.1760555548470; 
 Wed, 15 Oct 2025 12:12:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099aba3fcsm3793955ad.99.2025.10.15.12.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 12:12:28 -0700 (PDT)
Message-ID: <e5f2f9f8-b333-47e4-b48f-36740565dbac@linaro.org>
Date: Wed, 15 Oct 2025 12:12:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/34] target/riscv: Bugfix make bit 62 read-only 0 for
 sireg* cfg CSR read
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-6-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251014203512.26282-6-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/14/25 1:34 PM, Anton Johansson wrote:
> According to version 20250508 of the privileged specification, a read of
> cyclecfg or instretcfg through sireg* should make the MINH bit
> read-only 0, currently bit 30 is zeroed.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/csr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


