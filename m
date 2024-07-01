Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536EAC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCjW-0002yo-Hc; Mon, 01 Jul 2024 04:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOCis-0002u9-RU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:49:19 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sOCir-00050r-1d
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:49:18 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-585e6ad9dbcso2969741a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719823751; x=1720428551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d47GClQWTKYuZpPkQTNk8v60KFq323k3GhJ96sEsSp8=;
 b=toulnVX6eZAj5A8pv5ABhbgeFWzLNqMl+OeuTOnPKSTRQdSgfuXFSIUchbA48p+ptQ
 3A9u8TiiFyTYtBZiS+YYgk40eW+kvkOslB3ksTu+0qS1ZygCh+XCcXCZOZ2mhdspCYw7
 7B8lvr2JJMC1ZjHkhTgNTlgZCzj0Wc9ouBfjkhV+vF8sZvYmvTy2K/QtwDisn2KK970X
 /VDrFyzPyClozbDbweUghomzMNzxyb85EU94z3eZyaJ4WgOVni7YRYMXunYkO3pJq19h
 PqBN/dBdyWcAvYut+xnxqSxw17gyjEfWk6WiQk55DpIalS4vcKBuqTzm6GJwCFjl00PJ
 0E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719823751; x=1720428551;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d47GClQWTKYuZpPkQTNk8v60KFq323k3GhJ96sEsSp8=;
 b=Y9XgqcvDzO3k/Wgpf7HKbbx0u46OnGGEFH15cqwJvlI7B+B5VHZxWJfTPGIDvE1dAt
 Ulz1oHCYgcVTxVhLqvKkUCoCkuGiX6pzLIJ9iJu5m+trJ8596JHtELQC9ik8l7zGn1Mn
 BqZtHOCyFreNOoMGP2OlwD55YXxFa1hrstdANI4JMsO5D4CbeY0LdPuc+LTCmcy83MyZ
 hfAZ3+iQUznvDrDFCpmY9uJBrAordmjSgsVJ7KZAP3jmElsNSurm8xMpUbYpUXbscpjL
 7/jlIzpgdHfoTZVw2YopyNz14lAsp3+YMSXR+FEbrhtLxkY2RIn1TOQ7R6DFR5Y8whaD
 9m0A==
X-Gm-Message-State: AOJu0YxoZiDYEavH8f/sf7tgdaKuoGplWToVs7Ahv1x66OfcWRmxLMzr
 BII6yKTK2C+kXN2LtXTyES489EK5qZK+/ovISguTmRsVSJ3GGTV1B0VSvZK7Gsw=
X-Google-Smtp-Source: AGHT+IGuWg/18eBk95/Il++5Bi3s4PuX1mPXDAG+n48WKNbf+g05dtr7J5P85DSPiGEsejnwm6jYpw==
X-Received: by 2002:a17:906:adb:b0:a6f:878e:d6f8 with SMTP id
 a640c23a62f3a-a75144deb8dmr290146966b.70.1719823751021; 
 Mon, 01 Jul 2024 01:49:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b7ddasm310363966b.207.2024.07.01.01.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 01:49:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CD035F877;
 Mon,  1 Jul 2024 09:49:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?B?6aG55paH5oiQ?= <xiangwencheng@dayudpu.com>
Cc: <qemu-devel@nongnu.org>,  <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: Skip unnecessary duplicated
 VHOST_USER_SET_LOG_BASE requests
In-Reply-To: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
 (=?utf-8?B?IumhueaWh+aIkCIncw==?=
 message of "Thu, 13 Jun 2024 14:51:50 +0800")
References: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
Date: Mon, 01 Jul 2024 09:49:09 +0100
Message-ID: <87zfr1qyyi.fsf@draig.linaro.org>
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

=E9=A1=B9=E6=96=87=E6=88=90 <xiangwencheng@dayudpu.com> writes:

> From: BillXiang <xiangwencheng@dayudpu.com>
>
> The VHOST_USER_SET_LOG_BASE requests should be categorized into
> non-vring specific messages, and should be sent only once.
> If send more than once, dpdk will munmap old log_addr which may has
> been used and cause segmentation fault.

This looks fine to me but looking at the vhost-user.rst we don't seem to
make any explicit statements about how many times given messages should
be sent.

>
> Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> ---
>  hw/virtio/vhost-user.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cdf9af4a4b..41e34edd49 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -371,6 +371,7 @@ static bool vhost_user_per_device_request(VhostUserRe=
quest request)
>      case VHOST_USER_RESET_DEVICE:
>      case VHOST_USER_ADD_MEM_REG:
>      case VHOST_USER_REM_MEM_REG:
> +    case VHOST_USER_SET_LOG_BASE:
>          return true;
>      default:
>          return false;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

