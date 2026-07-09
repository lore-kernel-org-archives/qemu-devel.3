Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46431C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whklX-0001xy-Uy; Thu, 09 Jul 2026 05:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whklW-0001xi-AR
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:09:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whklT-0005Sc-4w
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:09:53 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so15115005e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783588188; x=1784192988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+XN3/ekNd3QUU4b0cAKXkzNfs4yUKBFrjKIK4bjmm/M=;
 b=QMVgvnqnazVraiA9Rnk/FLzf7pLNAgZB2NjxdMKCle323rXMIqfI/io+5+N4fW0TFw
 fWRteS+Bl6WDBTY/wiGpA7AUKGgsqkWBnodCVYIC7bjy38puGgyIOpYprZOq6MivdHT9
 bTNwRTDdR8ND+qm0POypYTTwmxne2DWQDvIFz6VNOXa9FgmfH6VafvXwUqyFX8zbVcS5
 73110kB5HzqYpbt+WzGot/XBPxIUcBCVso/qvAXQulhz3DyJtuxWfIHAQaOQtjBYEk7Y
 zaIlMGqWjmTbwZbUkHyyVwdek9zCjBtsPu4Lp1S+M2pbC6p5KrsKS+wmn/rNXd2NS0U/
 JAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783588188; x=1784192988;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+XN3/ekNd3QUU4b0cAKXkzNfs4yUKBFrjKIK4bjmm/M=;
 b=VC1TjTZLKyx0kUDAGMxBzR2b92wBKfJxcRZm48y1cK5yiAPcc4lTnWseHcrgq/t5GB
 IAoStcQI8KwT6O/mlJbezY8m7Y1Ouxgv0a1g9BG0AUX4P1NSW2UjCzjdDPebttHxlRAW
 cF6lvAaO4vP7+hiaCLgdY5F6LhCjpOoSc9HRtmlG+XAjCYkZZOgDsgCGt/aP7/3FKZdT
 KTdyBDrFanhMNEKV3+qsN2DWreOJG/mnzuSznXNkc5O/Qed9avLAVEGe2PLam9fyyhAs
 7pEcGYR2pejdW2nzKGsD3HGAfydVU4dn+AxAyTO0JWExdogXgKpT+mXY6fE+exDZxGXu
 LLRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqC4stflSCrh7AyXRU7/7tK5Dq82sqQNgzGfZYN224F6id+m0ImCBM5sqkmRKYrkozWE7Vs/gcN+fn5@nongnu.org
X-Gm-Message-State: AOJu0YzG0Iq+hhdfxh3OYGOllGM7a88COQs+H+IOHtHDl6ONoM7eWuca
 IHeNNTwWC6pJKq2cxSNoJTo6xgdFdsNunCM2kDsH7H5e4oZDYSUeLQ+lxzFj/FWO/NI=
X-Gm-Gg: AfdE7cnEXbbSi1SUUEWYWRyvJl7ddBJTn56PuRw6AJKBrcb0Dbml+gUBssRVO79tJac
 gWDvnE2zMPNZNq24maV0FLyjOhrF5Fju4Jl39qIvq0VG+8OD0hI10rzDB8OHJbSTnbBJkqKIJnU
 GvLh6FskCHU4SPmKD3Ud8lryVEn0t06YNrOqn3I2fuNctxQ6dHKCn+DWX54tCafx16hjq94VWiS
 8ZYj00oNuNpgBdEJu4SRjhAmUZC++6nC4Mba0WhGcQvqMo89xXkZELySKFfSSZIAsBaXkwtx8an
 wGYvvddH2dfAlVclGwba6mf/eSjFhMWjOLRLfbF2KDATIVmAARKwomUTL9EUasXCsyFjEq4C0Ty
 vkD+ET+yuBQ9Yjb81oRTUxAo6bAl+N1i+dSUWggfklOhW2RDZn/ce7/70f098p082Rh6R1G46jp
 yWyub3tTe1VH5e
X-Received: by 2002:a05:600c:8b34:b0:493:b03c:5650 with SMTP id
 5b1f17b1804b1-493e685f1dbmr57420055e9.19.1783588188376; 
 Thu, 09 Jul 2026 02:09:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6cccfdsm45549025e9.1.2026.07.09.02.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 02:09:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 635CD5F82D;
 Thu, 09 Jul 2026 10:09:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>,  qemu-devel@nongnu.org,  Ilya
 Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
In-Reply-To: <875x2oh786.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 09 Jul 2026 10:56:09 +0200")
References: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
 <875x2oh786.fsf@pond.sub.org>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 09 Jul 2026 10:09:46 +0100
Message-ID: <877bn4ttph.fsf@draig.linaro.org>
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

Markus Armbruster <armbru@redhat.com> writes:

> Max Filippov <jcmvbkbc@gmail.com> writes:
>
>> Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
>> which matches the way it's used to store `argc + 2` pointers.
>>
>> This fixes the test for me, which otherwise fails on xtensa with the
>> following message
>>
>>   linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv=
, environ) =3D=3D 0' failed.'.
>>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>>  tests/tcg/multiarch/linux/linux-sigrtminmax.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/m=
ultiarch/linux/linux-sigrtminmax.c
>> index a7059aacd9cb..b5ea65f3d393 100644
>> --- a/tests/tcg/multiarch/linux/linux-sigrtminmax.c
>> +++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
>> @@ -39,7 +39,7 @@ int main(int argc, char **argv)
>>      assert(qemu);
>>=20=20
>>      if (!getenv("QEMU_RTSIG_MAP")) {
>> -        char **new_argv =3D malloc((argc + 2) + sizeof(char *));
>> +        char **new_argv =3D malloc((argc + 2) * sizeof(char *));
>
> If you can switch to glib's malloc, then g_new(argc + 2, sizeof(char *))
> is better.  Yes, @argc can't become big enough for the multiplication to
> overflow, but g_new() removes the need for reasoning.

Not for TCG test cases - we are limited to plain old glibc.

>
>>          int tsig1, hsig1, count1, tsig2, hsig2, count2;
>>          char rt_sigmap[64];

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

