Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3128FC369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 12:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Dda-0002rj-J9; Fri, 11 Apr 2025 08:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u3DdU-0002pX-Rf
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 08:37:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u3DdP-00017A-DS
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 08:37:31 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so17351345e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744375030; x=1744979830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFl1LtPi/tano5zQKSLUXmodk+784obeqQ0NHFnd5I0=;
 b=Csnk3hP/F9u8VjJSZjvlBa9h8XbcP/FYYvF0PePKVdHHG2n2WKBzb7+uaybMzeqSOH
 ecFQ62du5kISdwZTubVYpOyie1F/mD7LGOhe2xwxYNFNe/q3jjv8ICHDBN4Hr4GC4HCt
 5Efnt0Bt402hkZ3tQCRGRf7o2YQoQo2A9oiRFCgeCKjC80Zz5UOpZPuHWQtcqb1CVpMD
 /XPERXt7U3N3zPNjObeJXgBap+PWg5JjufNXotnPJCfe8H4D00Vxz0xOy7b2j8RrntnY
 TKd+lbCv+kS7VjxcbDdBl2RrGSIFCdjN6prDpHGpUKgBbYBWdwHlhQ1IdzsXbMH/fcxF
 N0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375030; x=1744979830;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yFl1LtPi/tano5zQKSLUXmodk+784obeqQ0NHFnd5I0=;
 b=FrFOTp9QTKmdZbgAWwtq2MIUhi8KDPEGNUxieSUINSaa6YNtOvTHIcbDfwdEWvKIKx
 qbXPpMliAPumP2LUwnbD+jBiGNnXAYZ35kjmydGWxAubw0xcQIWMXzP7LAdFe4Rl+uOj
 KbUFI3M+cqt9tmtk2vobsS1mlezBW9obQW8TzP0iONDMDfLmVPIFH3YtH0ep41MgLgJO
 QOk+Mjvp/ORzd6DjyoNqw0R5oY7H15X+kqlqzQ7w28v2mAhMZXPl/aFFGPnIP3SwyaA3
 Ih7FBzNbDHGinE61zbqj8+c7GrgqDHKVSsimZPeFYJhGfFMX4gAWT+/XCs9Xd93FlcgK
 YyYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUZcwCR5pxJcOqosajt1iaoetAPwHmFs8RV36RZy+b2G2JHYngAI7EGwBSMXOuORSPy+JVnMAsDQHt@nongnu.org
X-Gm-Message-State: AOJu0Yyo2hWviHolPjeiFBn4k+nUEj3s+Af3ovpOlzt6r9215N3B9lKh
 qxnMX7PL0t70QKjyLSukJmqhFeAbGkEzcgwUQ6vT81nJmL/mayOR8n0YSMoXH8M=
X-Gm-Gg: ASbGncuBd49x7R2K1AsXl6Fxd9qCHXStrtmIDdRVHWKsOS/qsNZJNxW/R3iXu7Ej8BT
 LCt8Yft618cJUwqPq5yEBbAABq/Mg+nnUTnToa4kmkL6cr0Zlqa7AI/CkNxVQBrgpKYyshQkOZU
 P6OJcOaOWYmdtyjOKSyQrr9OO7FZtaoqCkD6rpEq1FHr+OKZFP6scbUwT7I1jc5IBcCRAYlBYlt
 5Az3S/MxCjgDHL+9KPSBuiMZJhRYjg/mGfXLj/XgUt61vidJl83cZ5C5zL4BkReJjYo2B2Q/ml2
 vRd3I2pxhM713N8hcTD3Gd2y+J/jKUh8BgCJQXrYPfk=
