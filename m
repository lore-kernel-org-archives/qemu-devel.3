Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06765CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKU7-0007PK-02; Thu, 15 Oct 2026 08:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHKTj-0006Qo-ER
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:36 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHKTf-0005eO-4A
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:33 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8ab43af5e97so51659907b3.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 05:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792066949; cv=none;
 d=google.com; s=arc-20260327;
 b=CyRJUEdl4J3CRn7L6oRREdAosMnPdi9vCgv/vU7b8NFqQyfUNG7rxVdmG7ulnfUrm9
 KNN5EF8yxk5GpDc6q2UKAs8ReVSZ9W/5wj2kaN1r7bRbZEaDBsg9sXLEI3zAZr5i0Nom
 TNF0sCgtkpwGg8xeqptXZR4bWhocKmzUCzYCiHGVgWWI6MdlQMj/BiK6O8WVG2ar2h6Q
 NNa9GMzDO4rGye9GrhOGAZg03TP33F1fVnoR4MT0I44BNAC76mEKQiUTo05J1IjF/Nyy
 c7lL6N5jDfadelplRbeiOMgfZH54FbbWbMUUzn/1RI5efYjWihvN/TevVMFRbrky0bko
 LOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U92CGQXLWP/g3pVsOzf+GbrF6oRwn/h4Pu4vLDCB2+g=;
 fh=znyq16sJXNTFYCTTu/8IvkEIs4tLovEoMKjKJd7A6IY=;
 b=Y+Bdbcd85HNjl0H89s/BM21sN+figPBK/ReUjAlP5Szyl6yuHBegGO8xsco9SC+o1v
 Z+klY892f6S9eTucpO0BJ+017GLXZNyT9w5s03Jsqsi/NomXf3eKQXvSgoftHN4RI4xZ
 bXHf7o4KTixgHY9PjWqYA2F+6jyoYymg7XVSKA93lXBEcex070qKIydgEp1Q52Uk/trw
 MOGpsNn74+hzcVslO2e7QV/vrpWBVsE//0DdmJkgCE+UbmDCcUGC0FViUMoF0eiJJMtm
 Lhd+MCYBwKdsqP9CZYMhG45VJNih92QJ8fcnCV4Xix52KkyVoKgNMc5HAnl4wpW5Ia0l
 PT0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792066949; x=1792671749; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U92CGQXLWP/g3pVsOzf+GbrF6oRwn/h4Pu4vLDCB2+g=;
 b=a0LoPnyYqhYxBX0kE4C/Hq+k0uLEJ1dBG1mHHstIyiPNtMriLQKsmGEbbyIzOoydgg
 XDRh5d/gYd/kIrexMx6mSlQSxKCYP73D7H7u2Gc0Ew2z3qEHNARsgjwBoEGCRwNXL04v
 e6qUfVU0pE/K6GpJIZ0wkff7H++Vz2TaGi02v/4lR4ddzD3NVQJ0u3OnqXIn24wc5q9Q
 NTMKkKpFPIywKuzfW9/4w8tX3i/41XbCgbhfdV3dkjfe05XyUD28SLd9VlxRrwkYrO0+
 ja1X9Fs7JltzA00kvwSlXbswGojTQix4GKwnTUSP3X3q+VzT1kiZ8t/3/j0p87HDbymS
 iQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792066949; x=1792671749;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U92CGQXLWP/g3pVsOzf+GbrF6oRwn/h4Pu4vLDCB2+g=;
 b=q3FCHbiwN9w73S8vQ3Bysk4nuwc+iCY1rbLLQ6l9vLy4KUXvjFn/G5lGwfJZtrOxM7
 6vY344BVd/AusdRjqxn1EXpsjrAziKbmx0AWPSyDB+mqsfk2SzGIiJNJy7rJU2sUiKDz
 27GnMD4/3pCsQB38X+3LJeA0CGQtczvjIwpU1A10kL5j5sZrr+mBx4ZLFypj6hIO5HpD
 J7OMMVWBokiJ2gxvthO0AKvYzUxxgmDZnzBAvnzl9zq5hn6UxIiWkLOVVEnlZYqYMdno
 Np3dvuOfMRbHV7Q65dcuJq8vxQQ9HhaPaqt8jx8b6YNRz64Q59/TfpBRcofK4K7pqI0z
 AzhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpr+ttFwzdsgYM+8StYIqFWEJ3EMxH49V/f6Kk9TmS9SCbJsg2XMjDJoxzxad20YE32BtfdiUWlqaH@nongnu.org
