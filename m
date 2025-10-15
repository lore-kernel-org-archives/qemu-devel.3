Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAAACCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 11:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8zQK-0005Pr-5Y; Wed, 15 Oct 2025 07:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8zQI-0005Pj-QE
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:12:02 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8zQE-0000uX-N5
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:12:02 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-63bdc7d939fso2830231a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760526713; x=1761131513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86/bvUm2pyDLY8JINuMAXfEBZkYmm4TAByqk9F7AXp8=;
 b=BPfvpB2aEsBUbaaUBqlzMugz0Yghyw8t3uJqLiyBSPABUKoCWYjC+i/bLcuufO3Ote
 +bKxOOuGAZb5erRveH+APMRMjX6G+lLHzOVfPG0E6sYXkGQmzmWCqj2rNPu0Vv4ouPCD
 GIuA2123SXU5/92Jjrs+ykAiXTwnC0wajch06LFIkG4oR2wgKGras5TEO4rjZ218vPDx
 XGtxSgevdl6nLpfw+UY22YChlya7vdhxsV7nA1oGwmyBCdRhDnPbxEtDAb5Qmczp4U42
 t4s8F4MI7Ur4brNoFT06GnBdvvj6DLQnHskNUcYekZfDR2pzPnaiiTN3ZTRXDLJjbAJf
 A12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760526713; x=1761131513;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=86/bvUm2pyDLY8JINuMAXfEBZkYmm4TAByqk9F7AXp8=;
 b=jd/N2c0GUN/TXK2muF7YoEzRg4191zW/clLr3lN3HsMPIKjkrAgNMQhrXovAi9ciFe
 g46xohhACNqk/Np3SflBZ3Xq2zVbX97+/XL9SzRSsv7OYGsacuWq1Dzquj916e3hMQ1u
 41WXoXVlS6EUIFLmUmcgTy3Py7gDA+3Rh2ruif0VWdHaboEelpEsfP50oSQlUS9VYDw7
 wmzTUWaFPjYxe5vurIGzmgH+lRSaus3BntaMHNBZWI/9nFrOKGYq3/PYW37YIWt9CtGv
 9y6hbTVZWadF3vF9CXn4pMDxQKPtCdTW6/ugq8BwCD350HruYq9chK+1i9BnCvvYsVPX
 KNaw==
X-Gm-Message-State: AOJu0Yxl6lxm9oLOTNMACeLrJ8o/xZr55ZJsegDOlCMVMk5rH6ARJ+H2
 /IzT2FGQWWGNpBH35akC8Gtffbu8alTa0x6v1wXGiFq+l+0kdBQI+nsOfs8o8OQILqM=
X-Gm-Gg: ASbGncumB3hDbNjzu2T9D3ExvkHDnlN4FH58qePIY/rhCHTws+P1a3VXzPag1CQ7squ
 4vIlnVZl4LJl5pAw28lYRr+MAtYnCMm+dUsIFSlwgI/LBn+rcTr4tLH6b5WUkZdslWv9jJlEAqw
 vXOvYG/JX38s8SG61aS6bYJiLr1NSekvW05CwbP5QNtl8V97Txgdeo+5NDr1ua2mzoe+PIE9quy
 p3KVX+a/K3gWtxxFXpTu1mA/o0zATpXIoBNohPAWUPJZfEgz2H80MkluJGOkI22nuMAUrrV75JL
 aFsLL8hV1G865XwBQbfKaMzWxaWm5o1H2x3bDHr4i/5feCG8osRUvsFzWH9jfL2Y44AIK11IgMg
 hJbdFL3aNM8fx8KNv5EksGlkuJXTqgbuZ+NSjYhEXLc7CmziQO7gcWs0b
X-Google-Smtp-Source: AGHT+IFPjCy6gTo06bl+eGfzIzLkElc2hwpcFzoDUJu6c4TJBAtddwwmsbFmHYy/sgVv/of8d7qKmg==
X-Received: by 2002:a05:6402:3589:b0:63b:f1aa:11c8 with SMTP id
 4fb4d7f45d1cf-63bf1aa13b0mr1414624a12.10.1760526713422; 
 Wed, 15 Oct 2025 04:11:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5235dcdasm13240947a12.6.2025.10.15.04.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 04:11:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 780045F83C;
 Wed, 15 Oct 2025 12:11:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Phil =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: generate debug
 files to map symbols to source
In-Reply-To: <20251013213912.413386-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 13 Oct 2025 14:39:12 -0700")
References: <20251013213912.413386-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Wed, 15 Oct 2025 12:11:51 +0100
Message-ID: <87h5w0ju6g.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

> Enhance uftrace_symbols.py to generate .dbg files, containing
> source location for every symbol present in .sym file.
> It allows to use uftrace {replay,dump} --srcline and show origin of
> functions, connecting trace to original source code.
>
> It was first implemented with pyelftools DWARF parser, which was way
> to slow (~minutes) to get locations for every symbol in the linux
> kernel. Thus, we use addr2line instead, which runs in seconds.
>
> As well, there were some bugs with latest pyelftools release,
> requiring to run master version, which is not installable with pip.
> Thus, since we now require binutils (addr2line), we can ditch pyelftools
> based implementation and simply rely on nm to get symbols information,
> which is faster and better.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Queued to maintainer/oct-2025, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

