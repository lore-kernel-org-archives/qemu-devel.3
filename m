Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F71C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 15:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChoI-0006sw-UW; Thu, 30 May 2024 11:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sChoH-0006r7-0T
 for qemu-devel@nongnu.org; Thu, 30 May 2024 11:35:21 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sChoF-0001zq-B4
 for qemu-devel@nongnu.org; Thu, 30 May 2024 11:35:20 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57a1059dc4fso1060147a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717083317; x=1717688117; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kffCTfVIgcPiSuaIdP7/qK5AEnvqYRNQ5sLQm7P7bT0=;
 b=P7UAX0k8DvtSnSVyG3YXAcf5pPciCSUXH3mg3OAUShohPXgbGIq3HUNnfKUWdvLxim
 if944ze5QyVUImAOxOC5EzjpZrlB4aguEeH9ZCQRCJmHlCrBl9GeBnUmDJPWSlUeR96z
 XSBSJlAP1ulx904TeeZkLqj4QaJpT0/AZTiG4nmauHmhqb2dUxw2TJXNFpFgz+er8vnT
 gwRhHrqzrh3yMXMBnc69oRLuQPjKxVC7AZzY5uyiajjnXCYq+1+mDxeEEVe8XHdUUeXL
 jG6OwHJcFMQcQnbT3dRpL6ZoxYR23BsnL4VR6+szcaquD2NditgkOZbM124AAIgya/ij
 mZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717083317; x=1717688117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kffCTfVIgcPiSuaIdP7/qK5AEnvqYRNQ5sLQm7P7bT0=;
 b=PLG+hX8J+kQ1EKrciVXDmmqK0Od8/W3ULVhMOWjejCzdxEYEiu74d+1jLfTWomE+ee
 m/Rclp7pdK+vdmHF+cmGOcIjzcI6IZWjPo17aGJ+DyxGlmWaT5fyTIBwnXHYP0wlnLvv
 I5BSZmKN9+x8scpowfabO9ExveQN8JZaJDmsHE6/GCFdfNeUjKGe2Ar8UZFl7G1BQSql
 MGGDOMok0PuiwkSXwu2gVUlWvZ+pafSVnNbPZ42GAX5rDWK9F7EhybZ7lrt7adZZ+5Cb
 oXsK4tJwboS0IoT+NFviT7ARXbKkSFaIJHAa4KUxTLuDus5+ZFvozNEuxTlFyj+QA88D
 1/Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5iETJkre3UVE5NBbNapjxlFinAxYqOmFR1HXOCsFdHMhPGPZpUoNeRKS0eNxGn08wZdFgGQrRkUImGFaLmt7c1oexWGM=
X-Gm-Message-State: AOJu0YwUZVHL+dQIzh11GNmWQXZkZkAIAZHhvEdBOx7geCi6K7M5zw85
 XXxbDb2PK5NWBoph8LfGoWCzmQnWrpmbTlu0vzADgchwutj06cslIt+/5XERJDSyI0yp0SP6nZL
 p3pKlfRKWTodNFjGM4jnGqy6C1aPKqqEiC5HTMw==
X-Google-Smtp-Source: AGHT+IEh5+tuqY+EJbGGqXbb2dRfkVFLmNUC4HfeJG9MYsl/f8PIxaiWQD/iz6ameEuhm67qaa6udj0dvrcoxfvGRTw=
X-Received: by 2002:a50:9344:0:b0:578:56e1:7ba3 with SMTP id
 4fb4d7f45d1cf-57a1791a129mr1474266a12.38.1717083316581; Thu, 30 May 2024
 08:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240430140035.3889879-1-peter.maydell@linaro.org>
 <20240430140035.3889879-2-peter.maydell@linaro.org>
 <87ttji3h69.fsf@draig.linaro.org>
In-Reply-To: <87ttji3h69.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 16:35:05 +0100
Message-ID: <CAFEAcA_DiLYdH_x88KtjjOH=7pVJdERe2-X+tDpgvN5qbj-_ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] accel/tcg: Make TCGCPUOps::cpu_exec_halt return bool
 for whether to halt
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 30 Apr 2024 at 18:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> The x86 version is essentially being called for side effects. Do we want
> to document this usage in the method?

I plan to take these two patches into target-arm.next, with
a slightly beefed up doc comment:

    /**
     * @cpu_exec_halt: Callback for handling halt in cpu_exec.
     *
     * The target CPU should do any special processing here that it needs
     * to do when the CPU is in the halted state.
     *
     * Return true to indicate that the CPU should now leave halt, false
     * if it should remain in the halted state.
     *
     * If this method is not provided, the default is to do nothing, and
     * to leave halt if cpu_has_work() returns true.
     */

which hopefully makes it a little clearer to the reader
that "do stuff you need to do when in halt" is the
primary purpose of the method.

I'll do the follow-on tidyup rth suggests once these
have made it into git.

thanks
-- PMM

