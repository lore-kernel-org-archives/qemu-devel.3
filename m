Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD6606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D6lzvjNZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJq2m-0001Q6-Tk; Thu, 22 Oct 2026 06:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJq2l-0001Nw-DO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:29:07 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJq2k-0006vM-39
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:29:07 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ad98c3fb15so14390237b3.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 03:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792664945; cv=none;
 d=google.com; s=arc-20260327;
 b=Vo4lr9d7FLCIrrAZf/hbt9bmeYcSvebFz0gQnlxEXCiOizvx0MrR5JPCHHKGy2INHi
 Ox5eJ/YHiStw7nyULHBrcQTYNvB8N5ZUGY34MgUm9BS6jiKTCoHxh/z9lItu9rY7TtOz
 jvQwYDY90y0gC+vVoIsK1XGiicHCExCgjp5sZxkbhqf+iWbLiBqUcxOM3uZH0Vp6HVsx
 NgdRsTMbkF7eB2q34D9NxaIDd8TmFqaxeFxsFfbF6T4wXXXoSip/kPutGuE82sDG/jU0
 qAw6NQAh6cOD6KKeYplefrKs7MCWG2z5vujrZAh7VKacoRT0naOwYRgwG7gSPvbvRuvt
 UzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cn7Jiy+rfx7L3qxqqL0r7yhmrZU1rqORsCCwAHiY62s=;
 fh=KCIokPmqIUCK7Ya/gVx45jYAspZT5yBvW27l2Aylpnc=;
 b=cLeFJB79Tns7qFTJRgy1J1Zp5xW0cvG0OeEFjl2elgsK/KHXAfEZe13oFNvbmmF+9u
 U4Vji7yO2/ePnxqJcJXsi0csp/c7miGpcgVUtUvTImI9IsgkH72yyLpjhYH/d2Z34sw7
 nY61IklMwm8mB3BqLNILEZmK0WqzRHKoxhyKBGyO4qWoAYYc0AUwZDfMi1qcQy8x3puN
 bHlrT++rT4K3Nod0NYOrcYUMwL4a/nAikDJxckNvBz0T9pAAMxkt70FuOU0LOVPv9rWD
 T0J7ZTeekkdlKxlhFNuEfzJf++7mroljkNjoRVGfFQUnyvejKGz50wsJpmZruEKps+8u
 2okA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792664945; x=1793269745; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cn7Jiy+rfx7L3qxqqL0r7yhmrZU1rqORsCCwAHiY62s=;
 b=D6lzvjNZd5AQEPbgQ+IUoXxhB2QfbOxlvEEAjQRYPUpTtdYv2tGzBcgXnUYzgJqTCF
 ZfL4XHGHg0gv8Oqc8m5ggK+rn1WIcnUV4Lz0qsXeHCBfjejJn6ewPR9Fa+oCuJYtNS6k
 FZFQCTt5zIzPhZqCUF7EGFCaqXR/NaNG9acVreSRwv0eV8bluBaHfw8mg3YZBDjHl1/6
 xSya1nTog9Cj/CvyMQw1KX9Nc0/2N86v6lNKMoV59z5YJSdH4ssZav0LP8anXIyRbwyI
 L4X1k8fK8M0b+u9dH+ddP2GzVU9qo+AXzjf/M3L985TIlRzAOr8eqlw/4wke70hkSsbJ
 0XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792664945; x=1793269745;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cn7Jiy+rfx7L3qxqqL0r7yhmrZU1rqORsCCwAHiY62s=;
 b=QZhwyEFPt72px/4BT0djAdiUuu21fOWjCn5LAhSfvUwzPTmUD+umx7vEKNz919IXlq
 zlA7uHk0V8uw4tkQ2j8n/OkZ1Ik3nlenqSliTk3heFmMn6U6oFhU/V6fXJLvUcIXZinE
 kkN7uUtRHujFInEBCSBuR3pnqCVvOHFUsGJzIU3oeYA/sRCOb7nAxFn/ClVR/nfQc4Ap
 FhwItYwZ/TXC7zbWQuznAzrs+krlsBuwPzRLpR38N/XC7ZXulw0HvLotfjiJnYZwRQGQ
 AKlgTf7kCjCZKV7RzRgiWHkGWUCf4p1SLvuKoiYA1MALjPcth2PQvHGjVx8uiaSaeHYh
 8cMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjXc/mbGOYJlmfr0bNhusjnUczu0RnIkg6v91OwU5pUIUZrPDM37gRLzSwinQSBkUBHzBBXoEqaNVe@nongnu.org
X-Gm-Message-State: AFq9FYJiCfKpV5YXK9/boMDfo9yPFVXOUC4HQr4RDg48EYO50gmdqzDg
 L33t0e4Pnhz9eLW0owT0Zr9crVkuTi/t5KcFDowyBdjGN8gCQFio+SHzNI4cFUiW3vfSvfjUQFM
 vW4PDPmBo4Tbi3XzZVx3KhTswf8lRvZml/RG9zmHGZg==
X-Gm-Gg: AYBFou3RoB5O2iB3FLo0bhquch9rgdUFK0hn1YJjNoStwsLrIdrV+fSLuSLFuq7AYnp
 kX6v3wydHC86626NLB1lB1xUvBRTXYsLPOEetXO4efLgtLVzYm4g8fop0EbkS/2jrgpIF7sqPYm
 nHCvyQiq0h7Eft+AGa7S9QnToro3KrI/+lUGh1HpIf6IKzOmeggf3vG6SrjqvnXfqc70JmUSeXK
 4h2WvjCKoT2MV529Chtwr2oQ2x/w6XG6GrepPO2VlEjWQgfYGn7/XtrG/LBFYspMmPKwnRK7/2w
 30Q+hn0fTOssbfgVM+ILJw4TjrEMpmrk8eRJM97CjcNxEigBDYUdfsaDxvdaiOXkp6HJOGeb+v4
 uqld8gnwb0LuyjBWFlnt2/yeR4xD1xqaQ+9+zwAHxxbfgRd3z5OH4J/tqaqedkbTlLmrPRAbGO+
 91FlEptYwFPdkNrBaoRyAj
X-Received: by 2002:a05:690c:698b:b0:7db:ccda:a409 with SMTP id
 00721157ae682-8b133c990ebmr26039097b3.9.1792664944827; Thu, 22 Oct 2026
 03:29:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261010133725.642498-1-eric.auger@redhat.com>
 <20261010133725.642498-4-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2026 11:28:52 +0100
X-Gm-Features: AclHuK88Pi0Irsvl-VdYfD4usULDFkmX6lTQYJ4Rpq4T7jFaUE3PDSXIv2XVoCo
Message-ID: <CAFEAcA8HS9a3eyrs7iOE3xZ9MyHHr9w5UmReAz==yy-cgyY-Fg@mail.gmail.com>
Subject: Re: [PATCH v10 03/26] target/arm: Enforce MPIDR into isar.idregs[]
 storage
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com, 
 maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 10 Oct 2026 at 14:37, Eric Auger <eric.auger@redhat.com> wrote:
>
> At the moment MPIDR_EL1 has no real storage. Instead cpu
> mp_affinity field stores the Aff0-Aff2 bits only and the
> ID register is reconstructed when needed. There is also
> an mp-affinity property used for TCG only.
>
> Keep the mp-affinity property and its associated storage
> while making sure the MPIDR_EL1 full register is stored
> in cpu->isar.idregs[] as other ID registers.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

