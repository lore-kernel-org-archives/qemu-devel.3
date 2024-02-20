Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B5DC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRJL-0004vp-SF; Tue, 20 Feb 2024 09:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcRJI-0004uz-Pn
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:41:30 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcRJH-0007sm-29
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:41:28 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33d509c5706so1301408f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 06:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708440085; x=1709044885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CseO12IZWpluw7w/fZtimbbG1umHRrjekjlm8CTpjIo=;
 b=uKaZ86DJ3xLg4FQEkHOyGCnulI5XMOp4cjQ9MFBAtu/h8/HFx0bvj5HwixGYYov6jQ
 hcgT4uxS60e7yT+++LfIIuE7HSW602pGvjKYeDA20huErjatixCOvrIbxWjvkoGi+BII
 PJmtBX91OWlSF4vIzqXWwKcUpfp36HkXLD82VPX1JGkfY+NN0hKC4GYWtSTAzLlwdUHe
 +/phvndemAQcCJbkoPkR+LQQefgmNfI9h0XTIvJQnPQMAkLIYsRHMcHOS9ZyTioZe4KP
 2AX6GvDl31TTfrYqOdz27T6dqQcTR4elChePd+TqqP6OM17ydCCsI76VghudlwPFYTcm
 jyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708440085; x=1709044885;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CseO12IZWpluw7w/fZtimbbG1umHRrjekjlm8CTpjIo=;
 b=CFPizhYcI+u7tD4kMlEZIIwW8t0jocsHP2UhCZ7N9DDioEMPsXVHuYqtOPYPLEffyy
 tbejg6myF7boqQ3qWUXUHZg9Z07lHSSn/yxoCp1uDBU1Yo5P9lLULSQ7QG6Ngo+OFt13
 MPG89ulU7o2z3ockms4hTovCRQeqc7z2el24jASgWNkpwRldhWSpvB9++2OA6+sadCSr
 rCJWVOkc2qkWAPIUFgN5S9C+VI4CrFIw8wvCueIXA4dPjtXuNQ8s0UEHdPoYBrJN2yKI
 fOm5LGtZDMff3a6bmd35qzjPbxNOLewglMSTgOkknUfHHV29lrIsK6zMG9vdM+/kK2Fs
 D2iA==
X-Gm-Message-State: AOJu0YyZM6Z4q8731S283P2nzSVuVwpE9C11M2Tyez9wM1+x7OMuOEfj
 EI84tjYb3tkYdGt4JzEJiH//wJNn44MvvCIDM9lXaVq9BoaIwNj4kZXGF4UtB71lx1aRSeRh6sa
 4
X-Google-Smtp-Source: AGHT+IEwvSeJS4r66lPSe/j4kVhT+T8mWcq1+oBEbYDbZAydNX0rVZ6dNGiXKcHLuSI9euheQZAESw==
X-Received: by 2002:adf:e6c3:0:b0:33c:ddc2:ca0c with SMTP id
 y3-20020adfe6c3000000b0033cddc2ca0cmr10807109wrm.56.1708440085426; 
 Tue, 20 Feb 2024 06:41:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 14-20020a056000154e00b0033d10bd6612sm14015970wry.81.2024.02.20.06.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 06:41:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E74A5F85F;
 Tue, 20 Feb 2024 14:41:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Faiq Ali Sayed <faiqueali.109@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: QNX VM hang on Qemu
In-Reply-To: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 (Faiq Ali Sayed's message of "Tue, 20 Feb 2024 14:31:46 +0100")
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Tue, 20 Feb 2024 14:41:24 +0000
Message-ID: <87a5nvci5n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Faiq Ali Sayed <faiqueali.109@gmail.com> writes:

> Hi everyone,=20
> I am facing an issue during booting QNX VM using Qemu,
> I have an image to Boot the VM. and when I trigger a Qemu command to crea=
te a VM it is stuck.
> I also used a debugger to investigate but I can not see any result by GDB.
>
> Here is the output of first windows
>
> qemu-system-aarch64 -M xlnx-zcu102 -m 16G -serial mon:stdio -display none=
 -device
> loader,file=3DQNX-IFS,addr=3D0x00100000,cpu-num=3D0 -drive
> file=3D/home/faiq/Downloads/install/BootSD/qemu-boot_sd.img,if=3Dsd,forma=
t=3Draw,index=3D1 -boot mode=3D5 -net
> nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem -net nic,model=3Dcad=
ence_gem -net
> nic,model=3Dcadence_gem,netdev=3Dxzynq0 -netdev user,id=3Dxzynq0,tftp=3D/=
tftpboot  -nographic -global
> xlnx,zynqmp-boot.cpu-num=3D0 -global 'xlnx,zynqmp-boot.use-pmufw=3Dtrue' =
-s -S
>
> qemu-system-aarch64: warning: hub 0 is not connected to host network

Is this QNX VM image built for the xlnx-zcu102 board?

> on the other hand, here is the output of GDB:
>
> (gdb) target remote :1234
> Remote debugging using :1234
> warning: No executable has been specified and target does not support
> determining executable automatically.  Try using the "file" command.
> 0x0000000000100000 in ?? ()
> (gdb) c
> Continuing.

You'll either want the debug symbols for your image or tell GDB what the
target arch is. Check you are somewhere sane by doing:

  x/10i $pc

and step through the instructions and see where it goes. If you hit
Ctrl-C are you executing nonsense instructions or in a tight loop
hanging?


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

