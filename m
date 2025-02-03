Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2DCC02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texF2-00026r-75; Mon, 03 Feb 2025 09:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texEp-0001fb-PU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:15:53 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texEl-0008Fh-IY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:15:45 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so746208366b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738592141; x=1739196941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8DLNiMTlVpLcrkpzTxDv6WaCMVzL1II9OOeA1yxymo=;
 b=GhIXINK7AYqs5NryWWW/4s0crR0YI3/G5lL9rqk1K/G/KAy3LMbXZRP8eI5IvRtw9N
 GWxvMknkR9fodsl0P4jf2F1uj7NnNhoJ48RRbcpgIqWPadI737sRbsXydVlzY2hTmxTS
 vvNjJB1fSgR80nIYqmzPqiOxyU9XUFxYY8vZv4QIf6H+eDs0TLvdHQyd75MuNYrL6sxg
 plCd4fNxk6s+svCcuaHkdK58LH9vbQ4e2NJO3rWTVT6pm2RRxB15c4HODNPoCa8XgygO
 1Seo45NqPBczAf8J4YJ2PxdpiSgakz/JfoE4DOHeUstrx/Kv/0vqNX2OeNZGnfBTBWJY
 Uvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738592141; x=1739196941;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a8DLNiMTlVpLcrkpzTxDv6WaCMVzL1II9OOeA1yxymo=;
 b=UzWf/tq8zFO+QEwh4nfSjYt0up+2nr2GUO0bb8VcSl6xxoSrWZRkcc54HwrccyUE91
 Vipt01HvHpzdbU3iMXJMmCv41Bh7/W4GiTdjYe6dwhyGNGMhpjx0TgfOtzawhrhhhKvW
 mqp+u+gun0d9h/JaQisL/emm2ff3aZOUvAxX0Yh2SMZIchnKP0fLa42VV1LPNYZmXDPJ
 9eBdk4vezUzi9eSQhaJOvwKBgy6qZXB2rsveMmX8UIN/mBx0tKQATJRyIFhUFozCiEiP
 WP2gJg/bdtK/iWfQS2iI1b1QzEPiGE1dXICk1+y9AKJM4khhNPz2/68MrmojaREtX+W3
 fJtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+5II8sYQHMWH31GBBetwaQ6FkZq/lqQ8wUN9fpJEQNWYfeyJu6w+If74W85LVJ3Yqq/SSrbfTHI1p@nongnu.org
X-Gm-Message-State: AOJu0YwQMoTO5aKEszxpuuuulXhCiwlqYzvVzLYnnTfn4mEEEu6UgkCO
 G8SNoGKSAmoguFKtL3Z/XpKRpWqji1+Is6/JNauZSmOWzY54rrk1I8CIVCS8150gSxjtp9I7Uiq
 nyyk=
X-Gm-Gg: ASbGncvKPrNgGWkXlolmwyRYBo/yqLWEWTmoyMjFnsbWRNelijzKWm8e2DYM4BCg18U
 NWk1upJIltct8DfSpbs8fUK2eCGl+DYYmqKKtRt9uqel6MpoHCwR471dVJ0tbDKSUqW5X0holjV
 4TiVG2XcTTMbytrCdsUgg0IU9ntgc57EJPYtGO749FTEKkNKr82t0YPUax/LVlkOI0nx6m0MfQV
 befwAuEWIcUdiuoK5U9kvnRJU7+tGIRYN4cLrD6LHr9E1oaTsoLP0GZmaIdU4/hEAfbNBtXDwMB
 R+g/xWB9nN7PCVAHUQ==
X-Google-Smtp-Source: AGHT+IEPL0/gAu4hoPsJMqL9NcTFl429Dwefiur/dR8AxW511cwk+fV3AItGSf977GcL8DCPpOJmqw==
X-Received: by 2002:a17:907:72c4:b0:aa6:5eae:7ed6 with SMTP id
 a640c23a62f3a-ab6cfce8dbbmr2225358066b.13.1738592141399; 
 Mon, 03 Feb 2025 06:15:41 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a2fa09sm765980266b.140.2025.02.03.06.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:15:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0198D5F8BF;
 Mon,  3 Feb 2025 14:15:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julia <midnight@trainwit.ch>
Cc: "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org,  qemu-riscv@nongnu.org
Subject: Re: [PATCH 1/1] target/riscv: log guest errors when reserved bits
 are set in PTEs
In-Reply-To: <8149beba-66b1-4707-93f1-083b8bc5ece0@app.fastmail.com> (Julia's
 message of "Mon, 03 Feb 2025 18:12:21 +1100")
References: <20250202051505.1846933-1-midnight@trainwit.ch>
 <20250202051505.1846933-2-midnight@trainwit.ch>
 <b76bf940-ff55-4619-a9ae-fa65c47e864f@ventanamicro.com>
 <8149beba-66b1-4707-93f1-083b8bc5ece0@app.fastmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 14:15:39 +0000
Message-ID: <87jza7azck.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Julia <midnight@trainwit.ch> writes:

>> This happens because 'pte' is a 'target_ulong' type that, for riscv32, w=
ill be
>> interpreted as uint32_t while the FMT being used is PRIx64.
>>
>> You can fix it by using TARGET_FMT_lx instead of PRIx64:
>>
>
> I've sent a follow-up patch fixing these build errors, it builds on 32 & =
64 bit on my system. Cheers=20
>
> As for the Signed-off-by, I'd rather not, and the contributing guide
> does not require it.

Apologies - I missed the context.

  The name used with =E2=80=9CSigned-off-by=E2=80=9D does not need to be yo=
ur legal name,
  nor birth name, nor appear on any government ID. It is the identity you
  choose to be known by in the community, but should not be anonymous, nor
  misrepresent whom you are.

>
> Regards,
> Julia

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

