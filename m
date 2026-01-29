Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE64D6101A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 14:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTLY-0005UW-42; Thu, 29 Jan 2026 09:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTLV-00052a-W1
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:50:10 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTLU-0006sZ-Fo
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:50:09 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-790b7b3e594so11008797b3.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 06:50:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769698207; cv=none;
 d=google.com; s=arc-20240605;
 b=i9yXmS9kAIYhANjmcplWAY3+wHpJ8xH8QBn9NB7aHFrRkHyzChLuyQ2bYmONTqfxWf
 Y3Y2adjxNr8Vke8HjCG5ANvft1NTU+9FOXf8T/yu/o8TpKBMgmoRAbLAM+KILBPhZ/TE
 fKN96n/F/xIyAW//Os60CGdDIjoo7urBpVEOt+rXkC8SK/VjzyBYzuwsAVcWxs+3L2OM
 8QIpzCZOoLo/HyLuHU6vvmaFC200gNFLpRmFnwWyD3oVY3664yzBWR7QcUjaBtUx5cIn
 P2kERpvZs0CYipchpJAVt6XLNhu1fmb7S8IMQfI3G6PY8gYCTFznVL09Nz98s6vjc2LU
 2Xhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G102y0G+FgpeT9KmYnieigLXgmRkgBeE42iRMbIJv4E=;
 fh=Tivoi3qbRP2le8EeVEErtzQyTzqfkh3HP41qKk3s5Tw=;
 b=devfl6/Z+GAi0FPmAeFXHrjP5tvalWi6Qd6duWJebJfdhr43WZ1MTvIacazL0wPJdf
 sMSb2/MPGIawtFwQ1R6+16t15G0uUIcENaSFQDesq1zR97zdt+UnuFrbDc6d/j1zkeHn
 onw3m9iF/f+cQ6qJ9hTLnuEYULJTYkg8H7U8yQyM/kKtThr79aAdOO57qXANZqFvqSOD
 w7t6go5tSCZXqFzngVLj/ktslnlHWPiQMfN47nO+NKWMrXwghMuLBVAhGUvjeElnP53y
 v5mFF/pf5qCnpzBHkSIR4LGItN+0mn6x3xZeFedfE/Dey8qXE6950s2tMVUdTyfUDEGm
 7YsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769698207; x=1770303007; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G102y0G+FgpeT9KmYnieigLXgmRkgBeE42iRMbIJv4E=;
 b=i4R2T7LaNkuojVBnl+LJLnV0zuD1r5n4omxLCex6GEHWChk3z5FlNnWJqtAydOde3G
 qC/OrOqCOIO4EkvjxJNjZiDhr+yynNP+UIIA7NQpNNl9HGfV9ADLttDNZ/LyN3ZZCYx+
 coEsGVDvnS2gh2SVk0l16ybmna/SQz23IMUyIUXltSlXSkTBNCXeVqJsp8iQHcStbtZe
 vkhdaRu3obTPbGxvRjci966EowehcMn6pSha+oYep1r4XvRp9fpiPyVe0N1om/TJzIa+
 MDx/wiZb7lSHf2A7BUqrDT75toWWD23/slyGskPnWCu+3opG4XAmBQzYCWRkvxgr632r
 2XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769698207; x=1770303007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G102y0G+FgpeT9KmYnieigLXgmRkgBeE42iRMbIJv4E=;
 b=Kuo0EJ5Y54Bu0nhXGy32ed7gEHvhEe+R/qpOn6qTLoQHxSQh6RDh2RYAJwlkauc6WY
 2TxMYUMWQ4xF7CSLJzO9JjAEnBM/uERFJECwWzwKAimcHaVi1Bh1+MUic6iwi+RyEs9M
 rozmubhevx1Hcm6I9HGvq2rsDG+HKVlejPxCaXz7Kv0Uxwqyw/DmgNV5MJU8yG1CTSZu
 QxfWsdNVNhm+ARIApapM0ZLV+3W/EwtVBi8Drj7qwIT9rX/ollnb2kM2TXNVA+MIYa+d
 O66Mv/b0jZTcx7fqwxtq2NBuy8aFXYRgfR/blRDfVwx2WMc7y+NPHyxCmkaSF/bla4+/
 sEsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCLjOwNQj/qQH6JMPwDHeKPffNHgJnrmd8uBtob7TtSHgNL7irswHzhdLpI5fyemW4YB6cUl810KeY@nongnu.org
X-Gm-Message-State: AOJu0YyyPHPUtp8/yRvodLf0VeC+gkzVtLdyOLS9vpwyg1Hbp7XbFTvP
 BR8W9UM19Cp8/9Swb6yBREo+bGEjsMDqut+cDV/BBxkOAf75UQEjLHBLPmfclGfTublezy4Pxqw
 31+YpY5stN+YnMpvJ7uDgBenWW2+0lFBJCq8RDSRXFetbTC817M0D
X-Gm-Gg: AZuq6aLIR1HiRuhxCqe9hb+ThOIIvjH9FtEPg/1kw2FnighRCm1FKiqTsuNKkXb23XX
 8EPNSYuYg2uTUASe3OZqsES9UWOspozLZhSOSy2T11rpAIlHQAPzByWl8zpfZmNlmcloQbsTPRh
 NRL2fug0HVvCN27QH5QQ19W0kxPIxSyh/RnZLQ0abtQIa+nbY4qjSROTv6ShvLAZp6Yc1pSw1+M
 QF3B7NO9xb1j284N9iHwpOPN51yc/2BDEBXTChRofNaD2BYAdtDXIR1Y5TOF4B0iZK9aQ==
X-Received: by 2002:a05:690c:e3c2:b0:794:3392:5d64 with SMTP id
 00721157ae682-7947ac18bdfmr80511487b3.44.1769698206639; Thu, 29 Jan 2026
 06:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20260105154119.59853-1-cohuck@redhat.com>
 <87tsw4sycv.fsf@redhat.com>
In-Reply-To: <87tsw4sycv.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 14:49:55 +0000
X-Gm-Features: AZwV_Qi7pH38OgAtongL_NVnLFm9xKs1dgjxGD34LPqz96eNK2scExh4GhFw5Wo
Message-ID: <CAFEAcA-rFx10-iaNmsbsW-HoWKLPJx0QQVgD36_aS5jfX6hGrg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm: move DCZID_EL0 to idregs array
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 29 Jan 2026 at 06:54, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, Jan 05 2026, Cornelia Huck <cohuck@redhat.com> wrote:
>
> > This is part of the ongoing effort to move all id registers to the idregs
> > array (so that we can work with an autogenerated list of registers.)
> >
> > Changes v2->v3:
> > - separate patch for adding the helpers
> > - put some rationale into the patch description
> >
> > Cornelia Huck (2):
> >   arm: add {get,set}_dczid_bs helpers
> >   arm: add DCZID_EL0 to idregs array



Applied to target-arm.next, thanks.

-- PMM

