Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6FCC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 09:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtlfl-0004L8-TW; Mon, 08 Apr 2024 05:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtlfh-0004Ir-Cm
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:52:13 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtlff-0006LE-Ay
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:52:12 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e346224bdso2258701a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 02:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712569929; x=1713174729; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S00HnoPgZTCHav0ogGWnx0fkG14NsNvYkf8qmSwJQHc=;
 b=GHjKurrK5JMkMWcTCvW0YADZCptFXgF1Fp2mDZDlqYsCryS49h4RBkrZGn0jODVYAL
 q4JKm1LlgY/iDbsQrv2pbOIqafb3rezK3j2LfM5AC3aW4mfogJuEywtMpL6s5PWbj74G
 tK3Mq2Koy8FMhdJL/t7eKX9ciesPJtrUjlm3fQIikFSKKNm/gJDuM7+TQgytSMGc+vki
 INO2xFswCVubaxdpEnR/kE8X/MWTTaMje9tceXCuo+IH8OdiwSrgVs+rZRzSlme4w6A4
 QvqdXb4iZxLdkI9gxyNCo30yYGNB23GqHhJmd/miYdDodlfrLs7w5aO468eVcQ3Wz8Vi
 kz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712569929; x=1713174729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S00HnoPgZTCHav0ogGWnx0fkG14NsNvYkf8qmSwJQHc=;
 b=LSHQFYiTNEVBdwo0LmjOapS0/k7VLAOwrTk99Qu+r9B3Ng5Ih+w5VLknpsMG7w7uf3
 0z3cezZwH6MMKzAIrgnf7GiJaNNZpOeDc0dv8ZNrq8qJC2u03HNvDFwq/xtfrYqiYaVI
 SjuDY5qJrJ6WgDJIFi01FKX+ZKLDA8CIS9lUuAozpjJYv+v9/4Vt3g20d5tpd4ZXUsbS
 xxu9n202o7lSt1d2v52j0UrOb6/ihbk7G0AyJZf/WzhzItwv9BkfOgZGWK/fjwjrQuQI
 nn+JSIOZFHN7D9m3QYnYSY2bH6amm8soGLfE/Z2StqBI/DeBLCp0HaEugvi8rYOS46dk
 NNaA==
X-Gm-Message-State: AOJu0YwRvWtljWanNB2C8XJLDitslzhc4WIsmWp4nP+sxMGCOEPtuP7W
 +2Q7b4dPsiXe7Dx/CdanlQuKvZ1XdeoggxZtlLqOWPM1/Gtj6pDHlH525tKMY8UbqZ1Qxbdko+a
 TBOYav8sYtvvIjjxwlSo6lCyoCUyy4Oj49uYlWw==
X-Google-Smtp-Source: AGHT+IFWjxhF1+HJMyd5/BUGlwg1Zae5/3S0wU8qEaVyejPHVGfVQOop8mtbSQ4T4lmeMN3+GRsCDpnOKu4y4Cf9j2U=
X-Received: by 2002:a50:8717:0:b0:568:d757:f7d2 with SMTP id
 i23-20020a508717000000b00568d757f7d2mr6288359edb.10.1712569928711; Mon, 08
 Apr 2024 02:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <df6b6b465753e754a19459e8cd61416548f89a42.1712569644.git.mst@redhat.com>
In-Reply-To: <df6b6b465753e754a19459e8cd61416548f89a42.1712569644.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2024 10:51:57 +0100
Message-ID: <CAFEAcA9_mLQ=jWNEHBVLJKHST4X=QVdpgPCTh1mRSSiea7ruzw@mail.gmail.com>
Subject: Re: [PATCH] Revert "hw/virtio: Add support for VDPA network
 simulation devices"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 8 Apr 2024 at 10:48, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This reverts commit cd341fd1ffded978b2aa0b5309b00be7c42e347c.
>
> The patch adds non-upstream code in
> include/standard-headers/linux/virtio_pci.h
> which would make maintainance harder.
>
> Revert for now.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Are you intending to target this revert for 9.0 ?

-- PMM

