Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F36C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 18:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s82Ef-0006WR-77; Fri, 17 May 2024 14:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s82Ec-0006Se-RW
 for qemu-devel@nongnu.org; Fri, 17 May 2024 14:23:14 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s82Ea-0001gj-37
 for qemu-devel@nongnu.org; Fri, 17 May 2024 14:23:14 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a59c5c9c6aeso492701266b.2
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715970189; x=1716574989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Emv5VvklMuq9eXXurzeTVDcgnuYbvDUpBwwn4e4TQks=;
 b=bgmuO+VXDTe4Bv7xJQLXxQmK9C4kKnSAV/cguZCKmeEyILs5eZ6tws2qsQgPpe8PFC
 OSsjSh2aIfscbc6ed4pbIuqz3QqkIkjkKlbvwdSXwwP0T/N38yLzxqdnGHisMkZQUAsA
 8NywXDXyCISJJjPwf3r7Fx6RdN+tDskMECY7qYVaQ7r0tBKYBkm3n2B0RpMpSxfr9jNb
 mCH5eJNEL+S9nsdXq7jJCT+Pt3KWS6Kak6kRT3C/UyMmySKqjzk7wkeM5tUGu+/ba/o1
 xQoR8C1xL+dlBoARdsuJk1dgwHI6dz7zM851CJgmkXHiq9nhU046HvQ+Zt/bsYXMo5pq
 D96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715970189; x=1716574989;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Emv5VvklMuq9eXXurzeTVDcgnuYbvDUpBwwn4e4TQks=;
 b=LldCqSeR2VyymNHHApVr4EnMQMpQGYrKfb7LW+u7NrapB48ttJwTv14XG4yWDVlfGB
 T6c1WvHO67DlVVIimDokeq4k1POvI6OXV+CGj+HE9qs8aDKeVs9Yx8KBhB6eSaCn0Miv
 NVkqnaDL6Pzy7Z0LxYd3YsOdodL+ws/7tIi9wRBOfe4PjXyaiLchbh3gqom/+4URgI66
 19GUWrJLCnbKW73F/RG4YZvjCh7njTeqaI+is0lZyHlufCKe3nVCJR163q92vB1gI0cc
 NhbzNSCZtMkNzmClWkVcqOoYy2k5aRYpJsDznQHrOjahaoIBTG/MdislEqKVbVuo+3HZ
 fH/Q==
X-Gm-Message-State: AOJu0YxpJCoKle40wi/PRZE4uzi14HizmNPbmRxzfOH5a/Du6r3NlNbV
 IGXRDE2KWTQTUfEfrkj92B8NSgBC7ZCgvPj4clFmJWl/LwwSRrychOYbHEn9djc=
X-Google-Smtp-Source: AGHT+IHq4FXZNCKfBVc79FVfyT/i1FE0ropqQt60kuZ6WuFyZmW63BW1/5586P8NPqDjJjTyzoDw4w==
X-Received: by 2002:a17:906:1d05:b0:a59:c9b1:cb68 with SMTP id
 a640c23a62f3a-a5a2d55a759mr1624513566b.7.1715970189147; 
 Fri, 17 May 2024 11:23:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781e97bsm1128056666b.32.2024.05.17.11.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 11:23:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B4D95F88D;
 Fri, 17 May 2024 19:23:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH v2 2/3] docs: define policy limiting the inclusion of
 generated files
In-Reply-To: <20240516162230.937047-3-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 16 May 2024 17:22:29
 +0100")
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516162230.937047-3-berrange@redhat.com>
Date: Fri, 17 May 2024 19:23:08 +0100
Message-ID: <87v83cpab7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

<snip>
> +
> +IOW, using coccinelle to convert code from one pattern to another patter=
n, or
> +fixing docs typos with a spell checker, or transforming code using sed /=
 awk /
> +etc, are not considered to be acts of code generation. Where an automated
> +manipulation is performed on code, however, this should be declared in t=
he
> +commit message.

Lets avoid IRC speak in documents (s/IOW/In other words/), otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +
> +At times contributors may use or create scripts/tools to generate an ini=
tial
> +boilerplate code template which is then filled in to produce the final p=
atch.
> +The output of such a tool would still be considered the "preferred forma=
t",
> +since it is intended to be a foundation for further human authored chang=
es.
> +Such tools are acceptable to use, provided they follow a deterministic p=
rocess
> +and there is clearly defined copyright and licensing for their output.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

