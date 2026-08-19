Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDACC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhJC-0001vz-1v; Wed, 19 Aug 2026 10:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwhJA-0001vl-Bx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:30:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwhJ8-0002Up-T2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:30:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso11422375e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787149821; x=1787754621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A2lAn/Ur/m2PgoqeGRBz1w5lv5jbAWXANXVgyPtwuY4=;
 b=q+nzBiXeoPHMXwkyFyQ1tEg5oBJl/ptREjD7AgLo4NUJ/xHjdYTtChJLz5Nm1URA82
 ps09fb9UgSKYEfkoKD21Ryt4jJAGZTEnmitggj9kvclc/w32RSbaBEoUHj+WvP9uyBfc
 wAiC60Uyper+PmB4awuofxvf9+Hkh9/UzuG5RHRTW/3QzsRGC+ITNTcxPU8dkDa/9I8z
 8/cJODg++MTfZrY2AcpfbkIRftwlwmYtuEDH7U+SkqsV+6f7UEP0tZfpupjiHnVTnok9
 jqlcbfhEOsEp/4ofVuPIZUGL9hZ7CWHO2Te0BpQNsV2khPuC0zC9TTCjeQ5dXN1gRoME
 0Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787149821; x=1787754621;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A2lAn/Ur/m2PgoqeGRBz1w5lv5jbAWXANXVgyPtwuY4=;
 b=k1Qpr9zstXk7y8d0godBB0E30vCNziIjmUuT7msiiydX/qRwwUc5EPDFhuezN9ApEE
 78/O0ElXYuYjsW6wfP1AoO0MY/T3htjTCbo3tAUo3fI9rrAkNsMNelelzpoZJgr1//Hi
 O6QVo0/bCt7lVvCtxf4+CvE9X684JB0VEBQ5fqkcKZ8BNpHyOGainxN0S2NKDDFd2aEP
 Cs81hgq0WXjVDfRE7baA+L1MVo68P117rSLZ6Z+8h/JG/ut/oB4dOsPC0RiKiNUDMOpU
 d1OSEsWp1NUS+qo8Gg+ucgQBUZvRoHTTwmdy6+YETFDTNoIA3WnUjMkZE9+vPgBQSkct
 oeYw==
X-Gm-Message-State: AOJu0YwJIoLGixKl1IEGuCgPjGytuyp3nfO0K653wyupxD1KWgAniaMz
 /lBWfVCV2EoPvsB+zvacEOKMRV2M95RFKAHfHVrn3qMfv41ITvlMAc9rU62axeU+9zM=
X-Gm-Gg: AR+sD10wp+Ny8XbWuNBmxv3IeXdvUpF7uPWReKVZSuD9ISYlS4Zxnm7gevqkMmBuKUy
 mAAYheax5jHJuzalr7MgW+m2U895ApHP9LC+yww3OkzBKZn9JGzjWfvbSUvvh/8Mtg+H8KS3j1A
 B2OU661+BVSSrM5uff0nbW4+rYRaSdf0NVExQZM2Kt7gS/HQL9La7xGWEC40HcWf82i/OKXrzS/
 nJqCN60+7AUQebHCD1OcANc1muoQ8b0whpRZ84b1XcmBQtl+32/o/iN+eigcyfNHsRoyegjdjQa
 SZGptJGniXzCQUeOWJp4r1J8pOHZuddm9+1YAHenrx+XO1W+qdin9dsoiVu2kqHmkB73RvRBWIS
 /Hh8y+GtgqjlWCTVgXRosxlayZ3jxwbrpCJbnDVfjIHDP1CJwm8TiluuUuaouGisMT61WdmRSKc
 wqYNCszb8NvGoFKw/oDXIa77rI+9uDAUzBSFK8ur9kCTUzxAIZlPGCqJjXYxIr
X-Received: by 2002:a05:600c:8b06:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-499aa1a93f0mr105925825e9.9.1787149821147; 
 Wed, 19 Aug 2026 07:30:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e09e87sm40288815e9.4.2026.08.19.07.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:30:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BB1845F805;
 Wed, 19 Aug 2026 15:30:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 033/104] tests/tcg/Makefile: skip user/system tests
 if target Makefile is not present
In-Reply-To: <20260818192309.22169-34-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:21:57 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-34-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Wed, 19 Aug 2026 15:30:17 +0100
Message-ID: <87y0e2p4hy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> In the next commits, we'll port each architecture from Makefile to
> meson, and it's easier to review those changes if we remove Makefiles
> step by step.
>
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

