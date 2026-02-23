Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C322EA4FBE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuW6G-0002X2-Kg; Mon, 23 Feb 2026 08:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuW6E-0002Tj-K4
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:35:46 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuW6C-0004Xv-O2
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:35:46 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8871718b00so691214666b.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 05:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771853743; x=1772458543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59UeeZ1m+OC54KJ8qSW4tohupoJFstsD/bfvexILTfs=;
 b=RVS3xrdlced5JsoMhbURK5syjof0TDwpY46CZEorUvJlsty9AjufVTc0q9ac5Pxmwy
 v/kO8tRWlRNn4/mJ8ESppWkqlgRc+HH+CjNqzwtT3ajg7+dtLBTkUWOSNUtpAXp//xmz
 LhbG2UZRdK7CDPLbDqkAUsjwyOFSOVydnVQEH+A+z4g2J+vlZ9lJP5L8RoAe4xOm1bGs
 KvOIxcjQ2l4LU0H6cEI3UwNsS3ApIOIEkcJGPqJjzJRUy8S9KKDBdfdOHaGUdEvrvFOM
 S74FbYGqbeu4x0lJ6x9vZL4zeMrrExEgj5wYEE6c8QmEU4tR6AojQw4phZh2nzSjOp9F
 LV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771853743; x=1772458543;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=59UeeZ1m+OC54KJ8qSW4tohupoJFstsD/bfvexILTfs=;
 b=xQ+x5WZyNQqG/xWQsVsg3hRFAfGWK515lMiist0UknHm4wNpuLLdFBo+WB0F5xayBs
 y9n22NFtnRNmpA5TOyqTSTwhvXw4dXRsf5NvQ34J3EfVJFs95B1gEpJxFP428h5c/Sbt
 eZdVYd3rRDynjy/a55XuXzfWoukLUe34HA3mLA9IUB8hS0rpTHDTB3DCivhamu4+0sfj
 bhnCT40k0wOxzy9fLTI1HL9PXguyXuy2frYrrv4ELoljwp/yWK77LOKu82lt4PTia2JQ
 VitPX20umWeoPM7n6awvGmAdha3iI3p3h1SATAzbv3nBetcJOD/Lh4kfQ9ZgioC1ZQ5F
 JHxg==
X-Gm-Message-State: AOJu0Yw5C3FwJWYRVoMWN1qujyS0E5EJ0BRYb2VDgqvEW3lEnPCxgtWP
 UnQmH09fjJl4tlm8uVXh5iGHscFhG0mbHnTRzTiOTicr5KDBCnlInSkT3m30mS8UvDyTkuP+55n
 aIHJZ
X-Gm-Gg: AZuq6aIp0ydKSXSGIIkZePA2mhveVR08Y2qxPHn3nL3Y+38J2HMILU1F4b/UUxK9G7E
 BpBOeJzx1sKkIZ+/bMjPHAnXPRLVGXb8f43r0IRyPXPTaEIo9xwT5+ne3UFLpXNrUgoNrhJ6f6p
 3DCT1PHD448+oCVkZpCy6JQ1M3OLzU8sszejQAGsfbnHvUh8Bat/DtE3dyVJuGKeNtLbnzA1xfV
 q7hQtPat2mYpdC6sr7G3uj1uBkVybW92635I1Liyjk/v/lRxZsgKV1u5N+mERYcKHOR/ExfOSUo
 lMzpzX7X4Tb7a1AQeUvGUO+uQl4HNoqwCsBYIehXe7x8WFvodr7XXiQvw1qUWcPe/kZCk9fUtot
 UihvoYmjeUGcsdlCCqKw7nY0g+DvQetTiZQ1fg96WmeBqyLp6h+Yxq8FdZy3y+/Zh33fkRJDKoW
 DATphnvDwyl6pCU/y14vifIjA=
X-Received: by 2002:a17:907:3d12:b0:b8f:a323:bda7 with SMTP id
 a640c23a62f3a-b9081b9ba28mr549338866b.46.1771853742583; 
 Mon, 23 Feb 2026 05:35:42 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084e87c92sm329744566b.45.2026.02.23.05.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 05:35:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37B4E5F88E;
 Mon, 23 Feb 2026 13:35:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gleb Popov <arrowd@freebsd.org>
Cc: qemu-devel@nongnu.org
Subject: Re: Upstreaming of the Elbrus2000 architecture support
In-Reply-To: <CALH631=92UznqkD25FszdAAFdm_0GAvpM-m1qYW1yeyQ1Lm6Kg@mail.gmail.com>
 (Gleb Popov's message of "Mon, 23 Feb 2026 10:44:34 +0300")
References: <CALH631=92UznqkD25FszdAAFdm_0GAvpM-m1qYW1yeyQ1Lm6Kg@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 23 Feb 2026 13:35:41 +0000
Message-ID: <87sear4m6q.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Gleb Popov <arrowd@freebsd.org> writes:

> Hello QEMU devs.
>
> MCST, a company behind the Elbrus2000 (e2k) architecture has
> open-sourced their QEMU fork that features e2k support [1]. I
> volunteered to help them get their work merged upstream. I realize
> that it might take a decent amount of time and labor, but I'm fully
> committed to this. On the MCST part they dispatched a developer team
> (CCed) to help in reviewing, answer questions and provide future code
> maintenance once it gets merged.
>
> So, if the whole idea sounds interesting to the QEMU community, what
> would be our first steps?

I think your first problem is finding people that can review and merge
the code. As MCST is on the sanctions list a potentially large section
of the regular contributors can't be involved in code review.

You may find a maintainer willing to process the PRs after they have
been reviewed but IANAL so check with your own counsel. It would be
worth making sure you have a plan before investing a lot of work into
re-basing and posting.=20

>
> [1] https://git.openelbrus.ru/mcst/qemu

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

