Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D197109879E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3byi-0004zW-Vf; Fri, 20 Mar 2026 11:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3byh-0004ya-FY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:41:35 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3byf-00040r-Q8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:41:35 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b976536806cso326608466b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021292; x=1774626092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOj1r+oeR498PgJtf2srwgUsVE9ojNuYZzjY04DTBOk=;
 b=LuSB4lwJpuhOjUIzWXcPGiSmNYWFTa0qG1U7Cc7ZwQp75X+kQ3j4CqmSpC740927+V
 P5eJQ5al4g2Uhti/XBRFCrH6LGRSCCXp0NfkrlDgprBsCvGu8439iQD3Lgv+/DU+ACeJ
 7nmJEID8guvKOgdbeTR+t+UYJd1pYr83Jcx+gvXuxMyrbZ7jl54IWlKtBjmLhctUj4Dn
 exL5BdWjye1mBql7NrVwno9IDvzd+dJAKsrJc5OtYVUmvtR8VPfURzjy7h4s402MShr3
 ZMrkxubkDrZEZzP8xltoHJZFLTD3r0FyLh7htKWFXsWaPZKLLBQLTBwLKWwTEhzqMAfY
 OQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021292; x=1774626092;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TOj1r+oeR498PgJtf2srwgUsVE9ojNuYZzjY04DTBOk=;
 b=FLtyoqDz96nEG9iSkcgYH0npqNZQl7PgTf9Dd3Jebnl1OhSru7C4O3QK6IwF56j6yp
 9w9tIl14+hFIxBvesS33k3x7RqzxHa/EWMfb8pq7F8T5h0gI9xvwvkxK95qOhBdz+cF2
 0zB+WhWcemiCOjCIvfShD5Opcy3exbXv8VoAfi7fVnr9Q6lBjVCjV1pUS53csxdT/zY/
 48DfNob4dhP/iuUWzFcILyq4wfc0aKvQIZGj4axP+weMRVYeFKaOYnsJcSpI7Ngm1NkS
 GwDljjWWMGHsG93LZt65E8+g2OdHoCQEtpQwur/UFoyr0e6vNpxB+dcjvXjsEAnFpeUy
 HdVg==
X-Gm-Message-State: AOJu0YxmTgW3kBI0rS9X4C6ywsfcWmBauz+T4b99JbvBIWprI6giC0Ib
 wBMTQZ91VBFlgesVP5bCSljHGoh2if4srkZ6vrOibW1J5kl3Pp5gZ4Z9hEQ0cvGnQf8=
X-Gm-Gg: ATEYQzwOsaY97DHostKm/RscdvhllwrvF1omqf9jFypGqGR/bG2nHWF5OpbJN+MXSwj
 HPnEZUUQPl2t9RN4G15yXy1E2jBpALzng3NZ6udxJz4HedAXAUahX5ChZTvdOjSCEFzhrtHZE6B
 4zfK3WM5lP0kpilCQKaJITdaO5kLs7F/xDhuDDV7KEQ2QHFvG9FZSNcXAs2HuJR5TPLk7un07SZ
 t8CFaiaZqB6hl+ZMPplpKGV2eo3RSAk30Hfr8ksY4EuORPgAi0lkNn9o0yxiYEN68uSd8tQIos5
 B8cWcizpHIghlYfk+LgKiydItry0/k7nEVo+KXS0YqXYDRbo9arnUxDPtPFf9w2nWnp9vtvJOXi
 sFtWF2jpB/dhFdO8IKeLLDA7h2fT5TwaXjicHduWVVprhJpsJGqJc8CwnrdAItBNkiI574CalnE
 5ZOcMHWI5I26Cqeq6bBUQJaJiatKoDItLjrg==
X-Received: by 2002:a17:907:d307:b0:b87:965:9079 with SMTP id
 a640c23a62f3a-b982f1ec9cdmr258217366b.3.1774021291648; 
 Fri, 20 Mar 2026 08:41:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f440e7sm169909566b.3.2026.03.20.08.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:41:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 431D55F82D;
 Fri, 20 Mar 2026 15:41:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] tests: Replace ncat with socat in migration test and
 drop ncat from containers
In-Reply-To: <20260316183016.239526-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 16 Mar 2026 19:30:16 +0100")
References: <20260316183016.239526-1-thuth@redhat.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Fri, 20 Mar 2026 15:41:30 +0000
Message-ID: <87se9uv785.fsf@draig.linaro.org>
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> nmap / ncat has a somewhat problematic license (e.g. saying claiming
> that derived work is also considered for software that "is designed
> specifically to execute Covered Software and parse the results", e.g.
> by executing ncat from your own program, you might already fall into
> this category) - so for example in openSUSE 16, you can only find it
> in the "non-OSS" repository.
>
> We are currently only using it in the migration functional test, and
> that likely does not fall into this "derived work" category yet (since
> it is also doing some other stuff), but still, to be safe, we should
> move away from using it now.
>
> Unfortunately, switching to one of the other flavors of netcat is
> also not a real option (see commit f700abbbeb6ab68a3446d1fb168a934d),
> but socat should be a solid replacement here instead.
>
> To avoid that someone else easily uses ncat again, let's also remove
> it from our container files now.
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

