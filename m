Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8A5CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 17:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyvgZ-00030w-Kh; Wed, 17 Sep 2025 13:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyvgW-0002n3-8W
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 13:11:12 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyvgU-0002IW-5o
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 13:11:11 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so4513566b.2
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758129068; x=1758733868; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=grsr+Iq/mix8BTrbbHjAbQj7y1SeDEmAzwyPj+04tok=;
 b=Rv6ZUaw9NFLa609YG5/eOveqWkEH4jLq/FKYmWAJG0GE3MlpH1oW65Mb1UEl+5JOfs
 5qq2LjF4mxi/Uzdt+/90EnArgxH5rssY7L0B3WmEpRBlgOcnkjkj1idJzs07ffuvLqOn
 cgX9w1W4QF4D2lTP3jWkBlWWFHctCVpLKfHzdj6KktaxEMPzbb58iBUmoEj8soJxHdee
 GT/GpEGm+kGUuLBgKfpK6zC/g0e4WnhBjHyCVIgY1PUcG0PT7rEMuOTjMAmUADCjX2zm
 E4GdUvC/T5hRaNZhUik79Krk9ad0Vc562cbF8yFqpf2fhP1Xs6Fk6x2x1UWFqaOU2oAY
 XadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758129068; x=1758733868;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=grsr+Iq/mix8BTrbbHjAbQj7y1SeDEmAzwyPj+04tok=;
 b=H3J+lUeZQZTB6EDLtitgBDiYQv5+035utnL5mxDuK+Cg1CPG5IUB0sqBk+6ujFGDll
 ayRZ5hxG/rWN8vdnSWFk5pszdmSm1fcEbNgG/WMqoXykkO6G7purRkMUyXCsoZO+wNAY
 RdxoH5sZ2C8mt8JNi1QXfm0b7XvAE+LEGP98oEuUkkaQIfwfQutynJyd+FsCYl1f23Gg
 gh6IBMsMYvCE8OqjCLpyEn8fMIzYdgqw4AEzCuM2wePmR+OL/BM1Q4ShptiMI+iDb+SS
 nomrLjfpA8O6JjETHpffZEINwjcaFity1tiefCGbKEG7fz+Ze0Hr4wmQqXf8kZBd6u7h
 /LLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLmTyfzmUG9XiJ6+bxszJBgTw5uyhuXO2lpqGes5OT6mbDvn8Ntdx2yUjexTbl1FnZPAIARoVydA9C@nongnu.org
X-Gm-Message-State: AOJu0Ywgdta8aV8ccSAuaFAoRPgM+E+5ioP9b4iizPMb/ENSC1KEE4cq
 Jp8pU+V7jnAuGpNWLNN2aCyQbZS7UzMRanuipD5/J7OFPXd/SuwhO0fL
X-Gm-Gg: ASbGncuWQVqJqsyJbiD/aajjhZEH53l0/SGlrq4aOMeAYe1Pmx3Hl5tjkgxyCGmMIRp
 SrJCSetaumQXE3Fvzpuf9RuCqUgWsEaWJymLURtk/YHkMNtfgd5NSQJBHAZhQTSkqIoPiTESXVX
 IhvENj+CxcMZ38ngFGTlFnHYobxySzK6bLX2QukHt1ypPw4GnfGiY1VHQNgoVjxAXH4JJ/iD5Sd
 hnO+rIEev5SGp/37yzIJbAHxroAgR/CEhfU7elPJOg3JNnbmXnkrAJGbJBunfvx5LaDD/+909ef
 9Zopd8kLa28wutcI/wfOUb7saIld8tHc4NrLpgZIrEl4RYv4JlUopjj4OXlSe/azBroXcfJ8M9a
 CTu9stO143Q3qD0++qAVA31Qs6RqocdErYg8r8PuLWM5EJHnKVQ==
X-Google-Smtp-Source: AGHT+IEE0Z9SGOaCD2PSebtfjMvxpDQbCV674MmKYu4c/DWIxXwoBTVXrWhSMIvoJZ3Ho9hXFeTyfA==
X-Received: by 2002:a17:906:f58f:b0:b04:1896:1236 with SMTP id
 a640c23a62f3a-b1bb62399d6mr330831266b.22.1758129067981; 
 Wed, 17 Sep 2025 10:11:07 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b1fd262993asm9049766b.94.2025.09.17.10.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 10:11:07 -0700 (PDT)
Message-ID: <e2f80c7ad10b8b6376144ba5d959a2ad4739f81c.camel@gmail.com>
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, amit@kernel.org, 
 armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 lvivier@redhat.com, 	marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, 	noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org, 
 wangyanan55@huawei.com, zhao1.liu@intel.com, nsg@linux.ibm.com
Date: Wed, 17 Sep 2025 19:11:03 +0200
In-Reply-To: <aMrfGUfCSWnvkXzT@redhat.com>
References: <20250915162535.147642-1-maxbr@linux.ibm.com>
 <20250915163415.149190-1-maxbr@linux.ibm.com>
 <4c8e1ae5dd16d6ee4bcb42ed25d2987bc2c4a3cc.camel@gmail.com>
 <95142e7fd2a103cfb8d8bea9727117bfe952baec.camel@linux.ibm.com>
 <E0EFD1A6-09E9-481D-82FD-84FD4B45CA9B@gmail.com>
 <aMq4Ta4aPwRgDrxR@redhat.com>
 <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
 <aMrfGUfCSWnvkXzT@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 2025-09-17 at 17:17 +0100, Daniel P. Berrang=C3=A9 wrote:

> We shouldn't send any size info to the guest if the hsot backend
> does not have it available.

Does that mean sending 0x0, or not sending anything at all? The later
is tricky,=C2=A0because for non-multiport devices it's only really possible
by not offering the feature bit, but we don't know upfront whether the
size command will be used.

