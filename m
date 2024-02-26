Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF2AC54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 18:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1refLh-0005eP-1r; Mon, 26 Feb 2024 13:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1refLc-0005dY-0F
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:05:06 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1refLM-0003E3-Re
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:05:03 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d240d8baf6so42921271fa.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 10:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708970684; x=1709575484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HeKiIVm+BC/GikSEmoHqMEFFJmK1NiGpSfArmtk3C/c=;
 b=ZZ3CK/R2MHb3MesheVZYE4ZANlxGqkNLwlD3ucgg27q2vE+cxSLcEUjMkj1TCD/y64
 LBFgOdRiU1TSfdzqUh4QL2kmwFaxsGYKjdqwDS8YwviTmgpNQ89qD4AKlbKDifCZj7X3
 VxLIgqNW6hUSEY+qpB7FObp7s0D1t50ZuggwoeGfDtoX6A6cGMLqDmym7XXSazs4XRQ2
 fqd42xiztxI6HUnzYQzazb3nK2ATcvG/t9GUNnQ2n43HtkMBzfsiFJnXa0fhvZvuuDHL
 cWO87hTa+i7UIwD7r16rEhExVo3OGQOFp/vFsHw2i0v3dSoP6lZyYSeO47jJ5JYb1s0Z
 jWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708970684; x=1709575484;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HeKiIVm+BC/GikSEmoHqMEFFJmK1NiGpSfArmtk3C/c=;
 b=NhQfxLt+MgJyCHi9TUAZnohtgq/FrpORZ8EC0fNnhK2KX4rRv5r9aSTrrrF1Zlz6fB
 UAUDO8J+zofoBIMZUvcID8EtMSGkgqtc2RiP0vz1abMIgEzy2O0QbOqWNMQauWJuGIBE
 h5Blnby2o8eG79dU3xxD4qaKqGXhWPCGfs/eJ/xHjhwgIu08xuLdE0+xdJmB+6tYWUH5
 +/unFuK9SC0+8WWCDAQ/+ZYNlWR9ufGAWoZbrP5Mnt4NvPInz9Zcdo0X91yOrFlLHf4b
 aMHKpSfBJ1XMdx3R2AAt2gRVCOgQhcDypOIvfqafsRYg4M8ocV5ugslSedmvM3Rs/7AW
 ACgA==
X-Gm-Message-State: AOJu0YziLB6yaUi1zaDW/H37OKaS7djo8uiEDH3hyJR/afBggo/ydJ02
 Xg4DThMgjLPjUxos2ayXvQdWJht+/YFmPHcKejv5FKIvO1ClzIVb2Cx1IOulivk=
X-Google-Smtp-Source: AGHT+IH+jZZISs65LKclX7JvA70vhnfAh9jgxGCJwNrJdyrw4Xz1A1AAJeBnqmViEdsTawTtqecGIg==
X-Received: by 2002:a2e:a16e:0:b0:2d2:36a7:64ae with SMTP id
 u14-20020a2ea16e000000b002d236a764aemr4271541ljl.32.1708970684637; 
 Mon, 26 Feb 2024 10:04:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bw11-20020a0560001f8b00b0033da4b06632sm9139140wrb.6.2024.02.26.10.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 10:04:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D0B905F796;
 Mon, 26 Feb 2024 18:04:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH] tests/vm: avoid re-building the VM images all the time
In-Reply-To: <20240226174639.438987-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Mon, 26 Feb 2024 17:46:39 +0000")
References: <20240226174639.438987-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Mon, 26 Feb 2024 18:04:43 +0000
Message-ID: <87msrndrus.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> There are two problems.
>
> The first is a .PHONY target will always evaluate which triggers a
> full re-build of the VM images. Drop the requirement knowing that this
> introduces a manual step on freshly configure build dirs.
>
> The second is a minor unrelated tweak to the Makefile also triggers an
> expensive full re-build. Solve this be avoiding the dependency and
> putting a comment just above the bit that matters and hope developers
> notice the comment.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
>
> This is hacky and sub-optimal. There surely must be a way to have our cake
> and eat it?
> ---
>  tests/vm/Makefile.include | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index bf12e0fa3c5..a109773c588 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -88,10 +88,11 @@ vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  vm-clean-all:
>  	rm -f $(IMAGE_FILES)
>=20=20
> +# Rebuilding the VMs every time this Makefile is tweaked is very
> +# expensive for most users. If you tweak the recipe bellow you will
> +# need to manually zap $(IMAGES_DIR)/%.img to rebuild.
>  $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
> -			$(SRC_PATH)/tests/vm/basevm.py \
> -			$(SRC_PATH)/tests/vm/Makefile.include \
> -			$(VM_VENV)
> +			$(SRC_PATH)/tests/vm/basevm.py

Maybe:

 # need to manually zap $(IMAGES_DIR)/%.img to rebuild.
 $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 			$(SRC_PATH)/tests/vm/basevm.py
+	$(if $(VM_VENV), make $(VM_VENV))
 	@mkdir -p $(IMAGES_DIR)
 	$(call quiet-command, \

?


>  	@mkdir -p $(IMAGES_DIR)
>  	$(call quiet-command, \
>  		$(VM_PYTHON) $< \

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

