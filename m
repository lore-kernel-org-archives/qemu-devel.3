Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29FAC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we8t7-0004sI-2p; Mon, 29 Jun 2026 06:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1we8sz-0004rf-Pi
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 06:06:43 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1we8sy-00008n-7u
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 06:06:41 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664ed6f5a48so124160d50.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782727599; cv=none;
 d=google.com; s=arc-20260327;
 b=Xan2VeheagfL6V9Sl/5fWnlUllEfGVnm8ALs7GulChUuAZrwUix5KPqCFSQvXlLyWe
 NIkejxp9GqC1Ycf3yAummeO0Et7Mxz/6+yznJduwA8nrefo6JsfAJn7H8HnC7NRVdocK
 A6E4/0lKzIgcM968fne0CUbA2jxczf5DsB5ghhO1ythg1mfQAmD1JFcglp9f4AmWpVbe
 a31FJckk/JSK//RRETEgcwK9cv/H/ZlsqmOrZGXOzbEQeeEZa7//Wdf0hgut8zK2WE3Z
 MtQqEddpYMn9uyZK3tn3TnwKroxrQAD/kIi1BR/PCTiTskohBGh1kN/1CAZ++iD9RW5h
 3EPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7ckXbkvmiBBZTMFFMg8C4vhbQU/5Aq5UiYOucG1zO3w=;
 fh=UuJz1IikU6hzvOR0WthtfU5HVZXWWnfFnZvwpv+hCuQ=;
 b=mmSJsiS42KFTI7VH+szGaBxDtzvhNuGKr5F7BCmW7D8ES489oBq30rF7fRUrza5lve
 d7lgCoBRQx1qvqCv7BLdjSZfCdzX8aKJTShCTKpYD5chMcUOqb4AfRKgB2QemPBMgngJ
 N4+KaF4KXVEhj2ZdZPUTTHfQ/PtDmcTUI73fSscSKFl6hi1gN9YkGweqtlLfjetR2ywU
 NP/+x9d523R9fEcQ2P73clNQYGpeZ25gZvwMd5ehOJyqEfFQoQ26lvl3WjH//vPuiVqz
 ZyjGbnHS4AwZKs68AFqoWwnpkpREpcOlWdXkJl4uYWDeEgOgi5maZ+jbDjLHvBc5Z8/i
 Bnrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782727599; x=1783332399; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ckXbkvmiBBZTMFFMg8C4vhbQU/5Aq5UiYOucG1zO3w=;
 b=fYyBauLgnFEq1MvTchdPngvLfG9GfyFnPOnt57iO5eWKP3CBdFXFfLlKcIpVo94iCP
 A56tnux8aYnh+G2CQ0NgfNrMSV4XQ0ft3RltatgVRUmvXahYgd8aG37vqW6z8RpdY1c2
 0WPo4GgNpvVojZJfeSJi104MwJR3+mFq32Itf9UXCuSh7a0+iXHr+2/za+hKulfcV75k
 4mXmaUNUgVZhqP0nSUjsZaK2UO/rTXUVKsf1jTzMFNV+h4gLr5ohpkKvGhEs+dzlgN6H
 1jBhuU7hMAaFE/TonC9hJZ3JhKQbEGB56m2iVSivmurttbjAf5ZUaE8jE1MjJJUlvY/1
 zDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782727599; x=1783332399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ckXbkvmiBBZTMFFMg8C4vhbQU/5Aq5UiYOucG1zO3w=;
 b=oEHyyIxhMWDhlS+twDUNq0iU7q1JSi6C5U6lWl7/EFF8iQb6pRQlIyQg9zTTbKGsDZ
 nz768UEhMsHA0QIdi6t8DGGReAwWPowzrFVk+jvCSIP6/dp2OB5uFJIQJxXoZzQEb0XU
 dlNklIrzmMmMDqomqJJOx8BV5eNyXdqRksjlO1gaHE0k/EZfRAzEvgS7ItHRQpcahbGS
 MQe4cVYFJQu7p78Na3ps/wZqSOiw16j514LDPABJnn8CEC38PGeKa1WzfrdbBE99yLsB
 uzVlo0iymaTLgMaZeCIuVrL2nytjpnT0PKvaJA5uzf4E71Mo0LI18wCE/NsCVRYtD0FN
 AWwg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrrcfi3lM2dmJlDj2PjX6DpLK1Ha+dAKOY7Y36DVQYjs5miEQm7+HPjR8wM/mhkkuYlVtDRgLAi6mvc@nongnu.org
X-Gm-Message-State: AOJu0Yyf9RbPYmnOEAPRWpbdClYuWLlblopm6j0agyXjLjT2+4taOQeN
 7hZ9gmRhbPUnBLA/6lDO0Y1NBuh+Lx2Zd4PbVkiOMglVjyj9XRhyERD6M7ZrzrNeuy/boQ/Jspd
 VJyGfXZ/tWD2XNgVs+81+dtosdKpKtCQ+8NRiRPFFWA==
X-Gm-Gg: AfdE7ckKVwUHOOVVDXcIaKTpHNSIWImNEMS/kMK797+UYuUfGRWnGG+3Zgz8fSED1VZ
 EwV840FsqK3FrWi/zENB/CbRpleloUJavn75YHErzGJZsVZaX+IDiFC7YV1QlGpNudKlK32uec7
 G8lcuNbs9dkbfNdMA45ffW1dgN1/Bgjt36AkmllBxdPuvukC80d8MdD/1jjm0xTan0l8g8vukFj
 6iiq3YeNsjJd1pOtCwOov0qs5gtyQGjKU0aIara8Y1bkuAA6LXG8PUG/erB3+ccXFHJmWHYPLRT
 4hRHezpnFB+DMKrjnmUCuXXYvPdXu6EO6nH8aez5j0/ymGTlm5fsu/c+6TCMEJsx1sY=
X-Received: by 2002:a05:690e:bc6:b0:664:be26:3cf7 with SMTP id
 956f58d0204a3-664be263f59mr5955863d50.51.1782727598749; Mon, 29 Jun 2026
 03:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260623104003.36590-1-skolothumtho@nvidia.com>
In-Reply-To: <20260623104003.36590-1-skolothumtho@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 11:06:26 +0100
X-Gm-Features: AVVi8CcwcsdFQpofYenKAbnHdmEQTTxr8mx9HYp6rHaA7K8jEzIGGIwPAOvwC-E
Message-ID: <CAFEAcA_j2CinOuRpitS4aWe07XNJ7=JRBLAh+mvdqcBWd-iLuA@mail.gmail.com>
Subject: Re: [PATCH] docs/system/arm/virt: Document accelerated SMMUv3 and
 Tegra241 CMDQV
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 23 Jun 2026 at 11:41, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> Add subsections for accel=on (nested Stage-1/Stage-2 translation) and
> cmdqv (Tegra241 CMDQV hardware command queues) under "User-creatable
> SMMUv3 devices".
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

