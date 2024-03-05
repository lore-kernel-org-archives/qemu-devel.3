Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE50C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV7L-0005vL-Sj; Tue, 05 Mar 2024 08:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhV6p-0005Dl-5M
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:45:35 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhV6n-0004UF-BA
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:45:30 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-564372fb762so7297977a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646325; x=1710251125; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3+e0CIOXUcduazQNLCzqDw7567dD+QGnGwspIiuVuIk=;
 b=LxKV0OKy7x7HOmVLlvHjN2OeyogaFNkcHzFIe8meZjheSpmRxL9f++llmGEKjC6PpH
 OSTc/1mP2ng34MTpLq4Ryvv4OV0XMjxpq1zWXGOqiKyIO0RykHWDVGJNxec3+gjAO/0I
 1nqrep72QnIBCEDTKIQxIdp5QHRxsLz/OvLuO+8B/eIoJ/fLvsFrPleTuTTu3trcWRyA
 MICkSNXYB3RMWVab1pf4krOVa7OudU4C6x4mPguJBhfUVN6yMxJGGcQLXK3U1jWjWAcq
 x5OOhluYtEP1RmqlT5X/2ye+E/mOc35OAYnJfvvbZ5aaIdFV1V0RMb01t0ooTGx4GRE1
 39zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646325; x=1710251125;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+e0CIOXUcduazQNLCzqDw7567dD+QGnGwspIiuVuIk=;
 b=Re+XDfYJLo30WF30BUUxAwIzCfgfmc8skpHuOxXxBLvNEFYAsqHEhmpJSvsCa0Bt9A
 XnR8XN2LvPZGbhUQQY/+s5OPcOaDiwD5yvxZVRAusNa4ZHz/MPTDA/osZv2RbOtxX6Mw
 7W77b6cU+u6H1mY1XJq+HlACpCkcGLuadlMQCvL5baswv2G8sczGCgNmJUgZL0whFZwe
 vhL1Noqdkqh8KHPxo1MpsdrLazveYfrV7F1nSfOdMxbFNi9mQd2sRJMi/Bw7pSEvROEt
 Hfv4c8WwfsYk9u4+aL39G/JOJcLRmwohxuXRxZa2h7l1hD9i+uM9qmUqKm9+9RFp+5OX
 0QhA==
X-Gm-Message-State: AOJu0YxLzUJACoMFWWor1XL5ppHBiOHrxMm0VsLlEAULAGHu+cS47b7G
 jrBK+BPlOpjWUQZVl6kgBw0hzbP6gQBwzbOwQuq/t/4c9RF9eGTP5EE4TQB8dsevPLhjQPbsI8c
 mab1Ni0lnheB1gTJPQlKJC9WkE2om5xx+BynvrA==
X-Google-Smtp-Source: AGHT+IFkynWTckaNCxaZhF6h3xJFlYL1fph/G3yQbUeP0pkxr/oSKruI/A1c5+vMOpJUs00pXkxCMITLr483Ut8Voe0=
X-Received: by 2002:a05:6402:26c5:b0:564:3392:e9db with SMTP id
 x5-20020a05640226c500b005643392e9dbmr10542200edd.33.1709646324844; Tue, 05
 Mar 2024 05:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20240304063236.213955-1-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:45:14 +0000
Message-ID: <CAFEAcA-u9E5_rmYti5NMQVZvh4qh_tW140gqPESQ9d+w_VYdjg@mail.gmail.com>
Subject: Re: [PULL 00/18] QAPI patches patches for 2024-03-04
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 4 Mar 2024 at 06:32, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:
>
>   Merge tag 'pull-request-2024-03-01' of https://gitlab.com/thuth/qemu into staging (2024-03-01 10:14:32 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-03-04
>
> for you to fetch changes up to 018d5fb1f91c7f316b4b8501a78e7219bb9fb614:
>
>   migration: simplify exec migration functions (2024-03-04 07:12:40 +0100)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2024-03-04
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

