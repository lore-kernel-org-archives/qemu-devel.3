Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D71BC5AC7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsI3s-0002aa-Lr; Fri, 07 Aug 2026 06:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wsI3q-0002aG-A0
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:44:22 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wsI3o-00026o-O5
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:44:22 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-8f0989428b3so4867106d6.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 03:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786099459; cv=none;
 d=google.com; s=arc-20260327;
 b=iqnq19Iu8+hyLx0TLGQ+S5bj4M7N8yEXEZOE0skLr7z1JHbWATrbWC7nIzlmJmdMqj
 lO86LYPsxF03YQGATZtR+8H76pcyLyuhgMDASEUGU610yKw5rj4Px+EsHyAxzzERkPSN
 KcidtfZNrVd9r7aNbjboQuWLZsvxjRxZwQq/4/ByeRS0P/5uMkpNj8rHw7+cBYNVgREF
 c6b5sBGrehbPJw76FCjlF2oLquX9bxKKHbhyioMYGuJ4ZbtABnYFEA1Q50VxaRerWjPy
 ACakEJ++zhDsvXDKdMZrA2vdi3yFmS/VjqHQDVPsIM9IipQHk/T0wh9NWv5YDCRlMGuW
 FSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NHHBCtWvy+yxz3rNzO1dTVES8+fob87b5z9eKsdJwsw=;
 fh=tNPdNIu4Lm4KvAx6o9zPmlQg4MWqiWML9WVMuVx1USA=;
 b=Tk+YcLrWP72O0v63ohQS35846lZWFYOXahqD7tdeHMqaER2FuAymT43CSd13bqSoDi
 LIFan2q+aEXod3vy2dvTlf/qN+i1PN1z5hWSD/K3CDJvrNrLCYHgNdSTpqyz/n9YuVlH
 wPkPrb914x0T2c/jBaIycZ0/wZCWR1vl6+aWqaubwDEiRLzJ/Mlve3hdaI9Q4ohVWHR1
 H8qZYEnseM5JVz2e4X+01VQWxVVTriPWQM6LxxX0njVlKfTPlVzPF7UqVSf5K7HxkWNa
 /zkIksYeoXqSynQSQHWCpJzJkzhVD7DwDC96NPBGrLIr+ujqKojOJ7ZfyCMmsUprTO1V
 f4Ow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786099459; x=1786704259; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NHHBCtWvy+yxz3rNzO1dTVES8+fob87b5z9eKsdJwsw=;
 b=NBcGxTx+zqyU4N7Vb60S6vkbrVI02qeK2HWBnO5yy85OX3xSRBjDHQovC3ctG7BF4u
 Jr5d6EfLtXBTbYkBfL9StE2BWv7yjKN05B1CKjJVYC2eJ9yIb7WA0TG0k+79McN0YNdy
 oGiIpxBtpKmkmZIX+BtghYZc8vHFxdoVu14kYGzzey555rcYth9UaYDksJIdK3blxlIf
 FZsHK4Wfo8DgXfP72zHrwUCjfMwUEVDP1GKZ+BhAi0cERdoWwfjmasXtkQG/oeh9pTid
 48ofaEdTeesCdJQmkyQyY9DDscvb7bOCCFObJOVmlSBOsDAPfVX0ImMiZj6s6P4vvZY+
 5b/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786099459; x=1786704259;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NHHBCtWvy+yxz3rNzO1dTVES8+fob87b5z9eKsdJwsw=;
 b=OdIuDtIGbwmLABZIbuTmdg4yJk60HG20426+CvNl+ICoGVyV9DW8DmbXJNANjSm2fh
 mS3sBmxXE7yYMGMyxVH+Nw7NjXJw5Mv0pUkOqHhmVnqwJFcREs9dt5ml8dCRtyiey/3M
 IVZx4q7RsLr0+h6GgbwfPyAIYqQRJ2SQzxZLKdGXWgG276Rar1/ddyAuHF8MiHJd3A1i
 9EMazvxgMzrme0OxOIgA3CNioCD8yraWuXCfcoYYqhpezWpCyXU0Z6uSF5y67B5H+YEp
 ixyEzJTyO1FjvEojciOK6QHGhiiTx/wijgtNe8BRp7oaPejeVSirI2Q9hkNO+mMbK8aq
 A90Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpW+oIfw2I9kEC4ZBjEip0dBn2+5iwFtCn89yHWzJs27U2CgFPIni0MME7+PKaQWTPZvRmrLdaQZaO1@nongnu.org
X-Gm-Message-State: AOJu0YzGn1ST27WDizNEPy1e6iQ+Wy/cMZIjq5dG7Agfnffy0E84MuR2
 OVk46od/rwKKywLU6Js8EMRkXSchSexk475i6CIkt0A0jg2CDunM5Js8paq2KFHF76r6eAXo87U
 81HEjPOcWgierHl2jFNH8wFXd/g6vszQ=
