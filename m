Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E298DCE7B17
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZKx-0006pc-BV; Fri, 06 Sep 2024 09:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smZKv-0006o6-Fi
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:49:17 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smZKt-0002Lj-Pw
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:49:17 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c241feb80dso6076598a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725630554; x=1726235354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gC0ptLVRSdsg6xiI82CowBgQaBgNyGgi5EBpVv1ToGk=;
 b=lLLmE1qvOoW7iNwfQsUDHdnz9YkRZAgs2fHZP/OyafFoO7UmvNccLymZV5F37kDPiM
 iZQtBT4fzSYXtTAphot4GfiUpndSaYOvvGhOzdg/32Y74SmsvGzUbwxFHX/LHekLID+j
 lwFoWtFmwiG1vnjaZ69AZEXvYFP0mFWEBBDovXG9YlHbifmeThM9cmR/3ZrwCiJ0Rs6h
 Ok1K9QSNNeFT2nEY43Hr87AS99gXkyKcMz/RcKj6DH3lMm1HHuuXzeK4FWUYadUQTw9D
 cYFxZLD7pfauT/+dVZLOvLvL4vOvh1xa4edXdLOVBi8U4DP1tkroOaeIVos0RCIcRPzy
 e8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725630554; x=1726235354;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gC0ptLVRSdsg6xiI82CowBgQaBgNyGgi5EBpVv1ToGk=;
 b=VI8Br9g4j573uwiZI1ZvqrfYaWsxdOoNuvyiHmUUSUgH2XIWddaIIB93NJKi+cVAV4
 rd94qlU9EYkbr/RcnlvOIeFajnNOb6QfSY7b4V5wl/6EEugtS7lHnoa3MipubjJRyiWt
 UOBCV+jEb0WX6mAqR1CoEpTOQDWPMH5jLHjv3MQaopDxai9J2hCZUduxhKHB21q14Bwc
 3JC26UbTFwbZygg0PqkHzQtqahKQoLeuk/1VjDgOy6USe4ACsMs7wR9MdWFnK69BbQ02
 AKasoeuPAi8s6sQ0oyAdGCOHcpzR7YcoLaxmVvxWBrHDIFfu+0mjC+oezQM9q4sBKS7P
 cUgA==
X-Gm-Message-State: AOJu0YyHC+9L0ZwHHIwJVvifrs0XZs6dLWLOFh2u1wQFkUOYsr+YsT70
 edsS55pXb7kd3C+Kfh2MQz/+ZWfKW44QitDpvb5rMgOyuLghFvYsHauaXKgioJ8=
X-Google-Smtp-Source: AGHT+IGKv+GMbozsnCsJ/tFb7fyc62PMjrOMcDtxDv9nEbQtlf4y16pW/eRnOb/rTc6lvRfevwoTig==
X-Received: by 2002:a05:6402:84d:b0:5c2:5248:a929 with SMTP id
 4fb4d7f45d1cf-5c3db976252mr3308396a12.7.1725630553147; 
 Fri, 06 Sep 2024 06:49:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc56d686sm2466217a12.56.2024.09.06.06.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 06:49:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9502E5F754;
 Fri,  6 Sep 2024 14:49:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 philmd@linaro.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v3 3/4] tests/guest-debug: Support passing arguments to
 the GDB test script
In-Reply-To: <20240825145208.46774-4-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Sun, 25 Aug 2024 14:52:07 +0000")
References: <20240825145208.46774-1-gustavo.romero@linaro.org>
 <20240825145208.46774-4-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 06 Sep 2024 14:49:11 +0100
Message-ID: <87plpgsxig.fsf@draig.linaro.org>
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> This commit adds support for passing arguments to the GDB test scripts
> so it's possible to parse the args in an "argparse way" in the test
> scripts launched by the runner. The arguments should be preceded by --
> when passed to the runner. For example, passing "--help" arg to the
> GDB_TEST_SCRIPT:
>
> run-test.py [...] --test <GDB_TEST_SCRIPT> -- --help
>
> The test script should not use the argparse module directly but import
> arg_parser from test_gdbstub module. arg_parser then can be used just
> like the argparse.ArgumentParser class:
>
> from test_gdbstub import arg_parser
>
> p =3D arg_parser(prog=3D"test-mytest.py", description=3D"My test.")
> p.add_argument("--vowel", help=3D"Select vowel",
>                required=3DTrue, choices=3D['a','e','i','o','u'])
> [...]
>
> The arg_parser allows a smooth and informative exit if, for instance,
> the caller of the runner script passes an invalid argument or misses a
> required argument by the test script.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

