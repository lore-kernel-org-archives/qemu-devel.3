Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA21DCA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuQlt-0000lE-49; Fri, 05 Sep 2025 03:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuQlq-0000jk-6p
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:22:06 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuQlh-0005LN-Db
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:22:05 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-61e3b74672cso3959418a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757056913; x=1757661713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vC2m595O+CuIEuis8FIZ9s31vR5DEiHeXhrdI1m2u4=;
 b=nTJfwdBR/EPwAyk1KmVDymPGD0Jib/9y9g/FNzt4B1QZUg/LGPL0o/MkFu/TBFY48G
 Yb03ea027SCRLxeSzYbdcbC2LFRdAML9beY2hBxQXt+fnHZ6LvPqWGFeAIJFrAkTanCV
 AyIMPTacS6FSn3sw3Q3nQkTBoEg8n4Z2ntZcRHQ2kAoh9ZpbeRNYHkgnb78U6xiolCAP
 kIYH0mwCgvE3D2panqofwWPVCCOiknkRWVqoA35RIlOqqQLhKXQs5LrzJwWrHHsyC5de
 MQCw3HjR/tRjuPrnpitk++F7LU8Dgl46eIWAuVEGEx3T8x49YO0+XM3p36h9YkS0wpCd
 pJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757056913; x=1757661713;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8vC2m595O+CuIEuis8FIZ9s31vR5DEiHeXhrdI1m2u4=;
 b=tJ7aESVpuH8DYgsZYKABD7IvRYySDcKwtQnvyTbdkB18eAC7BihjCC+RL5zeUxxHHI
 6vt0OIKMRVz3V8429askHwVDZ85G5k4ifLEw3v+4NXA0yeBzKBgx3RahlqwNLYdfAzKi
 rk8Bk7OglWBLpS+Fe/jTkNFcQS7updBJJzdfvQJOSiZoEP3ZQtwBsKszWhj6j+TryyFb
 EyvKIgx5WSaZfdBSFogGYYs1rBPdsnfG8wInIM1tavIhzVzpvBUtDgcE3GujKfiTl8Ft
 nCbcpmA5n4hjGak8qmrM8g5YQVQIeSLbaZPR1VSzRC1nmIHVgjIt3W2Qz02H7Dhl2/cZ
 bdEg==
X-Gm-Message-State: AOJu0Yy+DHYGADbkyb7ZnrcWk/16IkgQsR86Oox/bjky8ITmCvMXFYqK
 Y7wQT0B7lUSYbsAM7iF9rRgl2WhcDwaezINSkINBd6zRjvMXOI8QnjD2CZ/S9pFHZiM=
X-Gm-Gg: ASbGncvCbEvXccDdSe2JOd6YUXuXZftUYcs7sNuRuP6q8/5brXlF7i0Yt3xnVAm9d0D
 aks4nVyyzYRi7AReeQ8RoO1WLHdqONkUGfVLTtWyj/txHzN/4m1HC92i9GLxRknmpgsQKzHFTBe
 MtmKdsA9/VjBY3LBDBc5JIC8VDZOjNmqJm6hJjCaic4SnsJc+o1h80f9rw/Kl9+kbpwY0IKk+th
 e9xj0mc176tHtVg1T46vbLckP4Dug6+QNX2PeBobEKWbN1PLW4Aa0ThXFRi+QEpke4LUblHKzGC
 r8b3jBPKmlWgQNtMmkw5+xSXcdkewkSTCzSlTw8/XpULECo7OKrn07FxHS7V1iPGTtC7Q1Fxmm/
 +RN8Fv1DvG9YAeH3ymmJSlQUWe1OLqaMtVQ==
X-Google-Smtp-Source: AGHT+IEH24+vKLkHQF4W49O9cRlfZ4uJS10YnRtdExi/v1f2uSTFEO9U6FKVlxL2qBCwiB6Uv9LRGQ==
X-Received: by 2002:a05:6402:238c:b0:61c:e287:7ad3 with SMTP id
 4fb4d7f45d1cf-620f3e58fd0mr1675438a12.6.1757056913130; 
 Fri, 05 Sep 2025 00:21:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc22b594sm16522748a12.21.2025.09.05.00.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:21:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5ABBF5F879;
 Fri, 05 Sep 2025 08:21:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  berrange@redhat.com,
 qemu-arm@nongnu.org,  1844144@gmail.com
Subject: Re: [PATCH v2 3/5] tests/guest-debug: Add quiet option to run-tests.py
In-Reply-To: <20250904154640.52687-4-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 4 Sep 2025 15:46:38 +0000")
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <20250904154640.52687-4-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 05 Sep 2025 08:21:51 +0100
Message-ID: <878qitxt2o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

> Add a --quiet option to run-tests.py so it can run without printing any
> messages to the stdout.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/guest-debug/run-test.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index e051e8947c..cf8b37b8b8 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -39,15 +39,17 @@ def get_args():
>      parser.add_argument("--stderr", help=3D"A file to redirect stderr to=
")
>      parser.add_argument("--no-suspend", action=3D"store_true",
>                          help=3D"Ask the binary to not wait for GDB conne=
ction")
> +    parser.add_argument("--quiet", action=3D"store_true", default=3DFals=
e,
> +                        help=3D"Don't print any messages to stdout")
>=20=20
>      return parser.parse_args()
>=20=20
>=20=20
> -def log(output, msg):
> +def log(output, msg, quiet):
>      if output:
>          output.write(msg + "\n")
>          output.flush()
> -    else:
> +    elif not quiet:
>          print(msg)
>=20=20
>=20=20
> @@ -91,7 +93,7 @@ def log(output, msg):
>              cmd =3D f'{args.qemu} {args.qargs} -g {socket_name}{suspend}=
' \
>                  f' {args.binary}'
>=20=20
> -        log(output, "QEMU CMD: %s" % (cmd))
> +        log(output, "QEMU CMD: %s" % (cmd), args.quiet)
>          inferior =3D subprocess.Popen(shlex.split(cmd))
>=20=20
>      # Now launch gdb with our test and collect the result.
> @@ -117,7 +119,7 @@ def log(output, msg):
>=20=20
>=20=20
>      sleep(1)
> -    log(output, "GDB CMD: %s" % (gdb_cmd))
> +    log(output, "GDB CMD: %s" % (gdb_cmd), args.quiet)
>=20=20
>      gdb_env =3D dict(os.environ)
>      gdb_pythonpath =3D gdb_env.get("PYTHONPATH", "").split(os.pathsep)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

