Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94322C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD56s-0005A4-8H; Fri, 31 May 2024 12:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD56q-00058u-CV
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:28:04 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD56o-0002vv-Hp
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:28:04 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57a2f032007so1673699a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717172880; x=1717777680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hAqgSRoHvfVkotTgc2oeQxbvtA2YixEtORh+rft4hbM=;
 b=OHOBHVKnJRhVyAvxiRIJNz/9arMZBN747mIWn1T1K8DsckAFqw+jm1pREEthG6kIwr
 MMdWfD9TPW8u/nyGLwtN5Yxx6XQlDU0VAO0l6fZwzppwcpKGX9UHVWqw5UKJKClSWPQ4
 sJEru7gYx01ZIKl9jp8lO1QZ7jHfwtdJSE9ISiaIdHeSN+wWo3NveYwVuT8XpUA5bfRa
 lCc/sL5Jeby/56IrKsOS4EAg1uiDi9DkO3TlmZe/N0RqTT8QMNIZFbTEDRf6kLgQlDzf
 6Bj3olE7uAnapuWUjg9GpcmEfXuGMcYQBJTGnkmBXhWdlO6Lw6oYPoRjZY+aFzlCdu73
 HLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717172880; x=1717777680;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hAqgSRoHvfVkotTgc2oeQxbvtA2YixEtORh+rft4hbM=;
 b=R+DcEXgyN6S9x5fgjwEaJIrfG1Mmg1RAReAWBk3SjCpcV02CT192Mc64kOexkkYV/n
 7mGSyTrOOi0n/Oy230Xgir88vW2ZA/IMhK6M/QhOP92ResUMfMIOh3IAlYeZ/nmpPJ+x
 Y/vnEKbqa3KM7L3X1xs5u6QZPtEO4Uw+0XQSVj+khmetDninsDZuD6i7dbo2sV2JH6FE
 fCfjVIxRUadev58eVDQglxU2GfYoI1iCngMKJXp8eEc4Cf0ZbQ4a88hpX+SRMlmaCoo0
 Dzljyr2xH28KaAcg2O1fmv0SDXk6Ozzh76w957BAFtwwe7QimVU+QMbNPkeY405piTrJ
 sKNw==
X-Gm-Message-State: AOJu0Yxet3mEp0n35P5xqVUhecotvMSYKo96xSLrfFrDqmpKb2UllRYN
 qphxXOJNj4XVWOp/eMX4/4aM7W5oqX8QzzazxDlh1tVrMU+DaNLQMJm48sPEPE8=
X-Google-Smtp-Source: AGHT+IHEZtl0qCbvSM5C31yAZq+73QcHwFFOqmyEBicTIBWeW06zStAn3cRm0ss55cqYQJ7VK86ZvQ==
X-Received: by 2002:a17:907:80d:b0:a67:fca3:f481 with SMTP id
 a640c23a62f3a-a6822637523mr181950766b.71.1717172880372; 
 Fri, 31 May 2024 09:28:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab85c5asm103753266b.172.2024.05.31.09.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 09:28:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B10025F8A3;
 Fri, 31 May 2024 17:27:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 0/6] Implement icount=auto using TCG Plugins
In-Reply-To: <20240530220610.1245424-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 30 May 2024 15:06:04 -0700")
References: <20240530220610.1245424-1-pierrick.bouvier@linaro.org>
Date: Fri, 31 May 2024 17:27:59 +0100
Message-ID: <877cfaaquo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

> The goal here is to be able to scale temporally execution of qemu-user/sy=
stem,
> using a given number of instructions per second.
>
> We define a virtual clock, that can be late or in advance compared to rea=
l time.
> When we are in advance, we slow execution (by sleeping) until catching re=
al
> time.
>
> Finally, we should be able to cleanup icount=3Dauto mode completely, and =
keep
> icount usage for determistic purposes only.
>
> It is built upon new TCG Plugins inline ops (store + conditional callback=
s), now
> merged on master.
>
> Example in user-mode:
>
> - Retrieve number of instructions to execute /bin/true
> $ ./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /=
bin/true
> cpu 0 insns: 120546
> total insns: 120546
> - Slow execution to match 5 seconds
> $ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips,ips=3D$=
((120546/5)) /bin/true
> real    0m4.985s
>
> Tested in system mode by booting a full debian system, and using:
> $ sysbench cpu run
> Performance decrease linearly with the given number of ips.

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

