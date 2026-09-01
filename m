Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771F6C61DFD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Et3-0004BQ-Gl; Mon, 31 Aug 2026 23:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1x1Et2-0004BD-Kq
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:10:12 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1x1Et0-0007wa-FG
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:10:12 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66e63c2c9e1so687033d50.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788232209; cv=none;
 d=google.com; s=arc-20260327;
 b=khEbzTGyXMmDmCyJgmTEQXGNlTqtzp1QvGTLWkR5ISNpPrIxgGTHwibRm81IeRamy0
 PLCCguP6s5IrAnsNqU2UNQ7ejgaSaEkHHp7Rafkcf3Pti/cNzQqETpS9zaFgetCzstM5
 SAS0XNWWkvR47u9FXbNFD8e6OY1ZUSSZtyxUSiOQw3kU8aEBuJoKVyQ+RXm0zZX98OhV
 cT9XAqwjappLSvFammiA0cC3TUIM+Utulmxmy6oBkW3EH4lV8euA1SJPZm1t/wqlYwL7
 koWKTs8Cbirc/8pDkoeRjS4Xwc62Y3oWmANKoOV+jO918v6J40gHqjj9wUvvtHUK1aXl
 SutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nyoKXzipBbkcieAk15cRkxexlFI1yA8Xw3DnSBh5d5o=;
 fh=3TRS+rlaId+jTU6iFVW41C5U0GrHFoi0R3+w3Ibi0UI=;
 b=hdboi8xoBVr1HqryNLVcteDylOERJxQr7igSrIuYAEr/eswxzf1WNeMx/ohExx1xea
 j5Ptmj5hQwN4FOGR3OO8lx0Gh5e+u/Q/v7+t2KcedR4zb8SO24rxSrgSwm1I8bUZlXla
 ybE6FEZwiyUuHl48oSP0F1dUB3TQHEEXXbbBlJKBkvn5+Kxb8xnQSSkumIlnZLwmRFXL
 jBS7iJqFL7V5AnBRr7YXmgk4ZwlQeiMmGyMGIZBy4A9/5VtF8sKp8QJ7cNZbzz+KcNer
 Y7dEcKIX8xxzClmQGpkPRxZF64q7nM8gywPHHnoR6Crf0G11Qd52xPvHeRV+MuFAnoX1
 iiyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788232209; x=1788837009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nyoKXzipBbkcieAk15cRkxexlFI1yA8Xw3DnSBh5d5o=;
 b=nE6esoK1g0e8vRXjFeYMigsmcYXZ1JBVn5vZfHi8TSDV52IRrd0zMCgHsu2ktIdIgl
 DOyxkb7ZjEyWL3AaUWZZesojHF9zLlaIX9jyQCJaSYhdn8Y4RXSdsZbyfJB6/9+WX0Zc
 kd0RFrePLrr5vTMdDmrw82/BHrrtKl6kegbGSN4u8PI5AudBp/0EcX98m4p1aeOfo139
 1q57Z1y4grIs9o1sc+m0PK03jqntfdzvVxcF6kzdRd2gmnDmjCK1oNeoCQn+iv9vxx9b
 rULeOVasNCpqn94zSk5B97go3C3FPMTptULjB7G+H/tZPL+eGlCyr52AH3QN1lLO62eU
 iSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788232209; x=1788837009;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nyoKXzipBbkcieAk15cRkxexlFI1yA8Xw3DnSBh5d5o=;
 b=N00NBFG6rXReqa/z0MnNQsFNz+Fytqbr9fclCAEyoWUYMuXV4MwmCZgJGfzdJh8oLx
 OJGXjo+zJu0+v8kA7z5DmV+wTk1Lzf4Kmp+UgVq6mg7tQaPoZsOAxwPc1WS4rieq/ROz
 ePaVVBpF/af6siTp317BeScuYNoTccYVhbiuU/NdQz6YUnj5FHjHGqud8dDDDM1KfvwQ
 mvmiFdH7VUPXdBqQ/pA9u9lC/oJ0qkD6roA8MbnBudjanBGN73UF4gALMQeDX9rSLQ/y
 NTLJLHegJ2i9Z7GPGQ7ZzVMtwr/hduVSYWSO4AjPMgqR9rsuvyopdkuUwtSt4oboH0ht
 ZhvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwMVtCeAMHcBkGEbxKB4n7sEmA3wZVsYPqzmXSCuPIGuhOJ3bU2x/SxOneEhihgqx3ri+qIrQjKras@nongnu.org
X-Gm-Message-State: AFuF++nXok/sz+eTnVzYhRXB64b3eaHPkCX2uWIfcbtGTptkQCT2F2bz
 L3AKZUGFchO10If0ci0dzfX8XAMD8nlrDqlxPHvaeePa70vXu5nDgLU3DYZTWPUgy+pHPH1Q3u3
 CIjYBu0+y9JLkRSW4RcrBp7vZ7PpGoMc=
X-Gm-Gg: AYBFou0C2TvGzJoj+1OjwQB7eFw+8kEiB2dVAnTBwHGkUS/iIkX7NVsrEs20zdiJfl9
 Cpve5RnWQJYyw6VVuH2sRsG55EMDSTY1TvDkYZbZoIJODJEXk8ITmumPNzGlDs78W2NBsCzXmbI
 6py1TXjKkMFKGDlM8TGxyNyhphVJ3U5Lo4Scu5OI0gFBNDCMpGwFay0zwE6Jy9fBBLteqdiWXhD
 lj3dMkVomWlorFVm10cNzU8AQQR23gaW13+SxoulfxcIH+eGPjwaAku2O7mU4a673pzfVguHLvz
 hk5oZghQvPabKCQ4AwtdfyxQUbbcyvimB1JHbCq7t0sTOgMzQnjxjw==
