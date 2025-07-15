Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D9EC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 11:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubddo-0002BB-O4; Tue, 15 Jul 2025 07:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubdde-00026z-Jt
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 07:15:59 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubddc-0001JQ-Rm
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 07:15:58 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ae0b2ead33cso930515066b.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752578154; x=1753182954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YHUMGjoJybyzGJeHpg075rkoBOgyCEw0B7yoRkE4zeA=;
 b=eNG+brdlr5Tb0mN5WY7lvpBt9uOOv3Qkw4llri5/sjzSodmdxkdfMlS62t7Y4nFZrv
 PXRSIuRlLPQ1LdfxxTyQlmETJGCcDhO08rOAHCdgFNn00vGk2I044OopaVowMy7YkcjR
 BAvZG9f+/35CdPDqGLWZuZ5xEiO0pM/5+4iPFdTdZo9KWF3CpW+I/vdoFm8GW6bWBuNR
 NY8Kc+1rUvYbLO/iUCrv3vz3qNUprOw3wBGpWPM0ovx+8pWBc/v7ElHVWK42dGkMAiUj
 s4bmOhVz9pQKUxQTKDFlRIh7SeHYPbDV6jK2cLRSWs3pNmzRxi7Y925Epry69eH2Xfws
 WRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752578154; x=1753182954;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHUMGjoJybyzGJeHpg075rkoBOgyCEw0B7yoRkE4zeA=;
 b=eGMmYQtnGOUxua2fSyWJNjOTscMDQ6QFD0wHpdnTvf5N7fujT02rTOkAGWQVeTU++Z
 eS2ms2o2c5InMRjQtYWxsSUJqJGCUf2+mqxICy5WFDGgWORjfihoH7cPqhlQXoFIxA2I
 KXbhX+/pkPRS5TtGzvAz0DELcsgQUe+yXvxUflYWvdOLXN427xSFoNnegh4xH4B3TWYy
 FnbI8ZwYLMxj8zem2npVuX84nWvCVuk6SRpbJR8APy5cPL3FyX+24VlaliYmHGQlShGf
 b/m20An+R1zmj0y6ntr+A6qSVUWEpprTrQ2iMl9GKEzXFexl9l+JhVhNjZ90gemUr4Ab
 haQw==
X-Gm-Message-State: AOJu0YzvC59WeD4qv7yMe7XFZghQEib9qJGrM7Nra0Tac66/e2AVavKc
 HxjsihTKxAsBhLlQ/riMxX0z0AdrireQkdO131ttlcESmVzjCokD53bb1gFnPO0Ga9c=
X-Gm-Gg: ASbGncsOz23TakaqMsC8bnRt/SzEUlPh/8yEyVyIIyZTRyjR6RhUsFueXPtOFJZVsuA
 /dtovNOn9umYavqOPQ3eHdWjxe4TxfKgw8C9nw9UduBBOJZyA9rUhZseXFTmuJxOZNFLKyPxwfk
 hoKMzs8TvXqtXiG6rSQvBV1YnKHxqlyOoHZ57aix8biWhJdpIJc/wDnqK/ymNdO6FENYJxLaHSj
 g9HsuPwtsPC5gLS+6xwEZiJKVLLZCT1isQiOwaUARpsD5DJ8V3ieZ0lXiaSbRIxj7j0+3T8y71x
 YYUh8vC0PDB4+J+tURx9PTi/+XU61Ijm3gebIets04p6W48hmZsvjEghCCNSpyQZ51dszVvB2FG
 zFTEj7/IllGSPqxlrSEgZyQk=
X-Google-Smtp-Source: AGHT+IG0t1GoD3nltApQgFZJO75dMyeyjzvA1YIR/0LgHcIaphK+JZlaeenLrk/G8XnB6X4mIkU4wQ==
X-Received: by 2002:a17:907:72c9:b0:ae0:7e95:fb with SMTP id
 a640c23a62f3a-ae9b5bc98dfmr307834266b.5.1752578154027; 
 Tue, 15 Jul 2025 04:15:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-611c94f4587sm7088840a12.5.2025.07.15.04.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 04:15:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 71CC75F867;
 Tue, 15 Jul 2025 12:15:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@csgraf.de>,
 Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>, Roman
 Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Richard
 Henderson
 <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, Joelle van Dyne <j@getutm.app>,
 Marc Zyngier <maz@kernel.org>, Danny Canter <danny_canter@apple.com>
Subject: HVF EL2 support in QEMU (aka FEAT_NV/FEAT_NV2) for MacOS
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 15 Jul 2025 12:15:52 +0100
Message-ID: <87zfd5zouv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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


Hi all,

Has anyone had a chance to play with HVF's EL2 support?

Looking at Apple's API docs they provide the following Nested
virtualization APIs since MacOS 15.0+:

  hv_vm_config_get_el2_supported
  hv_vm_config_get_el2_enabled
  hv_vm_config_set_el2_enabled

although they don't give any indication to which silicon supports this.
I'm making the assumption that this is available on M4 silicon but it
would be nice to know if anyone has verified this or has access to the
silicon to check.

Wider context:

We are interested in this for the SplitAccel patches that Philippe is
working on:

  https://gitlab.com/philmd/qemu/-/tags/split-accel-rfc-v8

(preparatory patches are already on list).

The SplitAccel approach works by dynamically switch guests between HVF
and TCG so we can emulate things that HVF can't (for example EL3/EL2)
but still run the main EL1/EL0 workload at full speed.

Currently when we detect the guest enables stage 2 page tables we have
to switch to TCG to run because it would be impractical to manage the
fragmented layer 1 guest memory to present a useful memory to the layer
2 guest. This works but obviously means that any layer 2 guests run a
lot slower. With a fully virtualised EL2 we can just worry about
emulating the less frequently called EL3 services.

Marc mentioned UTM already has NV support although I couldn't find any
references to the above APIs in the utm-edition branch.=20

So to recap:

  - do we know which Apple silicon supports FEAT_NV2?
  - has anyone played with enabling it in QEMU or its forks?
  - what is missing to get this enabled upstream?

And I'd follow that with:

  - is anyone interested in sponsoring some Mac hardware so we could
    enable proper HVF testing in our CI?

Thanks,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

