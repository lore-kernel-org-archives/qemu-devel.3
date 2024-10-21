Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52621D0E6C9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2np0-0006e1-Vj; Mon, 21 Oct 2024 04:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2noi-0006cY-3o
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:31:08 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2nog-000520-0w
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:31:07 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539f7606199so4483035e87.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729499463; x=1730104263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSase5F8Se/7lv486orJ9GQ0ZYi2ta33Ui1zZEod1lY=;
 b=zOpYkzfdlFp0jlNV0nFSV2UvxN4KaGziwoT0LD+4II8qj6xQVk30PZ+MAp7gc7YgZ4
 /HjrdGNLz+q4OCdFfZzFQ9FZVZo1iRfvAeuIwdTJAJpnurXxtlyHSlbpvdHZZQ2Nk97X
 EiH+Q16O3jLGocHyOa7i/b7hg+8CrEb9mDMT9OHZ8o3STjWkfiZ0W8vtGnkFXxyBVrt/
 H1jou3GTDXDuWTfRwDFeJOldjLLaHl1hdmWNQBpSTGRPfG56w1BINt4jAot9X1J1x0fe
 EOkMuvwS2wv8vIr7vZOlWzMzF/OiXsuUvbY3kgeNa/yFbcb8FV3g+FChwpGUpr4gp8OS
 E89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729499463; x=1730104263;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uSase5F8Se/7lv486orJ9GQ0ZYi2ta33Ui1zZEod1lY=;
 b=CUN78Y5hcDsuUKchBLKbP7sSJ2AbV1gG6we2fokPPx8G5lb1gEmNa7lvAvALnwaVmd
 q9IlVLL9h+gglluV0KBRvE4ihfNLpI4mgdrM8Z940JtZgI+BZ53dqDH7m+x8le40lamU
 m1f2I/YN8+x+c1RZ84cxf3L5pIgRX840JaxA10FMSkZCnSb2ASO9K5GkSm2VBR8iMiJg
 xdKzOzZ3MxVtEI28L/0utNyiVW0P2BKhAAiBxnZGDNV0VhOgYcuFbRSX1unH99RVdYXu
 7rlI5r5HSWd7b3YZ6dbhS7n9MeSknG6wV2Dyi/lery55faiWcnc7g3fVsETY0aJTolHo
 x6Fw==
X-Gm-Message-State: AOJu0YwzRumuBj4Ur+rr++cwExl9ZxRBNQV1fk/1lpZexNbfmGgQ2MK9
 zXxVPGtru8XEawoOLu1HmgjpsnOAaCFR4XlpsrwgLp3/+Odf3Z4VAYyZ9/8efWaNqjRt+dU5rf9
 v
X-Google-Smtp-Source: AGHT+IHsLB8lmAUTiSJrE/sEB8DeJzMa/8JTXq7XOPiCOlmJEqIof62waP3w8f4UA3ptHBfJWSihSQ==
X-Received: by 2002:a05:6512:39d0:b0:539:8c02:64d5 with SMTP id
 2adb3069b0e04-53a15229e78mr4584584e87.27.1729499462069; 
 Mon, 21 Oct 2024 01:31:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d0e7sm1767248a12.51.2024.10.21.01.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:31:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A7EBD5F8B9;
 Mon, 21 Oct 2024 09:31:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] testing: Enhance gdb probe script
In-Reply-To: <20241015145848.387281-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Tue, 15 Oct 2024 14:58:48 +0000")
References: <20241015145848.387281-1-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 21 Oct 2024 09:31:00 +0100
Message-ID: <874j55q2m3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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

> Use list and set comprehension to simplify code. Also, gently handle
> invalid gdb filenames.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

