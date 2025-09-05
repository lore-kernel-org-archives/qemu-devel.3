Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B591CCA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuQml-0002CZ-LI; Fri, 05 Sep 2025 03:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuQmk-0002C4-3M
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:23:02 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuQmZ-0006BN-3X
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:23:00 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-afebb6d4093so365000566b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757056968; x=1757661768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWu7FbIe4I2S6aKukhLQ8uiyJqgxneGf7rUqa6wxVmo=;
 b=CPa7AchZUNgJ21A2TRpimdXaP05b40V3vxXfsj5c6kGZLYGI86Oe3r0r0aoez+gt2j
 HwHRZLLL3TVcD3sGAsvXHTzwuVZXjtq+ymig+2WYpmesGLrVu+JT/l1uBSblO27HKcxx
 lU9tcwNjVAU+0iV+WXbPYFU9OeuJYX5MEjwVAxlTlAmxuy1yg/YAVbR+uN3/EPZrmr+9
 fppYwLBjAerxaS1AJEgnuxsfceXxdJe/OgkZfbMA2VRvsOshmX8ACPTUAas7IcSO9QB/
 NpiANwO9Q0Jii8NUz81MTlOFH3dcJxXHqZHTcAW/Gldofqs/uNyIYcctQ8rDkrXZg4Iu
 mK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757056968; x=1757661768;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VWu7FbIe4I2S6aKukhLQ8uiyJqgxneGf7rUqa6wxVmo=;
 b=H5oNCE9PJppXtwZ9Cwj0y3TyNs55Tr8dipZA2ockUESoN1LFo8JCdH/7n0N49j107B
 N8FTMAgie+SuQjycW+JuD6Y0XYc/dslE30+W9vlJ/U5Vr6IqBRZ2Exp6cjgpeVdvHOem
 ZZUIUTrqNYmGSwinGkYu6rNO8wcIYtvzeg87bOwsXYK0lgZcwrfWI8ULfNs+5EGUohts
 /QdYu3fTmOT4jNP/0jJqyINXQzl6ej9PR2Iruii0SQGENsyCAA4EOCy4Ly6CkW+JpZUb
 OjueqGj2VezZgOcdBp5UVQxmvx2x8NcGRUZnzuspNZ6A39PQxqfH1/m9g7YifkNpr62I
 PXFg==
X-Gm-Message-State: AOJu0Yy38YVbLFcPpxp0bg3j7IgmZkkG4Hdjg/MYGETqeap+cNH6Gtgw
 5WaO9tNpNB9z4nnz7ImNFaUb5WlavOKdfs6AevVBA0fN227CxuyzWeHlexbujSCDZWc=
X-Gm-Gg: ASbGncu/9aLoXcF6/YJjTo0Oi88PMCNP9N67uIxZ8b00MUIKeWRLq3fn7A+7VDLkeS1
 eqoQqMUOvkCzSp+NKdHfP72P1GiXQGiJym+2A8puCmbmI6ogP3D5P/pXnEB67R8NIBNRVEVuxUG
 R8V3o06a4gskMqkmBfHVud82EtTn14xT56BlsSy+SyiSwHJw6cF3JF5/WBQ3AzdulRXpKwVSQ8e
 UKhknkS/egJbpV5iGleMSW4i/9ACZb9XBnc9fBI65DY2/UVFKcFiVoSzuwj4q7rSpI5ge5E+Mlx
 SAKEhJFjlAsRCCMIwWUqAxio13wzV8z/4QUaomYfH+vr4SuElGUzcKa/4jrzGd5odxDwJFvx6kg
 m/D08vryWyce2C9nOuYSEcc4=
X-Google-Smtp-Source: AGHT+IEfLKh+HocvcdIgShf54nK1Dap/VIH4mszvFLQjMhfhZsRd/AvVnSCf62Bj0tEL9ii6Eash9Q==
X-Received: by 2002:a17:907:9455:b0:ad5:777d:83d8 with SMTP id
 a640c23a62f3a-b01d8c98c4emr2090955766b.29.1757056967866; 
 Fri, 05 Sep 2025 00:22:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff3dd9574fsm1640695466b.84.2025.09.05.00.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:22:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37A155F879;
 Fri, 05 Sep 2025 08:22:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  thuth@redhat.com,  berrange@redhat.com,
 qemu-arm@nongnu.org,  1844144@gmail.com
Subject: Re: [PATCH v2 1/5] tests/guest-debug: Make QEMU optional in
 run-test.py
In-Reply-To: <20250904154640.52687-2-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 4 Sep 2025 15:46:36 +0000")
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <20250904154640.52687-2-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 05 Sep 2025 08:22:46 +0100
Message-ID: <87wm6dwegp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

