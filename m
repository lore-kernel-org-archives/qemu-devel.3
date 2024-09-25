Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FD6C369C8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 10:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPV0-00051d-5t; Wed, 25 Sep 2024 06:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stPUx-0004zO-Uw
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 06:43:56 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stPUr-0007jh-Hi
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 06:43:53 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so910555066b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 03:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727261027; x=1727865827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEyLcbbUmoimlSxWtCc/AqtMImzoDYNz7E3YoARLTFU=;
 b=sw2Hsjm2fmCwAreQCKrPmv+HoqZvTCZ7blj3Odb+YlP6JPPXR/IUfrW/dkfgOuIJp0
 e+Ut5HPV4fDyrRWqffquMDFG263vMoMx4XL/i8B2spdtDt6sT7Cmf6663j/N4ix6+gny
 8d7SqZPhqTR9twm1zMaZ+AokyQv40asBF/TSQojQJ1S+ZOhTu9SCP9+BwLG+kFcpw0Up
 QGhPqDY6LY1bVqZz3QJliieXLsW/rhJ4vnd4e31uYqgHeSVC2k9XRViEH1kRywvhUs/g
 CcVdxr8geo/X5lz1Q/E+eN1QKidrjde4BS1rXf1n1E3ekA4yQy5/8GkT29lkg9djusnC
 elZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727261027; x=1727865827;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KEyLcbbUmoimlSxWtCc/AqtMImzoDYNz7E3YoARLTFU=;
 b=gve0DyFrHOjUyD5nLuCU2GTcL2wLxAGV4UsHQf3Ux4NNUk/xEsUFwWAJeHDm2WYMb+
 DV2ugicE3EkBUDXlxWPOm9YwNtndAZeoaQhIwy6kOGR0BaObr3lij12fgl609LmiHjXn
 xAOvwmFXHDwdI8KxlVCym01h055mRFyQAr722hZxNE3PDKkvXkpVPr4TwMi20MLrd68I
 VYjMDalhDmadFst4utEL0Z42TYgcT7+M8zSh0UAB20vgn9c02QpQf20P/I6etbUfscO0
 0igasbx5f0TLjIcujDqobwEP5MYOi/ODveDE/Im20NCNP0UaFyJKZdrjq7AuUFzzqqA0
 yBMA==
X-Gm-Message-State: AOJu0YxovNJuU02ze3bJpMWPi6rxJSyshHtsvhyv6r2Q+AVpBrfv0vZX
 PjAByzzvajtXs34NeVdxWM/oXaqCA2B1tIWNv8ZijtAl9CPAIXKFDfNxNHfPues=
X-Google-Smtp-Source: AGHT+IHLwSMuBlfv82ofByDVJBnGyj1eTbb5/5Lk5t91jXVWPw3N612xva9I7YnIAmKK8vq2mQmT6g==
X-Received: by 2002:a17:906:cac9:b0:a8d:44a5:1c2f with SMTP id
 a640c23a62f3a-a93a03200e6mr198321266b.6.1727261027535; 
 Wed, 25 Sep 2024 03:43:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f470asm194654166b.151.2024.09.25.03.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 03:43:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E309F5F885;
 Wed, 25 Sep 2024 11:43:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  David Hildenbrand <david@redhat.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  kvm@vger.kernel.org,  Thomas Huth
 <thuth@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-s390x@nongnu.org,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v3 0/3] build qemu with gcc and tsan
In-Reply-To: <20240910174013.1433331-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 10 Sep 2024 10:40:10 -0700")
References: <20240910174013.1433331-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 25 Sep 2024 11:43:45 +0100
Message-ID: <87wmj0ypwe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

> While working on a concurrency bug, I gave a try to tsan builds for QEMU.=
 I
> noticed it didn't build out of the box with recent gcc, so I fixed compil=
ation.
> In more, updated documentation to explain how to build a sanitized glib t=
o avoid
> false positives related to glib synchronisation primitives.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

