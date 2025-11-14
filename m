Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3846CD8CBF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 01:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJiiY-0005Tc-Ay; Thu, 13 Nov 2025 20:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJiiS-0005Qt-AC
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 20:35:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJiiQ-0004V0-GT
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 20:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763084104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wAw0BQGYTBRg6+hEqOQOzyxFEqWxPqWfnfFgg6Kjo8Y=;
 b=dn5uiI6/cwG2bTP2q3C++poA0pIWxaXI84QqvSO3H7egk0zyUmfwqesig4tTAkUDcSqiFp
 UzPSc0sGYMKNl+yD1Y9tR1Vrgxvm4+7AOd+eysuhfxrhyRt0D+Mounxrruyj5k+g5dM+0e
 Fsg6+8V/SZ39OhtfxUgDGd0RfXV3bCk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-RPRpUr8TNrinoPa1YXnh6g-1; Thu, 13 Nov 2025 20:35:02 -0500
X-MC-Unique: RPRpUr8TNrinoPa1YXnh6g-1
X-Mimecast-MFC-AGG-ID: RPRpUr8TNrinoPa1YXnh6g_1763084102
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3439fe6229aso2146682a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 17:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763084101; x=1763688901; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAw0BQGYTBRg6+hEqOQOzyxFEqWxPqWfnfFgg6Kjo8Y=;
 b=X6n/Mm0ZQOaIPaM3Smezq/oZrXxGPf+QD/ZdbQnQKjvwUU5KARIlfntWP0699QT/TX
 lwfsNgju5wUwfnLlQfQQSrvuFecCvVNNkW8++A/2d2N4wVYbpBuRG/BXjXNEi4o48bVb
 ZUgHik+gO+xK16pYnZzVisfflKq8iINJzPQZ0DuhnnNkgdCLz06NbIKsKF2b94iTSw49
 dj2c5vsfN8pMZXP/heD+rgN9eZC8eEz952+YiCSL57OrtK1z2+GuidgKuqyLU4SRG2t4
 0JxUz7IAHefUsfQ48IKRIvQInzeyMp+BCvVWY0RcneLs9/z2fWhdwryarhyH9L8Xk+rF
 acIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763084101; x=1763688901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wAw0BQGYTBRg6+hEqOQOzyxFEqWxPqWfnfFgg6Kjo8Y=;
 b=qwhJAsfGjMaAHa7LiaoQpCN6AQUBA2zF9ro/We3U+RostYjvzeYm57iTHfQK/GbEeh
 NiOBwK9B9jIV/Q598HehpPn4NB56BIFE6XW61rmtKRcjhUWQGF8okbOhFEBUZUfLigmD
 Yd1YLfmO1fepFrz9ifSDsuDO7LFLPSiqz23gPjouJkybVbBYeWOS9aM5aM2KtZyzw0th
 EIZWItSdgwaLRx/kk+77pfz+oZeWmBHDgSJSSY0KViJOMtEuqP7iPGwG6QqApH/S77An
 oZfhOIsxPnKCv3qxoUp+syN3ZgAXPvybOuCxbkeVbDJYAIpBPB4PRLMbhmch33FuyLAu
 H8Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIxGwWKXyQQDCsfZ/emfgSTwBlAPmQ5EbTmV9+9V0aJCtKqyc2YGytroGg8UfBhf+ZupRfeV0loKZ2@nongnu.org
X-Gm-Message-State: AOJu0YzuWe3Wx42dsGgLn0uFH2EGMedcFqwtHRBq9kvGB4LNIkLHxKep
 dfbkRBRzjFZHYUxoZBv5FrxNThjN9Y3v/jgiPQMXIwHNx8IIL09yQoffbKTPv+trVNFaGCBIUQS
 Qn6N6I8+zWRGx1EejV4PRIZSVyIP5pMHFlZyTRiqigXkbNLVkUZ434H/e7h0nEmcBjfhRm4q5T5
 NMshRNfe7iVKdaHII/PJYkgq2UEZOeqfQ=
X-Gm-Gg: ASbGncsLslErG1CNyfs4p5SMoQmEpXKuYh14bdeLOnhwi+pRrfcOiHHsJFQOzBz4XXF
 o4S0opwhQU6y3wrGv5bPdqMuJiDge1lKrxrziUuYF8X001eGqTObYTjR8134cbyOLzV8bJ6PRAg
 iTr6uOt6M3FNzJ2HV79QwvZJulQerCkR+7/CPkLjzAq3zxh043v15eSnvK3X7g3VNi
X-Received: by 2002:a17:90b:3b48:b0:343:e692:f8d7 with SMTP id
 98e67ed59e1d1-343f9177d7dmr1570991a91.11.1763084101625; 
 Thu, 13 Nov 2025 17:35:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0kcMY/geQSr0YMOaNyFQbxuyJA+Byt97K7Sa9pmFUojn6+eOFRoEQP8DDPNtJwLoviOLZ7DJkCYPFNbc4KCw=
X-Received: by 2002:a17:90b:3b48:b0:343:e692:f8d7 with SMTP id
 98e67ed59e1d1-343f9177d7dmr1570957a91.11.1763084101194; Thu, 13 Nov 2025
 17:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20251113071711.349651-1-vsementsov@yandex-team.ru>
In-Reply-To: <20251113071711.349651-1-vsementsov@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Nov 2025 09:34:50 +0800
X-Gm-Features: AWmQ_bk-Tf5U7geCEmviwfuZVBfLnPuGrCfjcXgL71wMHQGaVvALt20E6ajaHrM
Message-ID: <CACGkMEv=UYKjc5jZRSQCzgzCe6Bdz8OGMHYA5F-5OkRVrRom9g@mail.gmail.com>
Subject: Re: [PATCH v6] qapi: net: deprecate vhostforce option
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: devel@lists.libvirt.org, eblake@redhat.com, armbru@redhat.com, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 13, 2025 at 3:17=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> This option for tap and vhost-user netdevs doesn't make sense
> since long ago (10 years!), starting from commits:
>
>  1e7398a140f7a6 ("vhost: enable vhost without without MSI-X")
>  24f938a682d934 ("vhost user:support vhost user nic for non msi guests")
>
> Prior these commits, to enable kernel vhost-net, or vhost-user-net for
> some specific kind of guests (that don't have MSI-X support), you should
> have set vhostforce=3Don.
>
> Now guest type doesn't matter, all guests are equal for these
> options logic.
>
> For tap the current logic is:
>   vhost=3Don / vhost=3Doff : vhostforce ignored, doesn't make sense
>   vhost unset : vhostforce counts, enabling vhost
>
> So you may enable vhost for tap several ways:
> - vhost=3Don
> - vhostforce=3Don
> - vhost=3Don + vhostforce=3Don
> - and even vhost=3Don + vhostforce=3Doff
>
> - they are all equal.
>
> For vhost-user we simply ignore the vhostforce option at all in the
> code.
>
> Let's finally deprecate the extra options.
>
> Also, fix @vhostforce documentation everywhere to show the real picture,
> and update vhost-user test to not use deprecated option.
>
> While updating command line options, drop "experimental" word from
> "experimental in kernel accelerator". vhost-net is in production for
> years.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>
> v6: - update numbers 10.2 -> 11.0
>     - add r-b by Markus

I've queued this for 11.0.

Thanks.


