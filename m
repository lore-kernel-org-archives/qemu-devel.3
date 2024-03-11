Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FF2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhqU-0000yw-8U; Mon, 11 Mar 2024 11:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjhqM-0000yX-OY
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:45:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjhqJ-0000FR-Qm
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:45:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412f55695d1so32636695e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710171934; x=1710776734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cujt6V1A/XvR6NaGuI706u7cr0TAQ/6i6YLDHIasSDo=;
 b=fLDBiMH/QpSczE6QAnDvNAbIqa8NIIjXuDXFa2Xv6/vOUlRSs9Rr7cozNHQiicD/lP
 5KHsvp02Z2sGKSpdixeVE3ufEvzpZydWZhjPSCkSRoE9w67SQKA6DEPhJ/0IxYu7ymR7
 S6CNbXHD6TcxNH/gEV3l9TgcJ6R9MxnNbpDGt2xQMsToQ++Omq5WiTDl7NU1JKDZKWV9
 GJ3tNgnOWApbb1YuJMsSHVezJebrGmJGyU9YX07/2MvNPVTv9pqdEz4VCM2NHk26t1ib
 tp8zWlbHiAgXNpQAtFRwi5XtIEtIchSllYZAMbatTIToNpfZS6Ax2QK1OvNrtxb7UftP
 CHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710171934; x=1710776734;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cujt6V1A/XvR6NaGuI706u7cr0TAQ/6i6YLDHIasSDo=;
 b=RXUlvxD6A0c5/Pu8NJ1aBNQNJqCzUxVOcBniozo274mB2gk96xPE83O87GyHfBbCqz
 /cgA7q6PrZ4poKSMdK9v9Xpfgzt8hpIAStaKFwdqMsfm4gID4uFiAsuo10zahkCrl76e
 JtLPZefBCOs7xW+9ufanNCtSQHxZt02lYCYkcgjCthO6EsJC9WqN5CwLpJSZuy58l9td
 HYKf3JnEemrMWs9+vkgEXBeTWvG8NIMJbp/F+skihI4Jh/2ZqqgPpoNDd4vMxJ6AAurE
 JzmuJph7OVb/4DQUYN+4arM17Av53BAiLsrX/bdliEM7asLBq2VzGlMT89YhzKePBs8G
 oIHw==
X-Gm-Message-State: AOJu0YybUHyi1525H8dcvURuREMzWI/E4XNxQtjLASdi+Jdn5o8uStBx
 duLN9iX6v8tr9Wroe5bZUrITadXe/u1AHkRro3FB0lGqgkF1WjJanwUz65g58eNBohCcL2Qur8J
 P
X-Google-Smtp-Source: AGHT+IEX+ao8TTZ2HndQFfIhbB6OIpJgilxWL4O0pNrIBIufbfWXmQBeEQHKDyMjBl6c+k7PzABLlQ==
X-Received: by 2002:a05:600c:45cb:b0:412:d0ab:a34a with SMTP id
 s11-20020a05600c45cb00b00412d0aba34amr5079478wmo.31.1710171934179; 
 Mon, 11 Mar 2024 08:45:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bg13-20020a05600c3c8d00b00412fe0eb806sm15993561wmb.14.2024.03.11.08.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 08:45:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8447F5F756;
 Mon, 11 Mar 2024 15:45:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  laurent@vivier.eu,  philmd@linaro.org
Subject: Re: [PATCH v3 0/5] Add stub to handle Xfer:siginfo:read query
In-Reply-To: <20240309030901.1726211-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Sat, 9 Mar 2024 03:08:56 +0000")
References: <20240309030901.1726211-1-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 11 Mar 2024 15:45:33 +0000
Message-ID: <87ttlcpyaq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Xfer:siginfo:read query is received, usually, when GDB catches a signal
> and needs additional info about it, like the si_code and the si_addr, so
> GDB can show the user interesting info about the signal. This query can
> also be received when an user explicitly asks for more information via
> printing GBD's special purpose variable '$_siginfo'.

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

