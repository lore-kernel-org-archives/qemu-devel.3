Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7743AEE0208
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 17:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQuQ-0007Fl-2s; Wed, 11 Sep 2024 13:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soQuO-0007Ah-L3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 13:13:36 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soQuM-0007lm-0w
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 13:13:36 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so10411066b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726074811; x=1726679611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGhdTq0Xy+ClkhZr9gmGWzxymj1JyxKdKuheJAvsOOc=;
 b=kC3IhXNNRDi6txQXA6XIM1RGiyH3eCdA6Es3lrqJSkuygSMQd0Xpb+GBBUO9o+c4qD
 xxR28V/RxuBdebYWTqg06P0pLMPMBHWrZoTRC/LVnIH9n/3mmsU6S363brFtd5J9ukK0
 hPCq87j/Qj9vcQzRQ8uZbrpjoATeqY91t5GKdVnLUZvXr+dbsvB2jlHqTOnjXYz1HyzL
 0kGQ0t2z2mahutaCMn9vMge60QnhxPGC/cNhLtUrdyc4GHcv+Wgsfo0hiXe39Y1FnHpX
 e+NFDoiZlkgCBBZsA/f+clwLKLHjm53ZFvNV1vIYFZH0liWi62NBkoP79+107GXCikyN
 Zq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726074811; x=1726679611;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zGhdTq0Xy+ClkhZr9gmGWzxymj1JyxKdKuheJAvsOOc=;
 b=w/f1vRDrBNjjGa0tO8WfHotpzZuFIgYhtI67u1V9mv5CLld25XEryJ9OG/OV00wHek
 y/o2uVECuWn9J6p73mBoOEbtQW3HB2TAsVs8h+RBedfGp99u+SqSMOHYOdW6MSHvVoE6
 K4UNCmJDQYhYK6vrmfduDxUThDlXiiRLsDh9s89AnSXKdN/m6/mhhSfqn2ZYRwxnapYr
 dqo0qZnEIlCQESkdKU3cO0AN0oqjtUvwvDnhkJtgrqQ5OJQLUVzoF1+nUjOXhCnc1GU0
 686rYBZ+sS7xe5g+lNHHgi/QaSNgFRoiMftGH8xRXcWmJ97dmXpSCDTRy91dSFZbvlC8
 6I1w==
X-Gm-Message-State: AOJu0Yy8Y+03ODHnOp10ellL9FoNbqTbUv9nAKBHUaMfvYWosL2A8EZL
 POROUfdCMdE/Vwx834M4RF9CHxGNLLLXh7cHXYqDXYQSyRwDkUTEauIrOqtvWrw=
X-Google-Smtp-Source: AGHT+IGGzrvjAf/dZvKOyi9sZKUED2HidYQWL3BWDrIGS7LQ6Oh7RVu5IuhfLqwFRQsgn1PnSznjaA==
X-Received: by 2002:a17:907:c7d4:b0:a8d:60e2:3972 with SMTP id
 a640c23a62f3a-a902943a562mr17728766b.23.1726074810999; 
 Wed, 11 Sep 2024 10:13:30 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d5da53sm631677166b.209.2024.09.11.10.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 10:13:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 88EFD5F898;
 Wed, 11 Sep 2024 18:13:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Nicholas Piggin <npiggin@gmail.com>,  Daniel
 Henrique Barboza <danielhb413@gmail.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Eduardo
 Habkost <eduardo@habkost.net>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 qemu-ppc@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v8 6/6] tests/tcg/multiarch: add test for plugin memory
 access
In-Reply-To: <20240910172033.1427812-7-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 10 Sep 2024 10:20:33 -0700")
References: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
 <20240910172033.1427812-7-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 11 Sep 2024 18:13:29 +0100
Message-ID: <874j6mw1ty.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Add an explicit test to check expected memory values are read/written.
> 8,16,32 load/store are tested for all arch.
> 64,128 load/store are tested for aarch64/x64.
> atomic operations (8,16,32,64) are tested for x64 only.
>
> By default, atomic accesses are non atomic if a single cpu is running,
> so we force creation of a second one by creating a new thread first.
>
> load/store helpers code path can't be triggered easily in user mode (no
> softmmu), so we can't test it here.
>
> Output of test-plugin-mem-access.c is the list of expected patterns in
> plugin output. By reading stdout, we can compare to plugins output and
> have a multiarch test.
>
> Can be run with:
> make -C build/tests/tcg/$ARCH-linux-user
> run-plugin-test-plugin-mem-access-with-libmem.so

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

