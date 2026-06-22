Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E53FCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgZS-0000O5-TN; Mon, 22 Jun 2026 11:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbgZP-0000Nd-85
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:28:20 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbgZN-0002lU-JE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:28:18 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66058b880e9so4303505d50.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782142096; cv=none;
 d=google.com; s=arc-20240605;
 b=eyu6Ovkkg9QlGphcu1gOo3QXu/ai4uopUXNmXZi/SPRezwqvolAQ3qS1oHXEHlHOLE
 90WNSicJ5F3cSQAtarhvKM8Wo3QVJpoW7L+E2OlYQmgIfzO/slXb9DGBatNzkeP4WH0I
 /Pkdp1WTnXEDkBkLqnkWBKJBa1eTdnHSahUBMmGw3KLswxI8QQeDC+Nyg6m2RWmrR8TJ
 mOVVAku0RhLHAet1mvxfxhky2HUczP8x9kxBC6QtnhHmcVaJZxxen7kDKGNuDCgnQ2oc
 FViPV0rlyj+n0nEwxolL8rLmjQ1Hurc97ZNcudZI+uVMXwl1eBYrMV/Frwcl/zVhzUPI
 QJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YgY71jmEy523WMOXI3xfJbJyzaQDf9J4mOIspMa2IPE=;
 fh=SfZs/aFWZf65gPOALFTveYTSccEi7xdfl90u9mId6+g=;
 b=gugec9coCUJArKCxiq8xfqBoSIll2dE/isIpDbBwTvnGrSxxHqMIOstty1Ac1nj3oN
 dT+WXt05Lq6TwoRCGhxpvsy5vV40/K1yHRPJyN4WckDcH5THrQTjqIpK4THDDk9/6hZV
 9aoqUlVifJ0YC8ab0yN7K7+ooU5NqyzH6rw1KLpKc/YgiJQIfLwOvDmdLRpkO1KKaMBl
 95Sx98ckVj/rGElijmh+GZzxGIIFLfV/YFbZ6PnTRb8BkCZjPRQ27V7mLGX2VXO1sgCJ
 6zGJw2eGRKNGknNYVV+Z753XxTyMHtwM7SB4zgnAXzd3VEGP57NlVpvvH2iZF11hxX3e
 Cb8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782142096; x=1782746896; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YgY71jmEy523WMOXI3xfJbJyzaQDf9J4mOIspMa2IPE=;
 b=nOAGMj+6eRk0Mkl2eHiNKvCt/ZQhvyLrZdL2XKnwZXkJKwJNH09okFJPLCeUlxftHY
 POWHvcfcUuC4h3tinuPUnNeNMeSFpp+fTnPg6ejok6SSAsCB0qjPjvaabMworDtZq8xc
 Uq2wg7hlfbxAq7IhRhZx3/QC7inRSg2U87WUUTHj0q4iXCpc1Ibifmn2deA/X0yW6nM7
 kHGlUftvvb16ViXEXAa84EuB2p04zHQsEd+gDy2RB7lU9a7/SR29Ue6cobffHmZyH50L
 pz3USc/2cW5CCRGrgPpbn7wU0lfFgCra+BqWQlaPP9H4yg9aI2qC8et2f0sFZ/nX8mTm
 lvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142096; x=1782746896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgY71jmEy523WMOXI3xfJbJyzaQDf9J4mOIspMa2IPE=;
 b=dbhKp5L8tcR248sa8vgyLt5DSfgeu96LO1cAsGaAXoML4EOJhjo80F/eDOuGfckSEg
 MFQURnjB1Z/izwP7TvVdhepOuVBFWi8VQfHqe8NNp5yTp5t4fp5JhA0YUML4gq7IvzpV
 U/fwJAkOfUXH7/Ebq5XK1b12YeyV0QMDYtCm+ltAl778II3mhTyhzXOWqkFsTYTXx/Sp
 Q9eCYG33aol5iRoY8/nbW4x1XNVZeUAF2mnK9Uopay939hdTEe9A4jv4VI6OCPUOROfg
 uOJie1FuF6gqEG0H6YOUdkQcROdVWY4OPR1AO4mzY66Iq6TTTZV1YiQdVMFUH9H8o5Q3
 t9WA==
X-Gm-Message-State: AOJu0YwNGjnixUCe6Gx2g/ape4EJgEqSqkoo2sS+HVra3Yqx4l2fiKJ/
 qbAsoiYidt4i8jFVStiLX1skWs3BfnTBf1TiVxtWl7k3gH9CX2s6gkMkLi/f90Y8HQOB3n24Rs5
 iEAc6ViUk3EZaxBBn/RNkojFkn0UT5vkwwDVgpyMEDu5C3jv1ixMhDrQ=
X-Gm-Gg: AfdE7cm249vY5Az5db0xsQ+SNVYGugmvkSfzfTZXrTJY/gPNn+g0xZy1GPyCu0rE9kR
 xqaYDyrkWiqBD21hCyFNliAQLHP7N906TRdbeZkqxqM2gH94IGLgod38rtCqi9pQmCxEzvfBM9H
 bDmnnUEChLOn5IOPzzZf1PPtIo5dJ6muiSLsVS9A81nliOSsti9vl0qo2P0YQyadCOQ+ce2eitp
 Hjn+LeVwiOz/QZcHo3od6Ha1Zu7dafWefk1kXiQZX7IVt2kSHpKGbWCEP8L1XPvoEUXx4aj6Bn1
 FFcOcnKGaPgy5hfFepnBs1Tkg9O4r/Beq1SEgQiPFqCXSQztUdTscn1O
