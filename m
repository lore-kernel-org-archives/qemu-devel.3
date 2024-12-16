Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014D1E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 17:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNEiC-0004BV-Kx; Mon, 16 Dec 2024 12:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNEi3-00043Z-U5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:16:44 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNEhx-0000Ez-4b
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:16:43 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa69107179cso815291466b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734369394; x=1734974194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBM4uFpiayLJP/bLXti6ZTvwMuTbtotx1NQbTLq1mY8=;
 b=VdoFcMOAgq6XbX5QPp5a9F8sS/OllR/lySoBRePys0hqPWrp8b94kVbvbM4ftx+bbd
 YKJ+l3MxPepWuou/tGGFIFJJFFckGGW74cz5Qm5MtH4DFt7/BOTjBkaNo3BfGehwr2hQ
 HHWdyn0eSZEoaAt2OD3iojUOLuUxxdVxxE8ykWsW+Tc1dg3bHk0ADMQSlAieQB6ZtWxc
 Jha/qjzcZmf1MSRXhLrXhXP7N+mStqiDPhKc6HHKYun01seCa4jUzuR5eoVtpl3pOr5M
 cDSD+mba6Ape2gDkbqw72BWvbx+sZIJ35pOHn/dYsSsisaw74gI9psJx7p2fIBPK8PsK
 C13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734369394; x=1734974194;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GBM4uFpiayLJP/bLXti6ZTvwMuTbtotx1NQbTLq1mY8=;
 b=JyPKNSvEvDJXVOLy9xIuB8WiVBDdyGtp1eGMITcn4zyU210pS+lzkjgXenOx/o0hW6
 bo5eIoA1+Hkekva9/5GFyT1Z5+Ab9ylsaEWcrkdH19qFHtFtZ3QLci5sWgrayMOytLXP
 ygq4HyuxPSKM1AqG2TdBWilpcGVP4qLchinw/BkNIoDpVFdPNFAj+VmBqiUiPyL17yLr
 ebFfrarR4tJTHkUU0c6VRAS2ZecVF8q1j9DbZ6AjGTHZsNmOWx6vEVRc/Is1AHnbE40z
 SfT/l8OLPDpXRi04jq5gw93HeiNce0B8muD2mCGuXp7unSKCuA9aQztYfOA8iITtjGd+
 4GEQ==
X-Gm-Message-State: AOJu0YxUXeAHaNDvznm+A5hAdokabygWv07D0Dy4hYCZjLGAiXwGIsUv
 1+3r8lmye8K513wIx5//O37zpyM9w2AMvVMMsg5yALwChXcE6t2mXFFf1oJufWJNj1XrxqNuqy2
 lml8=
X-Gm-Gg: ASbGnctrj+ABH1ml5ZnKj5XoisCuzQL6ickn24vPJeflnyuz3mDYvXM3LzFWG01auYM
 w/1McOlasfNfN1HMvEFbJtMsMTszTnQvAzsEmpYqh+jwEPVOmrl2aYNmjJNCEd7s4IXkbDt6/kB
 mAXGciMiVGHCpK1RrdI3YB1PENmZm6RljcpR7+cRRIMUoQmpdbVRsC6uiWXb9dbKgEYMZROgoBS
 vf+OG57LxJdXnjwc90TrwVTcZf4XzIxNHkydorcX1XNeXPLUMYaLI8=
X-Google-Smtp-Source: AGHT+IGVyfqFHYRqv4RLpllqzRlpHhRxNN4YWpb5a1wMUm/28DGqk6pNna02r/BdxLXV21fwWynbKQ==
X-Received: by 2002:a17:906:3112:b0:aa6:7ab9:e24d with SMTP id
 a640c23a62f3a-aab77ed3586mr1224978966b.57.1734369394131; 
 Mon, 16 Dec 2024 09:16:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab963c5477sm354444866b.185.2024.12.16.09.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 09:16:33 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0A74D5F952;
 Mon, 16 Dec 2024 17:16:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Fabiano Rosas <farosas@suse.de>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 2/3] tests: Use qemu_mkdir_with_parents() for all test code
In-Reply-To: <20241216161413.1644171-3-peterx@redhat.com> (Peter Xu's message
 of "Mon, 16 Dec 2024 11:14:12 -0500")
References: <20241216161413.1644171-1-peterx@redhat.com>
 <20241216161413.1644171-3-peterx@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 16 Dec 2024 17:16:33 +0000
Message-ID: <87ikrj1rbi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Peter Xu <peterx@redhat.com> writes:

> Coverity isn't happy on the QEMU test cases where g_mkdir_with_parents() =
is
> used without checking retvals.  Use qemu_mkdir_with_parents() to fix them.
>
> Resolves: Coverity CID 1568381
> Resolves: Coverity CID 1568378
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

