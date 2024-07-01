Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC09FC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIjz-0007XU-NS; Mon, 01 Jul 2024 11:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOIjq-0007QL-Fv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:14:44 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOIjn-0006nJ-Q5
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:14:41 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so572469a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719846878; x=1720451678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=saIO8yuEcqIHt4c13u7+w4pPuURHegbo1guXVO5zdjs=;
 b=iX40d61e9h6wJ2BTCf+DU7SfHOz+Y6VV2g6f74vpgGjo9xEe3QXjfJ/I+9HmQ4msAp
 X1rVvKOnw4wgCTqltvgeJZiDly2J9Qri9sU79vibZmFs960KbrvkQ4UKTLp2FZcs4nvp
 ljXkG/AeZvMWgLLAJmdMFSveo/xcZpmkemSMQICvuzhXMmnmivT11McgXRcslg0AU5eY
 7LprDZa2HUOA48GElq808Qwu5gyFq43eTzJosKyAWuWoVOcanhqNQHOarLXkT+ReNOZn
 YlXJDZufoMzYg6GWdbo2FM3ee1vzETEnh4FfA++0SJD0bTvaaRl1B9XGaKwd4IY31/ib
 AXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846878; x=1720451678;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saIO8yuEcqIHt4c13u7+w4pPuURHegbo1guXVO5zdjs=;
 b=m+999algFkCjOZDIZg2eDWJEtHyOgIl2sSmEhnFYoNiHgFHJvBfZn5bnmmESNLMEPt
 iPIEq/Ja//0gm51oiMg7Qjdax8CRLfaNHFpVaBAs4gwrRInMtO7lk1NllwfInFTt2914
 fFFwc+4XaNZWb5xpzjcwxY0bJSh/C4oScmgt52aZZXbCK2KUO25qsFvnzrG4lZ+n8ZbL
 4RKn9HEEaqJXkdEwPeIjSyuhoNi4KK0PzgTYuMa2AiLUDVaJEmBFZBsXZlI3l1GxiASo
 yv2E+bXe685qnKm76TlsLjPmq9bY9Umf5is9DWWbx3njWOmRVFB+PqjfDzT1L37EU36N
 Vo8w==
X-Gm-Message-State: AOJu0YxrxeiikAxshIo2KN31gNah7XWoeI5VMQ+I3lpbamB25dvmpwR5
 Ka6ju3RZ0fhKbgYAgWQw6WQETBNcbCaLCwcfrxYzNUziM6zMfqUF394brnlzq8c=
X-Google-Smtp-Source: AGHT+IEQ9P0iRHz1rDytgfGuRHY6C/TW0TLRKOo6vSh0cErX1WeW4dYyeUykK/9vzZu90M7SOougIw==
X-Received: by 2002:a17:906:f909:b0:a71:afc3:5c94 with SMTP id
 a640c23a62f3a-a7514498f2emr370765966b.74.1719846877361; 
 Mon, 01 Jul 2024 08:14:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0652eesm342943466b.131.2024.07.01.08.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 08:14:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E3CB85F877;
 Mon,  1 Jul 2024 16:14:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "BillXiang" <xiangwencheng@dayudpu.com>
Cc: <qemu-devel@nongnu.org>,  <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: Skip unnecessary duplicated
 VHOST_USER_SET_LOG_BASE requests
In-Reply-To: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.8eed26c3.aba1.4d51.9976.281bbad0a8e6@feishu.cn>
 (BillXiang's message of "Mon, 01 Jul 2024 17:36:02 +0800")
References: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
 <87zfr1qyyi.fsf@draig.linaro.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.8eed26c3.aba1.4d51.9976.281bbad0a8e6@feishu.cn>
Date: Mon, 01 Jul 2024 16:14:35 +0100
Message-ID: <87msn1qh44.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

"BillXiang" <xiangwencheng@dayudpu.com> writes:

>> From: "Alex Benn=C3=A9e"<alex.bennee@linaro.org>
>> Date:=C2=A0 Mon, Jul 1, 2024, 16:49
>> Subject:=C2=A0 Re: [PATCH] vhost-user: Skip unnecessary duplicated VHOST=
_USER_SET_LOG_BASE requests
>> To: "=E9=A1=B9=E6=96=87=E6=88=90"<xiangwencheng@dayudpu.com>
>> Cc: <qemu-devel@nongnu.org>, <mst@redhat.com>
>> =E9=A1=B9=E6=96=87=E6=88=90 <xiangwencheng@dayudpu.com> writes:
>>=C2=A0
>> > From: BillXiang <xiangwencheng@dayudpu.com>
>> >
>> > The VHOST_USER_SET_LOG_BASE requests should be categorized into
>> > non-vring specific messages, and should be sent only once.
>> > If send more than once, dpdk will munmap old log_addr which may has
>> > been used and cause segmentation fault.
>>=C2=A0
>> This looks fine to me but looking at the vhost-user.rst we don't seem to
>> make any explicit statements about how many times given messages should
>> be sent.
>>=C2=A0
> There is indeed no explicit statements about how many times given messages
> =C2=A0should be sent in vhost-user.rst but already have some discussions =
such as=C2=A0
> https://lore.kernel.org/qemu-devel/20230127083027-mutt-send-email-mst@ker=
nel.org/.

Right, but I think we should then update the specification if this is
the way we want things to work. Otherwise we are putting a backend
specific hack that another backend might be able to tolerate.

>> >
>> > Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
>> > ---
>> >=C2=A0 hw/virtio/vhost-user.c | 1 +
>> >=C2=A0 1 file changed, 1 insertion(+)
>> >
>> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> > index cdf9af4a4b..41e34edd49 100644
>> > --- a/hw/virtio/vhost-user.c
>> > +++ b/hw/virtio/vhost-user.c
>> > @@ -371,6 +371,7 @@ static bool vhost_user_per_device_request(VhostUse=
rRequest request)
>> > =C2=A0 =C2=A0=C2=A0 case VHOST_USER_RESET_DEVICE:
>> > =C2=A0 =C2=A0=C2=A0 case VHOST_USER_ADD_MEM_REG:
>> > =C2=A0 =C2=A0=C2=A0 case VHOST_USER_REM_MEM_REG:
>> > + =C2=A0=C2=A0 case VHOST_USER_SET_LOG_BASE:
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return true;
>> > =C2=A0 =C2=A0=C2=A0 default:
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return false;
>>=C2=A0
>> --=C2=A0
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