X-Google-Smtp-Source: AGHT+IEhLFyf+l7mOxmCm0OiJfG5Jcw+8K8vqrUbLt3bpcGluw2SpIpuEoW0Tm2ognKGHC/uQO2J9g==
X-Received: by 2002:a05:600c:4e13:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-43f3a9add63mr25111585e9.27.1744375030114; 
 Fri, 11 Apr 2025 05:37:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c184sm1933503f8f.30.2025.04.11.05.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 05:37:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8EB005F8B0;
 Fri, 11 Apr 2025 13:37:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Saanjh Sengupta <saanjhsengupta@outlook.com>
Cc: "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>,  "pbonzini@redhat.com"
 <pbonzini@redhat.com>,  "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>,  "amir.gonnen@neuroblade.ai"
 <amir.gonnen@neuroblade.ai>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "aabhashswain25@gmail.com"
 <aabhashswain25@gmail.com>,  "aniantre@gmail.com" <aniantre@gmail.com>,
 "guptapriyanshi180@gmail.com" <guptapriyanshi180@gmail.com>,
 "harshitgupta5049@gmail.com" <harshitgupta5049@gmail.com>
Subject: Re: Issue with stoptrigger.c Plugin in QEMU Emulation
In-Reply-To: <E57BEAE6-4DE5-4FF7-AADE-DB43678FE2E6@outlook.com> (Saanjh
 Sengupta's message of "Thu, 10 Apr 2025 11:10:23 +0000")
References: <E57BEAE6-4DE5-4FF7-AADE-DB43678FE2E6@outlook.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 11 Apr 2025 13:37:08 +0100
Message-ID: <87a58mg9hn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Saanjh Sengupta <saanjhsengupta@outlook.com> writes:

> Hi,
>
> I am writing to seek assistance with an issue I am experiencing while usi=
ng the stoptrigger.c plugin in QEMU emulation. I am
> currently utilising the latest QEMU version, 9.2.92, and attempting to em=
ulate the Debian 11 as the operating system.=20
>
> The command I am using to emulate QEMU is as follows:
> ./build/qemu-system-x86_64 -m 2048M -smp 2 -boot c -nographic -serial mon=
:stdio -nic
> tap,ifname=3Dtap0,script=3Dno,downscript=3Dno  -hda debian11.qcow2 -icoun=
t shift=3D0 -plugin .
> /build/contrib/plugins/libstoptrigger.so,icount=3D9000000000 -d plugin -q=
mp tcp:localhost:4444,server,wait=3Doff
>
> However, when I attempt to use the -icount shift=3D0 option, the plugin f=
ails with the error "Basic icount read". I have
> attached a screenshot of the error for your reference.

icount and libstoptrigger are independent of each other. You do not need
to enable icount to use libstoptrigger.

>
> error.png
>=20=20
>
> When I remove the -plugin argument from the command the OS boots up perfe=
ctly, as expected. Command utilised in that
> context was somewhat like ./build/qemu-system-x86_64 -m 2048M -smp 2 -boo=
t c -nographic -serial mon:stdio -nic
> tap,ifname=3Dtap0,script=3Dno,downscript=3Dno  -hda debian11.qcow2 -icoun=
t shift=3D0 -qmp
> tcp:localhost:4444,server,wait=3Doff
>
> I would greatly appreciate it if you could provide guidance on resolving =
this issue. Specifically, I would like to know the cause
> of the error and any potential solutions or workarounds that could be imp=
lemented to successfully use the stoptrigger.c
> plugin with the -icount shift=3D0 option.

It's likely the instrumentation libstoptrigger does has changed the size
of some of the translation blocks leading to the error being triggered.
To know exactly what is going wrong we would need to see a backtrace of
the failure. The case:

        if (!cpu->neg.can_do_io) {
            error_report("Bad icount read");
            exit(1);
        }

is basically saying you are trying to read icount at a point its not a
known precise value. Any attempt to do a device access should trigger a
TB recompile so the device access is on the last translated instruction
of the block. However if a TCG helper queries time and its not the last
instruction in a block that would trigger it.


>
> Regards
>
> Saanjh Sengupta

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

