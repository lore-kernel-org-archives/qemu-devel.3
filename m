Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C157FD0EE0D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 17:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNwbk-0002Pd-8c; Tue, 25 Nov 2025 12:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNwbZ-0002Ld-JX
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:13:30 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNwbX-0006S6-Ee
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 12:13:29 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78665368a5cso55144287b3.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764090806; x=1764695606; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtjFf0Bzvzx5JCRw+LKqfGdv0fU3m7HcMECmJcdWSlc=;
 b=COISwQOa2U7zHgzA94SLqD8KCVdkyTlMA6cYVqhkf14akF16Xz8X5GaN+puXwvUWo6
 fsJgoER8Q2h5R9E8qrmH32Lwv85Nj7OQ0SEfUnqdBicZeKf4JyhG3hk8oPf7xHTC+1AQ
 TKX4pO9wOdur6OC6K6dVVNKZCRfGO5NRywBUpCsbgUdttVi0n+F20FGVWtQjhyuJS3d2
 Wmerf9VwnZ47MJXr6x16wN6aSE2F8apOW9EVjaVXlFmASR0rcdonNYsqmoRmMyoT6RDr
 XH9IiiN07WeOyV8NkKa1GvUpTertKO1L+p2lUp/kvpufE3Y+BrxN0R/oFHWlSSZeXT/b
 ptcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764090806; x=1764695606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CtjFf0Bzvzx5JCRw+LKqfGdv0fU3m7HcMECmJcdWSlc=;
 b=c1Jc9RD3Stg93ez0Z/rncomkKO6QIm4uQIOHaSOr/UTe4OYOApYQtgW/4ugdoFnr3Z
 WhQLARrGsd9SG4Q5PeIxpua7w4Jn0miTW8k5qbyI5VVn3w7Lg3OAq8fFE34pgyVnSY58
 QYP3hXmgXIpLQwiIMjrKd1fTxi9VQbK0kW9l7Tc8yMsUiqFiJZg97dHwMsJrUnefc43L
 lIY/Gwl/JVEYioWXVjJd1xSQki2RkZhxBoS1KSMtdMaQXGPNVuAxLD6hLZcY2uxTfdpq
 iL+rvpAewgOJwhHH9bcAB/5AFNQUnOJ2+LFB7THiHtz3a2kfxtPtEkLsX3J3fA89bRa5
 j0bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtykNAaICo87Q8FagLuK+GWaTgrr2hRzCcSgwU+oyFyEEcjlfA/5Qay+FG74mEJPrq+0h368Ezi1Zd@nongnu.org
X-Gm-Message-State: AOJu0YywLr3zE4qiyCBUnZ8nggP9wXxZkd0i6Iy6z+ve7773PraTLoYq
 W42zdt47hSdgmyaSdpPyVjyUdGhkIGkk3hIYUW/x1+cKlCSUZAo/yl30BrudUOvTLwQpMZ2V3eC
 DXel/H8mdEPaEFp2y81EEB3besh7q0aQ4e2AiDhF+zw==
X-Gm-Gg: ASbGncsuB5dfr7SGFHf4UJZzCdDuO7rPghAQbgX/M6StpZFb7Z64lACp7oMJ+NvyWN+
 wT7hqrt9S29NV+gBTuaFQUPvgacGeg7OpxpRl9HcJPYrrHzLttlOwktfibfRCEWxYsSreoQ5B4e
 g5RGmInPnl3oSiJ3cpq50OUEPLzyaZZVxCfqgDgEtuMq6wZEIi+q8KvqxJuJWAuwlNowYJ+tS+z
 +l72PNttSPCd4sQ3qUZbkyxlR4uTze7BmlGH2Teid2wf7U0qHUEg9i3Fw==
X-Google-Smtp-Source: AGHT+IF6Ge6f1dAmXzoGWd8GvLHJ9ascEbreO3zZ2EnLBcX5oriapv+dfH0ojSQW9ZEZ5Z+Xq4/LchkLatgQc9UxLh4=
X-Received: by 2002:a05:690c:4807:b0:786:5f42:5ac8 with SMTP id
 00721157ae682-78a8b4720d7mr143479317b3.15.1764090806333; Tue, 25 Nov 2025
 09:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-5-john.levon@nutanix.com>
 <819f4595-b323-4dcb-96c5-09c52cb09380@redhat.com>
In-Reply-To: <819f4595-b323-4dcb-96c5-09c52cb09380@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Nov 2025 17:13:14 +0000
X-Gm-Features: AWmQ_bl4C-2KFCr0vkc3L7JS3hsLTqH070cwmX26DSZxYYEzS3K4e-79b5z4bzE
Message-ID: <CAFEAcA8+3=ZErD=pxs8Ne9+D1ZXujBKh000XiQs4egXayw9tcg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vfio-user: simplify vfio_user_recv_one()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org, 
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 18 Nov 2025 at 14:58, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On 11/17/25 16:56, John Levon wrote:
> > This function was unnecessarily difficult to understand due to the
> > separate handling of request and reply messages. Use common code for
> > both where we can.
>
> It's still difficult to read :) Could we have feedback from Thanos or Mar=
k ?

FWIW, when I suggested a restructure of this (because it popped
up in a false positive Coverity warning because Coverity couldn't
figure out the logic in it) the shape of code I had in mind
was something like

static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
{
    /* common prep, header read, etc code here */

    switch (hdr.flags & VFIO_USER_TYPE) {
    case VFIO_USER_REQUEST:
        return vfio_user_handle_request(...stuff...);
        break;
    case VFIO_USER_REPLY:
        return vfio_user_handle_request(...stuff...);
        break;
    default:
        error_setg(errp, "unknown message type");
        goto fatal;
    }
}

and then use a shared helper function for the
"read rest of message" logic which is the only other
part the request and reply codepaths seem to share
once they diverge.

In particular this means that the error-exit logic
doesn't have to have "if (isreply)" checks in it,
because the error-exit path in _handle_reply only
deals with tidying up the reply path, and similarly
for the path in _handle_request. This is the kind of
"codepaths diverge and then rejoin and then diverge
again" flow that Coverity (and I think human readers)
tends to have trouble with.

There are some fiddly loose ends here so it's not quite
as neat as the above pseudocode sketch (e.g. maybe the
handle_* functions need to return a value and
vfio_user_recv_one does some cleanup on failure too).
But anyway, that was the thing I had in my head.

thanks
-- PMM

