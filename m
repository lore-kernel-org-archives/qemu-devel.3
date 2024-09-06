Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808E4CE7B1C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sma72-0007DB-LM; Fri, 06 Sep 2024 10:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sma6z-00071M-Ka
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:38:57 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sma6y-0007i4-2l
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:38:57 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdbe4728so2269951a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725633534; x=1726238334; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UpT+1Xnzg67oQCE2zwOfiRC59zjDxX5+2pJE4iperas=;
 b=uchWggHJp6jIPU1qRD0idjsBOdl6DRNXRRi2pdFZdrjIhk8UuTdgZYj9FK2lE01gkS
 Y3dw46f8bjZ3XfdOjKdCuEn1uP+jtdHcHfdw5b/a9CWzbFKgXHwWeemnb8RKZBxRl1e1
 yRAibAQ6AEx91FFF4uVusYjPlEUiYGVFVpKuVY488sbGmbQExK0zzvZL6V06wu9KFRZ3
 +8OrvsGGnokN04IVWCA/nv4/YEM9mb4gpROMs+Ugtq2uba+6ACcM2LTOBqKe/LnZQ55a
 QEOofzP8lVhDC2BNlc1XJFy7g/873ntgsWZ12CNljFgasdFld5jKMbBPK4TTe/4hdjwK
 6nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725633534; x=1726238334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UpT+1Xnzg67oQCE2zwOfiRC59zjDxX5+2pJE4iperas=;
 b=pu4oLjzVck04CHMyyOn+ptnx1CMjOYn0S8CIwUPt/Ol3x6BGGiagTcFKSQ73FYRcXz
 wjCb84ghrhHkykhtyJHfZeCORS7HVM4qVI0kJvuthuQOUyrVb05Py73MNFIcJCBi0fNK
 cKtT+lhD3hTotDQLH1jSeUfrYIRNP8xp9wKuxthCPw9V5jrxh2O0muFZWunLV36n+6wL
 81/pZ1XCdKZ52vd01XMssrdRYJYpbZenjFgD8Tp/6WrHEN9465WAohlHsIJTl0EFsDl5
 zIBZ0C6PFztQvsylOyx6D1iw3mzoDnfuNYwLSXiRWx32iiBcDGs3mfLHOyBJOuEx1QHQ
 qDqw==
X-Gm-Message-State: AOJu0YzxWlD3q8iy43kyhdcFiNJzFTBuXMhWepFx9ajcb9ANbxXkxHIN
 PUnq+M0Hc38U/mMVhCsIrwi8A0gd4OvYYWWjhj8ApPZhed9c3UXuxod7upTy4GaOT40TTlnZl1Q
 w8/VJNEz/GNxW3hx+uLUK5EdgeMOopbyX0Whzomp8jls1qKSt
X-Google-Smtp-Source: AGHT+IF0euAg4r9ZhgE/+eDjdxNk+aBhyuYm6RXFENTmtKsciPtnkEp9ohthQAp0mpSI167JMRfaSRVoC5MB5YpOfwI=
X-Received: by 2002:a05:6402:5109:b0:5c3:c4d9:5e18 with SMTP id
 4fb4d7f45d1cf-5c3c4d95fa5mr4233013a12.38.1725633534170; Fri, 06 Sep 2024
 07:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
In-Reply-To: <20240830145812.1967042-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 15:38:43 +0100
Message-ID: <CAFEAcA_pHTRTDwH0dG3QAKx3x9xdJgG5xtrwo5diV6QgBqf+8Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] s390: Convert virtio-ccw, cpu to three-phase
 reset, and followup cleanup
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, 
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 30 Aug 2024 at 15:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The main aim of this patchseries is to remove the two remaining uses
> of device_class_set_parent_reset() in the tree, which are virtio-ccw
> and the s390 CPU class. Doing that lets us do some followup cleanup.
> (The diffstat looks alarming but is almost all coccinelle automated
> changes.)
>
> Changes v1->v2:
>  * new patch 1 to convert hw/s390/ccw-device
>    (fixes bug discovered via s390 CI testing in v1)
>  * a couple of patches are already upstream
>  * in the target/s390 cpu patch, fix sigp_cpu_reset() to use
>    RESET_TYPE_S390_CPU_NORMAL
>  * new patches 10, 11 which take advantage of the new function
>    device_class_set_legacy_reset() to allow us to replace the
>    generic Resettable transitional_function machinery with a
>    simple wrapper that adapts from the API of the hold method
>    to the one used by the legacy reset method
>
> Patches 1, 10, 11 need review. I believe that patch 1 should have
> fixed the intermittent s390 issue we found with v1 of the patchset,
> but if you could run these through the s390 CI again I'd
> appreciate it.

I'm going to apply this series to my target-arm.next queue.

Let me know if you need more time to CI/test/whatever it on
the s390 side before it goes upstream.

thanks
-- PMM

