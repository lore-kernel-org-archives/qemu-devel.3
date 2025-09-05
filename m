Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4B4CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuQlv-0000mw-9h; Fri, 05 Sep 2025 03:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuQlt-0000ls-Bk
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:22:09 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuQlr-0005OW-Bl
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:22:09 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b0428b537e5so315540766b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757056924; x=1757661724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZrLKJPhuA4bKjq3AxPPHJAqx7WHycMGtCtMHtbeggM=;
 b=At6/7+SIXS9L/5dCHthL/r5WYBQyIzQ4nAnmGaEujhvVyVpf4h1tuL2ZZcFli6+HHE
 IGNI6jYGIHZJwEZTOLYrrMqy1+S3tK0/xauOZDHV3aouZl8F+IuhlIAV90ki14IGJDkB
 XUpRMaShRfV1up+OO6yW69sbRncdctrpEfQbqIyhRRZ2lrSVNNU7KGUpNFziGz3gDZPx
 vn8k0YPF9J7naDaCQL0N37IMBli66F8xHKBbPRW2WzPUL/9UFEZuieCCwB8RpZ8kjqaZ
 AdIfkrJoXLjM1XvASDcvgZeGtoLsBI3R9yHdTRLla+yfeQI8Ct765ZRuieuFV/KpILQi
 LuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757056924; x=1757661724;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fZrLKJPhuA4bKjq3AxPPHJAqx7WHycMGtCtMHtbeggM=;
 b=Zp246TnSYhoW6upqbBGZgVHp1X7VHfewaIi4MrFON9KpGt2G5O+Xs8VGC6WashTeNW
 L9Pt1jEKOcW9veGaZSzU1xnPe3bHkPH5zuWO7EbJnSACdJLBH4pkCMSS7OFhVAPTMAlv
 Bs7wcBfmlWJKxHCo+vvp5qqZxTfAeBSEPfMRefbaros87TRXYkJmuoGqYpfcyuqAfzLT
 5j40urkUCm+ifSU4LcqJGeyjz7ipB2yaM3msMzRmUm0ewjUkJQIQIuLAWV60jKku5/iG
 VdTA/oI39P/tHq3nLqNpDNgbpTLxxAKvvoQBbkG29mL/kebAofDb9hPK5fU4lOEhnZPD
 sojA==
X-Gm-Message-State: AOJu0Yx8R2o0DZiYonvvqaO7TAqlBcOPMWaH7eGyfPA9xrNhc2PQot10
 IOD8+eNt9pRP3VLjJGy6hGmfg1vR+eVpdCY7dNtyT0i0SnDUyUyhSWpo7cYAMEgefi0=
X-Gm-Gg: ASbGncv8RDy/dR/NuMnCV6exFTM+/1Kx7REJB86vipch1lWXyYkGLqKAvpb78cMjj6B
 rADd17h2igncf1h6LkzjVoPpsYgW3b0eRSsYXalZo9j7jdcOv+H73bCKKb081H5iy1WYryMQZgG
 A0ppV6xgP+RZIZ/gRgtgBiB+GzpkvD7bvfRVbreBzckT9f2bi+dS08i+WnVBcpFgyZC4f3o8j03
 X9yNfMaz4S5E6n/T21iPYmR3hUbrn2ujHSVJuZnrYKfeCBwN+o8Xmkh+wakJDtMBAuodZZ+HWu6
 2WyLuKPblnp12ARgN2A49Dl4R9UXEbPFdgAF4w5LAy9FWdRaabVvZEvvBhe6FptMND7OXtGp1U/
 bFmbhvCFEqf3UdyVqQknJkYbUZdmXYt8A9Q==
X-Google-Smtp-Source: AGHT+IHo+qv/H1dbxxRg7YAwOBV2xFhT7TNWG6HN0Oiahp10k380fqf5erJngjYm0Ojay9v7Re9oFg==
X-Received: by 2002:a17:907:2d1f:b0:b04:388f:254 with SMTP id
 a640c23a62f3a-b04388f4b95mr1507943866b.59.1757056923809; 
 Fri, 05 Sep 2025 00:22:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff0d9b1b53sm1654938666b.96.2025.09.05.00.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:22:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4544B5F879;
 Fri, 05 Sep 2025 08:22:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  berrange@redhat.com,
 qemu-arm@nongnu.org,  1844144@gmail.com
Subject: Re: [PATCH v2 2/5] tests/guest-debug: Format comments
In-Reply-To: <20250904154640.52687-3-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 4 Sep 2025 15:46:37 +0000")
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <20250904154640.52687-3-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 05 Sep 2025 08:22:02 +0100
Message-ID: <873491xt2d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> Capitalize and add periods to comments.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/guest-debug/run-test.py | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index d21a5dda77..e051e8947c 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -54,7 +54,7 @@ def log(output, msg):
>  if __name__ =3D=3D '__main__':
>      args =3D get_args()
>=20=20
> -    # Search for a gdb we can use
> +    # Search for a gdb we can use.
>      if not args.gdb:
>          args.gdb =3D shutil.which("gdb-multiarch")
>      if not args.gdb:
> @@ -94,22 +94,22 @@ def log(output, msg):
>          log(output, "QEMU CMD: %s" % (cmd))
>          inferior =3D subprocess.Popen(shlex.split(cmd))
>=20=20
> -    # Now launch gdb with our test and collect the result
> +    # Now launch gdb with our test and collect the result.
>      gdb_cmd =3D args.gdb
>      if args.binary:
>          gdb_cmd +=3D " %s" % (args.binary)
>      if args.gdb_args:
>          gdb_cmd +=3D " %s" % (args.gdb_args)
> -    # run quietly and ignore .gdbinit
> +    # Run quietly and ignore .gdbinit.
>      gdb_cmd +=3D " -q -n -batch"
> -    # disable pagination
> +    # Disable pagination.
>      gdb_cmd +=3D " -ex 'set pagination off'"
> -    # disable prompts in case of crash
> +    # Disable prompts in case of crash.
>      gdb_cmd +=3D " -ex 'set confirm off'"
> -    # connect to remote
> +    # Connect automatically to remote only if QEMU is launched.
>      if args.qemu:
>          gdb_cmd +=3D " -ex 'target remote %s'" % (socket_name)
> -    # finally the test script itself
> +    # Finally the test script itself.
>      if args.test:
>          argv =3D [args.test] + args.test_args
>          gdb_cmd +=3D f" -ex \"py sys.argv=3D{argv}\""

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

