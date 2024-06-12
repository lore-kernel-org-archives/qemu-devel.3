Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD4DC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHP87-0006no-6U; Wed, 12 Jun 2024 10:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHP85-0006ne-KF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:39:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHP83-0001wi-RS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:39:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-421820fc26dso30617315e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718203150; x=1718807950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ef8cwBqo6pL0WcmkepLN9dRSm/R9iIFcuoJzW+Em48M=;
 b=iKOEqu5BQgOqhmNX2xu2CCac6vrnlTGvKqIT4jss39LcYK0qjJ5XG8m+ooe1iHXCnk
 jrvkWc5A+pwccMVyxH0EoNVETrperqnql2LaNrhOqg+12BrHZG5/bjSb0ycDX0Eitk9W
 9QnMPQuh3XWCt9HbItgaMsoK7trW/4o/tzAcG0QuQuEInP3HUDtRXZayVGuxuGMcXkuu
 pwO0Qm1oLzxgTSy1PF2MFgzM0uUFvgL0IRIrewrWDgZAVoEvBAxU9MOKlh6YzCXB8iXT
 Rg6/KZCewkiEeDnb6uQHfC7qUzOSHrMmQvyiKHvLBClPw/gkDqClmVshgUmAizadobB1
 Lt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718203150; x=1718807950;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ef8cwBqo6pL0WcmkepLN9dRSm/R9iIFcuoJzW+Em48M=;
 b=r6A8pPe4oUqzkj8oQeSx0R1fwf7JfdL9tnsicyKr1s22Vdh1oq21Ka0MXWvDUe24sB
 qRB2LAT/Cuf8DPCBCu7IevEWcapLwNy0kbwSyCgYLlt6qurqkmq0ih5gAsI7RAI0d0YK
 f31J2ix+CmUFAJ5SQe0uZvpblm5OqvK0jfhL7qJU0zdmMoj8V0RclnqRQx8JYENasxZA
 h1qZST6YM7Jv/kytYouF2/xc08j3v3Vhk7tgFTDiOTdgRZqib//rTjN9RGXuxil++wL8
 kgLoS+fXnpl8y9uFKNR73289/B9KgqiX1KUtpxBb9riaoUGan+d9xAlI/VAoV1ND9P5b
 E92A==
X-Gm-Message-State: AOJu0YyFObxF71bhAz0GZurQDJToztsLH2DE3LVghLTxuwMlOWjJSGKT
 xqEtuvhl2u//qKOtzqVTx5FCQ3WAEUgu8vlFP86Xf4HyyztCbkvftm8KNfv5+yc=
X-Google-Smtp-Source: AGHT+IFn1VrE5Z064gGrLkXklyEZ69xb+hNJ3JoOFFLoXsMh+6DLfwDmCxFjMTbceagkyEEJ3yBQaA==
X-Received: by 2002:adf:e9d1:0:b0:35e:7dfc:345b with SMTP id
 ffacd0b85a97d-35fdf7ada3bmr1550404f8f.35.1718203150257; 
 Wed, 12 Jun 2024 07:39:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5fc0a0dsm16903041f8f.91.2024.06.12.07.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 07:39:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E78A5F893;
 Wed, 12 Jun 2024 15:39:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 0/9] plugins: Use unwind info for special gdb registers
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 5 Jun 2024 20:29:17 -0700")
References: <20240606032926.83599-1-richard.henderson@linaro.org>
Date: Wed, 12 Jun 2024 15:39:09 +0100
Message-ID: <874j9yxm2a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> This is an attempt to fix
> https://gitlab.com/qemu-project/qemu/-/issues/2208
> ("PC is not updated for each instruction in TCG plugins")
>
> I have only updated target/{i386,arm} so far, but basically all
> targets need updating for the new callbacks.  Extra points to
> anyone who sees how to avoid the extra code duplication.  :-)

I've made a few comments but yeah I think we just have to live with the
extra helpers. The only other option would be pre-notifying the gdb
subsystem about which registers are "lazy" which I think amounts to the
same thing.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

