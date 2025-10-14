Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38568CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fPa-0003Ew-MK; Tue, 14 Oct 2025 09:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8fPZ-0003Ec-1K
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:49:57 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8fPV-00033X-CP
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:49:56 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71d60157747so53505227b3.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760449788; x=1761054588; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4gKfZ0YkzWzGz+PElf+gimFWSuP692BFzjyHAGS2TRQ=;
 b=elaWCmiU7U/p4Q6uA+iNnJn4MdggWWBi3lYVJ7E9t13H9EG9BSukLjrbGU5HkH9OMj
 m+3/M1cLI6C+jhLV5XrLG0z8uDva1HXDt5c5U1i5NSEnRabDqIQxrCFh+RUsIhRtwG+O
 TcMlndgo5e04AcjoSDz/llBhmuVj6rq0wwnYSWL/Av6PhNngXgK8XacuiHi0WSJmIrv7
 RPIXB3kpF/dI7O4GZUL+VOkh8gZMdbCk6Wj1ZLrQ0Yc3tudkb9rF66uFe/+dY4McZ4hU
 L5bxqK6b9b58YpJOuKniNUdR0jmbpX4qbjtWoIVOG8kydGz36OE+E0ErWlrt9e96pDQH
 E7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449788; x=1761054588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4gKfZ0YkzWzGz+PElf+gimFWSuP692BFzjyHAGS2TRQ=;
 b=F1CtPhJ8ySAv+97iPyQdFTbXFQZI+lgLIxLM5eZMKJunBa8lg0jttHysC8RbID/GzM
 3R+OdPRWi5JAM8Tk2pQb12J11Zmuq8rS2LivebF9aAbih4supcM+4mkzTECS+dce1wOr
 S7tsAcoXu8M8lyRNvqP/XBirjPRNJpNu9zPK5zIm3wgdKOHI8CQA5RQV1aPdzIDPvIFK
 epBdmB9PAtDqVDBT/I6NilRCNZFUqVWQHJT88deDyR44tzTQZHKyKo4vHBWy1f2dMZ5W
 Vg1xzrw5JfLGY0eWpj4keA1CXWSpJtU/eKHRtDOHikJZtEEh3s2pcdtdPpTK28U3G2lN
 uSNw==
X-Gm-Message-State: AOJu0YwCjhsKjvwZylRpUy0yzVgRIWlCwf+DilUbHMZxYcOJa4sYb+3K
 UUjTggvJEYgDhKzg/4vOxrJncbQi4Vod/LjIFTearcq0BFP/vxL47hPMQ6gFcU/RLgh/Vsu1bgD
 T+yhgqtvaknI8EEf+jvGlciI7W+8bVolGyWEC7XqWdw==
X-Gm-Gg: ASbGncuxJxSD5c/4gGCTzB6vUZS8PP5U8PCT+k9qm+GVEXL0NNnOh4EmL0Vowoni4E4
 O0i5Sl07GBtcTAhKXCXBq81p97U8plH9Cfw/xMAiwZt94lIjimdkNfQgqEVn9BaDb89JvWSOsUW
 8SijQj/biautHkjN8F0VkDDVf2iG1FsT37niuY6zHUPa2H14uBABzEHbs/dXBXUmWxXeuQXuMbZ
 PZjtR1Qp2o6SbHSAvzA3wozB8j2ZsuvoePgkRvSCQ==
X-Google-Smtp-Source: AGHT+IEYtvBpUfYeYmeJBf3YDISa0onBZbJlbHgShIStyh/hEUK2hiVP4rn3biWsDIgrYUG3BY+8ef6PXEPPglbJagI=
X-Received: by 2002:a05:690e:34e:b0:63c:f5a7:3e5 with SMTP id
 956f58d0204a3-63cf5a7091bmr7685169d50.65.1760449788416; Tue, 14 Oct 2025
 06:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
In-Reply-To: <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 14:49:36 +0100
X-Gm-Features: AS18NWBZsJI4OQh6lAsOExW6PCIqnr8Lzr-NguKfPtCpeFhocuja5Y8L6a-qPGE
Message-ID: <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Tue, 14 Oct 2025 at 14:41, Salil Mehta <salil.mehta@huawei.com> wrote:
> I thought you asked me to validate the fix by replacing below:
>
> https://lore.kernel.org/qemu-devel/20251001010127.3092631-22-salil.mehta@opnsrc.net/
>
>
> Yes, I'm using the recent RFC V6 vCPU Hotplug patches branch I've pushed to the
> community.
>
> https://lore.kernel.org/qemu-devel/20251001010127.3092631-1-salil.mehta@opnsrc.net/

That's the one with the "lazy realize" hack, right? I imagine
what's happening is that we realize the GIC, and the code in
this patch assumes that all the CPUs are already realized at
that point. When we try to get the register value for a
not-yet-realized CPU the kernel complains.

(I strongly agree with Igor's review remarks here
https://lore.kernel.org/qemu-devel/20251006160027.20067fe4@fedora/
that lazy realizing of CPU objects is a bad idea.)

thanks
-- PMM

