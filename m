Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C364FF43697
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDiLt-0003CE-3R; Fri, 17 Apr 2026 08:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDiLr-0003C3-6N
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:31:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDiLp-0003ep-Nc
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:31:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso4550175e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 05:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776429071; x=1777033871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wn9ue87KD3V8gYUDThXwu/F2PySHw8eTAPZateumWUA=;
 b=IOqbFpEZQZ3k3+hL06P1j6FBjRU60LGpJ3pRICzOc6HI/sdhKhe0hTR3A5iUBDqlrk
 EOkzc3wn/o80nE+GlY6wbav2wTguPLiLbJlo8Q89OROqfNWky2h6MG8gJQlKbm2Pm4Ei
 Ab6EXTKUzWSyHJHW5xlBKGcjj0Wu8AJ/ncOvcVK13oL8TdD/g/U2cz+kC/nbEDJ39N0E
 fB+h9P6CGieKH+QRvbbgTS24wQVtcJaKMjt3yZ5X9wbf5AenYjtdNEEfbj6/MAggA0Ya
 hNtwHHQ5ucE2vVFLEMSI+CjIvmNSSGIK4zcpl6ueYpytoAIGW81N+F8ahAirhBRdTgcq
 JYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776429071; x=1777033871;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wn9ue87KD3V8gYUDThXwu/F2PySHw8eTAPZateumWUA=;
 b=rrOjaAZDfefgVEz/rRbsvAOh4AfUHUQpxpvIOOPaLYUAqNTNH1+xaJQTeiJuEBkF+/
 NjrTMAvKtR1oURd60vwm5Y8QfRvLIzPwcbZPyfrl8czl//smG9+DCqtBRiXt8Bi53HF+
 nRQQpLOYqvE0RTbOtu1EavcFdwRRRv8U4FHCLlwvo6C7IOuLMEQOo8AcBFllymeU7dpn
 1EtfsXviQCEPTRdJuluWfk5A0DUN9vq2hsnTpbFz3+oD05LXrDEoNgU+x4HrnmQz2hJF
 ez1C2QfUd+2w6lJ5awlZxctC/H/FFdMVPC6lLZMK8ZTLiK/WX9Yrc9cfPlYwSZUiLBkj
 e5Kw==
X-Gm-Message-State: AOJu0Yx+tjlSJbMmIwuULwLAUpPxLwTN9CvHw6X7d3a5EAQXmFUzq2VH
 h/PBsoABCySrE3Z/hnz0QXFTni1voFPLVA91cjpafRkVEKkGG2J4FkoeKDnXqu1fsAA=
X-Gm-Gg: AeBDietnDrWjGv0CoJAWoAITQnaUzT8vbLU+TCnTPO0hGfi40tuwJs/xqADGVdKNqyJ
 j5BpW+kQjICciPlN6F9i6KeSpMB4SWcd+9OoCpL3FJX1p/0gSvC4Q2BOvaxeTzvy0g5UU2cYC5s
 mHtH8IP2mtM0frQqY/kqkwpYP6qibp3zhuY5Rz+sR/6EgpsiW6Y69OtmhP91+uJi9FaIp5hPJv3
 xIdpZ/qqBCFRvzdEY1tg/7I+n2uCoB9bcRvOV+zALCankf45YyU/1BosiuZ/hvGihNblZaI4xsQ
 pdksxXo8RNNv4M25uuZBKHx/cn5RMGmuZpItZNSN0OD6n4m5ubrXSFp3bBTeE4vqdYxNBKI5fkW
 o/UPn6n+lJJlRcJtr8yt8ARuiDptmpF/OcCX0qSMUcCOVwxm65sYxWdeYcygvh8m40PZDNzCXkB
 ABh1KSD7eRt3SVX7WkKYv7oDAfoHPAdQ==
X-Received: by 2002:a05:600c:a416:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-488fb73b31dmr30494885e9.6.1776429071525; 
 Fri, 17 Apr 2026 05:31:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1cfbf2sm41057615e9.15.2026.04.17.05.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:31:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 853145F94F;
 Fri, 17 Apr 2026 13:31:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 2/7] MAINTAINERS: Step up to maintain core machine code
In-Reply-To: <20260417110550.70068-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 17 Apr 2026 13:05:44
 +0200")
References: <20260417110550.70068-1-philmd@linaro.org>
 <20260417110550.70068-3-philmd@linaro.org>
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Fri, 17 Apr 2026 13:31:09 +0100
Message-ID: <871pgdsr8y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> The 'Machine core' section is orphan. Being acquainted
> with the code, step up to maintain it.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

