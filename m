Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5293C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7Zb-0004Iy-4U; Tue, 25 Jun 2024 10:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sM7ZW-0004Hr-MW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:55:03 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sM7ZV-0003LN-0u
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:55:02 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57d4ee2aaabso3002462a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719327299; x=1719932099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s2Wjn7dnTiu4c6dDztY2mJxot7GXZViiw/Q6aeaYO+k=;
 b=Y/1m7BAFaIA03MynH66K1nOPPBKh6AsUH13gCojhvZ83EsYEh753mOm5MZr1/dve3U
 HSzS6vHEBToNvnHzTzQx14fZtCC3o14NNoKP3x55Yksw4GFqDk/y9k/3hNbK6NOL6Iln
 w5aIaYMpCnfh9IF74yGpaFup0NpPGq+Vm72NZCEh84aS1CMYUi/88rh4eXkg9+CMxi4h
 jwM/X18HLwtx3iYeOjYCIxGd1h7HOLE1YE1qt4n2yGiIyq9/YiOjXu5IdNZ4qF2kuhg0
 ZlVfSMEeUW1t2sz0hNh0tFArHYOIhZUdh7LDwzR6Ykj/1+acX/5tFb8XG6HmOjaAveWG
 hdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719327299; x=1719932099;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2Wjn7dnTiu4c6dDztY2mJxot7GXZViiw/Q6aeaYO+k=;
 b=Cz/7KVwsCkPObf3+gHOA5hRTqMdH4XOiG/Jkz6D3nqzzmyTA7ICV1C0OnbXKJfA/Zf
 QNesk3ukUcZ0yZDw3IgCFVfNEg7vuG6kAm6jJiHhhCzjbF1a5bE83aZgaw+2RNREhNQR
 D0WBoT48TMnR88ucPEBalPQabPyTgr3kC7b6kX7POVFALxfJaLMoqg0B02BvoD0ykQD8
 vWEzh0Bc656ddW+/FUC40sj4wJy/bNrclijZnon9iq3c6YiKJWLGl2av0MBwbjqZst0b
 AQ3L3ylzlwG/jwNYWY8g3LirOPW57hJhUZXjMWdrw1VV2lOkavmgmjl1gB4VJljEU2gX
 B/fQ==
X-Gm-Message-State: AOJu0Yz+b89KgKN8Mt3aLjvZGmRHjIzftCQ9XEtuxbzhiYNc2jv7X7Ix
 i2A/F5w0PMOoNVuC9FRtpV/7NTV1X1NMjO+ZYI0F5kuX9Y2k34ZflSxYOzM6e24=
X-Google-Smtp-Source: AGHT+IFdDaOt7xORw4Ljwh/fLQwSCe900qR+GtqCtMQVjvEWX46axiESH+wjI6Skig9Ll8rwEWdqng==
X-Received: by 2002:a50:d653:0:b0:57c:74ea:8d24 with SMTP id
 4fb4d7f45d1cf-57d4bd71891mr4923680a12.18.1719327299026; 
 Tue, 25 Jun 2024 07:54:59 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303da3d6sm5959613a12.13.2024.06.25.07.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:54:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E939A5F85F;
 Tue, 25 Jun 2024 15:54:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Help improve 32-bit testing
In-Reply-To: <ab8beba8-658a-4359-bfb1-672e5782633d@linaro.org> (Richard
 Henderson's message of "Mon, 24 Jun 2024 16:33:08 -0700")
References: <ab8beba8-658a-4359-bfb1-672e5782633d@linaro.org>
Date: Tue, 25 Jun 2024 15:54:57 +0100
Message-ID: <87le2toywu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Hiya,
>
> I've just discovered a 32-bit build issue that is probably 3 weeks old.
>
> While we still support 32-bit builds at all, I would request that we
> improve our cross-i686 testing.  For instance: we have cross-i686-user
> and cross-i686-tci.  There is some system build testing in the tci
> job, but (rightfully) not everything.
>
> I would like a full cross-i686-system target that builds all targets,
> and I would like the debian-i686-cross image on which we base these to
> be more complete -- ideally, exactly matching x86_64.  In particular,
> CONFIG_SEV is not detected within the current docker image, which is
> where the current build error is located.
>
> Do you have time to look at this?

See:

  Subject: [RFC PATCH] testing: restore some testing for i686
  Date: Tue, 25 Jun 2024 15:54:18 +0100
  Message-Id: <20240625145418.694476-1-alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

