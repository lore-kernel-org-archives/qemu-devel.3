Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC18CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6XbP-0007y9-5L; Wed, 08 Oct 2025 13:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6XbM-0007xu-2U
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6XbD-0005wo-G6
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759943100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+06nEThWsJ6AUuMugKUbpt6JK3XmZIO7ax7RQ0PGW0=;
 b=NIddUfBMXw0X0ymMBCv9TdR5moBO5OrGsR4wQOQgKE+voRZ6kfyYmUMUZfpyrGk71f4PkP
 y6oO7leVLBFoTH5FcAaPxwQhBR2oupMish4gPocBT0F4eMvaf+YGoqvtR/HlPE9U4OwKoV
 S0BIENDuPKVS16mskwvX6giQPAnQVsE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-mEihgVZ6P4CpKNW0HK3ymQ-1; Wed, 08 Oct 2025 13:04:58 -0400
X-MC-Unique: mEihgVZ6P4CpKNW0HK3ymQ-1
X-Mimecast-MFC-AGG-ID: mEihgVZ6P4CpKNW0HK3ymQ_1759943098
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ee13e43dd9so77310f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 10:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759943097; x=1760547897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+06nEThWsJ6AUuMugKUbpt6JK3XmZIO7ax7RQ0PGW0=;
 b=tTgOcAYk2NS/+VEWbLgnNFz9QwJKw8aWbHItJphWhx2cIIKnc+gic23HCkgQhANmiJ
 u+NUN2gP5na2Aafl0vN57Pj3WkkfnjiPCO12+STUQQei8u3ONQV0emiHE5doGK0qCtXO
 vhelVSyu81nLyVPH+QFPi5XZPtLbwwk6/5qTcy9H3pbCMiTfRi5pzDG/jpHxUHNp9IE5
 CII5mgqzc5Qa1aEDa8J7cbLF5JkdPtKDAIkDjzXpbePFU8rURStWCT2bzNObvC+a2RaW
 8c6c8UHoz/EyoRMcU7Fq+lXWpZdT/4oeCgW9+cgKSeZ2j4WtrFA4V8S0VBdnkxHbt+0+
 wqXA==
X-Gm-Message-State: AOJu0Ywa4w3fxPstUnEAYab12sfJyOA7QA7T6Q8tidGrCYqJ4zleO76t
 2r9ZXcPA6Z61dcOuhB4X1ix2GahXoCF2jVPzXXCeQDlcnrmawfIAGc5DUQoizWCFUOOlmqh7+fh
 ZLMyGMLofF8/n/jfFK7m8C6/235DUGnQIwZaDT6Ofgl/p+aa9kd4E5iKW4A469gjcHdio4jtJg5
 qVnZ8lcftI6T1lT+oGBPISULDYdF2MqxU=
X-Gm-Gg: ASbGncskib0I4LkU35xhW/L+j4jNpYi4LKi57zgrOqCJ1NLAaM4qalVboIp73VCvEYs
 LzIskNelegZMkE9RsQXqBvU7Yma+105p9074BHRfc9mCHcrNrKh60kDf+RskqeFCoV8dilB+TMD
 +xkXtPKc/FyQKb3taJ9mSpbUrVIGIQvnaAqgCzPHe9wETER6Qd9FlAV4LjcMeHKb46bmPPGKHub
 oQ3vXhKPRXcTv3cs3fFVm74/cbcuw==
X-Received: by 2002:a05:6000:1ac8:b0:3f7:b7ac:f3d4 with SMTP id
 ffacd0b85a97d-42666abbbc1mr3393046f8f.5.1759943097532; 
 Wed, 08 Oct 2025 10:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsnyEFUGtRtAzwKHUE9EeDOUmEHcvi5NsvWDwWjykamvIjDElChPJXlNNIEQUITjEd397KYCTixQSb/WmPBIk=
X-Received: by 2002:a05:6000:1ac8:b0:3f7:b7ac:f3d4 with SMTP id
 ffacd0b85a97d-42666abbbc1mr3393025f8f.5.1759943097130; Wed, 08 Oct 2025
 10:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251008152701.411964-1-pbonzini@redhat.com>
 <50578062-8b7a-4286-a154-eebf05f3be3c@linaro.org>
 <19ec9e38-8b34-420e-ade7-f82e9e7f5969@redhat.com>
 <badbd3be-f09b-4215-a179-bc13c98a9d26@linaro.org>
In-Reply-To: <badbd3be-f09b-4215-a179-bc13c98a9d26@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 8 Oct 2025 19:04:45 +0200
X-Gm-Features: AS18NWDPCjifQuAkMKA5ZQblJ8k8cancIEZT0rFZrXb7VuFQwEnrjKP9Znu4T9Y
Message-ID: <CABgObfYAwwaASRkSWZTwwUsjcpiM2t8KcxFZ=egbrqKSDEPSQg@mail.gmail.com>
Subject: Re: [PATCH] qobject: make refcount atomic
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 8, 2025 at 6:53=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> int f(int *p) { return __atomic_add_fetch(p, -1, 0) =3D=3D 0; }
> int g(int *p) { return __atomic_fetch_add(p, -1, 0) =3D=3D 1; }
>
> With current gcc, these two functions compile identically for x86_64, s39=
0x, riscv, and
> aarch64.  I didn't bother testing further.

The trick is that you have constants everywhere. You have by
definition add_fetch(x, y) =3D=3D fetch_add(x, y) + y, but also in this
case the "+ y" can move to the other side and simplify, as if you were
in 8th grade.

If either the addend or the compared value were variables things would
be different. I had never thought about it, so thanks for pointing it
out!

Paolo


