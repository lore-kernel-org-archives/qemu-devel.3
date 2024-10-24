Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD49CFA457
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 10:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3usQ-0006Lh-Fv; Thu, 24 Oct 2024 06:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3usJ-0006LL-Bh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:15:27 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3usH-0006Jv-CA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:15:27 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c96936065dso761763a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729764924; x=1730369724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zlXKjvdRzWlvk5toOleY0ICZQuUCEYcraduEuL41ls=;
 b=dwqHWzSjuA8NgYI3nysh6O8LN7PPn+wL9iSQpIYjmEbSBaXIpvV2z3AlD+WySyA+vJ
 /HtKUkx5byM7jN/d5Mgj4EhofGZLWqb3EI302h0nJ2SSXtd3cyGVdCz8vYG6bdQU5+P3
 vnGv6U7X8NJa1umh0VMZaNzIaLhQLJgKJgBjGGRTPXnZCBE5wgrL8bNMvkDyo5iVQ3TQ
 bn7+IH6XayBZxaMD0GYwo5wl4MZ6AEdykufhp3RX2hghHwDEBlkFKJFipUMUcsBuGDnh
 MkEIfenjmGNe1VBbTeduNhuKlXopScDfIzx2KHVTgWPaXBJG1uzttCKAm5yUwdGWwVWy
 DIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729764924; x=1730369724;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1zlXKjvdRzWlvk5toOleY0ICZQuUCEYcraduEuL41ls=;
 b=DW8BVXrfkh3rF2usSKDG4NRz1bAW7r5DiZTqtmxFU8mL8rIz4hJo0TVX2QOGSauB7A
 5XExATdcWCHLKb6UgP3jYuXYLohZNjCgoljCWEOlEp+ekRtaty4Iee47p2xOIk72a/TC
 8yTEEoGGjJCRIEnOTMYywgg6X2Z2sfDEAdUWgavrUX1YwMMWwvAkqk7jxISZXeDAYLWM
 5fh6Cg1MlyDn0vIk5Asog352J1r+J+P3P3cMiQVI0G79VZMelbCK1SJa9rae8llZJuDF
 /NnrjUCJhgmgUCOukjmkioVWHy5BlfjM42Ka4ux2ZQP0IXJ/z2+IvaIpD9hzWoYuIEhZ
 WmWQ==
X-Gm-Message-State: AOJu0YzttvLoeYuNce1dyFRpBr1kDnyK+bWNXKs/h04G99X3QShtxJM7
 UvBEc10Vd3XS3uCMOC2sEfl6OasT8bTA2G+C1o5sFiwII7VcMXDd3go16KC12+I=
X-Google-Smtp-Source: AGHT+IEvqf+7bG4y0GvmJOvU+e9gqotwLkjYIgglFeSiVEnGmU1c2wWWSvfZNT08eV5B+iZhQyDs7w==
X-Received: by 2002:a17:907:9486:b0:a9a:6314:40e7 with SMTP id
 a640c23a62f3a-a9abf8756e6mr596479366b.17.1729764923635; 
 Thu, 24 Oct 2024 03:15:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91559951sm593736166b.106.2024.10.24.03.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 03:15:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B1D45F897;
 Thu, 24 Oct 2024 11:15:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH v3 0/3] build contrib/plugins using meson
In-Reply-To: <20241023212812.1376972-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 23 Oct 2024 14:28:09 -0700")
References: <20241023212812.1376972-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 24 Oct 2024 11:15:22 +0100
Message-ID: <87cyjpkds5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Contrib plugins have been built out of tree so far, thanks to a Makefile.
> However, it is quite inconvenient for maintenance, as we may break them,
> especially for specific architectures.
>
> First patches are fixing warnings for existing plugins, then we add meson
> support, and finally, we remove Makefile for contrib/plugins.
>
> Based on the proposal of Anton Kochkov on associated gitlab issue.
> Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
>
> Plugins are now deactivated by default on 32-bits hosts (since cf2a78), s=
o we
> can enable with meson without worrying of warnings when building plugins =
for 32
> bits.
>
> Removed patches for individual plugins.

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