X-Received: by 2002:a53:a648:0:b0:66c:e21d:9ada with SMTP id
 956f58d0204a3-66f8a499108mr612983d50.10.1788232208732; Mon, 31 Aug 2026
 20:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
In-Reply-To: <CA+AFTT-iZ8wbUOkEaU_SCM0rnqRJsefkOr=CTgC6T22nz_ZFoA@mail.gmail.com>
From: Huiba Li <lihuiba@gmail.com>
Date: Tue, 1 Sep 2026 11:09:56 +0800
X-Gm-Features: AcwNN1VpLguGuzN8CIs7UFmH5KetcyriWONaVWK2ZTM6Y4hmBdgpdAkpLukV5uo
Message-ID: <CA+AFTT-8odiRzg8mcnZiEQTyTiMeK5rHUFB6an+6wFgYLtyh1g@mail.gmail.com>
Subject: Re: [RFC] block: add an overlaybd image format driver
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=lihuiba@gmail.com; helo=mail-yx1-xb133.google.com
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

Hi all,

Gentle ping on this RFC from Aug 18.

In short: overlaybd is an openly specified image format (CNCF-hosted;
read-only blob stack + writable top, O(1) lookup regardless of chain
depth) deployed at scale for container/VM image streaming. The RFC
proposes an in-tree C block driver, starting with read-only support
(index merge at open, raw + ZFile layers), writes handled by a
qcow2/raw file on top.

I'd especially appreciate thoughts on the four questions in the RFC:

  1. Is a new in-tree format driver acceptable in principle?
  2. Is read-only-first a reasonable initial scope (with iotests and a
     docs/interop spec page)?
  3. Remote blobs: compose over block/curl, or fetch in-driver?
  4. CLI surface: point -drive at the OCI-style JSON config, or
     per-layer options?

Question 1 is the main gate -- if in-principle feedback is easier to
give than a full design review, that alone would help me decide
whether to proceed with the first series.

Thanks,
Huiba


Huiba Li <lihuiba@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8818=E6=97=A5=E5=
=91=A8=E4=BA=8C 17:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> I would like to propose adding a QEMU block driver for the
> overlaybd image format, and I am looking for early feedback on
> scope and design before sending patches.
>
> What overlaybd is
> -----------------
> Overlaybd is an open-source image format (https://containerd.github.io/ov=
erlaybd/)
> hosted as a sub-project of containerd (CNCF graduated). A disk
> image is a stack of read-only snapshot blobs plus a writable top
> file, in a layout compatible with OCI image registries: a base
> image is stored once and shared by every derivative image, and
> data is fetched on demand rather than pulled in full before boot.
>
> Two properties distinguish it from qcow2/VHDX/VMDK-style chains:
>
>   * Lookup cost is O(1) in chain depth. At open time the per-file
>     indices are merged into a single in-memory index (an
>     extent-based log-structured merge tree), so a read never walks
>     backing files, and per-file index caches do not multiply with
>     snapshots.
>
>   * The merged index is small (about 300 KB average for 50+ GB
>     images in our production data), and because extents are
>     variable-length, writes land at 512-byte granularity with no
>     cluster copy-on-write.
>
> The format is openly specified:
>   https://github.com/containerd/overlaybd/tree/main/docs/specs/lsmt.md
>   https://github.com/containerd/overlaybd/tree/main/docs/specs/zfile.md
>
> Reference implementation:
>   https://github.com/containerd/overlaybd
>
> Overlaybd has been in production at Alibaba for years (Taobao,
> Tmall, Alibaba Cloud, Function Compute) and is used by Azure AKS
> Artifact Streaming, Databricks serverless compute, and several
> microVM-based sandbox platforms. The design is documented in two
> USENIX ATC papers (DADI, ATC'20; FaaSNet, ATC'21). I am one of the
> overlaybd/DADI authors.
>
> Why a QEMU driver
> -----------------
> Today overlaybd images are served to VMs through a kernel blk dev
> and a userspace daemon. That fits container workloads well, but
> a native QEMU driver would let any QEMU-based stack (libvirt,
> KubeVirt, OpenStack, plain qemu-system-*) boot overlaybd images
> directly, with QEMU's usual amenities (backing files, block jobs,
> throttling, migration) and no extra daemon on the host. This is
> beneficial to agent sandboxes.
>
> Proposed implementation
> -----------------------
> A new block format driver, block/overlaybd.c, written in C from the
> open spec (like the existing vmdk/vhdx drivers) rather than binding
> the C++ reference implementation:
>
>   * v1: read-only support. Local layer files, index merge at open,
>     raw and ZFile blobs (lz4/zstd are already optional QEMU
>     dependencies). Writes can be served by a qcow2/raw file on top,
>     exactly like booting a read-only backing image today.
>   * v2: native writable layer, and lazy fetching of remote blobs =E2=80=
=94
>     either composed over the existing curl driver or with a small
>     built-in HTTP fetcher; guidance welcome.
>
> Questions
> ---------
>   1. Is a new in-tree format driver acceptable in principle, given
>      the format is stable, openly specified, and deployed at scale?
>   2. Is read-only-first a reasonable merge scope for the initial
>      series (with iotests and a docs/interop/ spec page)?
>   3. For remote blobs: compose over block/curl, or fetch in-driver
>      with a local cache?
>   4. CLI surface: point -drive at the OCI-style JSON image config
>      (which lists the layer blobs), or expose per-layer options?
>
> I will write the iotests and the docs/interop format page, and add
> myself to MAINTAINERS in the first series.
>
> Thanks for any comments,
> Huiba Li

