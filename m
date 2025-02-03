Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC3AC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 11:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teuxn-0000WM-81; Mon, 03 Feb 2025 06:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teuxl-0000W3-Lc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:50:01 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teuxk-0008Gz-28
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:50:01 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab2b29dfc65so706723566b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738583398; x=1739188198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KG7enp3IxYqZ5FSfAGIlJwUrowOLXXUsk2++GaceebM=;
 b=uRCJaW7TSneYlFV22G9+uiIew/eWnSbndMShe3lclHO7Uzt4IcsxsydeCLetNYnaM1
 MbmU2uOAByRrMunYhcCkCq9tsh4V+cxuXsZEYst6fXfwhiZjZfpwoUxF7kQYQPRSvCcb
 OsQWmJuW08O1CVZoXzmnPws4VqMafB9jUvMRFe8NxWDNOsmV79vte9UjtaME+ZrIhWgX
 WxVKVZNmF7lfxCSPmv0wBU1emdwTZiaGnSSIgNapX+ndZ4kBQo2Dnk8vwAGR8YFCXBTc
 6W5DQ4kA4PKbD7MckMfdEIcWM3HB65/hubMh07UbBiv3MMVG8pjk5PB0Z764LrfcjLDq
 Akag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738583398; x=1739188198;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KG7enp3IxYqZ5FSfAGIlJwUrowOLXXUsk2++GaceebM=;
 b=XGS5v8+Qdh5O0/vx9cKh4WbrR2ZR52V5a01iVfo2ij1JcFbGnNgSBowyBRAyPB2OrQ
 3iDlhdKgGO3QdYoM/u3gItBIseFuq1choIU7JAHCJTxDWYxo612Lv75VaFPU1JgJpjEJ
 OQN0Kh9szYV557tCqDQXV9dKMHuPTg3itu16UNZ6QSDqvRhf3X5867QbSoYw46ZRNmVv
 vr/rHzeFTfFCkw7hGcbvnGGIgy2XNV7GrYkyynrupeq1iiU0RZkmUN2oAC45U8NIC/2n
 oBTo3vxRYaxnyzEFpyCbKvxF6jK4WQpHuLK2I8nMQGey4Gyg1t6iSR2qlaU6cSX2wJTb
 t/TQ==
X-Gm-Message-State: AOJu0Yyi4r9URr/v/unL9+8GvYxwe49y2c6KgZF0I4/31ys7xCDXC186
 LIeXCDe7utwLKE6o2Juz7GWIqA7mMT8pDUJ3SMljsymFfYJv4wL4hbdGUEN5mr9KdDxqwQrsv7S
 tHJo=
X-Gm-Gg: ASbGncsbmniK/HxOsfAuXLPXA8IGnxdfQcLkW52L3AbvE5aOShZAgm1nYjZV5X6K7AS
 cjO7UV+HiwX7Igz7U5r+H456d5YwaVP5ahaMZini3PR82Lyegv1f8+cp0Lbzjo8SkoUnRU9/u2R
 3RKE/g7NwK6yrgCIxhHeZhOHYidxJtcnRJwTWxvQLytFjjOnYL41huKmbyNkESP7b2CA7wZbTjX
 7WwIRcoJIIO0z4S5V1+YkTOd1xDn1/2PhXKtuOIKCYM0kVZdmlLrtZjcq94I/K16d3SrWIE5ifC
 qcktDXzqvjvthr6qaA==
X-Google-Smtp-Source: AGHT+IHPv804kPwmnZAFjs0580NNn07kfDP6CTpR53ryib565RhPHGr4p6uwOv9WJC5OM3uz10gdpw==
X-Received: by 2002:a17:906:c143:b0:aa6:841a:dff0 with SMTP id
 a640c23a62f3a-ab6cfd09734mr2505484466b.32.1738583398348; 
 Mon, 03 Feb 2025 03:49:58 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47cf48esm746251066b.50.2025.02.03.03.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:49:57 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B5195F8BF;
 Mon,  3 Feb 2025 11:49:57 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 06/14] plugins: Link only when required in system mode
In-Reply-To: <20250203031821.741477-7-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 2 Feb 2025 19:18:13 -0800")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-7-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 11:49:57 +0000
Message-ID: <87jza7dz8a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

> Provide out-of-line versions of some of the qemu/plugin.h API.
> These will be referenced with --enable-plugin, but CONFIG_TCG
> is disabled for a specific target.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

