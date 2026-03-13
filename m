Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E32107BCEA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 23:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1C1a-00007J-8w; Fri, 13 Mar 2026 19:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1w1C1Y-000077-Jx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 19:34:32 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1w1C1W-0002cD-4U
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 19:34:32 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-5091ed02c54so116981cf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 16:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773444868; cv=none;
 d=google.com; s=arc-20240605;
 b=VjVXvsRWCnZ1/Atf6L23rUNrj0be9W4oq7H8Ty0vRgeiZSxA5+dF1AiYwdVrCVhYKE
 bjLehsHVi6LoGi2X9FtHy946tZwEPbVsLzga/Bnu1Ex+H7HWDKhAvpuwgpL7fLgzmdwG
 X6lRA5VQ79Ud9ZZ6etDSfz1HhObtCdU2u4qYElutSSUZQ+HGc8d4mrPfbf20YjXe7BJc
 R+bdn52xRKuoME6iM317jaSIYUSouTtWMAY0A1ar/SfBNMP8+y2hqdPYEBgC12664vrV
 ocfeV8Ub8VeF1DlGnBhQMUeh1G2wjz73HmfotnRNbrFAsvxWJFW52+vhhncVLhqx8sBM
 DzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d9cQs8WgF6gZAb3RC5fyumrq0nQGRHzYPfg+8EBqx70=;
 fh=ba1FszRwf7JaNB8e6fStBnVfFGHIJjBrMa4jV8yWqr8=;
 b=HQHS9yWa3BMQaMoAWaGbyXHIbWXG9Sz2gZGo5e1LToJkz1svxaTEgEgiEIWcZyxCVq
 ILyoBcl69vVaH8DMr4jXBWSedWJc3/kXWfamTs4LgK6ZKp16WwcLfDsCMi0qIIu9xtpn
 LvXgywYBjy0GHsNkpw8U78BX5pKpC4BZt4SlIFMEaiKiAz3iFA3fmseA40Xm7C0ryk1s
 5N2ZGXFeEXiYcRTBwHAiyMF+b7FMq/JxAAe3dTW54mmCQ++ah8tugPG8geXYXhB3ekkH
 9xOL07fiLxW4eMsNL/FymdUjy6w0eDQgPxlRNTpW3kUHtT1qfz8XUvbuTGAzl91QT/aQ
 3kOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773444868; x=1774049668; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9cQs8WgF6gZAb3RC5fyumrq0nQGRHzYPfg+8EBqx70=;
 b=Yts3dSYSsfSLldKYKQ41UFvplY1hgA2tKz0KWQkjdIc2kR/OFHmvAnEhLWaU9ru4rF
 33oYL757rV99rDscu2vwF98xKC27gLeMXCnb2iW6otGfU9Rjut2oXFbkZk5YeOcaSvYf
 sBFy6zLEi9ZD2MnCmZTbxZ4wkVEmqfWw8rYvm9nnklLNbJ/THaAUEqRBH0KtvTTGm2c5
 NePUWgPrAUvYRbQfcMBEu9hYPM3o56BPNx2lica+npKHkjOp/S9IQ2n+zZMcKJ/BZ5WY
 qRPOA9CIgDtOJ+4+G/38Egeg0Fy7X05n/x4YM4leHhSCJeE3CxkxNXQgnmLzCk+gjSqF
 S35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773444868; x=1774049668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d9cQs8WgF6gZAb3RC5fyumrq0nQGRHzYPfg+8EBqx70=;
 b=fOQ4qcc7s8u6d8uipg53bmoGSouhb/F0LctjQYUF7PH+zuuh2KnV0ZaC3B5Ug9q3xl
 9+JY4aS2xzCM9vyEZhZKo+UOBi0T8rmeSA/TLKBYAT+7dsVHg3xMn0yFYj4U18ftzukx
 XmZ82ZxwSK5FlEX+IDVclXHnBho8FwXUJDIcVlEo0MT+4fL6FRl1B7x9yEZGAL4SVMvJ
 q23ZHjnvN8LrAlBL8yLAs32QsP1dkaSc3UUNeaQr8vqI2dVA1cj06qVFHo1Sw5cc9EQT
 Lr1tuOFILqb2JzoJthqFbzCBNqhgupcf1joV+HfIl44163XQfHX1818mHV6cff30dwkD
 yt5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjyWdferi1V5a0sgS/chD9OanE2fbzjVEtNKkooDZS/dxVbkQcxec8OdR8Ru9wQiwR3ATgExl9vUmj@nongnu.org
X-Gm-Message-State: AOJu0YwfsQ3A9uyg6LvvsH4ScTQjo+XujVtqcu+DXuuQCTH+o+gzUMMF
 MHTzbjlP20iPuwwGvNEW5RgkQo2nCkBv3RZwqkYZwtMuqg+1R/53uTsTmYYEkppN54jLJKEHdMV
 77szEZ+EhlO/LwDZsbTGpxCDCrbgemiifcus6aPKB
X-Gm-Gg: ATEYQzzPW7AVMaWGRjfSdLBzkN7doaaDwusvdZKcZxHwLwjsooVpe1of0VkJDlERnwE
 yaqa0Llty2fRtgCfN5lqbppIRRfL5SmI2/SvY+VSNqKRpwHa3wi4ip+/OF1Mv60jE5T4S0Hb76B
 RCrpWorsLwKPaIzi+YTCH/r9qeErQICj8XWXxTjftj1nUq17YUoSmmTm0Yog9C7PNT0mwN62gNK
 cYg1X9NeE9U8VfvIAmCU7eJBPsMyAWVRPQXnYlhOEi1ovW/wojGN+2FbbcZTfM86e6jT88NJu+c
 GTSRRHA=
X-Received: by 2002:ac8:5893:0:b0:509:45f:fdd2 with SMTP id
 d75a77b69052e-5096aa4fd4dmr3253801cf.15.1773444867797; Fri, 13 Mar 2026
 16:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260312210802.899803-1-rkir@google.com>
 <abQflF_Ju2VI7pBa@x1.local>
In-Reply-To: <abQflF_Ju2VI7pBa@x1.local>
From: Roman Kiryanov <rkir@google.com>
Date: Fri, 13 Mar 2026 16:34:16 -0700
X-Gm-Features: AaiRm52iPwwCaP0KHAg5eJO63ju_os_Z1_wWmlMrmk26LmnDfqsJX-8VBoQnM74
Message-ID: <CAOGAQerTmr8ShvRq1P0o2f0yG=DYkBjNx7gu_XDO4oFy5by+9A@mail.gmail.com>
Subject: Re: [PATCH v2] vmstate: validate VMStateDescription::fields upon
 registration
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, whollins@google.com, 
 jansene@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=rkir@google.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Mar 13, 2026 at 7:30=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Thanks for the generosity, all kudos to Fabiano.  Let's replace this line
> with:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Sure, I will update the patch. I also noticed VirtioDeviceClass is not
covered by v2, so I added another assert into virtio_device_realize.
Now virtio-snd hits the assert if I remove unmigratable =3D 1.

