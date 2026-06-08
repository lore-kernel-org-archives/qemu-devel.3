Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AACCD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaFA-00005R-6K; Mon, 08 Jun 2026 09:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWaF7-0008T7-1w
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:42:18 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWaF4-0008Ku-Hp
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:42:15 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-660456349d9so4166191d50.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780926133; cv=none;
 d=google.com; s=arc-20240605;
 b=IgBDBX0/x12isqkPX8WbB4Gu/qwuDYg2bs6tR8+clCYmsqwQv0O6JzJfuqq0M7IwOe
 37dcbZbtqmCeGMzS6J8NNV0cC/I9wKl/NzJVE+8Wzn57KhQ6O46LlRzCEIElvf9VDM4J
 i4Ome9dr9h2BeKn20JmAbnjSw3QChGO3lPmPQmrhfsBNuugtZdaVQrn0mXQnP/KaxgBq
 vz348tWC1ZkZeliGu/Ij35B6Jjs6xK1YgFhVC5Yv6iLNvW9ornFAGvKLkzKpNIrt+esd
 oSTjRpQiI3yH3my4LHgvPTD57F+pEr6Hab0spy8tCS+MpJnjHDO3fkXqBsAydQR87iOA
 KzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yztRxVw2QDyjtz3NSNd73YzdZcktuUTBZ7qaQ7mbGGM=;
 fh=PEUsa26ikpmtKKnLI18byuqUrQygaTmALJxGjL/V0Sc=;
 b=O22zfp4NYoPIupGFH4wrQ82hKTaKb+s883aQxcuy8mVAdEGlMad2gcQHE+tsvKY8FZ
 vcAjSzqRSGuZLGSOgpebJwml7TXxbqL6eoaisxYmK6SWD4UO55ZBQLYt8XGo3Er45H/s
 qK7y4T1g2ia69jt+oYmbAaE7S5WrQIiVH6jUKD010lm/gHfkvlAYHuFg30ez7GO/x/59
 WtobH7Ted1iNOM91mWMrMu0MJSg6vAxx+pItVrYpKcOX8QmrmApT4rVAjaQOJduFjZkI
 WZF/CBce/0mhzhDz6PfjiXkcqAWtTL52ILx8zzIpwXVYvqQvce+ExfDUyD18KGewSGSu
 2Y4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780926133; x=1781530933; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yztRxVw2QDyjtz3NSNd73YzdZcktuUTBZ7qaQ7mbGGM=;
 b=Fnjp3LCBBi7Nnn5pVywWVC6FadiPS/h9QdZ6Td/RDigwPiN5P1Mm4rA/KBcDmeVAO0
 ArOCeEKF3+S2KIsenGMGsTrf5L7S2fHJatMwLveQP7pcopyzhzYguWXgHgJMnoD+8d3a
 74VlIDlY8sqEtT0ONzcnaqlk65Xw2pwRy+YYj1LORenFPKmQegqx+JtQTL7iIZGkubOi
 /Cx3KRvTP/dbxcawI1n/hPJr0Zom2uUwVCy2SUV0zwK6HU3Au7cvttZVGb1STflz4ukG
 Bgs5H2nvGzRQ9zZ6y/8guGTKxr3Cohhtqhnogs/1JqfH/LvCTuOphLo+upT3x1nUbfSe
 hvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926133; x=1781530933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yztRxVw2QDyjtz3NSNd73YzdZcktuUTBZ7qaQ7mbGGM=;
 b=XHXJ8UmoJzfvjMuZc7rPFCTXMOJiyx77QAhz8r++fQ+3Nofe7/yBIPk6+bbqTY4b2b
 C4tDGAdJ3xFfeFVTkr19CpAQF8suR1XEzYGq2mtPDgSP8pP33TFW4+KHMnKL8RlwewSp
 jR2WHs450TgEOHTwq+HJZzuxJPcOhmmvnniwxYtnSvXFSni6Y0pZjHhKsI/hLo1zY3t9
 KEHcYc3N1U1YF3FmSEClVByvni3P2kTMZNehQA9HnwKWpY5tB6qyJXooC5edceNPHpUw
 cEr+/lZpBLxso9TbYtgqHiSzdtyE5hUFEpzkTWsf5ZWcU7+JXYwkD8j6saVmZyGEVdnS
 TupQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jlYVMHB67fpPejrtLoDQ/UTqOly3L4NNAsYRhkVsUTY2NpZNRDpR0oA5CggJLC0VGW6hndrZ3pqse@nongnu.org
