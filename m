Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEFFFA3742
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 10:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp3Vg-00079p-R2; Fri, 13 Sep 2024 06:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sp3Vf-00077D-8C
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:26:39 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sp3Vd-0003Q9-J9
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:26:38 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8d6d0fe021so297678666b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726223196; x=1726827996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUQpIw0J7gYJntdrF3+fYQvrBvEG+S/20aOM1DWuFCc=;
 b=nBNw2bBIN85zyJG/3/jJno5hVrbG99bacxteIymEo+tMYjL4F40Lj/g3mNH9KLjaED
 JywVqTprPxlW+o6utNUnLIxKgaaG12qN7Sz+orBVDcIxmkIfFtpm3EAeAlCEQOdErKAd
 4m33XvVocosQ1QWBgELa1HGTcS16S48C3V1ZmgEgVlkXciHTogoBA9pwoYpHJT5Y8cE+
 6Mo8qZRfZtsCyUnncJb92egJgKm0o27BH3Lqq3yIKDoNS7Zhd9L/13+CzH1OQZaVB1h8
 3uU72HgD2pZT0XljBNkjgXk9RgsszFKjwgnElYahNMbgqhlxqyF2nqM04aid/6PQIixx
 w4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726223196; x=1726827996;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nUQpIw0J7gYJntdrF3+fYQvrBvEG+S/20aOM1DWuFCc=;
 b=oRE4elXlrHYRnGn4xzyk+TvDe4LkXt+g+Ha+UUXHqOnJSv5nb3jljUKBZpYdT4XwU4
 vGvHDUZ4uyzT5EhtqdLAp2k2Vu7HyjsA5Xq/LYIFWO/DzIfdUSl/7fOtljctqT8EkruD
 5LK2MgxDVZfw8NdNsobdFae8Gr1z4CTDPvyPzkStO8MtiPa2nYz8OQ6GvQ8Nw+WzRaAC
 CCWIQK+vpdIBzV2OvN7hn9/2GUqR47M3MjcExwF/uR847gonP34hLWweoSkKdW1oBxcO
 fZJoT97jcoqk4JqkvD9gBxeGE9AGmYtB/SV4cRnJ16QfSp3hMMrRlWGX8G79paU3f6i3
 HP8w==
X-Gm-Message-State: AOJu0YzYyQUqvADu53J5t1hpfl0Y7lW3hfHrlwXBM98t9NH4jwen9sBi
 jo97Rlc37cFzLeRDXg/9F2bP/SYt6DjsGOwUlIIzK9uhVhMzRHrCl9sn3LMIZOJBHNhm25ow2On
 Ezgk=
X-Google-Smtp-Source: AGHT+IHQrRt6FvxWmDCh/LAIW/dCSPM57n5VcW3TM4THvMvt3tl0pcGjDtqiFx8qhXZVQgJfGBcW5Q==
X-Received: by 2002:a17:907:e695:b0:a86:6fb3:fda5 with SMTP id
 a640c23a62f3a-a90294a28d7mr598467366b.32.1726223195670; 
 Fri, 13 Sep 2024 03:26:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c727fcsm851457266b.119.2024.09.13.03.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 03:26:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F2255F8B7;
 Fri, 13 Sep 2024 11:26:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 1/2] tcg: Return TCGOp from tcg_gen_op[1-6]
In-Reply-To: <20240910212351.977753-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 10 Sep 2024 14:23:50 -0700")
References: <20240910212351.977753-1-richard.henderson@linaro.org>
 <20240910212351.977753-2-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 13 Sep 2024 11:26:34 +0100
Message-ID: <87frq3rgrp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