X-Gm-Message-State: AFq9FYL3a/cKfhm9HqSd0aEoPWjEVCKQcp17Z3nkbqxC6Is5wbXjiVKE
 hP/BFG9ZhPpi5Jp6KOt5t2E4HbclAiRi+CsR2BnUhCtVcOLHgZ5vCd1iBZEnF9bMVjOW43L087n
 hMrwyzM/9J1NYXslnEyIM0XcdbrzW3NgKA0Uh5keaGg==
X-Gm-Gg: AYBFou3fRtuZMScCnPUGvguyhjSIUsGSz062qM62GTC3rqm7Yfaq3DrMecc0sQilz06
 xXCAn5FKHzaMOqZvtYL9uH36iwl3/mzqZikrrWIklPIMTFYz5FuAj7LfD9rxhpfiupRpJlMTAz3
 HulWOiB7COYbUhTtB5G1SrJFFqXcMMn78ZM4FhTIJ66Bbd3vI42ZnHJytH+6ASksQkwB2wq9DhB
 cGb0cod6tAOQrM/hbYhGqNBkrKdO2jJDEQsKiyL9OWar6wo/dSD9wkJDDa6KYJMRVS+hLwsuV05
 jfMr1w5ww7pC+VQrSaXi77TYQa3kuG9/4QWZCiQnC0cK1p1jiSX72l0Q+vkKybHwLlF1UA2kAJP
 oKI/g1ataPSUCeWdlbc+foOuMQRUIP5SPv/eUHbA=
X-Received: by 2002:a05:690c:9e:b0:8a9:a1e9:2665 with SMTP id
 00721157ae682-8b07d3c4195mr64805667b3.6.1792066949108; Thu, 15 Oct 2026
 05:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-15-khushit.shah@nutanix.com>
 <395b66c9-4173-401b-b469-8972b710aae2@redhat.com>
In-Reply-To: <395b66c9-4173-401b-b469-8972b710aae2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 13:22:15 +0100
X-Gm-Features: AclHuK8Tght3x1FGlR6vM-L7TqSFJaoIQpJthPwaxOxww4lF0LHqC4u2oGFG92Y
Message-ID: <CAFEAcA8DcLLYJeE_NUKrFTKfYvHp+6YYAmCdZnBfz2AjRNDnzw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 14/25] target/arm: add neoverse-v2-v2 named CPU
 model
To: eric.auger@redhat.com
Cc: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, cohuck@redhat.com, richard.henderson@linaro.org, 
 maz@kernel.org, oliver.upton@linux.dev, berrange@redhat.com, 
 abologna@redhat.com, jdenemar@redhat.com, gshan@redhat.com, 
 skolothumtho@nvidia.com, sebott@redhat.com, armbru@redhat.com, 
 philmd@linaro.org, yangjinqian1@huawei.com, shaju.abraham@nutanix.com, 
 mark.caveayland@nutanix.com, ping@khushitshah.com, sandesh.patel@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Thu, 15 Oct 2026 at 13:13, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Khushit,
>
> On 9/21/26 2:32 PM, Khushit Shah wrote:
> > Add a KVM-only named CPU model for Neoverse V2 r0p1 (TRM 102375),
> > inheriting from neoverse-v2-v1 (r0p0).
> >
> > r0p1 only changes MIDR_EL1.Revision and adds FEAT_ECBHB
> > (ID_AA64MMFR1_EL1.ECBHB).

> >  static const ArmNamedCpuModel arm_cpu_models[] = {
> >      {"arm-v9.0-a-v1", NULL, arm_v9_0_a_v1_props},
> >      {"neoverse-v2-v1", "arm-v9.0-a-v1", neoverse_v2_v1_props},
> > +    {"neoverse-v2-v2", "neoverse-v2-v1", neoverse_v2_v2_props},
> nit I would call it directly neoverse-v2-r0p1 and leave the -v<n> suffix
> for potential fixes. Same for r0p0 obviously.

I'm not very enthusiastic about accumulating different CPU models
for all the different rXpY variations that appear. We used to have
a ton of basically identical pxa720 variants and I was glad to be
able to drop those when we deprecated-and-dropped the pxa support.

Is any user actually going to care about the difference between
r0p0 and r0p1 ? In particular pX changes are just hardware
bugfixes that QEMU was unlikely to be modelling in the first place.

thanks
-- PMM

