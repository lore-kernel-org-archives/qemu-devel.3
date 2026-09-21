Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E957C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8aEO-0007VO-Rx; Mon, 21 Sep 2026 05:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8aEM-0007V1-Vw
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:22:35 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8aEK-0002ye-3a
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:22:34 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso19654245e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789982550; x=1790587350; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5HLMVdkkcD1Y+mvdwSHrsGQhVb0d/0LvnCklFy2sFMs=;
 b=vk2OP6mCg7er6psFSbifUy3HRX/3LN79qPZuGbZrhsQiwDARMGFdH9alxXzh6FdEI7
 NSwEV2umK8Op+YPLx6GWjIL3zvCfSohwjtHBeXRHbI+Od+iLVSAi9hn/5CULrS75sN3R
 f4tdbqipoozRFHpNO3YjaT9nsC8j//FwKVzuiMmxmaL1rvMFtlbMJ3xC198oA1ngq5DR
 1gdrCIT4h/50h0di05hTWa33Z8+j507mwz9ulZ0OMD+9k1wZIqfW9wBusg/pbsYCGfek
 sN9kq7IaK5M/gedo7vroXQ7/EM1XGkhlVSXxMGVXgUur+CPES62ENxdj56C1/PkYBhqo
 lm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789982550; x=1790587350;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5HLMVdkkcD1Y+mvdwSHrsGQhVb0d/0LvnCklFy2sFMs=;
 b=r6BtfzeRsxaNOngiu/f2TIni5BXIPt/RRNThlnL6b9KTYXaaT5QlyyBxhCqyMLzfnY
 LcOonSvbLcwCx70j492MRNu3B284grT/g3OACOEiqk0XuaKe4JceP9i1YcLICE4oA0BM
 qYatPplS3sS5BQZxuR/6DHLlQf3CPKxX1XtECeNlzfl9UOJl6k/517jXO7DF33rn0/3m
 IjVYcKkcQEUqEr0Bf1eCWNagPMt2RYowmDDsGcscLNB4/MZWuIv4uS9k1X6LCQTdBxad
 EC/SvoBMa+Tj8QikrENhw2rZvZ7rLQVqDK4DjoDtuMpw7453sVE0FuShbk2qpH50rdVY
 rOaQ==
X-Gm-Message-State: AFuF++lC0SjLTO008nHkTaINgfmfIZUD0ZRYLhAJTE2bbna40ja61r62
 0/WIlGeEiDVM27O4CDn3GrCXdRWDkyZzL16zSiiGTZ/sjRXvUbDPpgNuuhMBuQ8n77w=
X-Gm-Gg: AYBFou2XbnAIGX0YlL3MlMupEfo5LcstZxCC/MiGsnIgziEdNIu2h7LxT/HefQOBZVu
 JKmkya9n0jfC4Kwj9ckMJ/XjxwdWnxf6v8DFXqmtLgXUuZWm5qj//yN0SIotlwX24lw5YPlVH0X
 kRe428sw8ZRsSpIuAzqTRC1ow79oRR7HO3e7gpNn6QiPXEURAlz+fbj9xm+nP1C9vp7PfRKPOop
 VlOOpflGc7APOnp55q3RJRM9QMi39GpcEbs0i2jHNI8cwPehfYDtHMMkClMNXRqbNBfQIRSw+Yp
 os/5SOdqlnPtd9G8mlyQvUCmmmb/riTKlDTKpnaV7JXusHOqffpgD0T2x8OwQBA5BK+yUPikcBm
 0DqhJiMTSomgcEMZyCe7cFycHmVNkx/V5Spy8Z/dgVJlqrxJI6Ym9kt/fmCZo7tO/72stbMaRJP
 mRkSZPZ/SpOZLd1nvXUL6TIBqDtJKTQVF8t7mZ4uxV0ceekP/FSTGQ3DGQpTr5D/zc8BL3ApU=
X-Received: by 2002:a05:600c:154c:b0:49f:c451:b4ab with SMTP id
 5b1f17b1804b1-49fc5743c34mr131550355e9.29.1789982550238; 
 Mon, 21 Sep 2026 02:22:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc5755c40sm285163475e9.3.2026.09.21.02.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 02:22:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 63A2F5F8A9;
 Mon, 21 Sep 2026 10:22:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <20260921075251.12831-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 21 Sep 2026 09:52:48 +0200")
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Mon, 21 Sep 2026 10:22:28 +0100
Message-ID: <87jyof0xij.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify and enforce.
<snip>
> +Commit messages for AI-assisted changes
> +'''''''''''''''''''''''''''''''''''''''
> +
> +In order to disclose your usage of AI/LLM tools, add an ``AI-used-for:``
> +line before the :ref:`Signed-off-by <code-provenance>` line.  The trailer
> +is both a reminder of your DCO obligations and a guide to reviewers.  The
> +text is one or more of ``code``, ``tests``, ``docs``, ``research``, poss=
ibly
> +followed by an explanation in parentheses:
> +
> +.. code-block:: none
> +
> +     AI-used-for: tests, docs
> +     AI-used-for: code
> +     AI-used-for: code (refactoring)
> +     AI-used-for: code (prototype)
> +     AI-used-for: research
> +
> +``AI-used-for`` should not be included for "background" usage such as
> +autocomplete or obtaining a pre-review of the patch.

While experimenting with these tags I had done a patches with:

  AI-used-for: created qtest boilerplate based on bug report
  AI-used-for: importing and validating test case
  AI-used-for: initial prototype changes
  AI-used-for: initial draft of test
  AI-used-for: fetch issue, apply proposed patch, verify build and qtests

Of the last one I expect "fetch issue, apply proposed patch, verify
build" is superfluous as its really just automation but the converting a
bug test case into a proper qtest case is worth flagging as it is a
transformation worth getting called out?

Either way:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

