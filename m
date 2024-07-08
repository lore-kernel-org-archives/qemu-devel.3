Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82675C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 10:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQm38-0004UC-Jx; Mon, 08 Jul 2024 06:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQm37-0004P2-AQ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 06:56:49 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQm35-00077x-Hk
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 06:56:49 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ee910d6a9dso34473941fa.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 03:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720436204; x=1721041004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5E/TJ3iKOD/Br8SAMzPU8V5xfd4+J2s4GWsTX84yntw=;
 b=lK01+OynfflDC+f5j0leEGnPS6nrSsvKhXRthfNcIWqNavMn77BStWroHhx8oVDdno
 jB31J6d5iNASrlDtdBky0bNRMKhcfzlJVvNcRVtTz0a9GfUgGWtwhapfsQoLdGmGX9/U
 CbPpd5bp29cEA0FooxgADpymOujfY41gMtB8fPoDp4bakL5+EdQGjniqHl2EzQofsNVn
 GkjBzF9NS+YfY4YkMWssXUP6iJS9JQQZ1AMn4bHIJRTL/OuwV5JL1ZP9At7gO4jIJESf
 N70a25WfW6xqeLOnHS2ZS2cDJ4n+wkYpYhieeDe7ae7Ik5OedS4Rb//a7WWOpxHyW/Qq
 RG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720436204; x=1721041004;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5E/TJ3iKOD/Br8SAMzPU8V5xfd4+J2s4GWsTX84yntw=;
 b=sq0VjPgCSOtJlcbgF6/acNzZyRLUk5bddpSVrj0KhkHZLU/C2xsHsPRi8pE3r5Lrgt
 0Byon01f9t+9NdFIVAfMkjslvDTzvrRe98fenMM4NPzZW9MTwl4tpFLAeU0uGWbm29NS
 G4w2/O08KI8H/5Gz90YHfnXAk5Z4/mssi54Mdb3pPdgrJfYgUBMnlbiu8J620ANMoDJp
 To7CjVHeWvOfTqFuBpyfcJIsAzcYmOqnKCPhyVFcz3YcybVOomWiZ2S44AZ+QwbjnVNn
 xgqW1jKNAByUH17O8P6bqPsRT9gyf+cjIdrsFlNnDEPZBTLki/9DR/Fxf2ZCXoXxgDs3
 I/RA==
X-Gm-Message-State: AOJu0YzY8V5mEHODd+MM+F6Ul08+RDmfb9KXwmGt744LTGMzsHmiyDba
 PkO72uovk2NcKLmR/aoGpNsvYHtgA5zE81L6lt+A/yQ4qoRxHe1mgMYa6gAMEsU=
X-Google-Smtp-Source: AGHT+IGO8STdse2YvXgczy/gJE+Lzl2fnqjAUVdgAThNk+UlywJnEdv6ZKT+v6901+ouxRyqXR0MEA==
X-Received: by 2002:a2e:b0ed:0:b0:2ee:4d91:3d88 with SMTP id
 38308e7fff4ca-2ee8ed8bb73mr73535021fa.16.1720436203945; 
 Mon, 08 Jul 2024 03:56:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-586138185ebsm12752403a12.52.2024.07.08.03.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 03:56:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C3F005F7A1;
 Mon,  8 Jul 2024 11:56:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Yanan Wang <wangyanan55@huawei.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v6 3/7] plugins: extend API to get latest memory value
 accessed
In-Reply-To: <20240706191335.878142-4-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Sat, 6 Jul 2024 12:13:31 -0700")
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
 <20240706191335.878142-4-pierrick.bouvier@linaro.org>
Date: Mon, 08 Jul 2024 11:56:42 +0100
Message-ID: <87msmstamt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22f.google.com
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

> This value can be accessed only during a memory callback, using
> new qemu_plugin_mem_get_value function.
>
> Returned value can be extended when QEMU will support accesses wider
> than 128 bits.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1719
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2152
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

