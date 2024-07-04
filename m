Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA30C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJ61-00015I-N8; Thu, 04 Jul 2024 05:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJ5y-0000y8-IG
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:49:42 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJ5u-0003Hr-6D
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:49:42 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-58b0beaf703so576673a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720086575; x=1720691375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=13V5WJjFybPwm1SKLULJFlxEOKiTMm4cn3yxKgM2Jp8=;
 b=gn4neEuUv/jkmLOsk06ihPIfaHSiKX/ldlS6qvWOqyIdJHhSAUa6QGpUUMad+vaFev
 cxih1RfpMVwhTJxCBkza9SGBXSbeP6ZAKFTDZgN3iiIpbTUyiZlbhjT32jKayVGHDnv/
 LrXnhFPG240I7NeNeIfdB1b/3pjn8SUyIsTFHmlWYOdt1ftm9z4R0qTRsysTS/9cbUcC
 KxjI0hKbJgITh3THJBABQWPs15bN4wU7KdCo9w1NWAOIBJkFwAjitdqbb6ZG5tnYsRMT
 i1z8GZbkrq65PlO1rWjG9zZxkXG4RhoJ4DD0JMHocSjFBaeOO1hhTNgytxYsACPUUItE
 zzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720086575; x=1720691375;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13V5WJjFybPwm1SKLULJFlxEOKiTMm4cn3yxKgM2Jp8=;
 b=EmkRcal4+NvkMfsIERsd6AhlTxHoT7p+4QB9Uqqq44nguU+uz0b23L/a2VSfMypvaN
 ZalN7JjoKWvLKwMxL4l6ddj3obS4h9P0TAj531wZgRe2RQfEArDk88plgiFppl8RciiI
 46etyj2l3GesRBYcvO+8feuZpdcD1h9nPkHSphYYQ6D87DUmD6PgTbSNX1nODKV3UDBP
 NmTUemC2WaxLQ2fTEd/3CXHJ1yIzcpLHWLujb2RwYa09jsIdetZ0VVWi81LH52c+bssv
 CKK6rU8+2jFVg4coXUKWgDyMAf39/vtHJu2t3bwEbGtKalv9YO/2PrBk/1DxWANS9Ad5
 MmDg==
X-Gm-Message-State: AOJu0YyYsciI0OrN3BotT+ln4XTD87YDW92YiaYgdGY71qYFFATn1OX1
 ngm50Xvq4X0cjKxKBhGMA2oYX/6zALJTzsvls9p94oVpRrgYqxGfK9pM6cNaW0Oh/rz/OoZ/ypW
 J
X-Google-Smtp-Source: AGHT+IFg9laa+FuwqOGd5tU+qCjhEpq7leM+IU3WKk1TLRaV53bVdSRrJlRIXC4FkgjwFyVi1QdnHA==
X-Received: by 2002:a17:906:d0cd:b0:a72:81f5:85b6 with SMTP id
 a640c23a62f3a-a77ba4756damr71199366b.18.1720086574744; 
 Thu, 04 Jul 2024 02:49:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77b788be53sm40016166b.182.2024.07.04.02.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:49:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B3665F839;
 Thu,  4 Jul 2024 10:49:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add Stefano Garzarella as vhost/vhost-user
 reviewer
In-Reply-To: <20240704081336.21208-1-sgarzare@redhat.com> (Stefano
 Garzarella's message of "Thu, 4 Jul 2024 10:13:36 +0200")
References: <20240704081336.21208-1-sgarzare@redhat.com>
Date: Thu, 04 Jul 2024 10:49:33 +0100
Message-ID: <87v81lo5aq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Stefano Garzarella <sgarzare@redhat.com> writes:

> I have recently been working on supporting vhost-user on any POSIX,
> so I want to help maintain it.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

