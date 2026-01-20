Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E748CA5FA0
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 16:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viENr-00083S-6j; Tue, 20 Jan 2026 11:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1viENo-00082J-96
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:15:08 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1viENm-0007RH-RE
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:15:08 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-5efa33b2639so1720735137.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 08:15:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768925705; cv=none;
 d=google.com; s=arc-20240605;
 b=CzL8JMF30v5L/VrUk0YBfqS7HwJyvgMUViPnFRBv9cKullFyxMyd/EaqJTglJxm0gf
 GKW8xzW+BuYx/42RDTG6aFXZsEVBUmHX4nlWg8a/h22cgnqs3s515DTNLFjAQnjtVnR/
 TIvQvZk/o0IWot9kw22nuzJtYjjSF8vfuYWdgi2r6yf8PnpNmTlQQ581oR/ZQc6ks+NY
 G2nsW1kKmUPD9uCn0La3oRdwLVbG2U2wjdQOaRMype9hPoTg2KeGvjudxotPB3Z+L3F7
 3mszUTkaOcueBCXdojemkA8PO3bmqE8v3cJPCQlnrXJFNoyzIQgsA5e/FTGuwVKpwn6W
 C5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OgpKwBTWdzG+DUWbIK06eFrvh3MPbnsa/I6hsP4Sr4M=;
 fh=UbJQ5NaR3Qa+YiJY9hMRccFCMilAP/C+b86x+U5OObQ=;
 b=RQtDdG/Ao3336PF5wSwfKuD1fAUsBapwy1neHClK1+8EP67RWIcIc5fNkVQ8oRO0ki
 hIW6g8BfQAJ1hGCwATnI0EMY0Fsslc0jeN2k/xcjsrt6P7brYJ4R9/SELKZGnglDsGTY
 /86cuXCYiNLSc2LPxpul9Wc52oOwb8l2nG1TyM0P7l7zFt5YwLAL7o661pqKH+X/JNtv
 dKWbKrChOp/EO70VNU1WidV7w93GOArCjIzHjBL52wLhQq0yVcL8q60moNQU3Bnz8W+f
 LehkAqWlgA0UhNqv5rojWMcuICGRJ9UgqMae0rF8LVdCHtklzx4GkHonrcqZQpmmRcdi
 n5OA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768925705; x=1769530505; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgpKwBTWdzG+DUWbIK06eFrvh3MPbnsa/I6hsP4Sr4M=;
 b=ipq9ouvCv6ENCC180/j9I9tNRXYkAzP3DdHemXHzprZLYHL2JEiblaucc1SaRvGjkS
 WiIVtzgtif4cw0KNb6z0J1Ysb2SIzz7SflVFo/ie0rVYWXY0j4OCeN3Ax/4kYhBDoTqM
 a7Hb/0iRvBsUnLA/R2YwaevNwzJt8uZiOa1NkKFMWyKS0pd2EELloh9S0299wAWNJyef
 eTzn2DMnKzMgMxKn237mRBMqoQUtss0Urcrlieb1+Ntfmpbd/H9rbkkt+q3ck1dyCNfr
 Q2X0lfHAyjuoOESkGmyF7x7SNORpM97NuZfv+iVJagIpZORW+TFMJzTol8b+6gYVPjQG
 YuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768925705; x=1769530505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OgpKwBTWdzG+DUWbIK06eFrvh3MPbnsa/I6hsP4Sr4M=;
 b=ogVoquRBu8UNq2Pix+XNPAXxjWgZ51A3flOPp78sIgKfPuTF73mm9/HWyp7/J1S888
 z9/QEy4TYbIRnhmN09UDI6z4xsU7WamjH5eQJ8O8WgJT1kUXp/CERa/2DOOsD54w7e9h
 yqioQH1fQXU2c7Vb327aGyS6IkV/oHnjLmC2emK8T2nBy2iwvkkR7aRPyqBotEIA5K/9
 YFOesR1+BV5WYOnbe5+S0p7GiDG3MMzLeuRfdyjBywOJ6DjqWkkmVKrCx6WXjggr2Lvl
 I5J6SpC/zwXL7NqGKKW271gT0pdJoW+ZgaYdX40FLlvSWfSQJbt0l9lmZQYI3019aZpD
 XDXA==
X-Gm-Message-State: AOJu0YxkplD+NdhahHaJ3t91DvxyONJ6jQT21+coYSC+OrX/fZ6cFzGE
 YhZpRHgeb5CZaSTRph3sRtO7fEEE+T5+e1omb5pPFDNcbAzMtEEy5Lf2qmxVu9AcDl6wB3lrY8H
 6xEER+a5wJo7JyVOxvueZuHSE2rhiKaE=
X-Gm-Gg: AZuq6aJXFQziDqUPNg9v6+NA4fzvgjzHxdhGQFTH4W36QD7xm/Rbh6WMBPBCuJLzcgZ
 6l2PivqUWtryabfH/GMDTy02R4+t0dhAJlIrhUxTpjlgPceJMjaWEl3Mb7EV7CigQ4yAhhECWW9
 4Tvdywh9vNyDHVWr4RVKVe/p4YbiqPywylzJDBFWKxfvc0SacKRl7KYm25wmm4sULsRiZcHp5ik
 poZesx8SSRCeXMPPiZc/jtBjE5lasTojxvzRojULdjPTZNWtU8700f0iF0pmvFYM7lXOiAiHeZN
 vVtmtMO9tOA7kqQPIsPyWxp7Of0Q1EaENzWymYTGiA==
X-Received: by 2002:a05:6102:e08:b0:5ee:a0de:65d5 with SMTP id
 ada2fe7eead31-5f1a720aa52mr3985355137.41.1768925703788; Tue, 20 Jan 2026
 08:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20260119120402.284985-1-pbonzini@redhat.com>
In-Reply-To: <20260119120402.284985-1-pbonzini@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Tue, 20 Jan 2026 22:14:52 +0600
X-Gm-Features: AZwV_QgVIpjiAAcu-QwMNXTcAwcWJiYMHfWzpgyyC9brN_0Q41f-Qj7N00cmspQ
Message-ID: <CAFfO_h6enoquCVhD33Z0Om8-mOYmQTORKAbD_yYOOC4pVUn-vg@mail.gmail.com>
Subject: Re: [PATCH] virtio-nsm: include qemu/osdep.h
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Jan 19, 2026 at 6:04=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The file hw/virtio/cbor-helpers.c does not include our standard qemu/osde=
p.h
> header, add it.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/cbor-helpers.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>

