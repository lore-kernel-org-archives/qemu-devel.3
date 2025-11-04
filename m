Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF10CCFA03
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 02:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG6yh-0007DA-1s; Mon, 03 Nov 2025 21:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vG6ye-0007D2-QS
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:40:56 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vG6yd-0006Po-1Q
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:40:56 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b70406feed3so1126700766b.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 18:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762224052; x=1762828852; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyMCcojKz9XKybxE+3pwKpMUzaz6QiQSBxuaFAbidg4=;
 b=Jt0tKQ8gUTxIDxqV5M2i0p/19N0HJCLF7O7Te5woZxcuLRb8d05IsKbOTfgK+iwhyT
 y2CA8UvvifOxD1yPE9A3bMso/wyGLiTtE6k4j4/DUuDSctfLEi1ZqQc4sssggpIFO/0I
 x63mJAP4uMNVYXiohAs+TEOo9MRBXFdZplDxqmkhUzBOL00prXGwTCwbtE+FhdxYYffS
 6jMSuEskWq1xrkgywRnhoopw1MRoEpLyAKp+0u6ZSbf5DAkElG6JCXItdiWHSzB7Ao/i
 gvqHODwHD/vlwTP62StETEk5BgI15eQPokjEfRnWf8iyWmNoFh+K4E3tGqBmeAW+xfuI
 vk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762224052; x=1762828852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyMCcojKz9XKybxE+3pwKpMUzaz6QiQSBxuaFAbidg4=;
 b=Mz1+k04mRwXsDswj5ynhE6Q8tMvRJ5PTBW2qLOouHDbXUlMIf5OwqKIQ6F2kdwSYye
 acXasUiLMXSE8CATp/6UaP0NBGder36AGPChNzl+sqCQV3XYQQCweck8BK8y241Ms4B7
 KyxYa87rCTs743XrBJTtqIMnyzPgkZ5hoB/u8JhVq1nQI0TjhniahMQI9UgrNln38RMR
 tdkbMvZgze4hrCxmp81ChCkR9uzgbZSHD5hIgXrbuOaYozsaB/Xs1kDfrlY96rZSV8am
 vHnQ3TqMdGndA94r76veJJ39FlKdn+6VJHPuo2/LwXzrxCPIRa5uifbRO/UnZZPy8hVR
 rjXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmAdHo7r9YZbtW0KuGjxQ+0ydvIwP5vOclOQ7W44ObEvaix7pyC4tP5S2M/HJuPRQtr3YlbkgSCPYj@nongnu.org
X-Gm-Message-State: AOJu0Yyvy3I6kdR6mYHxZzIf46gXT6dOGGrcbvtTFjoOx+Etsmv7nmeR
 HWFV2p5Ncz9YYiSApCJvADf/3mM49Zak7/8UbaTMiBssHsSgxv0kIZ9QIJwZMxBD7A94/0tzN/+
 VZLLUaITkuE+k01TjM//4yHEaFQuKvwM=
X-Gm-Gg: ASbGncve2t4cVM1dkTWQ3o8qKSasMwXcw8OtaDg7+PYvh9bSnQuA1cUGJ0rtgK0SCfT
 +VxZ5NwTAGshkW15tZ66RIZNwx5IvxFCVMVwGRkHwxfrs2+JJlwlXAdM8Rae8H0Jz3CnMEoy0PD
 XGSuWPQDdy3GJd0GFMF8PzIbz/8xXMSkqGK3RkMdqDrYOTCfd+yFx+ypC8Czj5x53SFBeCw76+1
 sX+ny/U6mhCsfQG+ooRFxcAR7uSXwj21VeLJCO/oLlTNBrnrKOOkuPasXYHmQ==
X-Google-Smtp-Source: AGHT+IFedAykftALRkaiK0CnVRNt7jWwxsTFKZLz9QlfHuh60IqHtaFFma3N7fKRB7Q0nRs45MagVYsyv8ofxrd/ZcU=
X-Received: by 2002:a17:906:f586:b0:b72:134a:48c8 with SMTP id
 a640c23a62f3a-b72134a5137mr174752766b.14.1762224052056; Mon, 03 Nov 2025
 18:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20251104013606.1937764-1-lizhijian@fujitsu.com>
In-Reply-To: <20251104013606.1937764-1-lizhijian@fujitsu.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 4 Nov 2025 10:40:15 +0800
X-Gm-Features: AWmQ_bmqPafiTtomhcKlqUFnDwgPzSI17dVv1TyVm5xi6VU4RaFK_S71AqC0uv8
Message-ID: <CAK3tnvLy-Bw2skxOUqcT=4gdbL4YF8xueVGWaqWDw_i41-b01A@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix transition to COLO state from precopy
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: peterx@redhat.com, farosas@suse.de, zhanghailiang@xfusion.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 4, 2025 at 9:34=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> w=
rote:
>
> Commit 4881411136 ("migration: Always set DEVICE state") set a new DEVICE
> state before completed during migration, which broke the original transit=
ion
> to COLO. The migration flow for precopy has changed to:
> active -> pre-switchover -> device -> completed.
>
> This patch updates the transition state to ensure that the Pre-COLO
> state corresponds to DEVICE state correctly.
>
> Fixes: 4881411136 ("migration: Always set DEVICE state")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

LGTM~ Thanks Zhijian.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Tested-by: Zhang Chen <zhangckid@gmail.com>

> ---
>  migration/migration.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index a63b46bbef..6ec7f3cec8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3095,9 +3095,9 @@ static void migration_completion(MigrationState *s)
>          goto fail;
>      }
>
> -    if (migrate_colo() && s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
> +    if (migrate_colo() && s->state =3D=3D MIGRATION_STATUS_DEVICE) {
>          /* COLO does not support postcopy */
> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +        migrate_set_state(&s->state, MIGRATION_STATUS_DEVICE,
>                            MIGRATION_STATUS_COLO);
>      } else {
>          migration_completion_end(s);
> --
> 2.44.0
>

