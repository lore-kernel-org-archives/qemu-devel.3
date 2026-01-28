Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB88D46BE0
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 17:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl9Ke-00060N-Ht; Wed, 28 Jan 2026 12:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl9Kd-0005zk-3b
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:27:55 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl9Kb-0004Ei-KQ
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 12:27:54 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so72178f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 09:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769621272; x=1770226072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATwxkSN8E3CcYglenAu+Pimx9X7QbA0HWEDLtGKjkyg=;
 b=HpX7PCpPscM6zfpxvsWDnDrC/AX9gDA9G5thckieyGHzR+kzlCUSGvaMmw69EGyzRb
 lyKVVS/yXUkK51H72imNBAxLCvK5pSOoPeP+wZVk9/jbYwNgw6hFUdMHjLlJTQXKYlCW
 hQkNPYF4WpXLjndVPkwhHCYQcOFTHPASjROyIx+8GxcrItqQGlX0CdEUJLxaWousFaOB
 6bekV2HErXMEGNeHP8OMwY4lzyRbsOBUzNFbbgYbaQkWKx2t+/Yln0mlUb19Z46XOhEL
 fDXKqATtohhmbzk2r+s1hcB1EvlJAbivK+3m0Z6cqEYxrS6JmBIJJS+6wxjyGplFm1Qg
 DQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769621272; x=1770226072;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ATwxkSN8E3CcYglenAu+Pimx9X7QbA0HWEDLtGKjkyg=;
 b=bN/p+uX4Js7NHeMArHAHpz+4+Goymdm/19uAL2WPRIIcQBZU/MYZAzrptxeaCDLs+0
 Vqk5XeOo+J4LxQT1/5i/rHC+T4LNYqcUkkZ9v6Z80SGMoboBC2vISZ+mC7szpKzs1aJm
 pQiqL40iYaBsCSQ/Vvvc7L841pEPA8HLF6jT1BanxcrkzKuDBBvcIr3ff0MhqFYP5bBc
 gSPYR0KjcILXk4lP25fwKca2lvgBeKtdAu+mfuYkrsg3+UAMgRAA4M5JFcnLQH4XaVmB
 /Kun14exgTbo7mH7cx4nYR2Vg6K3eBkG9gb/ySssf1Et3Ii8J6pdCwo73kjZ5kIaqErW
 8hCQ==
X-Gm-Message-State: AOJu0YxCTKzK+yETOnsfKOFAx14mKtCptDu1y+kodvndDpqToRCsBMi1
 xVjm7aWXOGYugbv5d6XjeeXUvqW32PKqkaRIE6k5ag7pXHZHiOJfE+my7e8LFhW3FZY=
X-Gm-Gg: AZuq6aL0o24LoYn9S4bPri6youSgFrWasGZU/U1oNel933d02IvUYtEog90OUhy0jHD
 gADlYpGfiVqChAj2DLZ3cDljcvLaqZ3eEIuo27ZdskQQXNl8I2wUd7ddtWRUdfIPaaXhrVS1TF7
 h6mNbDW3QjZZBP86ivXdl12HRsJtI/5gk0MvN7flSnqphN4nJJjoPdm5Mc+hsoS+W4RXE5YH42A
 lzRNzTnSJKTsg2Xgt/8LvA7or7FA4J8jEj7XytSNYesPCstIdzu84dK+No2zvDmLojDDLKRKV+d
 hJcQDQOjkce0wmqDlvnBDRvPErSTWipNmfBvOehQlQIKMQo3G2CMIluFc+tccoXa+kVfxEkb0On
 hTybfgBxbBP97VMIYedlVj6dNOGk7SMcCBrgyiW/FYpk5S0Z6Pu3mbZM4GCUea7k/3y4vDS5JQQ
 OTzTbG6UzLdyY=
X-Received: by 2002:a5d:5f53:0:b0:431:266:d134 with SMTP id
 ffacd0b85a97d-435dd1cec11mr8744907f8f.53.1769621271924; 
 Wed, 28 Jan 2026 09:27:51 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce70sm8570612f8f.27.2026.01.28.09.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:27:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 59E825F895;
 Wed, 28 Jan 2026 17:27:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 0/2] gdbstub: re-do unlinking of unix socket before bind
In-Reply-To: <49c18e2c-b771-40a7-b060-3af6e47fc013@tls.msk.ru> (Michael
 Tokarev's message of "Wed, 28 Jan 2026 18:35:54 +0300")
References: <20251225062919.685146-1-mjt@tls.msk.ru>
 <877bt1bvk8.fsf@draig.linaro.org>
 <49c18e2c-b771-40a7-b060-3af6e47fc013@tls.msk.ru>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Wed, 28 Jan 2026 17:27:50 +0000
Message-ID: <87jyx1abqh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 1/28/26 18:34, Alex Benn=C3=A9e wrote:
>> Michael Tokarev <mjt@tls.msk.ru> writes:
>>=20
>>> Prior discussion is at
>>> https://lore.kernel.org/qemu-devel/ee091002-a552-49fe-ae5e-8916937dba15=
@tls.msk.ru/
>>>
>>> In short: when adding unlink() before bind() for unix socket
>>> in gdbstub/user.c, a previous patch introduced dependency of
>>> linux-user binaries on qemu-sockets.c, which is more problematic
>>> for usually-static binaries.  The monitor_get_fd stub which were
>>> also needed is another example why this might not be the right
>>> approach.
>>>
>>> This patchset reverts the previous commit (with fixes for current
>>> code), and adds just a single unlink() to the original code which
>>> handled unix sockets directly.
>> This isn't applying cleanly for me. Could you re-base please?
>
> It isn't applying cleanly because this patchset has been applied
> to the master branch already -- a2b429b114e1812e0b3f222818a2755b6d87fb8a
> and e916f8b3b68bd9da45245927e2a428c3a0eaea54 .

Ahh - I was confused as I had it on my list to get to. Sorry for the
noise and thanks.

>
> HTH,
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

