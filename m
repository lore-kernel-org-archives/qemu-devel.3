Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A95C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuOB-0006cV-Ce; Tue, 27 Feb 2024 05:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reuO7-0006au-7w
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:08:39 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reuO4-000062-6o
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:08:38 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d2305589a2so58492031fa.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 02:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709028514; x=1709633314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUf2vQYQNAnqenfvbkvh0HpkOGseOXFZ+5ibC1yJM6I=;
 b=Z63E+VX27864w9nrBW5dNMBlIEvN5dDlb9zatQYN1EKBM3W7hbDDGUSQZwHiWgy3xz
 S38A8iN504QxWw4/zdjPPqnct4iQQG2OP82llxwBUUmmNtfI/cYpGlqRBjKSpkjHYfzD
 6WRBTuFDD8ccL0FGQzoocAQMSS6nsSL+uPgDd2k1VbZMMrgIlZkQv/afnZa0XOtAic6D
 CdlYiy/HHvlawhzJGe8SYcm4YaqBZXjw3DITfpMMtUfXpjBTZMzfAFedNbXNyRd32BUc
 k4cKCeGkykYfFQ5Yw03lrVc666nV4FUJU65McyaYQ8n4+5K7UJkPsaVoqeOOSEO4wr4L
 eWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709028514; x=1709633314;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SUf2vQYQNAnqenfvbkvh0HpkOGseOXFZ+5ibC1yJM6I=;
 b=XOLMkycXzFvU8tCyob0SoOXN6s1dUa9XBLn9ZT07xOSsz2tIEfRKL2CD2rBX+PQk4j
 18ABO+80E9/qYKgOLECQaJQ0fb1kaYib63eRPpT5PTcMUVtqnps8MAncWksOLP8I4orH
 6bb+TjixcgyeUEillaiSl7+UGc47n7aJnP1N65EHAzQVkaZqkFAm4BpYTJww8VbuxHL7
 LKNeoR6i1BOol83XwanuAn7B8HAD08ytXMsrKFL7WhghkygT7DfjwD1/5e+QRpGmrXRr
 yia953l98Whqe/US23R92t5p0Ht1CuwzMphvei7eZmAkTcStUn0OF9rh+8a04fVvaN/y
 Zf2Q==
X-Gm-Message-State: AOJu0YxR8bf+a2jOvnu/hK4061WwQQ/QJYxlrIFHMEtd8LRQRdcNegJW
 TkdpvS/foNIdACAM9QcQ1J9ohdWZOJ52BHdaaINod9n4XWZig5VaU4SvQyGDzVQ=
X-Google-Smtp-Source: AGHT+IEKx8ZAAeu8eaSyhvntSGB4xFhD3hxbksf6E05asCI9y2j4mur5Hde4qxFJ/EVA2UF5gBFFFQ==
X-Received: by 2002:a2e:8044:0:b0:2d2:8bdd:2ed5 with SMTP id
 p4-20020a2e8044000000b002d28bdd2ed5mr2936385ljg.35.1709028513647; 
 Tue, 27 Feb 2024 02:08:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c3-20020adfe703000000b0033d6fe3f6absm10874714wrm.62.2024.02.27.02.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 02:08:33 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB8925F78A;
 Tue, 27 Feb 2024 10:08:32 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Nicholas Piggin <npiggin@gmail.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  qemu-riscv@nongnu.org,  Michael
 Rolnik <mrolnik@gmail.com>,  Song Gao <gaosong@loongson.cn>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  John Snow <jsnow@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 qemu-arm@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Thomas Huth <thuth@redhat.com>,  Yoshinori
 Sato <ysato@users.sourceforge.jp>,  Yanan Wang <wangyanan55@huawei.com>,
 Brian Cain <bcain@quicinc.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Bin Meng <bin.meng@windriver.com>,  Laurent
 Vivier <laurent@vivier.eu>,  Palmer Dabbelt <palmer@dabbelt.com>,  Daniel
 Henrique Barboza <danielhb413@gmail.com>,  Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 21/27] plugins: add an API to read registers
In-Reply-To: <b7aac53e-cde5-4596-b0fc-d39f52d4ceb8@daynix.com> (Akihiko
 Odaki's message of "Tue, 27 Feb 2024 16:47:26 +0900")
References: <20240226165646.425600-1-alex.bennee@linaro.org>
 <20240226165646.425600-22-alex.bennee@linaro.org>
 <b7aac53e-cde5-4596-b0fc-d39f52d4ceb8@daynix.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Tue, 27 Feb 2024 10:08:32 +0000
Message-ID: <878r36dxsv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2024/02/27 1:56, Alex Benn=C3=A9e wrote:
>> We can only request a list of registers once the vCPU has been
>> initialised so the user needs to use either call the get function on
>> vCPU initialisation or during the translation phase.
>> We don't expose the reg number to the plugin instead hiding it
>> behind
>> an opaque handle. For now this is just the gdb_regnum encapsulated in
>> an anonymous GPOINTER but in future as we add more state for plugins
>> to track we can expand it.
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
> Hi,
>
> Mostly looks good. I have a few trivial comments so please have a look
> at them.

Done

<snip>
>> +        g_array_append_val(find_data, desc);
>> +    }
>> +
>> +    return find_data;
>> +}
>> +
>> +GArray *qemu_plugin_get_registers(void)
>> +{
>> +    g_assert(current_cpu);
>> +
>> +    g_autoptr(GArray) regs =3D gdb_get_register_list(current_cpu);
>> +    return regs->len ? create_register_handles(current_cpu, regs) : NUL=
L;
>
> Why do you need regs->len check?

Not all guests expose register to gdb so we need to catch that:

  TEST    catch-syscalls-with-libinsn.so on alpha
**
ERROR:../../plugins/api.c:459:qemu_plugin_get_registers: assertion failed: =
(regs->len)
Aborted

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

