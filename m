Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DB2C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmof-0004eY-V1; Thu, 13 Jun 2024 11:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHmod-0004cM-4J
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:56:43 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHmoa-0005y7-IM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:56:42 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52bbf73f334so1485951e87.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718294197; x=1718898997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8YtzJE9zAkjTgDWzFu3+UQx6DXuF/sVtVwjxO60G1W0=;
 b=bPMAx4DitT3ur6T+3/LQ1G9Culdrk3EcEKSFqtSywHyoE5Q0od5dJ9+E+ey9ICroqe
 nYrsDa8RnjQmUnp9PMeX0OviGVdMuVbcTbnc10hr/tIB741I7JrQTycJ9MMgiAR8o2EV
 xYkcXileckOn1nlnxwrI/ME6uKBCXZvdBR2D3naYtO4snYrqneQXz5+09zdcyfyGM2o7
 3wu0MK2vAG1j0gCZ8pmx9jTL+nlO5e5iEsnvO35sz03a3blt7bv9Psu5cV3iPw6YYlH+
 mXwZgI/VNqKwTvlgsn/Tj41hTnStJdDsbWUc2H1GpkDWLCYWgFWeDjVIWwE+4UNw5QQk
 COSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718294197; x=1718898997;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8YtzJE9zAkjTgDWzFu3+UQx6DXuF/sVtVwjxO60G1W0=;
 b=dhtXTlDhgevrMtS4DPWZQXkaN3/H6A2acKlTEjTSR/7n4NKr0XkuupCy2HVK1Z//Iy
 gXWr7xROHKtIGTY3VQh33fg/Z4qKoeHs+tbiQCK1r8DdM2QkkEPFIHvNEFbh0VZwk9dB
 ful8mb6X9uY+UNIGIUbpld2Yq0ruajp9sR4hVqgNFzYVu19NOiyWL0DTUFcSI5sJqWT9
 pIIR5KECpnwwBHOvP5xRmF8GM42t5DxExCYokh3Pd9YfVlu8lMqm2L5zuFKEy/i1ytWn
 4JTLIweXlkDY6dBxVpl28hbNn7umOxLBicZrdNYrexOAtFmJ+zpi3kVrAgLSA6QGHh6K
 UnQw==
X-Gm-Message-State: AOJu0Yw780/5gp9CYO5vWjyrxvI2gE+Ct1waHgQfWE34rT3Q8ms+gd1k
 dETXYLXYsqiFHCkO2yFSeWDeOUj36xMrjjvs/N2mbrKtkVkuxCOpHi4S5SptUB0=
X-Google-Smtp-Source: AGHT+IHJaYZKsvz64jRvX35XKihrVj916LiCpv7D+1hg0yA075wN+w0ZLiWmKimWI+45ynqIxOrYNQ==
X-Received: by 2002:a05:6512:6c:b0:52c:8024:1db with SMTP id
 2adb3069b0e04-52ca6e9a378mr100980e87.63.1718294196984; 
 Thu, 13 Jun 2024 08:56:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874de5d5sm66893595e9.33.2024.06.13.08.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:56:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F36735F7A1;
 Thu, 13 Jun 2024 16:56:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  David Hildenbrand <david@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Marcelo Tosatti <mtosatti@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Mark Burton <mburton@qti.qualcomm.com>,
 qemu-s390x@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org,  Laurent Vivier <lvivier@redhat.com>,  Halil Pasic
 <pasic@linux.ibm.com>,  Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  qemu-arm@nongnu.org,  Alexander
 Graf <agraf@csgraf.de>,  Nicholas Piggin <npiggin@gmail.com>,  Marco
 Liebel <mliebel@qti.qualcomm.com>,  Thomas Huth <thuth@redhat.com>,  Roman
 Bolshakov <rbolshakov@ddn.com>,  qemu-ppc@nongnu.org,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Cameron Esfahani <dirty@apple.com>,  Jamie Iles
 <quic_jiles@quicinc.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 8/9] plugins: add time control API
In-Reply-To: <c4d36875-c70d-4e2c-b3a8-c50459c9db0f@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 13 Jun 2024 10:57:22
 +0200")
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-9-alex.bennee@linaro.org>
 <c4d36875-c70d-4e2c-b3a8-c50459c9db0f@linaro.org>
Date: Thu, 13 Jun 2024 16:56:35 +0100
Message-ID: <87r0d0vnt8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 12/6/24 17:35, Alex Benn=C3=A9e wrote:
>> Expose the ability to control time through the plugin API. Only one
>> plugin can control time so it has to request control when loaded.
>> There are probably more corner cases to catch here.
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Some of your patches include this dubious From: header, maybe strip?

I think because my original RFC patches went via Pierrick before pulling
back into my tree. I can clean those up.

>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> [AJB: tweaked user-mode handling]
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20240530220610.1245424-6-pierrick.bouvier@linaro.org>
>> ---
>> plugins/next
>>    - make qemu_plugin_update_ns a NOP in user-mode
>> ---
>>   include/qemu/qemu-plugin.h   | 25 +++++++++++++++++++++++++
>>   plugins/api.c                | 35 +++++++++++++++++++++++++++++++++++
>>   plugins/qemu-plugins.symbols |  2 ++
>>   3 files changed, 62 insertions(+)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

