Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FAEC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 17:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKLjC-0001f1-Nw; Thu, 20 Jun 2024 13:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKLjB-0001ea-Pp
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKLjA-0002Fx-BX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718905058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQ5EZfeSvzKgBXBmvZelTSPr13ceE0MByq/ssT8yTWc=;
 b=OjIKMFWIsyaBCeYkW/hWtLKCpvz5IV+v9uEOlrhfi9fTkwYcNna4HkvoE9FBz1U+RvYOGR
 PmthPj/2DtweBwGvLQdR61r0rNtFoE2/q42ww6/FAUmJUFI7ZvtPr7RuJG3KbS1PEItM31
 pnLqcOP1aBP1h9YYm+cMFFHyLl4RfIs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-ozbPK1-MPRqFt_QdW1OvGA-1; Thu, 20 Jun 2024 13:37:37 -0400
X-MC-Unique: ozbPK1-MPRqFt_QdW1OvGA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4229a964745so8224775e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 10:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718905056; x=1719509856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQ5EZfeSvzKgBXBmvZelTSPr13ceE0MByq/ssT8yTWc=;
 b=s5/TGEfAM63hM2z8ZhRZiBKutg/PbAizN3EcJaJ9Q2oflSYpjp3WBBQ9PyLyO/VFUh
 C9h58NTF1XuQm7dwf8td+DCl+7APVRsSsrgwweNfMnTNH/nkJKnE0G3zWYRsQVv5ryNi
 ABDWbvdsAcgVLfhAAIQKp04/soZcVCmCgVMuziwhOeodWnaML8hJbJ4FMSos5WRr3XkU
 5v3GypjQSOCHJPWeRclEy1VJMifkRxLAN/kBxJ0LCGLQxooMxOHhLRbxUVFzENzVSKfD
 +1iSP0SKkcCcj0vqNHxirqpj5aSjvvshKVUUDoUQW1h1OUcs77I4syihNXLtGlgzIJiF
 CHIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYZ/O6yCEpMCWjrh1btMUx9v1K58Z7pvx/6krp1cZx9lVE7CAZfbGA/eNiSN2IhR7+1gv/P+2sF4DhOtzmRlqs22tXOOU=
X-Gm-Message-State: AOJu0Ywnc1GKo1aUsGHkxQ5nIKv5Zm60qrbd3RH+vOv4AtODSDKmVkg9
 WY0g/3ThWELD8sIqpF+gwenBwaMkxIXIvlmzcu7xui3VRtM/vo43B2EvIhb9AGSRv3kHTVCX7yA
 AZBMBlO/3IfeJHW8Oes7ivZe28Yts7W9tURFWLAfSWtViQ7Gs7ObNoO0Khfx3gd1DwxU18yxyC7
 LlbrKKbYC46pL6Ngq+0sr9YBu47NA=
X-Received: by 2002:adf:fac9:0:b0:362:b906:11f5 with SMTP id
 ffacd0b85a97d-36319990f50mr4514877f8f.67.1718905056361; 
 Thu, 20 Jun 2024 10:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPkewBl19H7stwbg67u6ClRow7IA8r+t1GvgfDgrM461Tm+jusZn2bc22GA/RdQRQnK/NyTYizv4sA2+KCuRU=
X-Received: by 2002:adf:fac9:0:b0:362:b906:11f5 with SMTP id
 ffacd0b85a97d-36319990f50mr4514861f8f.67.1718905056027; Thu, 20 Jun 2024
 10:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240620130254.415699-1-pbonzini@redhat.com>
 <20240620130254.415699-7-pbonzini@redhat.com>
 <ZnRETaWTb57K0VO3@redhat.com>
 <068d20cb-62c2-47ca-bf56-eea5f53ff51a@linaro.org>
In-Reply-To: <068d20cb-62c2-47ca-bf56-eea5f53ff51a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Jun 2024 19:37:23 +0200
Message-ID: <CABgObfb1ge8ntKGvaXpBVumU+fzxn98kqc2xfGczy9EZPY8SHQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] meson: require compiler support for chosen x86-64
 instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, amonakov@ispras.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 20, 2024 at 7:22=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> > I'm not sure this makes sense. The CONFIG_AVX* options are used only
> > to validate whether the toolchain has support for this. The QEMU
> > code then has a runtime, so it automagically uses AVX2/AVX512
> > if-and-only-if running on a suitably new CPU.  IOW, we want this
> > enabled always when the toolchain supports it, regardless of what
> > x86_version is set.
>
> Indeed.  To me this means they should not be configure options at all.
> We should simply detect compiler support, end of.

Ok, I'll drop this patch then for now.

Paolo


