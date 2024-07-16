Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE07C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTicY-0004E7-IG; Tue, 16 Jul 2024 09:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTicW-0004DZ-6e
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:53:32 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTicU-0001C1-D6
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:53:31 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77c080b521so590812866b.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721138009; x=1721742809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+3q+zpeZwRSQPOJlWNmJW5DhQudLx6iPnIuG7KXAobY=;
 b=MHSFk4YIr9bCyBE+7ixXnjf9nwlyepfwcXiwbSHnaJ6Mu8YnZQ5PKygvDO7w4Ourxq
 51nGwVhMCBPqlzCi2cn1lii99Ea0+XxFSR6pmmqAnh9DBzSnKaPLNIfMh7UWqkDsW6Pp
 Wp5IRn7smPh3IAfAxMEa01LSw8wMYkcq3v4QH81hbtzokisSCG0aFm04Q67Mx9JjFJ/D
 uwHiJEY5A8D7NayopbIJDP/6JmLCpGoc+ZlbOVqbdV++M0b9I7dVWC9C26iId0GIGRKD
 +Onb/Zx9pggfiC/0BhHGoFBpZP857j+zaNkvlAaRkyBREXICaS9WKKmnrD5bDlT/qlKR
 vBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721138009; x=1721742809;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3q+zpeZwRSQPOJlWNmJW5DhQudLx6iPnIuG7KXAobY=;
 b=Yz0IvkquTzJAPTup4HwQ5oEUufMTEh0/npkSBNZxSX1nBt7Ww6gziXiJy8gBGJESvb
 salhDkCqu8/MSk/wviYIYeNMPxdygclqgncNbtQIjBY7R2L30uRb3WucAzRrUO1puI/i
 dciwv32v3pUtoi9N6kY+VQE2LkSQyoPZMGyNaAi4TrwEdh3JJAboGYnqOgk5S4aw5UMK
 T8+ZQDlxfh/LGYcnQJ0UXiTeJ+79VolAabKw14FzPaJfZZXF1s4mYyj8pxCQ0xnfIJGP
 dmmb/J1tksnsakTSPvDYo/hC5qoQXELw0zt667CDjR/ScDdYSSI9WZdu0/LVo/YunIly
 G5Ug==
X-Gm-Message-State: AOJu0YxwWCFV5Me2PUu+QsYm0MSboJxefPRyF2Hich3+b5zrJJOLnFEv
 6OIpJROGM23yAVldjXL/HSFKiEA+wVdaqouhytFkWupdCWByy0PGg03YQu2TiXE=
X-Google-Smtp-Source: AGHT+IGJYNvK2o+2F8kI64yBXg4Nq/9sK82cW0pS/by+n7gTY9aPpUJyDqsVun/MA6bHTDlaClmrwg==
X-Received: by 2002:a17:906:3506:b0:a6f:53a7:adaa with SMTP id
 a640c23a62f3a-a79ea3da956mr169024466b.11.1721138008319; 
 Tue, 16 Jul 2024 06:53:28 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc801192sm315365466b.187.2024.07.16.06.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 06:53:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 688AB5F7A0;
 Tue, 16 Jul 2024 14:53:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Yanan Wang <wangyanan55@huawei.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v6 1/7] plugins: fix mem callback array size
In-Reply-To: <20240706191335.878142-2-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Sat, 6 Jul 2024 12:13:29 -0700")
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-2-pierrick.bouvier@linaro.org>
Date: Tue, 16 Jul 2024 14:53:26 +0100
Message-ID: <87le21h295.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

> data was correctly copied, but size of array was not set
> (g_array_sized_new only reserves memory, but does not set size).
>
> As a result, callbacks were not called for code path relying on
> plugin_register_vcpu_mem_cb().
>
> Found when trying to trigger mem access callbacks for atomic
> instructions.
>
> Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I'm queuing this patch to plugins/next as it is a fix.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

