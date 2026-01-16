Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD10D4899D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjjS-0000ko-DN; Fri, 16 Jan 2026 08:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgjj7-0000bW-Ml
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:19:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgjj6-0004Yl-07
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768569533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BijVKfJYpft8hEjfNT217ssJf3b3ivqisyGnWJsuNY=;
 b=N/l92WU2dz+7znw7cJ5wMn6H/0rtCnM9HkWZ1tiH4/3CDgZTQ+sjonYnu0Q0Nsk7j2eMto
 rHkRkAPk4wKhoYMqxHmGMf0S6zzn0wcGPHBVidYKiMHQUGRDWFWfuaC+TiNbYBX8AcF3oQ
 /FQugVqNy7PQVT63rsmkMT/BN82KMcM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-bVRCKKwLOyGpe2slOdVYAw-1; Fri, 16 Jan 2026 08:18:51 -0500
X-MC-Unique: bVRCKKwLOyGpe2slOdVYAw-1
X-Mimecast-MFC-AGG-ID: bVRCKKwLOyGpe2slOdVYAw_1768569530
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcf10287so1749984f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 05:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768569530; x=1769174330; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BijVKfJYpft8hEjfNT217ssJf3b3ivqisyGnWJsuNY=;
 b=d5ze3MWyGxfgdVDDId/KgEXq1BmrOtT5wZXc4CoGMczzxpVcMA3zaCQ/XbaD/8L6L8
 Vy43BBBuchVHdlBKhbuwDpschzOFo6wbcML0OMIWu5tKXrg9S1IssS/ycuxNvB6HCdze
 Q7X3i3e3fM4KRKGUFsMNlUZ/tsKvfuZLng7bqnBXHrQW2ARSYyLlEKPJTdepMs0rLAbC
 +s580pK4OQSG2Seg8NLyfDOJ9Z8EvpaHmHmnKytdXhgHqkLa7N5PeNUgNXkkVwMUMVPQ
 pn0kz9FerGVzM8j2GvFNwKCRgXIX3xawamk8lBPdfC5LarJSbQg3lzjE53F9oKBeTNf5
 46yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768569530; x=1769174330;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2BijVKfJYpft8hEjfNT217ssJf3b3ivqisyGnWJsuNY=;
 b=Pwx6lgSq0RrLpTalUgSO563hDsQpnWPWl25JPf/fPX3fNKyead15Hmokjss3vZAQ9s
 MbjvcCRVIKqsVtM/TwDH7q7HtBoWfYMirVAhSoAkZg1B2K/1yrbFlfxxBHeiYi9PWVDz
 SWhl+vNO8duCthEeA+JjiKpVPuVqCHJiu7j8ytjOgcSfCESQ7Nu7Nt+2oBjqVbdD4ysq
 dVH/WOmaBAYCgIDfPyk0VQ2uAODtdzmy5va7w9mTUVNeP7fUjWC6D42mFBCvscYHpckx
 swuxkJy0FDY0YGJfnJ9fliQ/7gYmSqGmU7BUjo4D2mYZrzaEK2D7sPbTrLqMauoyzyVe
 yeVg==
X-Gm-Message-State: AOJu0YzfLxedxvP+mSW0puGfeMI7FsmUHExDS6ujTTQwSzSOXfatm/9T
 tAyzTqh/jpikNHIURHtDGVQJgg957oPBCe8ZGurgkMETEK7E5ezyFR2iUPTQ4FUSqWATs/tv5yR
 WrbwHTtnShnccWlZxZ36vtbwG+TO7PftuEU2+Niz/k0jA6g5viKMRhniRD+iiD0Co6jvcvDVTok
 cW/AI9N4uGkFCwJf+c2wdqVjQuTi5emtQ=
