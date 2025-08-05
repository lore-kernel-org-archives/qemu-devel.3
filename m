Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0266DC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujITl-0004C2-MQ; Tue, 05 Aug 2025 10:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujISu-0003Hf-Iw
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:16:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujISs-0000en-Fo
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:16:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-459e3926cbbso3339225e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754403389; x=1755008189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sn2QQeYaGNTConXGNFLWJIyjjPomB3Lr+eFkqyocCk0=;
 b=Miqulyu9pcW1bl+Q4PAnOd6UMiEk3YQElnkI573kxWzXsWRUwm4OAwb/IUwzVwxR+s
 KStT7Ef/HGgreHKBwYWgOdTSSnG5YZTJr+uVReiQqh4t7TzuEs13bkz1KNGi7TlE06/L
 qZPZJWaJ/2QAEkNoKe6YsGb4dJtGJ4V/Yb4CgctBZBHAOHaAntG9xLMC0qvpY3r5i50c
 ne7eGnua+IfRAtDpli5lEDV3mztXxnlw6E/bdE1IaKIWZJaAyvSyC6grFUWID32Vs+Yw
 g7uqTVMf8tgXg1G0/pgH51T4rvtopnwhnrPMvAIWNaA6XZ2d9uDpAw5vNrfm5wlLPgc4
 BhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754403389; x=1755008189;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sn2QQeYaGNTConXGNFLWJIyjjPomB3Lr+eFkqyocCk0=;
 b=Xq265S6NN51FjuVLMAa3LnlQOSuSNmJn93vBZjsK5R+Woo+4lTigKTJYCWmqTgjs8Y
 aRdK0kb+xRqfju3J9LrZvunJS14xugLHRfNw5BszF5hbxSX3Pb4Ncn6l9uooBEqZD/Ou
 wg6uQgJHRP4vGzQjN+V32rgsSmYIyzEhC3AWzag/apiOeDAKhM0+fJv+z51EeDfmcBFX
 w+K8pcCa12PwKR0Lvl9+/lHwHF96sDpjMBDTsAreEOX/BJFc9z1zsg0wdx9uSjFZ19aS
 58muL/gKqpUy9T4mBEVpSnlFthevLNzUxNj2rwHKLH0xky57+O54wNOMBdhLthNOhypG
 4pzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXham/lxV/s7BRGqinSatlepmI/20fMNh7MumnPsdW3tOR13uZ+CMOfTzWkFWMPxphUxroNYo14Fnz@nongnu.org
X-Gm-Message-State: AOJu0YyzW2rKwG9aB84cM51h65tolQYJud8kngqtltH9j6XP9ZFJDGml
 x7l8CkNDOxCccYw4RJyCRWq38YimmK8OaLIKDHnyJ909bDxd4/o/nWzG2cy1wSqJrjM=
X-Gm-Gg: ASbGncs5lbvPz2A9qfOxpCAPYAFz6oVXqUF9v3PrAA/F/pwYVreo+iou5bpsd4dJR1l
 0dQACOcisOxNfEf2j50gp3xdz4i0HczbfT3NXZx7B+bcg+B8i2SzMyqS2cS8Izj7hyrh0+LhFmn
 1PboHiWrsd5DGCivnRp5zLfg409tDXGJ/EfyTEXS2IwURRsc5rrSgMkZNEkcAkBwKtsyXBFh6SG
 skLl0A6WB28xRqOvjyea/QEmB4JzK4HBuBbDKK/gcvWW/T+U7fdKy+d31Xvwe8Zx19QU/SPnAxx
 wy+9SvG9pRKecQAYX/AQROFu7L1MJ659tkpG40EwPRk2obD47S8o4wIbaAgCw/k35JtCdCUGHJA
 0zljIri4IUg6H4lWaJGslYys=
X-Google-Smtp-Source: AGHT+IHKO/ij5Ade24XztOjvxa96QabVy9D6qDerWsGLm5K7/k9Kc7qSALHvyslUsgP0HqPrEJTA4A==
X-Received: by 2002:a05:600c:1e88:b0:459:ddd6:1cc7 with SMTP id
 5b1f17b1804b1-459ddd61f6bmr66122125e9.0.1754403388580; 
 Tue, 05 Aug 2025 07:16:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47b10asm19025553f8f.60.2025.08.05.07.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:16:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E94A25F7E9;
 Tue, 05 Aug 2025 15:16:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: pierrick.bouvier@linaro.org,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com
Subject: Re: New capabilities for plugins
In-Reply-To: <1016eeb7-57d8-4d80-ba25-42cda2d63b0f@epfl.ch> (Florian
 Hofhammer's message of "Tue, 5 Aug 2025 15:22:35 +0200")
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
 <87tt2n5az1.fsf@draig.linaro.org>
 <1016eeb7-57d8-4d80-ba25-42cda2d63b0f@epfl.ch>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 05 Aug 2025 15:16:26 +0100
Message-ID: <874iul26rp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> Hi Alex, hi Pierrick,
>
> I'm taking the freedom to reply to both of you at the same time, I
> hope you don't mind :)
>
> On 04/08/2025 18:05, Alex Benn=C3=A9e wrote:
>>> I was wondering whether the QEMU community would be open to extending
>>> the plugin API so that a plugin can fully emulate a syscall without
>>> the original syscall being executed by QEMU.
>>
<snip>
>> Another option would be to have a set_pc function that would restart
>> the execution at new PC. Then the vcpu_syscall_cb callback could set
>> the PC to post the syscall with whatever state it wants to set up.
>
> Such a set_pc functionality is already covered with the register write
> API, as long as I have a handle to the PC register, right? Please do
> correct me if I'm misunderstanding something here!

Ahh we should make that clear. It requires special handling as the PC
isn't automatically updated every instruction. For analysis this isn't a
problem as the TB itself knows the vaddr of each instruction so can save
it if it wants.

Currently if you write to the PC it won't change flow - and it will
likely be reset as we exit the syscall.

c.f. https://gitlab.com/qemu-project/qemu/-/issues/2208

>
> Thanks for your input,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

