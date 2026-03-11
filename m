Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8251049526
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GJT-0004Vk-16; Wed, 11 Mar 2026 05:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0GJR-0004VN-EX
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0GJP-0008GS-HL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 05:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773223026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/gdfKTPDRLDzNitVP5BB7zPQcxZ/nV8FvQ9vDJUvvc=;
 b=Oa6yuZFagkGEKXtCYFR3FtaIXlgN1vNrd7ECqSVWCxiPOGRDohmRNb5FacTiIrMQZrQUEC
 SGoVg20IjEGiWsZtfbwkscHfTmJXwGe+u8HHwU0utgc5sgHehtKwNtwXaoepEydJYSMK3D
 ZtuNES4MF4Ap6Hlt5qG1JuU3EH9Sk9U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-l29LoYrsOjmF5bNaB-PoXg-1; Wed, 11 Mar 2026 05:57:05 -0400
X-MC-Unique: l29LoYrsOjmF5bNaB-PoXg-1
X-Mimecast-MFC-AGG-ID: l29LoYrsOjmF5bNaB-PoXg_1773223024
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-485390246c8so40045495e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 02:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773223024; cv=none;
 d=google.com; s=arc-20240605;
 b=G+4uIEhV3yGuFXkVig4257hDL4r3Z5mkoztFHrcIebxrxu+zNg49Irm3AQI2QM7FEy
 9YkoXNS1hY/BHZaZWZcMZfbmzuCEmwFTll3EJisgg1aNsYxtcMPrMqx585tsrj/juc3P
 1eBTPWywARToQqm9a+6IWV9T6TqC40H5HONQ09tbFx7yoCDIgnoSFj4FaMnKrCo9tVtT
 8gyf2LgsCAnkQXtC1DV/D9AQRt0JJGViuigsIXamvKFAFku61WV0KxgCuHePJ4srNCFb
 Po1et6bc0EadcCid5lHiwmYjepp+wgOl4bFiB5N2jyFNxaXD3JIz63W/kSWgtbDidIY6
 iAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2/gdfKTPDRLDzNitVP5BB7zPQcxZ/nV8FvQ9vDJUvvc=;
 fh=lEWXKvk4W56vl9FK7s09UGvbWa3LPQFvWfq78Fg89M0=;
 b=NOodMAQfZ9jsIUOzOc6Uc4S4C4LkOFPLkBsWqtAUEjAw6o6Ghl9xb3QBbIlg5kuJel
 L2wnVazMbeOlj4lW3A8XpsTwkkED2y6yrxvUBrZfq3CUhA589e0OOOJcy/AM9QRWvizF
 DxGVTyJKssnl4QwWSKgjXU0uMLHgr0eR8gFUPqgwA3qbwpN8iMdtAok1z9Rq87jmV3AZ
 eCcGpOtb0dHA8JeKawc9djTuHLo6miBw/L4OsUB6ueGIlooOF6iuIM7yk7+/NJDzULVy
 40U5Gn9KWItSeDW4jux9voa8LmiPpc2KWURGiXAI3jM1FZYbU7aUKj6fBj4uqC9W0iy7
 miiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773223024; x=1773827824; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2/gdfKTPDRLDzNitVP5BB7zPQcxZ/nV8FvQ9vDJUvvc=;
 b=lPMspGrVcD4ZY8FfWvLyi8TGOpxpnY3SQ+v8rmx1pMUgr/orPthCkFIqb8MLfLFKxR
 YpsJZtMdDp0MwSrvfzpc/KeSW3sjQdahmOi5Twt5G76HsE6D046z6ucmSJTKMDS4DNA5
 Of3YmDbemcUFls4LT+01v/IrtSc2MQM0pZl7xnAAjrijihZAUeuXeoB/YwTWXk0/M8EU
 Gtht3JfnEDuo6e1zbIhAbvPffvUgnb/CT0eC+5hnadiuOdqnBX+6QxPvPm9usywie586
 KtcL15EkDIThHm68A2JnrAosogRqJ18G7+rI38t76cOmtCVWMb0DE+BdV2U5KBxGBSJk
 K84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773223024; x=1773827824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/gdfKTPDRLDzNitVP5BB7zPQcxZ/nV8FvQ9vDJUvvc=;
 b=wovxVC5bUPT4YpdTvSJwzkQsHAwm3DHPt3+E+NTfwChvII+eQYCgU2mhbyW6zAX95A
 hVeQue7QkLy4dzEEAaSqIPLbY9VNExturL9OmCp8bMZaz74Fu7R0zTwZMr+IUxYuADyy
 /jv445VnaRviRa2oo67pSSPNj7gI7QQ4v95Bf2uJXtuj9K9+26noHqk7G5eliPH8Wb7m
 L+3CLXjIssDj8AOjd+/4Wu8HD9DQZsvHntM5zuuDF8HxJ69hQXqL7uHS2poc41Bf6jXQ
 4KnvevFmQHsWQBaQOQURBKmKMpETOLkwZaLgWEKADcyqzK7leuT/QGbrJ8mhuDyOIefu
 AVHg==