X-Received: by 2002:a05:690e:e83:b0:660:4ae6:9638 with SMTP id
 956f58d0204a3-662fcb7d02amr15424653d50.54.1782142096087; Mon, 22 Jun 2026
 08:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
 <20260616190639.3462006-33-peter.maydell@linaro.org>
In-Reply-To: <20260616190639.3462006-33-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2026 16:28:04 +0100
X-Gm-Features: AVVi8CdpvkwiQ9irFdUQZCkQQHgC9pl_jnQcezvZPvRzQLIkrJqhxxJ0FQdqs3E
Message-ID: <CAFEAcA8pxFUnqAxa-ngjQ2ALDkJ-cjXsA66HgfisvRU_sMiwCQ@mail.gmail.com>
Subject: Re: [PULL 32/61] hw/arm/smmuv3-accel: Introduce common helper for
 veventq read
To: qemu-devel@nongnu.org
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Tue, 16 Jun 2026 at 20:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Shameer Kolothum <skolothumtho@nvidia.com>
>
> Move the vEVENTQ read and validation logic into a common helper
> smmuv3_accel_event_read_validate(). The helper performs the read(),
> checks for overflow and short reads, validates the sequence number,
> and updates the sequence state.
>
> This helper can be reused for Tegra241 CMDQV vEVENTQ support in a
> subsequent patch.
>
> Error handling is slightly adjusted: instead of reporting errors
> directly in the read handler, the helper now returns errors via
> Error **. Sequence gaps are reported as warnings.

Hi; Coverity spots what looks like an error here (CID 1660057);
could you have a look and send a fix, please?

> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
> +                                      void *buf, size_t size, Error **errp)
> +{
> +    uint32_t last_seq = veventq->last_event_seq;
> +    uint32_t id = veventq->veventq_id;
> +    struct iommufd_vevent_header *hdr;
> +    ssize_t bytes;
> +
> +    bytes = read(veventq->veventq_fd, buf, size);
> +    if (bytes <= 0) {
> +        if (errno == EAGAIN || errno == EINTR) {
> +            return true;
> +        }
> +        error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
> +        return false;
> +    }
> +    hdr = (struct iommufd_vevent_header *)buf;
> +    if (bytes == sizeof(*hdr) &&
> +        (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
> +        error_setg(errp, "vEVENTQ(type %u id %u): overflowed", type, id);
> +        veventq->event_start = false;
> +        return false;
> +    }
> +    if (bytes < size) {
> +        error_setg(errp, "vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
> +                          type, id, bytes, size);
> +        return false;
> +    }
> +    /* Check sequence in hdr for lost events if any */
> +    if (veventq->event_start && (hdr->sequence - last_seq != 1)) {
> +        warn_report("vEVENTQ(type %u id %u): lost %u event(s)",
> +                    type, id, hdr->sequence - last_seq - 1);
> +    }
> +    veventq->last_event_seq = hdr->sequence;
> +    veventq->event_start = true;
> +    return true;

This function takes a buf and size that it will read into. It returns
falso on various error cases, and true on success. In particular,
"didn't read exactly the requested number of bytes" is an error case.
However, it also returns true for EAGAIN and EINTR, having not read
any data into the buffer.  The API provides no way for the caller
to tell the difference between "successfully read the data" and
"you need to try again later".

> +}
> +
>  static void smmuv3_accel_event_read(void *opaque)
>  {
>      SMMUv3State *s = opaque;
> @@ -448,39 +486,14 @@ static void smmuv3_accel_event_read(void *opaque)
>          struct iommufd_vevent_header hdr;
>          struct iommu_vevent_arm_smmuv3 vevent;
>      } buf;
> -    enum iommu_veventq_type type = IOMMU_VEVENTQ_TYPE_ARM_SMMUV3;
> -    uint32_t id = veventq->veventq_id;
> -    uint32_t last_seq = veventq->last_event_seq;
> -    ssize_t bytes;
> +    Error *local_err = NULL;
>
> -    bytes = read(veventq->veventq_fd, &buf, sizeof(buf));
> -    if (bytes <= 0) {
> -        if (errno == EAGAIN || errno == EINTR) {
> -            return;
> -        }
> -        error_report_once("vEVENTQ(type %u id %u): read failed (%m)", type, id);

Here at the callsite, we used to return from smmuv3_accel_event_read()
without doing anything for the EAGAIN/EINTR case, report the error
in other error cases, and continue to smmuv3_propagate_event() only
for the success case.


> +    if (!smmuv3_accel_event_read_validate(veventq,
> +                                          IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
> +                                          sizeof(buf), &local_err)) {
> +        warn_report_err_once(local_err);
>          return;
>      }

In the new code, we report the failures (good), proceed for the
success case (also good), but we now continue to call
smmuv3_propagate_event() with an uninitialized buf struct if
the read call returned EAGAIN/EINTR...

> -
> -    if (bytes == sizeof(buf.hdr) &&
> -        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
> -        error_report_once("vEVENTQ(type %u id %u): overflowed", type, id);
> -        veventq->event_start = false;
> -        return;
> -    }
> -    if (bytes < sizeof(buf)) {
> -        error_report_once("vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
> -                          type, id, bytes, sizeof(buf));
> -        return;
> -    }
> -
> -    /* Check sequence in hdr for lost events if any */
> -    if (veventq->event_start && (buf.hdr.sequence - last_seq != 1)) {
> -        error_report_once("vEVENTQ(type %u id %u): lost %u event(s)",
> -                          type, id, buf.hdr.sequence - last_seq - 1);
> -    }
> -    veventq->last_event_seq = buf.hdr.sequence;
> -    veventq->event_start = true;
>      smmuv3_propagate_event(s, (Evt *)&buf.vevent);
>  }

thanks
-- PMM

