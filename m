Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AA0C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFzz-0001ua-Hv; Mon, 18 Mar 2024 12:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmFzy-0001uO-MG
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:38:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmFzx-0000KX-7s
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:38:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41409dc5becso13541435e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710779883; x=1711384683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbCSFnc15R3uSLShd1DuQ/jOd40bEiAJUTjGPt95Cvk=;
 b=WcyhcE7eNR5qNZS4X3ODJWkCKItvfrZ7lIhw/AYKYG9tzSpdhMWtENsp5mDpyZoAV3
 P/TRDm9JEaqnFkXZ3WfKsVJjLkgxJH3WMIqy4uw69m0KWmCWI3avh60zU5ZvnAKm0w1Y
 r8h12b7agBjO3KvhHQTYi0SAIa7rUYT+aL/McmgdArtF1b9NVmQmVHGru4ozIyQ4VMIK
 yzFLAnkhrlgiNMXnt+GHU271H7e6HH9Uv5GOEmnwUyKd7DIE4VKGWWHv2GKW72qbeTzn
 8kY/QnH8g4xzhRxpT1zPvmNmcMI8SbERLI8S8m+AVjjDAATt5q4zSExllwY3k5hWt9Jr
 6jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710779883; x=1711384683;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XbCSFnc15R3uSLShd1DuQ/jOd40bEiAJUTjGPt95Cvk=;
 b=ZbIP66sED4ki5XTR8uFW6uPDgNzSN95yxyZgZvH1FujvPNXtSoiYS6iRdinbJb3f8A
 CE+qCAvbpICxkbP+LsM/ELh0/Y4ILsAKcmxOHgFxqJOCXePBkBEoEQxk4Q410oe8SA3I
 jVw55g4YY6pEdZJ0gVp+W6wi1IfMrX9tc1C6m+NionB5wKkestHfsSkFUWhFJDndtHQG
 HmBVvMJAsIil9L4UcPFs2UUkyhBaQaoPra3XQyMeweI+fwbuumjkl2iib3sdhiMHCBDt
 pZNZTIktPmCw6/qYs8ii0rj8+3wTNTLYiimWQ0eUaVi6d7nSEYmqiVjk5HuUUanH3PB5
 N+cg==
X-Gm-Message-State: AOJu0Yzt6bD1vAuu8oyL0W0h4Q9mxb+Oe1sW8b9DgmCv8lgxCX3d+bVz
 eSmH5Bw1dWtdcosjGsbTpf5YqarREHgbfv5xYH8F2uotIiQYnUvivTrBdjGlLPOXtwv3LK94SG+
 d
X-Google-Smtp-Source: AGHT+IERCgbzBR0t75E6OgPNQK7VIwrDVe57DHr6WIOV1wq87RZM2KbOyLpq8o8Ci9xcY23r1km4kQ==
X-Received: by 2002:a05:600c:4f0e:b0:414:1363:53a4 with SMTP id
 l14-20020a05600c4f0e00b00414136353a4mr1597579wmq.15.1710779883455; 
 Mon, 18 Mar 2024 09:38:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c469000b00413eb5aa694sm15405026wmo.38.2024.03.18.09.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:38:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5BC565F796;
 Mon, 18 Mar 2024 16:38:02 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 12/22] plugins: Remove plugin helpers
In-Reply-To: <20240316015720.3661236-13-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 15 Mar 2024 15:57:10 -1000")
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-13-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Mon, 18 Mar 2024 16:38:02 +0000
Message-ID: <87wmpz5wd1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> These placeholder helpers are no longer required.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

