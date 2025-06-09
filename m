Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83CBC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOeIy-0002Gx-Pw; Mon, 09 Jun 2025 11:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uOeIw-0002Gb-JX
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:20:54 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uOeIu-0005EC-Uy
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:20:54 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad51ba0af48so1023384666b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749482450; x=1750087250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoJBL9/VH36x7L7yxNUA09PGKcLBXC7kOFv0XLXZ1Uw=;
 b=IcwYeBma9ZROPxaBcK6Hcg3vQDUqboSkPqwtBq3FOVusg2c5wCUmtaFvB7lAMD5Bby
 iXABk6l+5ecPyqS9rLQThft8Ti/NfgDrKJwq0aF4cRbEb30a2SqemyPbNe/WWBKebb3d
 SwTfQMV0yPZfEfDQBtp3BN0UToNTeLtDoSwFvskXdksEB1pCs/yMlobLVTl6pXVo1rEm
 GhEFtiQK1Q+8JsEBroNo3MHnHDYIaCw4sLGDGN1tonYWMI5iGoY3K6viO84NG2nADr1t
 PwryPfeYpTdKidC0aDFiOLb5qHLCi7FbtzIwEmYeNOiXNM1BLiYinHzuXRpZkHHc0/gC
 LVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749482450; x=1750087250;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RoJBL9/VH36x7L7yxNUA09PGKcLBXC7kOFv0XLXZ1Uw=;
 b=Xxdk9N6ztQxWRcTjN1/HS3pWagTrALD7UyRvebDNZP4fdYrNTwmNK0xRl44JSDs9M8
 0Yjn8OtaCcMXFuq1eSb9gN24KRr03D1ZOLFi+IyjR2oQzYvEy5fjwMDbVOvYyIyvGRxI
 uek5kNpLvWlLkbHkH2Gl7Km9Y2XGfdaOF2/6LYi66PAC+EvW9dYMoxue/L7a40+0CBfN
 cAxi5l0k+rALcdYnFA6Wfh3nY+9Up2ODhywcy2bIHj0q6Ayl8NFFZZrmzHFEDXsyAC+6
 TSJrowvLb5kO1+kUgkzpBLmMJGVtEUd9akgACZFCxaEyCA1UtP3xQELo8hp5nkk9g2ee
 VE+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvJJ2BcJ5ZweTO2dmB0FBrvUKDd6l1TMN4hTdxTo8zz/KrjZRSeZeqEgQInBXlr240ielAjxjGtGC9@nongnu.org
X-Gm-Message-State: AOJu0YzJ67IFd5ozbi7esoiujN5hve0NjbOjDcTXgKUCE0H4G6Q1h0GN
 jF/vgbwVBUbiTNO1k/AK6vyAMLLIWZTBOPyEbQ0SBXBQbo4VsR8VNsKsduEGAHbQYzQ=
X-Gm-Gg: ASbGncvAtHdhpZi/rWN4TmShdpFwd21+56PoTOqU4CDFGuB9TaLXHVckS1Y9tzX/ut1
 B1jgKN31oDvO/sXZNvX9d4aA73giYu0GkgofkkkA4AqfWc7DKZg1KjZiaw3UnLh/do01yY/uRdL
 3pGchj6iCFjwPceqE5wjbOQiz8cs7pOutCzI+Vv8ilbV1HehWcfXNCbBP2M2t7I7RhltiipsS/G
 d+GJiEiByCGJRagQLob8rz6pGDcTEuLY1dGexNCnm0hlDyJdLaMKuWk8/KgfRp9nsErVTfsR8W2
 CPnQ8Qn96oiViY1cgMioULdvnnirP4QBIQgkaVSAyKkf2KBQvOsMhRwbifk6aa0=
X-Google-Smtp-Source: AGHT+IFqlmC+qud0pH413xd/2V3+GqO4o+Av7iF7f2pkxY41nByWHywUEKrcxAjaDXmIApwM6Nap2w==
X-Received: by 2002:a17:907:7f03:b0:ad8:ace9:e280 with SMTP id
 a640c23a62f3a-ade75f6263bmr29870466b.5.1749482450079; 
 Mon, 09 Jun 2025 08:20:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc7c765sm571607466b.178.2025.06.09.08.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:20:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 849BE5F8A4;
 Mon, 09 Jun 2025 16:20:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: Julian Ganz <neither@nut.email>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Yanan Wang <wangyanan55@huawei.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alexandre Iooss
 <erdnaxe@crans.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 3/9] plugins: Add enforcement of QEMU_PLUGIN_CB flags
 in register R/W callbacks
In-Reply-To: <CAE5MsNZG2S2s=bqJ_kAj=p65_mNf7s0UTpAN1vt75iwm2+YD8A@mail.gmail.com>
 (Rowan Hart's message of "Mon, 9 Jun 2025 07:55:18 -0700")
References: <20250608230819.3382527-1-rowanbhart@gmail.com>
 <20250608230819.3382527-4-rowanbhart@gmail.com>
 <20250609135636.22368-1-neither@nut.email>
 <CAE5MsNZG2S2s=bqJ_kAj=p65_mNf7s0UTpAN1vt75iwm2+YD8A@mail.gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 09 Jun 2025 16:20:48 +0100
Message-ID: <87ikl5kkkv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

>  However, it should be safe at least for a subset of those callbacks and
>
>  I believe there are very valid use-cases for allowing such usage. For
>  example, we are currently working on a plugin API exposing traps. In
>  those callbacks, users may want to peek at some registers such as
>  "ecause" and "tval" (on RISC-V). We certainly will want to do so for the
>  use-case we are pushing that API for.
>
>  We could add a QEMU_PLUGIN_CB flag parameter to the respective
>  registration functions. But since they are not run from translated
>  blocks but _outside_ that context, I feel they would just clutter the
>  API without introducing any real benefit. That is, if there is no valid
>  safety or correctness concern that I'm not aware of.
>
> This makes sense, I think we could just set QEMU_PLUGIN_CB_RW_REGS for th=
ese callbacks if they're always called in a state
> where the stated requirements are met (I think they are). This would avoi=
d breaking compatibility while maintaining the
> functionality. Same as you, I looked around and it seems like the vcpu_(i=
nit|idle|exit) locations are definitely okay, I'll check
> into the tb_trans callback, I'm not entirely sure about it.

It should be OK here too.

The CB_RW_REGS flags are only needed for callback from within the
translated code - much like their cousins the TCG helpers. All register
state should rectified if we are no longer running translated code -
indeed currently it is rectified by the time we leave the translated
block and before we start the next one.

There are some edge cases when we handle exceptions but we should have
fixed up any register state before we longjmp back to the start of the
run loop.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

