Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBCCEC1433
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxOFl-0001oD-W8; Tue, 03 Mar 2026 06:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxOFj-0001n4-HF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:49:27 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxOFi-0003Uc-1H
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:49:27 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64c9a398bc7so5291859d50.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:49:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772538565; cv=none;
 d=google.com; s=arc-20240605;
 b=Clm8UdaJRP/xo/Dak6xJ3QkEcaEZaCb21Qw0cn21Zt+jbejk6QdeMO915YTSCOCNJ/
 36TVtth9O9U2ZctqGB4wxDd+nD6jhB6id72fDGgQs8rhVsQbDJ0Ko+T5RxI+7MxxME/H
 F5baY3LHSlXDHlzRpjGOIyVUOBXiv+Y+tKNuke9mu7i4OzkFA2Gaj+uo9ALKXu5Ol2TL
 N7LrmwSQsctcfAGTScuRllyuoLw9ALUbedEOsjuNyFbKPsZVhuzxOzN7OHnEoSArbnes
 yCE8FHrWQ9Ten0QbnXOQwkJIamXKfwvRoYnE5n/IkGVnHOLiDGRXP3GMR5TtAVOzwaNU
 yWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2hJUD9Sod/ACiZwBZu5VR2FoSOBesQTmoLcwQoPlkNk=;
 fh=AdBTw8e3qFSUl4ziMc4G2bNspFNTgb/iwfLaoEJKdE8=;
 b=aP7gzCta4PFkoArH/hNYye+yC9Yf/6b2Cd2AxIXKjCQk24zGi1LF9OVw+00Zr0+MT5
 rLQx6aggUK1lUwGOGx59rKfTHPgWA7vJWkYKC9VFkxbN98lNgRMl8I8fOpW+PR5/gRcO
 0sBwE/kbXcead53T/eJh1+bfIE3RLjjeamYrfaly8vadGVeXhRiPBC60D8vzC1z+JM9X
 GSoCP5EkqTOZtdPgnjCldcE+v3uMI09KSyOLWL6dq2rZ4ugijXJkgpyYGO0SM0UGG+t1
 R5/CICbQZaKkEdoErPNUy9/0o63jyKVwEHz7B+C3Wp+Rh0Wiikk20J7pXTDtqg2nLaix
 TPbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772538565; x=1773143365; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2hJUD9Sod/ACiZwBZu5VR2FoSOBesQTmoLcwQoPlkNk=;
 b=MtlYL0gPrTQyDsWkTOb0Oj5+gG1As7jr7el8Ih7zHErp9/OFxSTxIa0JILABL8xkTt
 nF6WoGghNsAjw8i9MX6tlPd1HviJxhdJjq0yIuRuqzVJpzQOrkdrGaW4mUoLMPAP7+jE
 6ZNYwDNaKZ8er7lhP4hlwBbwX5Q+/ogUGMBAA3IFkbYqYXtaVy113HBP4i8V5mTcpv/d
 v15HkRm/4CWTzGkVj0sHoj4eX+oZPO2e81sLx6/vQ03QxNrjB68ymGKPxO1cq8EgAvJs
 BUKbz4ILAKS2VTaeY3GmRS/B0F4wWE1gtTtn7edtnhNHedsCEEe5zp0PMJdtLwsNKgX0
 SKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772538565; x=1773143365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hJUD9Sod/ACiZwBZu5VR2FoSOBesQTmoLcwQoPlkNk=;
 b=q2QqUz5CSx4V/paNNs3MCJvvZ0Yw1Le3/ggVo+Yqu7b/X7uQxOI7oe4Ae75CCd4YT0
 bfAAkKkCn16SL9R2dA6d9V1Hr+DJ86erYI0/t7qfz78ALcKkhY1jBnOzQu+ba5nVUUR/
 imr2cgojNxywuDaL0LIc5nLLZnL+uAhcAQsiE/kz5cTP1t9OEwRs2N/3e9SfsbmW+hS8
 OHAI7Z2SrTK3DXKdUKnAYcyqEPGmdTPiHLC8FAB8hX7h1gkXdSwtu14fH9Oh1u+4mZOk
 LhyP2Vz46FI/lgxZA52rKsDnKm2twbdieV1F1y2r7lYMwT8/Thv1WlpmrgSZEappLfK5
 dj+A==
X-Gm-Message-State: AOJu0YzCwxC4RTl0LeQvOTW8sGRipyGu4TZ2RjwM4kHyk3F5PtGsLHST
 4nJn/YXGjv3NjAMduHmPsFBkJcDOtoQv9XEYT03KVVzskWa3pOXxVnozrB56iD0EAdzJRw2b8z/
 1zMmcmuffODhx3ip67sXD5o/ApZCOHtopKoR4RbNoXfFxDU2jzX1H
X-Gm-Gg: ATEYQzx6XKlOp1sJ7AjEnurtSIjl5eVlcUWcJ8z3AiN/NmzYPA/h7wkgxAmXSzOmBZ/
 L6G58Hir5dUPIPehl71y2UJdGaKQay7ZE41WzWjJx/xhEpb0dl4BwxrKRXNzy9MSQIudjg3Djxw
 QBgeGsrsk8COCCG1j0RuvhIyjgHg3urWCVy4CbdP6OVlTv8HgFMFzAzqFsXC7z/Bu3VVEB+4vV6
 uuHicsoJBg5cQFJvQocIcb43fmsBiFzFssY8s4IqgIVIt0xXmTJ7VHadB5q+tDWLGKbYqbRMLoH
 U4wzq2smaspSCJqFgPc61iXhrNBBqjUBVtryGjZhJpxENNuSOIhXteZDSFjwZbwmpVLn00tH4sT
 hTQ==
X-Received: by 2002:a53:e319:0:b0:646:a1ba:7168 with SMTP id
 956f58d0204a3-64cc22cd0c4mr9734394d50.67.1772538564597; Tue, 03 Mar 2026
 03:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20260224112215.83355-1-paul@xen.org>
In-Reply-To: <20260224112215.83355-1-paul@xen.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:49:13 +0000
X-Gm-Features: AaiRm53H_teTlzsJJeXXZkxZScQ4Iz6YgBEnQv6ejvp5s9BLJ8KPPRbxSsIbz8o
Message-ID: <CAFEAcA9CgNeDKT8mxKsU-_KCNZso2223RJ+JdFzKeQ6ACCn0Ng@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove myself as a Xen maintainer
To: Paul Durrant <paul@xen.org>
Cc: qemu-devel@nongnu.org, Paul Durrant <pdurrant@amazon.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 24 Feb 2026 at 11:22, Paul Durrant <paul@xen.org> wrote:
>
> From: Paul Durrant <pdurrant@amazon.com>
>
> I am no longer actively involved in the Xen Project.
>
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 233d2a5e71ff..ef805c8ef7a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -603,7 +603,6 @@ Guest CPU Cores (Xen)
>  X86 Xen CPUs
>  M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony PERARD <anthony@xenproject.org>
> -M: Paul Durrant <paul@xen.org>
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
> --
> 2.50.1 (Apple Git-155)

Thanks for sending in this patch; I'll take it via target-arm.next.

-- PMM

