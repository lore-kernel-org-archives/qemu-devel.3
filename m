Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC83FC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 10:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRTUb-0003yb-7X; Tue, 17 Jun 2025 06:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRTUY-0003yD-Ph
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:24:34 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRTUW-0004fn-GM
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 06:24:34 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so5354829f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750155868; x=1750760668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/spRQSZI5L9YMglQoCWWPNK0GpPtbCxeZsdzRk0K8eo=;
 b=xwK37eY3mlK9RXGgZl/JI2dvuc0Z0gPJefTVk8Alw6Dzq1hMsVkBrPCu+yrXMWM0Ln
 Xo2lR+HdDJ2taSQtJqKGBkcmpgbVma7A7qxhRG+oL7gUS258G3smtjekoC0GOoxKS0py
 m/lGTO2za8xywMcT7upMt+BQ4Ors5o/yC4i/qja3qGxpiir4hzPPkq1HxDXeCNdS2Sw+
 fP3ncXK5ird0+K044kjCgf2xTN9Pulvsr0kS/qpKx8lTzF7P9nofVSUZ0I6F1jAzgySZ
 SfICencmQ3EQrAMeH5jQ61fE6CmHAzRqadGjd07QRQEV95uVctU29JDulOZ5b/mNnkjl
 Tq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750155868; x=1750760668;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/spRQSZI5L9YMglQoCWWPNK0GpPtbCxeZsdzRk0K8eo=;
 b=azan8LRKJGDMHVqQbipwh/yYMzEVNPEFErCaCtBk0VXlsZArVyqOfeaXU7pe2+iHfi
 tuJ/pSTCpioltzYAJ8R3gV19w2cKmkfsSsCZwZZRAqcm001Ztsf9PiECvYTQG1RFjaNx
 PUfUcoGUZwYKP/h9L7qhoJAJ+oyD/fikc3dLgniAKyrm+2AKoN2Mmr98MEdJzyf+Qhcf
 zxBNtBLYeeFsZrP/BSkoxV6cAMUQNVV0WbLDSmhy3KttLEqGnYr0jRSuSbtsFgEummt7
 aNXB2/zBBw61TSmPr3GiACcyMydp6BLq8vyt6LiDcGNsiVfAi9ZEEVwtt2Dny3xizThu
 PSeA==
X-Gm-Message-State: AOJu0YyGDAhASPI7z8kZhSNNsR2Rqp2zJE6saH4A80GnCN/coDaYD3nX
 ImoGhqeDFfq9u77+4YMMJsHKJ2Ek0Iszuivlb2+4XqRWZR3sFBlIMX14K+c8KtfSupw=
X-Gm-Gg: ASbGncv+JaCHOkzBz8dLtxJjOop7Mq8hD7BRPLI7OzkH2jCfJYJk8MOfZwDQI+UCHiX
 HntsXw0TlCJZ51gXeFqRLorU8oTe4rSUuTEp+ReyGFybC/PBt4ts+tmlgHgG1jSVZkV6JvP1WQC
 UpKgHowEHPepdPbuKeWkb5i92g/ctXYQA3w83KPDh6Ilh2GZ8K0pIOz/PUPoiCn1eUhcFpmselU
 N+U9Mj3DzVdTdICvpvbXX6eQ4SfMW6uEOvg78HWr0lHY8SlxTgCY8q84LFYcYA81nAjGsIPLEzF
 o/+clZuFAgX3gE77ZfoJFcnFMMK8b83W1vgPAYMgLptVhpSOvz/iZJASvXX71+s=
X-Google-Smtp-Source: AGHT+IFRDd3JLHZvdgH4Uthxoj1/JqO9615gbqDAK5AdsQdBkxcB71VW+v/7lC+wCEC3sJAungLpag==
X-Received: by 2002:a05:6000:651:b0:3a5:8a68:b81d with SMTP id
 ffacd0b85a97d-3a58a68bc6amr1276666f8f.43.1750155868430; 
 Tue, 17 Jun 2025 03:24:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b70d77sm13699785f8f.94.2025.06.17.03.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:24:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E24555F834;
 Tue, 17 Jun 2025 11:24:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v12 5/7] plugins: Add memory hardware address read/write
 API
In-Reply-To: <20250611232409.2936521-6-rowanbhart@gmail.com> (Rowan Hart's
 message of "Wed, 11 Jun 2025 16:24:07 -0700")
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
 <20250611232409.2936521-6-rowanbhart@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 17 Jun 2025 11:24:26 +0100
Message-ID: <87h60evf6t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Rowan Hart <rowanbhart@gmail.com> writes:

> From: novafacing <rowanbhart@gmail.com>
>
> This patch adds functions to the plugins API to allow plugins to read
> and write memory via hardware addresses. The functions use the current
> address space of the current CPU in order to avoid exposing address
> space information to users. A later patch may want to add a function to
> permit a specified address space, for example to facilitate
> architecture-specific plugins that want to operate on them, for example
> reading ARM secure memory.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
<snip>
> +/**
> + * qemu_plugin_write_memory_hwaddr() - write to memory using a hardware =
address
> + *
> + * @addr: A physical address to write to
> + * @data: A byte array containing the data to write
> + *
> + * The contents of @data will be written to memory starting at the hardw=
are
> + * address @addr in the current address space for the current vCPU.
> + *
> + * This function does not guarantee consistency of writes, nor does it e=
nsure
> + * that pending writes are flushed either before or after the write take=
s place,
> + * so callers should take care when calling this function in plugin call=
backs to
> + * avoid depending on the existence of data written using this function =
which
> + * may be overwritten afterward. In addition, this function requires tha=
t the
> + * pages containing the address are not locked. Practically, this means =
that you
> + * should not write instruction memory in a current translation block in=
side a
> + * callback registered with qemu_plugin_register_vcpu_tb_trans_cb.
> + *
> + * You can, for example, write instruction memory in a current translati=
on block
> + * in a callback registered with qemu_plugin_register_vcpu_tb_exec_cb, a=
lthough
> + * be aware that the write will not be flushed until after the translati=
on block
> + * has finished executing.  In general, this function should be used to =
write
> + * data memory or to patch code at a known address, not in a current tra=
nslation
> + * block.

My main concern about the long list of caveats for writing memory is the
user will almost certainly cause weird things to happen which will then
be hard to debug. I can see the patcher example however it would be
useful to know what other practical uses this interface provides.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

