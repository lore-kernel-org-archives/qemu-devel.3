Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CC0E98E11
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSfT-0003ow-91; Mon, 23 Feb 2026 04:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuSfI-0003Zo-Pd
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:55:51 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuSfH-0007z9-2O
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:55:44 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ad2a2851cso3339460d50.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 01:55:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771840542; cv=none;
 d=google.com; s=arc-20240605;
 b=QrMNAtQ/pifc2ZAtCsTVttE0mqJlNRWRo/YengbNlK2sHQy+6vnnUnGike/lY8JSFq
 KdfIAgWZKIGWTnghWeh4a8Dc1PPjX7G+2QCH7ansy5UJpOZucFefdv9l6ZdEs2zsFXRd
 s2LrTi8IFc2DRwTM9tRtnSCURr3ndZUiEMC3Xnbc7+VNKYd9rdiXuOjQi6RjGma1X9l6
 Xvwyz67+nk5fRtTG7rLkkcgMCJCKBSDDScgDUMph1qAMHEwyOkYl6gRD3lNHdE/fNdm8
 Sdx+d7JWKsOGjG4X5bgdq3zp3L7jU3mL96JGUIdBnZOf2w3OER37jM8dSapx2iL3vZFS
 OHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AVlvhlHPrH543bH24rKedyPuXgT1j+euRQ4we4/lDsI=;
 fh=gMjfbdOkdsdyugoyuRb6DYWE7E1DjTHLX9jbWQ8ybu8=;
 b=X17OC7EG+g7sF7XH7RIIt06ZvaISOrYRCbiGWd670HfYN1bBdRI9weU3NaGhge/68/
 f5MSgZLmmiIK96pdSQpIm8bhmSHG+V+GOkpNhwbc3D2n0S5EblWRzB5h5jfLmQ+y9Wa9
 LdPuToL58bA1TpdSXrlPQwkbQ2QB46Qe7wot8XH4orWM+h2VPlwju7c85gb7uujmXFSO
 K3W5z/akayx1f9FQ4bEWTwrjMpAGt72Uayx6VxWGw5Tu+mZ1fhpt0UFNH+tVGobWW2rX
 Tt4PvUGEaocoZKe0IncItoVJ/mfKaT4eyYqTsMtg4ou4/dDr7e0oqu0Sxs/UMwgNKtap
 ZoVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771840542; x=1772445342; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AVlvhlHPrH543bH24rKedyPuXgT1j+euRQ4we4/lDsI=;
 b=y6PpYqvOfWcDtkqm4HbtuMOaBmFBKoc7p4Ny4XEijB9LhsVB9S9rHYEt3yq9ML5Y/0
 WI/d17BiwgZnQJwVLeJgFVDjL8ZshVXdnoIMNPlJkRuYhjBWqJzctO/gWk5RP6bewJGx
 aCkmWKfccwxL5LHUkOnYbL0OKZD3pLIzp78bGt/Rpqt4b0dw8U7fNW8yOGRIDO68Q7s+
 2po4QdirLVR0h0bar/KkiCuvJsnZ7GoLvO9xbm0iNAxGv4hF9vjgt+J5eTF5c9r1YX8X
 ZCDG3qcLASlg/ErvTPYNDMLmkl1vigTeEujnmWdwU24i7M44iH2t4zKqLmqDKMbISsuH
 NEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771840542; x=1772445342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AVlvhlHPrH543bH24rKedyPuXgT1j+euRQ4we4/lDsI=;
 b=cvlfJga9F5ztBd3Zk0UuDd63h8yCbC6iyFyg/tYY6PKeVhxNsI7cXLUrBMPn5XDmkx
 N5dzlPDH69cc+XJ+NnHIjPzDROgSzUK9I9LDydGhOGVducSwrM+xLNuRWINiwdqlyETH
 zzr/6pFLKOoS77NujN44+2pnrLc4yZpwzZ2hJp2XdgcIPe4Gy+yA8yPitHLPJs6hp2BZ
 sGs9JsjnqgsTi6pSvaORbGH6/AANZ1QphXkT0hTZ2gUGl+vg0O/vM5JgWCOvrZrL3n9m
 /oqt9zRby560qbyYYCMFNdlHUYL27ZhdFINu6VGHggCMVGDPCODL4VvYWLd9KMNeIgw1
 umrQ==
X-Gm-Message-State: AOJu0YwZdxNuHqkH0sZcAMm8dDa3ird2BQ5p52EWQjnzT+5Jy3WAFp/T
 9NO4rqU9aU6TyWxe8859ybQ3yEswMY+pMjgLa0P3xyV4dMZIg/+/1QnCJKMtW90hG2mjRokTDh5
 mwA0iIR9ZlJPPQ6H8bTK6ZdzQjeUp2PemkJCJU+FHrXQgrQ+TutJ+
X-Gm-Gg: ATEYQzyqWILq76SFyh0k8TBw6nHVkuk4jC423NwIDob5AVjcD9GuCFf2UWn6SXoM8n9
 vIeXEeDby3AeKEJMtdBaYyU/nSvavD7c5xV1wKv6LT4rL/50iaIutdpaAMIakrqRvIZgU6Nh1Kx
 czqiaZwh6B2WtF2lgy5KEODDvbxZulj7JWmxQ9cDdm3J0jdQ3Z4sRhLUpaFMBmhsGs/qD6cSdIv
 eu7DYRZmWcn9d/rYDm2PRhUHQW2wQRVekjgzPxkccqEl0lDmh+241RKJi//xGlxj8rgZ4oJr1jV
 phOiNvWu7nq0HWImiuNk86ex38apIXP9FAIP4tIrEkdtTzA0zCkvo5uEbHYqlmJxdgA=
X-Received: by 2002:a05:690e:e8c:b0:645:591a:cb6a with SMTP id
 956f58d0204a3-64c78f6fcc6mr6574397d50.70.1771840541864; Mon, 23 Feb 2026
 01:55:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771770471.git.mst@redhat.com>
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Feb 2026 09:55:30 +0000
X-Gm-Features: AaiRm51bWJ0QsNOcnV4uALKvkaYdbNOr5Az8lbWw3CMVwQJkNLzMzy_O8mGHILU
Message-ID: <CAFEAcA80CCL7=iLef5SSFSgUqQPXawdqaH46imNb4StSxEMZNw@mail.gmail.com>
Subject: Re: [PULL 00/33] virtio,pc,pci: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
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

On Sun, 22 Feb 2026 at 14:28, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 07f97d5da04a9f97e273de85c76f5017d8135a6e:
>
>   Merge tag 'pull-target-arm-20260219' of https://gitlab.com/pm215/qemu into staging (2026-02-19 10:36:06 +0000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 72f663f575ab5e0f31320d7c9f25cc1f086313bd:
>
>   vhost: fix vhost_inflight_buffer_pre_load (2026-02-20 13:04:45 -0500)
>
> ----------------------------------------------------------------
> virtio,pc,pci: features, fixes
>
> cxl:
>     RAS features
>     Back-Invalidate
>     Flit mode
>     r3.2 spec event updates
>     FM-API Physical Switch Command Set support
> vhost-vdpa: allow GSO for SVQ
>
> misc fixes, cleanups in intel_iommu, vhost, virtio, acpi
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