X-Gm-Gg: AR+sD10YSU2U6JD4WVKbED282PYCKwxTuMmJPhO4YHA/zoeWLG3DoU0+6wsh58ePpvi
 BtJO/0QezdN7kCr4kG9Mx0jLGcTDkE1wQqWKArSuyvip/Z3RsEeKukUy/7YZ0lAxJkqaIB131Sq
 LjVjGxxAwvIpRNGMCA9HK6JgX2I1X+BaNW0GX4tAJrwsMT/m6jHBMDLbzb2uP7AdYoE2BgpU6vO
 kvEhKzss0yPk3IRZfCwZqxGRVZjwjTiqMyleZocGmAIOVUD1rwe8yfHDuXiDrXJSPEwfxzWgIX1
 SjTKwceT+aXM52wg308iDG65mB1RTeZyoyVmYK/acA2+j7Yi36517ajVWeKZB+YavVTLDbioB0r
 z
X-Received: by 2002:a05:6214:2022:b0:907:bde4:981e with SMTP id
 6a1803df08f44-908813746c1mr173318266d6.4.1786099459331; Fri, 07 Aug 2026
 03:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260718175208.118721-1-danielpaziyski@gmail.com>
 <20260718175208.118721-2-danielpaziyski@gmail.com>
 <50b49ea8-cfbc-4d0d-821a-4794887cfdc7@oracle.com>
In-Reply-To: <50b49ea8-cfbc-4d0d-821a-4794887cfdc7@oracle.com>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Fri, 7 Aug 2026 12:44:07 +0200
X-Gm-Features: AUfX_mwsG34pSntaOK2a1AW9J3vmmeLzr_Nm6uVtkApZ77bQ4w8VwLuqe8O361M
Message-ID: <CANukVxv8zaAhJ2gUvd6omkDPO+K9OEKR5xNVstmf7vigqAMm8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] amd_iommu: Honor DTE[IR] and DTE[IW] when DTE[Mode]
 is 0
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=danielpaziyski@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hello Alejandro,

Thank you for the detailed review!

On Thu, 6 Aug 2026 at 15:57, Alejandro Jimenez
<alejandro.j.jimenez@oracle.com> wrote:

> Thank you for the patches and the detailed description in the commit
> message. While the problem you are describing is valid, I think the
> solution in this series only addresses it partially. If my understanding is
> correct, your proposed Mode=0 handling covers a scenario like the following:
>
> - an earlier INVALIDATE_DEVTAB_ENTRY read DTE[Mode]>0 and set
> addr_translation = true
> - guest changes DTE in RAM to Mode=0
> - The corresponding DTE invalidation has not yet been received/processed by
> QEMU, so addr_translation still reflects the older DTE with Mode>0
> - a DMA request misses the IOTLB and triggers a page walk
> - amdvi_do_translate() reads the new Mode=0 DTE, which conflicts with the
> older DTE state cached in addr_translation = true
>
> I think the reverse scenario can also happen where a previous
> addr_translation = false can select the passthrough code path while the
> guest memory already has a DTE[Mode]>0.

You're right. The approach that you suggest:

> The approach I am considering is to cache the relevant DTE state (i.e. only
> the address translation related state) for each address space, and update
> it when processing INVALIDATE_DEVTAB_ENTRY or a global invalidation
> (INVALIDATE_IOMMU_ALL). THis way we avoid reading the DTE from guest memory
> at various paths, and instead use the cached version, so the emulation code
> makes decisions based on a consistent state.

would solve this problem for the part of the code that I've touched, and other
parts too.

> Based on my reading of the AMDVi documentation, the OS must issue
> INVALIDATE_DEVTAB_ENTRY after modifying a DTE before it can rely on any the
> updated field(s) being used. A guest can change the Device Table in its
> RAM, but the synchronization point where the change starts affecting
> behavior in the HW (or emulated HW in this case) is after the next
> INVALIDATE_DEVTAB_ENTRY command.

By the way, as I understand per the AMDVi specification, it would not be
required to invalidate DTEs if address translation or interrupt translation
information is changed, as long as V=0 and IV=0 before the change. However,
I feel that emulating this will be complex, since the Device Table writes will
have to be intercepted. Moreover, Linux (and probably many other OSes) seem
to always flush DTEs, so implementing this wouldn't be necessary.

> There are other issues that the patch doesn't address e.g. for a VFIO
> device, the replay() callback does not handle Mode=0. It calls
> amdvi_sync_shadow_page_table_range()->fetch_pte() which rejects Mode=0, so
> no MAP notifications would be generated in case of DTEs with RO or WO
> permissions.

Oh, okay. I was not aware of this.

> I think what I describe above should be a prerequisite for your patch to
> then implement consistent handling of IR/IW permissions with Mode=0. It is
> a much larger change, so I am still working through it, but you are welcome
> to contribute now that I have hopefully explained the idea :).

Sure! I am willing to make a V2 of this series, fixing the replay callback and
taking advantage of the cached DTE, once you have implemented it.

Cheers,
Daniel

