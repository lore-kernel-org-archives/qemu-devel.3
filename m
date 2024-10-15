Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC27CFC273
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0cfO-0003ni-Ty; Tue, 15 Oct 2024 04:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t0cfO-0003m0-6o
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:12:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t0cfM-0002nQ-OJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:12:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-430576ff251so44246885e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 01:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728979947; x=1729584747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2y6BpyVKdfa3ge7EeTwhwrkdAxRiY+TEyMANBCu0a0U=;
 b=wzTObh4+n7iTsnEFLYwdS75hAVWqlUeZ+7TsuER5uuGuCnEBuRTz50hzN8FT3gfzGI
 Pq2DAvyaRCiXLAfyVCDGpRh71n6Kde5b3TgOKyyiwPug44Hz2H3EvInpZxXe54QtyTQZ
 LAlbhZjbye7fJCXS/FLDoBq357vlJI67Lv6kQTjgLx5/8pEyYR7JPPQngxqMT820t19s
 Spud+oQhryBBtBieW2CHhHSjNzSSTEzzkNVILGs+HpTwgfNXEKsia6UZ9rqmPpZCV0TX
 uVXkd0fJ6zuHMTR0mGWAop5fbVte3d5tldKD/5gh+5/93ovTxJ66Y+o5zGsABioA5+O0
 soag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728979947; x=1729584747;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2y6BpyVKdfa3ge7EeTwhwrkdAxRiY+TEyMANBCu0a0U=;
 b=N885lr1qLcmlB9z3AP+z90WqQ+TSKyt/71sjMqCNRdGIFfnbB49w/oQtW+01cNiInB
 6Q36B2l8p885GSZgtWfQ2089p2331axyXp+DUh/jC1LZggjO/c6YbLxA7nHZc1GtySSL
 Q0pbeOltDIEpqzM4L4Y2Df7OoSnnLbsCd2ZRNA88zmTv2tEMVz02Jse//va3DbCdZgkt
 1QNJCAWW/u1y1I8TaKHWmxSpgF0ycdxeOMdXxaGmrBv8pL5jtGcbfYPxCns7c0elPJwk
 DXxvMpQTVsaTurgq1snLV1i2IZ7beMY/P7tdY3ZdDEx0dXuK5iq/rQbemfr+Dl+Eq/5O
 9Pqg==
X-Gm-Message-State: AOJu0YyBRZ3ReVykVdmMG2YXBCvN+NJuOhlHxmJ68ORRlfnhRn0XfHL6
 5BHE7ntOuHfP0WTxhmH7VzosrxnzyElsC7HHRo0nLxJV2NLKzTV7WPG1gKqdWsU=
X-Google-Smtp-Source: AGHT+IEoFPF+YOlYP6+hTWtgJ6ZyWLoPrG2jYOUX+86a7nKxv6k8EE50KIPTuvrFSSlDjmxLCYQzdA==
X-Received: by 2002:a05:600c:5705:b0:431:2b66:44f7 with SMTP id
 5b1f17b1804b1-4312b664514mr70252925e9.31.1728979946976; 
 Tue, 15 Oct 2024 01:12:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a173sm921416f8f.15.2024.10.15.01.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 01:12:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C38D5F753;
 Tue, 15 Oct 2024 09:12:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/3] include/exec: Improve probe_access_full{,_mmu}
 documentation
In-Reply-To: <20241013184733.1423747-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 13 Oct 2024 11:47:31 -0700")
References: <20241013184733.1423747-1-richard.henderson@linaro.org>
 <20241013184733.1423747-2-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 15 Oct 2024 09:12:25 +0100
Message-ID: <87o73laiom.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