X-Gm-Gg: AY/fxX4fk4ZdNY4v1b3S3LKGTuFUgIfz1P58aqktrAHhDYwA6xwOpLXCQQt8YNa4LMO
 zVVT4ZFNwJUVw1lXBuwZurDiyvODxhf+o3yhbmpk7+aLJYlEfPRckfF81/L6thsyuaJtbK3C5Ek
 ZAlq3ibjaIHdjPZpZGeKPfzORkya/R2sbFLAQsPtF/JbxplKSdpQ5J1byDzb2mDkyO61OfEn388
 DcPnWf9OrgJ9a1RXKPHJ4IS+KkDMKh+Hue3ipTX5K9JHgrXFSkeeXJtOMrWHbWZkn1JdQ==
X-Received: by 2002:a05:6000:24c7:b0:42f:bbc6:edc1 with SMTP id
 ffacd0b85a97d-4356997f499mr3109131f8f.1.1768569530140; 
 Fri, 16 Jan 2026 05:18:50 -0800 (PST)
X-Received: by 2002:a05:6000:24c7:b0:42f:bbc6:edc1 with SMTP id
 ffacd0b85a97d-4356997f499mr3109103f8f.1.1768569529713; Fri, 16 Jan 2026
 05:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20260115135453.140870-1-pbonzini@redhat.com>
 <20260115135453.140870-2-pbonzini@redhat.com>
 <c19329fc-f57e-4687-a490-c38c4bfea866@linaro.org>
In-Reply-To: <c19329fc-f57e-4687-a490-c38c4bfea866@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 16 Jan 2026 14:18:36 +0100
X-Gm-Features: AZwV_QiTOctO-UYChQlj_Blvl4zp3ezfbd1E3RXI1on6IP-bAMwexl7I5TCxDXs
Message-ID: <CABgObfaXtFRxqyoHtzRKy6_gFS2ja+L6K_Cgj7qCT=3uqQX9Uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tcg: target-dependent lowering of extract to shr/and
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 16, 2026 at 12:38=E2=80=AFPM Jim MacArthur <jim.macarthur@linar=
o.org> wrote:
>
> On 1/15/26 13:54, Paolo Bonzini wrote:
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index fbf09f5c826..79ca49154a2 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3509,11 +3509,8 @@ static void process_constraint_sets(void)
>      }
>  }
>
> -static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
> +static const TCGArgConstraint *op_args_ct(TCGOpcode opc, TCGType type, u=
nsigned flags)
>  {
> -    TCGOpcode opc =3D op->opc;
> -    TCGType type =3D TCGOP_TYPE(op);
> -    unsigned flags =3D TCGOP_FLAGS(op);
>      const TCGOpDef *def =3D &tcg_op_defs[opc];
>      const TCGOutOp *outop =3D all_outop[opc];
>      TCGConstraintSetIndex con_set;
> @@ -3540,6 +3537,24 @@ static const TCGArgConstraint *opcode_args_ct(cons=
t TCGOp *op)
>      return all_cts[con_set];
>  }
>
> +static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
> +{
> +    return op_args_ct(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
> +}
> +
> +/* Return true if the backend can efficiently handle IMM as an immediate
> +   for OP.  */
> +bool tcg_op_imm_match(TCGOpcode opc, TCGType type, tcg_target_ulong imm)
> +{
> +    const TCGOpDef * const def =3D &tcg_op_defs[opc];
> +    const TCGArgConstraint *args_ct =3D op_args_ct(opc, type, 0);
> +
> +    tcg_debug_assert(def->nb_iargs =3D=3D 2);
> +    return tcg_target_const_match(
> +        imm, args_ct[def->nb_oargs + 2].ct,
> +        type, 0, 0);
> +}
> +
>  static void remove_label_use(TCGOp *op, int idx)
>  {
>      TCGLabel *label =3D arg_label(op->args[idx]);
>
> Functionally this looks good, but there are a couple of coding standards =
issues raised by scripts/checkpatch.pl: The definition of op_args_ct is ove=
r 80 characters, and your block comment for tcg_op_imm_match should use /* =
and */ on separate lines. If those are fixed I'm happy to approve it.

tcg/tcg.c has several comments with that style, especially at the head
of functions (see temp_sync, temp_free_or_dead).  I'll fix the 80
characters.

Paolo


