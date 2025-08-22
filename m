Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DB6CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 08:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upNO7-0001hd-BZ; Fri, 22 Aug 2025 04:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1upNO5-0001gt-MS
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 04:44:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1upNNx-0000uM-6n
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 04:44:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45a15fd04d9so19504035e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755852271; x=1756457071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQbFyyOMI3SbqLeipVtF5lyvm6jyjtSixpUHUD6wGlM=;
 b=blo70OorBwnvDDNpZ1DyNAoMwTqGf0NAS60UXeNfuNJXrHnWta6duvHPYd87IYRJ1M
 pqfSMTsN1zO5tG5cesexCsSVwkfYyaixTqwvMNlM8YeMIKwqmvF29e42CPcuuJactr3l
 e/+iRSGvSESNKsQ40QN/xjwsva3iLW2xxDIHcOv4Pwlc2TnVWmr9iU5o4ewlcIVvXifR
 vbKYVHcNos0dH75jkO8wbdxWWpFpJ7oWfvy2K65fsDsgNP4ynGPHYQVq8vVcB7v812ud
 hEWLcfPy5OKxS5MdfDQy2FGV5+d4hd9WG4oM6IqK4Y4IvyM8zCUZBc8YtKWZsWkNS6ML
 vSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755852271; x=1756457071;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qQbFyyOMI3SbqLeipVtF5lyvm6jyjtSixpUHUD6wGlM=;
 b=Uo1Zzv1ZwNhaBZ+jTjxg4QHq8Buo3MUp/keuthHQxtjG9ZJ4cTr9c5P4kwDCnqShC6
 2OJeBcoHZMNMCcChDWz2MqJHD0DaHuFtzZg6ajNOBBDUJHYS/tzNUEb7tPwBSzT8O4Af
 l/HEzc3TZfrq6On6rlai+YuTSBD/tqsbIKSFF0+Z9Y0tIggelqpF1XB5RfwOk9vxJiZW
 gYsVscuXnmkjY7z+OkcswYtKb4QpwweEM/iQzZ0tJwbbqoQ6uITJYkSqPQfTjRf/VkMZ
 FJjbVqYlKjmVR7wUN63JOHoNAxcpixXRFFyq3JOVUF+dxQ7J9QhjR8qBPoyy0i7tlJrA
 66jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5bISGZddxWczeexws7t69k5oEzfEXos+JQRswRg8oXkVD+A+uSaG+oTy6zi6TY74dViz2+lAxdPSq@nongnu.org
X-Gm-Message-State: AOJu0YytOorlQn17G5TWcUsmPNzqmqLTfexPqQtdJ0WmNjmWDOCYsMF0
 IGV1AENz5hsX8yHzpUKI1ZuXmqmi8p/iVIlId/ZadMQ7IqdmFCB0cyck11+0Sfj5IyA=
X-Gm-Gg: ASbGncsqYD7AOe68fkJDlAGlbZ6hdUzS2y25guIClBWcnqUtgovoAflGFVy0pclEVVU
 P1KXsHGKAyNFyKEiosk1mdKvLX8GbvBW+Nk+uycmTU+rhYYTVqPPGAcRbgaXOJ3OSGifWuwpVN1
 kcWsf5Mpkhwkck6lajgCz2D2hGv3lDTAwRYMVfKZGSB7xEuFrqs63wUqvuueA0daBDUB6G6r0lg
 t+ToCjEMBNWDP5SymgBY3qoziOC+ZIxcyyFcmPkWE3yr3EJgpIoxAdUIJZbg1tXaW3i75dh9PD6
 iYT47+V7CkZiD5DiA4+X34g62en73358AHmXmkGNQ4FbaBsh2pYTARUd1bW9YEOdl57I4e5aBp/
 FYU5bceq60Km/DpfNv0zVKnc=
X-Google-Smtp-Source: AGHT+IF8UCp2CIS7Par/Uk/Iu6yOYbrGcfkTvsDiwv/4Dzi3WIai2jZWbdG6Ut6FaIF+i/oJv+BMsQ==
X-Received: by 2002:a05:6000:2512:b0:3b7:931d:37a0 with SMTP id
 ffacd0b85a97d-3c4aee0f93fmr4414555f8f.9.1755852270584; 
 Fri, 22 Aug 2025 01:44:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c520d37833sm4331633f8f.45.2025.08.22.01.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 01:44:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0DBC45F810;
 Fri, 22 Aug 2025 09:44:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: pierrick.bouvier@linaro.org,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com
Subject: Re: New capabilities for plugins
In-Reply-To: <7e0bd15e-d022-4de1-814b-9d9bb6513934@epfl.ch> (Florian
 Hofhammer's message of "Thu, 21 Aug 2025 18:02:26 +0200")
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
 <87tt2n5az1.fsf@draig.linaro.org>
 <1016eeb7-57d8-4d80-ba25-42cda2d63b0f@epfl.ch>
 <874iul26rp.fsf@draig.linaro.org>
 <73d56742-5e6e-4e1f-8d8c-2b9783d0ddea@epfl.ch>
 <87y0rxzsz4.fsf@draig.linaro.org>
 <7e0bd15e-d022-4de1-814b-9d9bb6513934@epfl.ch>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 22 Aug 2025 09:44:29 +0100
Message-ID: <87v7mfkaoi.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> Hi Alex,
>
> Sorry for the late reply, I've been out of office and did not check my
> mail.
>
> On 05/08/2025 17:30, Alex Benn=C3=A9e wrote:
>> I think to read the PC we would just need to make sure we properly
>> resolve it - internally QEMU does this for faults with:
>>      tb =3D tcg_tb_lookup(retaddr);
>>      cpu_restore_state_from_tb(cpu, tb, retaddr);
>> where retaddr is the address of the translated code. We just need to
>> special case PC handling in the read path.
>> *snip* No need - we just need to exit the loop via
>> cpu_loop_exit_restore() and
>> the code will do the right thing. However we probably don't want to
>> trigger that via register write as we would surprise the plugin -
>> especially if there are other hooks still to run. So we would want an
>> explicit helper to do it.
>
> Is this something the QEMU maintainers would be interested in? If yes,
> I'm happy to dig into the codebase and submit some patches for review.
> But this of course depends on whether such a feature is even desirable
> in QEMU (cf. the parallel discussion thread).

I think writing the patches would be a useful exercise anyway. The way
the plugin code is structured should mean you can keep the changes
fairly localised which would reduce the burden of maintaining an
out-of-tree patch if it isn't accepted. This wasn't really possible
pre-plugins as instrumentation was often deep in the frontends which is
actively maintained code with constant changes making re-basing a
nightmare.

>
> Best regards,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

