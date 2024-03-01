Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2206AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 11:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg19E-0004dB-0e; Fri, 01 Mar 2024 06:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg19B-0004ck-5S
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 06:33:49 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg199-0002ZR-MG
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 06:33:48 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so362507166b.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 03:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709292826; x=1709897626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ofuE77d68LMi0fffi4FhBVynmgIr9dIkVDHmDGVo4A=;
 b=tIiuoNeddEBjGcDcab2k0VKMXx7k6265yMVSHz4fLe8kBSIO1HjYlPsb+OmUcdkzJJ
 SwOkPcR84tMKCnPtMDBDrcsH0TvJoo0UKKsWDKK3ddj0L3JAdqXsW0W9VeBldWO7u91w
 hdRTtnE/Esi46v0hReBrygOX9ehkNToVWn6h7rfSp4LI+Eavw+7SHU7qgaEuq40Twm+B
 WeYOdOmhTv9+Gcn6f1Lc4UE+i+EU6TIc9J9dIyOBoFo/GkTOHRs+UwENPylAlnKu86Au
 N33oXrZdzKupPwprGRT6i3miHs2DE71n0zzz4ruC6px9oiqjONCDHnSnQooXhzYezrVN
 VWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709292826; x=1709897626;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ofuE77d68LMi0fffi4FhBVynmgIr9dIkVDHmDGVo4A=;
 b=kFY4qV1YwEUGjIK38H5T4HpLWXWorWMhiOHHK6oNktJKOuCdyML+wlxg7FN3xk1bqv
 EqqpC2UHoTCigCGJ26IKKdOOOh/r7Digv0EwJG8R4Yyiw+0InCniDd4jojOVICSaSWtC
 gmNhtdKzSahGga8Iq4Numosv8xt42I8v0LO7zcRaijRYxbIN/p2cdhWZtlhQ2yX/k1pz
 AJvmXefmpZAW41c89F7PazrYeESVU47MALYhTJZLryemWrDb/+nxafjgGHfNq1zLVqtL
 yJ4R8X11jypHrXScFI6uj+756ZL5tJRoTr9Ty4vXNVEt2uX5WnglNjn/BHsHxVBVw32X
 Nfhg==
X-Gm-Message-State: AOJu0Yx9NPaJEEm6+/NxnO8jT3+HyjzbgeyQqx/G+az6SiEhKBPHGKeI
 BCR5zMpZ2Rlz2E6C7Ibi59nHCf1MKENSqOAOltmWPgtR0rkBmutKFPS/zL8Okbk=
X-Google-Smtp-Source: AGHT+IGGKDLYOtXnLLmCGyNoDYSjNNpgD2aqec0FJz9AwgZzVOmwcE+lmBg1ORWSo56/ZGEAo5pzDA==
X-Received: by 2002:a17:906:c06:b0:a3e:73c8:cd27 with SMTP id
 s6-20020a1709060c0600b00a3e73c8cd27mr1052159ejf.73.1709292825719; 
 Fri, 01 Mar 2024 03:33:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h18-20020a5d5052000000b0033cf4e47496sm4294632wrt.51.2024.03.01.03.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 03:33:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC5525F7DF;
 Fri,  1 Mar 2024 11:33:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: <qemu-devel@nongnu.org>,  <sstabellini@kernel.org>,  <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,
 "David Hildenbrand" <david@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [QEMU][PATCH v3 1/7] softmmu: physmem: Split ram_block_add()
In-Reply-To: <20240227223501.28475-2-vikram.garhwal@amd.com> (Vikram Garhwal's
 message of "Tue, 27 Feb 2024 14:34:55 -0800")
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-2-vikram.garhwal@amd.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Fri, 01 Mar 2024 11:33:44 +0000
Message-ID: <87bk7y5gpz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Vikram Garhwal <vikram.garhwal@amd.com> writes:

> Extract ram block list update to a new function ram_block_add_list(). Thi=
s is
> done to support grant mappings which adds a memory region for granted mem=
ory and
> updates the ram_block list.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