X-Gm-Message-State: AOJu0YwT079Eg4liez7CI5ZJIpvDLlnr7Rc+iJXsac3S1dG2plyJYpuZ
 jBxz87YvGoiTR/UZ3/CZpETFDzqvuJFDATwPtZnb15I+YgTxd1+1dRQ09gvAsg46iqpEveSoX1C
 ONfHYpfD4FcLMNKNqztgMU7oA2iE4tBlF73/GIKL6sQqKsYee1E1OHolWg6SQY8Jdh69cvdW5MA
 vb3DGvUgUkIuPj0iT9+9H16gNSUx97zxs=
X-Gm-Gg: ATEYQzxGzHErCTYbAE9Ch9jUba7ZJkwVc0yBh7fa0wT9k1nxu0jvqcsOD+GyMEEyrNe
 MD+warzdMpQqWAxEJLtejX/dtxU2Vy3n5ghKr2OqOoLl/e3mDGjjvn8rhsb2rv3ofJwd3dcyD0D
 B6Grl3JKmWD5vd6gZnpto6MboPSlcOoe7oxbg/477F6yaTIGde53hQVDcDF6eqWiiuotEraI8pK
 Q8JkGLeY7DVNwEIR5KFsqrWn69IDmWwPWgA/G8+F4C4rqETVbGbdOUGC+60EufMXO9O
X-Received: by 2002:a05:600c:314e:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-4854b10f1e5mr33409985e9.23.1773223023683; 
 Wed, 11 Mar 2026 02:57:03 -0700 (PDT)
X-Received: by 2002:a05:600c:314e:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-4854b10f1e5mr33409565e9.23.1773223023270; Wed, 11 Mar 2026
 02:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-7-farosas@suse.de>
In-Reply-To: <20260310135540.8679-7-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 11 Mar 2026 15:26:46 +0530
X-Gm-Features: AaiRm53k_6-wFpy8ce8E53rLgSqqg3MQcK6DbEJseX697dpony4ZZ5rAke7jy18
Message-ID: <CAE8KmOyPah_+dFEffqW+yK3DK2MQ4eui=sFH3QaEuiCQWcRDNw@mail.gmail.com>
Subject: Re: [PATCH 7/8] tests/qtest/migration: Fix leak in CPR exec test
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Mark Kanda <mark.kanda@oracle.com>, 
 Ben Chaney <bchaney@akamai.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 10 Mar 2026 at 19:26, Fabiano Rosas <farosas@suse.de> wrote:
> The string was being dup'ed only to get around the const of the
> qdict_get_str() return value.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/cpr-tests.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 1b3d42e51c..fabdec4ff3 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -161,15 +161,16 @@ static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
>  static void wait_for_migration_event(QTestState *who, const char *waitfor)
>  {
>      QDict *rsp, *data;
> -    char *status;
>      bool done = false;
>
>      while (!done) {
> +        const char *status;
> +
>          rsp = qtest_qmp_eventwait_ref(who, "MIGRATION");
>          g_assert(qdict_haskey(rsp, "data"));
>          data = qdict_get_qdict(rsp, "data");
>          g_assert(qdict_haskey(data, "status"));
> -        status = g_strdup(qdict_get_str(data, "status"));
> +        status = qdict_get_str(data, "status");
>          g_assert(strcmp(status, "failed"));
>          done = !strcmp(status, waitfor);
>          qobject_unref(rsp);
> --
> 2.51.0

* Look okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


