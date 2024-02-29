Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6871CC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhbz-00021a-EW; Thu, 29 Feb 2024 09:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfhbp-0001wn-N7
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:42:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfhbn-0001CO-VF
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:42:05 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412bf4030daso3920825e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 06:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709217721; x=1709822521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sGnB/M6ImQzemm+TfJxnssOOCp0gdRGdiUYG+dtEqtw=;
 b=SHW6StSaMAvgERhULpga5JEXwriWkTfp0C6Lxesef0dCGd+MUNRxb7YSrpcLsnmimy
 G2DGgF1NLUuuVCmmrDyMv1jZvMB0j2hxd4AHlcblRAZ1fjET42F29xp87MYw9Q9duk/m
 /dhtKv6uRQv1U7AM3T6/iyG6g02xEgv2wxeOO++aPEvJ2N/bAmX0KdDorxlNCwtQUxtr
 ODnFjuGTXIYTmQFR9lh+mEEHmGcCoh8kxqO6fSgumuzeX1/AuiCy/j+hD5txdoBqKS9K
 fWngkCxOlOddPaJPeA2QAchHwnWqh8NGbYwqaZJIo4F4ZapwD1IBFtJ+d3hO/tX66unS
 AFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709217721; x=1709822521;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sGnB/M6ImQzemm+TfJxnssOOCp0gdRGdiUYG+dtEqtw=;
 b=kLIvUHL62uQLfJ/9JCHqOU8nFUZkcsG47+Diqhli/jQ+SHrpQfLwrtMllNq6oWrl8f
 ymfROQAHOgRzNB+EBBas7oQ22URLvkCNsXCBE8hoUT7BuBQGGijhTtUz31yUvnFFHCX2
 3wmRVJWnuFpG9ykePyABa8fz+G2tINxZw9pcv9XbgRr7pntuFShxkbWFlkiP4Gb38doy
 IE4iD7Y1MtDNLDFLP5g+vBKxguyYQ6kQ+4/FvyjH/3gzRYKT1fTflhSmLoa2AuCER/0G
 vCXhGKDyTik5tEEmoElfW0l4SCkhecTPXwgPNAePEmWjPosz7zPeEzzlXhKTJiT8km9d
 4liw==
X-Gm-Message-State: AOJu0YwWevsF3iBpCESxEwKQHdl9XqwsjSzFH8wmNieQjcH8TxXwiVWw
 3Es3VELCKnF+gI5ESlS+7EN4OTHiwgg/uq4i8wx8+WulRMOxGwLI4EccsxfFjm4=
X-Google-Smtp-Source: AGHT+IHJcY60PphjanOwJSSQHJYsUKEGE2FwBLeGr5NCXw0UMVe5lrnru4CvjtVMIwyTHPHG5surzg==
X-Received: by 2002:a5d:6706:0:b0:33d:d9d4:9079 with SMTP id
 o6-20020a5d6706000000b0033dd9d49079mr1566759wru.9.1709217721445; 
 Thu, 29 Feb 2024 06:42:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e5-20020adff345000000b0033b278cf5fesm1925685wrp.102.2024.02.29.06.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:42:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BFB3D5F796;
 Thu, 29 Feb 2024 14:42:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 12/12] plugins: cleanup codepath for previous inline
 operation
In-Reply-To: <20240226091446.479436-13-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 26 Feb 2024 13:14:44 +0400")
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-13-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 14:42:00 +0000
Message-ID: <87v8678h8n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

