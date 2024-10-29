Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13401D2AB3C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lo3-0003D6-8g; Tue, 29 Oct 2024 08:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5lo2-0003Cx-EG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:58:42 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5lo0-0004AB-Hm
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:58:42 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d63a79bb6so3815333f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730206717; x=1730811517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHxAvFj+ZMvpi1xXlJf1uTSVkbPDoJ5QlNNixnWD9mw=;
 b=D/TVDEN3IYxden+09Bn6B9qaRBhxEXXvO09AdvWdEKkPte3JGaYORrqzDtfKcG74D4
 0iG1SJAyeg8R8Z6S7MoatZXUflu6IQUhbgUVzTVX7H3187Zx2c0lgICVifePNxV/+wBy
 AwvROfnye3NhWQ7+KoosNFKKhX/ouuNuwqB9bNs61UwaxXcfnAtj4bVkMSXcXHYVPLg1
 TgkbtMBSXbQMgA92lmHzqPUuz7zvCuez5eo6iuc8bEKzIOuKLeH9Uxlzx2shvBf0kSTV
 pIJSEJ0AJtbuN/7kcm/t+WGyVsrHskbvu+gMEOMQHEwkTdYjum/s76p0aEKFbhcwDJ2w
 xFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730206717; x=1730811517;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yHxAvFj+ZMvpi1xXlJf1uTSVkbPDoJ5QlNNixnWD9mw=;
 b=M3rJhznlrlI5qtyhjE5gJgoeNXUZ+Hi2hU78zp2/ch84vHsjRj3gfZ03tm1UXQl+Mb
 HSobJ5ZwqpERa/zw0YBvS0jmsCqomhdPVgN+M1DjATBcuDkIwzss0sNxe0H7RCYJGwHu
 g9bkE+ViEUjJ6UN2dJgzB73Jq6gCvESrkW4hv+ctx+OCemG7YdTsQlZlfe3vHlE/j1rp
 xW0fI0ijPVsielW101MdiWWWjDMbqseyr5I3JqDwd4/7sfoQgTeTiF14f8mLCw1zBAAd
 a1U6OLPaBjAOGrLaJUNHvEAExlyDOD+4JMsJyel0sgp9BTFF+JG/d6Vp7mFY8Lzn9RjM
 L7cQ==
X-Gm-Message-State: AOJu0YwuLrnCTgn5+tnTqXMZuNvSomSVZcksrrksNo5+1uA3HhF69tAB
 9LY4T06XjgsIpcLHXZONuV446tB5nO5RW3uVnWv2o29iHh0nZ96yTWnS1/TjKNnrOUXzbq5h8bQ
 e
X-Google-Smtp-Source: AGHT+IFjsO+pM0KI20Syj9pEOfPRrueTscjZLR2+vHQoywWKdA2S8B02R7P6rLtvHHXjBDWgX31Wmw==
X-Received: by 2002:a05:6000:89:b0:37d:5296:4b2a with SMTP id
 ffacd0b85a97d-380612126famr8039725f8f.58.1730206716768; 
 Tue, 29 Oct 2024 05:58:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b71231sm12387355f8f.66.2024.10.29.05.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:58:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7BF725F860;
 Tue, 29 Oct 2024 12:58:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] accel: remove dead statement and useless assertion
In-Reply-To: <20241029102326.473133-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 29 Oct 2024 11:23:26 +0100")
References: <20241029102326.473133-1-pbonzini@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 29 Oct 2024 12:58:35 +0000
Message-ID: <87ttcv6p6s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> ops is assigned again just below, and the result of the assignment must
> be non-NULL.
>
> Originally, the check for NULL was meant to be a check for the existence
> of the ops class:
>
>     ops =3D ACCEL_OPS_CLASS(object_class_by_name(ops_name));
>     ...
>     g_assert(ops !=3D NULL);
>
> (where the ops assignment begot the one that I am removing); but this is
> meaningless now that oc is checked to be non-NULL before ops is assigned
> (commit 5141e9a23fc, "accel: abort if we fail to load the accelerator
> plugin", 2022-11-06).
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


Although we could further clean-up with:

modified   accel/accel-system.c
@@ -65,7 +65,7 @@ void accel_setup_post(MachineState *ms)
 void accel_system_init_ops_interfaces(AccelClass *ac)
 {
     const char *ac_name;
-    char *ops_name;
+    g_autofree char *ops_name =3D NULL;
     ObjectClass *oc;
     AccelOpsClass *ops;
=20
@@ -79,7 +79,6 @@ void accel_system_init_ops_interfaces(AccelClass *ac)
         error_report("fatal: could not load module for type '%s'", ops_nam=
e);
         exit(1);
     }
-    g_free(ops_name);
     ops =3D ACCEL_OPS_CLASS(oc);
     /*
      * all accelerators need to define ops, providing at least a mandatory


> ---
>  accel/accel-system.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index f6c947dd821..61d689935e1 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -73,19 +73,17 @@ void accel_system_init_ops_interfaces(AccelClass *ac)
>      g_assert(ac_name !=3D NULL);
>=20=20
>      ops_name =3D g_strdup_printf("%s" ACCEL_OPS_SUFFIX, ac_name);
> -    ops =3D ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));
>      oc =3D module_object_class_by_name(ops_name);
>      if (!oc) {
>          error_report("fatal: could not load module for type '%s'", ops_n=
ame);
>          exit(1);
>      }
>      g_free(ops_name);
> -    ops =3D ACCEL_OPS_CLASS(oc);
>      /*
>       * all accelerators need to define ops, providing at least a mandato=
ry
>       * non-NULL create_vcpu_thread operation.
>       */
> -    g_assert(ops !=3D NULL);
> +    ops =3D ACCEL_OPS_CLASS(oc);
>      if (ops->ops_init) {
>          ops->ops_init(ops);
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

