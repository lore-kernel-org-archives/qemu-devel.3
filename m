Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BB5FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHcUC-000738-Ri; Tue, 28 Apr 2026 03:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHcU6-00072M-VL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wHcU5-0007Va-Bm
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 03:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777359831;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QyawPg9Aq3lbS5XDVMpEjzlUp1HDzjTtjnuHaBu5e2c=;
 b=gCCghBXOijgyvRJH+22uyM1qWMLtO3Weaww+YnUE8SVXGqtkbIf+w/duq54VQxiEs3Qc9a
 8yksTrSMsNUxXsMzUNHxvZS91zSO5MkPBNWQIMka+Lrr83mQh78REbh05spiK4iXaVDaML
 zlXXx/kWMw/+Jqybv0dX14qk3yN5qDs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-Wn1CRznnPSiT9fsNDaRlJg-1; Tue, 28 Apr 2026 03:03:50 -0400
X-MC-Unique: Wn1CRznnPSiT9fsNDaRlJg-1
X-Mimecast-MFC-AGG-ID: Wn1CRznnPSiT9fsNDaRlJg_1777359829
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b1f39c5827so133798426d6.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777359829; x=1777964629; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QyawPg9Aq3lbS5XDVMpEjzlUp1HDzjTtjnuHaBu5e2c=;
 b=c+HiNqRApbKnxUNPuOAf1EZZ2OLGz7iYj70LtzrT0GPbe2mT7LHG4JWXvZzGxyEYE2
 TzyPv+n8EZHNpTafROTpml9l2tqVAc+DTTDcl7liWAdP/LPq4yV/7YMtKC0+R3NdHugy
 TuoG09hjZXlcyJcqyrqMvg3jatiCz23OnblOxtei7+R0A6IuXM0Qt7Yp+mekwIumj4fo
 edjJeoDS6n7CCmft2lPjcHXPkkk2yQoth/bxER/7HYnHuJeq+yxAy0Wsn0fo38RG/NSW
 fiX55A28DgwvXWMxaC1NvWaaHE0sTyPbSz7voanmV3BAJz47TySPyF+yGvrCPQB5C1Ab
 xTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777359829; x=1777964629;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyawPg9Aq3lbS5XDVMpEjzlUp1HDzjTtjnuHaBu5e2c=;
 b=ONyailM5N8vvuz0yBQBdA8vWfJfX6rMNPLFO49Ua1xgSi+IHisNbaCDCQilL3JdtP6
 uSccuyA7LVoJAc8K1Mw45Xk1x1F9ZKG6mCWvs60EImw4T7pHh8+hRyR3YYtgVlgYfIxm
 kArh+jvdpPn9d6IKl8wM0XPyw7YvMt0D5qWhJW35nRb05+JKDBqtr7FNSydk3k5/fqbS
 OsXlBjpLdvxTE2VUEWsOszkMnvB2ntxk9TpNgKkopg15ABNyTDY+yFaz+PvMtei8TeVY
 HzAEBmormPRo2DYKD3H9nz7ZN6lNwwQZxrmZ9Sx/9KwJknwzVi10NJiPgD2b+uGU1UJ5
 KQdw==
X-Gm-Message-State: AOJu0YyUjy2haClA5QnKuqA7BYEQ/oUc9ICnSU5LyTtuJzzLzuDZQtVS
 mOVvmHAZJrMHRekbSInOHNPdG8oWaUtSnZO5ZqOHeUMWvmPvtMSlvlvAiJBRHKvbRHZLG+yCkyc
 +ayfhLkjQnFdsWR23errNTYqWvSbN6ta6eWTIERYHNx+U/E728epUkKV9
X-Gm-Gg: AeBDies7ewcus6enD2bPsHVc/X61jH9k75xcMFM9iCT64qW/wTs6UkXWMHDisjW/TyQ
 AytJJNpBdkYoEZbj0ScQpYVpe9Po0G/vHOfj57xABrIVLR5p+SEmdhSO2uHCRMpwMoJcZXEbCxO
 /Z+Hx+bVgvjO1Ba5RVx0YOwkeLOIJHVahvZlh9a55T/soGe20qc4lp/KU1Ah6o3tx6W5IV78YVl
 QOzCjTxmrQNg3xfYIOqMQ/RZ2YPbF8fjh/52Wbj16SebYX1PBNS9v8lEIfCtUzvggKppnXzejwb
 9FLojeuUFPgCwoS8GHSxMJju1jWSmbrhEvfHCuVVJomc3N5ctrfdwjaY7ww9zAUSAD/Vy4hPYZr
 ZLOMYXM/GxkbKfqLg0R346EskAGtL7M4=
X-Received: by 2002:a05:6214:5992:b0:8b0:2910:a365 with SMTP id
 6a1803df08f44-8b3e31d703bmr31235406d6.29.1777359829393; 
 Tue, 28 Apr 2026 00:03:49 -0700 (PDT)
X-Received: by 2002:a05:6214:5992:b0:8b0:2910:a365 with SMTP id
 6a1803df08f44-8b3e31d703bmr31235006d6.29.1777359828968; 
 Tue, 28 Apr 2026 00:03:48 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3e2956a8bsm13690806d6.31.2026.04.28.00.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:03:48 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:03:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 2/2] ui/gtk: Turn clipboard flag into runtime option
Message-ID: <afBb0cwglKDhWeQj@redhat.com>
References: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
 <20260427-gtk-clipboard-v5-2-6968feb31a5d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427-gtk-clipboard-v5-2-6968feb31a5d@gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 27, 2026 at 10:06:44PM +0200, Jindřich Makovička wrote:
> - Compile the GTK clipboard support unconditionally
> 
> - Introduce GTK clipboard option, defaulting to off
> 
> Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
> ---
>  meson.build       | 4 ----
>  meson_options.txt | 7 -------
>  qapi/ui.json      | 6 +++++-
>  qemu-options.hx   | 9 ++++++---
>  ui/gtk.c          | 8 +++++---
>  ui/meson.build    | 4 +---
>  6 files changed, 17 insertions(+), 21 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


