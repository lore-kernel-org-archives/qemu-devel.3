Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4EACCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8crf-0005P7-Lr; Tue, 14 Oct 2025 07:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8crb-0005Ok-C6
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:06:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8crV-0006r9-91
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:06:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e504975dbso30767865e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760439995; x=1761044795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8c6BLF2lqTy78AGujoGRAinoSiuCnNJ4qjHk+UxlYwI=;
 b=XBpYMgTw5nCqmiHOPPajFTV/D4/e+5awe+sHVDl8nsN/wLlngWegV8aS4ie4BQm/Ps
 WIzY0LqAjxRNoYTloaqouwiDHKRf1vZL/uiMbC6RKPCHvCxtun9XSACY6+BIeO6CT4xH
 M4q9vW2IGbCYGELm5VAcBp94Gq/KNhMmdCZmtm+Godeu2kx6VVFPZPduH+GtY2XwpwxZ
 ggk4e+PUDAYXFnzqUb8gabFARmfXdqT8DXqP5nwMN9NvcFt3Swd+frDachIAUNRCL1R9
 /FuuksDsKHyneZUErzXXXQOorth4Arxiv9bCQ7vYr8JS/uwA3U38+0PPlVnamEq7KMBa
 bEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760439995; x=1761044795;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8c6BLF2lqTy78AGujoGRAinoSiuCnNJ4qjHk+UxlYwI=;
 b=DSdwxy4ifS/PdizJzRCAzQIWSLc80bofOha3VGm5KKEi9f5imbMFRMy0CH8Rx0UJt4
 eJbxXiGgBmpxSXuKWdwooGZS0Uj23qteOdM22HXGahLauaXaThU2hFf8MsWCnDm9vdwA
 jdO/u3OjaHup1kD8uZtVJewAJCNtncULdwFVVxD0RQiLgQX+IMduREwtu73PztmKGBNY
 JOQ5PNwpY+anMXNIN68dBQ8k/HTl44QwO44tn6VcLbu/C5U5b2aFb+fKumAQUXQCCpj4
 QsNy44EhR0WY1kSJERpyx8ZFYXbTCiV1RRTOBpJENpHt/MZddDDo097YLaaqH/DzAeQb
 rLKA==
X-Gm-Message-State: AOJu0YxMgHgO8B+0MDfUgBXkvidUZV29TRa2WK9rmlxPz8Az63+VgbTT
 xVxREURar+lAPeFRaxFRFoh0tBNVumunZNZA+vLVlF/V6GjdBLKeg0Z+g+Z6RFJkouk=
X-Gm-Gg: ASbGnctSxvZntmVe0/PMVYOczfmIrLYT81ZbIMEmvDOmM7xO74bGUOI2LrVPlsLMlSj
 pKJZiQyBRj5YE3Xtn3jZfYzQYZbLgU3OQNI1CH6HrT+gVU5ig5VnSTEgdbjyvbEQLKFBdh0Keaf
 UEnbmyiR4KzZsmYjXBJEX5tUrpb6IArS+BcyVn5BWYijA98g1S7ep8l9yKnzciEpm6oxjoBayzT
 c7+Wf1qCUfJdGLhkVG0MjJqDem7vpdmiOadMXm5UZvg7UPKuJHgHKP4XSD4YHwqGk4P5AFrtG3z
 GaKnE4f6mTFqLeyRLDey+clw8Zt7GX37L7UxXgRz9Md8VlswfG2D8GTG2/lFj12RxFe3QtaYnnI
 ZAfX5BWLl7t1982m9TeTuD+mlicfhU/IY9bQnh0QpFpKxRhOJ94QG69O3
X-Google-Smtp-Source: AGHT+IEUtNfgccMI2ynS7uqJ1ZPPWJsQdth4aUaFqV+BJTui3VSvMWJjv5cUM9J04yzk5miWWtwaJA==
X-Received: by 2002:a05:600c:1f84:b0:46e:4cd3:7d54 with SMTP id
 5b1f17b1804b1-46fa9aef45fmr170498105e9.18.1760439994704; 
 Tue, 14 Oct 2025 04:06:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489af92sm253863455e9.17.2025.10.14.04.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:06:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 70E975F812;
 Tue, 14 Oct 2025 12:06:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH v7 02/25] plugins: add API for registering discontinuity
 callbacks
In-Reply-To: <59887dbdf3cdaeb3906c3b9a26f8803b2d6e6bcf.1759744337.git.neither@nut.email>
 (Julian Ganz's message of "Mon, 6 Oct 2025 11:56:57 +0200")
References: <cover.1759744337.git.neither@nut.email>
 <59887dbdf3cdaeb3906c3b9a26f8803b2d6e6bcf.1759744337.git.neither@nut.email>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 14 Oct 2025 12:06:33 +0100
Message-ID: <87qzv5lp3a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Julian Ganz <neither@nut.email> writes:

> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. In addition to
> those events, we recently defined discontinuity events, which include
> traps.
>
> This change introduces a function to register callbacks for these
> events. We define one distinct plugin event type for each type of
> discontinuity, granting fine control to plugins in term of which events
> they receive.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