> This commit makes QEMU optional in run-test.py, allowing it to be used
> as a GDB runner, i.e., to call GDB and pass a test script to it without
> launching QEMU. In this configuration, it is the test script=E2=80=99s du=
ty to
> configure and run the VMs that GDB connects to.
>
> sys.argv passed via -ex now includes the full path to the test script in
> addition to the script=E2=80=99s arguments, which allows unittest introsp=
ection
> to work properly in case it is used in the test script.
>
> The --binary option continues to be required when --qemu is passed.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/guest-debug/run-test.py | 60 +++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
>
> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
> index 75e9c92e03..d21a5dda77 100755
> --- a/tests/guest-debug/run-test.py
> +++ b/tests/guest-debug/run-test.py
> @@ -15,6 +15,7 @@
>  import subprocess
>  import shutil
>  import shlex
> +import sys
>  import os
>  from time import sleep
>  from tempfile import TemporaryDirectory
> @@ -22,10 +23,10 @@
>  def get_args():
>      parser =3D argparse.ArgumentParser(description=3D"A gdbstub test run=
ner")
>      parser.add_argument("--qemu", help=3D"Qemu binary for test",
> -                        required=3DTrue)
> +                        required=3DFalse)
>      parser.add_argument("--qargs", help=3D"Qemu arguments for test")
>      parser.add_argument("--binary", help=3D"Binary to debug",
> -                        required=3DTrue)
> +                        required=3D'--qemu' in sys.argv)
>      parser.add_argument("--test", help=3D"GDB test script")
>      parser.add_argument('test_args', nargs=3D'*',
>                          help=3D"Additional args for GDB test script. "
> @@ -73,27 +74,30 @@ def log(output, msg):
>      socket_dir =3D TemporaryDirectory("qemu-gdbstub")
>      socket_name =3D os.path.join(socket_dir.name, "gdbstub.socket")
>=20=20
> -    # Launch QEMU with binary
> -    if "system" in args.qemu:
> -        if args.no_suspend:
> -            suspend =3D ''
> +    if args.qemu:
> +        # Launch QEMU with binary.
> +        if "system" in args.qemu:
> +            if args.no_suspend:
> +                suspend =3D ''
> +            else:
> +                suspend =3D ' -S'
> +            cmd =3D f'{args.qemu} {args.qargs} {args.binary}' \
> +                f'{suspend} -gdb unix:path=3D{socket_name},server=3Don'
>          else:
> -            suspend =3D ' -S'
> -        cmd =3D f'{args.qemu} {args.qargs} {args.binary}' \
> -            f'{suspend} -gdb unix:path=3D{socket_name},server=3Don'
> -    else:
> -        if args.no_suspend:
> -            suspend =3D ',suspend=3Dn'
> -        else:
> -            suspend =3D ''
> -        cmd =3D f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
> -            f' {args.binary}'
> +            if args.no_suspend:
> +                suspend =3D ',suspend=3Dn'
> +            else:
> +                suspend =3D ''
> +            cmd =3D f'{args.qemu} {args.qargs} -g {socket_name}{suspend}=
' \
> +                f' {args.binary}'
>=20=20
> -    log(output, "QEMU CMD: %s" % (cmd))
> -    inferior =3D subprocess.Popen(shlex.split(cmd))
> +        log(output, "QEMU CMD: %s" % (cmd))
> +        inferior =3D subprocess.Popen(shlex.split(cmd))
>=20=20
>      # Now launch gdb with our test and collect the result
> -    gdb_cmd =3D "%s %s" % (args.gdb, args.binary)
> +    gdb_cmd =3D args.gdb
> +    if args.binary:
> +        gdb_cmd +=3D " %s" % (args.binary)
>      if args.gdb_args:
>          gdb_cmd +=3D " %s" % (args.gdb_args)
>      # run quietly and ignore .gdbinit
> @@ -103,11 +107,12 @@ def log(output, msg):
>      # disable prompts in case of crash
>      gdb_cmd +=3D " -ex 'set confirm off'"
>      # connect to remote
> -    gdb_cmd +=3D " -ex 'target remote %s'" % (socket_name)
> +    if args.qemu:
> +        gdb_cmd +=3D " -ex 'target remote %s'" % (socket_name)
>      # finally the test script itself
>      if args.test:
> -        if args.test_args:
> -            gdb_cmd +=3D f" -ex \"py sys.argv=3D{args.test_args}\""
> +        argv =3D [args.test] + args.test_args
> +        gdb_cmd +=3D f" -ex \"py sys.argv=3D{argv}\""
>          gdb_cmd +=3D " -x %s" % (args.test)
>=20=20
>=20=20
> @@ -129,10 +134,11 @@ def log(output, msg):
>          log(output, "GDB crashed? (%d, %d) SKIPPING" % (result, result -=
 128))
>          exit(0)
>=20=20
> -    try:
> -        inferior.wait(2)
> -    except subprocess.TimeoutExpired:
> -        log(output, "GDB never connected? Killed guest")
> -        inferior.kill()
> +    if args.qemu:
> +        try:
> +            inferior.wait(2)
> +        except subprocess.TimeoutExpired:
> +            log(output, "GDB never connected? Killed guest")
> +            inferior.kill()
>=20=20
>      exit(result)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

