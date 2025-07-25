Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49693C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHmz-00045D-Ii; Fri, 25 Jul 2025 08:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufHmy-00042C-8w
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:44:40 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufHmt-0005bt-82
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:44:40 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so3780330a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753447471; x=1754052271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJiQqSAvXR6o1jPOui+yHg4UcpZN5VpE6Xt3/PzW5Cw=;
 b=TufvvqoCxXVQsjhef1kUGTM8IOoe9ib0OFY5Yeohzb2EEzWOgUVYrW3Gl2suLmAadx
 pbjgiuDdWtl+Z6RCfX53lDIhNhqPWjDFeWWb7+uk3jM4N+mGOqGkY3dyXh3SWs2Ln59W
 kd8jV4VwNre6npFsP6HoXF1ztfAvUyQxCsWxR8pmP8KLY896bTJZ6zWC9VyEVjUYdDjC
 fmaz2CVGHfx72Z2SF0DAAZYorvUmMyDMjBZZukoEaDFe76m4AbjV/upptQQJZgyAcXfa
 uaVNs2JW42jVkXWOQqaTTZfpdag1+INEf3rYgDh3FVZzD90M3S/VdKs+4XDqcs/kjhnD
 ikTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753447471; x=1754052271;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TJiQqSAvXR6o1jPOui+yHg4UcpZN5VpE6Xt3/PzW5Cw=;
 b=lZ1TGkQ8u7WpGD/MRchaMmpVbABTBYBqq8shgUqls7lDnzzrQkZra3gsSrAVVW44IN
 JKp2yRtpJHQgrdsdCKCIgGWgDQnc3kamPXSNjxXxYq9hh+X1tbIrlPEsRo0Iozu+v2bE
 bjbOchZxMKaHxmOQj0ohC85W9Imu+am5KBkY+xs/ztLdatngp7NtMoi13SUrg084A0RS
 am2yc0dc6TatLo1z43e1juCOzBov1akskPPD9qC/w3i77QsZs+4Vl2oNPsHGU6x8O6Yz
 ZxAaDZipE21CyC+knodFQNlVSHuiiwEa216IkxUQPiF90J0IP1hN2zrbpvK6PWk1dpKe
 3dpA==
X-Gm-Message-State: AOJu0YxgjX89rDpl73XVBSa5RAmRdg7toSIziSnkzqpvvCYBtb9SGxz1
 FXN/XggnWQ1W14tgWAWW0PTl8qw3a+NLD9vD3cueeYWn7NHn62WSTZKhubWxgwFooOk=
X-Gm-Gg: ASbGncuwMMlY7GZNgci+J5PKY3NORK4bgJTzuVYg124KcNE6xmpGajPiiqUcl4T4Y0G
 GlKQP8qBiLr/+YFmc6dtCcd2BpmWCbA8pdqsJ+arC5pCuNtuRZ5D8f82Yyj+fw5S/Ifb5qnNXhv
 LBjmpRVGGkPbWkn+sIzi2N5nxAHJKa30raOIAIqSzKw6QF3ptgFINSE3nI/JnlQxhNfMIAwPHyB
 /zMP1AVbyRD83FaUAn6BDiJDOFiEhbv29yj4LC8IRwnR41+BO/xzVNrPLXJ9Gx8I5wQL+NmYKpf
 1wMcR50Di70cKoMu6ELNsU4JEfN6+gmlogc7UuKC1bSR90Q+fvkbGOWcac7LO9DW2rl6xdcOkJ5
 8bnbjxlAtn9bGN3KtqDVMJcU=
X-Google-Smtp-Source: AGHT+IFqETvVIFEOx8eKbe/MAVee1RpuSEZGTluWz5GX9ni30lZZ8+QKgdLwNlN2huZ0PaFcGNTJNA==
X-Received: by 2002:a17:907:d716:b0:ad5:3a97:8438 with SMTP id
 a640c23a62f3a-af6196080e4mr259306566b.41.1753447471316; 
 Fri, 25 Jul 2025 05:44:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-614cd2fdb37sm2081069a12.36.2025.07.25.05.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:44:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D1A25F7EE;
 Fri, 25 Jul 2025 13:44:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/4] tests/functional: add --debug CLI arg
In-Reply-To: <20250725-functional_tests_debug_arg-v3-1-b89921baf810@linaro.org>
 (Manos Pitsidianakis's message of "Fri, 25 Jul 2025 12:41:22 +0300")
References: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
 <20250725-functional_tests_debug_arg-v3-1-b89921baf810@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 25 Jul 2025 13:44:29 +0100
Message-ID: <87pldosamq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Add argument parsing to functional tests to improve developer experience
> when running individual tests. All logs are printed to stdout
> interspersed with TAP output.
>
> Example usage, assuming current build directory with qemu source code in
> the parent directory (see docs/devel/testing/functional.rst for details):
>
>   $ export PYTHONPATH=3D../python:../tests/functional
>   $ export QEMU_TEST_QEMU_BINARY=3D"$(pwd)/qemu-system-aarch64"
>   $ ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --help
>   usage: test_aarch64_virt [-h] [-d]
>
>   QEMU Functional test
>
>   options:
>     -h, --help   show this help message and exit
>     -d, --debug  Also print test and console logs on stdout. This will
>                  make the TAP output invalid and is meant for debugging
>                  only.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

