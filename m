Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81109CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBCL4-0001x2-Al; Mon, 28 Sep 2026 10:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBCKk-0001wG-5m
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:27:58 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBCKi-0005m3-41
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:27:57 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso23205795e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790605674; x=1791210474; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QLnMYjWC1u10mfgCAHCtME2LwGdqsSld+xN5u2fCvr8=;
 b=dxTgajszdL3zHpxev+X6paVi/Gp3r6voM1tWoZQ/+zKMAkinV3LS4qrpFcjo7XbHs+
 2NgG/VIuSWbSIamsgeqiHF1neoHs7x3JeenZbMyVhIQvUKxqgoDZYaymFwY7NB16NX45
 OJBDWSoFgIV5xrotdvk5/8VFKf4ykcAVlTmfEcGqA/57aNXItRmV48qUY+Lz1q9NT9Bn
 2QVk/48FfhKAyho5L3Bw0lGLzbJiXwe8tXaBo44eAXL5vCjwROYjIp7zCQcXh/oQUjng
 YORfmSAda2kvn+K7vkkehu+fnBfaC7ppuOBNhRB9vg31vrHSvcBu6t3FKbTp64c5sUfr
 0Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790605674; x=1791210474;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QLnMYjWC1u10mfgCAHCtME2LwGdqsSld+xN5u2fCvr8=;
 b=qVWuTcGv1jt2KYKlKCG8GdXweR1msCsasMN2J9hSZHHO6suU59eQBSuwT0jrh+cLFv
 QudsJyBq7YkUJHWD1r9HCg8wYYh/sV3F5VxY/TjfsmIZ4OU3WZWVWXPyvm/BXsPPQo70
 1Wj5YuGrg2Dhq0EnUKy66LTgziT7Qv1NihuO34NgszOmCNL7TEv944bPxE1+BPt6Bhp8
 EsPBMIR+659HO+lxuogGehFQJ3hUZIcij+BBRA6iQCs4/KSerGBsYzGYt4N/HMe+JuPD
 Irzb+cPzY+/8eiQ1Nag7T+QtFcMx3YRYHAWxYhFV4VP6QAmeAmzgEA198MTlFJs0SsV4
 l5nA==
X-Gm-Message-State: AFuF++lKCAzqUodGDJiE6jH+6R9ByFdsFzmLFvTYMvxnfSBb/e+a10FU
 J0oJ0gTh9rVuy1xcJJjooS7bZcJRDWnJX1Wsi5log9hm7BEIX0wZVHNzoSMBbwUJc4k=
X-Gm-Gg: AYBFou0IxKhXjq5uUEYc1huU3QZ4cK6IKYsKer5CwWEip6pdsMqQM4DsRQbcRbY9Rr+
 6P0mCVbah8/MRnh+PHN8WGOj+Nt+zYIk77nW0GkOMpMWsspSn90saKoxihvhlc0J8HCpXJdjS0F
 UCq9sBFrQpJhZgEFnJIoxDWxnCKBCJRQ0IfOKuKI0zzlSM7GLluG3JJPyPteEl0PZH52+hhZTW6
 DJSdRPkyrQhJ6S7aTQYPoLm6wO5McnunU/WwUA8uo0+H9w/cs0vSkHEPBwwSgxkZ+NfniUnvxeD
 Km78i2Am+aVu5ZPGoeEYJ7ZPGQUqi/5K6LTPXnD2yZmoBjUm8mzjA1BkxRDyblqE12zMTJtQMTD
 fhoXuBgKUaR5eglXPBarzwc8Oo2j8kNFXNIayGXX2wUbX7gDQXcTCNuaMZZ3m+BwA+IA54H80hM
 sbfGWLelx88gON+Msb4B8metIVU1KYU0WCz9d6s6+ulG1plPt7LY3XQu9LDp8sxENOfqkvnQ==
X-Received: by 2002:a05:600c:138f:b0:49f:cbf3:551c with SMTP id
 5b1f17b1804b1-49fe66cc5camr221553275e9.12.1790605673588; 
 Mon, 28 Sep 2026 07:27:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018e6dcbsm143688625e9.6.2026.09.28.07.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:27:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 851055F8C1;
 Mon, 28 Sep 2026 15:27:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH] target/arm: fix user-mode emulation of
 ID_AA64MMFR0_EL1
In-Reply-To: <CAFEAcA8DLweguCk7-9prMKraPcYRC_Sf5WD_07Ke9cLi4R9-Zw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 28 Sep 2026 15:02:43 +0100")
References: <20260921142910.1462880-1-alex.bennee@linaro.org>
 <CAFEAcA8DLweguCk7-9prMKraPcYRC_Sf5WD_07Ke9cLi4R9-Zw@mail.gmail.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Mon, 28 Sep 2026 15:27:51 +0100
Message-ID: <87mrt1a1so.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 21 Sept 2026 at 15:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>> Since kernel commit b130a8f70cbbf9 (KVM: arm64: Check advertised
>> Stage-2 page size capability) the relevant Stage 2 have been pegged at
>> 1 f(4KB granule not supported at stage 2) by the kernel. As a result
>> the behaviour of the test differs when run on real HW compared to
>> under emulation:
>>
>>   id_aa64mmfr0_el1    : 0x00000111ff000000
>>     !!extra bits!!    : 0x0000011100000000
>>
>> Update the test with a new helper to explicitly test for fixed bits
>> and update v8_user_idregs to match real systems.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4566
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Why is this only an RFC? What would you like comments on? :-)

skill issue (or possibly my shell history). If your happy to take it
please do ;-)

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

