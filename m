Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55050C55822
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqx6H-0006mK-Pv; Mon, 03 Aug 2026 14:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wqx6E-0006mA-V1
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 14:09:19 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wqx6C-0002Yj-4A
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 14:09:18 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso6062071a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 11:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785780549; cv=none;
 d=google.com; s=arc-20260327;
 b=rKJGSa7CG9E9pLJk4yKTsCv6/LF40r0M3o1bJt4RNOR02/NP2Q1jYrXpWvWX8CNq2w
 Ijl14yVorItrpKSHFDt8EuvZdARLPqIhxcTh3zP9p84p7B5yzULHGUPlIMdAmqPJLDjr
 waSdpVCcnVPJohJhgghdef7IWMDocslVsLL896Ync34gMR8nAoYmFN7gkB+VThaDityW
 ELObHRNeRKUr8w3o+qLfO5BbndWF5aoyy3VCEQ08PkjB7HQpKKKbMIjsMs3WOOzETawj
 OU7FP2uxGNDG6ZAvQtvSvft3kKewzqfzVq/OnjeUongoQ1cNaPiJ81bu1/AyGEh4zCJi
 hqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=a9+f17//kPXmpMy7ZzUPz1bauowQzxOA+c1xKzNhnAE=;
 fh=wzl9jMok7pbKGLGrD2z5a8AfFR3CQLcrDOLbNIJZ8cg=;
 b=GS9KObyElXOwgVtjDFgf9UjZsdvJ522XYFYdlTr9xXAoP/3sQP9OAFfPcT6XFW+9qI
 XHD2IvhUqCW93c56LDjhFKzN4dxYSajdgbvkZDSNFRXSPYvWnluaef1JMZKS+TdvbnpR
 nhFoLjz2D5icoUkVemD+++c4G/ebkmzfFl0KWisfNUeXzOLZ1QwLo59RQBUEqTaWWyIo
 upEKd0c7oKIMC5JxtdQxP4aOJ+UTuxzawz70GDZRgF88dBx0xvBhcpl5gChaK5cMkxNI
 FphK727dJnld8L9BvwKd0ygxBHJwZ535uqkhXWinVhTLRctPvsZLZXwN7FoWHWQxlUMH
 50nQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785780549; x=1786385349; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a9+f17//kPXmpMy7ZzUPz1bauowQzxOA+c1xKzNhnAE=;
 b=iYp2NoGmzANKIclfCougzH9QG3d6NtfrhT331S0TvfoxIBSwg+HGj95FpmuJlf2hgY
 HodCRDt0t9zqZmRoKWOi7zj5XfGrVcdpZAEd761YIUKxUc8PUP325EcOGGO+/R7ZIeH1
 KK/Iw/DsdzKBiStmdgV7EJ1G8Wl66oqTDnNYMLhO5s9MkIDeYxN+nLjgtFcVKR+DaCSV
 RAFJgzEMchVGwqKi5+ujF1uGNUh1GjLJpIycl5d2QQM7of2fejEeMX68mt9ufz7DkQln
 pQz9lYfZPL/lyFymVvGa8pozpw0WaWCUVsHq1fmy9valbCjguzwU6I6bYQ4wm5vebO89
 7w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785780549; x=1786385349;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a9+f17//kPXmpMy7ZzUPz1bauowQzxOA+c1xKzNhnAE=;
 b=MUoQmFHN8ExRVRQMV7gd5HvA0MXHYquSF4q4mL9ZcirPIqnq0xScYE0gu/o7Tkw0RM
 u8u0SWHJpHTkBr6vOFTgLa7sJugJwILGDTb7DD3gWfcg8U6F25jpdt+f3PC/lGLGGx0r
 oA0QPbJFI3nk0wHC9bTw0pkevpMgwm9iWw2r8DyC/1NaW7sKBtdU/TCeg+CXNkyOiCgf
 0FjmJ/RXF4rywgDRZcWYI/AHA439rL6vgagRU1khzf0N0aejZLPE5o0ZlZDHjC3OIlxO
 Sa4tRvpTQ10ZbaEhe31NZStHg7mUVjtnsmNthYcLUjEwE+IQGYRh3Ye638Q+G51jFzcn
 ygrQ==
X-Gm-Message-State: AOJu0YxnDdWnYbGGK4o148iK1SFhvU/Ju3wYJOXOOKb4gyY5DMCBOaVu
 Z8d7vvHJZR+pITDA0DgyVDYEZOYok8ZMHj9TK3v7V5cgy+soO4Gi38smDBMb42RVspJeCc6Q4VF
 a7heqkbace57KUtcgvqStfoWsHM3RuIE=
X-Gm-Gg: AR+sD13gmlrUo+01SFxsZCGWtlxoKvCDIHU5FjROEFl3ksWWrbtsylfnkqWTih9tgBV
 9dI5g7mPEKWkHUeU2V5VpInNpiWfDrgePwE4SMgtz+vOpvTddBf+TvqlcbdUfJ3pSLLI/Vr4bAx
 yXazygtfyubhnydcoGlWIaJoz8LHt2qYeXi3G/Ewm3Nu39FstiIAsU7mgNFiVS0vrkXzKhOyJpi
 cJ83coQQzn0LqxSuL4bL75asPeedGw1mFfaYAw5/qNW22KQID21maaiQDPnTVtoLtyOssbZ8i4F
 yJ/i+A9vspAZagb8Lp/6BnaXNJb0E3VWj0lL7gzYypqIoH+o77ou5ft+gsJtGSECR/VewCXKHTm
 nmw==
X-Received: by 2002:a05:6402:21d9:b0:69c:794d:4862 with SMTP id
 4fb4d7f45d1cf-6a0a7c614f9mr8966251a12.7.1785780548769; Mon, 03 Aug 2026
 11:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260803180700.367388-1-stefanha@redhat.com>
In-Reply-To: <20260803180700.367388-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 3 Aug 2026 14:08:55 -0400
X-Gm-Features: AUfX_mwi0pXT44bc3Q_I2_TNDYYAmCMariY4c5kgoVuUG7DQnPPC19qezVuT7hA
Message-ID: <CAJSP0QVzgmN1uBmB+9Bj1GqYfcW0iGq2E0Qg9JTuLKe1+5+-Qg@mail.gmail.com>
Subject: Re: [PATCH] tests/docker: use stable URLs for zlib tarballs
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This is v2 of the patch.

Stefan

