Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E029ED17122
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 18:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2xRf-0004k8-F9; Mon, 21 Oct 2024 14:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2xRd-0004js-Kk
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:47:57 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2xRb-0004LH-4j
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:47:56 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f84907caso5450487e87.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729536473; x=1730141273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cpJn+/vfNLcaEXz6SSP+jpCrdyuOiOvQ+k2RtOgLo4=;
 b=vskLqIFiLOHeGcXjSmids0iJAvCmIpmJ800DOM26zq4uSW1Mj8RQXxWKSqWl6W96Mw
 TlYknex8Lpgl6qVqjQwYnkcMSCniwXOC8GxZsN/PLnzMenzgHk0a/jZSJcXlCnk4zjQb
 NLa3oqdfis48JMo24qnKe13a/US4yYbQoWszSeqwXXgIXL/dBp6H8z43Pdi4L/YHJUAw
 NinWsh7ZOiLlteFX285lmu2pvcdBozA9ICzb8ea4KarHCcHdrXo0AB/MZY01fViM/ROi
 hNUfiSovkbGDSK0AkiK0uOIIy62NuQs+SqBRV8TDqr9Yw1wy2FPt8//NMB05PNcT4az8
 9fQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729536473; x=1730141273;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9cpJn+/vfNLcaEXz6SSP+jpCrdyuOiOvQ+k2RtOgLo4=;
 b=rT+GLNum2R/Z/YCrnYro7ROA8KGgO+wyVioKhgCzCeMOry0O2h5ioMTi/Nv12El/Fl
 6W2vzdwIjIwHPHSKd2MYOYe8Ne7qnvXxWSGFkuCc4K+66m+xZYMIkDf5jCTZPDFrmVYV
 7BFnV8NfteYtLQlxQ2pmkxNQymNrb4mLyGwXcsqWwQeKkokxNo+1HhLLE2GFMvT0prZK
 eWXMeQ3qaII9BzhKR9sHqTEWlAydkTUQLsSzF70hzojW+ahAyTYthFxEytNwWOXVdGma
 IOUgyU6LXIjHHZIen8Z91yJJJ563F80aDmragjQ8Vv42GCJAvr5+zwAzShRnI5MIblEj
 YshA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3fm1Zc981UpxNlkWvsVQ3TzKtfrjI6Acj6rL6AxcABx6EZYPYoU/driQEqS/bnYsIQ1v96QRkd601@nongnu.org
X-Gm-Message-State: AOJu0Yxp/sxXw4OmUiW79om57tOVTbAcZoTFw8EdTOeUHd/F6nMy7JZr
 Y1nNxzSGJbEpNoo2xtNh9u3dgAtqomA3vz9qov2TfDfbCMMCsoEga+hhmZsDVMA=
X-Google-Smtp-Source: AGHT+IH7BfEo+lY2rVIuCSDimKlzLc70wfWamMa+F+P+NEIa9D6PkXIaTAFsJWmtOei3oHUhM01ZrA==
X-Received: by 2002:a05:6512:3e0b:b0:539:eb44:7ec3 with SMTP id
 2adb3069b0e04-53a1522d8bfmr6355165e87.31.1729536472982; 
 Mon, 21 Oct 2024 11:47:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c725dfsm2269928a12.81.2024.10.21.11.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 11:47:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F368C5F8B9;
 Mon, 21 Oct 2024 19:47:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Julian Ganz <neither@nut.email>,  qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
In-Reply-To: <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org> (Pierrick
 Bouvier's message of "Mon, 21 Oct 2024 11:00:20 -0700")
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 21 Oct 2024 19:47:49 +0100
Message-ID: <878quhnvhm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Hi Julian,
>
> On 10/19/24 09:39, Julian Ganz wrote:
>> Some analysis greatly benefits, or depends on, information about
>> interrupts. For example, we may need to handle the execution of a new
>> translation block differently if it is not the result of normal program
>> flow but of an interrupt.
>> Even with the existing interfaces, it is more or less possible to
>> discern these situations, e.g. as done by the cflow plugin. However,
>> this process poses a considerable overhead to the core analysis one may
>> intend to perform.
>>
>
> I agree it would be useful. Beyond the scope of this series, it would
> be nice if we could add a control flow related API instead of asking
> to plugins to do it themselves.

I think there is a balance to be had here. We don't want to
inadvertently expose QEMU internals to the plugin API. With this series
at least we rely on stuff the front-end knows which can at least be
tweaked relatively easily.

> If we would provide something like this, is there still a value to add
> an API to detect interrupt/exceptions/traps events?
>
> Note: It's not a critic against what you sent, just an open question
> on *why* it's useful to access this QEMU implementation related
> information vs something more generic.
<snip>

It would be good to have the opinion of the front-end maintainers if
this is too burdensome or easy enough to manage.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