X-Gm-Message-State: AOJu0YyFZycvl8QMXapJ888894sUMhe6nnKA8yuI5OQijKHde9K7BVal
 wB5chYCzHcQ9OHmYq6RvkiBUBwQSME2Uj160bBkGaOtk9gga8MsD6UiXTMZuDP9FbrrXteSCiS/
 W4EI9xxHM/AHv4Y1jNbsmflcCX2bpIV9GsVRFVMHSDA==
X-Gm-Gg: Acq92OEGczpLA6W1ZHsbIakflUWMKO+wVEs19mtek/ORgBGeiDxoNDRJL+uy6qLwXrq
 jD0Xb6c3mxi1rX8Bx2HY6nBmA2Dbllj+h+OBLZUdpJXP5KZFxkEY/ateXbFw7dYcwp+da1V/Ay3
 hvH6KuaUgnMUj2CUsv0JneMW+Z4pbN/lfoncs5mS0VxpdDB3ViPglErh6RD6rjmd4FyQ2xA1UEr
 5CKA5WHFX9EHUgwcthibo+5eq+OjIaeYpERSFVhIjByYYBJtaTKDS9CiuAgAWbdk3CEtxdeS/mF
 HkI6OgqboOMvufP8BUMrI6M8sSgLWBeN1GSjeRe4Z1+QhWFA9bWESlCBHhr6LwSsVCQA7TI0oe2
 ElQ==
X-Received: by 2002:a05:690e:4805:b0:660:8e61:1a49 with SMTP id
 956f58d0204a3-66106e4abb7mr9259269d50.18.1780926133079; Mon, 08 Jun 2026
 06:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260428162048.2995097-1-luc.fast2004@gmail.com>
 <252f4369-68c4-4b34-a076-9c844b25720e@tls.msk.ru>
 <87y0gp17j6.fsf@draig.linaro.org>
In-Reply-To: <87y0gp17j6.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 14:42:01 +0100
X-Gm-Features: AVVi8Cf7m1O0i15R5TP8liS52je5HurvLYhOvTC_RNsApjTLdrrB-qNvnd_roO4
Message-ID: <CAFEAcA8nmKBbhkxzgF2diV41pqez3=m5hnx_qUZ2+5DCLqG3ag@mail.gmail.com>
Subject: Re: [PATCH v2] hw/audio/fmopl.c: Convert malloc, free to g_malloc0,
 g_new and g_free
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Lucas Cardoso <luc.fast2004@gmail.com>,
 qemu-devel@nongnu.org, 
 kraxel@redhat.com, qemu-trivial@nongnu.org, marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 8 Jun 2026 at 14:33, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Yeah I just scanned though:
>
>   /* lock/unlock for common table */
>   static int OPL_LockTable(void)
>   {
>           num_lock++;
>           if(num_lock>1) return 0;
>           /* first time */
>           cur_chip =3D NULL;
>           /* allocate total level table (128kb space) */
>           if( !OPLOpenTable() )
>           {
>                   num_lock--;
>                   return -1;
>           }
>           return 0;
>   }
>
>
> which needless to say is faking a lock with num_lock++ which should
> totally be using qemu_mutex - although even that might need some
> handling to make sure its initialised properly.

It's not really a lock -- it's just a reference count of the number
of devices using the shared data tables (if you have two adlib
sound cards in the system, they share the data). The locking here
is provided by the big-qemu-lock, as usual (OPL_LockTable() is
called from OPLCreate(), which is called from adlib_realizefn(),
which will always be called with the BQL held).

thanks
-- PMM

