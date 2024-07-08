Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00A2C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqsW-0001NN-L7; Mon, 08 Jul 2024 12:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQqsS-0001MA-3j
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:06:08 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQqsO-0007ro-LO
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:06:07 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57ccd1111b0so2740957a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720454763; x=1721059563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L0akaoyPQ+VpJIwY1giHyFaR3OtkO/ICa8sv13FZJ2w=;
 b=D4ZTgvKYKC7QFkJwlamFU82A5SMJA1iSwtg8QFhgHZ81F+P6ALn39nCXOnZoWzydl/
 7fd+exmPQ5hTILAzrtmN9YM3V1I11Wh7AlKC4f5SFcWOav7VKbVMPcsj6G6xtMJLOOS1
 fMN1nQaK0QJZ9y25sF7gNsSnL7pf06tb22bxnMm6WBrurbRhmW9Wq7BQOYMBb2WKjtWq
 1j1H9uB0lZqtbQ0ieaCsFhxJS7Pw96t5T9zvS8Y0tDwGLkLv6obR5ObG2WpivePZ4VXH
 BkPqjggnrZnFXw2PeNTnyZyrYZp8kVBNdED0GGmeCKj0sFM25FtCRbmnw+gIrDFx8r00
 l6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720454763; x=1721059563;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0akaoyPQ+VpJIwY1giHyFaR3OtkO/ICa8sv13FZJ2w=;
 b=SKZ+AjuRDK34n4bnY92u6pyT//ZaeeFTUAttWSkMIj/tiCs/x1dSZ912uh8ihpqUqw
 /qGN7Y38W/O1V9FMUK+5QR8R5cZH930jodqS0a1nIJDi/dsZsGV3GANjOh1dBwihQZzy
 c5abcrvVSUc7Cx5Z4E1hRHUxJhPvVfqIIMMDHAszwEq6mvD9tp+Je3KTkFVf2riPKI3L
 ZXyc3zVlij3hyPTrThwFels2sRZ3AV/xNBiwgfcs7O/bgeWz1OzdFPlux15ZjHpdLFf8
 cVgifaQLfomlHPrNGymzUxd38oAjUARgpKQsE/8PegtBpnaenJAxuPvSAHWnMh3Mkmb8
 dTrw==
X-Gm-Message-State: AOJu0Yx61rtZ1FzQ1NOwTVZXM1rJd7cNT0JgfTVsRrdwNXRDQeC8Ipdy
 sHkNsQ5B5mMi9gXvqFgo6bcBUWIiVLknUSdNF6ELOwlW/u5cf+g9PjFuggs1+d0=
X-Google-Smtp-Source: AGHT+IGXMMJSnxrweqyJ/uYB4yLBKwETXeV+DUaGecuWIvlaGkVXi17EwDaA7gf+3umh49ToG5dRyw==
X-Received: by 2002:a05:6402:5194:b0:579:73b7:b4cc with SMTP id
 4fb4d7f45d1cf-594bab80a30mr53529a12.2.1720454762555; 
 Mon, 08 Jul 2024 09:06:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a856214sm5849966b.178.2024.07.08.09.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 09:06:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 01AB15F8CC;
 Mon,  8 Jul 2024 17:06:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Yanan Wang <wangyanan55@huawei.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v6 5/7] tests/tcg: allow to check output of plugins
In-Reply-To: <20240706191335.878142-6-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Sat, 6 Jul 2024 12:13:33 -0700")
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-6-pierrick.bouvier@linaro.org>
Date: Mon, 08 Jul 2024 17:06:00 +0100
Message-ID: <878qybuavr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

> A specific plugin test can now read and check a plugin output, to ensure
> it contains expected values.
>
> Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  tests/tcg/Makefile.target | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 52616544d52..6f50b0176ea 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -90,6 +90,7 @@ CFLAGS=3D
>  LDFLAGS=3D
>=20=20
>  QEMU_OPTS=3D
> +CHECK_PLUGIN_OUTPUT_COMMAND=3Dtrue
>=20=20
>=20=20
>  # If TCG debugging, or TCI is enabled things are a lot slower
> @@ -180,6 +181,9 @@ run-plugin-%:
>  		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
>  		-d plugin -D $*.pout \
>  		 $(call strip-plugin,$<))
> +	$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
> +	       TEST, check plugin $(call extract-plugin,$@) output \
> +	       with $(call strip-plugin,$<))
>  else
>  run-%: %
>  	$(call run-test, $<, \
> @@ -194,6 +198,9 @@ run-plugin-%:
>  	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
>  	    	  -d plugin -D $*.pout \
>  		  $(QEMU_OPTS) $(call strip-plugin,$<))
> +	$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
> +	       TEST, check plugin $(call extract-plugin,$@) output \
> +	       with $(call strip-plugin,$<))

No need to have a null test, we can wrap the call in an if:

--8<---------------cut here---------------start------------->8---
modified   tests/tcg/Makefile.target
@@ -90,7 +90,7 @@ CFLAGS=3D
 LDFLAGS=3D
=20
 QEMU_OPTS=3D
-CHECK_PLUGIN_OUTPUT_COMMAND=3Dtrue
+CHECK_PLUGIN_OUTPUT_COMMAND=3D
=20
=20
 # If TCG debugging, or TCI is enabled things are a lot slower
@@ -181,9 +181,10 @@ run-plugin-%:
 		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<))
-	$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
-	       TEST, check plugin $(call extract-plugin,$@) output \
-	       with $(call strip-plugin,$<))
+	$(if $(CHECK_PLUGIN_OUTPUT_COMMAND),		\
+		$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
+		       TEST, check plugin $(call extract-plugin,$@) output \
+	       		with $(call strip-plugin,$<)))
 else
 run-%: %
 	$(call run-test, $<, \
@@ -198,9 +199,10 @@ run-plugin-%:
 	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 	    	  -d plugin -D $*.pout \
 		  $(QEMU_OPTS) $(call strip-plugin,$<))
-	$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
-	       TEST, check plugin $(call extract-plugin,$@) output \
-	       with $(call strip-plugin,$<))
+	$(if $(CHECK_PLUGIN_OUTPUT_COMMAND),		\
+		$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
+		       TEST, check plugin $(call extract-plugin,$@) output \
+	       	with $(call strip-plugin,$<)))
--8<---------------cut here---------------end--------------->8---

>  endif
>=20=20
>  gdb-%: %

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

