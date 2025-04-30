Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110D3C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA509-0001Yr-BV; Wed, 30 Apr 2025 06:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uA507-0001Ye-1d
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:49:15 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uA505-0004yo-9h
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:49:14 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f728aeedacso8570563a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746010150; x=1746614950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCqIy3Xt2xIYlEfLnaTVHRsYxj2Ia4p2fbvaBmd+j9A=;
 b=k/0DavXLmmOmXUTNys6Bf9atFCMpclEHOHyoy1MHE/FdYySfWsyBLpja/v52u9fSd7
 FZYrR2tSSH/v8TgdEt8VYQlIdGOqf5ln2U9/SDFlyW9AJuYXkGwKxEiCqrgNFzGJmtP2
 FAZjB/tmbC7t3rLGQ6XHsfTDSGiCsx5i1Rf5qf4lV5teI0RB2dkg81TuZQ3B6NyByac+
 APHrJtAxD5FEqZFLA1uL8151wr/mN+45AxOg4U0ufb1zuyPQ6oLaBaKXNRRYG8vCiOdD
 pZdwj+3gp+otAryw9oDmZ8p2uJzbNPTsHwzDA2GP85TkaFqB9rEpI7WUYIrGxU3+g0PU
 JWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746010150; x=1746614950;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VCqIy3Xt2xIYlEfLnaTVHRsYxj2Ia4p2fbvaBmd+j9A=;
 b=NmAWN5rBrLt+kXHQw9JC81FmOAmi4IbEJRFiZq68cY/vRM4DJlMPl6xXC5E66jRQD6
 wTvsa48kytVqRL2QkEu30OOkLT64oPppL9NakGMw8Qt9mybuJvM9C0y0AwYb/dR2jMO4
 E501gB6h76K5fDprvMgt5kHTL5K5ldWgA1hR/FnoftiLqoZtFBAhC9NaDwy+LAxg40fn
 HFcgd9GyyTRQ6rWEqbt0KRnwpc9pxc+qjaxeh+OOMTo8b6Xk4a91cxx1KPmhdLn5BhTW
 LYgPYZ2VMFISuqzGxyTUMWhVNi8MIG3yyQO4Zv722ZHF1AE8vxUZ+km1ZBBL3Kt09J0h
 RjYg==
X-Gm-Message-State: AOJu0YyvuoGVD5gFhZ0NUnRw1AAS3iEazqGsG85oCOPYqTd49OcxlDXM
 r0+1XblI//458p5c6y6MYD1aq2IN0LdC8MmLZJaZ+BLoH7hwP2sD3rCl/vyFQV8=
X-Gm-Gg: ASbGncu7G3YjMXqouXESzcDZ6mA42blQItVyr1bmwXZWZIC9zVxD7aGAk1JgAU5MQlu
 SclkXEC+YMtTMBAK7/2JR3g2RwXiz2jRtShh/8yDAGr2FI7pC0h4YjgrfwiKdfm1wRsM665vW1k
 qoQLr/PkZK6NMGxFi1TmpbQjvU/pZbuRIDIDTBBg3xKWfeJ8Nf+ySG3+qBgrq1vSvtr6ks1P0wV
 B0P5B6AVlx5hBBW2mIXDRM5hsig58jfYfhaAKrwx42VKc2K8HLWSdEkzgWAPJspuNI84cx88Vni
 stRLG0QveqXnJGoamVpqPilzGtNZszVBf8jPyuUkbdk=
X-Google-Smtp-Source: AGHT+IGKu6IPiDNrRJa7tc8KyFLVJAZPK5Vyh/9LVNmhW4mqVYHvwj7OqhXZai7ZP6TqTjAHggKizw==
X-Received: by 2002:a17:907:2d0c:b0:ac6:ff34:d046 with SMTP id
 a640c23a62f3a-acedc5793e6mr316884766b.2.1746010150025; 
 Wed, 30 Apr 2025 03:49:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f8919af029sm937775a12.21.2025.04.30.03.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 03:49:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 730615F8BB;
 Wed, 30 Apr 2025 11:49:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  lvivier@redhat.com,
 farosas@suse.de,  sriram.yagnaraman@ericsson.com, akihiko.odaki@daynix.com
Subject: Re: [PATCH v2] Running with `--enable-ubsan` leads to a qtest failure:
In-Reply-To: <20250429155621.2028198-1-nabihestefan@google.com> (Nabih
 Estefan's message of "Tue, 29 Apr 2025 15:56:21 +0000")
References: <20250429155621.2028198-1-nabihestefan@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 30 Apr 2025 11:49:08 +0100
Message-ID: <87cyct3owr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Nabih Estefan <nabihestefan@google.com> writes:

> v2: used ldl_le_p and lduw_l_p instead of memcpy as per upstream
> suggestion.
>
> ```
> ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned addr=
ess 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
> ```
> Instead of straight casting the uint8_t array, we use memcpy to assure
> alignment is correct against uint32_t and uint16_t.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

